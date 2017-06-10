//
//  WGSelectedItemView.m
//  WGFileManagerViewController
//
//  Created by guoyutao on 2017/5/31.
//  Copyright © 2017年 guoyutao. All rights reserved.
//

#import "WGSelectedItemView.h"

#define theLineSpaceing 3

@interface WGSelectedItemView()

@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) NSArray *titleArray;
@property (nonatomic ,strong) UIButton *selectedButton;

@end

@implementation WGSelectedItemView

- (id)initWithFrame:(CGRect)frame itmeTiteArray:(NSArray *)titleArray selectedColor:(UIColor *)selectedColor normalColor:(UIColor *)normalColor{
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < titleArray.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            button.frame = CGRectMake(frame.size.width/titleArray.count * i, 0, frame.size.width/titleArray.count, frame.size.height - theLineSpaceing);
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:selectedColor forState:UIControlStateSelected];
            [button setTitleColor:normalColor forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
            [self addSubview:button];
            if (i == 0) {
                _selectedButton = button;
                _selectedButton.selected = YES;
            }
        }
        
        _titleArray = titleArray;
        UIView *lineBottonmView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - theLineSpaceing, frame.size.width, theLineSpaceing)];
        [self addSubview:lineBottonmView];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/titleArray.count, theLineSpaceing)];
        [lineBottonmView addSubview:_lineView];
        _lineView.backgroundColor = selectedColor;
        
        UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, theLineSpaceing - 0.5, frame.size.width, 0.5)];
        bottomLineView.backgroundColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1];
        [lineBottonmView addSubview:bottomLineView];
    }
    return self;
}

- (void)itemButtonClick:(UIButton *)btn {
    _selectedButton.selected = NO;
    _selectedButton = btn;
    _selectedButton.selected = YES;
    _lineView.frame = CGRectMake(self.frame.size.width/_titleArray.count * btn.tag, 0,self.frame.size.width/_titleArray.count, theLineSpaceing);
    [self.delegate itemSelectChanged:_selectedButton.tag];
    
}

@end
