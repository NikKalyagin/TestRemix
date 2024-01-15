// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ENS {
    address owner;
    bool public alive;
    uint public regCostYear = 2000000000000000000;
    uint8 public cofficient = 2;
    constructor() {
        owner = msg.sender;
        alive = true;
    }

    modifier admin() {
        require(msg.sender == owner, 'You are not a master');
        _;
    }

    modifier isAlive() {
        require(alive == true, "That contraction - DEAD!!!");
        _;
    }

    function setRegCostYear(uint _newRegCostYear) public isAlive admin  {
        regCostYear = _newRegCostYear;
    }

    function setCofficient(uint8 _newCofficient) public isAlive admin  {
        cofficient = _newCofficient;
    }

    struct DomainInfo {
        address userAddress;
        uint creationTime;
        uint fee;
        string message;
        uint8 year;
        uint remainder;
    }

    mapping(string => DomainInfo) public  domain;
    
    
    uint fees = 1000000000000000000;
    uint public totalBalance;

    function getBalance() public view isAlive returns(uint) {
        return address(this).balance;
    }
     

    function registerDomain(string memory _input, uint8 _year) public payable isAlive {
        require(domain[_input].userAddress == address(0), "Domain is already registered");
        require(block.timestamp > domain[_input].creationTime + domain[_input].year * 365 days, "Domain registration has not expired");
        require(msg.value >= (fees + _year*regCostYear), "Insufficient funds. Cost = fee for registration + (rent cost * years) ");
        require(_year>=1 && _year<=10, "Invalid term of rent");
        domain[_input] = DomainInfo({
            userAddress: msg.sender,
            creationTime: block.timestamp,
            fee: msg.value,
            message: _input,
            year: _year,
            remainder: (msg.value - (fees + _year*regCostYear))
        });
        totalBalance += (fees + _year*regCostYear);
        address payable receiver = payable(msg.sender);
        receiver.transfer(domain[_input].remainder);
        
    }

    
    function prolongateRent(string memory _input, uint8 _year) public payable isAlive {
        require(domain[_input].userAddress == msg.sender, "Domain does not belong to the sender");
        require(msg.value >= ((_year * regCostYear) + (fees * cofficient)), 'Insufficient funds. Cost = rent cost * years + fee * coefficient');
        require(_year >= 1 && _year <= 10, "Invalid term of rent");
        domain[_input].year += _year;
        domain[_input].remainder = msg.value - ((_year * regCostYear) + (fees * cofficient));
        domain[_input].fee +=  ((_year * regCostYear) + (fees * cofficient)); 
        totalBalance += msg.value - domain[_input].remainder;
        address payable receiver = payable(msg.sender);
        receiver.transfer(domain[_input].remainder);
    }


    function returnAddress(string memory _input) public view isAlive returns(address){
        return domain[_input].userAddress;
    }

    //Можно забрать средства сколько угодно раз
    function withdrawFunds() public payable admin isAlive {
        address payable receiver = payable(msg.sender);
        receiver.transfer(address(this).balance);
        totalBalance = 0;
    }
    //Уходя, оставь ключи в квартире. Забрать средства и навсегда заблокировать контракт (не удалить)
    function destroy() public admin {
        address payable receiver = payable(msg.sender);
        receiver.transfer(address(this).balance);
        totalBalance = 0;
        alive = false;        
    }
}