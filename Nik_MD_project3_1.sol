//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract Record {
    uint public timeOfCreation;

    constructor() {
        timeOfCreation = block.timestamp;
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

contract RecordFactory {
    Record[] public records;

    function addRecord(address _record) public {
        AddressRecord addressRecord = new AddressRecord(_record);
        records.push(addressRecord);
    }

    function addRecord(string memory _record) public {
        StringRecord stringRecord = new StringRecord(_record);
        records.push(stringRecord);

    }
}