// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// Libraries are similar to contracts, but you can't declare any state variable and you can't send ether.
// Library is like a file consists of helper functions
// learn library vs interface vs abstract contract
library PriceConverter {
    // A library is embedded into the contract if all library functions are internal.
    // Otherwise the library must be deployed and then linked before the contract is deployed.
    function getPrice() internal view returns (uint256) {
        // sepolia price feed: ETH -> USD
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int answer, , , ) = dataFeed.latestRoundData();
        return uint256(answeer * 1e10);
    }
}
