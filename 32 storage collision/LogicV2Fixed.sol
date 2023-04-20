// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract LogicV2Fixed {
    uint public x;
    address public owner;
    address public logicContract;
    uint public y;

    function increaseX() external {
        x += 5;
    }

    function setY(uint _y) external {
        y = _y;
    }
}