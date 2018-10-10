//
//  UIButton+ACSImagePosition.m
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "UIButton+ACSImagePosition.h"


@implementation UIButton (ACSImagePosition)

- (void)acs_positionWith:(ACSUIButtonImagePosition)type edg:(CGFloat)edg {
    if (type == ACSUIButtonImagePositionTop) {
        self.titleEdgeInsets = UIEdgeInsetsMake(self.imageView.frame.size.height+edg, -self.imageView.bounds.size.width, 0,0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.frame.size.width/2, self.titleLabel.frame.size.height+edg, -self.titleLabel.frame.size.width/2);
    }
    else if (type == ACSUIButtonImagePositionBottom) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.bounds.size.width, self.imageView.frame.size.height+edg, -self.imageView.frame.size.width/2);
        self.imageEdgeInsets = UIEdgeInsetsMake(self.titleLabel.frame.size.height+edg, self.titleLabel.frame.size.width/2, 0,-self.titleLabel.frame.size.width/2);
    }
    else if (type == ACSUIButtonImagePositionLeft) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, edg, 0, 0);
    }
    else if (type == ACSUIButtonImagePositionRight) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.bounds.size.width-edg, 0, self.imageView.bounds.size.width + edg);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0,- self.titleLabel.bounds.size.width);
    }
}

@end
