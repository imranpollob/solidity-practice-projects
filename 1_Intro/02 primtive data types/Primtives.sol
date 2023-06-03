// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Primtives {
    bool public isActive = true;

    /*
    uint stands for unsigned integer, meaning non negative integers
    different sizes are available
        uint8   ranges from 0 to 2 ** 8 - 1
        uint16  ranges from 0 to 2 ** 16 - 1
        ...
        uint256 ranges from 0 to 2 ** 256 - 1
    */
    uint8 public u8 = 1;
    uint256 public u256 = 1243567890;
    uint public u = 1234567890987654321; // uint is an alias for uint256

    /*
    Negative numbers are allowed for int types.
    Like uint, different ranges are available from int8 to int256
    
    int256 ranges from -2 ** 255 to 2 ** 255 - 1
    int128 ranges from -2 ** 127 to 2 ** 127 - 1
    */
    int8 public i8 = -1;
    int public i256 = 456;
    int public i = -123; // int is same as int256
    
    // minimum and maximum of int
    int public maxInt = type(int).max;
    int public minInt = type(int).min;

    /*  Address: two versions:
        - address: holds 20 byte ethereum address.
                   can't receive ether
        - address payable: same as address with two additional members
                           transfer and send
                           can receive ether                   
    */
    address public recipent_address = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
    address payable public recipent;

    // Bytes: holds a sequence of bytes from one to up to 32. 
    // Ex: bytes1, bytes2, bytes3, …, bytes32
    // byte is an alias for  .
    bytes1 smallest_byte = 0xb5; //  [10110101]
    bytes32 largest_byte;
    // The term bytes represents a dynamic array of bytes. 
    // It’s a shorthand for byte[] .
    bytes array_of_bytes;

    // Default values
    // Unassigned variables have a default value
    bool public defaultBoo; // false
    uint public defaultUint; // 0
    int public defaultInt; // 0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000
}
