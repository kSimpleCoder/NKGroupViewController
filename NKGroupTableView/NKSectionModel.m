//
//  NKSectionModel.m
//  NKGroupTableView
//
//  Created by 刘小武 on 2017/4/28.
//  Copyright © 2017年 NorthKing. All rights reserved.
//

#import "NKSectionModel.h"

@implementation NKSectionModel

+(instancetype)sectionModelWithState:(BOOL)state title:(NSString *)title array:(NSArray *)array {
    NKSectionModel * model = [[NKSectionModel alloc] init];
    model.isOpen = state;
    model.title = title;
    model.sectionArray = array;
    return model;
}

@end
