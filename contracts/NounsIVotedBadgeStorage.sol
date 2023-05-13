// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {NounsDescriptorV2} from "packages/nouns-monorepo/packages/nouns-contracts/contracts/NounsDescriptorV2.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

abstract contract NounsIVotedBadgeStorage is ERC721 {

  uint256 internal _tokenId;

  struct Badge {
    uint256 proposalId;
    uint256 glassIndex;
    uint8 support;
    address voter;
  }

  address payable public constant NOUNS_DAO = payable(0x6f3E6272A167e8AcCb32072d08E0957F9c79223d);
  NounsDescriptorV2 public descriptors = NounsDescriptorV2(0x6229c811D04501523C6058bfAAc29c91bb586268);
  
  mapping(uint256 tokenId => Badge badge) internal _tokenIdToBadge;
  mapping(address voter => mapping(uint256 proposalId => bool minted)) internal _mintedBadge;

  string internal constant _SVG_START_TAG = '<svg width="320" height="320" viewBox="0 0 320 320" xmlns="http://www.w3.org/2000/svg">';
  string internal constant _SVG_END_TAG = "</svg>";

}
