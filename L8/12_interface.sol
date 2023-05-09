// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

interface ITest {
    function getName() external returns (string memory);
    function getCodeMessage() external pure  returns (string memory);
    function minMaxValues() external pure returns (int256, int256);
} 

contract TypeTest is  ITest {
   bytes4 public constant IID_ITEST = type(ITest).interfaceId;   

   function getName() public pure returns(string memory) {
       return type(TypeTest).name;
   }
   function getCodeMessage() public pure  returns (string memory) {
       return "hello world";
   }
    function minMaxValues() public pure returns (int256, int256) {
        return (type(int).min, type(int).max);
    }
}