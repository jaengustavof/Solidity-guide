// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract bucle_for {

    //Suma de los 100 primeros numeros a partir del numero introducido
    function sumar(uint _n) public pure returns(uint){

        uint suma = 0;

        for(uint i = _n; i < (100 + _n); i++){
            suma = suma + i;
        }

        return suma;
    }

    ////////////////////////////////////////
    //Buscar direcciones, clientes, etc
    address [] direcciones;

    //agregar cliente
    function asociar() public {
        direcciones.push(msg.sender);
    }

    //comprobar si el cliente existe
    function comprobar() public view returns(bool, address){
        bool flag = false;

        for(uint i = 0; i < direcciones.length; i++){
            if(direcciones[i] == msg.sender){
                flag = true;
            }
        }

        return (flag, msg.sender);
    }


    // For anidado : Sumar los 10 primeros factoriales (3! = 3*2*1)
    //n! = n*(n-1)*(n-2)*...*2*1

    function sumaFactorial() public pure returns(uint){

        uint suma = 0;
        for(uint i = 0; i <= 10; i++){

            uint factorial = 1;

            for(uint j = 2; j <= i; j++){
                factorial = factorial * j;
            }


            suma = suma + factorial;

        }

        return suma;

    }


   
}