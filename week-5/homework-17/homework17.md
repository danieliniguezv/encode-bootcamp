# Homework 17

1. Create a fork of mainnet.
2. On the command line check the current block height, is this what you expected?
3. Can you transfer ETH form one of Vitalik's accounts to your own account?

## Creating a fork of mainnet

See also lesson 9.
See hardhat [documentation](https://hardhat.org/hardhat-network/docs/guides/forking-other-networks).

1. Create an account on [Infura](https://www.infura.io/) or [Alchemy](https://www.alchemy.com/). This will allow for you to hold a key to use their RPC nodes.

### Forking using Ganache
```npx ganache-cli --f https://mainnet.infura.io/v3/<your key> -m “your 12 word mnemonic” --unlock <address> -i <chain ID>```

### Forking using Hardhat
```npx hardhat node --fork https://ethmainnet.alchemyapi.io/v2/<your key>```

In Hardhat you can also specify this in the config file:
``` networks: {
        hardhat: {
            forking: {
                url: ""https://eth-mainnet.alchemyapi.io/v2/<key>"
            }
        }
    } ```