import { Identity } from "@semaphore-protocol/identity"
import { Group } from "@semaphore-protocol/group"
import { generateProof, verifyProof } from "@semaphore-protocol/proof"
import { Wallet } from 'ethers';

async function main() {
    const identity1 = new Identity(Wallet.createRandom().privateKey)
    const identity2 = new Identity(Wallet.createRandom().privateKey)

    console.log(identity1._commitment)
    // console.log(publicKey, commitment)


    // const identity2 = new Identity(privateKey)
    console.log(identity2._commitment)

    // const message = "Hello World"
    // const signature = identity1.signMessage(message)
    // console.log(signature)
    // console.log(Identity.verifySignature(message, signature, identity1.publicKey))

    let members = [identity1._commitment, identity2._commitment]

    let group1 = new Group(members)

    const identity3 = new Identity(Wallet.createRandom().privateKey)
    const identity4 = new Identity(Wallet.createRandom().privateKey)
    group1.addMember(identity3._commitment)
    group1.addMember(identity4._commitment)

    // console.log(group1.generateMerkleProof(0))

    const scope = group1.root
    const message = 1000

    const proof = await generateProof(identity1, group1, message, scope)
    console.log(proof)

    let v = await verifyProof(proof)
    console.log(v)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error("Error:", error);
        process.exit(1);
    });