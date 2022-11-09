// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Event {
    event Log(address indexed sender, string message);
    event AnotherLog(string message);

    function test() public {
        emit Log(msg.sender, "Hi");
        emit Log(msg.sender, "Hello");
        emit AnotherLog("A message");
        emit AnotherLog("Another message");
    }
}