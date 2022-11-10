// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
call is a low level function to interact with other contracts.

This is the recommended method to use when you're just sending Ether via calling the fallback function.

However it is not the recommend way to call existing functions.
*/

contract Call {
    event EtherReceived(address indexed calledId, uint amount, string message);

    fallback() external payable {
        emit EtherReceived(msg.sender, msg.value, "Fallback was called");
    }

    function foo(string memory _message, uint _x) external payable  returns (uint) {
        emit EtherReceived(msg.sender, msg.value, _message);
        return _x + 1;
    }
}

contract Caller {
    event Response(bool success, bytes data);

    // Let's imagine that contract Caller does not have the source code for the
    // contract Receiver, but we do know the address of contract Receiver and the function to call
    function callingFoo(address payable _addr, string memory _str) payable public {
        (bool success, bytes memory data) = _addr.call{ value: msg.value }(
            abi.encodeWithSignature("foo(string,uint256)", _str, 123)
        );
        require(success, "Transaction failed");
        emit Response(success, data);
    }

    // Calling a function that does not exist triggers the fallback function.
    function calling(address payable _addr) public {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("doesNotExist()")
        );
        require(success, "Transaction failed");
        emit Response(success, data);
    }
}