// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Contract {
    
    string private message;
    string[] private messages; 
    uint public lastMsgUnix;
    address private admin;

    constructor() {
        admin = msg.sender;
    }

    function addMessage(string memory _new_message) public payable {
        require(messages.length == 0 || msg.value == 0.001 ether, "You must pay 0.001 ether to add a new message.");
        messages.push(_new_message);
        lastMsgUnix = block.timestamp;
    }

    function getMessage(uint index) public view returns(string memory) {
        return messages[index];
    }


    function getAllMessages() public view returns (string[] memory) {
        return messages;
    }

    function deleteMessage(uint index) public {
        require(msg.sender == admin, "You are not authorized to delete any message");
        if(index < messages.length){
            for(uint i = index; i < messages.length - 1; i++){
                messages[i] = messages[i+1];
            }
            messages.pop();
        }
    }

}

