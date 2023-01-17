// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./University.sol";

contract DGree {
    mapping(address => bool) public admins;
    mapping(uint => University) public universities;

    constructor (address[] memory _initialAdmins) {
        for (uint i = 0; i < _initialAdmins.length; i++) {
            admins[_initialAdmins[i]] = true;
        }
    }

    modifier onlyAdmin (address _user) {
        require(admins[_user], "You need to be an admin to perform the following operation!");
        _;
    }

    function addAdmin (address _newAdmin) external onlyAdmin(msg.sender) {
        admins[_newAdmin] = true;
    }

    function deleteAdmin (address _oldAdmin) external onlyAdmin(msg.sender) {
        require(admins[_oldAdmin], "Specified address is not a valid admin!");
        admins[_oldAdmin] = false;
    }

    function addUniversity(
        uint code,
        string memory name,
        string memory symbol,
        address[] memory initialAdmins
    ) external onlyAdmin(msg.sender) {
        University university = new University(name, symbol, initialAdmins);
        universities[code] = university;
    }
}