// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Estructuras {

    //Cliente de una pagina web de pago
    struct cliente{
        uint idCliente;
        string nombre;
        string dni;
        string email;
        uint phone_number;
        uint credit_number; //Numero tarjeta
        uint secret_number; //Numero secreto tarjeta
    }

    //Declaramos en una variable de tipo cliente
    cliente cliente_1 = cliente(1, "Gustavo", "48091680Z", "test@test.com", 12345679, 4444, 123);


    //Productos para pagina de compraventa(ej Amazon)
    struct producto{
        string nombre;
        uint precio;
    }

    //DEclaramos una variable de tipo producto
    producto producto_1 = producto("Producto 1", 10000);



    ///////////////
    //Proyecto ONGs
    struct ONG {
        address ong;
        string nombre;
    }

    ONG nueva_ong = ONG(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, "Caritas");


    //Causas de ONG
    struct causa {
        uint id;
        string nombre;
        uint recaudacion_objetivo;
    }

    causa ayuda_animales = causa(123, "Ayuda a perros", 120000);

}