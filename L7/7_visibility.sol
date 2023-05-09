// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
contract EjemploVisibility{
    
   int  valor = 11;
  
    function get_int_internal() view internal returns (int) {
        return valor;
    }
    function get_int_public() view public returns (int) {
        return valor;
    }
   
}

contract B {
    int public aux;
    EjemploVisibility  contract1 = new EjemploVisibility();

   function test() public returns(int) {
       // aux = contract1.get_int_internal();
       aux = contract1.get_int_public();
       return aux;
   }
}