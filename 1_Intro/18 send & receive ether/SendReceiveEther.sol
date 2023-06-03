// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
You can send Ether to other contracts by
- transfer (2300 gas, throws error)
- send (2300 gas, returns bool)
- call (forward all gas or set gas, returns bool)

A contract receiving Ether must have at least one of the functions below
- receive() external payable
- fallback() external payable
receive() is called if msg.data is empty, otherwise fallback() is called.
fallback() is also executed when a function that does not exist is called

Which method should you use?
call in combination with re-entrancy guard is the recommended method to use after December 2019.

Guard against re-entrancy by
- making all state changes before calling other contracts
- using re-entrancy guard modifier
*/

contract ReceiveEther {
    /*
        Which function is called, fallback() or receive()?

            send Ether
                |
            msg.data is empty?
                / \
                yes  no
                /     \
    receive() exists?  fallback()
            /   \
            yes   no
            /      \
        receive()   fallback()
    */

    // called when is msg.data empty
    receive() external payable {}

    // called when is msg.data not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}


contract SendEther {
     function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}

