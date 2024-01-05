// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Greenzone {
    struct Green {
        address owner;
        address customer;
        string name;
        string image;
        string description;
        uint256 quantity;
        uint256 price;
        uint256 deadline;
        bool sold;
        bool cancelled;
    }
    mapping(uint256 => Green) public greens;
    uint256 public numberOfGreens = 0;

    function publicGreenItem(
        address _owner,
        string memory _name,
        string memory _image,
        string memory _description,
        uint256 _quantity,
        uint256 _price,
        uint256 _deadline
    ) public returns (uint256) {
        Green storage green = greens[numberOfGreens];
        require(
            green.deadline < block.timestamp,
            "The deadline should be a date in the future."
        );
        green.owner = _owner;
        green.name = _name;
        green.image = _image;
        green.description = _description;
        green.quantity = _quantity;
        green.price = _price;
        green.deadline = _deadline;
        numberOfGreens += 1;

        return numberOfGreens - 1;
    }

    function buyGreen(uint256 _id) public payable {
        uint256 amount = msg.value;
        Green storage green = greens[_id];
        require(
            amount == green.price,
            "The value sent is not equal to the price."
        );
        (bool sent, ) = payable(green.owner).call{value: amount}("");
        if (sent) {
            green.customer = msg.sender;
            green.sold = true;
        }
    }

    function cancelGreen(uint256 _id) public {
        Green storage green = greens[_id];
        green.cancelled = true;
    }

    function getGreen(uint256 _id) public view returns (Green memory) {
        return greens[_id];
    }

    function getGreens() public view returns (Green[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < numberOfGreens; i++) {
            Green storage item = greens[i];
            if (!item.cancelled && !item.sold) {
                count++;
            }
        }
        Green[] memory allGreens = new Green[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < numberOfGreens; i++) {
            Green storage item = greens[i];
            if (!item.cancelled && !item.sold) {
                allGreens[index] = item;
                index++;
            }
        }
        return allGreens;
    }

    function getNumberOfPublicGreens() public view returns (uint256) {
        uint256 count = 0;
        for (uint256 i = 0; i < numberOfGreens; i++) {
            Green storage item = greens[i];
            if (!item.cancelled && !item.sold) {
                count++;
            }
        }
        return count;
    }

    function getAllGreens() public view returns (Green[] memory) {
        Green[] memory allGreens = new Green[](numberOfGreens);
        for (uint256 i = 0; i < numberOfGreens; i++) {
            Green storage item = greens[i];
            allGreens[i] = item;
        }
        return allGreens;
    }

    function getAllBoughtGreens(address _customer) public view returns (Green[] memory) {
         uint256 count = 0;
        for (uint256 i = 0; i < numberOfGreens; i++) {
            Green storage item = greens[i];
            if (item.customer == _customer) {
                count++;
            }
        }
        Green[] memory allGreens = new Green[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < numberOfGreens; i++) {
            Green storage item = greens[i];
            if (item.customer == _customer) {
                allGreens[index] = item;
                index++;
            }
        }
        return allGreens;
    }
}
