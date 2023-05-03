// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import {NounsDAOLogicV2} from "packages/nouns-monorepo/packages/nouns-contracts/contracts/governance/NounsDAOLogicV2.sol";

import {IMetadataRenderer} from "./interfaces/IMetadataRenderer.sol";


contract NounsIVotedBadge is ERC721 {

  uint256 private _tokenId;

  address payable public constant NOUNS_DAO = payable(0x6f3E6272A167e8AcCb32072d08E0957F9c79223d);

  IMetadataRenderer public renderer;

  mapping(uint256 tokenId => uint256 proposalId) private _tokenIdToProposalId;
  mapping(address voter => mapping(uint256 proposalId => bool minted)) private _mintedBadge;

  event VoterBadgeMinted(
    uint256 proposalId,
    uint256 badgeId
  );

  error CannotBeZeroAddressError();
  error AddressNotVotedInProposalError();
  error AlreadyMintedProposalBadgeError();
  error VoterHasMoreThanZeroVotesError();
  error CannotTransferError();

  constructor(IMetadataRenderer _renderer) ERC721("NOUNS I VOTED", "NIV") {
    if(address(_renderer) == address(0)) revert CannotBeZeroAddressError();

    renderer = _renderer;
  }

  
  function claimBadge(uint256 proposalId) external returns (uint256) {
    if(!NounsDAOLogicV2(NOUNS_DAO).getReceipt(proposalId, msg.sender).hasVoted) revert AddressNotVotedInProposalError(); 
    if(NounsDAOLogicV2(NOUNS_DAO).getReceipt(proposalId, msg.sender).votes > 0) revert VoterHasMoreThanZeroVotesError();
    if(_mintedBadge[msg.sender][proposalId]) revert AlreadyMintedProposalBadgeError();

    unchecked {
      _mint(msg.sender, ++_tokenId);
    }

    _mintedBadge[msg.sender][proposalId] = true;
    _tokenIdToProposalId[_tokenId] = proposalId;

    emit VoterBadgeMinted({
      proposalId: proposalId,
      badgeId: _tokenId
    });
  }

  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    _requireMinted(tokenId);

    /*
    this line:

    is soulbond -> line correct
    not soulbond -> bug line
    */
    uint8 voterSupport = NounsDAOLogicV2(NOUNS_DAO).getReceipt(_tokenIdToProposalId[tokenId], ownerOf(tokenId)).support;

    return renderer.tokenURI(tokenId, _tokenIdToProposalId[tokenId], voterSupport);
  }

  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 /* firstTokenId */,
    uint256 /* batchSize */
  ) internal virtual override {

    if(from != address(0) || to != address(0)) {
      revert CannotTransferError();
    }

  }


}
