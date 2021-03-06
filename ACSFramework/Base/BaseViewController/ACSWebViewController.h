//
//  BaseWebViewController.h
//  Simon
//
//  Created by Simon on 2018/1/26.
//  Copyright © 2018年 Simon. All rights reserved.
//

#import "ACSBaseViewController.h"
#import <WebKit/WebKit.h>

@interface ACSWebViewController : ACSBaseViewController

@property (nonatomic, strong) WKWebView *webView;

/** 进入条颜色 默认：#0485d1 */
@property (nonatomic, copy) UIColor *progressViewColor;

/** 传入网址 */
@property (nonatomic, copy) NSString *url;

/** 是否适应屏幕比例缩放 */
@property (nonatomic, assign) BOOL isChangeScale;

/** 加载前是否清除网页缓存 */
@property (nonatomic, assign) BOOL cleanBool;


@end

