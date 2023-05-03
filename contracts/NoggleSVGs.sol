// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;


contract NoggleSVGs {

  /*
  function smallNoggle() public view returns (string memory) {
    return '<path d="M224.5 293.531H159.438V305.125H224.5V293.531Z" class="noggle"/>'
    '<path d="M300.406 293.531H235.344V305.125H300.406V293.531Z" class="noggle"/>'
    '<path d="M170.281 305.125H159.438V316.719H170.281V305.125Z" class="noggle"/>'
    '<path d="M191.969 305.125H170.281V316.719H191.969V305.125Z" fill="#fff"/>'
    '<path d="M213.656 305.125H191.969V316.719H213.656V305.125Z" fill="#000"/>'
    '<path d="M224.5 305.125H213.656V316.719H224.5V305.125Z" class="noggle"/>'
    '<path d="M246.188 305.125H235.344V316.719H246.188V305.125Z" class="noggle"/>'
    '<path d="M267.875 305.125H246.188V316.719H267.875V305.125Z" fill="#fff"/>'
    '<path d="M289.562 305.125H267.875V316.719H289.562V305.125Z" fill="#000"/>'
    '<path d="M300.406 305.125H289.562V316.719H300.406V305.125Z" class="noggle"/>'
    '<path d="M170.281 316.719H126.906V328.312H170.281V316.719Z" class="noggle"/>'
    '<path d="M191.969 316.719H170.281V328.312H191.969V316.719Z" fill="#fff"/>'
    '<path d="M213.656 316.719H191.969V328.312H213.656V316.719Z" fill="#000"/>'
    '<path d="M246.188 316.719H213.656V328.312H246.188V316.719Z" class="noggle"/>'
    '<path d="M267.875 316.719H246.188V328.312H267.875V316.719Z" fill="#fff"/>'
    '<path d="M289.562 316.719H267.875V328.312H289.562V316.719Z" fill="#000"/>'
    '<path d="M300.406 316.719H289.562V328.312H300.406V316.719Z" class="noggle"/>'
    '<path d="M137.75 328.312H126.906V339.906H137.75V328.312Z" class="noggle"/>'
    '<path d="M170.281 328.312H159.438V339.906H170.281V328.312Z" class="noggle"/>'
    '<path d="M191.969 328.312H170.281V339.906H191.969V328.312Z" fill="#fff"/>'
    '<path d="M213.656 328.312H191.969V339.906H213.656V328.312Z" fill="#000"/>'
    '<path d="M224.5 328.312H213.656V339.906H224.5V328.312Z" class="noggle"/>'
    '<path d="M246.188 328.312H235.344V339.906H246.188V328.312Z" class="noggle"/>'
    '<path d="M267.875 328.312H246.188V339.906H267.875V328.312Z" fill="#fff"/>'
    '<path d="M289.562 328.312H267.875V339.906H289.562V328.312Z" fill="#000"/>'
    '<path d="M300.406 328.312H289.562V339.906H300.406V328.312Z" class="noggle"/>'
    '<path d="M137.75 339.906H126.906V351.5H137.75V339.906Z" class="noggle"/>'
    '<path d="M170.281 339.906H159.438V351.5H170.281V339.906Z" class="noggle"/>'
    '<path d="M191.969 339.906H170.281V351.5H191.969V339.906Z" fill="#fff"/>'
    '<path d="M213.656 339.906H191.969V351.5H213.656V339.906Z" fill="#000"/>'
    '<path d="M224.5 339.906H213.656V351.5H224.5V339.906Z" class="noggle"/>'
    '<path d="M246.188 339.906H235.344V351.5H246.188V339.906Z" class="noggle"/>'
    '<path d="M267.875 339.906H246.188V351.5H267.875V339.906Z" fill="#fff"/>'
    '<path d="M289.562 339.906H267.875V351.5H289.562V339.906Z" fill="#000"/>'
    '<path d="M300.406 339.906H289.562V351.5H300.406V339.906Z" class="noggle"/>'
    '<path d="M224.5 351.5H159.438V363.094H224.5V351.5Z" class="noggle"/>'
    '<path d="M300.406 351.5H235.344V363.094H300.406V351.5Z" class="noggle"/>';
  }
  */

  function smallNoggle() public view returns (string memory) {
    return '<path d="M224.5 293.531h-65.062v11.594H224.5v-11.594Zm75.906 0h-65.062v11.594h65.062v-11.594Zm-130.125 11.594h-10.843v11.594h10.843v-11.594Z" class="noggle"/>'
    '<path d="M191.969 305.125h-21.688v11.594h21.688v-11.594Z" fill="#fff"/>'
    '<path d="M213.656 305.125h-21.687v11.594h21.687v-11.594Z" fill="#000"/>'
    '<path d="M224.5 305.125h-10.844v11.594H224.5v-11.594Zm21.688 0h-10.844v11.594h10.844v-11.594Z" class="noggle"/>'
    '<path d="M267.875 305.125h-21.687v11.594h21.687v-11.594Z" fill="#fff"/>'
    '<path d="M289.562 305.125h-21.687v11.594h21.687v-11.594Z" fill="#000"/>'
    '<path d="M300.406 305.125h-10.844v11.594h10.844v-11.594Zm-130.125 11.594h-43.375v11.593h43.375v-11.593Z" class="noggle"/>'
    '<path d="M191.969 316.719h-21.688v11.593h21.688v-11.593Z" fill="#fff"/>'
    '<path d="M213.656 316.719h-21.687v11.593h21.687v-11.593Z" fill="#000"/>'
    '<path d="M246.188 316.719h-32.532v11.593h32.532v-11.593Z" class="noggle"/>'
    '<path d="M267.875 316.719h-21.687v11.593h21.687v-11.593Z" fill="#fff"/>'
    '<path d="M289.562 316.719h-21.687v11.593h21.687v-11.593Z" fill="#000"/>'
    '<path d="M300.406 316.719h-10.844v11.593h10.844v-11.593ZM137.75 328.312h-10.844v11.594h10.844v-11.594Zm32.531 0h-10.843v11.594h10.843v-11.594Z" class="noggle"/>'
    '<path d="M191.969 328.312h-21.688v11.594h21.688v-11.594Z" fill="#fff"/>'
    '<path d="M213.656 328.312h-21.687v11.594h21.687v-11.594Z" fill="#000"/>'
    '<path d="M224.5 328.312h-10.844v11.594H224.5v-11.594Zm21.688 0h-10.844v11.594h10.844v-11.594Z" class="noggle"/>'
    '<path d="M267.875 328.312h-21.687v11.594h21.687v-11.594Z" fill="#fff"/>'
    '<path d="M289.562 328.312h-21.687v11.594h21.687v-11.594Z" fill="#000"/>'
    '<path d="M300.406 328.312h-10.844v11.594h10.844v-11.594ZM137.75 339.906h-10.844V351.5h10.844v-11.594Zm32.531 0h-10.843V351.5h10.843v-11.594Z" class="noggle"/>'
    '<path d="M191.969 339.906h-21.688V351.5h21.688v-11.594Z" fill="#fff"/>'
    '<path d="M213.656 339.906h-21.687V351.5h21.687v-11.594Z" fill="#000"/>'
    '<path d="M224.5 339.906h-10.844V351.5H224.5v-11.594Zm21.688 0h-10.844V351.5h10.844v-11.594Z" class="noggle"/>'
    '<path d="M267.875 339.906h-21.687V351.5h21.687v-11.594Z" fill="#fff"/>'
    '<path d="M289.562 339.906h-21.687V351.5h21.687v-11.594Z" fill="#000"/>'
    '<path d="M300.406 339.906h-10.844V351.5h10.844v-11.594ZM224.5 351.5h-65.062v11.594H224.5V351.5Zm75.906 0h-65.062v11.594h65.062V351.5Z" class="noggle"/>';
  
  }

  function bigNoggle() public view returns (string memory) {
    return '<path d="M230 150H121v24h109v-24Zm126 0H248v24h108v-24Zm-217 24h-18v22h18v-22Z" class="noggle"/>'
    '<path d="M175 174h-36v22h36v-22Z" fill="#fff"/>'
    '<path d="M211 174h-36v22h36v-22Z" fill="#000"/>'
    '<path d="M230 174h-19v22h19v-22Zm36 0h-18v22h18v-22Z" class="noggle"/>'
    '<path d="M302 174h-36v22h36v-22Z" fill="#fff"/>'
    '<path d="M338 174h-36v22h36v-22Z" fill="#000"/>'
    '<path d="M356 174h-18v22h18v-22Zm-217 22H67v24h72v-24Z" class="noggle"/>'
    '<path d="M175 196h-36v24h36v-24Z" fill="#fff"/>'
    '<path d="M211 196h-36v24h36v-24Z" fill="#000"/>'
    '<path d="M266 196h-55v24h55v-24Z" class="noggle"/>'
    '<path d="M302 196h-36v24h36v-24Z" fill="#fff"/>'
    '<path d="M338 196h-36v24h36v-24Z" fill="#000"/>'
    '<path d="M356 196h-18v24h18v-24ZM85 220H67v24h18v-24Zm54 0h-18v24h18v-24Z" class="noggle"/>'
    '<path d="M175 220h-36v24h36v-24Z" fill="#fff"/>'
    '<path d="M211 220h-36v24h36v-24Z" fill="#000"/>'
    '<path d="M230 220h-19v24h19v-24Zm36 0h-18v24h18v-24Z" class="noggle"/>'
    '<path d="M302 220h-36v24h36v-24Z" fill="#fff"/>'
    '<path d="M338 220h-36v24h36v-24Z" fill="#000"/>'
    '<path d="M356 220h-18v24h18v-24ZM85 244H67v24h18v-24Zm54 0h-18v24h18v-24Z" class="noggle"/>'
    '<path d="M175 244h-36v24h36v-24Z" fill="#fff"/>'
    '<path d="M211 244h-36v24h36v-24Z" fill="#000"/>'
    '<path d="M230 244h-19v24h19v-24Zm36 0h-18v24h18v-24Z" class="noggle"/>'
    '<path d="M302 244h-36v24h36v-24Z" fill="#fff"/>'
    '<path d="M338 244h-36v24h36v-24Z" fill="#000"/>'
    '<path d="M356 244h-18v24h18v-24Zm-126 24H121v22h109v-22Zm126 0H248v22h108v-22Z" class="noggle"/>';
  }
}
