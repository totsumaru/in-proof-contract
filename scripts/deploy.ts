import { network } from 'hardhat';
import fs from 'fs';

const { ethers } = require('hardhat');

async function main() {
  const Contract = await ethers.getContractFactory("InProof");
  const nft = await Contract.deploy();

  await nft.deployed();

  const deployPath = 'deploy.json';
  let deployData: Record<string, string> = {};

  // Check if deploy.json exists and read it
  if (fs.existsSync(deployPath)) {
    const rawData = fs.readFileSync(deployPath, 'utf8');
    deployData = JSON.parse(rawData);
  }

  // Update the entry for the current network
  deployData[network.name] = nft.address;

  // Write the updated data back to deploy.json
  fs.writeFileSync(deployPath, JSON.stringify(deployData, null, 2));

  console.log(`✨ NFT deployed to ${network.name}:`, nft.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
