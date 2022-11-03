// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Count {
    uint public count = 0;

    // You can read from a state variable without sending a transaction.
    function get() public view returns (uint) {
        return count;
    }

    // You need to send a transaction to write to a state variable.
    function increment() public {
        count++;
    }

    function decrement(uint _num) public {
        count -= _num;
    }
}
