// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Messagebox {
    string public message;
    
    constructor ()  {
        message = "HELLO WORLD!";
    }
    
    function setMessage(string memory _new_message) public {
        
         message = _new_message;
        
    }
    
    function getMessage() public view returns (string memory) {
        return message;
    }
    
}
interface ITest {
    function getName() external returns (string memory);
    function getCodeMessage() external pure  returns (bytes memory);
    function minMaxValues() external pure returns (int256, int256);
} 

contract TypeTest is  ITest {
   bytes4 public constant IID_ITEST = type(ITest).interfaceId;   

   function getName() public pure returns(string memory) {
       return type(TypeTest).name;
   }
   function getCodeMessage() public pure  returns (bytes memory) {
       return type(Messagebox).creationCode;
   }
    function minMaxValues() public pure returns (int256, int256) {
        return (type(int).min, type(int).max);
    }
  
}