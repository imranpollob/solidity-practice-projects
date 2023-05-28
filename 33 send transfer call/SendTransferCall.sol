//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;


contract Sender {
    receive() external payable {}
    // send has limited supply of 2300 gas
    // doesn't revert even if nothing is sent
    // need to use require to revert
    function withdrawSend(address payable _to) public {
        bool success = _to.send(10);
        // require(success);
    }
    // transfer has limited supply of 2300 gas
    // automatically reverts
    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);
    }
    // call usage all available gas
    // need to use require to revert
    function withdrawCall(address payable _to) public {
        (bool success, ) = _to.call{value: 10, gas: 1000}("");
        // require(success);
    }
}

contract ReceiverNoAction {
    // this function will be passed by send, transfer and call
    // because it completable with 2300 gas limit
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {}
}

contract ReceiverAction {
    uint public balanceReceived;
    // this function will be passed call only
    // because of high gas required due to state variable chnage 
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {
        balanceReceived += msg.value;
    }
}