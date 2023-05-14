// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract ReturnFunctions {
    // Function that returns a greeting
    function saludos() public pure returns (string memory) {
        return "Saludos";
    }

    //Function multiplies two integers
    function multiply(uint _a, uint _b) public pure returns(uint){
        return  _a*_b;
    }

    //Function even or odd
    function oddOrEven(uint _num) public pure returns(string memory){
        if(_num%2 == 0){
            return "even";
        }else{
            return "odd";
        }
    }

    //Function division
    function division(uint _a, uint _b) public pure returns(uint, uint, bool) {
        uint q = _a/_b; //cociente
        uint r = _a%_b; //resto
        bool multiplo = false;
        if(r==0){
            multiplo = true;
        }

        return (q, r, multiplo);
    }

    //Practica para el manejo de los valores devueltos
    function numeros() public pure returns(uint, uint, uint, uint, uint, uint){
        return (1,2,3,4,5,6);
    }

    //Asignacion multiple
    function todos_los_valores() public pure {
        //declaramos la variables donde se guardan los valores de retorno
        uint a;
        uint b;
        uint c;
        uint d;
        uint e;
        uint f;

        //realizar la asignacion multiple
        (a,b,c,d,e,f) = numeros();
    }

    function ultimo_valor() public pure returns(uint) {
        (,,,,,uint ultimo) = numeros();
        return ultimo;
    }
}