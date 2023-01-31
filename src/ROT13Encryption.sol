// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ROT13Encryption {
    uint256 public number;
    event rot13Performed(bool encrypt, string  input, string  output);

    function rot13Encrypt(string calldata input)external returns(string memory){
        bytes memory casted = bytes(input);
        string memory result = input;
        uint256 l = casted.length;
        for(uint256 i=0; i< l;){
            bytes1  char = casted[i];
            assembly{
                // char = first byte of char
                char := byte(0,char)
                //if character is between [N-Z]
                if and(gt(char, 0x6D), lt(char, 0x7B))
                {
                    // char = A - (char - Z)
                    char := sub(0x60, sub(0x7A, char))
                }
                if iszero(eq(char, 0x20))
                {
                    // add 13 to char
                    {mstore8(add(add(result, 0x20), mul(i,1)), add(char, 13))}
                }
            }

            unchecked {
                ++i;
            }
        }
        emit rot13Performed(true, input, result);
        return result;
    }


    function rot13Decrypt(string calldata input) external returns(string memory){
        bytes memory casted = bytes(input);
        string memory result = input;
        uint256 l = casted.length;
        for(uint256 i=0; i< l;){
            bytes1  char = casted[i];
            assembly{
               char := byte(0,char)
                 if and(gt(char, 0x60), lt(char, 0x6E))
                {
                    char := add(0x7B, sub(char, 0x61))
                }
                if iszero(eq(char, 0x20))
                {
                    // substract 13 to char
                    {mstore8(add(add(result, 0x20), mul(i,1)), sub(char, 13))}
                }
            }

            unchecked {
                ++i;
            }
        }
        emit rot13Performed(false, input, result);
        return result;
    }

}
