// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract CarShop {
   address[] public carAssets;
   mapping(string=>address) public addressVehiculos;
   
   function newCar(string memory matricula,string memory brand, string memory model, uint _price) public    {
       require(addressVehiculos[matricula] == address(0), "vehiculo ya registrado");
      address newCarAsset = address(new CarAsset(matricula,brand, model, msg.sender, _price));            
      carAssets.push(newCarAsset);   
      addressVehiculos[matricula] = newCarAsset;
   }
   function getDeployedChildContracts() public view returns (address[] memory) {
      return carAssets;
   }

   function getCarPrice(string memory matricula) public view returns(uint) {
       require(addressVehiculos[matricula] != address(0), "vehiculo no existe");
        return CarAsset(addressVehiculos[matricula]).getPrice();
        
   }
   function getCarOwner(string memory matricula) public view returns(address) {
       require(addressVehiculos[matricula] != address(0), "vehiculo no existe");
        return CarAsset(addressVehiculos[matricula]).owner();
        
   }

    function buyCar(string memory matricula) public payable returns (bool){
         require(addressVehiculos[matricula] != address(0), "vehiculo no disponible");
         assert( CarAsset(addressVehiculos[matricula]).buyCar{value: msg.value}(msg.sender));
         addressVehiculos[matricula] = address(0);   //quitar de vehiculos
         return true;
    }

}
contract CarAsset {
   string public matricula;
   string public brand;
   string public model;
   address public owner;
   uint public price;
   address public shop;

   constructor (string memory _matricula, string memory _brand, string memory _model, address _owner, uint _price)  {
      matricula = _matricula;
      brand = _brand;
      model = _model;
      owner = _owner;
	  price = _price;
      shop = msg.sender;
   }
   
   function buyCar(address newOwner) public payable returns(bool) {
        require(msg.sender == shop, "buy only available through shop");
	    require(msg.value == price, "buy order with wrong price");
        payable(owner).transfer(msg.value);
        owner = newOwner;
	    return true;
   }
    function getPrice() public view returns(uint) {
        return price;
    }
}