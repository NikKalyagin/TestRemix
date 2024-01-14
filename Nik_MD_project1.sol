// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ENS {
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