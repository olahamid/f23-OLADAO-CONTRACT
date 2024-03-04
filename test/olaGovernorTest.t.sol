//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Test} from "../lib/forge-std/src/Test.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {Box} from "../src/Box.sol";
import {olaGovernor} from "../src/olaGovernor.sol";
import {TimeLock} from "../src/TimeLock.sol";
import {govToken} from "../src/govToken.sol";

contract olaGovernorTest is Test {
    olaGovernor governor;
    TimeLock timelock;
    govToken GovToken;
    Box box;
    address public USER = makeAddr("user");
    uint256 public total_Supply = 10 ether;
    uint256 public _percentage = 15;
    uint256 public MIN_DELAY = 3600;
    
    uint public constant Voting_Delay = 1;
    uint public constant Voting_Period = 50400;

    address[] proposers;
    address[] executors;
    address admin;
    bytes[] calldatas;
    uint[] values;
    address[] target;


    function setUp() public {
        GovToken = new govToken(USER, total_Supply, _percentage);

        vm.prank(USER);
        GovToken.delegate(USER);
        timelock = new TimeLock(MIN_DELAY, proposers, executors, USER);
        governor = new olaGovernor(GovToken, timelock);

        bytes32 proposerRoles = timelock.PROPOSER_ROLE();
        bytes32 executorRole = timelock.EXECUTOR_ROLE();
        bytes32 adminRole = timelock.DEFAULT_ADMIN_ROLE();

        timelock.grantRole(proposerRoles, address(governor));
        timelock.grantRole(executorRole, address(0));
        timelock.revokeRole(adminRole, msg.sender);
        // vm.stopPrank();

        // box = new Box(USER);
        // box.transferOwnership(address(timelock));
        // console.log (address(timelock));
        // console.log(msg.sender);

    }
    function testCantUpdateBoxWithoutGoveranance() public {
        
        vm.startPrank(msg.sender);
        
        box.store(1);
        vm.expectRevert();
        vm.stopPrank();
    }
   function testGovernanceUpdateBox() public {
        uint valueToStore = 888;
        string memory description = "store memory in box";
        bytes memory encodeFunctionCall = abi.encodeWithSignature("store(uint)", valueToStore); 
        values.push(0);
        calldatas.push(encodeFunctionCall);
        target.push(address(box));

        //1. propose to the DAO
        uint proposeId = governor.propose(target, values, calldatas, description);

        //view the state of the proposal 
        //warp is used to update the blockchain to pass 
        vm.warp(block.timestamp + Voting_Delay + 1);
         //the vm.roll is used to in the numnber of the blockchain, this is used to increase the enum, proposal (blockchain/)from pemding to active 
        vm.roll(block.number + Voting_Delay + 1);

        console.log ("proposal State:", uint (governor.state(proposeId)));

        //2 vote 
        string memory reason = "hamid is a baller";
        uint8 voteWay = 1;
        vm.prank(USER); 
        governor.castVoteWithReason(proposeId, voteWay, reason);

        vm.warp(block.timestamp + Voting_Period + 1);
        vm.roll(block.timestamp + Voting_Period + 1);

        //3 QUEUE the TX
        bytes32 descriptionHash = keccak256(abi.encodePacked(description));
        governor.queue(target, values, calldatas, descriptionHash);
        vm.warp(block.timestamp + Voting_Delay + 1);
        vm.roll(block.number + Voting_Delay + 1);



        //4 execute 
        governor.execute(target, values, calldatas, descriptionHash);

        assert(box.getNumber() == valueToStore);







   }
}
