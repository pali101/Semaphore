import { Identity } from "@semaphore-protocol/identity"
import { Group } from "@semaphore-protocol/group"
import { generateProof, verifyProof } from "@semaphore-protocol/proof"
import { Wallet } from 'ethers';
import { encodeBytes32String } from "ethers"
import { SemaphoreSubgraph } from "@semaphore-protocol/data"

async function main() {
    const identity1 = new Identity("Bomb")
    const identity2 = new Identity("Star")
    const semaphoreSubgraph = new SemaphoreSubgraph("sepolia")

    console.log(identity1._commitment, "Commitment 1")
    // console.log(publicKey, commitment)


    // const identity2 = new Identity(privateKey)
    console.log(identity2._commitment, "Commitment 2")

    // const message = "Hello World"
    // const signature = identity1.signMessage(message)
    // console.log(signature)
    // console.log(Identity.verifySignature(message, signature, identity1.publicKey))

    // let members = [identity1._commitment.toString(), identity2._commitment.toString()]
    // console.log(members)
    const groupOnchain = await semaphoreSubgraph.getGroup("81")
    console.log(groupOnchain)
    const groupOffchain = new Group()

    const { members } = await semaphoreSubgraph.getGroup("81", { members: true })

    console.log(members)

    const identity3 = new Identity('176-0-1-Star')
    const identity4 = new Identity('176-1-1-Bomb')
    groupOffchain.addMember(identity1._commitment)
    groupOffchain.addMember(identity2._commitment)
    groupOffchain.addMember(identity3._commitment)
    groupOffchain.addMember(identity4._commitment)
    console.log(identity1._commitment, "Commitment 1")
    console.log(identity3._commitment, "Commitment 3")
    console.log(identity4._commitment, "Commitment 4")

    // // // console.log(group1.generateMerkleProof(0))

    const scope = groupOffchain.root
    // console.log(scope)
    const message = '1000'
    const feedback = encodeBytes32String(message)
    // feedback - onchain contract is encodeBytes32String(message), group Id is the group you're tryng to prove identity is a part of, points are generated via proof (convert them to int before sending to contract)
    const proof = await generateProof(identity1, groupOffchain, feedback, '81')
    console.log(proof)
    // // console.log(JSON.stringify(proof).length)


    // let v = await verifyProof(proof)
    // console.log(v)
    const isMember = await semaphoreSubgraph.isGroupMember(
        "81",
        "10879816846374803187782192184349638366142740911864759579429330054032172440051"
    )
    console.log(isMember)
    const verifiedProofs = await semaphoreSubgraph.getGroupValidatedProofs("81")
    console.log(verifiedProofs)

    console.log(groupOffchain.generateMerkleProof(0))
    groupOffchain.removeMember(0)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error("Error:", error);
        process.exit(1);
    });

