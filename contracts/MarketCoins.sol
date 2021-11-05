pragma solidity ^0.8.0;

contract MarketCoins{
    string public name = "NFTeams Marketplace";
    string public symbol = "NFMS";
    mapping(address => uint) balances;

    function sendCointsToAdress(address to, uint amount) external {
        balances[to] += amount;
    }

    function balanceOf(address account) external view returns (uint) {  
        return balances[account];
    }

    function withdrawCoins(address account, uint amount) external returns (uint) {
        balances[account] -= amount;
        return balances[account];
    }

}