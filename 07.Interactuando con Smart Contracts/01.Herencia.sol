// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Banco {

    //Definimos tipo de dato complejo
    struct cliente {
        string nombre;
        address direccion;
        uint dinero;
    }

    //mapping nombre cliente con el tipo de dato complejo (struct cliente).
    mapping (string => cliente) clientes;

    //Funcion que nos permita dar de alta un nuevo cliente
    function nuevoCliente(string memory _nombre) public {
        clientes[_nombre] = cliente(_nombre, msg.sender, 0);
    }

}

contract Cliente is Banco {

    //Funcion que permite darse de alta
    function altaCliente(string memory _nombre) public {
        nuevoCliente(_nombre);
    }

    //Funcion que permite ingresar dinero
    function ingresarDinero(string memory _nombre, uint _cantidad) public {
        clientes[_nombre].dinero = clientes[_nombre].dinero + _cantidad;
    }

    //Funcion para retirar dinero
    function retirarDinero(string memory _nombre, uint _cantidad) public returns(bool){
        bool flag = true;
        
        if(clientes[_nombre].dinero >= _cantidad){
            clientes[_nombre].dinero = clientes[_nombre].dinero - _cantidad;
        }else {
            flag = false;
        }

        return flag;

    }

    //Funcion para consultar la cantidad de dinero
    function consultarDinero(string memory _nombre) public view returns(uint){
        return clientes[_nombre].dinero;
    }
}