// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/**
Multisig requires multiple signatures or approvals to authorize a transaction.
In our program there will be 5 owners
If 3 owners approve a transaction then the transaction can be executed
Notes:
1. The wallet can receive ether from any source
2. Only owners can create a transaction request
3. Transaction request should be approved by specific number of owners.
   Say the number is 3.
4. If a transaction is approved by 3 then it can be executed
5. Owner can revoke the approval, before execution 
**/
contract Multisig {
    event TransactionCreated(
        address indexed _owner,
        uint256 indexed _transactionId
    );
    event TransactionApproved(
        address indexed _owner,
        uint256 indexed _transactionId
    );
    event TransactionApprovalRevoked(
        address indexed _owner,
        uint256 indexed _transactionId
    );
    event TransactionExecuted(
        address indexed _owner,
        uint256 indexed _transactionId
    );

    mapping(address => bool) public owners;
    uint256 public immutable totalApprovalRequired;
    struct Transaction {
        address to;
        uint256 amount;
        uint256 numOfApprovals;
        bool isExecuted;
    }
    Transaction[] public transactions;
    mapping(uint256 => mapping(address => bool)) public transactionApprovals;

    modifier OwnerOnly() {
        require(owners[msg.sender], "Not an owner");
        _;
    }
    modifier TrxExists(uint256 _trxId) {
        require(_trxId < transactions.length, "Invalid transaction ID");
        _;
    }
    modifier NotExecuted(uint256 _trxId) {
        require(
            !transactions[_trxId].isExecuted,
            "Transaction already executed"
        );
        _;
    }

    constructor(address[] memory _owners, uint256 _totalApprovalRequired) {
        require(
            _totalApprovalRequired > 0,
            "totalApprovalRequired shoudn't be 0"
        );
        require(_owners.length > 0, "Owners required");
        totalApprovalRequired = _totalApprovalRequired;
        for (uint256 i = 0; i < _owners.length; i++) {
            address _addr = _owners[i];
            require(owners[_addr] == false);
            owners[_addr] = true;
        }
    }

    function createTransaction(address payable _address, uint256 _amount)
        external
        OwnerOnly
    {
        uint256 _trxId = transactions.length;
        Transaction memory _trx = Transaction({
            to: _address,
            amount: _amount,
            numOfApprovals: 0,
            isExecuted: false
        });
        transactions.push(_trx);
        emit TransactionCreated(msg.sender, _trxId);
    }

    function approveTransaction(uint256 _trxId)
        external
        OwnerOnly
        TrxExists(_trxId)
        NotExecuted(_trxId)
    {
        require(
            !transactionApprovals[_trxId][msg.sender],
            "Transaction already approved"
        );
        transactionApprovals[_trxId][msg.sender] = true;
        transactions[_trxId].numOfApprovals++;
        emit TransactionApproved(msg.sender, _trxId);
    }

    function revokeApproval(uint256 _trxId)
        external
        OwnerOnly
        TrxExists(_trxId)
        NotExecuted(_trxId)
    {
        require(
            transactionApprovals[_trxId][msg.sender],
            "Transaction not approved previously"
        );
        transactionApprovals[_trxId][msg.sender] = false;
        transactions[_trxId].numOfApprovals--;
        emit TransactionApprovalRevoked(msg.sender, _trxId);
    }

    function executeTransaction(uint256 _trxId)
        external
        OwnerOnly
        TrxExists(_trxId)
        NotExecuted(_trxId)
    {
        Transaction storage transaction = transactions[_trxId];
        require(
            transaction.numOfApprovals >= totalApprovalRequired,
            "Need more approvals"
        );
        require(
            address(this).balance >= transaction.amount,
            "Insuffucuent balance"
        );
        transaction.isExecuted = true;
        (bool success, ) = payable(transaction.to).call{
            value: transaction.amount
        }("");
        require(success, "Transaction failed");
        emit TransactionExecuted(msg.sender, _trxId);
    }

    receive() external payable {}
}
