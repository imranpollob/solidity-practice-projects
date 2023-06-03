// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract LogicV2 {
    uint public x;
    uint public y;

    function increaseX() external {
        x += 5;
    }

    function setY(uint _y) external {
        y = _y;
    }
}