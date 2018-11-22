//
//  RequestModel.h
//  ACSFramework
//
//  Created by wang on 2018/2/10.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

/**
 网络请求返回类型
 
 - ACSRequestSuccess: 返回成功
 - ACSRequestServerError: 服务器错误
 - ACSRequestNetworkError: 网络错误
 - ACSRequestOtherError: 其他错误，服务器返回的错误
 */
typedef NS_ENUM(NSUInteger, ACSRequestError) {
    ACSRequestSuccess = 0,
    ACSRequestServerError = 2000,
    ACSRequestNetworkError = 2001,
    ACSRequestOtherError = 2002
};

@interface ACSRequest : NSObject

+ (AFHTTPSessionManager *)shareAFManager;


#pragma mark - GET & POST
/**
 Get
 
 @param aPath 地址
 @param params 参数
 @param block 回掉
 */
+ (NSURLSessionDataTask *)GetDataWithPath:(NSString *)aPath
                               withParams:(NSDictionary*)params
                                 andBlock:(void (^)(ACSRequestError code, id data, NSString *msg))block;
/**
 Post
 
 @param aPath 地址
 @param params 参数
 @param block 回掉
 */
+ (NSURLSessionDataTask *)PostDataWithPath:(NSString *)aPath
                                withParams:(NSDictionary*)params
                                  andBlock:(void (^)(ACSRequestError code, id data, NSString *msg))block;


/**
 Post 带发送文件

 @param aPath 地址
 @param constructingBodyBlock 发送文件Block
 @param params 参数
 @param block 回掉
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)PostDataWithPath:(NSString *)aPath
                 constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBodyBlock
                                withParams:(NSDictionary*)params
                                  andBlock:(void (^)(ACSRequestError code, id data, NSString *msg))block;

/**
 下载文件
 @param path 路径
 @param downloadProgressBlock 下载进度
 @param completionHandler 完成后的Block
 */
+ (void)downloadPath:(NSString *)path
            progress:(void (^)(CGFloat downloadProgress))downloadProgressBlock
   completionHandler:(void (^)(NSString *filePath, NSError * _Nullable error, BOOL isFromCache))completionHandler;
@end
