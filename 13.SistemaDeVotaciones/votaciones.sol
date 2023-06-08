
//SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;

// -----------------------------------
//  CANDIDATO   |   EDAD   |      ID
// -----------------------------------
//  Toni        |    20    |    12345X
//  Alberto     |    23    |    54321T
//  Joan        |    21    |    98765P
//  Javier      |    19    |    56789W

contract votacion {

    //Direccion del propietario del contrato
    address public owner;

    //constructor
    constructor() public{
        owner = msg.sender;
    }

    //Relacion entre el nombre del candidato y el hash de sus datos personales
    mapping (string => bytes32) ID_Candidato;

    //Relacion entre el nombre del candidato y el numero de votos
    mapping(string=>uint) votos_Candidato;

    //Lista para almacenar los nombres de los candidatos
    string [] candidatos;

    //List de hashes identidad votantes
    bytes32 [] votantes;


    ///----Functiones----///

    //Agregar un nuevo candidato
    function nuevoCandidato(string memory _nombre, uint _edad, string memory _id) public{
        //calcular el hash de los datos del candidato
        bytes32 hash_candidato = keccak256(abi.encodePacked(_nombre, _edad, _id));

        //Almacenar el hash de los datos del candidato
        ID_Candidato[_nombre] = hash_candidato;

        //Actualizad lista de candidatos
        candidatos.push(_nombre);
    }

    //Ver candidatos que se han presentado
    function verCandidato()public view returns(string [] memory){
        return candidatos;
    }

    //Funcion que permite votar
    function votar(string memory _nombre) public {
        //hash de la persona que ejecuta esta funcion
        bytes32 hash_votante = keccak256(abi.encodePacked(msg.sender));

        //verificamos si el votante ya ha votado
        for(uint i = 0; i < votantes.length; i++){
            require(votantes[i] != hash_votante, "No puede votar mas de una vez");
        }

        //Si no ha votado lo anadimos al array de votantes
        votantes.push(hash_votante);

        //Anadimos un voto al candidato
        votos_Candidato[_nombre]++;
    }

    //Saber cantidad de votos que tiene cierto candidato
    function cantidadVotos(string memory _nombre) public view returns(uint) {
        return votos_Candidato[_nombre];
    }

    ///////////FUNCION DE UINT A STRING///////////////

    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }

    
    //Ver los votos de cada uno de los candidatos
    function verResultados() public view returns(string memory) {

        //Guardamos en una variable los candidatos con sus respectivos votos
        string memory resultados ="";

        //actualizamos el str resultado y devolvemos el candidato que ocupa la posicion i del array candidatos.
        //agregamos tambien su numero de votos
        for(uint i = 0; i< candidatos.length; i++){
            resultados = string(abi.encodePacked(resultados, "(", candidatos[i], ", ", uint2str(cantidadVotos(candidatos[i])), ") ---")); //abi.encodedPacked pasa a bytes todos los parametros que ingresamos en el parentesis y string pasa esos bytes a string
        }

        //Devolvemos los resultados
        return resultados;
    }


    //Ver el ganador de las elecciones
    function ganadorVotacion() public view returns(string memory) {

        string memory ganador = candidatos[0];
        bool flag;

        for(uint i = 1; i < candidatos.length; i++){

            if(votos_Candidato[ganador]<votos_Candidato[candidatos[i]]){

                ganador = candidatos[i];
                flag = false;

            }else {
                if(votos_Candidato[ganador] == votos_Candidato[candidatos[i]]){
                    flag = true;
                    
                }
            }

        
            if(flag == true){
                ganador = "Hay un empate entre los candidatos";
            }
        }

        return ganador;

    }

}