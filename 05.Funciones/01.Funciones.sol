// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Funciones {

    //Anadir dentro de un array de direcciones la direccion de la persona que llame a la funcion

    address[] public direcciones;

    function addAddress() public {
        direcciones.push(msg.sender);
    }


    //Computar el hash de los datos proporcionados como parametro
    bytes32 public hash;

    function hashValue(string memory _datos) public {
        hash = keccak256(abi.encodePacked(_datos));
    }


    //Declaramos un tipo de dato complejo (comida)
    struct comida {
        string name;
        string ingredientes;
    }
    //Vamos a crear un tipo de dato complejo 
    comida public hamburguesa;

    function hamburguesas(string memory _ingredientes) public {
        hamburguesa = comida("Hamburguesa", _ingredientes);
    }


    //estructura alumno
    struct alumno {
        string name;
        address walletAddress;
        uint age;
    }

    bytes32 public hash_id_alumno;

    //funcion privada
    function hashIdAlumno (string memory _name, address _address, uint _age) private {
        hash_id_alumno = keccak256(abi.encodePacked(_name, _address, _age));
    }

    //funcion publica - guarda dentro de una lista a los alumnos

    alumno[] public lista;
    mapping(string => bytes32) public alumnos; //Este mapping relaciona el nombre de los alumnos con su hash

    function addAlumno(string memory _name, uint _age) public {
        lista.push(alumno(_name, msg.sender, _age));
        hashIdAlumno(_name, msg.sender, _age); // llama a la funcion privada
        alumnos[_name] = hash_id_alumno;
    }

   
}