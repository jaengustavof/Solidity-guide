// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface contrato1 {
    function setValor(uint newvalue) external returns(bool);
    function getValue() external view  returns (uint) ;
    function sumaValors(uint aux1, uint aux2) external returns(bool);
    function restaValors(uint aux1, uint aux2) external returns(bool);
    function funcionNoExiste() external returns (uint);
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
       bool result =  contrato1(changerSC).sumaValors(aux1,aux2);
       assert(result);
    }
     function setRestValors(uint aux1, uint aux2) public {
       bool result =  contrato1(changerSC).restaValors(aux1,aux2);
       assert(result);
    }
    
    function setValue() public {
        valor =  contrato1(changerSC).getValue();
        assert(valor != 0);
    }

    function probarfuncionNoExiste() public {
        valor =  contrato1(changerSC).funcionNoExiste();

    }
    
}