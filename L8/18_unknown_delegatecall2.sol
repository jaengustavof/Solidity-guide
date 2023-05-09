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
}
contract CallingContract {
   address implementationContractAddress = address(new ImplementationContract());
   
   function callImplementationContract() payable public {
       implementationContractAddress.call{value: 0.5 ether}(abi.encodeWithSignature("doSomething()"));
   }
   
   function delegateCallToImplementationContract() payable public {
       implementationContractAddress.delegatecall(abi.encodeWithSignature("doSomething()"));
   }
    
    function callImplementationLib() payable public {
       ImplementationLib.doSomething();
   }
}