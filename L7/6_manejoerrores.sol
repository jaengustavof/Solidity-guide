// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract VendingMachine {
    address owner;
    error Unauthorized();

    constructor() payable {
        owner = msg.sender;
    }

    function buy(uint amount) public payable {
        if (amount > msg.value)
            revert("Not enough Ether provided.");
       
        // Perform the purchase.
    }
     function buy2(uint amount) public payable {
        require(
            amount <= msg.value,
            "Buy2:Not enough Ether provided."
        );
        // Perform the purchase.
    }

   function recieve() external{

    }
    
    function withdraw() public {
        if (msg.sender != owner)
            revert Unauthorized();

        payable(msg.sender).transfer(address(this).balance);
        
        assert(address(this).balance == 0);
    }
}

/* 
View example in public blockexplorer
https://sepolia.etherscan.io/address/0x53388b5f6d4a5314869b4532fef648500b1a9bad
*/