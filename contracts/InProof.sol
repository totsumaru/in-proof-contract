// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract InProof is ERC1155Burnable, Ownable, AccessControl {
    string public name = "InProof";
    string public symbol = "IPF";
    string public baseUrl;
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN");

    function mint(address[] _toAddresses, uint256 id) external onlyRole("ADMIN") {
        for (uint256 i = 0; i < _toAddresses.length; i++) {
            _mint(_toAddresses[i], id, 1, "");
        }
    }

    function uri(uint256 _id) public override view returns (string memory) {
        return string(abi.encodePacked(baseURI, _id.toString()));
    }

    function setBaseUri(string memory _uri) external onlyOwner {
        baseUrl = _uri;
    }

    // ---------------
    // SBT
    // ---------------
    function setApprovalForAll(address operator, bool approved) public override {
        revert("setApprovalForAll is prohibited");
    }

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override {
        require(
            from == address(0) || to == address(0),
            "Transfer is prohibited"
        );
        super._beforeTokenTransfers(from, to, startTokenId, quantity);
    }
}
