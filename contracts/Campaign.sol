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

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = _amountCollected;
        campaign.image = _image;

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }

    function donateToCampaign(uint256 _id) public payable  returns () {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];
        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        (bool sent,) = payable(campaign.owner).call{value: amount}("");

        if (sent) {
            campaign.amountCollected += amount;
        }
    }

    function getDonators(uint256 _id) view public returns (address[] memory, uint256 memory) {
        return campaigns[_id].donators, campaigns[_id].donations;
    }

    function getCampaigns() public view returns (Campaign memory) {
        Campaign[] memory AllCampaigns = new Campaign[](numberOfCampaigns);
        
        for (uint i = 0; i < numberOfCampaigns; i++) {
            Campaign storage item = campaign[i];

            AllCampaigns[i] = item;
        }

        return AllCampaigns;
    }
}