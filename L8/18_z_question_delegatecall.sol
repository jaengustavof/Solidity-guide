//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.7;

///  RECORDATORIO - CREAR CLASES CON BALANCE POSITIVO 


contract Contract1 {
    
    string public iExist;

   constructor()  payable {  //To-do: create with 1eh
        iExist= "Yes";
    }
    
    function doSomething() public {
        
         selfdestruct(payable(msg.sender));
        
    }
    receive() external payable {

    }
    function  getBalance() public view returns(uint256){
        return address(this).balance;
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
    
     function testDelegatecall(address scAddress) public returns (bool, bytes memory) {
        
       
        bytes memory payload = abi.encodeWithSignature("doSomething()");
        (bool success, bytes memory returnData) = address(scAddress).delegatecall(payload);
		assert (success);
        return (success, returnData);   
        /* Question: Who recieves the balance?  how much?*/
        
    }
    receive() external payable {
        
    }
    function  getBalance() public view returns(uint256){
        return address(this).balance;
    }
    
}