// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import * as cimp  from "./13_tobeimported.sol";

contract AlphaContract is cimp.Contract2 {

    function getValues() public view returns(uint, string memory) {
        return (valor,getName());
    }
}
