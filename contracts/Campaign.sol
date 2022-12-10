// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Crowdfunding {
    constructor() {}
    
    struct Campaign {
        address owner;
        stringtitle;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
    }

    mapping (uint256 => Campaign) public Campaign;

    uint256 public numberOfCampaigns = 0;

    function createCampaign(address _owner,
        string memory _title,
        string memory _description,
        uint256 _target,
        uint256 _deadline,
        uint256 _amountCollected,
        string memory _image
    )  public returns (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns];

        // is everything ok ?
        require (campaign.deadline < block.timestamp, "Deadline must be in the future");
    }

    function donateToCampaign()  returns () {
        
    }

    function getDonators()  returns () {
        
    }

    function getCampaigns()  returns () {
        
    }
}