// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

library Operaciones {

    function division(uint _a, uint _b) public pure returns(uint) {
        require(_b != 0, "No se puede dividir por 0");
        return _a/_b;
    }

    function multiplicacion (uint _a, uint _b) public pure returns(uint){
        if((_a == 0) || (_b==0)){
            return 0;
        }else {
            return _a*_b;
        }
    }
}

contract calculos {

    using Operaciones for uint;

    function calcular(uint _a, uint _b) public pure returns(uint, uint){
        
        uint q = _a.division(_b); //cociente
        uint m = _a.multiplicacion(_b); //resultado multiplicacion

        return (q, m);
    }

}