# **Store Sample Smart Contract**

## **Description**
The `storeSample` smart contract, implemented in **Solidity**, is designed to simulate a basic store on the **Ethereum blockchain**. It facilitates the purchase and inventory management of three types of products: **donuts, cookies, and candies**. Each product is set with a specific price and an initial inventory balance, and the contract ensures that transactions comply with the necessary stock and payment requirements.

## **Features**
- **Contract Owner**: The creator of the contract is automatically set as the owner, who has exclusive rights to restock inventory and withdraw accumulated ethers from the contract's balance.
- **Product Purchasing**: Users can purchase donuts, cookies, and candies, provided there is sufficient inventory and payments are made correctly.
- **Inventory Management**: The owner can add more products to the inventory.
- **Inventory Query**: Any user can check the available stock of any product.
- **Funds Withdrawal**: The owner can withdraw ethers from the contract balance to any specified address.
- **Personal Balances Query**: Users can check the balances of products they have purchased.

## **Technologies Used**
The contract is written in **Solidity version 0.8.13**.

## **How to Test the Contract**
To test the contract:
1. Visit [Remix - Ethereum IDE](https://remix.ethereum.org).
2. Create a new file and paste the code for the `storeSample` contract.
3. Compile the contract using the corresponding Solidity compiler.
4. Deploy the contract in a test environment (e.g., JavaScript VM).
5. Interact with the contract using the available functions in Remix.

## **Contract Functions**
- **purchaseProduct(product _product, uint8 amount)**: Allows for the purchase of specified products.
- **getProductStocks(product _product)**: Returns the available stock of a product.
- **restockCookies(uint amount)**, **restockDonuts(uint amount)**, **restockCandy(uint amount)**: Allows the owner to add more products to the inventory.
- **withdraw(uint amount, address payable destAddr)**: Allows the owner to withdraw ethers from the contract balance.
- **getUserBalances(address user)**: Returns the balances of all products for a specific user.

## **Security and Error Handling**
The contract includes checks to ensure that interactions are valid and secure, such as validating sufficient stock and proper payments before permitting purchases, and restricting access to critical functions to the contract owner only.
