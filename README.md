                                              LoanContract
    
This is a  Solidity-based smart contract for issuing and repaying loans. It allows an owner to issue loans with an interest rate, track the amount due, and handle repayments from borrowers. The contract also allows borrowers to view their loan details and outstanding balance.

Features
.Issue Loans: The owner can issue loans to borrowers with a predefined interest rate.
.Repay Loans: Borrowers can repay their loans before the due date. The contract keeps track of the amount paid and the remaining balance.
.View Loan Details: Borrowers can view the details of their loan, including the principal amount, interest rate, total due amount, and amount paid so far.
.Outstanding Balance: Borrowers can check their remaining balance to repay.

Smart Contract Overview

Loan Struct

The Loan struct represents the details of a loan:
.amount: The principal amount of the loan.
.interestRate: The interest rate for the loan in percentage.
.dueAmount: The total amount due, including the principal and interest.
.dueDate: The due date for repayment, set to 30 days from issuance.
.amountPaid: The amount repaid by the borrower.

Functions
.issueLoan(address borrower, uint256 loanAmount):

.Issues a loan to the borrower with a predefined interest rate of 8%. The total amount due is calculated based on the loan amount and interest rate.
.Only the contract owner can call this function.
.repayLoan(uint256 amount):

.Allows the borrower to repay the loan in installments.
.Ensures the repayment does not exceed the outstanding amount.
.Emits an event each time a repayment is made.
.getOutstandingBalance():

Returns the remaining amount that the borrower needs to repay.
.getLoanDetails(address borrower):

.Retrieves the full loan details (amount, interest rate, total due, amount paid, and due date) for a specific borrower.
Events
.LoanIssued(address borrower, uint256 amount, uint256 interestRate, uint256 dueAmount):

Emitted when a loan is issued to a borrower.
.LoanRepaid(address borrower, uint256 amountPaid, uint256 remainingAmount):

Emitted when a borrower repays a portion of the loan.

Frontend Integration
.To interact with this smart contract from a frontend, you will need the following:

Prerequisites
.Ethereum wallet: Use a wallet like MetaMask to interact with the Ethereum network.
.Web3.js or Ethers.js: These JavaScript libraries will allow the frontend to communicate with the smart contract.

 Frontend Features
.Issue Loan: The frontend will allow the owner to input a borrower's address and a loan amount to issue a loan.
.Repay Loan: Borrowers can input the amount they wish to repay, and the frontend will interact with the repayLoan function.
.View Loan Details: Borrowers can check their loan details, including the principal, interest rate, due amount, and amount paid.
.Check Outstanding Balance: Borrowers can view how much is left to repay


## Contributing:

Contributions are welcome! Please open an issue to discuss proposed changes or submit a pull request.
