// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

error Zero_Not_Acceptable(uint _money);

contract BankStruct {
    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numOfDeposits;
        mapping (uint => Transaction) deposits;
        uint numOfWithdrawals;
        mapping (uint => Transaction) withdrawals;
    }

    mapping (address => Balance) balanceReceived;

    function getBalance(address _address) external view returns (uint) {
        return balanceReceived[_address].totalBalance;
    }

    function deposite() external payable {
        if(msg.value < 1) revert Zero_Not_Acceptable(msg.value);
        balanceReceived[msg.sender].totalBalance += msg.value;
        balanceReceived[msg.sender].deposits[balanceReceived[msg.sender].numOfDeposits] = Transaction(
            msg.value, block.timestamp
        );
        balanceReceived[msg.sender].numOfDeposits++;
    }

    function withdrawal(uint _amount) external payable {
        if(_amount < 1) revert Zero_Not_Acceptable(_amount);
        balanceReceived[msg.sender].totalBalance -= _amount;
        Transaction memory trx = Transaction(_amount, block.timestamp);
        balanceReceived[msg.sender].withdrawals[balanceReceived[msg.sender].numOfWithdrawals] = trx;
        balanceReceived[msg.sender].numOfWithdrawals++;
        payable(msg.sender).transfer(_amount);
    }
}