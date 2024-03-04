// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20Votes} from "../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Votes.sol";
import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Nonces} from "../lib/openzeppelin-contracts/contracts/utils/Nonces.sol";
import {Box} from "./Box.sol";
// import {Nonces} from "../lib/openzeppelin-contracts/contracts/utils/Nonces.sol";

/**
 * @title A simple F23-DAO contract for maintaining ownership
 * @author ola hamid
 * @notice This contract is for creating a sample DAO
 * @dev  establishing a dao governed cotract controlled my this author
 */
contract govToken is ERC20, ERC20Permit, ERC20Votes, Box {
    event TokenTransfered(address indexed from, address indexed to, uint256 amount);
    // error cannotClaimError();

    event TokenMinted(address indexed to, uint256 amount);
    event TokenBurned(address indexed from, uint256 amount);

    uint256 constant s_tokenPerUser = 1000;
    uint256 public s_tokenTotalsupply; //= 1000000 * 10 ** 18;

    mapping(address => bool) public m_HasClaimedToken;

    address[] public s_holders;

    constructor(address to, uint256 amount, uint256 _keepPercentage)
        ERC20("OLADAO TOKEN", "ODT")
        ERC20Permit("OLADAO TOKEN")
        Box(msg.sender)
    {
        amount = s_tokenTotalsupply;
        uint256 keepAmount = (_keepPercentage * s_tokenTotalsupply) / 100;
        _mint(to, amount);
        _transfer(msg.sender, address(this), keepAmount);
        s_holders.push(msg.sender);
    }
    //function allow users claim token loving this istg
    // function mint (address to, uint amount) public {
    //     _mint(to, amount);
    // }

    function claimToken() external {
        //  require(!m_HasClaimedToken[msg.sender], "you have claimed already");
        //
        if (m_HasClaimedToken[msg.sender]) {
            revert("you have claimed already");
        }
        m_HasClaimedToken[msg.sender] = true;
        _transfer(address(this), msg.sender, s_tokenPerUser * 10 ** 18);
        s_holders.push(msg.sender);
    }

    function getClaimersLength() external view returns (uint256) {
        return s_holders.length;
    }

    function _transfer(address from, address to, uint256 amount) internal override(ERC20) {
        super._transfer(from, to, amount);
        emit TokenTransfered(from, to, amount);
    }

    function _mint(address to, uint256 amount) internal override(ERC20) {
        super._mint(to, amount);
        emit TokenMinted(to, amount);
    }

    function _burn(address to, uint256 amount) internal override(ERC20) {
        super._burn(to, amount);
        emit TokenBurned(to, amount);
    }

    function _update(address from, address to, uint256 value) internal override(ERC20, ERC20Votes) {
        super._update(from, to, value);
    }

    function nonces(address owner) public view override(ERC20Permit, Nonces) returns (uint256) {
        return super.nonces(owner);
    }
}

//patrick's zepple contract
// contract GovToken is ERC20, ERC20Permit, ERC20Votes {
// constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken") {}

//     // The following functions are overrides required by Solidity.

//     function mint(address to, uint256 amount) public {
//         _mint(to, amount);
//     }

//     function _afterTokenTransfer(address from, address to, uint256 amount) internal override(ERC20, ERC20Votes) {
//         super._afterTokenTransfer(from, to, amount);
//     }

//     function _mint(address to, uint256 amount) internal override(ERC20, ERC20Votes) {
//         super._mint(to, amount);
//     }

//     function _burn(address account, uint256 amount) internal override(ERC20, ERC20Votes) {
//         super._burn(account, amount);
//     }

// }

// Hot Proposal Coming up => Buy a ton of tokens and dump them after voting is over
// need to prevent that by setting a Snapshop of tokens at a certain block.
