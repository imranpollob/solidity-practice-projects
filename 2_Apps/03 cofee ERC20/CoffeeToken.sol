// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Coffea is ERC20, Ownable {
    constructor() ERC20("Coffea", "CFE") {
        _mint(msg.sender, 10);
    }

    event CoffeeSold(address indexed addr, uint amount);
    event CoffeeTokenCreated(address indexed addr, uint amount);

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        emit CoffeeTokenCreated(to, amount);
    }

    function giveOneCoffeeToken(address addr) public {
        transfer(addr, 1);
    }

    function allowOneCoffeeToken(address addr) public {
        increaseAllowance(addr, 1);
    }

    function buyOneCoffee() public {
        _burn(msg.sender, 1);
        emit CoffeeSold(msg.sender, 1);
    }

    function buyOneCoffeeVia(address addr) public {
        _spendAllowance(addr, msg.sender, 1);
        _burn(addr, 1);
        emit CoffeeSold(addr, 1);
    }
}