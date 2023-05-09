// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Owned {
    address public administrador;

    constructor() {
        administrador = msg.sender;
    }

    modifier onlyAdmin {
        require(msg.sender == administrador);
        _;
    }
}