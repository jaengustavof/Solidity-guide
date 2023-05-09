// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8;

contract ArrayTest {
    uint[] public list;
    
    constructor ()  {
        list.push(1);
        list.push(2);
        list.push(3);
    }
    function getList() public view returns (uint[] memory) {
        return list;
    }
    function getNumberItems() public view returns(uint) {
        return list.length;
    }

    function addItemWithVal(uint val) public {
        list.push(val);
    }
    function addItem() public {
        list.push();
    }

    function deleteOneItem(uint index)  public {
        delete list[index];
    }
    function deleteList() public {
        delete list;
    }
    

}