//
//  dlnaTestVC.m
//  YSTThirdSDK_Example
//
//  Created by MccRee on 2018/2/9.
//  Copyright © 2018年 MQL9011. All rights reserved.
//

#import "DLNASearchVC.h"
#import "DLNAControlVC.h"
#import "MRDLNA.h"


//屏幕高度
#define H [UIScreen mainScreen].bounds.size.height
#define W [UIScreen mainScreen].bounds.size.width

@interface DLNASearchVC ()<UITableViewDelegate, UITableViewDataSource, DLNADelegate>

@property(nonatomic,strong) MRDLNA *dlnaManager;

@property(nonatomic,strong) UITableView *dlnaTable;

@property(nonatomic,strong) NSArray *deviceArr;

@end

@implementation DLNASearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dlnaTable.frame = CGRectMake(0, 80, W, 300);
    [self.view addSubview:self.dlnaTable];
    self.dlnaManager = [MRDLNA sharedMRDLNAManager];
    self.dlnaManager.delegate = self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dlnaManager startSearch];
}

- (void)searchDLNAResult:(NSArray *)devicesArray{
    NSLog(@"发现设备");
    self.deviceArr = devicesArray;
    [self.dlnaTable reloadData];
}

- (void)dlnaStartPlay{
    NSLog(@"投屏成功 开始播放");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.deviceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseID = [NSString stringWithFormat:@"cell%lu%lu",(long)indexPath.row,(long)indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
    }
    CLUPnPDevice *device = self.deviceArr[indexPath.row];
    cell.textLabel.text = device.friendlyName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //测试视频如果太短，快进时会直接结束，建议找长一点的视频测试
    NSString *testUrl = @"http://oss-hqwx-video.hqwx.com/82d30125f52d122c021fb8a6c67a6b2baf33498913671858999346691m3u81280.m3u8";
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.deviceArr.count) {
        CLUPnPDevice *model = self.deviceArr[indexPath.row];
        self.dlnaManager.device = model;
        self.dlnaManager.playUrl = testUrl;
        DLNAControlVC *controlVC = [[DLNAControlVC alloc] init];
        controlVC.model = model;
        [self.navigationController pushViewController:controlVC animated:YES];
    }
}


- (UITableView *)dlnaTable{
    if (!_dlnaTable) {
        _dlnaTable = [[UITableView alloc]init];
        _dlnaTable.dataSource = self;
        _dlnaTable.delegate = self;
    }
    return _dlnaTable;
}
@end
