//
//  ACSBaseViewModel.m
//  ACSFramework
//
//  Created by wang on 2018/6/21.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "ACSBaseViewModel.h"

@implementation ACSBaseViewModel

- (void)getData{
    // 网络请求示例
    RACSignal *signal = [self.requestModel getWithUrl:@"http://www.baidu.com" parameters:nil];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [signal subscribeError:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Getter & Setter
- (RequestModel *)requestModel {
    if (!_requestModel) {
        _requestModel = [[RequestModel alloc] init];
    }
    return _requestModel;
}

@end
