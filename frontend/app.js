import { ethers } from 'ethers';  // Import ethers if using npm or bundler

let simpleStorage;
let provider;
let signer;
 
const connectButton = document.getElementById("connectButton");
const setValueButton = document.getElementById("setValueButton");
const getValueButton = document.getElementById("getValueButton");
const currentValueElement = document.getElementById("currentValue");
const valueToSetInput = document.getElementById("valueToSet");

// Contract ABI and address (replace with your contract's deployed address)
const contractABI = [
    "function set(uint256 x) public",
    "function get() public view returns (uint256)"
];

const contractAddress = "0xb49a5e13Ca3FE16d3Bf62FEB439e87F9a349F416"; // Replace with the actual address

connectButton.addEventListener("click", async () => {
    if (typeof window.ethereum !== "undefined") {
        try {
            // Connect to MetaMask
            await window.ethereum.request({ method: "eth_requestAccounts" });
            provider = new ethers.JsonRpcProvider(window.ethereum);
            signer = provider.getSigner();
            simpleStorage = new ethers.Contract(contractAddress, contractABI, signer);
            connectButton.textContent = "Connected to MetaMask";
        } catch (error) {
            console.error("Error connecting to MetaMask:", error);
        }
    } else {
        alert("Please install MetaMask.");
    }
});

setValueButton.addEventListener("click", async () => {
    const valueToSet = valueToSetInput.value;
    if (valueToSet && simpleStorage) {
        try {
            // Set value in contract
            const tx = await simpleStorage.set(valueToSet);
            await tx.wait();
            alert("Value set successfully!");
        } catch (error) {
            console.error("Error setting value:", error);
        }
    }
});

getValueButton.addEventListener("click", async () => {
    if (simpleStorage) {
        try {
            // Get value from contract
            const value = await simpleStorage.get();
            currentValueElement.textContent = `Stored Value: ${value}`;
        } catch (error) {
            console.error("Error getting value:", error);
        }
    }
});
