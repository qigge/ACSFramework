//
//  RequestModel.m
//  ACSFramework
//
//  Created by wang on 2018/2/10.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "RequestModel.h"


static AFHTTPSessionManager *_afManager;

@implementation RequestModel


+ (AFHTTPSessionManager *)shareInstanceAFManager {
    RequestModel *baseModel = [[RequestModel alloc] init];
    return baseModel.afManager;
}

- (AFHTTPSessionManager *)afManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _afManager = [AFHTTPSessionManager manager];
        _afManager.requestSerializer.timeoutInterval = 15;
        _afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",nil];

        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [securityPolicy setAllowInvalidCertificates:YES];
        [securityPolicy setValidatesDomainName:NO];
        _afManager.securityPolicy = securityPolicy;
    });
    return _afManager;
}

#pragma mark - GET & POST
- (RACSignal *)getWithUrl:(NSString *)url parameters:(NSDictionary *)param {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSURLSessionDataTask *getDataTask = [[RequestModel shareInstanceAFManager] GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"Get -- :%@",@{@"url":url,@"param":param?param:@"",@"res":responseObject?responseObject:@"NULL"});
            [self requestSuccessWithResponse:responseObject subscriber:subscriber];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self requestFailWithsubscriber:subscriber];
            NSLog(@"Get Error-- :%@",@{@"url":url,@"param":param?param:@"",@"error":error});
        }];
        return [RACDisposable disposableWithBlock:^{
            [getDataTask cancel];
        }];
    }];
    return signal;
}

- (RACSignal *)postWithUrl:(NSString *)url parameters:(NSDictionary *)param {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSURLSessionDataTask *postDataTask = [[RequestModel shareInstanceAFManager] POST:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"Post -- :%@",@{@"url":url,@"param":param?param:@"",@"res":responseObject?responseObject:@"NULL"});
            [self requestSuccessWithResponse:responseObject subscriber:subscriber];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self requestFailWithsubscriber:subscriber];
            NSLog(@"Post Error-- :%@",@{@"url":url,@"param":param?param:@"",@"error":error});
        }];
        return [RACDisposable disposableWithBlock:^{
            [postDataTask cancel];
        }];
    }];
    return signal;
}

- (RACSignal *)postWithUrl:(NSString *)url parameters:(NSDictionary *)param constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSURLSessionDataTask *postDataTask = [self.afManager POST:url parameters:param constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"Post -- :%@",@{@"url":url,@"param":param?param:@"",@"res":responseObject?responseObject:@"NULL"});
            [self requestSuccessWithResponse:responseObject subscriber:subscriber];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self requestFailWithsubscriber:subscriber];
            NSLog(@"Post Error-- :%@",@{@"url":url,@"param":param?param:@"",@"error":error});
        }];
        return [RACDisposable disposableWithBlock:^{
            [postDataTask cancel];
        }];
    }];
    return signal;
}

- (void)requestSuccessWithResponse:(id)responseObject subscriber:(id<RACSubscriber>  _Nonnull)subscriber {
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = responseObject;
        NSInteger code = [dic[@"code"] integerValue];
        if (code == ACSRequestSuccess) {
            [subscriber sendNext:dic[@"data"]];
            [subscriber sendCompleted];
        }else {
            [subscriber sendError:[NSError errorWithDomain:HostName code:ACSRequestOtherError userInfo:@{@"msg":dic[@"msg"]}]];
        }
    }else {
        [subscriber sendError:[NSError errorWithDomain:HostName code:ACSRequestServerError userInfo:@{@"msg":@"Server Crash"}]];
    }
}
- (void)requestFailWithsubscriber:(id<RACSubscriber>  _Nonnull)subscriber {
    [subscriber sendError:[NSError errorWithDomain:HostName code:ACSRequestNetworkError userInfo:@{@"msg":@"Please check your network"}]];
}

#pragma mark - GET & POST
- (NSURLSessionDataTask *)GetDataWithPath:(NSString *)aPath
                               withParams:(NSDictionary*)params
                                 andBlock:(void (^)(ACSRequestError code, id data, NSString *msg))block {
    
    NSURLSessionDataTask *getDataTask = [self.afManager GET:aPath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responseObject;
            NSInteger code = [dic[@"code"] integerValue];
            block(code, dic[@"data"],dic[@"msg"]);
        }else {
            block(ACSRequestServerError, nil, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(ACSRequestNetworkError, nil, nil);
    }];
    return getDataTask;
}

- (NSURLSessionDataTask *)PostDataWithPath:(NSString *)aPath
                                withParams:(NSDictionary*)params
                                  andBlock:(void (^)(ACSRequestError code, id data, NSString *msg))block {
    
    NSURLSessionDataTask *postDataTask = [self.afManager POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responseObject;
            NSInteger code = [dic[@"code"] integerValue];
            block(code, dic[@"data"],dic[@"msg"]);
        }else {
            block(ACSRequestServerError, nil, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(ACSRequestNetworkError, nil, error.localizedFailureReason);
    }];
    return postDataTask;
}


#pragma mark - Download
- (void)downloadPath:(NSString *)path
            progress:(void (^)(CGFloat downloadProgress))downloadProgressBlock
   completionHandler:(void (^)(NSString *filePath, NSError * _Nullable error, BOOL isFromCache))completionHandler {
    if (!path || path.length == 0) {
        if (completionHandler) {
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:1000 userInfo:@{@"msg":@"空路径"}];
            completionHandler(@"", error,NO);
        }
    }
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    rootPath = [rootPath stringByAppendingPathComponent:@"Downloads"];
    
    NSURL *remoteUrl = [NSURL URLWithString:path];
    // 文件路径
    NSString *localFullPath = [rootPath stringByAppendingPathComponent:remoteUrl.host];
    localFullPath = [localFullPath stringByAppendingPathComponent:remoteUrl.path];
    // 文件夹路径
    NSString *localDirectory = [localFullPath stringByReplacingOccurrencesOfString:remoteUrl.lastPathComponent withString:@""];
    // 判断文件夹是否存在
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    if (![fm fileExistsAtPath:localDirectory isDirectory:&isDir]) {
        [fm createDirectoryAtPath:localDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    // 判断文件是否存在
    if ([fm fileExistsAtPath:localFullPath]) {
        if (downloadProgressBlock) {
            downloadProgressBlock(1.0);
        }
        if (completionHandler) {
            completionHandler(localFullPath, nil,YES);
        }
    }else {
        // 下载文件
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:path parameters:nil error:nil];
        NSURLSessionDownloadTask *downloadSrtTask = [self.afManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            if (downloadProgressBlock) {
                downloadProgressBlock(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            }
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return [NSURL fileURLWithPath:localFullPath];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            if (completionHandler) {
                completionHandler(localFullPath, error, NO);
            }
        }];
        [downloadSrtTask resume];
    }
}





@end
