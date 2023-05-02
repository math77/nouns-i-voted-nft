// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;


interface IMetadataRenderer {

  function tokenURI(uint256 tokenId, uint256 proposalId, uint8 voterSupport) external view returns (string memory);

}
