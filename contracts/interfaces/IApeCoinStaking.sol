// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.9;

interface IApeCoinStaking {
    struct SingleNft {
        uint256 tokenId;
        uint256 amount;
    }
    struct PairNftWithAmount {
        uint256 mainTokenId;
        uint256 bakcTokenId;
        uint256 amount;
    }
    struct PairNft {
        uint256 mainTokenId;
        uint256 bakcTokenId;
    }

    struct Position {
        uint256 stakedAmount;
        int256 rewardsDebt;
    }

    struct TimeRange {
        uint256 startTimestampHour;
        uint256 endTimestampHour;
        uint256 rewardsPerHour;
        uint256 capPerPosition;
    }

    struct Pool {
        uint256 lastRewardedTimestampHour;
        uint256 lastRewardsRangeIndex;
        uint256 stakedAmount;
        uint256 accumulatedRewardsPerShare;
        TimeRange[] timeRanges;
    }

    struct DashboardStake {
        uint256 poolId;
        uint256 tokenId;
        uint256 deposited;
        uint256 unclaimed;
        uint256 rewards24hr;
        DashboardPair pair;
    }

    struct DashboardPair {
        uint256 mainTokenId;
        uint256 mainTypePoolId;
    }

    struct PoolUI {
        uint256 poolId;
        uint256 stakedAmount;
        TimeRange currentTimeRange;
    }

    function getCurrentTimeRangeIndex(Pool memory pool) external view returns (uint256);

    function getTimeRangeBy(uint256 _poolId, uint256 _index) external view returns (TimeRange memory);

    function getPoolsUI()
        external
        view
        returns (
            PoolUI memory,
            PoolUI memory,
            PoolUI memory,
            PoolUI memory
        );

    function getSplitStakes(address _address) external view returns (DashboardStake[] memory);

    function stakedTotal(address _addr) external view returns (uint256);

    function pools(uint256 poolId) external view returns (Pool memory);

    function nftPosition(uint256 poolId, uint256 tokenId) external view returns (Position memory);

    function pendingRewards(
        uint256 _poolId,
        address _address,
        uint256 _tokenId
    ) external view returns (uint256);

    function depositBAYC(SingleNft[] calldata _nfts) external;

    function depositMAYC(SingleNft[] calldata _nfts) external;

    function depositBAKC(PairNftWithAmount[] calldata _baycPairs, PairNftWithAmount[] calldata _maycPairs) external;

    function claimBAYC(uint256[] calldata _nfts, address _recipient) external;

    function claimMAYC(uint256[] calldata _nfts, address _recipient) external;

    function claimBAKC(
        PairNft[] calldata _baycPairs,
        PairNft[] calldata _maycPairs,
        address _recipient
    ) external;

    function withdrawBAYC(SingleNft[] calldata _nfts, address _recipient) external;

    function withdrawMAYC(SingleNft[] calldata _nfts, address _recipient) external;

    function withdrawBAKC(PairNftWithAmount[] calldata _baycPairs, PairNftWithAmount[] calldata _maycPairs) external;
}
