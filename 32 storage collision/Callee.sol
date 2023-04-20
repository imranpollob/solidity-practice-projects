// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Callee {
    uint public x;

    function setX(uint _x) external {
        x = _x;
    }
}