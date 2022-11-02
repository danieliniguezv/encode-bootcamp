# Homework 7

## Adding more functionality to the Volcano Coin Contract

1. Write a function to view the payment records, specifying the user as an input.

What is the difference between doing this and making the mapping public?

2. For the payments record mapping, create a function called recordPayment that 
takes:

	1. The sender's address,
	2. The receiver's address, and
	3. The amount

	as an input, then creates a new payment record and adds the new record to the 
	user's payment record.

3. Each time we make a transfer of tokens, we should call the recordPayment 
function to record the transfer.
