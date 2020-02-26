# Wepy Wallet

This repo is mirroring the [fuse-wallet](http://github.com/fuseio/fuse-wallet)
repository. Follow the instructions bellow to be able to pull changes from
fuse-wallet and at the same time, keeping the differences.
The mirror strategy is because Github does not allow the creation of private forks for public repositories.

The correct way of creating a private frok by duplicating the repo is documented [here](https://help.github.com/articles/duplicating-a-repository/).

 1. You can now clone your `wepy-wallet` repository on your machine (in my case in the `code` folder).
    ```bash
    cd ~/code
    git clone git@github.com:henry-hz/wepy-wallet.git
    ```
 2. If you want, add the original repo as remote to fetch (potential) future changes.
    Make sure you also disable push on the remote (as you are not allowed to push to it anyway).
    ```bash
    git remote add upstream https://github.com/fuseio/fuse-wallet.git
    git remote set-url --push upstream DISABLE
    ```
    You can list all your remotes with `git remote -v`. You should see:
    ```
    origin  git@github.com:henry-hz/wepy-wallet.git (fetch)
    origin  git@github.com:henry-hz/wepy-wallet.git (push)
    upstream        https://github.com/fuseio/fuse-wallet.git (fetch)
    upstream        DISABLE (push)
    ```
    > When you push, do so on `origin` with `git push origin`.
   
    > When you want to pull changes from `upstream` you can just fetch the remote and rebase on top of your work.
    ```bash
      git fetch upstream
      git rebase upstream/master
      ```
      And solve the conflicts if any


# Fuse Wallet

The Fuse Wallet is a cross platform Ethereum wallet written in Dart and built on [Flutter](https://flutter.dev/). It's runninng on the Fuse network, but can be plugged into any EVM compatible blockchain.

# Architecture

The Fuse Wallet built upon the [wallet-core SDK](https://github.com/fuseio/wallet_core), which provides a set of API's for the Fuse platform and its auxiliary services. Those services include:
- The Fuse Network and the networks' smart contracts, via the [web3dart](https://github.com/simolus3/web3dart) package
- The [graphql API](https://graph.fuse.io/subgraphs/name/fuseio/fuse/graphql) (provided by [theraph's node](https://thegraph.com/)) provides a convinient API for reading from the network. More info about the API can be found [here](https://github.com/fuseio/fuse-graph)
- The relayer service for fee abstraction
- The [fuse-studio](https://github.com/fuseio/fuse-studio) backend API for business logic and data
- [3box](https://3box.io/) to store user's private and public data in a decentralized manner.
- [IPFS](https://ipfs.io/) to store other public data, e.g. businesses data and images.

## Smart Contracts

We developed and deployed a set of smart contracts, which the wallet interacts with:
- To avoid developing our own best practices and try to adhere to the indusry standarts we used [Argent-contracts](https://github.com/fuseio/argent-contracts), that were taken from the popular [wallet](https://www.argent.xyz/). These contracts are the core of wallet's logic on the Network. Using them, our users are sending free transactions (fee abstraction), have rate limits, and can use wallet recovery. More interesting features will be developed on their basis.
- [Token contracts](https://github.com/fuseio/fuse-studio/tree/master/contracts/token-factory) complying to ERC20 standard
- [Community contracts](https://github.com/fuseio/fuse-studio/tree/master/contracts/entities) to create a tied in interaction between users, businesses and other entities.

## Download the App

You can download the beta version of our app from the [Google Play](https://play.google.com/store/apps/details?id=io.fuse.fusecash&hl=en) or the [App Store](https://apps.apple.com/us/app/fuse-wallet/id1491783654?ls=1)

## Getting Started

## As a developer
- Set a Flutter environment on your machine, you can start from [here](https://flutter.dev/docs/get-started/install)
- Connect a phone or run a simulator
- Then clone the project and run futter
```
 git clone https://github.com/fuseio/fuse-wallet2.0.git
 cd fuse-wallet2.0
 flutter run
```

## As an enterprenuer or a community manager
Launch your community on the [Fuse Studio](https://studio.fuse.io/), then open the community dashboard. There you can configure it and *customize your wallet* app. When you done go to "White label wallet" and send an app invite link to yourself. Visit our [docs](https://docs.fuse.io/the-fuse-studio/overview) to learn about the Fuse Studio.
