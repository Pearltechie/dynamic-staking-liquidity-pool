const depositBtn = document.getElementById('deposit-btn');
const claimRewardsBtn = document.getElementById('claim-rewards-btn');
const checkStakedBtn = document.getElementById('check-staked-btn');
const checkTotalStakedBtn = document.getElementById('check-total-staked-btn');
const responseDiv = document.getElementById('response');

const client = new StacksClient({
    network: StacksNetwork.Mainnet,
    app: 'dynamic-staking-liquidity-pool',
});

depositBtn.addEventListener('click', async () => {
    const amount = prompt("Enter amount of liquidity to deposit:");
    await callClarityFunction('deposit-liquidity', [amount]);
});

claimRewardsBtn.addEventListener('click', async () => {
    await callClarityFunction('claim-rewards', []);
});

checkStakedBtn.addEventListener('click', async () => {
    await callClarityFunction('get-staked-balance', []);
});

checkTotalStakedBtn.addEventListener('click', async () => {
    await callClarityFunction('get-total-staked', []);
});

async function callClarityFunction(functionName, args) {
    try {
        const response = await client.callContract(functionName, args);
        responseDiv.innerHTML = `Response: ${response}`;
    } catch (error) {
        responseDiv.innerHTML = `Error: ${error.message}`;
    }
}
