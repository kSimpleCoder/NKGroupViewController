//
//  NKSectionModel.h
//  NKGroupTableView
//
//  Created by 刘小武 on 2017/4/28.
//  Copyright © 2017年 NorthKing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKSectionModel : NSObject

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSArray * sectionArray;

+ (instancetype)sectionModelWithState:(BOOL)state title:(NSString *)title array:(NSArray *)array;

@end
