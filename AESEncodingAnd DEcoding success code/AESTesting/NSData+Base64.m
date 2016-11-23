//
//  NSData+Base64.m
//  base64
//
//  Created by Matt Gallagher on 2009/06/03.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
//

#import "NSData+Base64.h"
#include <stdlib.h>
#include <stdint.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (Base64)

- (NSData *)AES256EncryptWithKey:(NSString *)key
{
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
//    const char iv[16] = { 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,   0xcd, 0xcd, 0xcd, 0xcd };
//    printf(iv);
//    uint8_t iv[kCCBlockSizeAES128];
//    arc4random_buf(&iv, kCCBlockSizeAES128);
//
    char iv[kCCBlockSizeAES128 + 1];
    bzero(iv, sizeof(iv));
    printf(iv);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES, kCCOptionECBMode + kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          iv /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    NSLog(@"size of iv is %lu yes.",sizeof(iv));
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

//-(NSData *)AES128EncryptWithKey:(NSString *)key {
//    // ‘key’ should be 16 bytes for AES128
//    char keyPtr[kCCKeySizeAES128 + 1]; // room for terminator (unused)
//    bzero( keyPtr, sizeof( keyPtr ) ); // fill with zeroes (for padding)
//    
//    // fetch key data
//    [key getCString:keyPtr maxLength:sizeof( keyPtr ) encoding:NSUTF8StringEncoding];
//    
//    NSUInteger dataLength = [self length];
//    
//    //See the doc: For block ciphers, the output size will always be less than or
//    //equal to the input size plus the size of one block.
//    //That’s why we need to add the size of one block here
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc( bufferSize );
//    
//    size_t numBytesEncrypted = 0;
//    NSData *iv = [@"0000000000000000" dataUsingEncoding:NSUTF8StringEncoding];
//    CCCryptorStatus cryptStatus = CCCrypt( kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
//                                          keyPtr, kCCKeySizeAES128,
//                                          iv.bytes /* initialization vector (optional) */,
//                                          [self bytes], dataLength, /* input */
//                                          buffer, bufferSize, /* output */
//                                          &numBytesEncrypted );
//    if( cryptStatus == kCCSuccess )
//    {
//        //the returned NSData takes ownership of the buffer and will free it on deallocation
//        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
//    }
//    
//    free( buffer ); //free the buffer
//    return nil;
//}

- (NSData *)AES256DecryptWithKey:(NSString *)key
{
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
//    const char iv[16] = { 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,   0xcd, 0xcd, 0xcd, 0xcd };
    char iv[kCCBlockSizeAES128];
    bzero(iv, sizeof(iv));
//    [key getCString:keyPtr maxLength:sizeof( keyPtr ) encoding:NSUTF8StringEncoding];
//    printf(iv);
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionECBMode + kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          iv /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

//- (NSData *)AES128EncryptedDataWithKey:(NSString *)key
//{
//    return [self AES128EncryptedDataWithKey:key iv:nil];
//}
//
//- (NSData *)AES128DecryptedDataWithKey:(NSString *)key
//{
//    return [self AES128DecryptedDataWithKey:key iv:nil];
//}
//
//- (NSData *)AES128EncryptedDataWithKey:(NSString *)key iv:(NSString *)iv
//{
//    return [self AES128Operation:kCCEncrypt key:key iv:iv];
//}
//
//- (NSData *)AES128DecryptedDataWithKey:(NSString *)key iv:(NSString *)iv
//{
//    return [self AES128Operation:kCCDecrypt key:key iv:iv];
//}
//
//- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv
//{
//    char keyPtr[kCCKeySizeAES128 + 1];
//    bzero(keyPtr, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    
//    char ivPtr[kCCBlockSizeAES128 + 1];
//    bzero(ivPtr, sizeof(ivPtr));
//    if (iv) {
//        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
//    }
//    
//    NSUInteger dataLength = [self length];
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(operation,
//                                          kCCAlgorithmAES128,
//                                          kCCOptionECBMode + kCCOptionPKCS7Padding,
//                                          keyPtr,
//                                          kCCBlockSizeAES128,
//                                          ivPtr,
//                                          [self bytes],
//                                          dataLength,
//                                          buffer,
//                                          bufferSize,
//                                          &numBytesEncrypted);
//    if (cryptStatus == kCCSuccess) {
//        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
//    }
//    free(buffer);
//    return nil;
//}



@end