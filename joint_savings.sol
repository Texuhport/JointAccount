pragma solidity ^0.5.7;

// Define a new contract named `JointSavings`
contract JointSavings {address payable public accountOne;
    address payable public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;
    
    function withdraw(uint amount, address payable recipient) public {

        /*
        Require that the recipient is either accountOne or accountTwo
        */
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        /*
        Require that the contract has adequate funds
         */
        require(contractBalance >= amount, "Insufficient funds!");

        // If lastToWithdraw is not equal to recipient, set it to the current value of recipient
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Transfer funds to the recipient
        recipient.transfer(amount);

        // Set lastWithdrawAmount equal to amount
        lastWithdrawAmount = amount;

        // Update contractBalance variable to reflect the new balance of the contract
        contractBalance = address(this).balance;
    }

    // Define a `public payable` function named `deposit`.
    function deposit() public payable {
        // Update contractBalance variable to reflect the new balance of the contract
        contractBalance = address(this).balance;
    }
    

    /*
    Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    */
    function setAccounts(address payable account1, address payable account2) public{

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
        accountOne = account1;
        accountTwo = account2;
    }

    /*
    Finally, add the **default fallback function** so that your contract can store Ether sent from outside the deposit function.
    */
    function() external payable {
        contractBalance = address(this).balance;
    }
}