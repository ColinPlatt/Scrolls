// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import 'forge-std/Test.sol';

import {Scrolls} from '../src/scrolls.sol';


contract ScrollsTest is Test {

    Scrolls scroll;

    fallback() external payable {}
    receive() external payable {}

    function setUp() public {
        scroll = new Scrolls();
    }

    function testMinting() public payable {
        address beef = address(0xBEEF);
        address fad = address(0xFAD);

        vm.deal(beef, 1 ether);
        vm.startPrank(beef);
        scroll.mint{value:0.0042069 ether}(fad, 'hello fren.');

        assertEq(scroll.balanceOf(fad), 1);
        assertEq(scroll.readText(fad), 'hello fren.');
        assertEq(scroll.readSender(fad), beef);

    }

    function testBurning() public payable {
        address beef = address(0xBEEF);

        vm.deal(beef, 1 ether);
        vm.startPrank(beef);
        scroll.mint{value:0.0042069 ether}(beef, 'writing to myself');

        scroll.burn{value:0.0042069 ether}();
        assertEq(scroll.balanceOf(beef), 0);

    }

    function testWithdraw() public payable {
        address beef = address(0xBEEF);

        vm.deal(beef, 1 ether);
        vm.startPrank(beef);
        scroll.mint{value:0.0042069 ether}(beef, 'writing to myself');

        scroll.burn{value:0.0042069 ether}();
        vm.stopPrank();

        uint256 balanceBefore = address(scroll.deployer()).balance;

        scroll.withdraw();

        assertEq(address(scroll.deployer()).balance - balanceBefore, 0.084138 ether);

    }

    function testMetaData() public payable {
        address beef = address(0xBEEF);
        address fad = address(0xFAD);

        vm.deal(beef, 1 ether);
        vm.startPrank(beef);
        scroll.mint{value:0.0042069 ether}(fad, 'hello fren. how are you doing? it is a lovely day, do you not think?');

        assertEq(scroll.tokenURI(scroll.getIdfromAddress(fad)),'data:application/json;base64,eyJuYW1lIjogIlNjcm9sbHMiLCAiZGVzY3JpcHRpb24iOiAiU2Nyb2xscyBpcyBhbiBORlQgYmFzZWQgbWVzc2FnaW5nIGFwcGxpY2F0aW9uLiBVc2VycyBjYW4gbWludCBhIG1lc3NhZ2UgdXAgdG8gMjgwIGNoYXJhY3RlcnMgbG9uZyB0byBhbnkgYWRkcmVzcywgd2hpY2ggY2FuIG9ubHkgYmUgYnVybmVkIGJ5IHRoZSBvd25lciBvZiB0aGF0IGFkZHJlc3MuIEhhdmUgZnVuIHdpdGggTG9jayBOb3RlIGhvd2V2ZXIgeW91IGxpa2UuIiwgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016QXdJajQ4WkdWbWN6NDhiR2x1WldGeVIzSmhaR2xsYm5RZ2FXUTlJbUVpSUhneFBTSXlOU0lnZURJOUlpMHVNU0lnZVRFOUlqRTBNaUlnZVRJOUlqRTBNaUlnWjNKaFpHbGxiblJWYm1sMGN6MGlkWE5sY2xOd1lXTmxUMjVWYzJVaVBqeHpkRzl3SUhOMGIzQXRZMjlzYjNJOUlpTTRaRFZqTXpRaUlHOW1abk5sZEQwaUxqRWlMejQ4YzNSdmNDQnpkRzl3TFdOdmJHOXlQU0lqWlRoa01HRTVJaUJ2Wm1aelpYUTlJaTR6SWk4K1BITjBiM0FnYzNSdmNDMWpiMnh2Y2owaUkyVXpZMkpoTkNJZ2IyWm1jMlYwUFNJdU5pSXZQanh6ZEc5d0lITjBiM0F0WTI5c2IzSTlJaU00WkRWak16UWlJRzltWm5ObGREMGlNU0l2UGp3dmJHbHVaV0Z5UjNKaFpHbGxiblErUEd4cGJtVmhja2R5WVdScFpXNTBJR2xrUFNKaUlpQjRNVDBpTWpJaUlIZ3lQU0l6TWpFaUlIa3hQU0l4TkRVaUlIa3lQU0l4TXpVaUlHZHlZV1JwWlc1MFZXNXBkSE05SW5WelpYSlRjR0ZqWlU5dVZYTmxJajQ4YzNSdmNDQnpkRzl3TFdOdmJHOXlQU0lqT0dRMVl6TTBJaTgrUEhOMGIzQWdjM1J2Y0MxamIyeHZjajBpSTJReFlqTTRZaUlnYjJabWMyVjBQU0l1TURVaUx6NDhjM1J2Y0NCemRHOXdMV052Ykc5eVBTSWpaVE5qWW1FMElpQnZabVp6WlhROUlpNDVOU0l2UGp4emRHOXdJSE4wYjNBdFkyOXNiM0k5SWlNNFpEVmpNelFpSUc5bVpuTmxkRDBpTVNJdlBqd3ZiR2x1WldGeVIzSmhaR2xsYm5RK1BHeHBibVZoY2tkeVlXUnBaVzUwSUdsa1BTSmpJaUI0TVQwaU16UXpJaUI0TWowaU16RTJJaUI1TVQwaU1UUTBJaUI1TWowaU1UUTBJaUJuY21Ga2FXVnVkRlZ1YVhSelBTSjFjMlZ5VTNCaFkyVlBibFZ6WlNJK1BITjBiM0FnYzNSdmNDMWpiMnh2Y2owaUl6aGtOV016TkNJdlBqeHpkRzl3SUhOMGIzQXRZMjlzYjNJOUlpTTVNell6TTJJaUlHOW1abk5sZEQwaUxqRWlMejQ4YzNSdmNDQnpkRzl3TFdOdmJHOXlQU0lqWlRoa01HRTVJaUJ2Wm1aelpYUTlJaTR6SWk4K1BITjBiM0FnYzNSdmNDMWpiMnh2Y2owaUkyVXpZMkpoTkNJZ2IyWm1jMlYwUFNJdU5pSXZQanh6ZEc5d0lITjBiM0F0WTI5c2IzSTlJaU01TXpZek0yRWlJRzltWm5ObGREMGlMamtpTHo0OGMzUnZjQ0J6ZEc5d0xXTnZiRzl5UFNJak9HUTFZek0wSWlCdlptWnpaWFE5SWpFaUx6NDhMMnhwYm1WaGNrZHlZV1JwWlc1MFBqd3ZaR1ZtY3o0OGNHRjBhQ0JrUFNKdE15NDFJREkzTlM0NVl5MHdMakl0T1RBdU1pMHhMalF0TVRnd0xqUXRNaTQzTFRJM01DNDFJRFV1TmkweUxqZ2dNVGd1TmkwekxqY2dNVGN1TWlBMUxqSWdNeTQySURrd0lEY3VNU0F4T0RBZ01UQXVOeUF5TmprdU9TMDNMamt0TXk0eUxURTJMall0Tnk0MUxUSTFMakl0TkM0MmVpSWdabWxzYkQwaWRYSnNLQ05oS1NJZ1ptbHNiQzF5ZFd4bFBTSmxkbVZ1YjJSa0lpOCtQSEJoZEdnZ1pEMGliVEV5TGpFZ01qZ3lMall0TVM0eUxUTXVPUzAxTGpFdE1pNHhZek11T0MweExqSWdOeTR6TFRFdU15QXhNQzQ0TFRBdU5pQXpMalFnTUM0NUlEWXVOeUF5TGpRZ09TNDRJRFV1TVMweUxqZ2dNUzQwTFRVdU5DQXlMakl0Tnk0M0lESXVOQzB5TGpVZ01DNHpMVFF1TlMwd0xqRXROaTQyTFRBdU9Yb2lJR1pwYkd3OUluVnliQ2dqWVNraUlHWnBiR3d0Y25Wc1pUMGlaWFpsYm05a1pDSXZQanh3WVhSb0lHUTlJbTB5T0M0NElESTNObU10TXk0NExUZzVMamd0Tnk0MkxURTNPUzQxTFRFeExqUXRNalk1TGpNZ01UUXVOeUF4TGpRZ01qa3VPU0F3TGpZZ05EUXVOQ0F5TGpVZ015NDRJRFl1TmlBeE1TNHpJRGt1TmlBeE1pNDJMVEF1TnlBeE1TMHhMamdnTWpRdU1pMHpMalVnTWpNdU5pQXhNQ0EyTGpNZ05DNHpJRFV1TWkweE5TNHpJREUxTGpndE9TNHhJREV3TGpjdE1pNHlJREl3SURFdU5DQXlPQzR6SURVdU55QXpMamt0TVRFdU9TQXlOQzAzTGpFZ016RXVOaTB4TGprZ01TNDNJRFl1TVNBMExqWWdNakF1T0NBMExqVWdOaTQ0SURBdU55MHhOeTQySURJeExqTXRPUzQ0SURNekxqSXRPUzQ0SURJdU9TQTJMamdnTkM0MklERTJMamNnTnk0eklETXVPU0EyTGpndE5TNDFJREkyTGpjdE1DNDFJRE00TGpVdE5DNDBJREV6TGpVdE1pNHlJREkzTGpJZ05DQTBNU0F5TGpRZ09DNDJJREV1TWlBeU1pMDBMamdnTVRndU15QTRMalFnTUM0eklEZzBMalFnTUM0MklERTJPQzQ0SURBdU9TQXlOVE11TXkweE5pNDNMVFF0TXpNdU55QXlMakl0TlRBdU5pQXhMamt0TVRFdU9TMHlMalF0TXpNdU1TQTNMamN0TXpZdU9DMDVMakV0TWk0MExUVXVPUzAxTGpZdE1qQXVOQzAxTGpjdE5TNDFJREF1TlNBeU1TMHlOQ0F4TVM0NUxUTTJMamdnTVRJdU55MHhPUzQySURJdE16a3VNeUEwTFRVNUxqRWdNUzQ0TFRFMkxqRXROQzR6TFRNeExqY2dOaTAwTnk0MElEQXVNUzB4TXk0NUlEVXVOQzB4TVM0eExURTFMalF0TVRNdU1TMHhOeTQxTFRndU1pQTFMamNnTmk0eElESXhMalV0T1M0MklERTRMak10T1M0NElEQXVOUzB4T1M0NElERXRNamt1TlMwd0xqWjZJaUJtYVd4c1BTSjFjbXdvSTJJcElpQm1hV3hzTFhKMWJHVTlJbVYyWlc1dlpHUWlMejQ4Y0dGMGFDQmtQU0p0TXpFM0xqUWdNamM1TGpaakxUQXVNaTA1TVM0NElEQXRNVGd6TGpVdE1DNDVMVEkzTlM0eklEWXVOeUEzTGpJZ01Ua3VOU0F5TGpjZ01qVXVOQ0F6TGpVdE1TNDFJRGt3TGpNdE15QXhPREF1TmkwMExqVWdNamN3TGprdE5pNHhJRE11TmkweE5DNHpJRGN1T0MweU1DQXdMamw2SWlCbWFXeHNQU0oxY213b0kyTXBJaUJtYVd4c0xYSjFiR1U5SW1WMlpXNXZaR1FpTHo0OGNHRjBhQ0JrUFNKdE16RTFMamtnTkM0Mll6SXVOeUF4TGpnZ05TNDVJRE1nT1M0eklETXVOaUF6TGpRZ01DNDJJRGd1TWlBd0xqZ2dNVEV1TVNBd0xqTWdNaTQzTFRBdU5DQTBMamN0TVM0eklEVXVOeTB5TGpjdE1TNDBMVEF1TmkwekxqTXRNUzR4TFRVdU5DMHhMalV0TWk0eUxUQXVOQzAwTGpZdE1DNDJMVGN1TlMwd0xqbHNMVE11TmkweUxqUmpMVEl1TWkwd0xqUXROQzR4TFRBdU15MDFMamNnTUM0ekxURXVOeUF3TGpZdE1pNDRJREV1Tnkwekxqa2dNeTR6ZWlJZ1ptbHNiRDBpZFhKc0tDTmpLU0lnWm1sc2JDMXlkV3hsUFNKbGRtVnViMlJrSWk4K1BIQmhkR2dnWkQwaWJURXhMallnTWpnekxqVmpNaTR6SURBdU5DQTBMamNnTUM0MElEY3VOaUF3SURJdU9TMHdMalFnTmkweElEa3VOUzB5TGpKc01DNHpMVE11T0dNekxqUXRNQzR6SURZdU5TMHdMalFnT1M0NUxUQXVNeUF6TGpJZ01DNHlJRFlnTUM0M0lEa3VOU0F3TGpjZ015NDBMVEF1TWlBNExqSXRNQzQ0SURFeExqUXRNUzR6SURNdU15MHdMak1nTlM0NExUQXVOQ0E0TFRBdU15QXdMak10TUM0MUlEQXVNeTB4TGpnZ01DMHpMamd0TUM0ekxUSXVNUzB4TGpjdE5TNDRMVEV1TmkwNExqTWdNQzR5TFRJdU15QXdMamt0TkM0eUlESXVOaTAxTGpjdE1DNDNJREl1TWkweElEUXRNU0ExTGpRZ01DQXhMalVnTUM0NElERXVOU0F4TGpNZ015NDFJREF1TlNBeUxqRWdNQzQ0SURVZ01TNHpJRGd1T1NBeklEQXVNU0EyTGpZZ01DNHpJREV3TGpVZ01DNDJJRE11T1NBd0xqVWdOeTR6SURFdU55QXhNeUF4TGpZZ05TNDJMVEF1TWlBeE5TNHpMVEl1TVNBeU1TMHlMallnTlM0M0xUQXVNU0E1TGpndE1DNHpJREV5TGpjZ01DNHpJRE11TkNBeElEY3VOU0F4TGpRZ01USXVOeUF4TGpZZ05TNHlJREF1TXlBeE1pNDFMVEF1TXlBeE55NDRMVEF1TmlBMUxUQXVOQ0EzTGpJdE1DNDNJREV6TFRFdU15QTFMamd0TUM0MElERTFMamd0TUM0NUlESXlMVEF1T1NBMkxqRWdNQzR4SURrdU9TQXhMalFnTVRRdU55QXhMak1nTkM0M0xUQXVNU0E1TFRBdU9DQXhNeTQwTFRFdU9TQXdMak10TUM0NUlEQXVOaTB4TGpnZ01TNHpMVE11TWlBd0xqWXRNUzR4SURFdU9DMHlMakVnTWk0eUxUUXVOQ0F3TGpNdE1pNHpMVEF1TmkwM0xqZ3RNQzR6TFRrdU5TQXdMak10TVM0MklEQXVOaTB4TGpjZ01TNDJMVEF1TXkwd0xqWWdNaTQ1TFRBdU5TQTFMak1nTUM0eklEY3VOaUF3TGpnZ01pNHpJRE11TVNBMExqTWdOQzR4SURZdU1TQXdMamtnTVM0NUxUQXVNeUF6TGpNZ01TNDJJRFF1TlNBeExqa2dNUzR5SURNdU9TQXhMamNnT1M0MklERXVPU0ExTGpVZ01DNHpJREUzTGpRdE1DNDBJREl6TGprdE1DNDJJRFl1TXkwd0xqSWdPQzQxTFRBdU1pQXhOQzR5TFRBdU5pQTFMall0TUM0MElERXpMakl0TVM0M0lERTVMalF0TVM0NUlEWXVNUzB3TGpFZ01USWdNQzQwSURFM0xqVWdNUzR6YkMwd0xqTWdOUzQzWXpNZ01pNDFJRFl1TWlBekxqWWdPUzQ1SURNdU5TQXpMall0TUM0eUlEY3VOUzB4TGpZZ01URXVPQzAwTGpWc05DNDBMVEkzTkM0MVl5MHdMakl0TUM0eUxURXVNeTB3TGpVdE15NDFMVEV0TWk0eUxUQXVOUzAxTGpRdE1DNDVMVGt1TlMweExqWnNMVEV1T1MweUxqWmpMVE11TWkwd0xqRXROUzQySURBdU1TMDNMallnTUM0MkxUSXVNU0F3TGpZdE15NDFJREV1TXkwMExqVWdNaTQyYkRBdU15QTRMakpqTFRFMkxqRXRNQzR6TFRJNExqTXRNQzQyTFRNM0xqSXRNUzR6TFRndU9TMHdMall0TVRBdU1pMHlMakl0TVRVdU9TMHlMakl0TlM0NUlEQXVNUzB4TXk0MUlERXVPUzB4T0M0NElESXVNaTAxTGpJZ01DNDBMVGN1T0Mwd0xqRXRNVEl1TVNBd0xUUXVOU0F3TGpJdE9TNHhJREF1TkMweE5DNHpJREF1T1Mwd0xqRWdNaTQwTFRBdU1TQTBMalF0TUM0MklEWXVNUzB3TGpVZ01TNDNMVEVnTWk0NUxURXVPU0F6TGprZ01DNDJMVEl1TVNBd0xqY3ROQzR4SURBdU15MDJMVEF1TlMweExqa3RNUzR6TFRNdU55MHlMamt0TlM0MExUWXRNQzQzTFRFeExqY3RNUzB4Tnk0eUxURXVNeTAxTGpjdE1DNHhMVEV3TGpjdE1DMHhOUzQ1SURBdU15QXdMallnTVM0NElEQXVPQ0F6TGpVZ01DNDJJRFV1TVMwd0xqTWdNUzQyTFRFdU5TQXlMalF0TVM0NUlEUXVOUzB3TGpRZ01pNHlMVEF1TlNBMExqZ3RNQzR6SURndU15MHdMVEF1Tnkwd0xqRXRNUzQyTFRBdU15MHlMamt0TUM0ekxURXVNeTB3TGpndE1pNDRMVEV0TkM0MUxUQXVNaTB4TGpRZ01DNHpMVE11TWkwd0xqTXROQzQ0TFRBdU5pMHhMall0TUM0NUxUTXVNaTB6TGpVdE5DNDFMVEl1T0MweExqSXRPQzR4TFRFdU9DMHhNaTQzTFRJdU1pMDBMamd0TUM0ekxURXlMakV0TUM0eExURTFMak1nTVMwekxqRWdNUzR5TFRFdU5TQTJMVE11TWlBMkxURXVPQ0F3TGpFdE15NDVMVFF1T0MwM0xqTXROUzQzTFRNdU5pMHdMamt0T0M0NUlEQXVOQzB4TXk0M0lEQXVNeTAwTGpnZ01DNHhMVGt1T0NBd0xqRXRNVFF1T1NBd0xURWdNUzR6TFRFdU55QXlMamd0TWk0MklEUXVOQzB3TGpnZ01TNDNMVEV1TXlBMUxqVXRNaTR5SURVdU5DMHhMakl0TUMwekxqVXROQzQwTFRNdU9DMDFMamN0TUM0eUxURXVNaUF6TFRBdU9TQXlMall0TVM0NUxUQXVOaTB4TFRFdU5DMHpMamd0TlM0M0xUUXVOQzAwTGpVdE1DNDFMVEV4TGpNdE1DNHhMVEl3TGpjZ01TNHpMVEF1T1NBMExqVXRNaUEyTGpjdE15NDFJRFl1TnkweExqWXRNQzB6TGpJdE5TNDBMVFV1TnkwMkxqY3RNaTQyTFRFdU1pMHlMakV0TUM0ekxUa3VOUzB3TGpZdE55NDNMVEF1TXkweE9TNHpMVEF1TlMwek5TNDJMVEF1T1Mwd0xqWXRNUzQ1TFRJdU15MHpMakV0TlM0MExUTXVOUzB6TGpFdE1DNDBMVGN1TlNBd0xqRXRNVE1nTVM0emJETXVNaUF5TnpFdU4yTXhMallnTVNBekxqSWdNUzQzSURRdU5TQXlMaklnTVM0eUlEQXVOaUF5TGpRZ01DNDRJRE11TWlBd0xqa2dNQzR5SURFdU5DQXdMalFnTWk0M0lEQXVOaUEwTGpFME1YcHRMVGN1TURJdE9HTXpMakl0TUM0MklEWXVNeTB3TGprZ09TNDJMVEF1TmlBekxqSWdNQzR6SURjdU15QXhMak1nT1M0MUlESXVNaUF5TGpJZ01TQXpMalVnTVM0NUlETXVPQ0F6TGpJdE1DNHlMVGd1TVMwd0xqWXRNakl1T1MweExqWXRORFV1TlMweExqRXRNakl1TmkweUxqTXROVEF1TXkwekxqa3RPRGd1TnkweExqVXRNemd1TXkwekxqSXRPRFF1TVMwMUxqRXRNVE01TGpRdE1pNHhMVEV1TWkwMExqTXRNUzQ0TFRjdE1TNDVMVEl1Tnkwd0xUVXVOaUF3TGpVdE9DNDVJREV1TmlBeExqSWdPRGt1TnlBeUxqTWdNVGM1TGpRZ015NDFJREkyT1M0eGVtMHhOQzB5TmpjdU5tTXhOQzQzSURBdU55QXlOUzQwSURFdU1TQXpNaTQySURFdU15QTNMakVnTUM0eUlEY3VNeTB4TGpFZ01UQXVNaUF3SURJdU9DQXhMaklnTlM0eElEWXVNeUEzSURjdU15QXhMamdnTVM0eUlETWdNQzQzSURRdU1TMHdMallnTVM0eUxURXVNaUF4TGprdE15NDJJREl1TmkwM0lEUXVOUzB3TGpRZ09DNDBMVEF1TmlBeE1TNDRMVEF1TmlBekxqVXRNQ0EyTGpZZ01DNHlJRGd1TXlBd0xqWWdNUzQwSURBdU55QXhMakVnTWk0eElEQXVPU0F5TGpndE1DNHlJREF1T0MweExqZ2dNQzQ1TFRFdU5pQXhMamtnTUM0eUlERXVNeUF4TGpjZ015NDFJREl1T0NBMExqZ2dNUzR4SURFdU15QXlMallnTXlBekxqZ2dNaTQySURFdE1DNDBJREV1TnkwekxqTWdNaTQyTFRVdU1TQXdMamd0TVM0M0lERXVOUzB6TGpVZ01pNHlMVFV1TkNBMklEQXVNeUF4TVM0eUlEQXVOQ0F4TlM0MklEQXVNeUEwTGpRdE1DQTNMamd0TUM0NElERXdMalV0TUM0eklESXVOU0F3TGpZZ015NDVJREl1TnlBMUxqUWdNeTQ0SURFdU5TQXhMaklnTXlBekxqRWdOQzR4SURNdU1pQXhJREF1TVNBeExqZ3RNUzR6SURJdU5TMHlMalVnTUM0MkxURXVNaTB4TGpFdE15NDBJREV1TXkwMExqVWdNaTQwTFRFZ09DNDVMVEV1TXlBeE15MHhMak1nTkM0eElEQXVNaUE0TGpnZ01TNHlJREV4TGpVZ01pNHlJREl1TnlBeElETXVOU0F4TGpZZ05DNDFJRE11T0NBd0xqZ2dNaTQwSURBdU1pQTNMamNnTVNBeE1DNHlJREF1T0NBeUxqWWdNUzQ1SURRdU1pQXpMalVnTlM0eExUQXVOaTB6TGpNdE1DNDNMVFl1TVMwd0xqTXRPQzQySURBdU15MHlMalFnTVM0MkxUUXVNU0F5TGpJdE5pQXdMall0TVM0NUlEQXVPUzB6TGprZ01TNHpMVFV1TnlBd0xqWXRNQ0F6TGpNdE1DQTRJREFnTkM0M0lEQXVNU0F4TVM0eklEQXVNaUF5TUM0eElEQXVNeUF4TGpRZ01TNDNJREl1TkNBekxqWWdNeTR5SURVdU55QXdMamNnTWk0eUlERWdOQzQySURFZ055NHpJREV1TXkweExqSWdNaTQwTFRJdU5pQXpMakl0TkM0MUlEQXVPQzB4TGpnZ01TNHpMVE11T0NBeExqWXROaTR6SURFeUlEQXVNU0F5TVM0MkxUQXVNU0F5T1M0ekxUQXVOaUEzTGpZdE1DNDFJREV3TGpVdE1pNHlJREUyTGpJdE1pNHlNeUExTGpVZ01DNHlJRGd1TmlBeExqa2dNVGN1TWlBeUxqWWdPQzQySURBdU5pQXhPUzQ0SURBdU9DQXpOQzR4SURBdU5td3hMak1nTWpVNUxqbGpMVFF1TnkweExURXdMakl0TVM0MUxURTJMamd0TVM0ekxUWXVPQ0F3TGpRdE1UWXVOeUF4TGprdE1qSXVPU0F5TGpZdE5pNHhJREF1TmkwM0xqRWdNQzQyTFRFekxqTWdNQzQyTFRZdU5DQXdMak10TVRrdU1TQXdMalF0TWpRdU1pQXdMVFV1TVMwd0xqVXROQzQ1TFRFdU5TMDJMVEl1TmkweExqTXRNQzQ0TFRBdU5DMHhMVEV1TXkweUxqa3RNUzB4TGpndE15NHpMVFV1TWkwMExqRXRPQzB3TGpndE1pNDJJREF1TVMwMkxqTXRNQzQyTFRndE1DNDVMVEV1TlMwekxqVXRNaTR6TFRRdU1TMHhMak10TUM0NElERXVNU0F3TGpJZ05TQXdJRGN1Tmkwd0xqSWdNaTQzTFRBdU5TQTJMakl0TVM0eklEZ3VNeTB3TGprZ01pNHlMVElnTXk0MkxUTXVOU0EwTGpVdE5DNDRJREV0T0M0NUlERXVOQzB4TWk0MElERXVOaTB6TGpZZ01DNHhMVE11TlMwd0xqY3RPQzQ1TFRFdE5TNDFMVEF1TVMweE5TNDRMVEF0TWpNdU5TQXdMak10Tnk0NUlEQXVOUzB4Tnk0MUlESXVNeTB5TXk0eUlESXVOaTAxTGpjZ01DNDBMVFl1Tnkwd0xqRXRNVEV1TWkwd0xqWXROQzQzTFRBdU5pMHhNUzR4TFRFdU9DMHhOaTQxTFRJdU1pMDFMamN0TUM0eUxURXhMaklnTUM0MUxURTJMallnTVMwMUxqUWdNQzQzTFRFeExqUWdNaTQwTFRFMUxqTWdNaTQyTFRNdU9DQXdMakV0TkM0eUxURXVNeTAzTGpNdE1TNDVMVE11TVMwd0xqVXROaTQ1TFRBdU9TMHhNUzQwTFRFdU15MHhMamN0TXk0MUxUSXVOaTAyTGpZdE1pNDVMVGt1T1Mwd0xqTXRNeTR5SURBdU1TMDJMaklnTVM0ekxUa3VNaTB6SURNdU1pMDFJRFV1TnkwMklEY3VOaTB4TGpJZ01TNDVMVEF1T1NBeUxqTXRNQzQySURRdU1TQXdMak1nTWlBd0xqa2dOQzQxSURJdU1pQTNMall0TUM0NUlEQXVOaTB6TGpVZ01DNDVMVGN1TmlBeExqTXROQzR6SURBdU5DMHhNaTR6SURBdU55MHhOeTR5SURBdU5pMDBMamtnTUMwNExqY3RNQzR5TFRFeExqZ3RNQzQyYkMweE1TNHlMVEkyTnk0eWVtMHROUzQzSURJM015NDVMVEV1TXkwMExqRXROQzQxTFRFdU0yTXpMalF0TUM0eElEWXVOUzB3TGpFZ09TNDFJREF1TmlBeklEQXVOeUExTGpjZ01TNDNJRGd1TXlBekxqSXRNaTQzSURFdU1TMDBMamtnTVM0MkxUY2dNUzQ1Y3kwekxqY2dNQzR5TFRVdU1TMHdMak42YlRNeU9DMHlOell1TW1NdE1TNDRJREF1T1Mwekxqa2dNUzQxTFRZdU55QXhMall0TWk0NUlEQXVNaTAyTGpZdE1DMDVMall0TUM0MkxUTXRNQzQyTFRVdU5DMHhMak10Tnk0MkxUSXVOaUF4TGpJdE1TQXlMamN0TVM0MklEUXVNUzB4TGprZ01TNDBMVEF1TXlBekxqRXRNQzR4SURRdU9DQXdMak5zTXk0eUlESXVNbU16TGprZ01DNHpJRGN1T0NBd0xqWWdNVEV1T0NBd0xqbDZiUzB5TXk0NUlERmpNQzQwSURJMkxqRWdNQzQzSURZeExqSWdNU0F4TURZdU9TQXdMaklnTkRZZ01DNHpJREV3TUM0eUlEQXVNeUF4TmpVdU55QXdMamdnTWk0eElESXVOaUF6TGpFZ05TNDNJREl1T1NBekxUQXVNaUEzTGpNdE1TNDBJREV5TGpjdE15NDRiRFF1TVMweU56QXVNV010TkM0eUlERXROeTQ1SURFdU5TMHhNUzR4SURFdU5pMHpMalVnTUMwMkxqUXRNQzQyTFRndU5pMHhMak10TWk0eUxUQXVOaTB6TGpVdE1TNHhMVFF1TVMweExqbDZJaUJtYVd4c0xYSjFiR1U5SW1WMlpXNXZaR1FpTHo0OGRHVjRkQ0I0UFNJeE1DSWdlVDBpTWprMUlpQm1iMjUwTFdaaGJXbHNlVDBpYzJGdWN5MXpaWEpwWmlJZ1ptOXVkQzF6YVhwbFBTSXhNSEI0SWlCbWIyNTBMWE4wZVd4bFBTSnBkR0ZzYVdNaVBtWnliMjA2SURCNFltVmxaand2ZEdWNGRENDhkR1Y0ZENCbWIyNTBMV1poYldsc2VUMGlVR0Z3ZVhKMWN5d2dabUZ1ZEdGemVTSWdabTl1ZEMxemFYcGxQU0l4TW5CNElpQm1hV3hzUFNKRVlYSnJSMjlzWkdWdWNtOWtJajQ4ZEhOd1lXNGdlRDBpTXpVaUlIazlJalExSWo1b1pXeHNieUJtY21WdUxpQm9iM2NnWVhKbElIbHZkU0JrYjJsdVp6OGdhWFFnYVhNZ1lTQnNiM1psYkhrZ1pHRjVMQ0JrYnp3dmRITndZVzQrUEhSemNHRnVJSGc5SWpNMUlpQjVQU0kyTlNJK2VXOTFJRzV2ZENCMGFHbHVhejg4TDNSemNHRnVQand2ZEdWNGRENDhMM04yWno0PSJ9');
        //uncomment this to return message
        //emit log_string(scroll.tokenURI(scroll.getIdfromAddress(fad)));

    }


}