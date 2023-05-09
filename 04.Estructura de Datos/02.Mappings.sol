// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Mappings {

    //Mapping que nos permita eligir un numero
    mapping (address => uint) public elegirNumero; //relacionamos el address[KEY] con un uint[Value]

    function AgregarNumero(uint _numero) public {//Asigna un numero al wallet que ejecuta la funcion
        elegirNumero[msg.sender] = _numero;
    }

    function consultarNumero() public view returns(uint) { //Deveuelve el numero de acuerdo al Numero de Wallet
        return elegirNumero[msg.sender];
    }


    //Mapping que relaciona el nombre de una persona con la cantidad de dinero
    mapping (string => uint) public cantidadDinero;

    function Dinero(string memory _nombre, uint _cantidad) public {
        cantidadDinero[_nombre] = _cantidad;
    }

    function consultarDinero(string memory _nombre) public view returns(uint){
        return cantidadDinero[_nombre];
    }


    //Mapping con struct

    struct Persona {
        string nombre;
        uint edad;
    }

    mapping (uint => Persona) personas; //Este ejemplo relaciona un numero de dni(uint) con una Persona(struct)

    function dni_persona(uint _numero_dni, string memory _nombre, uint _edad) public{
        personas[_numero_dni] = Persona(_nombre, _edad);
    }

    function visuzalizarPersona(uint _dni) public view returns(Persona memory){
        return personas[_dni];
    }
}