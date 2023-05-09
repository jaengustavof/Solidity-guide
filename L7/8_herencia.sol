// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;


//// HAY QUE ELEGIR EL CONTRATO QUE DEPLOYAMOS
contract Owned {
    address payable public owner;
   
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    constructor ()  {
        owner = payable(msg.sender);
    }
}

contract Mortal is Owned {
   function deleteSmartContract() onlyOwner public {
        selfdestruct(owner);
    }
}

contract Named  {
  string public name;
    constructor(string memory _name)  {
      name = _name;
    }
}

contract EjemploHerencia is  Named, Mortal {
    
    string public text = "hello world";
    uint public initialvalue;
  
    constructor(string memory _name) Named(_name) payable{
        initialvalue = msg.value;
    }
   
    
}