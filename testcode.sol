// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import "./lib/PriceTickConvert.sol";

contract Test {
    function getsqrtPrice(uint256 reserve0, uint256 reserve1)
        public
        pure
        returns (uint160 sqrtPriceX96)
    {
        sqrtPriceX96 = PriceTickConvert.encodePriceSqrt(reserve0, reserve1);
    }

    function getTickFromSqrtPrice(uint160 sqrtPriceX96)
        public
        pure
        returns (int24 tick)
    {
        return PriceTickConvert.getTickFromSqrtPrice(sqrtPriceX96);
    }
}
