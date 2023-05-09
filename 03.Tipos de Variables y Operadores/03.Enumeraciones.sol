// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Ejemplos_enumeraciones {

    //Enumeracion de interruptor
    enum estado {ON, OFF}

    //Variable de tipo enum (estado)
    estado state;

    function encender() public{
        state = estado.ON;
    }

    function apagar() public{
        state = estado.OFF;
    }

    function fijarEstado(uint _k) public{ //el estado se cambia de acuerdo al indice del enum 0 = ON, 1 = OFF
        state = estado(_k);
    }

    function Estado() public view returns(estado){
        return state;
    }


    //Enumeracion de direcciones
    enum direcciones {ARRIBA, ABAJO, DERECHA, IZQUIERDA}

    //Variable de tipo enum (direcciones)
    direcciones direccion = direcciones.ARRIBA;

    function arriba() public {
        direccion = direcciones.ARRIBA;
    }

    function abajo() public {
        direccion = direcciones.ABAJO;
    }

    function derecha() public {
        direccion = direcciones.DERECHA;
    }

    function izquierda() public {
        direccion = direcciones.IZQUIERDA;
    }

    function fijarDireccion (uint _j) public {
        direccion = direcciones(_j);
    }

    function Direccion() public view returns(direcciones){
        return direccion;
    }

    

}