// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Ownable.sol";
import "./Helper.sol";

contract SimpleToken is Ownable, Helper {
    mapping (address => uint) public tokenBalance;
    uint tokenPrice = 100 wei;

    constructor() {
        tokenBalance[owner] = 100;
    }

    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }

    function purchaseToken() public payable notZero {
        // think about it
        require(tokenBalance[owner] * tokenPrice > msg.value, "Not enough balance");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

    // This calculation is related to token.
    // So, msg.value is not involved and not payable
    function sendToken(address _to, uint amount) public {
        require(tokenBalance[msg.sender] > amount, "Not enough token");
        // safemath
        assert(tokenBalance[_to] + amount > tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - amount < tokenBalance[msg.sender]);
        tokenBalance[msg.sender] -= amount;
        tokenBalance[_to] += amount;
    }

}