//
//  ViewController.h
//  WGFileManagerViewController
//
//  Created by guoyutao on 2017/5/31.
//  Copyright © 2017年 guoyutao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WWFileType) {
    WWFileTypeDocument = 0,//文档
    WWFileTypeVideo,//视频
    WWFileTypeAudio,//音频
    WWFileTypeAlbum,//图片
    WWFileTypeOther,//其他
};

@interface ViewController : UIViewController

@property (nonatomic,assign) WWFileType fileType;//文件类型
@end

