//
//  WWFileModel.h
//  WGFileManagerViewController
//
//  Created by guoyutao on 2017/6/1.
//  Copyright © 2017年 guoyutao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWFileModel : NSObject
- (id)initWithFilePath:(NSString *)filePath;
@property (nonatomic,assign) float fileSize;//文件大小
@property (nonatomic,copy) NSString *filePathExtension;//文件后缀名
@property (nonatomic,copy) NSString *fileAllPath;//文件全路径
@property (nonatomic,copy) NSString *fileLastPathComponent;//文件名 “abc.mp4”
@property (nonatomic,strong) NSDate *fileDate;//文件创建日期




@end
