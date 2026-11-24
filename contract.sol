// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title InsightLoop daily on-chain engagement
/// @notice Non-payable, permissionless check-in. Rewards are non-transferable off-chain points.
/// @dev UTC day boundaries. No administrator can override a user's daily eligibility.
contract PINEngagement {
    error AlreadyCheckedIn(uint256 day);

    struct Participation {
        uint64 lastDay;
        uint64 total;
        uint64 streak;
        uint64 lastTimestamp;
    }

    mapping(address => Participation) public participation;

    event CheckedIn(address indexed user, uint256 indexed day, uint256 total, uint256 streak);

    function checkIn() external {
        uint256 day = block.timestamp / 1 days;
        Participation storage user = participation[msg.sender];
        if (user.total > 0 && user.lastDay == day) revert AlreadyCheckedIn(day);
        uint64 streak = user.total > 0 && uint256(user.lastDay) + 1 == day ? user.streak + 1 : 1;
        user.lastDay = uint64(day);
        user.lastTimestamp = uint64(block.timestamp);
        user.total += 1;
        user.streak = streak;
        emit CheckedIn(msg.sender, day, user.total, streak);
    }

    function hasCheckedInToday(address account) external view returns (bool) {
        Participation memory user = participation[account];
        return user.total > 0 && user.lastDay == block.timestamp / 1 days;
    }

    function currentStreak(address account) external view returns (uint256) {
        Participation memory user = participation[account];
        if (user.total == 0 || block.timestamp / 1 days > uint256(user.lastDay) + 1) return 0;
        return user.streak;
    }
}
