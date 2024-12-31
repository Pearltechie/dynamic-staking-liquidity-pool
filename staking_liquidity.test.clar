const { assertEquals, assertRejects } = require('@stacks/clarinet');
const { chain } = require('@stacks/clarinet');

describe('Dynamic Staking and Liquidity Pool', () => {

    it('should deposit liquidity successfully', async () => {
        const block = await chain.mineBlock([
            chain.callContract('staking-liquidity.deposit-liquidity', [1000]),
        ]);
        assertEquals(block.receipts[0].result, '(ok "Liquidity deposited successfully!")');
    });

    it('should claim rewards successfully', async () => {
        const block = await chain.mineBlock([
            chain.callContract('staking-liquidity.claim-rewards', []),
        ]);
        assertEquals(block.receipts[0].result, '(ok "Rewards claimed: 100")');
    });

    it('should check the staked balance of a user', async () => {
        const block = await chain.mineBlock([
            chain.callContract('staking-liquidity.get-staked-balance', []),
        ]);
        assertEquals(block.receipts[0].result, '(ok "Staked liquidity: 1000")');
    });

    it('should check the total liquidity staked in the pool', async () => {
        const block = await chain.mineBlock([
            chain.callContract('staking-liquidity.get-total-staked', []),
        ]);
        assertEquals(block.receipts[0].result, '(ok "Total liquidity staked: 1000")');
    });
});
