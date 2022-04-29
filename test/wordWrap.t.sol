// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import 'forge-std/Test.sol';
import '../src/Utils.sol';
import {strings} from 'stringUtils/strings.sol';

contract WordWrapTest is Test {
    using strings for *;

    string testShortString = " try doing this.";
    string testLongString = "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat mas";

    uint256 constant MAX_LINELENGTH = 34;

    //yields and error if the first word is more than 34 Char long.
    function testReturnStringArray() public {

        strings.slice memory s = testLongString.toSlice();
        strings.slice memory delim = ' '.toSlice();
        string[] memory words  = new string[](s.count(delim));
        string[] memory completedLines = new string[](10); //set to max number of lines possible

        string memory nextLine = s.split(delim).toString();
        uint256 wordLength;
        uint256 nextLineLength;
        uint256 j = 0;

        for(uint256 i = 0; i < words.length; i++) {
            words[i] = s.split(delim).toString();
        }

        for(uint256 i = 0; i < words.length; i++) {
            wordLength = utils.utfStringLength(words[i]);
            if(wordLength > MAX_LINELENGTH) {
                completedLines[j] = nextLine;
                j++;
                completedLines[j] = words[i];
                j++;
                nextLine = '';
                nextLineLength = 0;
            } else if ((nextLineLength + wordLength) >= MAX_LINELENGTH) {
                completedLines[j] = nextLine;
                j++;
                nextLine = words[i];
                nextLineLength = 0;
            } else {
                nextLine = string.concat(
                    nextLine,
                    ' ',
                    words[i]
                );
                nextLineLength += wordLength;
                if (i == (words.length - 1)) {
                    completedLines[j] = nextLine;
                    break;
                }
            }
        }

        for(uint256 i = 0; i<8; i++) {
            emit log_string(completedLines[i]);
        }
        



        



        


    }

}
