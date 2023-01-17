// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UniversityDiplomas.sol";

contract University {
    mapping(address => bool) public admins;
    mapping(bytes32 => address) private students;

    UniversityDiplomas public universityDiplomas;

    constructor (address[] memory _initialAdmins) {
        for (uint i = 0; i < _initialAdmins.length; i++) {
            admins[_initialAdmins[i]] = true;
        }
        universityDiplomas = new UniversityDiplomas();
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

    function storeStudentETHAddress (address _student, bytes32 _encrCNP) external onlyAdmin(msg.sender) {
        students[_encrCNP] = _student;
    }

    function mintDiplomaFor(bytes32 _encrCNP) external onlyAdmin(msg.sender) {

    }

    function getDiplomasOf(bytes32 _encrCNP) external {

    }
}