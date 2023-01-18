// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./UniversityDiplomas.sol";

contract University {
    event AdminAdded(address indexed _newAdmin, address _by);
    event AdminDeleted(address indexed _oldAdmin, address _by);
    event StudentETHAddressStored(bytes32 indexed _student, address _by);

    mapping(address => bool) public admins;
    mapping(bytes32 => address) private students;

    UniversityDiplomas public universityDiplomas;

    constructor (string memory name, string memory symbol, address[] memory _initialAdmins) {
        for (uint i = 0; i < _initialAdmins.length; i++) {
            admins[_initialAdmins[i]] = true;
        }
        universityDiplomas = new UniversityDiplomas(name, symbol);
    }

    modifier onlyAdmin (address _user) {
        require(admins[_user], "You need to be an admin to perform the following operation!");
        _;
    }

    function addAdmin (address _newAdmin) external onlyAdmin(msg.sender) {
        admins[_newAdmin] = true;
        emit AdminAdded(_newAdmin, msg.sender);
    }

    function deleteAdmin (address _oldAdmin) external onlyAdmin(msg.sender) {
        require(admins[_oldAdmin], "Specified address is not a valid admin!");
        admins[_oldAdmin] = false;
        emit AdminDeleted(_oldAdmin, msg.sender);
    }

    function storeStudentETHAddress (address _student, bytes32 _encrCNP) external onlyAdmin(msg.sender) {
        students[_encrCNP] = _student;
        emit StudentETHAddressStored(_encrCNP, msg.sender);
    }

    function mintDiplomaFor(bytes32 encrCNP, UniversityDiplomas.DiplomaMetadata memory metadata) external onlyAdmin(msg.sender) {
        universityDiplomas.mintDiploma(students[encrCNP], metadata);
    }

    function getDiplomasOf(bytes32 encrCNP) external view returns (UniversityDiplomas.DiplomaMetadata[] memory) {
        return universityDiplomas.diplomasOwnedBy(students[encrCNP]);
    }
}