//
//  WGFileManager.h
//  GreenNanTong
//
//  Created by guoyutao on 16/4/25.
//  Copyright © 2016年 guoyutao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kExtensionWMV @"wmv"
#define kExtensionASF @"asf"
#define kExtensionRM @"rm"
#define kExtensionRMVB @"rmvb"
#define kExtensionMPEG @"mpeg"
#define kExtensionAVI @"avi"
#define kExtensionMP4 @"mp4"

#define kExtensionJPG @"jpg"
#define kExtensionPNG @"png"
#define kExtensionPDF @"pdf"
#define kExtensionJPEG @"jpeg"

#define kExtensionWAV @"wav"
#define kExtensionMP3 @"mp3"
#define kExtensionCaf @"caf"


#define kExtensionXLSX @"xlsx"
#define kExtensionXLS @"xls"
#define kExtensionDOC @"doc"
#define kExtensionDOCX @"docx"
#define kExtensionTXT @"txt"
#define kExtensionHTML @"html"
#define kExtensionXML @"xml"

#define kExtensionRAR @"rar"
#define kExtensionZIP @"zip"
#define kExtensionXIP @"xip"

#define kExtensionVideo @"video"//视频
#define kExtensionAudio @"audio"//音频
#define kExtensionTupian @"tupian"//图片
#define kExtensionYasuobao @"yasuobao"//压缩包
#define kExtensionQita @"qita"//其他
@interface WWFileManager : NSObject

+ (WWFileManager *)sharedManager;


// 写入数据方法
- (void)writeToFile:(NSString *)path data:(NSData *)data complete:(void (^)(BOOL result))complete;

// 读取数据
+ (NSData *)cacheDataWithPath:(NSString *)path;

////组织架构数据缓存
//+ (NSString *)structDataCachesPath;
+ (NSString *)cachePath;

- (void)writeToFile:(NSString *)path dictionary:(NSDictionary *)dic complete:(void (^)(BOOL result))complete;

+ (NSArray *)getAllFilePath:(NSString *)path;

//获取文件创建时间
+ (NSDate *) getFileCreatDate:(NSURL*) URL;

//获取文件大小
+ (float) getFileSize:(NSURL*) URL;

//文件后缀名对比
+ (NSString *)contrastThePathExtension:(NSString *)pathExtension;
@end
