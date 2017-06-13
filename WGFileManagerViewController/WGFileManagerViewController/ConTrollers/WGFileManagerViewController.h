//
//  WGFileManagerViewController.h
//  WGFileManagerViewController
//
//  Created by guoyutao on 2017/6/13.
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

typedef NS_ENUM(NSUInteger, OpenType) {
    OpenTypeSend = 0,//发送
    OpenTypeLook,//查看
};

@interface WGFileManagerViewController : UIViewController
@property (nonatomic,strong,readonly) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;//文件路径数组
@property (nonatomic,strong) NSMutableArray *selectedDataArray;//选中文件数组
@property (nonatomic,strong,readonly) NSMutableArray *videoFileArray;//视频数组
@property (nonatomic,strong,readonly) NSMutableArray *albumFileArray;//相册数组
@property (nonatomic,strong,readonly) NSMutableArray *audioFileArray;//音乐数组
@property (nonatomic,strong,readonly) NSMutableArray *documentFileArray;//文件数组
@property (nonatomic,strong,readonly) NSMutableArray *otherFileArray;//其他数组
@property (nonatomic,assign) WWFileType fileType;//文件类型
@property (nonatomic,assign) OpenType fileOpenType;//文件管理类展示方式（发送、查看）

- (instancetype)initWithOpenType:(OpenType)type dataArray:(NSArray *)dataArray;
@end


