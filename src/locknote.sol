//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {ERC721_address_specific} from './ERC721_address_specific.sol';
import {svg} from './SVG.sol';
import {json} from './JSON.sol';
import {utils} from './Utils.sol';
import {WordWrap} from './WordWrap.sol';

contract LockNote is ERC721_address_specific {
    
    uint256 constant MAX_MESSAGE = 280;
    uint256 MESSAGE_PRICE = 0.0042069 ether;
    address payable public deployer; 

    constructor () 
        ERC721_address_specific("Lock Note", unicode"🔏")
        {
            deployer = payable(msg.sender);
        }

    struct MESSAGE {
        string text;
        address sender;
    }

    mapping (uint256 => MESSAGE) public messages;



    function tokenURI(uint256 id) public view override returns (string memory) {
        require(ownerOf(id) == getAddressfromId(id), "NOT MINTED");
        MESSAGE memory _message = messages[id];

        WordWrap.WordWrapInfo memory bodyTextFormatting = WordWrap.WordWrapInfo({
            line_width: 39,
            x: 10,
            yFirst: 55,
            spacing: 20 
        });

        return json.formattedMetadata(
            'Lock Note',
            'Lock Note is an NFT based messaging application. Users can mint a message up to 280 characters long to any address, which can only be burned by the owner of that address. Have fun with Lock Note however you like.',
            svg._svg(
                    'viewBox="0 0 350 215"',
                    string.concat(
                        svg.rect(
                            string.concat(
                                'width="350" height="215" ',
                                'fill="gainsboro" ',
                                'stroke="DarkGray" stroke-width="3"'
                            )
                        ),
                        svg.text(
                            'x="285" y="20" font-family="sans-serif" font-size="12px" font-style="italic"',
                            'Lock Note'
                        ),
                        svg.text(
                            'x="10" y="35" font-family="sans-serif" font-size="12px" font-style="italic"',
                            utils.toHexString(getIdfromAddress(_message.sender))
                        ),
                        svg.text(
                            'font-family="monospace, Courier New" font-size="12px" fill="steelblue"',
                            WordWrap.toElement(_message.text, bodyTextFormatting)
                        )
                    )
            )
        );
    }

    function getIdfromAddress(address user) public pure returns (uint256) {
        return uint256(uint160(user));
    }

    function getAddressfromId(uint256 id) public pure returns (address) {
        return address(uint160(id));
    }

    function readText(address user) public view returns (string memory) {
        require(balanceOf(user) != 0, "NOT MINTED");

        return messages[getIdfromAddress(user)].text;
    }

    function readSender(address user) public view returns (address) {
        require(balanceOf(user) != 0, "NOT MINTED");

        return messages[getIdfromAddress(user)].sender;
    }

    function mint(address to, string memory message) public payable {
        require(msg.value >= MESSAGE_PRICE, "INSUFFICIENT PAYMENT");
        require(utils.utfStringLength(message) <= MAX_MESSAGE, 'MSG TOO LONG');
        uint256 _id = getIdfromAddress(to);
        messages[_id].text = message;
        messages[_id].sender = msg.sender;
        _mint(to, _id);
    }

    function burn() public payable {
        require(msg.value >= MESSAGE_PRICE, "INSUFFICIENT PAYMENT");
        uint256 _id = getIdfromAddress(msg.sender);
        messages[_id].text = ' ';
        messages[_id].sender = address(0);
        _burn(_id);
    }

    function withdraw() public {
        deployer.transfer(address(this).balance);
    }



}