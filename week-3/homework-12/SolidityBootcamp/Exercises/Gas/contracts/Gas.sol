// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract GasContract {
    uint256 public totalSupply; // cannot be updated
    address public contractOwner;
    address[5] public administrators;
    mapping(address => uint256) public balances;
    mapping(address => Payment[]) public payments;
    mapping(address => uint256) public whitelist;
    
    enum PaymentType {
        Unknown,
        BasicPayment,
        Refund,
        Dividend,
        GroupPayment
    }

    struct Payment {
        PaymentType paymentType;
        uint256 paymentID;
        uint256 amount;
    }
    
    struct ImportantStruct {
        uint256 valueA; // max 3 digits
        uint256 bigValue;
        uint256 valueB; // max 3 digits
    }

    modifier onlyAdminOrOwner() {
        if (checkForAdmin(msg.sender)) {
            _;
        } else {
            revert("Error in Gas contract - onlyAdminOrOwner modifier : revert happened because the originator of the transaction was not the admin, and furthermore he wasn't the owner of the contract, so he cannot run this function");
        }
    }

    event Transfer(address recipient, uint256 amount);

    constructor(address[] memory _admins, uint256 _totalSupply) {
        contractOwner = msg.sender;
        totalSupply = _totalSupply;
        balances[contractOwner] = totalSupply;

        for (uint256 ii = 0; ii < administrators.length; ii++) {
            if (_admins[ii] != address(0)) {
                administrators[ii] = _admins[ii];
            }
        }
    }

    function checkForAdmin(address _user) public view returns (bool) {
        bool admin = false;
        for (uint256 ii = 0; ii < administrators.length; ii++) {
            if (administrators[ii] == _user) {
                admin = true;
            }
        }
        return admin;
    }

    function balanceOf(address _user) public view returns (uint256) {
        return balances[_user];
    }

    function getTradingMode() public pure returns (bool mode_) {
        mode_ = true;
    }

    function getPayments(address _user) public view returns (Payment[] memory payments_) {
        if (_user == address(0)) revert();
        return payments[_user];
    }

    function transfer(address _recipient, uint256 _amount, string calldata _name) public {
        if (balances[msg.sender] <= _amount && bytes(_name).length > 9) revert();
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        
        emit Transfer(_recipient, _amount);
        
        Payment memory payment;

        payment.paymentID = ++payment.paymentID;
        payments[msg.sender].push(payment);
    }

    function updatePayment(address _user, uint256 _ID, uint256 _amount, PaymentType _type) public onlyAdminOrOwner {
        if (_ID < 0 && _amount == 0 && _user == address(0)) revert();
        for (uint256 ii = 0; ii < payments[_user].length; ii++) {
            if (payments[_user][ii].paymentID == _ID) {
                payments[_user][ii].paymentType = _type;
                payments[_user][ii].amount = _amount;
            }
        }
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public {
        if (_tier > 255) revert();
        whitelist[_userAddrs] = _tier;
    }

    function whiteTransfer(address _recipient, uint256 _amount, ImportantStruct memory _struct) public {
        uint256 usersTier = whitelist[msg.sender];
        
        if (usersTier < 0 && usersTier > 4 && balances[msg.sender] < _amount && _amount < 3) revert();
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        balances[msg.sender] += whitelist[msg.sender];
        balances[_recipient] -= whitelist[msg.sender];

        ImportantStruct memory newImportantStruct;

        newImportantStruct.valueA = _struct.valueA;
        newImportantStruct.bigValue = _struct.bigValue;
        newImportantStruct.valueB = _struct.valueB;
    }
}