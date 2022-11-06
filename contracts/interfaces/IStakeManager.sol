// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.9;

import {DataTypes} from "../libraries/DataTypes.sol";
import {IStakeProxy} from "./IStakeProxy.sol";

interface IStakeManager {
    event Staked(address indexed proxy, bytes32 apeOfferHash, bytes32 bakcOfferHash, bytes32 coinOfferHash);
    event UnStaked(address indexed proxy, address indexed staker);

    event FeePaid(address indexed payer, address indexed feeRecipient, uint256 apeCoinAmount);
    event Claimed(address indexed staker, uint256 apeCoinAmount);
    event Withdrawn(address indexed staker, uint256 apeCoinAmount);

    function getStakedProxies(address nftAsset, uint256 tokenId) external view returns (address[] memory);

    function claimable(IStakeProxy proxy, address staker) external view returns (uint256);

    function withdrawable(IStakeProxy proxy, address staker) external view returns (uint256);

    function feeRecipient() external view returns (address);

    function fee() external view returns (uint256);

    function getCurrentApeCoinCap(uint256 poolId) external returns (uint256);

    function updateFeeRecipient(address recipient) external;

    function updateFee(uint256 fee) external;

    function setMatcher(address matcher) external;

    function mintBoundApe(
        address ape,
        uint256 tokenId,
        address to
    ) external;

    function stake(
        DataTypes.ApeStaked memory apeStaked,
        DataTypes.BakcStaked memory bakcStaked,
        DataTypes.CoinStaked memory coinStaked
    ) external;

    function unstake(IStakeProxy proxy) external;

    function claim(IStakeProxy proxy) external;

    function lockFlashloan(address nftAsset, uint256 tokenId) external;

    function borrowETH(
        uint256 amount,
        address nftAsset,
        uint256 nftTokenId
    ) external;
}
