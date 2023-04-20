// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Caller {
    uint public x;
    address public callee;

    function setCallee(address _callee) external {
        callee = _callee;
    }

    function callSetX(uint _x) external {
        (bool success, ) = callee.call(abi.encodeWithSignature("setX(uint256)", _x));
        require(success, "Call failed");
    }

    function delegateCallSetX(uint _x) external {
        (bool success, ) = callee.delegatecall(abi.encodeWithSignature("setX(uint256)", _x));
        require(success, "Delegate call failed");
    }
}