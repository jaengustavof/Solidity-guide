// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract sentencia_if {

    //Numero ganador
    
    function probarSuerte(uint _num) public pure returns(bool) {
        bool ganador = false;

        if(_num == 100){
            ganador = true;
        }

        return ganador;
    }


    //Calcular el valor absoluto de un numero
    function valorAboluto(int _num) public pure returns(uint) {
        uint valor_absoluto_numero;
        if(_num < 0 ){
            valor_absoluto_numero = uint( - _num ); //tansformamos el valor a unit positivo
        }else{
            valor_absoluto_numero = uint( _num );
        }

        return  valor_absoluto_numero;
    }


    //Devolver true si el numero introducido es par y tiene 3 cifras
    function parTresCifras(uint _n) public pure returns(bool){

        bool flag = false;

        if((_n % 2 == 0) && (_n >= 100) &&(_n < 1000)){
            flag = true;
        }

        return flag;
    }


    // Votacion - 3 candidatos "Pepe", "Maria", "Otto"
    function votar(string memory _candidato) public pure returns(string memory){
        string memory mensaje;

        if(keccak256(abi.encodePacked(_candidato))==keccak256(abi.encodePacked("Pepe"))){
            mensaje = "Has votado a Pepe";
        }else if(keccak256(abi.encodePacked(_candidato))==keccak256(abi.encodePacked("Maria"))){
            mensaje = "Has votado a Maria";
        }else if(keccak256(abi.encodePacked(_candidato))==keccak256(abi.encodePacked("Otto"))){
            mensaje = "Has votado a Otto";
        }else {
            mensaje = "Candidato no disponible";
        }

        return mensaje;

    }

   
}