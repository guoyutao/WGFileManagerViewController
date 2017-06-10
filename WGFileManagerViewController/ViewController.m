//
//  ViewController.m
//  WGFileManagerViewController
//
//  Created by guoyutao on 2017/5/31.
//  Copyright © 2017年 guoyutao. All rights reserved.
//

#import "ViewController.h"
#import "WGSelectedItemView.h"
#import "WWFileManager.h"
#import "WWFileModel.h"
#import "WWFileManagerTableViewCell.h"
#import "WWWebViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,WGSelectedItemViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *videoFileArray;//视频数组
@property (nonatomic,strong) NSMutableArray *albumFileArray;//相册数组
@property (nonatomic,strong) NSMutableArray *audioFileArray;//音乐数组
@property (nonatomic,strong) NSMutableArray *yaSuoBaoFileArray;//压缩包
@property (nonatomic,strong) NSMutableArray *documentFileArray;//html数组
//@property (nonatomic,strong) NSMutableArray *txtFileArray;//txt数组
//@property (nonatomic,strong) NSMutableArray *docFileArray;//doc数组
//@property (nonatomic,strong) NSMutableArray *excelFileArray;//excel数组
//@property (nonatomic,strong) NSMutableArray *pdfFileArray;//excel数组
//
@property (nonatomic,strong) NSMutableArray *otherFileArray;//其他数组




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _documentFileArray = [NSMutableArray new];
    _videoFileArray = [NSMutableArray new];
    _albumFileArray = [NSMutableArray new];
    _audioFileArray = [NSMutableArray new];
//    _htmlFileArray = [NSMutableArray new];
//    _txtFileArray = [NSMutableArray new];
//    _excelFileArray = [NSMutableArray new];
//    _pdfFileArray = [NSMutableArray new];
    _yaSuoBaoFileArray = [NSMutableArray new];
    
    _otherFileArray = [NSMutableArray new];
    self.fileType = WWFileTypeDocument;
    
    
    NSArray *titleArray = @[@"文档",@"视频",@"相册",@"音乐",@"其他"];
    WGSelectedItemView *itemView = [[WGSelectedItemView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) itmeTiteArray:titleArray selectedColor:[UIColor colorWithRed:68.0/255.0 green:181.0/255.0 blue:232.0/255.0 alpha:1] normalColor:[UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1]];
    itemView.delegate = self;
    [self.view addSubview:itemView];
    
    _tableView  =[[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 50) style:UITableViewStylePlain];
    _tableView.rowHeight = 50;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
//    [[WGFileManager sharedManager] writeToFile:@"files" data:nil complete:^(BOOL result) {
//        
//    }];
    NSLog(@"%@",[WWFileManager cachePath]);
    //NSArray *arr = [WWFileManager getAllFilePath:@"files"];
    
