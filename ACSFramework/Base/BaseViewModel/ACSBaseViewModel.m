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
    [[ACSRequest shareInstance] GetDataWithPath:@"http://www.baidu.com" withParams:@{} andBlock:^(ACSRequestError code, id data, NSString *msg) {
        
    }];
}


@end
