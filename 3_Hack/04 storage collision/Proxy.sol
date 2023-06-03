// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Proxy {
    uint public x;
    address public owner;
    address public logicContract;

    constructor(address _addr) {
        logicContract = _addr;
        owner = msg.sender;
    }

    function upgrade(address _addr) external {
        require(msg.sender == owner, "Access denied");
        logicContract = _addr;
    }

    fallback() external payable {
        (bool success, ) = logicContract.delegatecall(msg.data);
        require(success, "Unexpected error");
    }

    function delegateCallToIncreaseX() external {
        (bool success, ) = logicContract.delegatecall(abi.encodeWithSignature("increaseX()"));
        require(success, "Unexpected error");
    }

    function delegateCallToSetY(uint _y) external {
        (bool success, ) = logicContract.delegatecall(abi.encodeWithSignature("setY(uint256)", _y));
        require(success, "Unexpected error");
    }
}