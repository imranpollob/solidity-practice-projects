// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// abi.encode encodes data into bytes.

interface IERC20 {
    function transfer(address, uint) external;
}

contract Token {
    function transfer(address, uint) external {}
}

contract AbiEncode {
    function test(address _contract, bytes calldata _data) external {
        (bool success, ) = _contract.call(_data);
        require(success, "Call failed");
    }

    function encodeWithSignature(address to, uint amount) pure external returns (bytes memory) {
        // Type is not checked
        return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
    }

    function encodeWithSelector(address to, uint amount) pure external returns (bytes memory) {
        // Type is not checked
        return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
    }

    function encodeCall(address to, uint amount) pure external returns (bytes memory) {
        // Type and typo errors will not compile
        return abi.encodeCall(IERC20.transfer, (to, amount));
    }
}