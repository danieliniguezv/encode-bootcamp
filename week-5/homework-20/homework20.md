# Homework 20

Make sure you have completed homework 17 and know how to create a fork of 
mainnet.

## Intercating with Uniswap

We will do this in two stages.

1. Write some unit tests that will interact with Uniswap.
2. Use those unit tests to create a contract to interact with Uniswap.

Today we will just do the first stage.

1. Make a fork of mainnet in the IDE of your preference.
2. Impersonate an account such as the Binance account that has a lot os DAI.
3. Write a unit test to call the ```swapExactInputSingle```function in the 
Uniswap router.
    1. Swap DAI for USDC
    2. Swap DAI for BUSD

Mainnet details:

```
Uniswap V3 router address : 0xE592427A0AEce92De3Edee1F18E0157C05861564
DAI stablecoin address : 0xE592427A0AEce92De3Edee1F18E0157C05861564
Binance Account : 0xDFd5293D8e347dFe59E90eFd55b2956a1343963d
```