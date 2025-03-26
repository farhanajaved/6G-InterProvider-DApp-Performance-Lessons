// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SLA.sol";
import "./PenaltyCalculation.sol";

contract ServiceContract {
    SLA public slaContract;
    PenaltyCalculation public penaltyContract;

    address public consumer;
    address public provider;
    uint256 public serviceId;

    event BreachDetected(address indexed provider, uint256 breachCount);
    event PenaltyTriggered(address indexed provider, uint256 penalty);

    constructor(
        address _penaltyContractAddress,
        address _consumer,
        address _provider,
        uint256 _serviceId
    ) {
        penaltyContract = PenaltyCalculation(_penaltyContractAddress);
        consumer = _consumer;
        provider = _provider;
        serviceId = _serviceId;
    }
}
