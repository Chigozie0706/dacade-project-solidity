// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
import "@openzeppelin/contracts/utils/Strings.sol";

contract DecVouch{

    // Ceating a struct to store voucher details.
    struct VoucherDetails {
        address owner;
        string voucherDescription;
        uint amount;
        uint rate;
        uint date;
        string voucherCode;
        bool redeemedStatus;
    }

    
    VoucherDetails[] private vouchers;
    

    // Function to create a voucherCode  using the openzepplin library
    function generateVoucherCode() private view  returns (string memory) {
        uint randomNumber = uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp))) % 1000;
        return string(abi.encodePacked(Strings.toString(randomNumber), "DV!"));   
    }

    
    // Function to create  a voucher.
    function createVoucher(string memory _voucherDescription, uint _amount, uint _rate) public {
        vouchers.push(VoucherDetails({owner: msg.sender, voucherDescription: _voucherDescription, amount: _amount, 
        rate: _rate, date: block.timestamp, voucherCode: generateVoucherCode(), redeemedStatus : false}));
    }


    // Function to get the records of all vouchers created.
    function getVouchers() public view returns (VoucherDetails[] memory) {
        return vouchers;
    }

    // Function to get current TimeStamp.
    function getCurrentTimeStamp () private view returns(uint) {
        return block.timestamp;
    }
    
    // Function to delete an expired voucher created after 30 minutes from the voucher list.
    function deleteExpiredVouchers () public  { 
        uint v = vouchers.length;
        for (uint i = 0; i < v; i++) {
        if(getCurrentTimeStamp() > vouchers[i].date + 30 minutes){
             delete vouchers[i];
            }
        }
    }


    // Function to redeem  a voucher.
    function redeemVoucher (uint _index) public {
        vouchers[_index].redeemedStatus = vouchers[_index].redeemedStatus = true; 
    }

    
    // Function to get a voucher record through it's index.
    function getIndividualVoucherDetails(uint _index) public view returns(VoucherDetails memory)
    {
        return vouchers[_index];
    }



}