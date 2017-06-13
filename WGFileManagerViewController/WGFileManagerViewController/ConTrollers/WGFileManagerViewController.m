//
//  WGFileManagerViewController.m
//  WGFileManagerViewController
//
//  Created by guoyutao on 2017/6/13.
//  Copyright © 2017年 guoyutao. All rights reserved.
//

#import "WGFileManagerViewController.h"
#import "WGSelectedItemView.h"
#import "WWFileManager.h"
#import "WWFileModel.h"
#import "WWFileManagerTableViewCell.h"
#import "WWWebViewController.h"

@interface WGFileManagerViewController ()<UITableViewDelegate,UITableViewDataSource,WGSelectedItemViewDelegate>
@property (nonatomic,strong) WGSelectedItemView *itemView;
@property (nonatomic,strong) UIView *bottomCountView;
@property (nonatomic,strong) UIButton *bottomSendButton;
@property (nonatomic,strong) UILabel *bottomCountLabel;
@end

@implementation WGFileManagerViewController

- (instancetype)initWithOpenType:(OpenType)type dataArray:(NSArray *)dataArray{
    if (self = [super init]) {
        _fileOpenType = type;
        _dataArray = dataArray;
        [self initDataArray];
    }
    return self;
}

- (void)initDataArray {
    _documentFileArray = [NSMutableArray new];
    _videoFileArray = [NSMutableArray new];
    _albumFileArray = [NSMutableArray new];
    _audioFileArray = [NSMutableArray new];
    _otherFileArray = [NSMutableArray new];
    
    _selectedDataArray = [NSMutableArray new];
    
    for (NSString *str in _dataArray) {
        WWFileModel *model = [[WWFileModel alloc]initWithFilePath:str];
        NSLog(@"%@",model.filePathExtension);
        NSString *filePathExtension = [WWFileManager contrastThePathExtension:model.filePathExtension];
        if ([filePathExtension isEqualToString:kExtensionVideo]) {
            [_videoFileArray addObject:model];
        }else if ([filePathExtension isEqualToString:kExtensionAudio]) {
            [_audioFileArray addObject:model];
        }else if ([filePathExtension isEqualToString:kExtensionTupian]) {
            [_albumFileArray addObject:model];
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
        }else if ([filePathExtension isEqualToString:kExtensionYasuobao] || [filePathExtension isEqualToString:kExtensionQita]) {
            [_otherFileArray addObject:model];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.fileType = WWFileTypeDocument;
    NSArray *titleArray = @[@"文档",@"视频",@"相册",@"音乐",@"其他"];
    _itemView = [[WGSelectedItemView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) itmeTiteArray:titleArray selectedColor:[UIColor colorWithRed:68.0/255.0 green:181.0/255.0 blue:232.0/255.0 alpha:1] normalColor:[UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1]];
    _itemView.delegate = self;
    [self.view addSubview:_itemView];
    
    _tableView  =[[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 50) style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.rowHeight = 50;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    if (_fileOpenType == OpenTypeSend) {
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        _tableView.editing = YES;
    }
    [self.view addSubview:_tableView];
    [self initSubViews];
    //    [[WGFileManager sharedManager] writeToFile:@"files" data:nil complete:^(BOOL result) {
    //
    //    }];
    NSLog(@"%@",[WWFileManager cachePath]);
    //NSArray *arr = [WWFileManager getAllFilePath:@"files"];
    
    //    NSDate *date = [WWFileManager getFileCreatDate:[NSURL URLWithString:arr[1]]];
    //
    //    float fileSize = [WWFileManager getFileSize:[NSURL URLWithString:arr[1]]];//25kb
    
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [_tableView reloadData];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initSubViews{
    
    if (_fileOpenType == OpenTypeSend) {
        //bottomCountView
        _bottomCountView = [UIView new];
        [self.view addSubview:_bottomCountView];
        _bottomCountView.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomCountView.backgroundColor = [UIColor whiteColor];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomCountView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomCountView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomCountView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomCountView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:50]];
        
        //lineView
        UIView *lineView = [UIView new];
        [_bottomCountView addSubview:lineView];
        lineView.translatesAutoresizingMaskIntoConstraints = NO;
        lineView.backgroundColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1];
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_bottomCountView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_bottomCountView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_bottomCountView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.5]];
        
        //countButton
         _bottomSendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomCountView addSubview:_bottomSendButton];
        _bottomSendButton.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomSendButton.backgroundColor = [UIColor colorWithRed:68.0/255.0 green:181.0/255.0 blue:232.0/255.0 alpha:1];
        [_bottomSendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomSendButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_bottomCountView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomSendButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_bottomCountView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10]];
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomSendButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:60]];
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomSendButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:36]];
        
        //countLabel
        _bottomCountLabel = [UILabel new];
        [_bottomCountView addSubview:_bottomCountLabel];
        _bottomCountLabel.font = [UIFont systemFontOfSize:13];
        _bottomCountLabel.textColor = [UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1];
        _bottomCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomCountLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_bottomCountView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomCountLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_bottomCountView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10]];
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomCountLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:80]];
        [_bottomCountView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomCountLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:36]];
        
        //tableView
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_itemView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_bottomCountView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    }else {
        //tableView
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_itemView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    }
}

- (void)reloadSelectedviews{
    float filesZie = 0;
    for (WWFileModel *model in _selectedDataArray) {
        filesZie += model.fileSize;
        NSLog(@"%f",model.fileSize);
    }
     _bottomCountLabel.text = [NSString stringWithFormat:@"已选%.2fMB",filesZie];
}




#pragma mark - UITableViewDelegate

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
    WWFileModel *model = nil;
    if (_fileType == WWFileTypeDocument) {
        model = _documentFileArray[indexPath.row];
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
        model = _videoFileArray[indexPath.row];
        cell.titleLabel.text = model.fileLastPathComponent;
        
        NSString *filePathExtension = [WWFileManager contrastThePathExtension:model.filePathExtension];
        if ([filePathExtension isEqualToString:kExtensionVideo]) {
            cell.iconImageView.image = [UIImage imageNamed:@"fileicon_video90"];
        }
    }else if (self.fileType == WWFileTypeAudio) {
        model = _audioFileArray[indexPath.row];
        cell.titleLabel.text = model.fileLastPathComponent;
        
        NSString *filePathExtension = [WWFileManager contrastThePathExtension:model.filePathExtension];
        
        if ([filePathExtension isEqualToString:kExtensionAudio]) {
            cell.iconImageView.image = [UIImage imageNamed:@"fileicon_music90"];
        }
    }else if (self.fileType == WWFileTypeAlbum) {
        model = _albumFileArray[indexPath.row];
        cell.titleLabel.text = model.fileLastPathComponent;
        NSString *filePathExtension = [WWFileManager contrastThePathExtension:model.filePathExtension];
        if ([filePathExtension isEqualToString:kExtensionTupian]) {
            cell.iconImageView.image = [UIImage imageNamed:model.fileAllPath];
            cell.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
            cell.iconImageView.clipsToBounds = YES;
        }
        
    }else if (self.fileType == WWFileTypeOther) {
        model = _otherFileArray[indexPath.row];
        cell.titleLabel.text = model.fileLastPathComponent;
        cell.iconImageView.image = [UIImage imageNamed:@"fileicon_unkown90"];
    }
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:CGRectZero];
    if (_fileOpenType == OpenTypeSend && model.isSelected == YES) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }if (_fileOpenType == OpenTypeSend && model.isSelected == NO) {
        cell.selected = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_fileOpenType == OpenTypeSend) {
        WWFileModel *model = nil;
        if (_fileType == WWFileTypeDocument) {
            model = _documentFileArray[indexPath.row];
        }else if (self.fileType == WWFileTypeVideo) {
            model = _videoFileArray[indexPath.row];
            
        }else if (self.fileType == WWFileTypeAudio) {
            model = _audioFileArray[indexPath.row];
            
        }else if (self.fileType == WWFileTypeAlbum) {
            model = _albumFileArray[indexPath.row];
            
        }else if (self.fileType == WWFileTypeOther) {
            model = _otherFileArray[indexPath.row];
        }
        model.isSelected = YES;
        [_selectedDataArray addObject:model];
        [self reloadSelectedviews];
    }else {
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
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
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_fileOpenType == OpenTypeSend) {
        WWFileModel *model = nil;
        if (_fileType == WWFileTypeDocument) {
            model = _documentFileArray[indexPath.row];
        }else if (self.fileType == WWFileTypeVideo) {
            model = _videoFileArray[indexPath.row];
            
        }else if (self.fileType == WWFileTypeAudio) {
            model = _audioFileArray[indexPath.row];
            
        }else if (self.fileType == WWFileTypeAlbum) {
            model = _albumFileArray[indexPath.row];
            
        }else if (self.fileType == WWFileTypeOther) {
            model = _otherFileArray[indexPath.row];
        }
        model.isSelected = NO;
        [_selectedDataArray removeObject:model];
        [self reloadSelectedviews];
    }
}

//是否可以编辑  默认的时YES
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_fileOpenType == OpenTypeSend) {
        return YES;
    }
    return NO;
}

//选择编辑的方式,按照选择的方式对表进行处理
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
    
}

//选择你要对表进行处理的方式  默认是删除方式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
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
