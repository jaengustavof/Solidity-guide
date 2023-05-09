// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

interface contrato1 {
    function setValor(uint newvalue) external returns(bool);
    function getValue() external view  returns (uint);
    function sumaValors(uint aux1, uint aux2) external ;      
}


contract contrato2 {
    uint public valor;
    address changerSC;
    address manager;
    
    constructor ()  {
        manager = msg.sender;
    }
    
    function setChanger(address newchanger) public {
        require(manager == msg.sender);
        changerSC = newchanger;
    }
    
    function setSumaValors(uint aux1, uint aux2) public {
        contrato1(changerSC).sumaValors(aux1,aux2);
    }
    
    function setValue(uint _value) public {
        require(msg.sender == changerSC, "unicamente se permite actualizar desde SCChanger autorizado");
        valor = _value;
    }
    
}