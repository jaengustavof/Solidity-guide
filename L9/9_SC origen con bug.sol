// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

// THIS CONTRACT CONTAINS A BUG - DO NOT USE
contract MYBancoPersonal {
    address public owner; //Soy yo
    address public lastSender;
    address public lastTxOrigin;


    constructor()  payable {
        owner = msg.sender;
    }
	receive() external payable{}

    function transferTo(address payable dest, uint amount) public {
        require(tx.origin == owner, "only owner");
        require( address(this).balance >= amount, "not enough balance for transfer");
        lastTxOrigin= tx.origin;
        lastSender = msg.sender;
        dest.transfer(amount);
    }

    

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}


