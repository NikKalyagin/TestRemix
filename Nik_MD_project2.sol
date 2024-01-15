// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ENS {
    address owner;
    uint public regCostYear = 2000000000000000000;
    uint8 public cofficient = 2;
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

    function setCofficient(uint8 _newCofficient) public admin {
        cofficient = _newCofficient;
    }

    struct DomainInfo {
        address userAddress;
        uint creationTime;
        uint fee;
        string message;
        uint8 year;
    }

    mapping(string => DomainInfo) public  domain;
    
    
    uint fees = 1000000000000000000;
    uint public totalBalance;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
     

    function registerDomain(string memory _input, uint8 _year) public payable  {
        require(domain[_input].userAddress == address(0), "Domain is already registered");
        require(block.timestamp > domain[_input].creationTime + domain[_input].year * 365 days, "Domain registration has not expired");
        require(msg.value >= (fees + _year*regCostYear), "Insufficient funds. Cost = fee for registration + (rent cost * years) ");
        require(_year>=1 && _year<=10, "Invalid term of rent");
        domain[_input] = DomainInfo({
            userAddress: msg.sender,
            creationTime: block.timestamp,
            fee: msg.value,
            message: _input,
            year: _year
        });
        totalBalance += msg.value;
        
    }
    function prolongateRent(string memory _input, uint8 _year) public payable  {
        require(domain[_input].userAddress == msg.sender, "Domain does not belong to the sender");
        require(msg.value >= ((_year * regCostYear) + (fees * cofficient)), 'Insufficient funds. Cost = rent cost * years + fee * coefficient');
        require(_year >= 1 && _year <= 10, "Invalid term of rent");
        domain[_input].year += _year; 
        domain[_input].fee += msg.value; 
        totalBalance += msg.value;
    }


    function returnAddress(string memory _input) public view returns(address){
        return domain[_input].userAddress;
    }

    
    function withdrawFunds() public payable admin  {
        address payable receiver = payable(msg.sender);
        receiver.transfer(address(this).balance);
        totalBalance = 0;
    }
}