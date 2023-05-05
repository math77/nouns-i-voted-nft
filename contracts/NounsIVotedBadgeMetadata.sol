// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;


import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {IFileStore} from "packages/ethfs/packages/contracts/src/IFileStore.sol";
import {NounsDescriptorV2, ISVGRenderer} from "packages/nouns-monorepo/packages/nouns-contracts/contracts/NounsDescriptorV2.sol";


import {IMetadataRenderer} from "./interfaces/IMetadataRenderer.sol";

import {Base64} from "./libraries/Base64.sol";

 
contract NounsIVotedBadgeMetadata is IMetadataRenderer {

  using Strings for uint256;

  address public londrinaFont;
  NounsDescriptorV2 public immutable descriptors;

  string private constant _SVG_START_TAG = '<svg width="320" height="320" viewBox="0 0 320 320" xmlns="http://www.w3.org/2000/svg" shape-rendering="crispEdges">';
  string private constant _SVG_END_TAG = "</svg>";

  constructor(NounsDescriptorV2 _descriptors, address _londrinaFont) {
    londrinaFont = _londrinaFont;
    descriptors = _descriptors;
  }

  function tokenURI(uint256 tokenId, Badge memory badge) external view override returns (string memory) {
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
                Base64.encode(bytes(getNoggle(badge.proposalId, badge.support))),
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
  function getNoggle(uint256 proposalId, uint8 support) public view returns (string memory svg) {

    //"dynamic" noggles
    uint256 glassIndex = proposalId % descriptors.glassesCount();

    bytes memory partBytes = descriptors.art().glasses(glassIndex); 

    ISVGRenderer.Part memory svgPart = ISVGRenderer.Part({image: partBytes, palette: _getPalette(partBytes)});
    
    string memory renderedSVGNogglePart = descriptors.renderer().generateSVGPart(svgPart);

    /*
    IFileStore fileStore = IFileStore(londrinaFont);
    
    //goerli testnet
    @font-face {font-family: "Londrina Regular";src: url(data:font/truetype;charset=utf-8;base64,
    fileStore.getFile("Londrina-Solid-Regular.ttf").read() format("truetype");}
    */

    svg = string.concat(
      _SVG_START_TAG,
      '<style>@import url("https://fonts.googleapis.com/css2?family=Londrina+Solid"); .general {font-family: "Londrina Solid"; fill: #000;}.font-size-1 {font-size: 42px;} .font-size-2 {font-size: 40px;}</style>',
      '<circle cx="160" cy="160" r="160" fill="#E1D7D5"/>',
      '<circle cx="160" cy="160" r="153" fill="none" stroke-width="5" stroke="',
      noggleColor(support),
      '"/>',                                                                                                                                                   
      renderedSVGNogglePart,
      '<text x="50%" y="65%" dominant-baseline="middle" text-anchor="middle" class="general font-size-1">I VOTED</text><text x="50%" y="75%" dominant-baseline="middle" text-anchor="middle" class="general font-size-1">PROP ',
      proposalId.toString(),
      '</text>',
      _SVG_END_TAG
    );
  }

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
  function noggleColor(uint8 support) public pure returns (string memory) {

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
