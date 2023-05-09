// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.1;

contract Messagebox {
    string public message;
    
    constructor ()  {
        message = "HELLO WORLD!";
    }
    
    function setMessage(string memory _new_message) public returns (string memory){
         //require(keccak256(abi.encodePacked(_new_message)) == keccak256(abi.encodePacked("Tonto quien lo lea")), "Messagebox: I am ofended");
         require(keccak256(abi.encodePacked(_new_message))!=keccak256(abi.encodePacked("Tonto quien lo lea")),"Messagebox: I am ofended");
         
         message = _new_message;
         return _new_message;   
    }
    
    function getMessage() public view returns (string memory) {
        return message;
    }
    
}


contract Tester {
    Messagebox MB;
    uint public errorCount;
    string public lastmessageupdated;
    string public lastMessageSent;
    string public lastErrorMessage;
    event Log(string message);

    constructor () {
        MB  = new Messagebox();
    }

    function newmessage(string memory _newmessage) public returns (string memory newMessage, bool success) {

        try MB.setMessage(_newmessage) returns (string memory m) {
            lastmessageupdated = m;
            return (m, true);
        } catch Error(string memory reason) {
            // This is executed in case
            // revert was called inside getData
            // and a reason string was provided.
            errorCount++;
            lastErrorMessage = _newmessage;
            emit Log(reason);
            return ("No update", false);
        } catch Panic(uint /*errorCode*/) {
            // This is executed in case of a panic,
            // i.e. a serious error like division by zero
            // or overflow. The error code can be used
            // to determine the kind of error.
            lastErrorMessage = _newmessage;
            errorCount++;
            return ("No update", false);
        } catch (bytes memory /*lowLevelData*/) {
            // This is executed in case revert() was used.
            lastErrorMessage = _newmessage;
            errorCount++;
            return ("No update", false);
        }
        lastMessageSent = _newmessage;
    }
    function getExternalMessage() public view returns(string memory) {
        return MB.getMessage();
    }
   /* function changeMessageAndDoSomething(string memory _newmessage) public {
        newmessage(_newmessage);
        lastMessageSent = _newmessage;
    }*/
}