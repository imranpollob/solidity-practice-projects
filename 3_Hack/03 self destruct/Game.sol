// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
Don't rely on address(this).balance
*/

contract Game {
    uint public winPoint = 7 ether;
    uint public balance;

    function deposite() public payable {
        require(msg.value  == 1 ether, "Send exactly 1 ether");

        balance++;
        require(balance <= winPoint, "Game Over");

        if (balance == winPoint) {
            (bool success, ) = msg.sender.call{ value: balance }("");
            require(success, "Transaction failed");
            balance = 0;
        }
    }
}

contract Attack {
    Game game;

    constructor(address _address) {
        game = Game(_address);
    }

    function attack() public payable {
        selfdestruct(payable(address(game)));
    }
}