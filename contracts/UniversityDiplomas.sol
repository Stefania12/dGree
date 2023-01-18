// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract UniversityDiplomas is Ownable, ERC721 {
    event DiplomaMinted(address indexed _student, address _by);

    using Counters for Counters.Counter;

    struct DiplomaMetadata {
        string educationLevel;
        string degree;
        string field;
        bytes32 encodedCNP;
        string URI;
    }

    Counters.Counter private _tokenID;
    mapping(uint256 => DiplomaMetadata) private _metadata;
    mapping(address => uint256[]) private _ownedTokens;

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

    function mintDiploma(address to, DiplomaMetadata calldata metadata) public onlyOwner {
        uint256 id = _tokenID.current();
        
        _safeMint(to, id);
        _metadata[id] = metadata;
        _ownedTokens[to].push(id);

        _tokenID.increment();
        emit DiplomaMinted(to, tx.origin);
    }

    function diplomasOwnedBy(address owner) public view returns (DiplomaMetadata[] memory) {
        uint256[] memory ownedTokens = _ownedTokens[owner];
        DiplomaMetadata[] memory metadata = new DiplomaMetadata[](ownedTokens.length);

        for (uint256 i = 0; i < ownedTokens.length; i++) {
            metadata[i] = _metadata[ownedTokens[i]];
        }

        return metadata;
    }


    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);
        return _metadata[tokenId].URI;
    }

    function renounceOwnership() public override {
        revert("disabled");
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        revert("disabled");
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        revert("disabled");
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public override {
        revert("disabled");
    }
}