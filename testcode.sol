// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import "./lib/PriceTickConvert.sol";

contract Test {
    function getsqrtPrice(uint256 reserve0, uint256 reserve1)
        public
        pure
        returns (uint160 sqrtPriceX96)
    {
        sqrtPriceX96 = PriceTickConvert.encodePriceSqrtFromAmount(reserve0,reserve1);
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
        return PriceTickConvert.tickFromPrice(reserve0,reserve1);
    }
}
