// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Tiempo{

    //Unidades de Tiempo
    uint public tiempo_actual = block.timestamp;
    uint public un_minuto = 1 minutes;
    uint public dos_horas = 2 hours;
    uint public cincuenta_dias = 50 days;
    uint public una_semana = 1 weeks; 
    
    function MasSegundos() public view  returns(uint){
        return block.timestamp + 50 seconds;
    }

    function MasHoras() public view  returns(uint){
        return block.timestamp + 1 hours;
    }

    function MasSemanas() public view returns(uint){
        return block.timestamp + 1 weeks;
    }
    
}