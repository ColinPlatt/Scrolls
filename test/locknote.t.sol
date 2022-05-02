// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import 'forge-std/Test.sol';

import '../src/locknote.sol';


contract LockNoteTest is Test {

    LockNote note;

    fallback() external payable {}
    receive() external payable {}

    function setUp() public {
        note = new LockNote();
    }

    function testMinting() public payable {
        address beef = address(0xBEEF);
        address fad = address(0xFAD);

        vm.deal(beef, 1 ether);
        vm.startPrank(beef);
        note.mint{value:0.042069 ether}(fad, 'hello fren.');

        assertEq(note.balanceOf(fad), 1);
        assertEq(note.readText(fad), 'hello fren.');
        assertEq(note.readSender(fad), beef);

    }

    function testBurning() public payable {
        address beef = address(0xBEEF);

        vm.deal(beef, 1 ether);
        vm.startPrank(beef);
        note.mint{value:0.042069 ether}(beef, 'writing to myself');

        note.burn{value:0.042069 ether}();
        assertEq(note.balanceOf(beef), 0);

    }

    function testWithdraw() public payable {
        address beef = address(0xBEEF);

        vm.deal(beef, 1 ether);
        vm.startPrank(beef);
        note.mint{value:0.042069 ether}(beef, 'writing to myself');

        note.burn{value:0.042069 ether}();
        vm.stopPrank();

        uint256 balanceBefore = address(note.deployer()).balance;

        note.withdraw();

        assertEq(address(note.deployer()).balance - balanceBefore, 0.084138 ether);

    }

    function testMetaData() public payable {
        address beef = address(0xBEEF);
        address fad = address(0xFAD);

        vm.deal(beef, 1 ether);
        vm.startPrank(beef);
        note.mint{value:0.042069 ether}(fad, 'hello fren. how are you doing? it is a lovely day, do you not think?');

        assertEq(note.tokenURI(note.getIdfromAddress(fad)),'data:application/json;base64,eyJuYW1lIjogIkxvY2sgTm90ZSIsICJkZXNjcmlwdGlvbiI6ICJMb2NrIE5vdGUgaXMgYW4gTkZUIGJhc2VkIG1lc3NhZ2luZyBhcHBsaWNhdGlvbi4gVXNlcnMgY2FuIG1pbnQgYSBtZXNzYWdlIHVwIHRvIDI4MCBjaGFyYWN0ZXJzIGxvbmcgdG8gYW55IGFkZHJlc3MsIHdoaWNoIGNhbiBvbmx5IGJlIGJ1cm5lZCBieSB0aGUgb3duZXIgb2YgdGhhdCBhZGRyZXNzLiBIYXZlIGZ1biB3aXRoIExvY2sgTm90ZSBob3dldmVyIHlvdSBsaWtlLiIsICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNakUxSWo0OGNtVmpkQ0IzYVdSMGFEMGlNelV3SWlCb1pXbG5hSFE5SWpJeE5TSWdabWxzYkQwaVoyRnBibk5pYjNKdklpQnpkSEp2YTJVOUlrUmhjbXRIY21GNUlpQnpkSEp2YTJVdGQybGtkR2c5SWpNaUx6NDhkR1Y0ZENCNFBTSXlPRFVpSUhrOUlqSXdJaUJtYjI1MExXWmhiV2xzZVQwaWMyRnVjeTF6WlhKcFppSWdabTl1ZEMxemFYcGxQU0l4TW5CNElpQm1iMjUwTFhOMGVXeGxQU0pwZEdGc2FXTWlQa3h2WTJzZ1RtOTBaVHd2ZEdWNGRENDhkR1Y0ZENCNFBTSXhNQ0lnZVQwaU16VWlJR1p2Ym5RdFptRnRhV3g1UFNKellXNXpMWE5sY21sbUlpQm1iMjUwTFhOcGVtVTlJakV5Y0hnaUlHWnZiblF0YzNSNWJHVTlJbWwwWVd4cFl5SStNSGhpWldWbVBDOTBaWGgwUGp4MFpYaDBJR1p2Ym5RdFptRnRhV3g1UFNKdGIyNXZjM0JoWTJVc0lFTnZkWEpwWlhJZ1RtVjNJaUJtYjI1MExYTnBlbVU5SWpFeWNIZ2lJR1pwYkd3OUluTjBaV1ZzWW14MVpTSStQSFJ6Y0dGdUlIZzlJakV3SWlCNVBTSTFOU0krYUdWc2JHOGdabkpsYmk0Z2FHOTNJR0Z5WlNCNWIzVWdaRzlwYm1jL0lHbDBJR2x6SUdFOEwzUnpjR0Z1UGp4MGMzQmhiaUI0UFNJeE1DSWdlVDBpTnpVaVBteHZkbVZzZVNCa1lYa3NJR1J2SUhsdmRTQnViM1FnZEdocGJtcy9QQzkwYzNCaGJqNDhMM1JsZUhRK1BDOXpkbWMrIn0=');

        //uncomment this to return message
        //emit log_string(note.tokenURI(note.getIdfromAddress(fad)));

    }


}