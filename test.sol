// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Moods {
  enum Mood {Surprise, Sadness, Disgust, Fear, Happiness, Anger}
  Mood public currentMood;
  uint public counter;

  function setMood(Mood _mood) public {
    currentMood = _mood;
  }

  modifier checkMood(Mood _expectedMood) {
    require(_expectedMood == currentMood, "Wrong Mood!");
    _;
  }

  function someAction(Mood _expectedMood) public checkMood(_expectedMood) {
    counter++;
  }

  uint8 public newNum;

modifier checker (uint8 _num) {
require(_num + 5 < 25, "Overflow");
_;
}

modifier checker1 () {
require(newNum + 1 < 25, "Overflow");
_;
}

  function counters(uint8 _num) public checker(_num)  returns(uint8)  {
    newNum =  _num + 5;
    return newNum;  
  }

  function counters() public checker1()  returns(uint8)  {
    newNum += 1;
    return newNum;  
  }

  struct DomainInfo {
        address userAddress;
        uint creationTime;
        uint fee;
        string message;
    }

    mapping(string => DomainInfo) public  domain;
    
    //address public userAddress;
    uint public fees = 1000000;

    function registerDomain(string memory _input) public payable  {
        domain[_input] = DomainInfo({
            userAddress: msg.sender,
            creationTime: block.timestamp,
            fee: fees,
            message: _input
        });
        
    }

    function returnAddress(string memory _input) public view returns(address){
        return domain[_input].userAddress;
    }

    
    function withdrawFunds() public {
        address payable receiver = payable(msg.sender);
        receiver.transfer(address(this).balance);
    }
} 