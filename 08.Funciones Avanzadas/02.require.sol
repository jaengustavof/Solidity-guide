// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Require {

    //Funcion que verifique la contrasena
    function password(string memory _password) public pure returns(string memory) {
        require(keccak256(abi.encodePacked(_password)) == keccak256(abi.encodePacked("12345")), "Contrasena incorrecta");
        return "Contrasena Correcta";
    }


    //Funcion que nos permita pagar
    uint public cartera = 0;
    uint ultimaLlamada =0; //ultima vez que se llamo a la funcion

    function pagar(uint _cantidad) public returns(uint){

        require(block.timestamp > ultimaLlamada + 5 seconds, "Debe esperar 5 segundos");
        ultimaLlamada = block.timestamp;
        cartera = cartera + _cantidad;

        return cartera;

    }



    //Funcion con una lista

    string [] nombres;

    function nuevoNombre(string memory _nombre) public {
        for(uint i = 0; i < nombres.length; i++){
            require(keccak256(abi.encodePacked(_nombre)) !=keccak256(abi.encodePacked(nombres[i])), "Ya esta en la lista");
        }

        nombres.push(_nombre);
    }

}