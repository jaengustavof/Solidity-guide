// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract contrato1 {

    uint internal valor ;
    
    function setValor(uint newvalue) public returns(bool) {
        valor = newvalue;
        return true;
    }
    
    function getValue() public view  returns (uint) {
        return valor;
    }
	
	 function sumaValors(uint aux1, uint aux2) public returns(bool){
		valor = aux1+aux2;
		return true;
	 }
	 
      function restaValors(uint aux1, uint aux2) public returns(bool){
		valor = aux1-aux2;
		return true;
	 }
    
}

contract contrato2 {
    uint public valor;
    
    function changeOtherContract(address otherscaddress, uint newvalor) public {
         assert(contrato1(otherscaddress).setValor(newvalor));
    }
    
    function setValueFromOtherContract(address otherscaddress) public {
        valor = contrato1(otherscaddress).getValue();
    }
}