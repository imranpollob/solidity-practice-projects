// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
A constructor is an optional function that is executed upon contract creation.
Here are examples of how to pass arguments to constructors.
*/

// Base contract X
contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

// Base contract Y
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}


// There are 2 ways to initialize parent contract with parameters.
// 1. Pass the parameters here in the inheritance list.
contract A is X("-X-"), Y("_Y_") {

}
// 2. Pass the parameters here in the constructor,
// similar to function modifiers.
contract B is X, Y {
    constructor(string memory _a, string memory _b) X(_a) Y(_b) {}
}

// Parent constructors are always called in the order of inheritance
// regardless of the order of parent contracts listed in the
// constructor of the child contract.

// Order of constructors called:
// 1. X
// 2. Y
// 3. C
contract C is X, Y {
    constructor() X("-X-") Y("_Y_"){}
}

// Order of constructors called:
// 1. X
// 2. Y
// 3. D
contract D is X, Y {
    constructor() Y("Y was called") X("X was called") {}
}