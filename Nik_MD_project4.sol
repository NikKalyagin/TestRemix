//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Record {
    uint public timeOfCreation;

    constructor() {
        timeOfCreation = block.timestamp;
    }
}

contract EnsRecord is Record {
    string public domain;
    address public owner;
    constructor(string memory _domain) {
        owner = msg.sender;
        domain = _domain;
    }

    function getRecordType() public pure returns (string memory) {
        return "ens";
    }

    function setOwner(address _owner) public {
        owner = _owner;
    }
}

contract StringRecord is Record {
    string public record;

    constructor(string memory _record) {
        record = _record;
    }

    function getRecordType() public pure returns (string memory) {
        return "string";
    }

    function setRecord(string memory _record) public {
        record = _record;
    }
}

contract AddressRecord is Record {
    address public record;

    constructor(address _record) {
        record = _record;
    }

    function getRecordType() public pure returns (string memory) {
        return "address";
    }

    function setRecord(address _record) public {
        record = _record;
    }
}

contract RecordsStorage {
    address contrOwner;
    constructor() {
        contrOwner = msg.sender;    
    }
    
    Record[] public records;
    mapping(address => bool) public factories;

    modifier admin() {
        require(msg.sender == contrOwner, 'You are not a owner');
        _;
    }

    function addRecord(string memory _record) public {
        StringRecord stringRecord = new StringRecord(_record);
        records.push(stringRecord);
    }

    function addDomain(string memory _domain) public {
        EnsRecord ensRecord = new EnsRecord(_domain);
        records.push(ensRecord);
    }

    function addRecord(address _record) public {
        AddressRecord addressRecord = new AddressRecord(_record);
        records.push(addressRecord);
    }

    function addFactory(address _address) public admin returns(bool)  {
        factories[_address] = true;
        return factories[_address];
    }

}
