// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract Overflow {
 uint public counter = 0;
  function add() public returns(uint) {
  if (counter > 255) {
  revert('error');
  }
    else counter += 5;
    return counter;
    }
}  