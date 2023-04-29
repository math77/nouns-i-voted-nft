// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;


import {IMetadataRenderer} from "./interfaces/IMetadataRenderer.sol";

contract NounsIVotedBadgeMetadata is IMetadataRenderer {

  function tokenURI(uint256 tokenId) external view override returns (string memory) {
    return "";
  }
}
