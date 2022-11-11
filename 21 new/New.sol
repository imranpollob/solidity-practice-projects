// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
Contracts can be created by other contracts using the new keyword. 
Since 0.8.0, new keyword supports create2 feature by specifying salt options.
*/

contract Car {
    string public model;
    address public carAddress;

    constructor(string memory _model) payable {
        model = _model;
        carAddress = address(this);
    }
}

contract CarFactory {
    Car[] public cars;

    function create(string memory _model) public {
        Car car = new Car(_model);
        cars.push(car);
    }
    
    function createAndSendEther(string memory _model) public payable {
        Car car = (new Car){ value: msg.value }(_model);
        cars.push(car);
    }
}