// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Administrador {
    address private admin;

    modifier OnlyAdmin() {
        require(msg.sender == admin, "Only admin is Authorized");
        _;
    }

    constructor () {
        admin = msg.sender;
    }
}

contract VoteFactory {
    address[] public votingContracts;

    function newVote(string memory nombrePropuesta) public    {
      address newVoteAsset = address(new Votacion(nombrePropuesta));            
      votingContracts.push(newVoteAsset);   
   }

}

contract Votacion is Administrador {

    struct Propuesta {
        string name;
        string detallePropuesta;
        uint idPropuesta;
        uint voteCount;
    }

    struct Votante {
        bool votado;
        uint pesoVoto;
        address delegarVotoTo;
        uint propuestaVotada;
    }

    enum EstadoVotacion { Preparacion, Abierta, Finalizada }

    EstadoVotacion public estado;
    string public name;
    uint public totalVotantes;
    uint public votosEfectuados;
    uint public propuestaGanadora;
    uint private deploymentTime;
    Propuesta[] internal propuestas;
    mapping (address => Votante) public votantes;

    event Log(uint message);

    modifier onlyEnPreparacion() {
       require(estado == EstadoVotacion.Preparacion,"votacion ya iniciada");
        _;
    }
    modifier onlyEnAbierta() {
         require(estado == EstadoVotacion.Abierta,"votacion finalizada");
        _;
    }
    
    constructor(string memory nombrePropuesta)  {
        name = nombrePropuesta;
        propuestas = propuestas;
        estado = EstadoVotacion.Preparacion;
        deploymentTime = block.timestamp;
    }

    function addPropuesta (string memory nombreProp, string memory detalleProp) public  OnlyAdmin {
        require(block.timestamp < deploymentTime + 1 days, "El periodo de votacion ha terminado.");
        propuestas.push(Propuesta({name: nombreProp, detallePropuesta: detalleProp, idPropuesta: propuestas.length+1, voteCount: 0}));
    }

    function darDerechoDeVoto (address voterAddress) public OnlyAdmin {
        require(votantes[voterAddress].pesoVoto == 0, "Votante ya Registrado");
        require(block.timestamp < deploymentTime + 1 days, "El periodo de votacion ha terminado.");
        votantes[voterAddress] = Votante({votado: false, pesoVoto: 1, delegarVotoTo: address(0), propuestaVotada : 0 });
        totalVotantes++;
    }

    function iniciarVotacion () public OnlyAdmin {
        require(estado == EstadoVotacion.Preparacion, "La votacion ha sido iniciada");
        estado = EstadoVotacion.Abierta;
    }


    function getPropuestas() public view returns (string[] memory nombres, string[] memory detalles, uint[] memory cantidadVotos) {
        uint numPropuestas = propuestas.length;
        nombres = new string[](numPropuestas);
        detalles = new string[](numPropuestas);
        cantidadVotos = new uint[](numPropuestas);
        for (uint i = 0; i < numPropuestas; i++) {
            Propuesta memory propuesta = propuestas[i];
            nombres[i] = propuesta.name;
            detalles[i] = propuesta.detallePropuesta;
            cantidadVotos[i] = propuesta.voteCount;
        }
        return (nombres, detalles, cantidadVotos);
    }

    function votar (uint idPropuesta) public {
        emit Log(idPropuesta);
        require(votantes[msg.sender].pesoVoto != 0, "No tienes derecho a voto");
        require(votantes[msg.sender].votado == false, "ya ha votado");
        require(votantes[msg.sender].delegarVotoTo == address(0), "has  delegado");
        require(block.timestamp < deploymentTime + 1 days, "El periodo de votacion ha terminado.");
        require(estado == EstadoVotacion.Abierta, "Votacion cerrada");

        uint pesoVotoUsuario = votantes[msg.sender].pesoVoto;
        votantes[msg.sender].pesoVoto = 0;
        votantes[msg.sender].votado = true;
        votantes[msg.sender].propuestaVotada = idPropuesta;

        if(idPropuesta != 0){ // 0 vota en blanco
            propuestas[idPropuesta-1].voteCount += pesoVotoUsuario;
        }

        votosEfectuados += pesoVotoUsuario;
    }

    function finalizarVotacion() public  OnlyAdmin onlyEnAbierta {
        require(block.timestamp > deploymentTime + 1 days, "No ha pasado un dia");
        estado = EstadoVotacion.Finalizada;

       uint idPropuestaMasVotada = 0;
       uint votosPropuestaMasVotada = 0;
       
       for(uint i = 0; i < propuestas.length; i++) {
           if(propuestas[i].voteCount > votosPropuestaMasVotada) {
               idPropuestaMasVotada = i+1;
               votosPropuestaMasVotada = propuestas[i].voteCount ;
           }
       }
       
       propuestaGanadora = idPropuestaMasVotada;
    }
    
    
    function getPropuestabyId(uint8 propuestaId) public view returns(string memory nombreProp, string memory detallePropuesta) {
        nombreProp = propuestas[propuestaId-1].name;
        detallePropuesta  = propuestas[propuestaId-1].detallePropuesta;
    }
    
    function getPropuestaGanadora() public view returns(string memory nombreProp, string memory detallePropuesta) {
        require(estado == EstadoVotacion.Finalizada,"votacion no finalizada");
        nombreProp = propuestas[propuestaGanadora-1].name;
        detallePropuesta  = propuestas[propuestaGanadora-1].detallePropuesta;
    }
    

}