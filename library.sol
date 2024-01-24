// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

library NumCheck {
    function even(uint _myInt) internal pure returns(bool) {
        return _myInt % 2 == 0;
    }
}

contract DemoL {
    using NumCheck for uint;
    

    function isEven(uint _Int) public pure returns(bool) {
        return _Int.even();
    }
}