// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@semaphore-protocol/contracts/interfaces/ISemaphore.sol";

contract TicTacToeContract {
    ISemaphore public semaphore;

    uint256 public groupId;

    constructor(ISemaphore _semaphore) {
        semaphore = _semaphore;

        groupId = semaphore.createGroup();
    }

    function addMember(uint256 identityCommitment) external {
        semaphore.addMember(groupId, identityCommitment);
    }

    function addMembers(uint256[] calldata identityCommitments) external {
        semaphore.addMembers(groupId, identityCommitments);
    }

    function updateMember(
        uint256 identityCommitment,
        uint256 newIdentityCommitment,
        uint256[] calldata merkleProofSiblings
    ) external {
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
    ) external {
        semaphore.removeMember(
            groupId,
            identityCommitment,
            merkleProofSiblings
        );
    }
}
