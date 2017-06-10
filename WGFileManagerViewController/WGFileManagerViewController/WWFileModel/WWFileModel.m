//
//  WWFileModel.m
//  WGFileManagerViewController
//
//  Created by guoyutao on 2017/6/1.
//  Copyright © 2017年 guoyutao. All rights reserved.
//

#import "WWFileModel.h"
#import "WWFileManager.h"

@implementation WWFileModel

- (id)initWithFilePath:(NSString *)filePath{
    if (self = [super init]) {
        self.fileAllPath = filePath;
        self.filePathExtension = [filePath pathExtension];
        self.fileLastPathComponent = [filePath lastPathComponent];
        self.fileDate = [WWFileManager getFileCreatDate:[NSURL URLWithString:filePath]];
        self.fileSize = [WWFileManager getFileSize:[NSURL URLWithString:filePath]];
    }
    return self;
}

#pragma - mark Set
- (void)setFileSize:(float)fileSize {
    if (_fileSize != fileSize) {
        _fileSize = fileSize;
    }
}

- (void)setFilePathExtension:(NSString *)filePathExtension {
    if (_filePathExtension != filePathExtension) {
        _filePathExtension = filePathExtension;
    }
}

- (void)setFileAllPath:(NSString *)fileAllPath {
    if (_fileAllPath != fileAllPath) {
        _fileAllPath = fileAllPath;
    }
}

- (void)setFileLastPathComponent:(NSString *)fileLastPathComponent {
    if (_fileLastPathComponent != fileLastPathComponent) {
        _fileLastPathComponent = fileLastPathComponent;
    }
}

- (void)setFileDate:(NSDate *)fileDate {
    if (_fileDate != fileDate) {
        _fileDate = fileDate;
    }
}


@end
