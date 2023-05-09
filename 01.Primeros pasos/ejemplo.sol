// Esto es un comentario
// SPDX-License-Identifier: MIT
// Version
pragma solidity >=0.4.0 <0.7.0;


contract FirstContract {

    address owner; //variable de tipo direccion

    constructor() public {
        owner = msg.sender;

    }

}