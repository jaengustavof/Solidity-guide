// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Modifier {

    //Ejemplo de modifier que comprueba si es el admin o propietario del contrato

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier ownerOnly() {
        require(msg.sender == owner, "No tienes permisos para ejecutar la funcion");
        _;
    }


    function ejemplo1 () public ownerOnly() {
        //codigo de la funcion para el admin. No podra ser utilizado por otro
    }


    //Funcion que solo puedan ejecutar los clientes
    struct cliente{
        address direccion;
        string nombre;
    }

    mapping (string => address) clientes; //relacionamos el nombre del cliente con la direccion

    function altaCliente(string memory _nombre) public {
        clientes[_nombre] = msg.sender;
    }

    modifier clientsOnly(string memory _nombre) {
        require(clientes[_nombre] == msg.sender, "No esta dado de alta como cliente");
        _;
    }

    function ejemplo2(string memory _nombre) public clientsOnly(_nombre){
        //logica de la funcion para los clientes
    }


    //Ejemplo de condiccion

    modifier mayorDeEdad(uint _edadMinima, uint _edadUsuario){
        require(_edadUsuario >= _edadMinima, "No tiene edad suficiente");
        _;
    }

    function confucir(uint _edad) public mayorDeEdad(18, _edad){
        //Respuesta si se cumplo o no
    }

}

