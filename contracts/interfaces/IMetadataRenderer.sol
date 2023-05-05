// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;


interface IMetadataRenderer {

  struct Badge {
    uint256 proposalId;
    uint8 support;
    address voter;
  }

  function tokenURI(uint256 tokenId, Badge memory badge) external view returns (string memory);
}
