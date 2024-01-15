// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Overflow { 
  uint8 public newNum;

modifier checker (uint8 _num) {
require(_num + 5 < 25, "Overflow");
_;
}

modifier checker1 () {
require(newNum + 1 < 25, "Overflow");
_;
}

  function counter(uint8 _num) public checker(_num)  returns(uint8)  {
    newNum =  _num + 5;
    return newNum;  
  }

  function counter() public checker1()  returns(uint8)  {
    newNum += 1;
    return newNum;  
  }
} 