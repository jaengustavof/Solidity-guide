// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract view_pure_payable {
    
    //Modificador view - Permite acceder a los datos, pero no permite modificarlos.
    string[] lista_alumnos;
    function nuevo_alumno(string memory _alumno) public {
        lista_alumnos.push(_alumno);
    }

    function ver_alumno(uint _posicion) public view returns(string memory) {
        return lista_alumnos[_posicion];
    }

    uint x=10;
    function sumarAx(uint _a) public view returns(uint){
        return x+_a;
    }



    //Modificador pure - no accede a los datos.
    function exponenciacion(uint _a, uint _b) public pure returns(uint){
        return _a**_b;
    }

    //Modificador payable - nos permite recibir ETH

    mapping (address => cartera) DineroCartera; //relacion entre el address de la persona que ejecuta la consulta y los datos de la cartera

    struct cartera {
        string nombre_persona;
        address direccion_persona;
        uint dinero_persona;
    }

    function Pagar(string memory _nombrePersona, uint _cantidad) public payable  {
        cartera memory mi_cartera; //declaro la variable mi_cartera

        mi_cartera = cartera(_nombrePersona, msg.sender, _cantidad);
        DineroCartera[msg.sender] = mi_cartera;

    }

    function verSaldo() public view returns (cartera memory){
        return DineroCartera[msg.sender];
    }




}