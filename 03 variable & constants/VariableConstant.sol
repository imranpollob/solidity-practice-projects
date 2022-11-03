// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
There are 3 types of variables in Solidity
    local
    - declared inside a function
    - not stored on the blockchain
    state
    - declared outside a function
    - stored on the blockchain
    global (provides information about the blockchain)
*/
contract VariableConstant {
    // State variables are stored on the blockchain.
    string public text = "Hello";
    uint public num = 123;

    /*
    Constants are variables that cannot be modified.
    Their value is hard coded and using constants can save gas cost.
    Coding convention to uppercase constant variables
    */
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint public constant MY_UINT = 123;

    /*
    Immutable variables are like constants. 
    Values of immutable variables can be set inside the constructor but cannot be modified afterwards.
    */
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    constructor(uint _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }

    function doSomething() public {
        // Local variables are not saved to the blockchain.
        uint i = 456;

        // Here are some global variables
        uint timestamp = block.timestamp; // Current block timestamp
        address sender = msg.sender; // address of the caller
    }
}
