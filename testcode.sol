// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import "./lib/PriceTickConvert.sol";

contract Test {
    function getsqrtPrice(uint256 reserve0, uint256 reserve1)
        public
        pure
        returns (uint160 sqrtPriceX96)
    {
        sqrtPriceX96 = PriceTickConvert.encodePriceSqrtFromAmount(
            reserve0,
            reserve1
        );
    }

    function getTickFromSqrtPrice(uint160 sqrtPriceX96)
        public
        pure
        returns (int24 tick)
    {
        return PriceTickConvert.getTickFromSqrtPrice(sqrtPriceX96);
    }

    function getTickFromPrice(uint256 reserve0, uint256 reserve1)
        public
        pure
        returns (int24 tick)
    {
        //uint160 sp =  PriceTickConvert.encodePriceSqrtFromAmount(reserve1,reserve0);
        return PriceTickConvert.tickFromPrice(reserve0, reserve1);
    }

    function tokenInAmoutFromPrice(
        int24 curTick,
        int24 lowerTick,
        int24 upperTick,
        uint256 amount0InDesried,
        uint256 amount1InDesried
    )
        public
        pure
        returns (
            uint128 liquidity,
            int256 amount0In,
            int256 amount1In
        )
    {
        return
            PriceTickConvert.tokenInAmoutFromTick(
                curTick,
                lowerTick,
                upperTick,
                amount0InDesried,
                amount1InDesried
            );
    }
}
