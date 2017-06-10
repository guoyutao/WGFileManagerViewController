//
//  WGSelectedItemView.h
//  WGFileManagerViewController
//
//  Created by guoyutao on 2017/5/31.
//  Copyright © 2017年 guoyutao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WGSelectedItemViewDelegate <NSObject>

- (void)itemSelectChanged:(NSInteger)itemTag;

@end

@interface WGSelectedItemView : UIView

@property (nonatomic,assign) id <WGSelectedItemViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame itmeTiteArray:(NSArray *)titleArray selectedColor:(UIColor *)selectedColor normalColor:(UIColor *)normalColor;
@end
