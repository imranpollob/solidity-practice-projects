// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

error Lottery__NotEnoughETHEntered();

contract Lottery is VRFConsumerBaseV2 {
    uint private immutable i_entranceFee;
    address payable[] private s_players; 

    event LotteryEnter(address indexed player);

    constructor(address _vrfCoordinator, uint _entranceFee) VRFConsumerBaseV2(_vrfCoordinator) {
        i_entranceFee = _entranceFee;
    }

    function enterLottery() public payable {
        // require(msg.value < i_entranceFee, "Not enough ETH!");
        if (msg.value < i_entranceFee) revert Lottery__NotEnoughETHEntered();
        s_players.push(payable(msg.sender));
        emit LotteryEnter(msg.sender);
    }

    function pickRandomWinner() private view {

    }

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
        
    }

    function getEntranceFee() public view returns(uint) {
        return i_entranceFee;
    }

    function getPlayer(uint _index) public view returns(address) {
        return s_players[_index];
    }
    
}