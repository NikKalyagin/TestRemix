// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Person {
    address public factory;
    address public owner;

    constructor(address _owner) payable {
        owner = _owner;
        factory = msg.sender;
    }
}

contract PersonFactory {
    Person[] public persons;

    function deposit() public payable{

    }

    function thisBalance() public view returns(uint) {
        return address(this).balance;
    }

    function createPerson(address _owner) public {
        Person newPerson = new Person{value: thisBalance() / 2}(_owner);
        persons.push(newPerson);
    }

    function getFactory(uint _index) public view returns (address) {
        return persons[_index].factory();
        //address(persons[_index]);  для доступа к адресу как таковому
    }

    function balanceOf(uint _index) public view returns(uint) {
        return address(persons[_index]).balance;
    }
}