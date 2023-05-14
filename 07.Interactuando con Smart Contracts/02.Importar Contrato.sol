// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

//Este contrato se importara en el archivo 02.Cliente

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

contract Banco2 {

}

contract Banco3 {
    
}