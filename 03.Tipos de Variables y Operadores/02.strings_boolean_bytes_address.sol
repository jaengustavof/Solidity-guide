// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract mas_variables {

    //Variables String
    string mi_primer_string;
    string public saludo = "Hola, mundo.";
    string public string_vacio = "";

    //Variables booleanas
    bool mi_primer_booleano;
    bool public flag_true = true;
    bool public flag_false = false;

    //Variables byte
    bytes32 mi_primer_bytes;
    bytes4 segundo_bytes;
    string public nombre = "Gustavo";
    bytes32 public hash = keccak256(abi.encodePacked(nombre));
    bytes4 public identificador;

    function ejemploBytes4 () public{
        identificador = msg.sig;
    }

    //Variables address
    address mi_primera_direccion;
    address public direccion_local_1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public direccion_local_2 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
}