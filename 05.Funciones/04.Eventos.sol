// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Eventos {
    
    //Declaramos los eventos a utiilizar

    event nombre_evento1 (string _nombrePersona);
    event nombre_evento2 (string _nombrePersona, uint _edad);
    event nombre_evento3 (string, uint, address, bytes32);
    event abortar_mision();
    
    function EmitirEvento1(string memory _nombrePersona)public {
        emit nombre_evento1(_nombrePersona);
    }

    function EmitirEvento2(string memory _nombrePersona, uint _edad) public {
        emit nombre_evento2(_nombrePersona, _edad);
    }

    function EmitirEvento3(string memory _nombre, uint _edad)public {
        bytes32 hash_id = keccak256(abi.encodePacked(_nombre, _edad, msg.sender));
        emit nombre_evento3(_nombre,_edad ,msg.sender,hash_id );
    }

    function abortarMision() public{
        emit abortar_mision();
    }


}