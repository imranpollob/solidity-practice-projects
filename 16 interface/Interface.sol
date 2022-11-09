// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
You can interect with other contracts by declaring an interface.
Properties of an interface are given below:
- No function body
- Function decalrations are external
- No constructor
- No state variables
- Can inherit form other interfaces
*/

interface ICounter {
    function count() external view returns (uint);
    function increment() external;
}

contract Counter {
    uint public count;

    function increment() external {
        count += 1;
    }
}

contract MyContract {
    function getCount(address _counterAddress) external view returns (uint) {
        return ICounter(_counterAddress).count();
    }

    function incrementCounter(address _counterAddress) external  {
        ICounter(_counterAddress).increment();
    }
}