# Homework 19

Write a *shame coin* contract.

1. The shame coin needs to have an administrator address that is set in the 
constructor.
2. The decimal places should be set to 0.
3. The administrator can send 1 shame coin at a time to other addresses (but 
keep the transfer function signature).
4. If non administrators try to transfer their shame coin, the transfer function
will instead increase their balance by one.
5. Non administrators can approve the administrator (and only the administrator)
to spend one token on their behalf.
6. The transfer from function should just reduce the balance of the holder.
7. Write unit tests to show that the functionality is correct.
8. Document the contract with Natspec, and produce docs from this.