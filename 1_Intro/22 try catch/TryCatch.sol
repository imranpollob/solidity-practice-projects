// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Test {
    function willFail() public pure {
        require(false, "It's failing");
    }
}

contract TryCatchError {
    event Log(string _msg);

    function test(address _address) external {
        Test t = Test(_address);
            try t.willFail() {
        } catch Error(string memory _msg) {
            emit Log(_msg);
        }
    }
}
