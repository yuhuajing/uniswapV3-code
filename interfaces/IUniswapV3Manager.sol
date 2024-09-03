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
// ["0x6160D0Ca6ad8AA9Cc68d143D01591d8050b7dD9f","0xf02A102153DDf132032B7De5D19F43aA049052Dd",500,-201360,-199360,1000000000000000000,2000000000,0,0]
    struct MintParams {
        address tokenA;
        address tokenB;
        uint24 fee;
        // uint256 reserve0;
        // uint256 lowerReserve1;
        // uint256 upperReserve1;
        int24 tickLower;
        int24 tickUpper;
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
