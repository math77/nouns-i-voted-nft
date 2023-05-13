// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {NounsDAOLogicV2} from "packages/nouns-monorepo/packages/nouns-contracts/contracts/governance/NounsDAOLogicV2.sol";
import {NounsDAOStorageV2} from "packages/nouns-monorepo/packages/nouns-contracts/contracts/governance/NounsDAOInterfaces.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ISVGRenderer} from "packages/nouns-monorepo/packages/nouns-contracts/contracts/NounsDescriptorV2.sol";

import {Base64} from "./libraries/Base64.sol";

import "./NounsIVotedBadgeStorage.sol";


contract NounsIVotedBadge is NounsIVotedBadgeStorage, NounsDAOStorageV2 {
  using Strings for uint256;

  event VoterBadgeMinted(
    uint256 indexed proposalId,
    uint256 indexed badgeId
  );

  error CannotBeZeroAddressError();
  error AddressNotVotedInProposalError();
  error AlreadyMintedProposalBadgeError();
  error VoterHasMoreThanZeroVotesError();

  constructor() ERC721("NOUNS I VOTED", "NIV") {}

  
  function claimBadge(uint256 proposalId) external returns (uint256) {
    Receipt memory receipt = NounsDAOLogicV2(NOUNS_DAO).getReceipt(proposalId, msg.sender);

    if(!receipt.hasVoted) revert AddressNotVotedInProposalError();
    if(receipt.votes > 0) revert VoterHasMoreThanZeroVotesError();
    if(_mintedBadge[msg.sender][proposalId]) revert AlreadyMintedProposalBadgeError();

    _mintedBadge[msg.sender][proposalId] = true;

    unchecked {
      _tokenIdToBadge[++_tokenId] = Badge({
        proposalId: proposalId,
        glassIndex: proposalId % descriptors.glassesCount(),
        support: 1,
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

    Badge memory badge = _tokenIdToBadge[tokenId];

    return string(
      string.concat(
        "data:application/json;base64,",
          Base64.encode(
            bytes(
              abi.encodePacked(
                '{"name":"' "Voter Badge #",
                tokenId.toString(),
                '", "description":"Collect your voter badge in an ecosystem nouns proposal."',
                ', "image": "' "data:image/svg+xml;base64,",
                Base64.encode(bytes(getNoggle(badge.proposalId, badge.glassIndex, badge.support))),
                '", "attributes": ',
                generateAttributes(badge.proposalId, badge.support, badge.voter),
                '}'
              )
            )
          )
        )
      );
  }

  //USING FALLABACK (GOOGLE URL) FOR TESTS, CHANGE FOR FILESTORE FOR DEPLOY
  function getNoggle(uint256 proposalId, uint256 glassIndex, uint8 support) public view returns (string memory svg) {

    bytes memory partBytes = descriptors.art().glasses(glassIndex); 

    ISVGRenderer.Part memory svgPart = ISVGRenderer.Part({image: partBytes, palette: _getPalette(partBytes)});
    
    string memory renderedSVGNogglePart = descriptors.renderer().generateSVGPart(svgPart);
    
    svg = string.concat(
      _SVG_START_TAG,
      '<style>.general {font-family: "serif"; fill: #000; font-weight: semibold;}.font-size-1 {font-size: 34px;}</style>',
      '<circle cx="160" cy="160" r="160" fill="#E1D7D5"/>',
      '<circle cx="160" cy="160" r="153" fill="none" stroke-width="7" stroke="',
      arcColor(support),
      '"/>',                                                                                                                                   
      renderedSVGNogglePart,
      '<text x="50%" y="65%" dominant-baseline="middle" text-anchor="middle" class="general font-size-1">I VOTED</text><text x="50%" y="75%" dominant-baseline="middle" text-anchor="middle" class="general font-size-1">PROP ',
      proposalId.toString(),
      '</text>',
      _SVG_END_TAG
    );
  }

  /*
  function noggle() internal view returns (string memory) {
    return '<rect width="60" height="10" x="100" y="110" fill="#ec5b43" /><rect width="60" height="10" x="170" y="110" fill="#ec5b43" /><rect width="10" height="10" x="100" y="120" fill="#ec5b43" /><rect width="20" height="10" x="110" y="120" fill="#ffffff" /><rect width="20" height="10" x="130" y="120" fill="#000000" /><rect width="10" height="10" x="150" y="120" fill="#ec5b43" /><rect width="10" height="10" x="170" y="120" fill="#ec5b43" /><rect width="20" height="10" x="180" y="120" fill="#ffffff" /><rect width="20" height="10" x="200" y="120" fill="#000000" /><rect width="10" height="10" x="220" y="120" fill="#ec5b43" /><rect width="40" height="10" x="70" y="130" fill="#ec5b43" /><rect width="20" height="10" x="110" y="130" fill="#ffffff" /><rect width="20" height="10" x="130" y="130" fill="#000000" /><rect width="30" height="10" x="150" y="130" fill="#ec5b43" /><rect width="20" height="10" x="180" y="130" fill="#ffffff" /><rect width="20" height="10" x="200" y="130" fill="#000000" /><rect width="10" height="10" x="220" y="130" fill="#ec5b43" /><rect width="10" height="10" x="70" y="140" fill="#ec5b43" /><rect width="10" height="10" x="100" y="140" fill="#ec5b43" /><rect width="20" height="10" x="110" y="140" fill="#ffffff" /><rect width="20" height="10" x="130" y="140" fill="#000000" /><rect width="10" height="10" x="150" y="140" fill="#ec5b43" /><rect width="10" height="10" x="170" y="140" fill="#ec5b43" /><rect width="20" height="10" x="180" y="140" fill="#ffffff" /><rect width="20" height="10" x="200" y="140" fill="#000000" /><rect width="10" height="10" x="220" y="140" fill="#ec5b43" /><rect width="10" height="10" x="70" y="150" fill="#ec5b43" /><rect width="10" height="10" x="100" y="150" fill="#ec5b43" /><rect width="20" height="10" x="110" y="150" fill="#ffffff" /><rect width="20" height="10" x="130" y="150" fill="#000000" /><rect width="10" height="10" x="150" y="150" fill="#ec5b43" /><rect width="10" height="10" x="170" y="150" fill="#ec5b43" /><rect width="20" height="10" x="180" y="150" fill="#ffffff" /><rect width="20" height="10" x="200" y="150" fill="#000000" /><rect width="10" height="10" x="220" y="150" fill="#ec5b43" /><rect width="60" height="10" x="100" y="160" fill="#ec5b43" /><rect width="60" height="10" x="170" y="160" fill="#ec5b43" />';
  }
  */

  function generateAttributes(uint256 proposalId, uint8 _support, address voter) internal view returns (string memory attrs) {
    
    string memory support;
    if(_support == 0) {
      support = "Against";
    } else if(_support == 1) {
      support = "For";
    } else {
      support = "Abstain";
    }


    attrs = string.concat(
      '[{"trait_type":"Proposal", "value":"',
      proposalId.toString(),
      '"}, {"trait_type":"Support", "value":"',
      support,
      '"}, {"trait_type":"Voter", "value":"',
      Strings.toHexString(voter),
      '"}]'
    );
  }

  //0=against, 1=for, 2=abstain
  function arcColor(uint8 support) public pure returns (string memory) {

    if(support == 0) {
      return "#F3322C"; // red
    } else if(support == 1) {
      return "#068940"; // green
    } else {
      return "#000";
    }
  }

  function _getPalette(bytes memory part) private view returns (bytes memory) {
    return descriptors.art().palettes(uint8(part[0]));
  }

}
