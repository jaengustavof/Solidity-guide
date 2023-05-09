//SPDX-License-Identifier:UNLICENSED

pragma solidity ^0.8.7;

contract Contract1 {
    
    string public iExist;
    string public message;

   constructor()  payable {  //To-do: create with 1eh
        iExist= "Yes";
    }

    function changeMessage(string memory newmessage) public payable{
        require(keccak256(abi.encodePacked(newmessage))!=keccak256(abi.encodePacked("Tonto quien lo lea")),"Messagebox: I am ofended");
        message = newmessage;
    }
    
    function doSomething() public {
        
         selfdestruct(payable(msg.sender));
        
    }
    receive() external payable {

    }
    function  getBalance() public view returns(uint256){
        return address(this).balance;
    }
    function  getSCBalance(address scaddress) public view returns(uint256){
        return scaddress.balance;
    }
    
}
 


contract testingCalls {
   
   string public iExist;

   constructor()  payable {
        iExist= "Yes";  //todo-create with one ether
    }
    
    function testCall(address scAddress) public returns (bool, bytes memory) {
        
       
        bytes memory payload = abi.encodeWithSignature("doSomething()");
        (bool success, bytes memory returnData) = address(scAddress).call(payload);
		assert (success);
        return (success, returnData);
         /* Question: Who recieves the balance? how much? */
        
    }
    
	/*
    function testDelegatecall(address scAddress) public returns (bool, bytes memory) {
        
       
        bytes memory payload = abi.encodeWithSignature("doSomething()");
        (bool success, bytes memory returnData) = address(scAddress).delegatecall(payload);
		assert (success);
        return (success, returnData);   
        
    } 
    */

    function changeMessageCall(address scAddress, string memory message) public  payable returns (bool, bytes memory) {
        
       
        bytes memory payload = abi.encodeWithSignature("changeMessage(string)",message );
        (bool success, bytes memory returnData) = address(scAddress).call{value:msg.value}(payload);
		assert (success);
        return (success, returnData);
         /* Question: Who recieves the balance? how much? */
        
    }

    receive() external payable {
        
    }
    function  getBalance() public view returns(uint256){
        return address(this).balance;
    }
    function checkBalance(address checkaddress) public view returns(uint256){
        return checkaddress.balance;
    }
    
}