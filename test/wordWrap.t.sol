// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import 'forge-std/Test.sol';
import '../src/Utils.sol';
import {strings} from 'stringUtils/strings.sol';

import {WordWrap} from '../src/WordWrap.sol';

contract WordWrapTest is Test {
    using WordWrap for *;

    function setUp() public {}

    function testWordWrapping() public {

        string memory testText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat mas";

        WordWrap.WordWrapInfo memory formattingData = WordWrap.WordWrapInfo({
            line_width: 34,
            x: 10,
            yFirst: 30,
            spacing: 20 
        });

        string memory output = WordWrap.toElement(testText, formattingData);

        emit log_string(output);


    }

}
