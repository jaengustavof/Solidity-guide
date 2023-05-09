// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Owned {
    address payable public admin;

    constructor() {
        admin = payable(msg.sender) ;
    }

    modifier onlyAdmin() {
        require(admin == msg.sender, "Only Admin is authorized");
        _;
    }
}

contract Contract is Owned {
    
    string[] private messages; 
    uint public lastMsgUnix;
    string private noText = "tonto quien lo lea";

    event deleteLog(
        address indexed _from,
        uint _time,
        string _action, 
        string _msg
    );

    function addMessage(string memory _new_message) onlyAdmin public payable {
        require(keccak256(abi.encodePacked(_new_message)) != keccak256(abi.encodePacked(noText)), "This message is not allowed");
        require(messages.length == 0 || msg.value == 0.001 ether, "You must pay 0.001 ether to add a new message.");
        messages.push(_new_message);
        lastMsgUnix = block.timestamp;
    }

    function getMessage(uint index) onlyAdmin public view returns(string memory) {
        return messages[index];
    }

    function getAllMessages() onlyAdmin public view returns (string[] memory) {
        return messages;
    }

    function deleteMessage(uint index) onlyAdmin public {
        if(index < messages.length){
            emit deleteLog(msg.sender, block.timestamp, "Message Deleted", messages[index]);
            for(uint i = index; i < messages.length - 1; i++){
                messages[i] = messages[i+1];
            }
            messages.pop();
        }
        
    }

    function destroySmartContract() onlyAdmin public {
        selfdestruct(admin);
    }

}

