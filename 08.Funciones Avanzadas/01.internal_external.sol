// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Comida {

    struct plato {
        string nombre;
        string ingredientes;
        uint tiempo;
    }

    plato[] platos; //array dinamico de tipo plato

    mapping (string => string) ingredientes; //relaciona el nombre del plato con los ingredientes

    function NuevoPlato(string memory _nombre, string memory _ingredientes, uint _tiempo) internal {
        platos.push(plato(_nombre, _ingredientes, _tiempo));
        ingredientes[_nombre] = _ingredientes;

    }

    function MostrarIngredientes(string memory _nombre) internal view returns(string memory) {
        return ingredientes[_nombre];
    }

}

contract Sandwitch is Comida {

    function newSandwitch(string memory _ingredientes, uint _tiempo) external {
        NuevoPlato("Sandwitch", _ingredientes, _tiempo); //Funcion en el contrato Comida
    }

    function verIngredientes() external view returns(string memory) {
        return MostrarIngredientes("Sandwitch"); //Funcion en el contrato Comida
    }

}