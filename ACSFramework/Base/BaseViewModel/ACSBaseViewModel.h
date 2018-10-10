//
//  ACSBaseViewModel.h
//  ACSFramework
//
//  Created by wang on 2018/6/21.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RequestModel.h"

@interface ACSBaseViewModel : NSObject

/**
 网络请求模型
 */
@property (nonatomic, strong) RequestModel *requestModel;


@end
