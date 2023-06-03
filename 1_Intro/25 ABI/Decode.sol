// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// abi.decode decodes bytes back to data

contract AbiDecode {
    struct MyStruct {
        string name;
        uint[2] nums;
    }

    // 123,0x1c91347f2A44538ce62453BEBd9Aa907C662b4bD,[1,2,3],["asdf",[23,25]]
    function encode(
        uint x, 
        address addr, 
        uint[] calldata arr, 
        MyStruct calldata myStruct
    ) pure external returns (bytes memory) {
        return abi.encode(x, addr, arr, myStruct);
    }

    function decode(bytes calldata data) pure external returns (
        uint x, 
        address addr, 
        uint[] memory arr, 
        MyStruct memory myStruct
    ) {
        (x, addr, arr, myStruct) = abi.decode(data, (uint, address, uint[], MyStruct));
    }
}