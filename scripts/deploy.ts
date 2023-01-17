import { ethers } from "hardhat";

async function main() {
  const dGreeFactory = await ethers.getContractFactory("DGree");
  const dGree = await dGreeFactory.deploy();

  await dGree.deployed();

  console.log(`Deployed dGree to ${dGree.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});