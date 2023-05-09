// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Messagebox {
    string[] public messages;
    mapping(address => bool) public isUser;
	address public administrador;
	uint public lastMessageDate;
    
    constructor ()  {
		administrador = msg.sender; 
        messages.push("Hello World!");
    }
    
    function addMessage(string memory _new_message ) public payable {
        if(isUser[msg.sender] ) { //primera vez es falso, el usuario todavía no está registrado.
            if(msg.value == 0.001 ether) { //si no aporta 0.001 ethers no registramos mensaje
                registrarMensaje(_new_message);
            }
        }else {
            isUser[msg.sender] = true;  //registramos nuevo usuario, siguientes mensajes deberá pagar
            registrarMensaje(_new_message);
        }
        
    }

    function registrarMensaje(string memory _new_message ) internal {
            messages.push(_new_message);
            lastMessageDate = block.timestamp; 
    }
    
	function getMessage(uint index) public view returns (string memory) {  
        return messages[index];
    }

    function getAllMessages() public view returns (string[] memory) {
        return messages;
    }
	
	function deleteMessage(uint index) public {  //REQ3
        if(msg.sender == administrador && index < messages.length) {
            for (uint i = index; i<messages.length-1; i++){
                        messages[i] = messages[i+1];
             }
            messages.pop();
        }
    }
    
}