//    NSDate *date = [WWFileManager getFileCreatDate:[NSURL URLWithString:arr[1]]];
//    
//    float fileSize = [WWFileManager getFileSize:[NSURL URLWithString:arr[1]]];//25kb

    
    NSString *str = [[NSBundle mainBundle] pathForResource:@"resorces/历年人民币汇率(年均价)-1978-2014" ofType:@"xlsx"];
    NSString *str2 = [[NSBundle mainBundle] pathForResource:@"resorces/统计表" ofType:@"xls"];
    NSString *str3 = [[NSBundle mainBundle] pathForResource:@"resorces/高中英语语法大全TXT版" ofType:@"txt"];
    NSString *str4 = [[NSBundle mainBundle] pathForResource:@"resorces/香港美景" ofType:@"pdf"];
    NSString *str5 = [[NSBundle mainBundle] pathForResource:@"resorces/压缩包" ofType:@"rar"];
    NSString *str6 = [[NSBundle mainBundle] pathForResource:@"resorces/压缩包2" ofType:@"zip"];
    NSString *str7 = [[NSBundle mainBundle] pathForResource:@"resorces/压缩包3" ofType:@"xip"];
    NSString *str8 = [[NSBundle mainBundle] pathForResource:@"resorces/音乐" ofType:@"caf"];
    NSString *str9 = [[NSBundle mainBundle] pathForResource:@"resorces/音乐2" ofType:@"mp3"];
    NSString *str10 = [[NSBundle mainBundle] pathForResource:@"resorces/音乐3" ofType:@"wav"];
    NSString *str11 = [[NSBundle mainBundle] pathForResource:@"resorces/怎么写优美的文章" ofType:@"doc"];
    NSString *str12 = [[NSBundle mainBundle] pathForResource:@"resorces/优美身姿从少女时期做起" ofType:@"docx"];
    NSString *str13 = [[NSBundle mainBundle] pathForResource:@"resorces/AVI视频" ofType:@"avi"];
    NSString *str14 = [[NSBundle mainBundle] pathForResource:@"resorces/HTML文件" ofType:@"html"];
    NSString *str15 = [[NSBundle mainBundle] pathForResource:@"resorces/JPEG图片" ofType:@"jpeg"];
    NSString *str16 = [[NSBundle mainBundle] pathForResource:@"resorces/JPG图片" ofType:@"jpg"];
    NSString *str17 = [[NSBundle mainBundle] pathForResource:@"resorces/PNG图片" ofType:@"png"];
    NSString *str18 = [[NSBundle mainBundle] pathForResource:@"resorces/MP4视频" ofType:@"mp4"];
    NSString *str19 = [[NSBundle mainBundle] pathForResource:@"resorces/MPEG视频" ofType:@"mpeg"];
    NSString *str20 = [[NSBundle mainBundle] pathForResource:@"resorces/rmvb视频" ofType:@"rm"];
    NSString *str21 = [[NSBundle mainBundle] pathForResource:@"resorces/MPEG视频" ofType:@"rmvb"];
    NSString *str22 = [[NSBundle mainBundle] pathForResource:@"resorces/wmv视频" ofType:@"wmv"];
    NSString *str23 = [[NSBundle mainBundle] pathForResource:@"resorces/ASF视频" ofType:@"asf"];
    NSString *str24 = [[NSBundle mainBundle] pathForResource:@"resorces/xml文件" ofType:@"xml"];
    
    
    NSMutableArray *resorceArray = [[NSMutableArray alloc]initWithObjects:str,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15,str16,str17,str18,str19,str20,str21,str22,str23,str24, nil];
    
    for (NSString *str in resorceArray) {
        WWFileModel *model = [[WWFileModel alloc]initWithFilePath:str];
        NSLog(@"%@",model.filePathExtension);
       NSString *filePathExtension = [WWFileManager contrastThePathExtension:model.filePathExtension];
        if ([filePathExtension isEqualToString:kExtensionVideo]) {
            [_videoFileArray addObject:model];
        }else if ([filePathExtension isEqualToString:kExtensionAudio]) {
            [_audioFileArray addObject:model];
        }else if ([filePathExtension isEqualToString:kExtensionTupian]) {
            [_albumFileArray addObject:model];
        }else if ([filePathExtension isEqualToString:kExtensionYasuobao]) {
            [_yaSuoBaoFileArray addObject:model];
        }else if ([filePathExtension isEqualToString:kExtensionHTML]) {
            [_documentFileArray addObject:model];
        }else if ([filePathExtension isEqualToString:kExtensionXLSX]) {
            [_documentFileArray addObject:model];
        }else if ([filePathExtension isEqualToString:kExtensionDOC]) {
            [_documentFileArray addObject:model];
        }else if ([filePathExtension isEqualToString:kExtensionTXT]) {
            [_documentFileArray addObject:model];
        }else if ([filePathExtension isEqualToString:kExtensionTupian]) {
            [_albumFileArray addObject:model];
        }else if ([filePathExtension isEqualToString:kExtensionPDF]) {
            [_documentFileArray addObject:model];
        }
    }
    
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [_tableView reloadData];
    
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - UITableViewDelegate

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return _titleArray.count + 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.fileType == WWFileTypeDocument) {
        return _documentFileArray.count;
    } else if (self.fileType == WWFileTypeVideo) {
        return _videoFileArray.count;
    }else if (self.fileType == WWFileTypeAudio) {
        return _audioFileArray.count;
    }else if (self.fileType == WWFileTypeAlbum) {
        return _albumFileArray.count;
    }
        return _otherFileArray.count;
}

