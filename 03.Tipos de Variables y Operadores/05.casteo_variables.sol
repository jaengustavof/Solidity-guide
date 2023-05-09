// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Casteo {

    //Ejemplo de casteo de variables

    uint8 entero_8bits = 42;
    uint64 entedo_64bits = 60000;
    uint entero_256bits = 1000000;
    int16 entero_16_bits = 156;
    int120 entero_120_bits = 900000;
    int entero_256_bits = 5000000;

    //Casteo de las variables
    uint64 public casteo_1 = uint64(entero_8bits); //cambiamos la variable de 8bits a una de 64bits
    uint64 public casteo_2 = uint64(entero_256bits); //cambiamos la variable de 256bits a una de 64bits
    // uint8 casteo_3 = uint8(entero_16_bits); No se puede pasar de int a uint
    int256 public casteo_4 = int(entero_120_bits);//cambiamos la variable int de 120bits a una int de 256bits
    int public casteo_5 = int(entero_256bits); //cambiamos una uint de 256bits a una int de 256

    function convertir(uint8 _k) public pure returns(uint64){
        return uint64(_k);
    }
}