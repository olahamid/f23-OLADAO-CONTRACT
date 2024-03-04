// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {govToken} from "../src/govToken.sol";
import {olaGovernor} from "../src/olaGovernor.sol";

contract interaction is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("govToken", block.chainid);
        governDaoOnContract(mostRecentlyDeployed);
    }

    function governDaoOnContract(address contractAddress) public {
        vm.startBroadcast();
        govToken(contractAddress);
        vm.stopBroadcast();
    }
}
