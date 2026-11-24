# InsightLoop Engagement Contract

A Solidity smart contract for recording daily on-chain engagement check-ins. The contract is designed for the InsightLoop application and tracks each wallet's total check-ins and consecutive-day streak.

## BNB Chain and BSC Deployment

This contract is deployed on **BNB Smart Chain (BSC)**, the EVM-compatible blockchain in the BNB Chain ecosystem. BNB Chain provides a decentralized network for running smart contracts and decentralized applications, while BSC supports Ethereum-compatible tooling and Solidity contracts.

Use a BSC-compatible wallet and select the correct BSC network when interacting with the deployed contract. Transactions on BSC require network gas, paid in BNB. The deployment address and explorer link are not included in this repository; obtain them from the official InsightLoop deployment information before interacting with a live instance.

## Contract Overview

The source defines `PINEngagement`, a permissionless, non-payable check-in contract:

- Any wallet can call `checkIn()` once per UTC day.
- Successful check-ins update the caller's total check-in count and consecutive-day streak.
- Missing a UTC day resets the streak on the next check-in.
- The `CheckedIn` event records the user, UTC day, total check-ins, and streak.
- `hasCheckedInToday(address)` reports whether an account has checked in during the current UTC day.
- `currentStreak(address)` returns the current streak, or zero when it has expired.
- The contract does not issue on-chain tokens. Any associated rewards are off-chain points and are non-transferable.
- There is no administrator function to override a user's daily eligibility.

## Source

- [`contract.sol`](./contract.sol) — Solidity implementation (`^0.8.28`)
- [`config.json`](./config.json) — compiler settings

## Build and Deployment

The repository contains the Solidity source and compiler configuration. Compile with Solidity `0.8.28` or a compatible later `0.8.x` compiler, using the settings in `config.json`.

The contract is deployed on BSC. This repository does not include deployment scripts, a verified contract address, or a specific BSC network designation (such as Mainnet or Testnet). Confirm the official deployment details before compiling or interacting with a deployment.

## License

The contract source is provided under the MIT License.
