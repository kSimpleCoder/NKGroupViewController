
//
//  NKSectionHeaderView.m
//  NKGroupTableView
//
//  Created by 刘小武 on 2017/4/28.
//  Copyright © 2017年 NorthKing. All rights reserved.
//

#import "NKSectionHeaderView.h"

@interface NKSectionHeaderView () {
    UITextField * _titleField;
    UILabel     * _titleLabel;
    UIButton    * _confirmBtn;
}

@end

@implementation NKSectionHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        [self initGes];
    }
    return self;
}

- (void)initUI {
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"arrow_down"];
    UITextField * titleField = [[UITextField alloc] init];
    titleField.font = [UIFont systemFontOfSize:15.f];
    titleField.borderStyle = UITextBorderStyleRoundedRect;
    titleField.hidden = YES;
    UILabel     * titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15.f];
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.backgroundColor = [UIColor orangeColor];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.hidden = YES;
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    _imageView  = imageView;
    _titleField = titleField;
    _titleLabel = titleLabel;
    _confirmBtn = confirmBtn;
    
    [self addSubview:imageView];
    [self addSubview:titleField];
    [self addSubview:titleLabel];
    [self addSubview:confirmBtn];

}

- (void)initGes {
    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tapGes];
    
    UILongPressGestureRecognizer * pressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressAction)];
    [self addGestureRecognizer:pressGes];
}

- (void)tapAction {
    if (self.tapBlock) {
        self.tapBlock(self);
    }
}

- (void)pressAction {
    _titleField.hidden = NO;
    _confirmBtn.hidden = NO;
    _titleLabel.hidden = YES;
    
    if (self.pressBlock) {
        self.pressBlock(self);
    }
}

- (void)confirmAction {
    _titleField.hidden = YES;
    _confirmBtn.hidden = YES;
    _titleLabel.hidden = NO;
    _titleLabel.text = _titleField.text;
    [_titleField resignFirstResponder];
    if (self.confirmBlock) {
        self.confirmBlock(self);
    }
}

- (void)close {
    [self confirmAction];
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
    _titleField.text = title;
}

- (void)setImageName:(NSString *)imageName {
    _imageView.image = [UIImage imageNamed:imageName];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /*
     
     |    _____20_____     ____X___     ____60_____     |
     | 20 | imageview | 10 | title | 20 | confirm | 20  |
     |    -------------    --------     -----------     |
     
     */
    
    CGFloat imageWH = 20;
    CGFloat imageY = (self.frame.size.height - imageWH) * 0.5;
    _imageView.frame = CGRectMake(10, imageY, imageWH, imageWH);
    
    CGFloat titleX = CGRectGetMaxX(_imageView.frame) + 20;
    CGFloat titleW = self.frame.size.width - 150;
    CGFloat titleH = 30;
    CGFloat titleY = (self.frame.size.height - titleH) * 0.5;
    _titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    _titleField.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat confirmX = self.frame.size.width - 80;
    CGFloat confirmY = titleY;
    CGFloat confirmW = 60;
    CGFloat confirmH = titleH;
    _confirmBtn.frame = CGRectMake(confirmX, confirmY, confirmW, confirmH);
    
}

- (NSString *)title {
    return _titleLabel.text;
}

@end
