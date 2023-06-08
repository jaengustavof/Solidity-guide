// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

// -----------------------------------
//  ALUMNO   |    ID    |      NOTA
// -----------------------------------
//  Marcos |    77755N    |      5
//  Joan   |    12345X    |      9
//  Maria  |    02468T    |      2
//  Marta  |    13579U    |      3
//  Alba   |    98765Z    |      5

contract notas {

    // Direccion del profesor
    address public profesor;

    // Constructor
    constructor () {
        profesor = msg.sender;
    }

    //Mapping para relacionar el hash de la identidad del alumno con su nota
    mapping (bytes32 => uint) Notas;

    // Array de los alumnos que pidan revision de examen
    string [] revisiones;

    // Eventos
    event alumno_evaluado(bytes32, uint);
    event evento_revision(string);


    modifier UnicamenteProfesor(){
        //Require que la direccion introducida sea igual al owner del contrato
        require(msg.sender == profesor, "No tiene permisos para realizar esta funcion");
        _;
    }

    // Funcio para evaluar a alumnos
    function Evaluar(string memory _idAlumno, uint _nota) public UnicamenteProfesor() {
        //hash de la identificacion del alumno
        bytes32 hash_idAlumno = keccak256(abi.encodePacked(_idAlumno));
        
        //relacionar el hash con la nota
        Notas[hash_idAlumno] = _nota;

        // Emitir evento
        emit alumno_evaluado(hash_idAlumno, _nota);
    }

    //Funcion para ver las notas de un alumno de clase // Ingresar el id del alumno que aparezca en la linea 6
    function verNotas(string memory _idAlumno) public view returns(uint) { 
        bytes32 hash_idAlumno = keccak256(abi.encodePacked(_idAlumno));
        return Notas[hash_idAlumno];
    }

    //Funcion para pedir revision de examen
    function revisionExamen(string memory _idAlumno) public {
        revisiones.push(_idAlumno);
        emit evento_revision(_idAlumno);
    }

    //Funcion para ver quienes pidieron revisiones de examen
    function VerRevisione() public view UnicamenteProfesor() returns(string [] memory) {
        return revisiones;
    }
}