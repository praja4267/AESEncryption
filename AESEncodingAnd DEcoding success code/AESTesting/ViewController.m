//
//  ViewController.m
//  AESTesting
//
//  Created by Active Mac05 on 21/01/16.
//  Copyright (c) 2016 techactive. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>
//#import "RNEncryptor.h"
//#import "RNDecryptor.h"
//#import "AESCrypt.h"
//#import "NSString+Base64.h"
#import "StringEncryption.h"
#import "Base64.h"
#include "iconv.h"
#import "QSStrings.h"
//#import "BBAES.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *TextFielsMine;

@end

@implementation ViewController
@synthesize TextFielsMine;
- (void)viewDidLoad {
    [super viewDidLoad];
    TextFielsMine.text = @"1234567812345678";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ButtonAction:(id)sender {
    /*
     
     
     ----------------------------------------BBAES------------------------
    NSData* salt = [BBAES randomDataWithLength:BBAESSaltDefaultLength];
    NSData *key = [BBAES keyBySaltingPassword:@"a22!@#$s8523key!a22bytes8523key!" salt:salt keySize:BBAESKeySize256 numberOfIterations:BBAESPBKDF2DefaultIterationsCount];
    
    NSString *secretMessage = @"My secret message.is a secret message ";
    NSLog(@"Original message: %@", secretMessage);
    
    NSString *encryptedString = [secretMessage bb_AESEncryptedStringForIV:[BBAES randomIV] key:key options:BBAESEncryptionOptionsIncludeIV];
    NSLog(@"Encrypted message: %@", encryptedString);
    
    NSString *decryptedMessage = [encryptedString bb_AESDecryptedStringForIV:nil key:key];
    NSLog(@"Decrypted message: %@", decryptedMessage);
    TextFielsMine.text = decryptedMessage;
    [ViewController testAES128_1];
    */
    /* ------------------      String encryption ------------------*/
    
    // encode ios 7+
    NSString* ivector = @"h_k!m@b#c#d$fp*v";
    NSData *plainData = [ivector dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
//    NSLog(@"%@", base64String); // Zm9v
    // Decoding
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", decodedString); // foo
    
    
//    NSMutableString *iv = @"h_k!m@b#c#d$fp*v";
    NSString *key = @"a22!@#$s8523key!a22bytes8523key!";
    NSString *Mystr = @"one . Two, Three";
    NSString *ZeroString = @"0000000000000000";
    NSString *temString = [ZeroString stringByAppendingString:Mystr];//@"1111111111111111NSDataqwertyuiop";
//    NSLog(@"before encrypted-- %@",temString);
    NSString *ensryptedString=[StringEncryption encWithString:temString key:key];
    NSLog(@"encrypted-- %@",ensryptedString);
//    ensryptedString=@"PlsuqJiwHLtU1gRuseYaUN0XDBxPuqZAcab7HTRc8hY=";
    NSString *decrypted = [StringEncryption decWithString:@"3RcMHE+6pkBxpvsdNFzyFg==" key:key];
    NSLog(@"decrypted-- raja %@",decrypted);
//    TextFielsMine.text = decrypted;
    
//    [ViewController testCipher];
//    [self AES128Test];
    
    /* ***  LYmo Code *** */
    
//    
//    
//    NSString *key = @"a22!@#$s8523key!";
//    NSString *keybig = @"a22!@#$s8523key!a22bytes8523key!";
//    NSString *temString = @"0000000000000000badiali";
//    
//    NSString *ensryptedString=[StringEncryption encWithString:temString key:keybig];
//    NSLog(@"encrypted badi ali -- %@",ensryptedString);
//    
    NSString *decrypted123 = [StringEncryption decWithString:@"sr37XZ/LoZvSbEYKgqOb1VpAAcL+UTcITraWrjNIopOVIVE6mWkrWYLoR1UoZC5hFPFn1jFvL4FPH6C1qdK8++asY582ynypt2W4UnhHTqY=" key:key];
    NSLog(@"decrypted badiali-- %@ ",decrypted123);
//
//    NSString *encryptedString=@"2t81Smj7NTlcgQqjl+ca2QSsRBpYxlhfnwOO1t7JLpg=";
//    NSString *decrypted1 = [StringEncryption decWithString:encryptedString key:keybig];
//    NSLog(@"decrypted by Thirdparty  -- %@",decrypted1);
//    
//    /* doing base 64 decoding manually */
//    
//    NSData* data = [[NSData alloc] initWithBase64EncodedString:@"fZTj4BxWSdCYQW/scUHvx9QoiTNXmxNrGWb/n7eFkR4=" options:0];
//    NSLog(@"the manually base64 decoded data = %@",data);
//    NSData* justDecryptedDataddata = [data AES256DecryptWithKey:keybig];
//    NSLog(@"justDecryptedDataddata after aes 256 decryted = %@",justDecryptedDataddata);
//    NSString* newStr5 = [[NSString alloc] initWithData:justDecryptedDataddata encoding:NSUTF8StringEncoding];
//    NSLog(@"finally utf8 encoded to get original string = %@",newStr5);
//    NSString* decoded = [[NSString alloc] initWithData:[data AES256DecryptWithKey:keybig] encoding:NSUTF8StringEncoding];
//    NSLog(@"the manually nsutf8 decrypted string = %@",decoded);
//    
//    /* decrypting using third party  */
//    
//    NSString *decrypted = [StringEncryption decWithString:encryptedString key:keybig];
//    NSLog(@"decrypted-- %@",decrypted);
//    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
//    [dictParam setValue:encryptedString forKey:@"name"];
    
    
    
}

//+ (void)testAES128_1 {
//    NSString *testVector = @"how is it going now";
//    NSString *initVector = @"00000000000000000000000000000000";
//    NSString *key        = @"a22!@#$s8523key!a22bytes8523key!";
//    NSString *expected   = @"7649abac8119b246cee98e9b12e9197d";
//    
//    NSData *inputData    = [self dataFromHexString:testVector];
//    NSData *keyData      = [self dataFromHexString:key];
//    NSData *ivData       = [self dataFromHexString:initVector];
//    NSData *expectedData = [self dataFromHexString:expected];
//    
//    NSError *error;
//    
//    NSData *current = [ViewController doCiphertestAES128_1:inputData
//                                  iv:ivData
//                                 key:keyData
//                             context:kCCEncrypt
//                               error:&error];
//    NSLog(@"Match: %@",current);
//    BOOL res = [expectedData isEqualToData:current];
//    NSLog(@"Match: %@", res ? @"Yes" : @"No"); // Match: Yes
//}

//+ (NSData *)doCiphertestAES128_1:(NSData *)dataIn
//                  iv:(NSData *)iv
//                 key:(NSData *)symmetricKey
//             context:(CCOperation)encryptOrDecrypt // kCCEncrypt or kCCDecrypt
//               error:(NSError **)error
//{
//    CCCryptorStatus ccStatus   = kCCSuccess;
//    size_t          cryptBytes = 0;
//    NSMutableData  *dataOut    = [NSMutableData dataWithLength:dataIn.length + kCCBlockSizeAES128];
//    
//    ccStatus = CCCrypt( encryptOrDecrypt,
//                       kCCAlgorithmAES128,
//                       0, //kCCOptionPKCS7Padding,
//                       symmetricKey.bytes,
//                       kCCKeySizeAES128,
//                       iv.bytes,
//                       dataIn.bytes,
//                       dataIn.length,
//                       dataOut.mutableBytes,
//                       dataOut.length,
//                       &cryptBytes);
//    
//    if (ccStatus == kCCSuccess) {
//        dataOut.length = cryptBytes;
//    }
//    else {
//        if (error) {
//            *error = [NSError errorWithDomain:@"kEncryptionError"
//                                         code:ccStatus
//                                     userInfo:nil];
//        }
//        dataOut = nil;
//    }
//    
//    return dataOut;
//}

//+ (NSData *)dataFromHexString:(NSString *)string
//{
//    NSMutableData *stringData = [[NSMutableData alloc] init];
//    unsigned char whole_byte;
//    char byte_chars[3] = {'\0','\0','\0'};
//    int i;
//    for (i=0; i < [string length] / 2; i++) {
//        byte_chars[0] = [string characterAtIndex:i*2];
//        byte_chars[1] = [string characterAtIndex:i*2+1];
//        whole_byte = strtol(byte_chars, NULL, 16);
//        [stringData appendBytes:&whole_byte length:1];
//    }
//    return stringData;
//}

//+ (NSData *)doCipher:(NSData *)dataIn
//                  iv:(NSData *)iv
//                 key:(NSData *)symmetricKey
//             context:(CCOperation)encryptOrDecrypt{
//    CCCryptorStatus ccStatus   = kCCSuccess;
//    size_t          cryptBytes = 0;    // Number of bytes moved to buffer.
//    NSMutableData  *dataOut    = [NSMutableData dataWithLength:dataIn.length + kCCBlockSizeAES128];
//    
//    ccStatus = CCCrypt( encryptOrDecrypt,
//                       kCCAlgorithmAES128,
//                       kCCOptionPKCS7Padding,
//                       symmetricKey.bytes,
//                       kCCKeySizeAES128,
//                       iv.bytes,
//                       dataIn.bytes,
//                       dataIn.length,
//                       dataOut.mutableBytes,
//                       dataOut.length,
//                       &cryptBytes);
//    
//    if (ccStatus != kCCSuccess) {
//        NSLog(@"CCCrypt status: %d", ccStatus);
//    }
//    
//    dataOut.length = cryptBytes;
//    return dataOut;
//}

//+ (void) testCipher{
//    NSData *dataIn = [[@"2t81Smj7NTlcgQqjl+ca2QSsRBpYxlhfnwOO1t7JLpg=" base64DecodedString] dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"dataIn = %@",dataIn);
//    NSData *datagivenasInput = [QSStrings decodeBase64WithString:@"2t81Smj7NTlcgQqjl+ca2QSsRBpYxlhfnwOO1t7JLpg="];
//    NSLog(@"datagivenasInput = %@",datagivenasInput);
//    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:@"2t81Smj7NTlcgQqjl+ca2QSsRBpYxlhfnwOO1t7JLpg=" options:0] ;
//    NSLog(@"input data to decoder ios 7+ = %@",decodedData);
//    NSData *key = [@"a22!@#$s8523key!a22bytes8523key!" dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *iv = [@"0000000000000000" dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"input iv to decoder =  %@.", iv);
//    NSLog(@"input data to decoder = %@",decodedData);
//    NSLog(@"input key to decoder = %@",key);
//    
//    
//    NSData *dataOut = [self doCipher:decodedData iv:iv key:key context:kCCDecrypt];
//    NSString* nonUllTerminated = [[NSString alloc] initWithData:dataOut encoding:NSUTF8StringEncoding];
//     NSLog(@"nonAsciiTerminated = %@",nonUllTerminated);
//    NSString* nullTerminated = [[NSString alloc] initWithData:dataOut encoding:NSASCIIStringEncoding];
//    NSLog(@"AsciiTerminated = %@",nullTerminated);
//    
//    
//    
//    
//    NSLog(@"data srting out = %@", [[NSString alloc] initWithData:dataOut
//                                     encoding:NSUTF8StringEncoding]);
//    
//    NSString* strOut = [[[NSString alloc] initWithData:dataOut
//                                              encoding:NSUTF8StringEncoding] base64DecodedString];
//    NSLog(@"output string after decoding =  %@.", strOut);
//    NSLog(@" the decoded string is %@",[@"itvAOlVSSD8unOzTMYa8Thnjh7lX6Bb39+BGP8kn+VQ==" base64DecodedString]);
////    NSLog(@" the encoded 64 base  string is %@",[@"1111111111111111" base64EncodedString]);
//    
//    
//}


//- (NSData *)cleanUTF8:(NSData *)data {
//    // this function is from
//    // http://stackoverflow.com/questions/3485190/nsstring-initwithdata-returns-null
//    //
//    //
//    iconv_t cd = iconv_open("UTF-8", "UTF-8"); // convert to UTF-8 from UTF-8
//    int one = 1;
//    iconvctl(cd, ICONV_SET_DISCARD_ILSEQ, &one); // discard invalid characters
//    size_t inbytesleft, outbytesleft;
//    inbytesleft = outbytesleft = data.length;
//    char *inbuf  = (char *)data.bytes;
//    char *outbuf = malloc(sizeof(char) * data.length);
//    char *outptr = outbuf;
//    if (iconv(cd, &inbuf, &inbytesleft, &outptr, &outbytesleft)
//        == (size_t)-1) {
//        NSLog(@"this should not happen, seriously");
//        return nil;
//    }
//    NSData *result = [NSData dataWithBytes:outbuf length:data.length - outbytesleft];
//    iconv_close(cd);
//    free(outbuf);
//    return result;
//}


//- (void)AES128Test {
//    
//    
//    NSString *key = @"a22!@#$s8523key!a22bytes8523key!";
//    
//    NSData *cipherData;
//    NSData *cipherData123;
//    NSString *base64Text;
//    NSString *plainText;
//    NSString *plainText123;
//    NSString *iv;
//    //############## Request(crypt) ##############
//    ////----    Plain text -> AES128
//    plainText  = @"0000000000000000Hello, world!";
//    iv = @"0000000000000000";
//    cipherData = [[plainText dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptedDataWithKey:key];
//    cipherData123 = [[plainText dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptedDataWithKey:key iv:iv];
//    NSLog(@"crypt AES128: %@", cipherData);
//    NSLog(@"crypt AES128: with iv %@", cipherData123);
//    
//    ////----    AES128 -> base64
//    // base 64 encryption
//    base64Text = @"PlsuqJiwHLtU1gRuseYaUN0XDBxPuqZAcab7HTRc8hY="; //[cipherData base64EncodedStringWithOptions:0];
//    
//    NSLog(@"crypt AES128+base64: %@", base64Text);
//    
//    //############## Response(decrypt) ##############
//    ////---- AES128 -> plain text
//    plainText  = [[NSString alloc] initWithData:[cipherData AES128DecryptedDataWithKey:key]
//                                       encoding:NSUTF8StringEncoding];
//    plainText123 = [[NSString alloc] initWithData:[cipherData123 AES128DecryptedDataWithKey:key]
//                                         encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"decrypt AES128: %@",plainText);
//    NSLog(@"decrypt AES128: with iv  %@",plainText);
//    
//    ////----    base64 -> AES128 -> plain text
//    // NSData from the Base64 encoded str
//    cipherData = [[NSData alloc] initWithBase64EncodedString:base64Text
//                                                     options:0];
//    
//    plainText  = [[NSString alloc] initWithData:[cipherData AES128DecryptedDataWithKey:key]
//                                       encoding:NSUTF8StringEncoding];
//    NSLog(@"decrypt AES128+base64: %@", plainText);
//}



@end
