// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract MyContract {
  uint public myNumber = 450; 

  function funcOne() public view returns(uint) {
    return myNumber;
  }

  function funcTwo() public pure returns(uint) {
    return 450;
  }

  function funcThree() public pure returns(string memory) {
    return 'Hello';
  }

  function funcFour() public returns(uint) {
    return myNumber ++;
  }
  
}