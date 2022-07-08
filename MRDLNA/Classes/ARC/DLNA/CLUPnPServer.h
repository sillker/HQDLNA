//
//  CLUPnPServer.h
//  DLNA_UPnP
//
//  Created by ClaudeLi on 2017/7/31.
//  Copyright © 2017年 ClaudeLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLUPnPServer;
@class CLUPnPDevice;

@protocol CLUPnPServerDelegate <NSObject>
@required

/// 搜索结果
/// @param devices 设备数组
- (void)upnpSearchChangeWithResults:(NSArray <CLUPnPDevice *>*)devices;

@optional

/// 搜索失败
- (void)upnpSearchErrorWithError:(NSError *)error;

///搜索结束
- (void)upnpDidEndSearch;

@end

@interface CLUPnPServer : NSObject

@property (nonatomic, weak) id<CLUPnPServerDelegate>delegate;

@property (nonatomic,assign) NSInteger searchTime;

+ (instancetype)shareServer;

/// 启动Server并搜索
- (void)start;

/// 停止
- (void)stop;


- (void)refresh;

/// 搜索
- (void)search;

/// 获取已经发现的设备
/// return Device Array
- (NSArray<CLUPnPDevice *> *)getDeviceList;

@end
