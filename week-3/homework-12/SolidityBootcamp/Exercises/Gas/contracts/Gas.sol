// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract GasContract {
    uint256 public totalSupply; // cannot be updated
    address contractOwner;
    address[5] public administrators;
    mapping(address => uint256) balances;
    mapping(address => Payment[]) payments;
    mapping(address => uint256) public whitelist;

    struct Payment {
        uint256 paymentType;
        uint256 paymentID;
        uint256 amount;
    }
    
    struct ImportantStruct {
        uint256 bigValue;
    }

    modifier onlyAdminOrOwner() {
        if (checkForAdmin(msg.sender)) {
            _;
        } else {
            revert();
        }
    }

    event Transfer(address recipient, uint256 amount);

    constructor(address[] memory _admins, uint256 _totalSupply) {
        contractOwner = msg.sender;
        totalSupply = _totalSupply;
        balances[contractOwner] = totalSupply;

        for (uint256 ii = 0; ii < administrators.length; ii++) {
            administrators[ii] = _admins[ii];            
        }
    }

    function checkForAdmin(address _user) public view returns (bool admin) {
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
        return payments[_user];
    }

    function transfer(address _recipient, uint256 _amount, string calldata _name) public {
        if (bytes(_name).length > 9) revert();
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        
        Payment memory payment;

        payment.paymentID = ++payment.paymentID;
        payments[msg.sender].push(payment);

        emit Transfer(_recipient, _amount);
    }

    function updatePayment(address _user, uint256 _ID, uint256 _amount, uint256 _type) public onlyAdminOrOwner {
        for (uint256 ii = 0; ii < payments[_user].length; ii++) {
            payments[_user][ii].paymentID == _ID;
            payments[_user][ii].paymentType = _type;
            payments[_user][ii].amount = _amount;
        }
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public {
        whitelist[_userAddrs] = _tier;
    }

    function whiteTransfer(address _recipient, uint256 _amount, ImportantStruct calldata _struct) public {
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        balances[msg.sender] += whitelist[msg.sender];
        balances[_recipient] -= whitelist[msg.sender];

        ImportantStruct memory newImportantStruct;

        newImportantStruct.bigValue = _struct.bigValue;
    }
}