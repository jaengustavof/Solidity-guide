// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract CompararStrings {

    function comparar(string memory _j, string memory _y) public  pure returns(bool){
        bytes32 primero = keccak256(abi.encodePacked(_j)); 
        bytes32 segundo = keccak256(abi.encodePacked(_y)); 
        if(primero == segundo){
            return true;
        }else{
            return false;
        }
    }
}