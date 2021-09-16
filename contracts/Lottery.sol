// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.5;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */

contract Lottery {
    address public manager;
    address payable[] public players;

    constructor() public payable {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > .01 ether);

        players.push(payable(msg.sender));
    }

    function random() private view returns (uint){
        return uint(keccak256(abi.encode(block.difficulty, block.timestamp, players)));
    }

    function getPlayers() public view returns (address payable[] memory){
        return players;
    }

    function pickWinner() public payable restricted{
        uint index = random() % players.length;
        players[index].transfer(address(this).balance);
        players = new address payable[](0);
    }

    modifier restricted(){
        require(msg.sender==manager);
        _;
    }
}
