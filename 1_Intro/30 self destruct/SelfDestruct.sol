// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// using selfdestruct we can forcefully send eth to Bot
contract Bot {
    
}

contract Bomb {
    receive() external payable { }

    function blast(address addr) public {
        selfdestruct(payable (addr));
    }
}