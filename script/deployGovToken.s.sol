//SPDX-Identifier-License:MIT
pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {govToken} from "../src/govToken.sol";
// import {helperConfig} from "../script/helperConfig.s.sol";
import {olaGovernor} from "../src/olaGovernor.sol";
import {TimeLock} from "../src/TimeLock.sol";
import {Box} from "../src/Box.sol";

contract deployGovToken is Script {
    // helperConfig HelperConfig;
    // address[] proposers = HelperConfig.getProposers();
    // address[] executors = HelperConfig.getExecutors();
    // address admin;
    // // govToken GovToken;
    // // uint percentage = helperConfig._percentage;
    // // uint mIN_DELAY = helperConfig.MIN_DELAY ;

    // function run () external returns(govToken, olaGovernor, TimeLock) {
    //     HelperConfig = new helperConfig();
    //     (
    //         uint256 deployer_key,
    //         olaGovernor governor,
    //         TimeLock timelock,
    //         Box box,
    //         govToken GovToken
    //     ) = HelperConfig.ActiveNetworkConfig();
    //     vm.startBroadcast(deployer_key);
    //     timelock = new TimeLock(HelperConfig.MIN_DELAY(), proposers, executors, admin);
    //     box = new Box(HelperConfig.box_Owner());
    //     GovToken = new govToken(HelperConfig._percentage());
    //     governor = new olaGovernor(GovToken, timelock);
    //     vm.stopBroadcast();

    //     return(GovToken, governor, timelock);
    // }
    uint256 public constant anvil_Private_Key = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployer_Key;
    uint256 public _percentage;
    uint256 total_Supply = 100 ether;
    govToken GovToken;

    function run() public returns (govToken) {
        if (block.chainid == 31337) {
            deployer_Key = anvil_Private_Key;
        } else {
            deployer_Key = vm.envUint("PRIVATE_KEY");
        }

        vm.startBroadcast(deployer_Key);
        GovToken = new govToken(msg.sender, total_Supply, _percentage);
        // GovToken.claimToken();
        vm.stopBroadcast();
        return GovToken;
    }
}
