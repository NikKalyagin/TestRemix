//SPDX-License-Identifier: GPL-3.0 
pragma solidity ^0.8.0; 
import "hardhat/console.sol"; 

contract DemoStorage {
  uint customData;
 
  function set(uint x) public { 
    customData = x; 
    
  } 

  function get() public view returns (uint) { 
    return customData; 
  } 
}
