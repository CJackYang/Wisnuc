//
//  CSDownloadModel.h
//  WisnucBox
//
//  Created by wisnuc-imac on 2017/11/7.
//  Copyright © 2017年 JackYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSDownloadModel : NSObject

@property(nonatomic, strong, getter = getDownloadFileName) NSString* downloadFileName;

@property(nonatomic, strong, getter = getDownloadFileAvatorURL) NSString* downloadFileAvatorURL;

@property(nonatomic, strong, getter = getDownloadFinishTime) NSString* downloadFinishTime;

@property(nonatomic, strong, getter = getDownloadFileSize) NSNumber* downloadFileSize;

@property(nonatomic, strong, getter = getDownloadedFileSize) NSNumber* downloadedFileSize;

@property(nonatomic, strong, getter = getDownloadFileVersion) NSString* downloadFileVersion;

@property(nonatomic, strong, getter = getDownloadTaskURL) NSString* downloadTaskURL;

@property(nonatomic, strong, getter = getDownloadFileSavePath) NSString* downloadFileSavePath;

@property(nonatomic, strong, getter = getDownloadTempSavePath) NSString* downloadTempSavePath;

@property(nonatomic, strong, getter = getDownloadFilePlistURL) NSString* downloadFilePlistURL;

@end
