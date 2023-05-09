// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Owned {
    address public administrador;

    constructor() {
        administrador = msg.sender;
    }

    modifier onlyAdmin {
        require(msg.sender == administrador, "only admin");
        _;
    }
}

contract Lottery is Owned {

    enum Estado { Activo, Finalizado }
    
    address payable[] private participantes;
    Estado public estado; 
    address payable private ganador;


    constructor()  {
        estado = Estado.Activo;
    }
    
    function participar() public payable {
        require(msg.value == 0.01 ether, "Cantidad participacion incorrecta debe ser 0.01 ether"); //la participacion debe enviar exactamente 0.01 ethers
        require(estado == Estado.Activo, "loteria ya finalizada"); //debe estar activa
        participantes.push(payable(msg.sender));
    }
    
    receive() external payable {  //call with empty call data (transfer without data)
        participar();
    }
    fallback() external payable {   
        participar();
    }

    function getCantidadParticipaciones() public view returns(uint) {
        return participantes.length;
    }

    
    function finalizarLoteria()  public onlyAdmin {
        
        require(estado == Estado.Activo, "ya finalizado"); //debe estar activa
        
        estado = Estado.Finalizado;
        
        uint idGanador = random() % participantes.length;
        ganador = participantes[idGanador];
        
        enviarPremio();  //error potencial
    }
    
    //function random() public view returns (uint) {
    function random() public view returns (uint) {
       //uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty,participantes.length, gasleft(), block.coinbase)));
        return block.prevrandao;  //valor pseudo-aleatorio
    }

    function get_bote_acumulado() public view returns(uint){
        return address(this).balance; //devuelve balance del contrato
    }
    function enviarPremio() internal {
        require(ganador != address(0));
        
        ganador.transfer(address(this).balance);
    }
    
    function getGanador() public view returns (address payable) {
         require(estado == Estado.Finalizado, "loteria no finalizada"); //debe estar Finalizado
         return ganador;
    }
}

// https://sepolia.etherscan.io/address/0x83c1b8e505153ca6521cc0921fc61165ade972f1#code