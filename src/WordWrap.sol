// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

import {utils} from '../src/Utils.sol';
import {svg} from './SVG.sol';
import {strings} from 'stringUtils/strings.sol';

library WordWrap {
    using strings for *;

    struct WordWrapInfo {
        uint256 line_width;
        uint256 x;
        uint256 yFirst;
        uint256 spacing;
    }


    //yields and error if the first word is more than line_width Char long.
    function toArray(string memory _raw_text, uint256 _line_width) internal pure returns (string[] memory) {

        strings.slice memory s = _raw_text.toSlice();
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
            if(wordLength > _line_width) {
                completedLines[j] = nextLine;
                j++;
                completedLines[j] = words[i];
                j++;
                nextLine = '';
                nextLineLength = 0;
            } else if ((nextLineLength + wordLength) >= _line_width) {
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
                nextLineLength += wordLength + 1;
                if (i == (words.length - 1)) {
                    completedLines[j] = nextLine;
                    // if we don't need the entire max array setup another and return just that.
                    string[] memory completedLinesShorter = new string[](j+1);
                    for (uint256 k = 0; k <= j; k++) {
                        completedLinesShorter[k] = completedLines[k];
                    }
                    return completedLinesShorter;
                }
            }
        }

        return completedLines;

    }
    
    function toElement(string memory raw_text, WordWrapInfo memory formatting) pure internal returns (string memory) {

        string memory el;
        string[] memory arrayText = toArray(raw_text, formatting.line_width);

        string memory xProp = svg.prop('x', utils.toString(formatting.x));

        for (uint256 i = 0; i<arrayText.length; i++) {
            el = string.concat(
                el,
                svg.tspan(
                    string.concat(
                        xProp,
                        svg.prop('y', utils.toString(formatting.yFirst + (i * formatting.spacing)), true)
                    ),
                    arrayText[i]
                )
            );
        }

        return el;

    }



    /*

    <tspan x={0} dy={index === 0 ? 0 : 14}>
    {word}
  </tspan>

  */

}