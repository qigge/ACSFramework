//
//  UIFont+ACSFontToFit.m
//  ACSFramework
//
//  Created by wang on 2018/5/31.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "UIFont+ACSFontToFit.h"

#import <objc/runtime.h>

#define MyUIScreenWidth  375

@implementation UIFont (ACSFontToFit)

+ (void)load {
    // 获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    // 获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    // 然后交换类方法，交换两个方法的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(newMethod, method);
}

+ (UIFont *)adjustFont:(CGFloat)fontSize {
    UIFont *newFont = nil;
    newFont = [UIFont adjustFont:fontSize * [UIScreen mainScreen].bounds.size.width/MyUIScreenWidth];
    return newFont;
}

@end

@implementation UILabel (ACSFontToFit)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的把tag值设置成333跳过
        if(self.tag !=333){
            CGFloat fontSize =self.font.pointSize;
            self.font = [UIFont systemFontOfSize:fontSize];
        }
    }
    return self;
}

@end

@implementation UIButton (ACSFontToFit)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的把tag值设置成333跳过
        if(self.titleLabel.tag !=333){
            CGFloat fontSize =self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        }
    }
    return self;
}

@end

@implementation UITextField (ACSFontToFit)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的把tag值设置成333跳过
        if(self.tag !=333){
            CGFloat fontSize =self.font.pointSize;
            self.font = [UIFont systemFontOfSize:fontSize];
        }
    }
    return self;
}

@end

@implementation UITextView (ACSFontToFit)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的把tag值设置成333跳过
        if(self.tag !=333){
            CGFloat fontSize =self.font.pointSize;
            self.font = [UIFont systemFontOfSize:fontSize];
        }
    }
    return self;
}

@end

