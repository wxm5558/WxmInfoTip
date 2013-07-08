//
//  InfoTipView.h
//  WxmInfoTip
//
//  Created by xiaomanwang on 13-6-29.
//  Copyright (c) 2013年 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewProxy : NSObject
{
    NSTimer *hideSelfTimer;
}
@property (assign, nonatomic) id delegate;
@end

@interface InfoTipView : UIView
{
    UILabel *textLabel;
    InfoViewProxy *proxy;
}
- (void)showMessage:(NSString *)message;
- (void)hide;

+(InfoTipView *)sharedInfoTipView;
@end
