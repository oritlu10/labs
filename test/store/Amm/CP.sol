// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@hack/like/IERC20.sol";
// constant product
contract CP {
       IERC20 public immutable token0;
       IERC20 public immutable token0;

       uint public reserve0;
       uint public reserve1;

       mapping(address => uint public balances;

       constractor(address t0, address t1) {
          token0 = IERC20(t0);
          token1 = IERC20(t1);
       }
