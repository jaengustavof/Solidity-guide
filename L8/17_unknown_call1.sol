//SPDX-License-Identifier:UNLICENSED

pragma solidity ^0.8.11;

//primero publicar contrato MEssagebox
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

//Segundo publicar contrato testCall y testear
contract testCall {
   
    
    function setMessage(address scHelloWorld, string memory _new_message) public returns (bool) {
        
       
        bytes memory payload = abi.encodeWithSignature("setMessage(string)", _new_message);
        (bool success, bytes memory returnData) = address(scHelloWorld).call(payload);
		assert (success);
        return (success);
        
    }
    
    function getMessage(address scHelloWorld) public view returns (bool, string memory) {  
        bytes memory payload = abi.encodeWithSignature("getMessage()");
        (bool success, bytes memory returnData) = address(scHelloWorld).staticcall(payload);    //call(payload);
        string memory message  = abi.decode(returnData, (string));
        return (success, message);
    }
    
}