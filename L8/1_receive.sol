// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8;

contract Sink {
    event Received(address, uint);
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    function selfdestructSC() public {
        selfdestruct(payable(msg.sender));
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}
