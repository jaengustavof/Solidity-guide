// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;


contract Loteria {

    enum Estado {Activo, Finalizado}

    Estado private estado;
    address payable [] private participantes;
    address payable private ganador;
    uint private deployementTime;
    uint private total;

    constructor()  {
        estado = Estado.Activo;
        deployementTime = block.timestamp;
    }
    
    function participar() public payable{
        require(block.timestamp < deployementTime + 5 minutes, "El sorteo ha finalizado 5m");
        require(estado == Estado.Activo, "El sorteo ha finalizado");
        require(msg.value == 0.01 ether, "Debe pagar 0.01Ether para participar");
        participantes.push(payable(msg.sender));
    }

    function participarXveces(uint cantidad)public payable{
        total = cantidad * 0.01 ether;
        require(block.timestamp < deployementTime + 5 minutes, "El sorteo ha finalizado 5m");
        require(estado == Estado.Activo, "El sorteo ha finalizado");
        require(msg.value == total, "Debe pagar 0.01Ether por cada participacion");
        for(uint i = 0; i < cantidad; i++){
            participantes.push(payable(msg.sender));
        }
    }

    receive() external payable {  //call with empty call data (transfer without data)
        participar();
    }
    fallback() external payable {   
        participar();
    }

    function getParticipantes() public view returns (address payable[] memory) {
        return participantes;
    }

    function getCantidadParticipaciones() public view returns(uint) {
        return participantes.length;
    }

    function finalizar() private {
        require(estado == Estado.Activo, "El sorteo no ha finalizado");
        estado = Estado.Finalizado;

        uint idGanador = random() % participantes.length;
        ganador = participantes[idGanador];
        enviarPremio();
    }

    function random() private view  returns(uint){
        return block.prevrandao;
    }

    function enviarPremio() internal {
        require(ganador !=address(0));
        ganador.transfer(address(this).balance);
    }

    function getBote() public view returns(uint){
        return address(this).balance;
        
    }

    function getGanador() public view returns(address payable){
        require(estado == Estado.Finalizado, "loteria no finalizada");
        return ganador;
    }
}

contract LoteriaContrato {
    address[] private loterias;

    function createLottery() public {
        address loteria = address(new Loteria());
        loterias.push(loteria);
    }

    function getLotteries() public view returns (address[] memory) {
        return loterias;
    }
}