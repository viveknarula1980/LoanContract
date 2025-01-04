// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoanContract {

    struct Loan {
        uint256 amount;
        uint256 interestRate;
        uint256 dueAmount;
        uint256 dueDate;
        uint256 amountPaid;
    }

    mapping(address => Loan) public loans;
    address public owner;

    event LoanIssued(address borrower, uint256 amount, uint256 interestRate, uint256 dueAmount);
    event LoanRepaid(address borrower, uint256 amountPaid, uint256 remainingAmount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can issue loans.");
        _;
    }

    function issueLoan(address borrower, uint256 loanAmount) external onlyOwner {
        uint256 interestRate = 8; // 8% interest rate
        uint256 interestAmount = (loanAmount * interestRate) / 100;
        uint256 totalDueAmount = loanAmount + interestAmount;

        Loan storage loan = loans[borrower];
        loan.amount = loanAmount;
        loan.interestRate = interestRate;
        loan.dueAmount = totalDueAmount;
        loan.dueDate = block.timestamp + 30 days;

        emit LoanIssued(borrower, loanAmount, interestRate, totalDueAmount);
    }

    function repayLoan(uint256 amount) external payable {
        Loan storage loan = loans[msg.sender];
        require(loan.amount > 0, "No loan found.");
        require(block.timestamp <= loan.dueDate, "Loan repayment period has expired.");

        uint256 remainingAmount = loan.dueAmount - loan.amountPaid;
        require(amount <= remainingAmount, "Repayment exceeds the amount due.");

        loan.amountPaid += amount;

        emit LoanRepaid(msg.sender, amount, loan.dueAmount - loan.amountPaid);
    }

    function getOutstandingBalance() external view returns (uint256) {
        Loan storage loan = loans[msg.sender];
        require(loan.amount > 0, "No loan found.");
        return loan.dueAmount - loan.amountPaid;
    }

    function getLoanDetails(address borrower) external view returns (uint256 amount, uint256 interestRate, uint256 dueAmount, uint256 amountPaid, uint256 dueDate) {
        Loan storage loan = loans[borrower];
        return (loan.amount, loan.interestRate, loan.dueAmount, loan.amountPaid, loan.dueDate);
    }
}
