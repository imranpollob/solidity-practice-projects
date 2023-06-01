// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "forge-std/Test.sol";
import "../src/Multisig.sol";

contract MultisigTest is Test {
    Multisig multisig;
    address[] owners = [address(1), address(2), address(3)];

    function setUp() public {
        multisig = new Multisig(owners, 2);
    }

    function test_constructor() public {
        assertReve
    }

    function test_deposit() public {
        uint amount = 1 ether;
        (bool s,) = address(multisig).call{value: amount}("");
        require(s);
        assertEq(address(multisig).balance, amount);
    }

}
