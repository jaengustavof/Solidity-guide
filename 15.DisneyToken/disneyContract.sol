// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 < 0.7.0;
pragma experimental ABIEncoderV2;

import "./ERC20.sol";

contract Disney {

    // ---------------------- DECLARACIONES INICIALES ---------------------- // 

    // Instancia del contrato de token
    ERC20Basic private token;

    //Direccion Owner
    address payable public owner; //payable es una direccion para hacer pagos

    // Constructor
    constructor () public {

        //Instanciar el numero de tokens inicial
        token = new ERC20Basic(10000);

        //Propietario del contrato
        owner = msg.sender;

    }

    //Estructura de datos para almacenar a los clientes de Disney
    struct cliente {
        uint tokens_comprados;
        string [] atracciones_disfrutadas;
    }

    //Mapping para el registro de clientes
    mapping (address => cliente) public Clientes;



    // ---------------------- GESTION DE TOKENS ---------------------- // 

    // Funcion para establecer el precio de un token
    function precioTokens(uint _numTokens) internal pure returns(uint) {
        //Conversion de Tokens a Ethers: 1 Token = 1 ETH
        return _numTokens * (1 ether);
    }

    //Balance de tokens del contrato disney
    function balanceOf() public view returns(uint){
        return token.balanceOf(address(this)); //balanceOf - ERC20.sol. address(this) la direccion de este contrato
    }

    // Modificador para controlar las funciones ejecutables por el Owner
    modifier OwnerOnly(address _direccion){
        require(_direccion == owner, "No tienes permisos para ejecutar esta funcion");
        _;
    }

    // Funcion para comprar Tokens
    function compraTokens(uint _numTokens) public payable {
        // Establecer el precio de los tokens
        uint coste = precioTokens(_numTokens);
        // Se evalua el dinero que el cliente paga por los tokens
        require(msg.value >= coste, "Compra menos tokens o paga con mas ETH");
        // Diferencia de lo que el cliente paga
        uint returnValue = msg.value - coste; //se devuelve la diferencia entre el lo que est'a pagando y el coste de la compra de los tokens
        // Disney devuelve el vuelto
        msg.sender.transfer(returnValue); // se devuelve el returnValue al msg.sender. A la persona que esta comprando Tokens
        // Obtencion del numero de tokens disponibles
        uint balance = balanceOf();
        require(_numTokens <= balance, "Compra un numero menor de Tokens"); //el numero de tokens comprados debe ser menor o igual a la cantidad todal e los tokens disponibles
        // Se transfiere el numero de tokens al cliente
        token.transfer(msg.sender, _numTokens); //funcion ERC20.sol
        // Registro de tokens comprados
        Clientes[msg.sender].tokens_comprados += _numTokens;
    }

    // Visualiar el numero de tokens de un cliente
    function misTokens() public view returns(uint){
        return token.balanceOf(msg.sender); // balanceOf - ERC20.sol
    }

    // Funcion para generar mas tokens
    function generaTokens(uint _numTokens) public OwnerOnly(msg.sender) {
        token.increaseTotalSupply(_numTokens); // increaseTotalSupply - ERC20;
    } 


    // ---------------------- GESTION DE DISNEY ---------------------- //

    // Eventos
    event disfruta_atraccion(string, uint, address);
    event nueva_atraccion(string, uint);
    event baja_atraccion(string);

    event disfruta_comida(string, uint, address);
    event nueva_comida(string, uint);
    event baja_comida(string);


    // Estructura de datos de la atraccion
    struct atraccion {
        string nombre;
        uint precio;
        bool estado_atraccion;
    }

    // Estructura de datos de la comida
    struct comida {
        string nombre;
        uint precio;
        bool estado_comida;
    }


    // Mapping para relacionar un nombre de una atraccion con una estructura de datos de la atraccion
    mapping (string => atraccion) public MappingAtracciones;

    // Mapping que relaciona el nombre de la comida con la estructura
    mapping (string =>comida) public MappingComidas;

    // Array para almacenar el nombre de las atracciones
    string [] atracciones;

    // Array para almacenar el nombre de las atracciones
    string [] comidas;

    // Mapping para relacionar una identdad de un cliente con su historial de atracciones
    mapping (address => string []) HistorialAtracciones;

    //Mapping para relacioar al cliente y las comidas consumidas
    mapping  (address => string []) HistorialComidas;

    // Star Wars -> 2 tokens
    // Toy Story -> 5 tokens
    // Piratas del Caribe -> 8 tokens
    
    //Crear nueva atraccion para disney. Solo es Ejecutable por Disney.
    function nuevaAtraccion(string memory _nombreAtraccion, uint _precio) public OwnerOnly(msg.sender) {
        // Crear una atraccion
        MappingAtracciones[_nombreAtraccion] = atraccion(_nombreAtraccion, _precio, true);

        // Almacenamiento del nombre de la atraccion en el array
        atracciones.push(_nombreAtraccion);

        // Emision del evento para la nueva atraccion
        emit nueva_atraccion(_nombreAtraccion, _precio);
    }

    function nuevaComida(string memory _nombreComida, uint _precioComida) public OwnerOnly(msg.sender) {
        MappingComidas[_nombreComida] = comida(_nombreComida, _precioComida, true);

        comidas.push(_nombreComida);

        emit nueva_comida(_nombreComida, _precioComida);
    }

    //Dar de baja las atracciones de disney
    function bajaAtraccion(string memory _nombreAtraccion) public OwnerOnly(msg.sender) {
        // Cambiar el estado de la atraccion
        MappingAtracciones[_nombreAtraccion].estado_atraccion = false;

        //Emitimos el evento
        emit baja_atraccion(_nombreAtraccion);
    }

    function bajaComida(string memory _nombreComida) public OwnerOnly(msg.sender) {
        MappingComidas[_nombreComida].estado_comida = false;
        emit baja_comida(_nombreComida);
    }

    //Visualizar las atracciones que esten disponibles
    function visualizarAtracciones() public view returns(string[] memory){
        return atracciones;
    }

    function visualizarComidas() public view returns(string [] memory){
        return comidas;
    }

    //Funcion para subirse a una atracion de disney y pagar en tokens
    function subirseAtraccion(string memory _nombreAtraccion) public {
        //Precio de la atraccion  (en tokens)
        uint tokens_atraccion = MappingAtracciones[_nombreAtraccion].precio;

        //Verifica el estado de la atraccioon
        require(MappingAtracciones[_nombreAtraccion].estado_atraccion == true, "La atraccion no esta disponible en estos momentos");

        //verificar el numero de tokens que tiene el cliente
        require(tokens_atraccion <= misTokens(), "No tiene tokens suficientes");

        /*
        El cliente paga la atraccion en tokens.
        -Ha sido necesario crear una funcion en ERC20.sol con el nombre transferDisney
        Debido a que si usamos transfer o transfer from, estas tomaban directamente la direccion del contrato en lugar de la direccion del cliente
        */

        /*
        *msg.sender - quien ejecuta la funcion
        *address(this) - la direccion del contrato
        *tokens_atraccion - la cantidad
        */
        token.transferDisney(msg.sender, address(this), tokens_atraccion); 

        //Almacenamiento de atracciones del cliente
        HistorialAtracciones[msg.sender].push(_nombreAtraccion);

        //Emision de evento para disfrutar de la atraccion
        emit disfruta_atraccion(_nombreAtraccion, tokens_atraccion, msg.sender);
    }

    //Funcion para consumir comida
    function disfrutarComida(string memory _nombreComida) public {
        //Obtenemos el precio de la comida
        uint tokens_comida = MappingComidas[_nombreComida].precio;

        //verificar el estado de la comida
        require(MappingComidas[_nombreComida].estado_comida == true, "Comida no disponible");

        //Verificar el numero de tokens que tiene el cliente
        uint tokens_cliente = misTokens();
        require(tokens_cliente >= tokens_comida, "No tiene suficientes tokens");

        //Pagar tokens a disney
        token.transferDisney(msg.sender, address(this), tokens_comida);

        //Historial de comidas
        HistorialComidas[msg.sender].push(_nombreComida);

        emit disfruta_comida(_nombreComida, tokens_comida, msg.sender);
    }

    //Visualizar el historial completo de atracciones de un cliente
    function historial() public view returns(string [] memory){
        return HistorialAtracciones[msg.sender];
    }

    //visualizar el historial completo de comidas
    function historialComidas() public view returns(string [] memory) {
        return HistorialComidas[msg.sender];
    }

    // Devolucion de tokens
    function devolverTokens(uint _numTokens) public payable {
        //Numero de tokens es positiovo
        require(_numTokens >0, "Necesitas devolver una cantidad positiva de tokens");

        //Usuario debe tener el numero de tokens que desea devolver
        require(_numTokens <= misTokens(), "No tienes los tokens que deseas devolver");

        //El cliente devuelve los tokens al contrato 
        token.transferDisney(msg.sender, address(this), _numTokens); 

        //Devolucion de los ETH al cliente
        msg.sender.transfer(precioTokens(_numTokens));
    }


}