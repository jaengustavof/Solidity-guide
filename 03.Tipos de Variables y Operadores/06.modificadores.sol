// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
pragma experimental ABIEncoderV2;

contract public_private_internal {

    //Modificador public
    uint public mi_entero = 45;
    string public mi_string = "Test String";
    address public owner;

    constructor () {
        owner = msg.sender;
    }


    //MOdificador private
    uint private mi_entero_privado = 10;
    bool private flag = true;

    function test(uint _k) public {
        mi_entero_privado = _k;
    }


    //Modificador internal
    bytes32 internal hash = keccak256(abi.encodePacked(("Hola")));
    address internal direccion = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    

}
