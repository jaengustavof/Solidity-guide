// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract bucle_while{


    //Suma de los numeros impares menores a 100
    function sumaImpares() public pure returns(uint) {
        
        uint suma = 0;
        uint contador = 1;

        while(contador < 100){

            if(contador % 2 != 0){
                suma = suma + contador;
            }

            contador++;

        }

        return suma;
    }


    //Esperar 5 segundos
    uint tiempo;

    function fijarTiempo() public {
        tiempo = block.timestamp;
    }

    function esperaCIncoSeg() public view returns(bool){
        while (block.timestamp < tiempo+5 seconds){
            return false;
        }
        return true;
    }


    //Devolver el siguiente numero primo
    //Numero primo es aquel que es divisible entre uno y el mismo

    function siguientePrimo(uint _p) public pure returns(uint){

        uint contador = _p+1;

        while (true){
            //comprobar si contador es primo
            uint aux=2;
            bool primo = true;
            while(aux<contador){

                if(contador%aux ==0){ //no es primo
                    primo =false;
                    break;
                }

                aux++;
            }

            if(primo == true){
                break;
            }

            contador++;
        }

        return contador;
    }
   
}