//
//  RequestModel.m
//  ACSFramework
//
//  Created by wang on 2018/2/10.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "ACSRequest.h"


static AFHTTPSessionManager *_afManager;

@implementation ACSRequest


+ (AFHTTPSessionManager *)shareAFManager {
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
+ (NSURLSessionDataTask *)GetDataWithPath:(NSString *)aPath
                               withParams:(NSDictionary*)params
                                 andBlock:(void (^)(ACSRequestError code, id data, NSString *msg))block {
    
    NSURLSessionDataTask *getDataTask = [[self shareAFManager] GET:aPath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
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

+ (NSURLSessionDataTask *)PostDataWithPath:(NSString *)aPath
                                withParams:(NSDictionary*)params
                                  andBlock:(void (^)(ACSRequestError code, id data, NSString *msg))block {
    
    NSURLSessionDataTask *postDataTask = [[self shareAFManager] POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

+ (NSURLSessionDataTask *)PostDataWithPath:(NSString *)aPath
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBodyBlock
                                withParams:(NSDictionary*)params
                                  andBlock:(void (^)(ACSRequestError code, id data, NSString *msg))block {
    NSURLSessionDataTask *postDataTask = [[self shareAFManager] POST:aPath parameters:params constructingBodyWithBlock:constructingBodyBlock progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
+ (void)downloadPath:(NSString *)path
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
        NSURLSessionDownloadTask *downloadSrtTask = [[self shareAFManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
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
