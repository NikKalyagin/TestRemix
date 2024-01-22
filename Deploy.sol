// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Demo{
    address public owner;
    event Deployed(address _thisAddr, uint _balance);

    constructor (address _owner) payable {
        owner = _owner;
        emit Deployed(address(this), getBalance());
    }

    function getBalance() public view  returns(uint) {
        return address(this).balance;
    }
}