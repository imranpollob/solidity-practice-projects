// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract BuyMeACoffee {
    event NewEntry(
        address indexed from,
        uint timestamp,
        string message
    );

    struct Entry {
        address from;
        uint timestamp;
        string message;
    }

    Entry[] public entries;

    address immutable public owner;

    constructor() {
        owner = msg.sender;
    }

    function getEntries() public view returns (Entry[] memory) {
        return entries;
    }

    function buyACoffee(string memory _msg) public payable  {
        require(msg.value > 0, "Can't buy coffee for free!");
        entries.push(Entry(msg.sender, block.timestamp, _msg));
        emit NewEntry(msg.sender, block.timestamp, _msg);
    }

    function withdraw(uint _amount) public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(address(this).balance >= _amount, "Withdrawal overlimit");
        (bool success, ) = payable(owner).call{ value: _amount }("");
        require(success, "Transaction failed");
    }

}