
//
//  NKGroupViewController.m
//  NKGroupTableView
//
//  Created by 刘小武 on 2017/4/28.
//  Copyright © 2017年 NorthKing. All rights reserved.
//

#import "NKGroupViewController.h"
#import "NKSectionHeaderView.h"
#import "NKSectionModel.h"

@interface NKGroupViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic, strong) NKSectionHeaderView * previousHeader;


@end

@implementation NKGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _isFirstAppear = YES;
}

- (void)initData {
    self.data = @[
                  [NKSectionModel sectionModelWithState:NO title:@"软件一部" array:@[@"张三",@"李四",@"王五"]],
                  [NKSectionModel sectionModelWithState:NO title:@"软件二部" array:@[@"张三",@"李四",@"王五"]],
                  [NKSectionModel sectionModelWithState:NO title:@"软件三部" array:@[@"张三",@"李四",@"王五"]],
                  [NKSectionModel sectionModelWithState:NO title:@"软件四部" array:@[@"张三",@"李四",@"王五"]]
                  ].mutableCopy;
}

- (void)initUI {
    self.title = @"NKGroupViewController";
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    _tableView = tableView;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NKSectionModel * model = self.data[section];
    if (model.isOpen == YES) {
        return model.sectionArray.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"UITableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NKSectionModel * model = self.data[indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    cell.textLabel.text = model.sectionArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NKSectionModel * model = self.data[section];
    NKSectionHeaderView * headerView = [[NKSectionHeaderView alloc] init];
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    headerView.title = model.title;
    __weak typeof(self) weakSelf = self;
    headerView.tapBlock = ^(NKSectionHeaderView * view) {
        model.isOpen = !model.isOpen;
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    headerView.confirmBlock = ^(NKSectionHeaderView * view) {
        model.title = view.title;
    };
    headerView.pressBlock = ^(NKSectionHeaderView * view) {
        if (_previousHeader != view) {
            [_previousHeader close];
        }
        _previousHeader = view;
    };
    if (_isFirstAppear == NO) {
        if (model.isOpen == YES) {
            headerView.imageView.image = [UIImage imageNamed:@"arrow_up"];
            CABasicAnimation * rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotationAnim.fromValue = @(0);
            rotationAnim.toValue   = @(M_PI_2);
            rotationAnim.duration = 0.2f;
            rotationAnim.fillMode = kCAFillModeForwards;
            rotationAnim.removedOnCompletion = YES;
            [headerView.imageView.layer addAnimation:rotationAnim forKey:@"up_to_down"];
        } else {
            headerView.imageView.image = [UIImage imageNamed:@"arrow_down"];
            CABasicAnimation * rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotationAnim.fromValue = @(M_PI_2);
            rotationAnim.toValue   = @(M_PI);
            rotationAnim.duration = 0.2f;
            rotationAnim.fillMode = kCAFillModeForwards;
            rotationAnim.removedOnCompletion = YES;
            [headerView.imageView.layer addAnimation:rotationAnim forKey:@"down_to_up"];
        }
    }
    _isFirstAppear = NO;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
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
