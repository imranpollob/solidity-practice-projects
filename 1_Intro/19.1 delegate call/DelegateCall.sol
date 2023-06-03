// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
delegatecall is a low level function similar to call.

When contract A executes delegatecall to contract B, B's code is executed
with contract A's storage, msg.sender and msg.value.
*/

contract B {
    address public owner;
    uint public amount;
    uint public number;

    function foo(uint _number) payable public {
        owner = msg.sender;
        amount = msg.value;
        number = _number;
    }
}

// NOTE: Deploy this contract first
contract A {
    // NOTE: storage layout must be the same as contract A
    address public owner;
    uint public amount;
    uint public number;

    function delegateCallFoo(address _addr, uint _number) payable public {
        (bool success, ) = _addr.delegatecall(
            abi.encodeWithSignature("foo(uint256)", _number)
        );
        require(success, "Transaction failed");
    }
}