// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8;

contract Messagebox {
    string[] public messageList;
    uint public lastMessageDate;
    address payable public administrador;
    
    constructor ()  {
        administrador = payable(msg.sender); 
    }
    
    function destroy()  public {
        if (msg.sender == administrador) {
            selfdestruct(administrador);
        }     
    }
}