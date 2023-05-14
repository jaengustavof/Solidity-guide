// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract causaBenefica {
    
    struct Causa {
        uint id;
        string nombre;
        uint recaudacion_objetivo;
        uint cantaidad_recaudadad;
    }

    uint contador_causas = 0;

    mapping (string nombre => Causa) causas; //relaciona el nombre de la causa con el objeto de la causa(struct)

    function nuevaCausa (string memory _nombre, uint _objetivo) public payable {//dar de alta una nueva causa
        contador_causas = contador_causas++;

        causas[_nombre] = Causa(contador_causas, _nombre, _objetivo, 0);
        /*
        Causa memory nuevacausa = Causa(contador_causas, _nombre, _objetivo, 0);
        causas[_nombre] = nuevacausa;
        */
    }

    function objetivoAlcanzado(string memory _nombre, uint _cantidad) private view returns(bool){ //devuelve true si se puede donar
        
        bool flag = false; 
        Causa memory causaSeleccionada = causas[_nombre]; //guardamos en una variable la causa seleccionada. El nombre lo proporciona la funcion cuando se ejecuta
       
        if(causaSeleccionada.recaudacion_objetivo >= (causaSeleccionada.cantaidad_recaudadad + _cantidad)){
            flag = true;
        }

        return flag;
    }

    function donar(string memory _nombre, uint _cantidad) public returns(bool){ //no permitira donar en caso que la cantidad recaudad haya llegado a la recaudacion objetivo
        bool aceptar_donacion = true;
        if(objetivoAlcanzado(_nombre, _cantidad)){
            causas[_nombre].cantaidad_recaudadad = causas[_nombre].cantaidad_recaudadad + _cantidad;
        }else {
            aceptar_donacion = false;
        }

        return aceptar_donacion;
    }

    function comprobar_causa(string memory _nombre) public view returns(bool, uint){
        bool limite_alcanzado = false;
        Causa memory causa = causas[_nombre];

        if(causa.cantaidad_recaudadad >= causa.recaudacion_objetivo){
            limite_alcanzado = true;
            
        }

        return (limite_alcanzado, causa.cantaidad_recaudadad);
    }
  

}