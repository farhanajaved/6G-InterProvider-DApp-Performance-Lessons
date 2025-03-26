// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./RegistrationAD.sol";

contract AddService {
    RegistrationAD public registration;

    constructor(address registrationAddress) {
        registration = RegistrationAD(registrationAddress);
    }

    struct Service {
        address provider;
        string serviceId; // Unique service identifier
        string location;
        uint256 cost;
        string ipfsHash; // IPFS hash for the service metadata
    }

    Service[] public services;
    mapping(address => uint256[]) public providerServices;

    event ServiceAdded(address indexed provider, uint256 serviceIndex, string serviceId);
    event ServicePublishedToIPFS(address indexed provider, uint256 serviceIndex, string ipfsHash);

    // Function to add a new service
    function addService(string memory serviceId, string memory location, uint256 cost) public {
        require(registration.isRegistered(msg.sender), "Not registered");
        require(registration.getUserRole(msg.sender) == RegistrationAD.Role.Provider, "Not a provider");

        services.push(Service(msg.sender, serviceId, location, cost, ""));
        uint256 serviceIndex = services.length - 1;
        providerServices[msg.sender].push(serviceIndex);

        emit ServiceAdded(msg.sender, serviceIndex, serviceId);
    }
}
