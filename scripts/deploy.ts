const { ethers } = require('hardhat');
const { writeFileSync } = require('fs');

async function main() {
  const Contract = await ethers.getContractFactory("InProof");
  const nft = await Contract.deploy();

  await nft.deployed();

  writeFileSync('deploy.json', JSON.stringify({
    Contract: nft.address,
  }, null, 2));

  console.log("✨ NFT deployed to:", nft.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });