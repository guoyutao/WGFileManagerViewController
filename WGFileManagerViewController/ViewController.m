//
//  ViewController.m
//  WGFileManagerViewController
//
//  Created by guoyutao on 2017/5/31.
//  Copyright © 2017年 guoyutao. All rights reserved.
//

#import "ViewController.h"
#import "WGFileManagerViewController.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)lookFiles:(id)sender {
    
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
    NSString *str20 = [[NSBundle mainBundle] pathForResource:@"resorces/rmvb视频" ofType:@"rmvb"];
    NSString *str21 = [[NSBundle mainBundle] pathForResource:@"resorces/MPEG视频" ofType:@"mpeg"];
    NSString *str22 = [[NSBundle mainBundle] pathForResource:@"resorces/WMV视频" ofType:@"wmv"];
    NSString *str23 = [[NSBundle mainBundle] pathForResource:@"resorces/ASF视频" ofType:@"asf"];
    NSString *str24 = [[NSBundle mainBundle] pathForResource:@"resorces/xml文件" ofType:@"xml"];
    NSString *str25 = [[NSBundle mainBundle] pathForResource:@"resorces/RM视频" ofType:@"rm"];
    
    
    NSMutableArray *resorceArray = [[NSMutableArray alloc]initWithObjects:str,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15,str16,str17,str18,str19,str20,str21,str22,str23,str24,str25, nil];
    WGFileManagerViewController *maVc = [[WGFileManagerViewController alloc] initWithOpenType:OpenTypeLook dataArray:resorceArray];
    maVc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:maVc animated:YES];
}

- (IBAction)sendFiles:(id)sender {
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
    NSString *str20 = [[NSBundle mainBundle] pathForResource:@"resorces/rmvb视频" ofType:@"rmvb"];
    NSString *str21 = [[NSBundle mainBundle] pathForResource:@"resorces/MPEG视频" ofType:@"mpeg"];
    NSString *str22 = [[NSBundle mainBundle] pathForResource:@"resorces/WMV视频" ofType:@"wmv"];
    NSString *str23 = [[NSBundle mainBundle] pathForResource:@"resorces/ASF视频" ofType:@"asf"];
    NSString *str24 = [[NSBundle mainBundle] pathForResource:@"resorces/xml文件" ofType:@"xml"];
    NSString *str25 = [[NSBundle mainBundle] pathForResource:@"resorces/RM视频" ofType:@"rm"];
    
    
    NSMutableArray *resorceArray = [[NSMutableArray alloc]initWithObjects:str,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15,str16,str17,str18,str19,str20,str21,str22,str23,str24,str25, nil];
    WGFileManagerViewController *maVc = [[WGFileManagerViewController alloc] initWithOpenType:OpenTypeSend dataArray:resorceArray];
    maVc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:maVc animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
