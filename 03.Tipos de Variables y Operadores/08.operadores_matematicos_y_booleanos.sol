// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Operadores {

    // Operadores matematicos
    uint a = 32;
    uint b = 4;

    uint public suma = a + b;
    uint public resta = a - b;
    uint public division = a/b;
    uint public multiplicacion = a*b;
    uint public modulo = a%b;
    uint public exponenciacion = a**b;

    function sumar(uint _y, uint _j) public pure returns(uint){
        return _y+_j;
    }

    //Comparacion de enteros

    uint c = 3;
    uint d = 3;
    
    bool public test_1 = a>b;
    bool public test_2 = a<b;
    bool public test_3 = a==b;
    bool public test_4 = c==d;
    bool public test_5 = a!=b;

    function comparar(uint _x, uint _y) public pure returns(bool){
        return _x==_y;
    }

    //Operadores booleanos

    function divisionEntreCinco(uint x) public pure returns(bool){
        return x%5 == 0;
    }

    //Criterio de divisibilidad entre 5: si el numero termina en 0 o en 5
    function divisibilidad(uint k) public pure returns(bool){
        uint ultima_cifra = k%10; //el modulo entre k y 10 nos dara la ultima cifra
        if((ultima_cifra == 0) || (ultima_cifra == 5)){
            return true;
        }else{
            return false;
        }
    }

    //Criterio de divisibilidad entre 5: si el numero termina en 0 o en 5
    function divisibilidadV2(uint k) public pure returns(bool){
        uint ultima_cifra = k%10; //el modulo entre k y 10 nos dara la ultima cifra
        if((ultima_cifra != 0) && (ultima_cifra != 5)){
            return false;
        }else{
            return true;
        }
    }

}