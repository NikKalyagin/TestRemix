// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract EventDemo { 
  mapping(address => uint) public tokenBalance; 
  event TokensSent(address _from, address _to, uint _amount); 

  constructor() { 
    tokenBalance[msg.sender] = 10000000000; 
  } 
         
  function sendToken(address _to, uint _amount) public  { 
    tokenBalance[msg.sender] -= _amount; 
    tokenBalance[_to] += _amount; 
         
    emit TokensSent(msg.sender, _to, _amount);
  } 
  //
}