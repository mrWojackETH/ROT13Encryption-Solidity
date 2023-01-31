// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ROT13Encryption.sol";

contract CounterTest is Test {
    ROT13Encryption public encrypter;

    function setUp() public {
        encrypter = new ROT13Encryption();
    }

    function test_words_encrypt() public {
        assertEq(encrypter.rot13Encrypt("cow"), "pbj");
        assertEq(encrypter.rot13Encrypt("house"), "ubhfr");
        assertEq(encrypter.rot13Encrypt("dog"), "qbt");
        assertEq(encrypter.rot13Encrypt("girl"), "tvey");
        assertEq(encrypter.rot13Encrypt("floor"), "sybbe");
    }

    function test_sentences_encrypt() public{
        assertEq(encrypter.rot13Encrypt("My friend has a bycicle"), "Zl sevraq unf n olpvpyr");
        assertEq(encrypter.rot13Encrypt("I will take a walk"), "V jvyy gnxr n jnyx");
        assertEq(encrypter.rot13Encrypt("I like animals"), "V yvxr navznyf");
    }

    function test_words_decrypt() public {
        assertEq(encrypter.rot13Decrypt("pbj"), "cow");
        assertEq(encrypter.rot13Decrypt("ubhfr"), "house");
        assertEq(encrypter.rot13Decrypt("qbt"), "dog");
        assertEq(encrypter.rot13Decrypt("tvey"), "girl");
        assertEq(encrypter.rot13Decrypt("sybbe"), "floor");
    }

    function test_sentences_decrypt() public{
        assertEq(encrypter.rot13Decrypt("Zl sevraq unf n olpvpyr"), "My friend has a bycicle");
        assertEq(encrypter.rot13Decrypt("V jvyy gnxr n jnyx"), "I will take a walk");
        assertEq(encrypter.rot13Decrypt("V yvxr navznyf"), "I like animals");
    }
}
