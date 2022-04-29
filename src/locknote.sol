//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import {ERC721_address_specific} from './ERC721_address_specific.sol';
import {svg} from './SVG.sol';
import {json} from './JSON.sol';
import {utils} from './Utils.sol';

contract LockNote is ERC721_address_specific {
    

    uint256 constant MAX_MESSAGE = 280;
    uint256 MESSAGE_PRICE = 0.0042069 ether; 

    constructor () ERC721_address_specific("Lock Note", unicode"🔏"){}

    struct MESSAGE {
        string text;
        address sender;
    }

    mapping (uint256 => MESSAGE) public messages;

    function tokenURI(uint256 id) public view override returns (string memory) {
        require(ownerOf(id) == getAddressfromId(id), "NOT MINTED");
        MESSAGE memory _message = messages[id];

        return json.formattedMetadata(
            'Lock Note',
            'Lock Note is an NFT based messaging application. Users can mint a message up to 280 characters long to any address, which can only be burned by the owner of that address. Have fun with Lock Note however you like.',
            svg._svg(
                    string.concat(
                        svg.prop('viewBox', '0 0 350 215'),
                        svg.prop('width', '350'),
                        svg.prop('height', '215'),
                        svg.prop('style', 'background: gainsboro; box-shadow: 0 0 0 3px rgba(169,169,169,1)')
                    ),
                    string.concat(
                        svg.el('style',
                            '',
                            string.concat(
                                'div { ', 
                                'color: steelblue; ',
                                'font: 14px sans-serif; ',
                                'height: 100%; ',
                                'overflow: auto',
                                ' }'
                            )
                        ),
                        svg.text(
                            'x="269" y="20" font-family="sans-serif" font-size="12px" font-style="italic"',
                            unicode'Lock Note 🔏'
                        ),
                        svg.text(
                            'x="10" y="35" font-family="sans-serif" font-size="12px" font-style="italic"',
                            utils.toHexString(getIdfromAddress(_message.sender))
                        ),
                        svg.foreignObject(
                            'x="10" y="45" width="330" height="160"',
                            svg.el(
                                'div',
                                'xmlns="http://www.w3.org/1999/xhtml"',
                                _message.text
                            )
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
        require(utils.utfStringLength(message) <= MAX_MESSAGE, 'MSG TOO LONG');
        uint256 _id = getIdfromAddress(to);
        messages[_id].text = message;
        messages[_id].sender = msg.sender;
        _mint(to, _id);
    }

    function burn() public payable {
        uint256 _id = getIdfromAddress(msg.sender);
        messages[_id].text = ' ';
        messages[_id].sender = address(0);
        _burn(_id);
    }

    // Need to add treasury functions



}