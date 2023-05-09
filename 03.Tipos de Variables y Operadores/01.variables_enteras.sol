// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract enteros {

    // uint - solo numeros positivos
    // int - numeros positivos y negativos.

    // Variables enteras sin signo
    uint mi_primer_entero;
    uint mi_primer_entero_inicializado = 3;
    uint cota = 5000;

    // Varialbes enteras sin signo con un numero especifico de bits
    uint8 entero_8_bits;
    uint64 entero_64_bits = 7000;
    uint16 entero_16_bits;
    uint256 entero_256_bits; // es lo mismo que escribir uint ya que por defecto uint es de 256 bits

    // Variables enteras con signo (para numeros negativos)
    int mi_primer_entero_con_signo;
    int mi_numero = -32;
    int mi_entero2 = 65;

    // Variables enteras con signo con un numero especifico de bits
    int72 entero_con_signo_72_bits;
    int240 entero_con_signo_240_bits = 9000;
    int256 entero_con_256_bits; // es lo mismo que escribir int ya que por defecto int es de 256 bits

}