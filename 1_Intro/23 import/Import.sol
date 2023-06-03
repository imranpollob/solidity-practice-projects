// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Foo.sol";
import { Unauthorized, add as ex_add, Point } from "./Foo.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol";


contract Import {
    Foo public foo = new Foo();

    function getFooName() view public returns (string memory) {
        return foo.name();
    }

    function call_ex_add(uint a, uint b) pure public returns (uint) {
        return ex_add(a, b);
    }
}