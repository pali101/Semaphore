// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@semaphore-protocol/contracts/interfaces/ISemaphore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TicTacToeContract is Ownable {
    ISemaphore public semaphore;

    uint256 public groupId_Bomb;
    uint256 public groupId_Star;

    constructor(ISemaphore _semaphore) Ownable(msg.sender) {
        semaphore = _semaphore;
        // Create groups with this contract as admin and store the assigned group IDs
        groupId_Bomb = semaphore.createGroup(address(this));
        groupId_Star = semaphore.createGroup(address(this));
    }

    function addMember(
        uint256 groupId,
        uint256 identityCommitment
    ) external onlyOwner {
        require(
            groupId == groupId_Bomb || groupId == groupId_Star,
            "Invalid groupId"
        );
        semaphore.addMember(groupId, identityCommitment);
    }

    function addMembers(
        uint256 groupId,
        uint256[] calldata identityCommitments
    ) external onlyOwner {
        require(
            groupId == groupId_Bomb || groupId == groupId_Star,
            "Invalid groupId"
        );
        semaphore.addMembers(groupId, identityCommitments);
    }

    function updateMember(
        uint256 groupId,
        uint256 identityCommitment,
        uint256 newIdentityCommitment,
        uint256[] calldata merkleProofSiblings
    ) external onlyOwner {
        require(
            groupId == groupId_Bomb || groupId == groupId_Star,
            "Invalid groupId"
        );
        semaphore.updateMember(
            groupId,
            identityCommitment,
            newIdentityCommitment,
            merkleProofSiblings
        );
    }

    function removeMember(
        uint256 groupId,
        uint256 identityCommitment,
        uint256[] calldata merkleProofSiblings
    ) external onlyOwner {
        require(
            groupId == groupId_Bomb || groupId == groupId_Star,
            "Invalid groupId"
        );
        semaphore.removeMember(
            groupId,
            identityCommitment,
            merkleProofSiblings
        );
    }

    function verifyProof(
        uint256 groupId,
        uint256 merkleTreeDepth,
        uint256 merkleTreeRoot,
        uint256 nullifier,
        uint256 feedback,
        uint256[8] calldata points
    ) external {
        require(
            groupId == groupId_Bomb || groupId == groupId_Star,
            "Invalid groupId"
        );
        ISemaphore.SemaphoreProof memory proof = ISemaphore.SemaphoreProof(
            merkleTreeDepth,
            merkleTreeRoot,
            nullifier,
            feedback,
            groupId,
            points
        );
        semaphore.validateProof(groupId, proof);
    }
}
