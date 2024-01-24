// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract StringRecord {
    uint internal timeOfCreation;
    string public record;

    constructor(uint _timeOfCreation, string memory _record) payable {
        timeOfCreation = _timeOfCreation;
        record = _record;
    }

    function getRecordType () public pure virtual returns(string memory typeContr) {
        return typeContr = "string";
    }

    function setRecord(string memory _record) internal  {
        record = _record;
    }
}

contract AddressRecord {
    uint internal timeOfCreation1;
    address public record1;

    constructor(uint _timeOfCreation1, address _record) payable {
        timeOfCreation1 = _timeOfCreation1;
        record1 = _record;
    }

    function getRecordType1 () public pure virtual returns(string memory typeContr) {
        return typeContr = "address";
    }

    function setRecord(address _record) internal    {
        record1 = _record;
    }
}

contract RecordFactory is StringRecord, AddressRecord  {
   constructor(string memory _record, address _record1, uint _timeOfCreation, uint _timeOfCreation1)
   StringRecord(_timeOfCreation, _record)  AddressRecord(_timeOfCreation1, _record1) {}
   
   mapping(uint => string) public records;
   uint internal  i;

   function addRecord(string memory _record) public  {
    StringRecord.setRecord(_record);
    records[i] = StringRecord.record;
    i += 1;
   }

   function addRecord(address _record1) public  {
    AddressRecord.setRecord(_record1);
    records[i] = addressToString(AddressRecord.record1);
    i += 1;
    }

    function addressToString(address _address) private pure returns (string memory) {
    bytes32 value = bytes32(uint256(uint160(_address)));
    bytes memory alphabet = "0123456789abcdef";

    bytes memory str = new bytes(42);
    str[0] = "0";
    str[1] = "x";
    for (uint k = 0; k < 20; k++) {
        str[2+k*2] = alphabet[uint8(value[k + 12] >> 4)];
        str[3+k*2] = alphabet[uint8(value[k + 12] & 0x0f)];
    }
    return string(str);
}

    

}


/*contract RecordFactory is StringRecord, AddressRecord   {
   mapping(uint => string) public records;
   uint public i;

   function addRecord(string memory _record) public  {
    StringRecord newStringRecord = new StringRecord(_record);
    records[i] = newStringRecord.record();
    i += 1;
   }

   function addRecord(address _record) public {
    AddressRecord newAddressRecord = new AddressRecord(_record);
    records[i] = newAddressRecord.record1();
    i += 1;
    }

   function getRecordType () public pure override returns(string memory typeContr) {
        return typeContr = "factory";
    }
}
    */