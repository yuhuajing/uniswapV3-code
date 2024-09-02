// SPDX-License-Identifier: GPL2.0
// https://github.com/gakonst/v3-periphery-foundry/blob/main/contracts/foundry-tests/utils/Math.sol#L6
pragma solidity ^0.8.0;

uint256 constant PRECISION = 2**96;
import "./TickMath.sol";
import "./LiquidityMath.sol";
import "./Math.sol";

library PriceTickConvert {
    // Computes the sqrt of the u64x96 fixed point price given the AMM reserves
    function encodePriceSqrtFromAmount(uint256 reserve0, uint256 reserve1)
        internal
        pure
        returns (uint160)
    {
        return uint160(sqrt((reserve1 * PRECISION * PRECISION) / reserve0));
    }

    function tickFromPrice(uint256 reserve0, uint256 reserve1)
        internal
        pure
        returns (int24)
    {
        uint160 sqrtp = uint160(
            sqrt((reserve1 * PRECISION * PRECISION) / reserve0)
        );
        return getTickFromSqrtPrice(sqrtp);
    }

    function getTickFromSqrtPrice(uint160 sqrtPriceX96)
        internal
        pure
        returns (int24 tick)
    {
        return TickMath.getTickAtSqrtRatio(sqrtPriceX96);
    }

    function getSqrtPriceFromTick(int24 tick)
        internal
        pure
        returns (uint160 sqrtPriceX96)
    {
        return TickMath.getSqrtRatioAtTick(tick);
    }

    function tokenInAmoutFromPrice(
        // uint256 Reserve0,
        // uint256 targetReserve1,
        // uint256 lowerReserve1,
        // uint256 upperReserve1,
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
        uint160 srqtTarget = getSqrtPriceFromTick(curTick);
        uint160 srqtLower = getSqrtPriceFromTick(lowerTick);
        uint160 srqtUpper = getSqrtPriceFromTick(upperTick);
        liquidity = LiquidityMath.getLiquidityForAmounts(
            srqtTarget,
            srqtLower,
            srqtUpper,
            amount0InDesried,
            amount1InDesried
        );

        amount0In = ProMath.calcAmount0Delta(
            srqtTarget,
            srqtUpper,
            int128(liquidity)
        );
        amount1In = ProMath.calcAmount1Delta(
            srqtLower,
            srqtTarget,
            int128(liquidity)
        );
    }

    // Fast sqrt, taken from Solmate.
    function sqrt(uint256 x) internal pure returns (uint256 z) {
        assembly {
            // Start off with z at 1.
            z := 1

            // Used below to help find a nearby power of 2.
            let y := x

            // Find the lowest power of 2 that is at least sqrt(x).
            if iszero(lt(y, 0x100000000000000000000000000000000)) {
                y := shr(128, y) // Like dividing by 2 ** 128.
                z := shl(64, z) // Like multiplying by 2 ** 64.
            }
            if iszero(lt(y, 0x10000000000000000)) {
                y := shr(64, y) // Like dividing by 2 ** 64.
                z := shl(32, z) // Like multiplying by 2 ** 32.
            }
            if iszero(lt(y, 0x100000000)) {
                y := shr(32, y) // Like dividing by 2 ** 32.
                z := shl(16, z) // Like multiplying by 2 ** 16.
            }
            if iszero(lt(y, 0x10000)) {
                y := shr(16, y) // Like dividing by 2 ** 16.
                z := shl(8, z) // Like multiplying by 2 ** 8.
            }
            if iszero(lt(y, 0x100)) {
                y := shr(8, y) // Like dividing by 2 ** 8.
                z := shl(4, z) // Like multiplying by 2 ** 4.
            }
            if iszero(lt(y, 0x10)) {
                y := shr(4, y) // Like dividing by 2 ** 4.
                z := shl(2, z) // Like multiplying by 2 ** 2.
            }
            if iszero(lt(y, 0x8)) {
                // Equivalent to 2 ** z.
                z := shl(1, z)
            }

            // Shifting right by 1 is like dividing by 2.
            z := shr(1, add(z, div(x, z)))
            z := shr(1, add(z, div(x, z)))
            z := shr(1, add(z, div(x, z)))
            z := shr(1, add(z, div(x, z)))
            z := shr(1, add(z, div(x, z)))
            z := shr(1, add(z, div(x, z)))
            z := shr(1, add(z, div(x, z)))

            // Compute a rounded down version of z.
            let zRoundDown := div(x, z)

            // If zRoundDown is smaller, use it.
            if lt(zRoundDown, z) {
                z := zRoundDown
            }
        }
    }
}
