// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Arrays {

    //Array de enteros de longitud fija 5
    uint[5] public array_de_enteros = [1,2,3]; //position 3 y 4 no hay asignacion

    //Array de enteros de 32bits de longitud fija 7
    uint32[17] array_enteros_32bits;

    //Array de strings de longitud fija 15
    string[15] array_de_strings;

    //Array dinamico de enteros
    uint[] public array_dinamico_enteros;



    struct Persona{
        string nombre;
        uint edad;
    }

    //Array dinamico de tipo Persona
    Persona[] public array_dinamico_personas;

/*
    function modificar_array(string memory _nombre, uint _edad) public {
        //array_dinamico_enteros.push(_numero);
        array_dinamico_personas.push(Persona(_nombre, _edad));
    }
*/
    function modificar_array() public {
        array_de_enteros[3] = 12;
    }

    uint public test = array_de_enteros[2];
}