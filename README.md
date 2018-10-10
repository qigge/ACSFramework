# ZQFramework
[iOS Framework](https://github.com/qigge/ACSFramework)

https://github.com/qigge/ACSFramework

iOS 基本框架，对AppDelegate拓展；对UIView进行拓展（ACSUIKit），添加一些常用的工具（ACSTool），添加了一些常用的第三方库，并且使用pods管理；

ACSUIKit支持pod导入
1. 导入整个ACSUIKit
```
pod 'ACSFramework/UIKit'
```
2. 分功能导入，如导入键盘遮挡(UIViewController+ACSKeyboardCorver.h)
```
pod 'ACSFramework/ACSKeyboardCorver'
```


# AppDelegate 拓展

## 推送(AppDelegate+ACSAPNS.h)

```
/** 注册推送（第三方等） */
- (void)acs_registerAPNSWithApplication:(UIApplication *)application;
```

## 网络监控(AppDelegate+ACSNetWorkReachability.h)
```
/** 监听网络变化 */
- (void)acs_startNetWorkReachability;
```
```
/** 获取网络状态 */
AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
AFNetworkReachabilityStatus networkStatus = appDelegate.networktype;
```

## 友盟(AppDelegate+ACSUmeng.h)
```
/** 注册友盟 */
- (void)acs_registerUmeng;
```


# 基础控制器

## 基础ViewController(ACSBaseViewController.h)
友盟页面统计
```
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}
```
是否隐藏导航栏
```
/** 是否隐藏导航栏,默认情况是NO */
```
自定义返回
```
/** 自定义返回 */
- (void)popToBack;
```
@property (nonatomic, assign) BOOL isHidenNaviBar;
## 基础UITabBarController(ACSTabBarController.h)

## 基础UITableViewController(ACSTableViewController.h)
```
/** TableView的样式 */
@property (nonatomic, assign) UITableViewStyle tableStyle;

/** 下拉刷新开关 */
- (BOOL)shouldHeaderRefresh;

/** 上拉加载开关 */
- (BOOL)shouldFooterRefresh;

/** 下拉刷新执行的方法 */
- (void)handlePullRefresh;

/** 上拉加载执行的方法 */
- (void)handleInfiniteScrolling;

/** 关闭头部刷新 */
- (void)endHeadRefresh;

/** 关闭尾部刷新 */
- (void)endFootRefresh;
```
## 基础网页浏览器(ACSWebViewController.h)
```
/** 传入网址 */
@property (nonatomic, copy) NSString *url;
```
## 基础UINavigationController(ACSNavigationController.h)

公共方法
```
/** 导航栏背景透明度设置 */
- (void)acs_navigationBackgroundTranslucent:(BOOL)translucent;
```
> 以上基础控制器都重写了屏幕旋转方法，若需要屏幕旋转，继承以上控制器，然后重新以下方法即可
```
//是否自动旋转,返回YES可以自动旋转
- (BOOL)shouldAutorotate;
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations;
//这个是返回优先方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation ;
```

## 

# ACSUIKit

## 字体大小自适应(UIFont+ACSFontToFit.h)
添加到工程即可，适用于纯代码UIFont，以及XIB和SB中（UIButton、UILabel、UITextView、UITextField）的字号适配

## 十六进制颜色(UIColor+ACSHexColor.h)
```
/**
 根据十六进制色值返回颜色
 @param stringToConvert 十六进制色值
 @return 系统颜色
 */
+ (UIColor *)acs_hexStringToColor:(NSString *)stringToConvert;

/**
 根据十六进制色值和透明度返回颜色
 @param stringToConvert 十六进制色值
 @param alpha 透明度
 @return 系统颜色
 */
+ (UIColor *)acs_hexStringToColor:(NSString *)stringToConvert alpha:(CGFloat)alpha;
```

## 设置按钮图片位置(UIButton+ACSImagePosition.h)
```
/**
 设置button 图片位置
 @param type 位置
 @param edg  偏移
 */
- (void)positionWith:(ACSUIButtonImagePosition)type edg:(CGFloat)edg;
```
## 空白页展示(UIScrollView+ACSEmpty.h)
```
/** 空视图（tableview，colloctionview 为空时，显示此视图） */
@property (nonatomic, strong) UIView *acs_emptyView;
```
## 圆角、阴影、边框(UIView+ACSLayer.h)
```
/**
 圆角
 使用自动布局，需要在layoutsubviews 中使用
 @param radius 圆角尺寸
 @param corner 圆角位置
 */
- (void)acs_radiusWithRadius:(CGFloat)radius corner:(UIRectCorner)corner;
/**
 阴影
 @param color  颜色
 @param radius 尺寸
 @param offset 便宜位置
 */
- (void)acs_shadowWithColor:(UIColor *)color radius:(CGFloat)radius offset:(CGSize)offset;
/**
 添加边框
 @param color  颜色
 @param borderWidth 宽度
 @param borderType 边框位置
 */
- (void)acs_borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(ACSBorderSideType)borderType;
```
## Frame(UIView+ACSSize.h)
```
@property (nonatomic, assign) CGFloat acs_x;
@property (nonatomic, assign) CGFloat acs_y;
@property (nonatomic, assign) CGFloat acs_centerX;
@property (nonatomic, assign) CGFloat acs_centerY;

@property (nonatomic, assign) CGFloat acs_left;
@property (nonatomic, assign) CGFloat acs_top;
@property (nonatomic, assign) CGFloat acs_right;
@property (nonatomic, assign) CGFloat acs_bottom;

@property (nonatomic, assign) CGFloat acs_width;
@property (nonatomic, assign) CGFloat acs_height;
@property (nonatomic, assign) CGPoint acs_origin;
@property (nonatomic, assign) CGSize  acs_size;

- (void)acs_topAdd:(CGFloat)add;
- (void)acs_leftAdd:(CGFloat)add;
- (void)acs_widthAdd:(CGFloat)add;
- (void)acs_heightAdd:(CGFloat)add;

/**
 判断View是否显示在屏幕上
 
 @return YES/NO
 */
- (BOOL)acs_isDisplayedInScreen;

/**
 水平居中
 */
- (void)acs_alignHorizontal;

/**
 水平居中
 */
- (void)acs_alignVertical;
```

## 键盘遮挡(UIViewController+ACSKeyboardCorver.h)
```
/**
 添加键盘通知
 */
- (void)acs_addKeyboardCorverNotification;

/**
 清理通知和移除手势 在控制器的dealloc中记得要释放
 */
- (void)acs_clearNotificationAndGesture;
```

## 具有内边距的UILabel(ACSPaddingLabel.h)
```
/** 设置内边距 */
@property (assign, nonatomic) UIEdgeInsets edgeInsets;
```

## 具有内边距的UITextField(ACSPaddingTextField.h)
```
/** 设置内边距 */
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

/** 最长字符 */
@property (nonatomic, assign) NSInteger maxLenght;

/** 超过长度回掉 */
@property (nonatomic, copy) void(^maxBlock)(void);
```

## 具有占位文字的UITextView(ACSPlaceholderTextView.h)
```
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;

/** 占位文字颜色 默认 lightGrayColor */
@property (nonatomic, strong) UIColor *placeholderColor;

/** 输入最长字符 */
@property (nonatomic, assign) NSInteger maxLenght;

/** 输入超过长度回调 */
@property (nonatomic, copy) void(^maxBlock)(void);
```

## 选项卡View(ACSTapsView.h)
```
- (instancetype)initWithFrame:(CGRect)frame tapArr:(NSArray<NSString *> *)arr;

/** 标题数组 （设置这个重新更新标题）*/
@property (nonatomic, strong)  NSArray<NSString *> *dataArr;

/** 选中的序号 (0开始 ） */
@property (nonatomic, assign) NSInteger index;
/** 默认颜色 */
@property (nonatomic, strong) UIColor *defaultColor;
/** 选中的颜色（默认red） */
@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, weak) id<ACSTapsViewDelegate> delegate;
```


# ACSTool 
## 用字符串和字体计算size(NSString+ACSSize.h)
```
/**
 固定高度，根据内容计算UILabel的宽度
 @param aHeight 高度
 @param aFont 字体大小
 @return 宽度
 */
- (CGFloat)acs_getWidthWithFixedHeight:(CGFloat)aHeight font:(UIFont *)aFont;
/**
 固定宽度，根据内容计算UILabel的高度
 @param aWidth 高度
 @param aFont 字体大小
 @return 高度
 */
- (CGFloat)acs_getHeightWithFixedWidth:(CGFloat)aWidth font:(UIFont *)aFont;
```

## 时间转换(TimeTool.h)
```
/**
 时间戳转时间
 @param timeStamp 时间戳 字符串类型
 @param formatterStr 时间格式 默认 yyyy-MM-dd HH:mm:ss
 @return 返回格式化的时间
 */
+ (NSString *)timeStampIntervalToStringWithTimeStamp:(NSTimeInterval)timeStamp formatter:(NSString *)formatterStr;
/**
 时间戳转时间
 @param timeStamp 时间戳 字符串类型
 @param formatterStr 时间格式 默认 yyyy-MM-dd HH:mm:ss
 @return 返回格式化的时间
 */
+ (NSString *)timeStampStringToStringWithTimeStamp:(NSString *)timeStamp formatter:(NSString *)formatterStr ;

/**
 获取当前时间字符串
 @param formatterStr 时间格式 默认 yyyy-MM-dd HH:mm:ss
 @return 格式化的时间字符串
 */
+ (NSString *)currentDateWithFormatter:(NSString *)formatterStr;

/**
 获取当前时间戳
 @return 格式化的时间字符串
 */
+ (NSTimeInterval)currentTimeStamp;
```

## 设备信息(DeviceTool.h)
```
/**
 获取IP地址
 */
+(NSString *)getIPAddress;

/**
 获取手机型号
 */
+ (NSString *)getCurrentDeviceModel;

/**
 设备唯一标识符
 */
+ (NSString *)getIdentifierUUID;

/**
 设备名称
 */
+ (NSString *)getSystemName;

/**
 手机别名： 用户定义的名称
 */
+ (NSString *)getSystemUserName;

/**
 手机系统版本
 */
+ (NSString *)getSystemVersion;

/**
 地方型号  （国际化区域名称）
 */
+ (NSString *)getlocalizedModel;

/**
 当前应用软件版本  比如：1.0.1
 */
+ (NSString *)getAppCurVersion;

/**
 当前应用版本号码   int类型
 */
+ (NSString *)getAppCurVersionNum;
```

## 加密(EncryptionTool.h)
```
/**
 32位 md5加密
 */
+ (NSString *)getMD5_32BIT_String:(NSString *)srcStirng;

/**
 40位 sha1加密
 */
+ (NSString *)getSHA1_40BIT_String:(NSString *)srcString;

/**
 DES加密
 */
+ (NSString*)encryptWithContent:(NSString*)content type:(CCOperation)type key:(NSString*)aKey;
```

## Base64(GTMBase64.h)
```
+ (NSString*)md5_base64: (NSString *) inPutText;
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;
```

# Pods
```
target 'ACSFramework' do
    platform :ios, '8.0'

    pod 'AFNetworking'
    pod 'SDWebImage'
    pod 'SVProgressHUD'
    pod 'MJExtension'
    pod 'MJRefresh'
    pod 'Masonry'
    pod 'ReactiveObjC'
    
    # 友盟
    pod 'UMCCommon'
    pod 'UMCAnalytics' # 友盟分析
    pod 'UMCSecurityPlugins' # 为安全组件，不需要开发者显式调用，为开发者提供安全的数据环境，能有效的防止刷量和反作弊等行为，属于可选项，如果对App的数据安全性要求不高的话，可以去掉此pod。
end
```
