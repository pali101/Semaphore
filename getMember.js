import { SemaphoreSubgraph } from "@semaphore-protocol/data"
import { Identity } from "@semaphore-protocol/identity"
import { Group } from "@semaphore-protocol/group"

async function main() {
    const identity1 = new Identity("Bomb")
    const identity2 = new Identity("Star")
    const semaphoreSubgraph = new SemaphoreSubgraph("sepolia")

    const groupOnchain = await semaphoreSubgraph.getGroup("81")
    console.log(groupOnchain)

    const { members } = await semaphoreSubgraph.getGroup("81", { members: true })

    console.log(members)
}

main()

[
    '5936115432148947984251346549819389071579568864114081774754153512449036237424',
    '8619212447955244524756806054863413032909038435803404431572781958042597084590',
    '10879816846374803187782192184349638366142740911864759579429330054032172440051',
    '12116642700503529292565343040451094503417765305702001119287006467139058532071'
]