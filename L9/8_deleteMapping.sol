// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

contract Map {
    mapping(uint => uint)[] array;

    function allocate(uint newMaps) public {
        for (uint i = 0; i < newMaps; i++)
            array.push();
    }

    function writeMap(uint map, uint key, uint value) public {
        array[map][key] = value;
    }

    function readMap(uint map, uint key) public view returns (uint) {
        return array[map][key];
    }

    function eraseMaps() public {
        delete array;
    }
}

/*
allocate 1 (o más mappings)
assigna valores al mapping clave-valor
elimina los mappings, lo que elimina es la longitud de la lista, pero dado que no se puede resetear los elementos de un mapping sin la clave, siguen los valores almacenados en el contrato
por lo que si consultamos el mapping  no nos devuelve porque la lista está vacía
pero si volvemos simplemente a crear la lista, allocate el mapping
al consultar se recuperan los valores del anterior mapping registrado
*/