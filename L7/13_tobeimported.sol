// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Contract1  {
   uint valor = 1;

    function getName() internal pure returns(string memory) {
         return type(Contract1).name;
    }

}

contract Contract2  {
  uint  valor = 2;

    function getName() internal pure returns(string memory) {
         return type(Contract2).name;
    }

}

contract Contract3  {
   uint valor = 3;

    function getName() internal pure returns(string memory) {
        return type(Contract3).name;
    }
}