//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        return 80;
//    }else {
//        return kCell_Height;
//    }
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 16;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0.0001;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 6)];
//    sectionHeader.backgroundColor = [UIColor colorWithHexString:tableectionbackcolor];
//    return sectionHeader;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *sectionFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 6)];
//    sectionFooter.backgroundColor = shallowGrayColor;
//    return sectionFooter;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *ID = @"WWFileManagerTableViewCell";
    WWFileManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WWFileManagerTableViewCell" owner:nil options:nil]lastObject];
    }
    
    if (_fileType == WWFileTypeDocument) {
        WWFileModel *model = _documentFileArray[indexPath.row];
        cell.titleLabel.text = model.fileLastPathComponent;
        
        NSString *filePathExtension = [WWFileManager contrastThePathExtension:model.filePathExtension];
        if ([filePathExtension isEqualToString:kExtensionHTML]) {
            cell.iconImageView.image = [UIImage imageNamed:@"fileicon_unkown90"];
        }else if ([filePathExtension isEqualToString:kExtensionXLSX]) {
            cell.iconImageView.image = [UIImage imageNamed:@"fileicon_xls90"];
        }else if ([filePathExtension isEqualToString:kExtensionDOC]) {
            cell.iconImageView.image = [UIImage imageNamed:@"fileicon_word90"];
        }else if ([filePathExtension isEqualToString:kExtensionTXT]) {
            cell.iconImageView.image = [UIImage imageNamed:@"fileicon_txt90"];
        }else if ([filePathExtension isEqualToString:kExtensionPDF]) {
            cell.iconImageView.image = [UIImage imageNamed:@"fileicon_pdf90"];
        }
    }else if (self.fileType == WWFileTypeVideo) {
        WWFileModel *model = _videoFileArray[indexPath.row];
        cell.titleLabel.text = model.fileLastPathComponent;
        
        NSString *filePathExtension = [WWFileManager contrastThePathExtension:model.filePathExtension];
        if ([filePathExtension isEqualToString:kExtensionVideo]) {
            cell.iconImageView.image = [UIImage imageNamed:@"fileicon_video90"];
        }
    }else if (self.fileType == WWFileTypeAudio) {
        WWFileModel *model = _audioFileArray[indexPath.row];
        cell.titleLabel.text = model.fileLastPathComponent;
        
        NSString *filePathExtension = [WWFileManager contrastThePathExtension:model.filePathExtension];
        
      if ([filePathExtension isEqualToString:kExtensionAudio]) {
            cell.iconImageView.image = [UIImage imageNamed:@"fileicon_music90"];
        }
    }else if (self.fileType == WWFileTypeAlbum) {
        WWFileModel *model = _albumFileArray[indexPath.row];
        cell.titleLabel.text = model.fileLastPathComponent;
        
        NSString *filePathExtension = [WWFileManager contrastThePathExtension:model.filePathExtension];
        if ([filePathExtension isEqualToString:kExtensionTupian]) {
            cell.iconImageView.image = [UIImage imageNamed:@"fileicon_unkown90"];
        }
    }else if (self.fileType == WWFileTypeOther) {
        WWFileModel *model = _otherFileArray[indexPath.row];
        cell.titleLabel.text = model.fileLastPathComponent;
        cell.iconImageView.image = [UIImage imageNamed:@"fileicon_unkown90"];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (_fileType == WWFileTypeDocument) {
        WWFileModel *model = _documentFileArray[indexPath.row];
        WWWebViewController *webVc = [WWWebViewController new];
        webVc.urlString = model.fileAllPath;
        [self.navigationController pushViewController:webVc animated:YES];
        
    }else if (self.fileType == WWFileTypeVideo) {
        WWFileModel *model = _videoFileArray[indexPath.row];
        
    }else if (self.fileType == WWFileTypeAudio) {
        WWFileModel *model = _audioFileArray[indexPath.row];
        
    }else if (self.fileType == WWFileTypeAlbum) {
        WWFileModel *model = _albumFileArray[indexPath.row];
        
    }else if (self.fileType == WWFileTypeOther) {
        WWFileModel *model = _otherFileArray[indexPath.row];
    }
}

#pragma - mark WGSelectedItemViewDelegate

- (void)itemSelectChanged:(NSInteger)itemTag {
    if (itemTag == 0) {
        self.fileType = WWFileTypeDocument;
    }else if (itemTag == 1) {
        self.fileType = WWFileTypeVideo;
    }else if (itemTag == 2) {
        self.fileType = WWFileTypeAlbum;
    }else if (itemTag == 3) {
        self.fileType = WWFileTypeAudio;
    }else if (itemTag == 4) {
        self.fileType = WWFileTypeOther;
    }
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
