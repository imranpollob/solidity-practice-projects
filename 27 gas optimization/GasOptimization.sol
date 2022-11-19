// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
Some gas saving techniques.
- Replacing memory with calldata
- Loading state vatiable to memory
- Replacing for loop i++ with ++i
- Caching array elements
- Short circuit
*/

contract SaveGas {
    // start - 50908 gas
    // use calldata - 49163 gas
    // load state variables to memory - 48952 gas
    // short circuit - 48634 gas
    // loop increments - 48244 gas
    // cache array length - 48209 gas
    // load array elements to memory - 48047 gas
    // uncheck i overflow/underflow - 47309 gas

    uint public total;

    // start - not gas optimized 
    function sum1(uint[] memory nums) external {
        for (uuint i = 0; i < nums.length; i++) {
            bool isEven = nums[i] % 2 == 0;
            bool isLeesThan99 = nums[i] < 99;

            if (isEven && isLeesThan99) {
                total += nums[i];
            }
        }
    }

    // gas optimized 
    function sum2(uint[] calldata nums) external {
        uint _total = total;
        uint len = nums.length;

        for(uint i = 0; i < len; ) {
            uint num = nums[i];

            if (num % 2 == 0 && num < 99) {
                _total += num;
            }

            unchecked {
                ++i;
            }
        }

        total = _total;
    }
}