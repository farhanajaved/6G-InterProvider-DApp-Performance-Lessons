// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ServiceContract.sol";

contract TransferFunds {
    ServiceContract public serviceContract;

    struct Payment {
        address consumer;
        address provider;
        uint256 amount;
        bool serviceCompleted;
        bool fundsTransferred;
    }

    mapping(uint256 => Payment) public payments; // Mapping from service ID to Payment
    uint256 public nextServiceId; // Counter for unique service IDs

    event ServiceRegistered(uint256 serviceId, address indexed consumer, address indexed provider, uint256 amount);
    event ServiceCompleted(uint256 serviceId, address indexed provider);
    event FundsTransferred(uint256 serviceId, address indexed provider, uint256 amount);

    modifier onlyConsumer(uint256 serviceId) {
        require(msg.sender == payments[serviceId].consumer, "Only the consumer can call this function");
        _;
    }

    modifier serviceExists(uint256 serviceId) {
        require(payments[serviceId].consumer != address(0), "Service does not exist");
        _;
    }

    constructor(address _serviceContract) {
        serviceContract = ServiceContract(_serviceContract);
    }


    // Transfer funds to the provider after service completion
    function transferFunds(uint256 serviceId) public onlyConsumer(serviceId) serviceExists(serviceId) {
        Payment storage payment = payments[serviceId];
        require(payment.serviceCompleted, "Service is not marked as completed");
        require(!payment.fundsTransferred, "Funds have already been transferred");

        payment.fundsTransferred = true;
        payable(payment.provider).transfer(payment.amount);

        emit FundsTransferred(serviceId, payment.provider, payment.amount);
    }

}
