// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@semaphore-protocol/contracts/interfaces/ISemaphore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TicTacToeContract is Ownable {
    ISemaphore public semaphore;

    uint256 public groupId;

    constructor(ISemaphore _semaphore) Ownable(msg.sender) {
        semaphore = _semaphore;
        groupId = semaphore.createGroup();
    }

    function addMember(uint256 identityCommitment) external onlyOwner {
        semaphore.addMember(groupId, identityCommitment);
    }

    function addMembers(
        uint256[] calldata identityCommitments
    ) external onlyOwner {
        semaphore.addMembers(groupId, identityCommitments);
    }

    function updateMember(
        uint256 identityCommitment,
        uint256 newIdentityCommitment,
        uint256[] calldata merkleProofSiblings
    ) external onlyOwner {
        semaphore.updateMember(
            groupId,
            identityCommitment,
            newIdentityCommitment,
            merkleProofSiblings
        );
    }

    function removeMember(
        uint256 identityCommitment,
        uint256[] calldata merkleProofSiblings
    ) external onlyOwner {
        semaphore.removeMember(
            groupId,
            identityCommitment,
            merkleProofSiblings
        );
    }
}
