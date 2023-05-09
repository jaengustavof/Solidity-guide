//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.7.0;

contract ImplementationContract {
    event testEvent(address txOrigin, address msgSenderAddress, address _from, uint msgValue);
    function doSomething() public payable {
        emit testEvent(tx.origin, msg.sender, address(this), msg.value);
    }

}

library ImplementationLib {
    event testEvent(address txOrigin, address msgSenderAddress, address _from, uint msgValue);
    function doSomething() public {
        emit testEvent(tx.origin, msg.sender, address(this), msg.value);
    }
    function getLibAddress() public view returns(address){
        return address(this);
    }
    function getLibBalance() public view returns(uint){
        return address(this).balance;
    }
}
contract CallingContract {
   address public implementationContractAddress = address(new ImplementationContract());

   function callImplementationContract() payable public {
       require(address(this).balance > 0.1 ether, "not enough balance in SC");
        (bool success, bytes memory returnData) = implementationContractAddress.call{value: 0.1 ether}(abi.encodeWithSignature("doSomething()"));
        assert(success);
        //check that the event address is the implementationContractAddress's
   }
   
   function delegateCallToImplementationContract() payable public {
        require(address(this).balance > 0.1 ether, "not enough balance in SC");
      (bool success, bytes memory returnData) =  implementationContractAddress.delegatecall(abi.encodeWithSignature("doSomething()"));
       assert(success);
       //check that the event address is this SC's
   }
    
   
    function callImplementationLib() payable public {
       ImplementationLib.doSomething();
       //check that the event address is this SC's
   }
   function getSCBalance() public view returns(uint){
        return address(this).balance;
    }

    function getSCBalance(address scAddress) public view returns(uint) {
        return scAddress.balance;
    }
}