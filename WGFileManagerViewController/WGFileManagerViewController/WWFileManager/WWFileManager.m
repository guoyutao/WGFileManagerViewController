//
//  WGFileManager.m
//  GreenNanTong
//
//  Created by guoyutao on 16/4/25.
//  Copyright © 2016年 guoyutao. All rights reserved.
//

#import "WWFileManager.h"
#define kHomedatacaches @"FileCashe"
#define kGnVidodatacaches @"gnVidoDownCashe"

//线程队列名称
static char *queueName = "fileManagerQueue";

@interface WWFileManager(){
    
    //读写队列
    dispatch_queue_t _queue;
    
}
@end

@implementation WWFileManager
{
    
}
+ (WWFileManager *)sharedManager
{
    static WWFileManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (instancetype)init {
    if(self = [super init]) {
        _queue = dispatch_queue_create(queueName, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}


+ (NSData *)filterListCacheData:(NSString *)path{
    
    return [WWFileManager cacheDataWithPath:path];
}

+ (NSString *)cachePath{
    NSString *cachePath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachePath =[cachePath stringByAppendingPathComponent:kHomedatacaches];
    
    NSFileManager *fm =[NSFileManager defaultManager];
    if (![fm fileExistsAtPath:cachePath isDirectory:nil]) {
        BOOL result =[fm createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (result) {
            NSLog(@"---创建DataCache目录成功");
        }else{
            NSLog(@"---创建DataCache目录失败");
        }
    }
    return cachePath;
}

// 写入数据方法
- (void)writeToFile:(NSString *)path data:(NSData *)data complete:(void (^)(BOOL result))complete{
    NSString *cachePath = [WWFileManager cachePath];
    cachePath = [cachePath stringByAppendingPathComponent:path];
    
    NSData *cacheData = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
    __block BOOL result = NO;
    dispatch_barrier_async(_queue, ^{
        result = [cacheData writeToFile:cachePath atomically:YES];
        complete(result);
    });
}
// 读取数据
+ (NSData *)cacheDataWithPath:(NSString *)path{
    NSString *cachePath = [WWFileManager cachePath];
    cachePath = [cachePath stringByAppendingPathComponent:path];
    NSData *data =[NSData dataWithContentsOfFile:cachePath];
    if(data == nil){
        return nil;
    }else {
        return data;
    }
    
}


- (void)writeToFile:(NSString *)path dictionary:(NSDictionary *)dic complete:(void (^)(BOOL result))complete{
    NSString *cachePath = [WWFileManager cachePath];
    cachePath = [cachePath stringByAppendingPathComponent:path];
    NSData *cacheData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    __block BOOL result = NO;
    dispatch_barrier_async(_queue, ^{
        result = [cacheData writeToFile:cachePath atomically:YES];
        complete(result);
    });
}

+ (NSArray *)getAllFilePath:(NSString *)path {
    NSString *cachePath = [WWFileManager cachePath];
    cachePath = [cachePath stringByAppendingPathComponent:path];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:nil];
    NSMutableArray *filesArray = [NSMutableArray new];
    for (NSString *fileName in files) {
        if ([fileName hasSuffix:@"DS_Store"]) {
            continue;
        }else {
            [filesArray addObject:[cachePath stringByAppendingPathComponent:fileName]];
        }
    }
    return filesArray;
}

+ (NSDate *) getFileCreatDate:(NSURL*) URL
{
    NSDate *creatDate;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fm attributesOfItemAtPath:URL.path error:nil];
    if (fileAttributes) {
        if ((creatDate = [fileAttributes objectForKey:NSFileCreationDate])) {
            NSLog(@"date = %@",creatDate);
            return creatDate;
        }
    }
    return nil;
    
}

+ (float) getFileSize:(NSURL*) URL
{
    NSInteger fileTotalSize = 0;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fm attributesOfItemAtPath:URL.path error:nil];

    fileTotalSize = [fileAttributes[NSFileSize] integerValue];
    return fileTotalSize/1000.0/1000;

    
}

+ (NSString *)contrastThePathExtension:(NSString *)pathExtension {
    if ([pathExtension caseInsensitiveCompare:kExtensionWMV] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionASF] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionRM] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionRMVB] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionMPEG] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionAVI] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionMP4] == NSOrderedSame) {
        return kExtensionVideo;
    }else if ([pathExtension caseInsensitiveCompare:kExtensionWAV] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionMP3] == NSOrderedSame ||
              [pathExtension caseInsensitiveCompare:kExtensionCaf] == NSOrderedSame){
        return kExtensionAudio;
    }else if ([pathExtension caseInsensitiveCompare:kExtensionJPG] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionPNG] == NSOrderedSame ||
              [pathExtension caseInsensitiveCompare:kExtensionJPEG] == NSOrderedSame){
        return kExtensionTupian;
    }else if ([pathExtension caseInsensitiveCompare:kExtensionXLSX] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionXLS] == NSOrderedSame){
        return kExtensionXLSX;
    }else if ([pathExtension caseInsensitiveCompare:kExtensionDOC] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionDOCX] == NSOrderedSame){
        return kExtensionDOC;
    }else if ([pathExtension caseInsensitiveCompare:kExtensionTXT] == NSOrderedSame){
        return kExtensionTXT;
    }else if ([pathExtension caseInsensitiveCompare:kExtensionHTML] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionXML] == NSOrderedSame){
        return kExtensionHTML;
    }else if ([pathExtension caseInsensitiveCompare:kExtensionPDF] == NSOrderedSame){
        return kExtensionPDF;
    }else if ([pathExtension caseInsensitiveCompare:kExtensionRAR] == NSOrderedSame || [pathExtension caseInsensitiveCompare:kExtensionZIP] == NSOrderedSame ||
               [pathExtension caseInsensitiveCompare:kExtensionXIP] == NSOrderedSame){
        return kExtensionYasuobao;
    }
    
    return kExtensionQita;
}

////从路径中获得完整的文件名 （带后缀）
//NSString *fileName = [filePath lastPathComponent];
//
////获得文件名 （不带后缀）
//NSString *fileName1 = [filePath stringByDeletingPathExtension];
//
////获得文件的后缀名 （不带'.'）
//NSString *suffix = [filePath pathExtension];


@end
