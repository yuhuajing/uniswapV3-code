// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract XToken is ERC20Capped, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    constructor() ERC20("Token", "TY") ERC20Capped(1000) {
        _grantRole(MINTER_ROLE, _msgSender());
        _setRoleAdmin(MINTER_ROLE, ADMIN_ROLE);
        _grantRole(ADMIN_ROLE, _msgSender());
    }

    modifier checkRole(
        bytes32 role,
        address account,
        string memory message
    ) {
        require(hasRole(role, account), message);
        _;
    }

    function mint(address to, uint256 amount)
        external
        checkRole(MINTER_ROLE, _msgSender(), "Caller is not a minter")
    {
        super._mint(to, amount * decimals());
    }
}
