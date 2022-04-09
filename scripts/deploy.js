// import "firebase/firestore";
const admin = require("firebase-admin");
const { getFirestore } = require("firebase-admin/firestore");

const hre = require("hardhat");

const serviceAccount = require("../firebase_secret.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = getFirestore();
const smartContractsRef = db.collection("smart-contracts");

async function main() {
  const [deployer] = await ethers.getSigners(); //get the account to deploy the contract

  const contracts = ["MarketCoins"];

  console.log(`Deploying contract(s): ${contracts.toString()}`);
  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());
  for (const contract of contracts) {
    const contractArtifact = await hre.ethers.getContractFactory(contract); // Getting the Contract

    const deployInstance = await contractArtifact.deploy(); //deploying the contract

    await deployInstance.deployed(); // waiting for the contract to be deployed

    console.log(`${contract} deployed to:${deployInstance.address}`);

    try {
      const ContractABI = require(`../artifacts/contracts/${contract}.sol/${contract}.json`);

      await smartContractsRef.doc(`${contract}_matic`).set({
        abi: JSON.stringify(ContractABI.abi),
        address: deployInstance.address,
      });
      console.log(`${contract} contract metadata saved to firebase.`);
    } catch (err) {
      console.log("Error deploying smart contract to firebase", err);
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); // Calling the function to deploy the contract
