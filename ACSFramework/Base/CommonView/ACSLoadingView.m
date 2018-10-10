//
//  ACSLoadingView.m
//  ACSFramework
//
//  Created by wang on 2018/6/19.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "ACSLoadingView.h"

#import "UIColor+ACSHexColor.h"


@interface ACSLoadingView ()

@property (nonatomic, strong) UIImageView *loadingImage;
@property (nonatomic, strong) UILabel *loadingTitle;

@end

@implementation ACSLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor acs_hexStringToColor:@"F8F8FA"];
        
        _loadingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_loading"]];
        [self addSubview:_loadingImage];
        
        _loadingTitle = [[UILabel alloc] init];
        _loadingTitle.textColor = [UIColor acs_hexStringToColor:@"#666666"];
        _loadingTitle.font = [UIFont systemFontOfSize:18];
        _loadingTitle.text = @"Wait a moment";
        _loadingTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_loadingTitle];
        
        [_loadingImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).with.offset(-50);
            make.size.mas_equalTo(CGSizeMake(45, 46));
        }];
        [_loadingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.loadingImage.mas_bottom).with.offset(20);
        }];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self startAnimation];
}

- (void)startAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: M_PI *2];
    animation.duration = 3;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [_loadingImage.layer addAnimation:animation forKey:@"loading"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
