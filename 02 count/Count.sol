// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Count {
    uint public count = 0;

    function get() public view returns (uint){
        return count;
    }
    
    function increment() public {
        count++;
    }

    function decrement(uint _num) public {
        count -= _num;
    }
}
