// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract Test {
    string public text;
    
    function concatString(string memory s1, string memory s2) public {
        //text = string(abi.encodePacked(s1,s2));   //Anterior forma de concatenar strings
        text = string.concat(s1,s2);
    }
    
    function compareString(string memory text2) public view returns (bool)
    {
        if(keccak256(abi.encodePacked(text)) == keccak256(abi.encodePacked(text2)))
            return true;
        else 
            return false;
    }
   
   function getStringLength(string memory s) public pure returns(uint)
   {
       return bytes(s).length;
   }

    
}