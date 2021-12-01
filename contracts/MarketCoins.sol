pragma solidity ^0.8.0;

contract MarketCoins{
    string public name = "NFTeams Marketplace";
    string public symbol = "NFMS";
    mapping(address => uint) balances;

    function sendCoinsToAdress(address to, uint amount) external {
        balances[to] += amount;
    }
    function sendCoinsToAdresses(address[] memory to, uint amount) external {
        for(uint index = 0; index<to.length; index++){
            this.sendCoinsToAdress(to[index], amount);
        }
    }

    function balanceOf(address account) external view returns (uint) {  
        return balances[account];
    }

    function withdrawCoins(address account, uint amount) external returns (uint) {
        balances[account] -= amount;
        return balances[account];
    }

}