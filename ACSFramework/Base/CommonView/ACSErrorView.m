//
//  ACSErrorView.m
//  ACSFramework
//
//  Created by wang on 2018/6/19.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "ACSErrorView.h"

#import "UIColor+ACSHexColor.h"

@interface ACSErrorView ()
@property (nonatomic, strong) UIImageView *errorImage;
@property (nonatomic, strong) UILabel *errorTitle;

@property (nonatomic, strong) UIButton *errorBtn;

@end

@implementation ACSErrorView


- (instancetype)initWithFrame:(CGRect)frame type:(ACSErrorViewType)type {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor acs_hexStringToColor:@"#F8F8FA"];
        
        _errorImage = [[UIImageView alloc] init];
        [self addSubview:_errorImage];
        
        _errorTitle = [[UILabel alloc] init];
        _errorTitle.textColor = [UIColor acs_hexStringToColor:@"#666666"];
        _errorTitle.font = [UIFont systemFontOfSize:18];
        _errorTitle.text = @"";
        _errorTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_errorTitle];
        
        [_errorImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).with.offset(-100);
            make.size.mas_equalTo(CGSizeMake(200, 200));
        }];
        [_errorTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.errorImage.mas_bottom).with.offset(44);
        }];
        
        if (type == ACSErrorViewTypeServer || type == ACSErrorViewTypeNetwork) {
            _errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _errorBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:_errorBtn];
            
            [_errorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self.errorTitle.mas_bottom).with.offset(20);
            }];
            
            [_errorBtn addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        NSDictionary *attrs = @{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
                                NSForegroundColorAttributeName : [UIColor acs_hexStringToColor:@"#0BD0B2"]
                                };
        NSAttributedString *errorBtnStr = [[NSAttributedString alloc] initWithString:@"Refresh" attributes:attrs];
        if (type == ACSErrorViewTypeServer) {
            _errorImage.image = [UIImage imageNamed:@"icon_error_server"];
            _errorTitle.text = @"Server Crash";
            [_errorBtn setAttributedTitle:errorBtnStr forState:UIControlStateNormal];
        }
        else if (type == ACSErrorViewTypeNetwork) {
            _errorImage.image = [UIImage imageNamed:@"icon_error_network"];
            _errorTitle.text = @"Network Abnormaly";
            [_errorBtn setAttributedTitle:errorBtnStr forState:UIControlStateNormal];
        }
        else if (type == ACSErrorViewTypeEmpty) {
            _errorImage.image = [UIImage imageNamed:@"icon_error_empty"];
            _errorTitle.text = @"EMPTY";
        }
    }
    return self;
}

#pragma mark - Action
- (void)refreshAction:(UIButton *)btn {
    if (_refreshBlock) {
        [self removeFromSuperview];
        _refreshBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
