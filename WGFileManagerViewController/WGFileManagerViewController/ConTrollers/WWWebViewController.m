//
//  GNWebViewController.m
//  GreenNanTongGV
//
//  Created by guoyutao on 16/8/15.
//  Copyright © 2016年 guoyutao. All rights reserved.
//

#import "WWWebViewController.h"

@interface WWWebViewController ()<UIWebViewDelegate>{
    NSMutableURLRequest *_requestUrl;
    UIBarButtonItem *_backBarButtonItem;
    UIBarButtonItem *_popToBaseVcButtonItem;
    NSMutableArray *_leftNavBackButtonItemArr;
    NSMutableArray *_leftNavBackButtonItemArr2;
    UIBarButtonItem *_rightBarButtonItem;
    UIWebView *_webview;
}

@end

@implementation WWWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
        //回退按钮
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_webView_back_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
        _backBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        _leftNavBackButtonItemArr = [[NSMutableArray alloc]initWithArray:@[_backBarButtonItem]];
        
        _popToBaseVcButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_webView_pop_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(popToBaseVc)];
        _popToBaseVcButtonItem.imageInsets = UIEdgeInsetsMake(0, -20, 0, 20);
        _leftNavBackButtonItemArr2 = [[NSMutableArray alloc]initWithArray:@[_backBarButtonItem,_popToBaseVcButtonItem]];
        self.navigationItem.leftBarButtonItems = _leftNavBackButtonItemArr;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    
    //webview初始化
    _webview = [UIWebView new];
    [self.view addSubview:_webview];
    _webview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_webview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_webview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_webview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_webview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    _webview.delegate = self;
    _webview.scalesPageToFit = YES;
    _webview.backgroundColor = [UIColor whiteColor];
    
    [self _loadWebViewAtUrl];
}

- (void)leftButtonClick{
        if ([_webview canGoBack]) {
            self.navigationItem.leftBarButtonItems = _leftNavBackButtonItemArr2;
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            } 
            [_webview goBack];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
}

- (void)popToBaseVc {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)_loadWebViewAtUrl{
    if (_webview.loading) [_webview stopLoading];
    if (_urlString == nil) {
        _urlString = @"";
    }
    _urlString = [_urlString stringByReplacingOccurrencesOfString:@" " withString:@""];//cap:去除空格
    
    //_requestUrl =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    
    if ([_urlString.pathExtension caseInsensitiveCompare:@"TXT"] == NSOrderedSame) {
        NSStringEncoding *useEncoding = nil;
        NSString *urlString = [NSString stringWithContentsOfFile:_urlString encoding:useEncoding error:nil];
        
        //按gbk的方式解码；
        if (urlString) {
            urlString = [NSString stringWithContentsOfFile:_urlString encoding:0x80000632 error:nil];
        }
        if (urlString) {
            //将解码的贴到webview上
            [_webview loadHTMLString:urlString baseURL:nil];
        } else if (urlString){
            //如果gbk解码不成功，尝试utf-8解码，NSUTF8StringEncoding
            if ([[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] floatValue] >= 9.0) {
                NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
                NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
                urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
            }else {
                urlString = [urlString stringByAddingPercentEscapesUsingEncoding:0x80000632];
            }
            NSURL *requesurl = [NSURL URLWithString:urlString];
            NSURLRequest *request = [NSURLRequest requestWithURL:requesurl];
            //用第一种方式加载
            [_webview loadRequest:request];
        }else {
            NSData *txtData = [NSData dataWithContentsOfFile:_urlString];
            //自定义一个编码方式
            if (txtData) {
                [_webview loadData:txtData MIMEType:@"text/txt" textEncodingName:@"GBK" baseURL:nil];
            }
        }
        return;
    }
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:_urlString]]];
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    //[self showHudInView:self.view hint:@"加载中..."];
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}


- (void)dealloc{
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
