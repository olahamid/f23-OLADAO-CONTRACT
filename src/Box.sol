//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
/**
 * @title A simple F23-DAO contract for maintaining ownership
 * @author ola hamid
 * @notice This contract is for creating a sample DAO
 * @dev  establishing a dao governed cotract controlled my this author
 */

import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract Box is Ownable {
    uint256 private s_number;

    event e_setNumber(uint256 number);

    constructor(address initialOwner) Ownable(initialOwner) {
        //    initialOwner = msg.sender;
    }

    function store(uint256 _number) public onlyOwner {
        s_number = _number;
        emit e_setNumber(_number);
    }

    function getNumber() public view returns (uint256) {
        return s_number;
    }

    function transferOwnership(address newOwner) public override onlyOwner {}
}
