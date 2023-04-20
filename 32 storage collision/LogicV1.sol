// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract LogicV1 {
    uint public x;

    function increaseX() external {
        x++;
    }
}