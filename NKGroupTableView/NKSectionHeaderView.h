//
//  NKSectionHeaderView.h
//  NKGroupTableView
//
//  Created by 刘小武 on 2017/4/28.
//  Copyright © 2017年 NorthKing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NKSectionHeaderView;

typedef void(^NKSectionBlock)(NKSectionHeaderView * view);

@interface NKSectionHeaderView : UIView

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * imageName;
@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, copy) NKSectionBlock tapBlock;
@property (nonatomic, copy) NKSectionBlock pressBlock;
@property (nonatomic, copy) NKSectionBlock confirmBlock;

- (void)close;

@end
