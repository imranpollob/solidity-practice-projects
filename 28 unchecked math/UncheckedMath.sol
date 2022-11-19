// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
Overflow and underflow of numbers in Solidity 0.8 throw an error. This can be disabled by using unchecked.
Disabling overflow / underflow check saves gas.
*/

contract UncheckedMath {
    function add(uint x, uint y) external pure returns (uint) {
        // 22291 gas
        // return x + y;

        // 22103 gas
        unchecked {
            return x + y;
        }
    }

    function sub(uint x, uint y) external pure returns (uint) {
        // 22329 gas
        // return x - y;

        // 22147 gas
        unchecked {
            return x - y;
        }
    }
}