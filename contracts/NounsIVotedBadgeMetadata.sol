// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;


import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

import {IFileStore} from "packages/ethfs/packages/contracts/src/IFileStore.sol";

import {NoggleSVGs} from "./NoggleSVGs.sol";

import {IMetadataRenderer} from "./interfaces/IMetadataRenderer.sol";

import {Base64} from "./libraries/Base64.sol";

 
contract NounsIVotedBadgeMetadata is IMetadataRenderer {

  using Strings for uint256;

  NoggleSVGs private _noggleSVGs;

  address private _londrinaFontAddress;

  constructor(NoggleSVGs noggleSVGs, address londrinaFont) {
    _noggleSVGs = noggleSVGs;
    _londrinaFontAddress = londrinaFont;
  }

  function tokenURI(uint256 tokenId, uint256 proposalId, uint8 voterSupport) external view override returns (string memory) {
    return string(
      string.concat(
        "data:application/json;base64,",
          Base64.encode(
            bytes(
              abi.encodePacked(
                '{"name":"' "Badge #",
                tokenId.toString(),
                '", "description":" Get a badge..."',
                ', "image": "' "data:image/svg+xml;base64,",
                Base64.encode(bytes(getBadge(proposalId, voterSupport))),
                '"}'
              )
            )
          )
        )
      );
  }

  /*
  function badge1(uint256 proposalId, uint8 voterSupport) public view returns (string memory) {
    return string.concat(
      '<svg width="450" height="450" viewBox="0 0 450 450" fill="none" xmlns="http://www.w3.org/2000/svg"><style>@font-face {font-family: "Londrina Regular";src: url(data:font/truetype;charset=utf-8;base64,',
      _londrinaFont.font(),
      ') format("truetype");} .general {font-family: "Londrina Regular"; fill: #000;}.font-size-1 {font-size: 90px;} .font-size-2 {font-size: 40px;} .noggle {fill: #F3322C;}',
      noggleColor(voterSupport),
      ';}</style><circle cx="225" cy="225" r="225" fill="#E1D7D5"/><text x="100" y="180" class="general font-size-1">I VOTED</text><text x="150" y="230" class="general font-size-2">PROP ',
      proposalId.toString(),
      '</text>',
      _noggleSVGs.smallNoggle(),
      '</svg>'     
    );    
  }
  */

  function getBadge(uint256 proposalId, uint8 voterSupport) public view returns (string memory badgeSVG) {
    uint256 badgeType = uint256(keccak256(abi.encodePacked(proposalId, address(this))));

    if(badgeType % 2 == 0) {
      badgeSVG = badge1(proposalId, voterSupport);
    } else {
      badgeSVG = badge2(proposalId, voterSupport);
    }
  }

  //USING FALLABACK (GOOGLE URL) FOR TESTS, CHANGE FOR FILESTORE FOR DEPLOY
  function badge1(uint256 proposalId, uint8 voterSupport) public view returns (string memory) {

    /*
    IFileStore fileStore = IFileStore(_londrinaFontAddress);
    
    //goerli testnet
    fileStore.getFile("Londrina-Solid-Regular.ttf").read()
    */

    return string.concat(
      '<svg width="450" height="450" viewBox="0 0 450 450" fill="none" xmlns="http://www.w3.org/2000/svg"><style>@import url("https://fonts.googleapis.com/css2?family=Londrina+Solid");',
      ' .general {font-family: "Londrina Solid"; fill: #000;}.font-size-1 {font-size: 90px;} .font-size-2 {font-size: 40px;} .noggle {fill: ',
      noggleColor(voterSupport),
      ';}</style><circle cx="225" cy="225" r="225" fill="#E1D7D5"/><text x="50%" y="40%" dominant-baseline="middle" text-anchor="middle" class="general font-size-1">I VOTED</text><text x="50%" y="52%" dominant-baseline="middle" text-anchor="middle" class="general font-size-2">PROP ',
      proposalId.toString(),
      '</text>',
      _noggleSVGs.smallNoggle(),
      '</svg>'     
    );    
  }

  function badge2(uint256 proposalId, uint8 voterSupport) public view returns (string memory) {
    return string.concat(
      '<svg width="450" height="450" viewBox="0 0 450 450" fill="none" xmlns="http://www.w3.org/2000/svg"><style>@import url("https://fonts.googleapis.com/css2?family=Londrina+Solid");',
      ' .general {font-family: "Londrina Solid"; fill: #000;}.font-size-1 {font-size: 60px;} .noggle {fill: ',
      noggleColor(voterSupport),
      ';}</style><circle cx="225" cy="225" r="225" fill="#E1D7D5"/><text x="50%" y="25%" dominant-baseline="middle" text-anchor="middle" class="general font-size-1">I VOTED</text><text x="50%" y="75%" dominant-baseline="middle" text-anchor="middle" class="general font-size-1">PROP ',
      proposalId.toString(),
      '</text>',
      _noggleSVGs.bigNoggle(),
      '</svg>'
    );
  }

  //0=against, 1=for, 2=abstain
  function noggleColor(uint8 voterSupport) public pure returns (string memory) {

    if(voterSupport == 0) {
      return "#F3322C"; // red
    } else if(voterSupport == 1) {
      return "#068940"; // green
    } else {
      return "#000";
    }
  }

}
