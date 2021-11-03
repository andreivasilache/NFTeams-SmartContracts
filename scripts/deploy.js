// import "firebase/firestore";
const admin = require("firebase-admin");
const { getFirestore } = require("firebase-admin/firestore");

const hre = require("hardhat");
const NFTProviderAbi = require("../artifacts/contracts/NFTProvider.sol/NFTProvider.json");

const serviceAccount = require("../firebase_secret.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = getFirestore();
const smartContractsRef = db.collection("smart-contracts");

async function main() {
  const [deployer] = await ethers.getSigners(); //get the account to deploy the contract

  console.log("Deploying contracts with the account:", deployer.address);

  const NFTProviderContract = await hre.ethers.getContractFactory(
    "NFTProvider"
  ); // Getting the Contract
  const NFTProvider = await NFTProviderContract.deploy(); //deploying the contract

  await NFTProvider.deployed(); // waiting for the contract to be deployed

  console.log("NFTProvider deployed to:", NFTProvider.address); // Returning the contract address

  try {
    await smartContractsRef.doc("NFTProvider").set({
      abi: JSON.stringify(NFTProviderAbi.abi),
      address: NFTProvider.address,
    });
    console.log("Smart contract saved to firebase.");
  } catch (err) {
    console.log("Error deploying smart contract to firebase", err);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); // Calling the function to deploy the contract
