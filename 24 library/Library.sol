// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/* 
Libraries are similar to contracs except
- can't declare any state variable
- can't send / receive ether

A library is embeded into the contract if all library function are internal.
Otherwise the library must be deployed and then linked before the contract is deployed.
*/

library Math {
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            
            uint x = y / 2 + 1;

            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
        // else z = 0 (default value)
    }
}

contract TestMath {
    function testSquareRoot(uint x) pure public returns (uint) {
        return Math.sqrt(x);
    }
}

library Array {
    function remove(uint[] storage arr, uint index) public {
        require(arr.length > 0, "Can't remove from empty array");
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
}

contract TestArray {
    using Array for uint[];

    uint[] public arr;

    function testArrayRemove() public {
        for (uint i = 0; i < 3; i++) {
            arr.push(i);
        }

        arr.remove(1);

        assert(arr.length == 2);
        assert(arr[0] == 0);
        assert(arr[1] == 2);
}
