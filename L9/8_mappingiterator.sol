pragma solidity ^0.8.13;

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
contract example_mapping_iterator{
    struct Student {
        uint id; //id se corresponde con la posicion del alumno en la lista de alumnos
        string name;
        
    }
        
    mapping(address => Student)  alumnos;
    address[] public idAlumnos;
    uint public registered;
 
    function addAlumno(string memory _name, address studenwallet) public {
        require(alumnos[studenwallet].id == 0, "alumno ya registrado");
        idAlumnos.push(studenwallet);
        alumnos[studenwallet] = Student({name:_name, id: idAlumnos.length});
        registered++;
    }
    
    function getRegisteredStudents() public view returns (address[] memory)
    {
        return idAlumnos;
    }

    function getStudentbyWallet(address userwallet) public view returns(string  memory studentname, uint idAlumno) {
         idAlumno = alumnos[userwallet].id;
         studentname = alumnos[userwallet].name;
    }
    
    function getStudentbyId(uint studentId) public view returns(string  memory studentname, address userwallet) {
         userwallet = idAlumnos[studentId-1];
         studentname = alumnos[userwallet].name;
    }

    
    
}