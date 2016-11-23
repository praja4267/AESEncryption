//
//  CryptLib.h
//

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+Base64.h"

@interface StringEncryption : NSObject

+(NSString*)encWithString:(NSString*)string key:(NSString*)key;
+(NSString*)decWithString:(NSString*)string key:(NSString*)key;

@end
