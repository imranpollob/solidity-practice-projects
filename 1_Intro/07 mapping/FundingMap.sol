// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 

error Unsufficient_Fund();

contract FundingMap {
    mapping (address => uint) public funds;

    receive() external payable {
        funds[msg.sender] += msg.value;
    }

    function withdrawAll() external payable  {
        require(funds[msg.sender] != 0, "No fund found");
        uint amount = funds[msg.sender];
        funds[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    function withdraw(uint _amount) external payable {
        if (_amount > funds[msg.sender]) revert Unsufficient_Fund();
        funds[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }
}