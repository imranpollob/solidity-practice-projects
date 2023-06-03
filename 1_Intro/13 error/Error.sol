// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
An error will undo all changes made to the state during a transaction.

You can throw an error by calling require, revert or assert.
- require is used to validate inputs and conditions before execution.
- revert is similar to require. See the code below for details.
- assert is used to check for code that should never be false. Failing assertion probably means that there is a bug.

Use custom error to save gas.
*/
contract Error {
    function testRequire(uint i) pure public {
        // Require should be used to validate conditions such as:
        // - inputs
        // - conditions before execution
        // - return values from calls to other functions
        require(i > 10, "Input should be more than 10");
    }

    function testRevert(uint i) pure public{
        // Revert is useful when the condition to check is complex.
        // This code does the exact same thing as the example above
        if (i <= 10) {
            revert("Input should be more than 10");
        }
    }

    uint public num;

    function testAssert() view public {
        // Assert should only be used to test for internal errors,
        // and to check invariants.

        // Here we assert that num is always equal to 0
        // since it is impossible to update the value of num
        assert(num == 0);
    }

    // custom error
    error InsufficientBalance(uint balance, uint withdrawAmount);

    function testCustomError(uint _withdrawAmount) view public {
        uint balance = address(this).balance;
        
        if(balance < _withdrawAmount) {
            revert InsufficientBalance(balance, _withdrawAmount);
        }
    }
}