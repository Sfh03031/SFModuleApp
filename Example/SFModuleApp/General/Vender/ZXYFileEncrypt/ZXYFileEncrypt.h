//
//  ZXYFileEncrypt.h
//
//  Created by Spark        on 16/7/22.
//  Copyright © 2022年 zhixueyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXYFileEncrypt : NSObject

typedef void(^EncryptCompletionHandler)(NSString *msg);
typedef void(^DecryptCompletionHandler)(NSString *decryptFilePath);

//加密文件
+ (void)encryptFileWithFilePath:(NSString*)filePath completion:(EncryptCompletionHandler)completion;

//解密文件
+ (void)decryptFileWithFilePath:(NSString*)filePath completion:(DecryptCompletionHandler)completion;

//是否是加密文件
+ (BOOL)IsEncryptFileWithFilePath:(NSString*)filePath;

@end
