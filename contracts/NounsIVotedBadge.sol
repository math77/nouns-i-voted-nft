// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";


import {IMetadataRenderer} from "./interfaces/IMetadataRenderer.sol";

contract NounsIVotedBadge is ERC721 {

  uint256 private _tokenId;

  IMetadataRenderer public renderer;

  error CannotBeZeroAddress();

  constructor(IMetadataRenderer _renderer) ERC721("NOUNS I VOTED", "NIV") {
    if(address(_renderer) == address(0)) revert CannotBeZeroAddress();

    renderer = _renderer;
  }

  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    return renderer.tokenURI(tokenId);
  }
}
