// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract InProof is ERC1155Burnable, Ownable, AccessControl {
    using Strings for uint256;

    string public name = "InProof";
    string public symbol = "IPF";
    string public baseUri;
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR");

    constructor() ERC1155("") {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    function mint(address[] memory _toAddresses, uint256 id) external onlyRole(OPERATOR_ROLE) {
        for (uint256 i = 0; i < _toAddresses.length; i++) {
            _mint(_toAddresses[i], id, 1, "");
        }
    }

    function uri(uint256 _id) public override view returns (string memory) {
        return string(abi.encodePacked(baseUri, _id.toString()));
    }

    function setBaseUri(string memory _uri) external onlyOwner {
        baseUri = _uri;
    }

    // SBT
    function setApprovalForAll(address, bool) public pure override {
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
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC1155, AccessControl) returns (bool) {
        return
            AccessControl.supportsInterface(interfaceId) ||
            ERC1155.supportsInterface(interfaceId);
    }
}
