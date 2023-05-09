// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract CarShop {
   address[] public carAssets;
   
   
   function newCar(string memory matricula,string memory brand, string memory model, uint _price) public    {
      address newCarAsset = address(new CarAsset(matricula,brand, model, msg.sender, _price));            
      carAssets.push(newCarAsset);   
   }
   function getDeployedChildContracts() public view returns (address[] memory) {
      return carAssets;
   }
}
contract CarAsset {
   string public matricula;
   string public brand;
   string public model;
   address public owner;
   uint public price;
   
   constructor (string memory _matricula, string memory _brand, string memory _model, address _owner, uint _price)  {
      matricula = _matricula;
      brand = _brand;
      model = _model;
      owner = _owner;
	  price = _price;
   }
   
   function buyCar() public payable returns(bool) {
	    require(msg.value == price, "buy order with wrong price");
        payable(owner).transfer(msg.value);
        owner = msg.sender;
	    return true;
   }
}