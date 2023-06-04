// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Policy {
        uint256 id;
        string policyName;
        uint256 premium;
        uint256 coverage;
        uint256 duration;
        address insurer;
        address holder;
        bool isActive;
    }

    uint256 public policyCount;
    mapping(uint256 => Policy) public policies;

    function createPolicy(
        string memory _policyName,
        uint256 _premium,
        uint256 _coverage,
        uint256 _duration,
        address _holder
    ) public returns (uint256) {
        policyCount++;
        policies[policyCount] = Policy(
            policyCount,
            _policyName,
            _premium,
            _coverage,
            _duration,
            msg.sender,
            _holder,
            true
        );
        return policyCount;
    }

    function cancelPolicy(uint256 _policyId) public {
        Policy storage policy = policies[_policyId];
        require(policy.holder == msg.sender, "You are not the policy holder");
        require(policy.isActive == true, "Policy is not active");
        policy.isActive = false;
    }
}