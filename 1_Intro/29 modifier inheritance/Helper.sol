// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Helper {
    modifier notZero() {
        require(msg.value > 0, "Zero not allowed");
        _;
    }
}