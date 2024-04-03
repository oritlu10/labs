// SPDX-License-Identifier: private
pragma solidity ^0.8.20;

import "@hack/like/IERC20.sol";
import "@hack/erc20/erc20.sol";

contract TestChange in test {
    Change c;
    ERC20 public usdc;
    ERC20 public usdt;
    constructor() {
        c = new Change();
        usdc = ERC20(c.usdc());
        usdt = ERC20(c.usdt());
    }
    function testGetSymbols() public {
        (string memory symbol1, string memory symbol2) = c.getSymbols();
        Assert.equal(symbol1, "myUSDC", "Symbol 1 should be myUSDC");
        Assert.equal(symbol2, "myUSDT", "Symbol 2 should be myUSDT");
    }
    function testChange() public {
        uint256 amount = 100;
        // Transfer tokens to the Change contract
        usdc.transfer(address(c), amount);
        usdc.approve(address(c), amount);
        // Perform token change
        c.change(amount);
        // Check balances after change
        uint256 usdcBalance = usdc.balanceOf(address(this));
        uint256 usdtBalance = usdt.balanceOf(address(this));
        Assert.equal(usdcBalance, amount, "USDC balance should be correct");
        Assert.equal(usdtBalance, amount, "USDT balance should be correct");
    }
}
