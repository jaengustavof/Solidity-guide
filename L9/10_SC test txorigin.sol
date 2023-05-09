// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;



// THIS CONTRACT CONTAINS A BUG - DO NOT USE
contract CA {
    address public owner;
    address public lastTxOrigin;
    address public lastSender;

    constructor()  payable {
        owner = msg.sender;
    }
	
    function testCall(address payable dest, uint amount) public {
        CB(dest).test();
    }

    function llamadaRetorno() public {
        lastTxOrigin = tx.origin;
        lastSender = msg.sender;
    }

}

contract CB {
    address owner;
    constructor()  {
        owner = msg.sender;
    }

    function test() external {
        CA(msg.sender).llamadaRetorno();
    }
}