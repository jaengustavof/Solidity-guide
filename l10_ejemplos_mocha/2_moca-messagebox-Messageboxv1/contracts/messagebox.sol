// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Messagebox {
    string public message;
    address creator;
    
    constructor (string memory _message)  {
        message = _message;
        creator = msg.sender;
    }
    
    function setMessage(string memory _new_message) public {
        require(msg.sender == creator, "only admin can change message");
        message = _new_message;
    }
    
    function getMessage() public view returns (string memory) {
        return message;
    }
    
}
