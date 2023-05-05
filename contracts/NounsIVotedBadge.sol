// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {NounsDAOLogicV2} from "packages/nouns-monorepo/packages/nouns-contracts/contracts/governance/NounsDAOLogicV2.sol";
import {NounsDAOStorageV2} from "packages/nouns-monorepo/packages/nouns-contracts/contracts/governance/NounsDAOInterfaces.sol";

import {IMetadataRenderer} from "./interfaces/IMetadataRenderer.sol";


contract NounsIVotedBadge is ERC721, Ownable, NounsDAOStorageV2 {

  uint256 private _tokenId;

  address payable public constant NOUNS_DAO = payable(0x6f3E6272A167e8AcCb32072d08E0957F9c79223d);

  IMetadataRenderer public renderer;
  
  mapping(uint256 tokenId => IMetadataRenderer.Badge badge) private _tokenIdToBadge;

  mapping(address voter => mapping(uint256 proposalId => bool minted)) private _mintedBadge;

  event VoterBadgeMinted(
    uint256 indexed proposalId,
    uint256 indexed badgeId
  );

  event UpdatedMetadataRenderer(
    address newRenderer
  );

  error CannotBeZeroAddressError();
  error AddressNotVotedInProposalError();
  error AlreadyMintedProposalBadgeError();
  error VoterHasMoreThanZeroVotesError();
  error CannotTransferError();

  constructor(IMetadataRenderer _renderer) ERC721("NOUNS I VOTED", "NIV") Ownable() {
    if(address(_renderer) == address(0)) revert CannotBeZeroAddressError();

    renderer = _renderer;
  }

  
  function claimBadge(uint256 proposalId) external returns (uint256) {

    Receipt memory receipt = NounsDAOLogicV2(NOUNS_DAO).getReceipt(proposalId, msg.sender);

    if(!receipt.hasVoted) revert AddressNotVotedInProposalError();
    if(receipt.votes > 0) revert VoterHasMoreThanZeroVotesError();
    if(_mintedBadge[msg.sender][proposalId]) revert AlreadyMintedProposalBadgeError();

    _mintedBadge[msg.sender][proposalId] = true;

    unchecked {
      _tokenIdToBadge[++_tokenId] = IMetadataRenderer.Badge({
        proposalId: proposalId,
        support: receipt.support,
        voter: msg.sender
      });
    }
  
    _mint(msg.sender, _tokenId);

    emit VoterBadgeMinted({
      proposalId: proposalId,
      badgeId: _tokenId
    });

    return _tokenId;
  }

  
  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    _requireMinted(tokenId);

    IMetadataRenderer.Badge memory badge = _tokenIdToBadge[tokenId];

    //uint8 voterSupport = NounsDAOLogicV2(NOUNS_DAO).getReceipt(badge.proposalId, badge.voter).support;

    return renderer.tokenURI(tokenId, badge);
  }

  function updateMetadaRenderer(IMetadataRenderer newRenderer) external onlyOwner {
    if(address(newRenderer) == address(0)) revert CannotBeZeroAddressError();

    renderer = newRenderer;

    emit UpdatedMetadataRenderer({newRenderer: address(newRenderer)});
  }

}
