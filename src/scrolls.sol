//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {ERC721_address_specific} from './ERC721_address_specific.sol';
import {svg} from './SVG.sol';
import {json} from './JSON.sol';
import {utils} from './Utils.sol';
import {WordWrap} from './WordWrap.sol';

contract Scrolls is ERC721_address_specific {
    
    uint256 constant MAX_MESSAGE = 280;
    uint256 MESSAGE_PRICE = 0.0042069 ether;
    address payable public deployer; 

    constructor () 
        ERC721_address_specific("Scrolls", unicode"📜")
        {
            deployer = payable(msg.sender);
            // do initial mint
            uint256 _id = getIdfromAddress(msg.sender);
            messages[_id].text = 'we shall now get ready to write some scrolls for the world.';
            messages[_id].sender = msg.sender;
            _mint(msg.sender, _id);
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
            line_width: 50,
            x: 35,
            yFirst: 45,
            spacing: 20 
        });

        return json.formattedMetadata(
            'Scrolls',
            'Scrolls is an NFT based messaging application. Users can mint a message up to 280 characters long to any address, which can only be burned by the owner of that address. Have fun with Lock Note however you like.',
            svg._svg(
                    'viewBox="0 0 350 300"',
                    string.concat(
                        '<defs><linearGradient id="a" x1="25" x2="-.1" y1="142" y2="142" gradientUnits="userSpaceOnUse"><stop stop-color="#8d5c34" offset=".1"/><stop stop-color="#e8d0a9" offset=".3"/><stop stop-color="#e3cba4" offset=".6"/><stop stop-color="#8d5c34" offset="1"/></linearGradient><linearGradient id="b" x1="22" x2="321" y1="145" y2="135" gradientUnits="userSpaceOnUse"><stop stop-color="#8d5c34"/><stop stop-color="#d1b38b" offset=".05"/><stop stop-color="#e3cba4" offset=".95"/><stop stop-color="#8d5c34" offset="1"/></linearGradient><linearGradient id="c" x1="343" x2="316" y1="144" y2="144" gradientUnits="userSpaceOnUse"><stop stop-color="#8d5c34"/><stop stop-color="#93633b" offset=".1"/><stop stop-color="#e8d0a9" offset=".3"/><stop stop-color="#e3cba4" offset=".6"/><stop stop-color="#93633a" offset=".9"/><stop stop-color="#8d5c34" offset="1"/></linearGradient></defs><path d="m3.5 275.9c-0.2-90.2-1.4-180.4-2.7-270.5 5.6-2.8 18.6-3.7 17.2 5.2 3.6 90 7.1 180 10.7 269.9-7.9-3.2-16.6-7.5-25.2-4.6z" fill="url(#a)" fill-rule="evenodd"/><path d="m12.1 282.6-1.2-3.9-5.1-2.1c3.8-1.2 7.3-1.3 10.8-0.6 3.4 0.9 6.7 2.4 9.8 5.1-2.8 1.4-5.4 2.2-7.7 2.4-2.5 0.3-4.5-0.1-6.6-0.9z" fill="url(#a)" fill-rule="evenodd"/><path d="m28.8 276c-3.8-89.8-7.6-179.5-11.4-269.3 14.7 1.4 29.9 0.6 44.4 2.5 3.8 6.6 11.3 9.6 12.6-0.7 11-1.8 24.2-3.5 23.6 10 6.3 4.3 5.2-15.3 15.8-9.1 10.7-2.2 20 1.4 28.3 5.7 3.9-11.9 24-7.1 31.6-1.9 1.7 6.1 4.6 20.8 4.5 6.8 0.7-17.6 21.3-9.8 33.2-9.8 2.9 6.8 4.6 16.7 7.3 3.9 6.8-5.5 26.7-0.5 38.5-4.4 13.5-2.2 27.2 4 41 2.4 8.6 1.2 22-4.8 18.3 8.4 0.3 84.4 0.6 168.8 0.9 253.3-16.7-4-33.7 2.2-50.6 1.9-11.9-2.4-33.1 7.7-36.8-9.1-2.4-5.9-5.6-20.4-5.7-5.5 0.5 21-24 11.9-36.8 12.7-19.6 2-39.3 4-59.1 1.8-16.1-4.3-31.7 6-47.4 0.1-13.9 5.4-11.1-15.4-13.1-17.5-8.2 5.7 6.1 21.5-9.6 18.3-9.8 0.5-19.8 1-29.5-0.6z" fill="url(#b)" fill-rule="evenodd"/><path d="m317.4 279.6c-0.2-91.8 0-183.5-0.9-275.3 6.7 7.2 19.5 2.7 25.4 3.5-1.5 90.3-3 180.6-4.5 270.9-6.1 3.6-14.3 7.8-20 0.9z" fill="url(#c)" fill-rule="evenodd"/><path d="m315.9 4.6c2.7 1.8 5.9 3 9.3 3.6 3.4 0.6 8.2 0.8 11.1 0.3 2.7-0.4 4.7-1.3 5.7-2.7-1.4-0.6-3.3-1.1-5.4-1.5-2.2-0.4-4.6-0.6-7.5-0.9l-3.6-2.4c-2.2-0.4-4.1-0.3-5.7 0.3-1.7 0.6-2.8 1.7-3.9 3.3z" fill="url(#c)" fill-rule="evenodd"/><path d="m11.6 283.5c2.3 0.4 4.7 0.4 7.6 0 2.9-0.4 6-1 9.5-2.2l0.3-3.8c3.4-0.3 6.5-0.4 9.9-0.3 3.2 0.2 6 0.7 9.5 0.7 3.4-0.2 8.2-0.8 11.4-1.3 3.3-0.3 5.8-0.4 8-0.3 0.3-0.5 0.3-1.8 0-3.8-0.3-2.1-1.7-5.8-1.6-8.3 0.2-2.3 0.9-4.2 2.6-5.7-0.7 2.2-1 4-1 5.4 0 1.5 0.8 1.5 1.3 3.5 0.5 2.1 0.8 5 1.3 8.9 3 0.1 6.6 0.3 10.5 0.6 3.9 0.5 7.3 1.7 13 1.6 5.6-0.2 15.3-2.1 21-2.6 5.7-0.1 9.8-0.3 12.7 0.3 3.4 1 7.5 1.4 12.7 1.6 5.2 0.3 12.5-0.3 17.8-0.6 5-0.4 7.2-0.7 13-1.3 5.8-0.4 15.8-0.9 22-0.9 6.1 0.1 9.9 1.4 14.7 1.3 4.7-0.1 9-0.8 13.4-1.9 0.3-0.9 0.6-1.8 1.3-3.2 0.6-1.1 1.8-2.1 2.2-4.4 0.3-2.3-0.6-7.8-0.3-9.5 0.3-1.6 0.6-1.7 1.6-0.3-0.6 2.9-0.5 5.3 0.3 7.6 0.8 2.3 3.1 4.3 4.1 6.1 0.9 1.9-0.3 3.3 1.6 4.5 1.9 1.2 3.9 1.7 9.6 1.9 5.5 0.3 17.4-0.4 23.9-0.6 6.3-0.2 8.5-0.2 14.2-0.6 5.6-0.4 13.2-1.7 19.4-1.9 6.1-0.1 12 0.4 17.5 1.3l-0.3 5.7c3 2.5 6.2 3.6 9.9 3.5 3.6-0.2 7.5-1.6 11.8-4.5l4.4-274.5c-0.2-0.2-1.3-0.5-3.5-1-2.2-0.5-5.4-0.9-9.5-1.6l-1.9-2.6c-3.2-0.1-5.6 0.1-7.6 0.6-2.1 0.6-3.5 1.3-4.5 2.6l0.3 8.2c-16.1-0.3-28.3-0.6-37.2-1.3-8.9-0.6-10.2-2.2-15.9-2.2-5.9 0.1-13.5 1.9-18.8 2.2-5.2 0.4-7.8-0.1-12.1 0-4.5 0.2-9.1 0.4-14.3 0.9-0.1 2.4-0.1 4.4-0.6 6.1-0.5 1.7-1 2.9-1.9 3.9 0.6-2.1 0.7-4.1 0.3-6-0.5-1.9-1.3-3.7-2.9-5.4-6-0.7-11.7-1-17.2-1.3-5.7-0.1-10.7-0-15.9 0.3 0.6 1.8 0.8 3.5 0.6 5.1-0.3 1.6-1.5 2.4-1.9 4.5-0.4 2.2-0.5 4.8-0.3 8.3-0-0.7-0.1-1.6-0.3-2.9-0.3-1.3-0.8-2.8-1-4.5-0.2-1.4 0.3-3.2-0.3-4.8-0.6-1.6-0.9-3.2-3.5-4.5-2.8-1.2-8.1-1.8-12.7-2.2-4.8-0.3-12.1-0.1-15.3 1-3.1 1.2-1.5 6-3.2 6-1.8 0.1-3.9-4.8-7.3-5.7-3.6-0.9-8.9 0.4-13.7 0.3-4.8 0.1-9.8 0.1-14.9 0-1 1.3-1.7 2.8-2.6 4.4-0.8 1.7-1.3 5.5-2.2 5.4-1.2-0-3.5-4.4-3.8-5.7-0.2-1.2 3-0.9 2.6-1.9-0.6-1-1.4-3.8-5.7-4.4-4.5-0.5-11.3-0.1-20.7 1.3-0.9 4.5-2 6.7-3.5 6.7-1.6-0-3.2-5.4-5.7-6.7-2.6-1.2-2.1-0.3-9.5-0.6-7.7-0.3-19.3-0.5-35.6-0.9-0.6-1.9-2.3-3.1-5.4-3.5-3.1-0.4-7.5 0.1-13 1.3l3.2 271.7c1.6 1 3.2 1.7 4.5 2.2 1.2 0.6 2.4 0.8 3.2 0.9 0.2 1.4 0.4 2.7 0.6 4.141zm-7.02-8c3.2-0.6 6.3-0.9 9.6-0.6 3.2 0.3 7.3 1.3 9.5 2.2 2.2 1 3.5 1.9 3.8 3.2-0.2-8.1-0.6-22.9-1.6-45.5-1.1-22.6-2.3-50.3-3.9-88.7-1.5-38.3-3.2-84.1-5.1-139.4-2.1-1.2-4.3-1.8-7-1.9-2.7-0-5.6 0.5-8.9 1.6 1.2 89.7 2.3 179.4 3.5 269.1zm14-267.6c14.7 0.7 25.4 1.1 32.6 1.3 7.1 0.2 7.3-1.1 10.2 0 2.8 1.2 5.1 6.3 7 7.3 1.8 1.2 3 0.7 4.1-0.6 1.2-1.2 1.9-3.6 2.6-7 4.5-0.4 8.4-0.6 11.8-0.6 3.5-0 6.6 0.2 8.3 0.6 1.4 0.7 1.1 2.1 0.9 2.8-0.2 0.8-1.8 0.9-1.6 1.9 0.2 1.3 1.7 3.5 2.8 4.8 1.1 1.3 2.6 3 3.8 2.6 1-0.4 1.7-3.3 2.6-5.1 0.8-1.7 1.5-3.5 2.2-5.4 6 0.3 11.2 0.4 15.6 0.3 4.4-0 7.8-0.8 10.5-0.3 2.5 0.6 3.9 2.7 5.4 3.8 1.5 1.2 3 3.1 4.1 3.2 1 0.1 1.8-1.3 2.5-2.5 0.6-1.2-1.1-3.4 1.3-4.5 2.4-1 8.9-1.3 13-1.3 4.1 0.2 8.8 1.2 11.5 2.2 2.7 1 3.5 1.6 4.5 3.8 0.8 2.4 0.2 7.7 1 10.2 0.8 2.6 1.9 4.2 3.5 5.1-0.6-3.3-0.7-6.1-0.3-8.6 0.3-2.4 1.6-4.1 2.2-6 0.6-1.9 0.9-3.9 1.3-5.7 0.6-0 3.3-0 8 0 4.7 0.1 11.3 0.2 20.1 0.3 1.4 1.7 2.4 3.6 3.2 5.7 0.7 2.2 1 4.6 1 7.3 1.3-1.2 2.4-2.6 3.2-4.5 0.8-1.8 1.3-3.8 1.6-6.3 12 0.1 21.6-0.1 29.3-0.6 7.6-0.5 10.5-2.2 16.2-2.23 5.5 0.2 8.6 1.9 17.2 2.6 8.6 0.6 19.8 0.8 34.1 0.6l1.3 259.9c-4.7-1-10.2-1.5-16.8-1.3-6.8 0.4-16.7 1.9-22.9 2.6-6.1 0.6-7.1 0.6-13.3 0.6-6.4 0.3-19.1 0.4-24.2 0-5.1-0.5-4.9-1.5-6-2.6-1.3-0.8-0.4-1-1.3-2.9-1-1.8-3.3-5.2-4.1-8-0.8-2.6 0.1-6.3-0.6-8-0.9-1.5-3.5-2.3-4.1-1.3-0.8 1.1 0.2 5 0 7.6-0.2 2.7-0.5 6.2-1.3 8.3-0.9 2.2-2 3.6-3.5 4.5-4.8 1-8.9 1.4-12.4 1.6-3.6 0.1-3.5-0.7-8.9-1-5.5-0.1-15.8-0-23.5 0.3-7.9 0.5-17.5 2.3-23.2 2.6-5.7 0.4-6.7-0.1-11.2-0.6-4.7-0.6-11.1-1.8-16.5-2.2-5.7-0.2-11.2 0.5-16.6 1-5.4 0.7-11.4 2.4-15.3 2.6-3.8 0.1-4.2-1.3-7.3-1.9-3.1-0.5-6.9-0.9-11.4-1.3-1.7-3.5-2.6-6.6-2.9-9.9-0.3-3.2 0.1-6.2 1.3-9.2-3 3.2-5 5.7-6 7.6-1.2 1.9-0.9 2.3-0.6 4.1 0.3 2 0.9 4.5 2.2 7.6-0.9 0.6-3.5 0.9-7.6 1.3-4.3 0.4-12.3 0.7-17.2 0.6-4.9 0-8.7-0.2-11.8-0.6l-11.2-267.2zm-5.7 273.9-1.3-4.1-4.5-1.3c3.4-0.1 6.5-0.1 9.5 0.6 3 0.7 5.7 1.7 8.3 3.2-2.7 1.1-4.9 1.6-7 1.9s-3.7 0.2-5.1-0.3zm328-276.2c-1.8 0.9-3.9 1.5-6.7 1.6-2.9 0.2-6.6-0-9.6-0.6-3-0.6-5.4-1.3-7.6-2.6 1.2-1 2.7-1.6 4.1-1.9 1.4-0.3 3.1-0.1 4.8 0.3l3.2 2.2c3.9 0.3 7.8 0.6 11.8 0.9zm-23.9 1c0.4 26.1 0.7 61.2 1 106.9 0.2 46 0.3 100.2 0.3 165.7 0.8 2.1 2.6 3.1 5.7 2.9 3-0.2 7.3-1.4 12.7-3.8l4.1-270.1c-4.2 1-7.9 1.5-11.1 1.6-3.5 0-6.4-0.6-8.6-1.3-2.2-0.6-3.5-1.1-4.1-1.9z" fill-rule="evenodd"/>',
                        svg.text(
                            'x="10" y="295" font-family="sans-serif" font-size="10px" font-style="italic"',
                            string.concat(
                                'from: ',
                                utils.toHexString(getIdfromAddress(_message.sender))
                            )
                        ),
                        svg.text(
                            'font-family="Papyrus, fantasy" font-size="12px" fill="DarkGoldenrod"',
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