// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

///SE PUEDE IMPORTAR DE CUALQUIERA DE ESTAS FORMAS//

//import "./02.Importar Contrato";
import { Banco, Banco2 } from "./02.Importar Contrato";




contract Cliente is Banco {

    //Funcion que permite darse de alta
    function altaCliente(string memory _nombre) public {
        nuevoCliente(_nombre);
    }

    //Funcion que permite ingresar dinero
    function ingresarDinero(string memory _nombre, uint _cantidad) public {
        clientes[_nombre].dinero = clientes[_nombre].dinero + _cantidad;
    }

    //Funcion para retirar dinero
    function retirarDinero(string memory _nombre, uint _cantidad) public returns(bool){
        bool flag = true;
        
        if(clientes[_nombre].dinero >= _cantidad){
            clientes[_nombre].dinero = clientes[_nombre].dinero - _cantidad;
        }else {
            flag = false;
        }

        return flag;

    }

    //Funcion para consultar la cantidad de dinero
    function consultarDinero(string memory _nombre) public view returns(uint){
        return clientes[_nombre].dinero;
    }
}