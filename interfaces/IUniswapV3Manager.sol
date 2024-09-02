// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.14;

interface IUniswapV3Manager {
    struct GetPositionParams {
        address tokenA;
        address tokenB;
        uint24 fee;
        address owner;
        int24 lowerTick;
        int24 upperTick;
    }
// ["0x4a9C121080f6D9250Fc0143f41B595fD172E31bf","0x540d7E428D5207B30EE03F2551Cbb5751D3c7569",500,1000000000000000000,1800000000,2200000000,1000000000000000000,2000000000,0,0]
    struct MintParams {
        address tokenA;
        address tokenB;
        uint24 fee;
        uint256 reserve0;
        uint256 lowerReserve1;
        uint256 upperReserve1;
        uint256 amount0Desired;
        uint256 amount1Desired;
        uint256 amount0Min;
        uint256 amount1Min;
    }

    struct SwapSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        uint256 amountIn;
        uint160 sqrtPriceLimitX96;
    }

    struct SwapParams {
        bytes path;
        address recipient;
        uint256 amountIn;
        uint256 minAmountOut;
    }

    struct SwapCallbackData {
        bytes path;
        address payer;
    }
}
