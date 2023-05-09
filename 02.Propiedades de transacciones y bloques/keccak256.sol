// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;
//pragma experimental ABIEncoderV2;


contract hash {

    //computo del hash de un string
    function calcularHash(string memory _cadena) public pure returns(bytes32){ //devuelve valor hash
        return keccak256(abi.encodePacked(_cadena));
    }

    //computo del hash de un string, un entero y una direccion
    function calcularHash2(string memory _cadena, uint _k, address _direccion) public pure returns(bytes32){ //devuelve valor hash
        return keccak256(abi.encodePacked(_cadena, _k, _direccion));
    }

    //computo del hash de un string, un entero, una direccion, un string y un entero que no estan dentro de una variable.
    function calcularHash3(string memory _cadena, uint _k, address _direccion) public pure returns(bytes32){ //devuelve valor hash
        return keccak256(abi.encodePacked(_cadena, _k, _direccion, "hola", uint(2)));
    }
}