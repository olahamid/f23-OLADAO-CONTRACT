//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {govToken} from "../src/govToken.sol";
import {olaGovernor} from "../src/olaGovernor.sol";
import {Box} from "../src/Box.sol";
import {TimeLock} from "../src/TimeLock.sol";

contract helperConfig is Script {
//we are doing this on the sapolia network firstly
// struct networkConfig {
//     uint256 deployer_key;
//     olaGovernor governor;
//     TimeLock timelock;
//     Box box;
//     govToken GovToken;
// }

// networkConfig public ActiveNetworkConfig;
// //instances
// govToken instance_GovToken = new govToken(_percentage);
// //remeberr to add govToken to delegate
// Box instance_Box = new Box(box_Owner);
// TimeLock instance_TimeLock = new TimeLock(MIN_DELAY, proposers, executors, admin);
// olaGovernor instance_olaGovernor = new olaGovernor(instance_GovToken, instance_TimeLock);

// uint256 public constant MIN_DELAY = 3600; //== 1hour delay
// address[] public proposers;
// address[] public executors;
// address admin;
// address public box_Owner = (address(instance_TimeLock));
// uint256 public _percentage = 15;

// constructor() {
//     if (block.chainid == 11155111) {
//         ActiveNetworkConfig = getSapoliaConfig();
//     } else {
//         ActiveNetworkConfig = getOrCreateAnvilConfig();
//     }
// }

// function getSapoliaConfig() public view returns (networkConfig memory) {
//     return networkConfig({
//         deployer_key: vm.envUint("PRIVATE_KEY"),
//         governor: instance_olaGovernor,
//         timelock: instance_TimeLock,
//         box: instance_Box,
//         GovToken: instance_GovToken
//     });
// }

// function getOrCreateAnvilConfig() public view returns (networkConfig memory) {
//     return networkConfig({
//         deployer_key: 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80,
//         governor: instance_olaGovernor,
//         timelock: instance_TimeLock,
//         box: instance_Box,
//         GovToken: instance_GovToken
//     });
// }

// function getProposers() public view returns (address[] memory) {
//     return proposers;
// }

// function getExecutors() public view returns (address[] memory) {
//     return executors;
// }
}
