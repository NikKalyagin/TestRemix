// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ENS {
    address owner;
    uint public regCostYear = 2000000000000000000;
    constructor() {
        owner = msg.sender;
    }

    modifier admin() {
        require(msg.sender == owner, 'You are not a master');
        _;
    }

    function setRegCostYear(uint _newRegCostYear) public admin {
        regCostYear = _newRegCostYear;
    }

    struct DomainInfo {
        address userAddress;
        uint creationTime;
        uint fee;
        string message;
    }

    mapping(string => DomainInfo) public  domain;
    
    
    uint fees = 1000000000000000000;
    uint public totalBalance;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
     

    function registerDomain(string memory _input) public payable  {
        require(msg.value >= fees, "Insufficient funds");
        domain[_input] = DomainInfo({
            userAddress: msg.sender,
            creationTime: block.timestamp,
            fee: msg.value,
            message: _input
        });
        totalBalance += msg.value;
        
    }

    function returnAddress(string memory _input) public view returns(address){
        return domain[_input].userAddress;
    }

    
    function withdrawFunds() public payable admin  {
        address payable receiver = payable(msg.sender);
        receiver.transfer(address(this).balance);
    }
}