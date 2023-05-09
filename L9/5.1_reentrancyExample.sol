// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

/*
Any interaction from a contract (A) with another contract (B) and any transfer of Ether hands over control to that contract (B). 
This makes it possible for B to call back into A before this interaction is completed. To give an example, the following code contains
 a bug (it is just a snippet and not a complete contract)

*/

// THIS CONTRACT CONTAINS A BUG - DO NOT USE
contract Fund {
    /// @dev Mapping of ether shares of the contract.
    mapping(address => uint) shares;
    /// Withdraw your share.
    function withdraw() public {
        if (payable(msg.sender).send(shares[msg.sender]))
            shares[msg.sender] = 0;
    }
}

contract MaliciusSC {
    function recieve() external {
        Fund(msg.sender).withdraw();   //when receiving the funds would call again for more
    }
}

/*
The problem is not too serious here because of the limited gas as part of send, but it still exposes a weakness: 
Ether transfer can always include code execution, so the recipient could be a contract that calls back into withdraw. 
This would let it get multiple refunds and basically retrieve all the Ether in the contract. 


In particular, the following contract will allow an attacker to refund multiple times as it uses call which forwards all remaining gas by default:
*/
// THIS CONTRACT CONTAINS A BUG - DO NOT USE
contract Fund2 {
    /// @dev Mapping of ether shares of the contract.
    mapping(address => uint) shares;
    /// Withdraw your share.
    function withdraw() public {
        (bool success,) = msg.sender.call{value: shares[msg.sender]}("");   //addr.transfer(x), only that it forwards all remaining gas and opens up the ability for the recipient to perform more expensive actions
        if (success)
            shares[msg.sender] = 0;
    }
}


/*
To avoid reentrancy, you can use the Checks-Effects-Interactions pattern as demonstrated below:
*/
contract Fund3 {
    /// @dev Mapping of ether shares of the contract.
    mapping(address => uint) shares;
    /// Withdraw your share.
    function withdraw() public {
        uint share = shares[msg.sender];
        shares[msg.sender] = 0;
        payable(msg.sender).transfer(share);
    }
}

/*
This is a common foolproof way to prevent reentrancy attacks, where an externally called malicious contract is able to 
double-spend an allowance, double-withdraw a balance, among other things, by using logic that calls back into the original 
contract before it has finalized its transaction.

Note that reentrancy is not only an effect of Ether transfer but of any function call on another contract.
 Furthermore, you also have to take multi-contract situations into account. A called contract could modify the state of
  another contract you depend on.
*/