// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RegistrationAD {
    enum Role { Consumer, Provider }

    struct User {
        address userAddress;
        uint256 registrationTime;
        Role role;
    }

    mapping(address => User) public users;
    uint256 public userCount;

    function registerAD(Role role) public {
        // Determine if the user is new
        bool isNewUser = users[msg.sender].userAddress == address(0);

        // Update user details with the latest registration info
        users[msg.sender] = User({
            userAddress: msg.sender,
            registrationTime: block.timestamp,
            role: role
        });

        // Increment the user count only if it's a new user
        if (isNewUser) {
            userCount++;
        }
    }

}
