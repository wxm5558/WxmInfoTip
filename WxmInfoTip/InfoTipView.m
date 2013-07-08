//
//  InfoTipView.m
//  WxmInfoTip
//
//  Created by xiaomanwang on 13-6-29.
//  Copyright (c) 2013年 wxm. All rights reserved.
//

#import "InfoTipView.h"

@implementation InfoViewProxy
@synthesize delegate;
- (void)startTimer:(SEL)action
{
    if (delegate && [delegate respondsToSelector: action])
    {
        if ( hideSelfTimer )
        {
            [hideSelfTimer invalidate];
            [hideSelfTimer release];
			hideSelfTimer = nil;
        }
        hideSelfTimer = [[NSTimer scheduledTimerWithTimeInterval: 2.5 target: delegate selector: action userInfo: nil repeats: NO] retain];
    }
}

- (void)invalidate
{
    if ( hideSelfTimer )
    {
        [hideSelfTimer invalidate];
        [hideSelfTimer release];
		hideSelfTimer = nil;
    }
}

- (void)dealloc
{
    [self invalidate];
    [super dealloc];
}
@end

@implementation InfoTipView

static InfoTipView *_sharedInfoView;

+(InfoTipView *)sharedInfoTipView
{
    @synchronized([self class])
    {
		if (!_sharedInfoView)
        {
			_sharedInfoView = [[[self class] alloc] init];
		}
		return _sharedInfoView;
	}
    
	return nil;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = UITextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:15.0f];
        [textLabel setClipsToBounds: YES];
        [self addSubview: textLabel];
        self.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
        textLabel.numberOfLines = 0;
        textLabel.lineBreakMode = UILineBreakModeWordWrap;
        [self setFrame: CGRectZero];
        proxy = [[InfoViewProxy alloc] init];
        [proxy setDelegate: self];
    }
    return self;
}

- (void)dealloc
{
    [textLabel release];
    [proxy invalidate];
    [proxy release]; proxy = nil;
    [super dealloc];
}

- (void)showMessage:(NSString *)message
{
    [proxy invalidate];
	UIWindow *w = [UIApplication sharedApplication].keyWindow;
	CGSize wSize = w.frame.size;
    [textLabel setText: message];
    self.frame = CGRectMake((wSize.width - 250)/2.0f, (wSize.height - 65)/2.0f, 250, 65);
    textLabel.bounds =  self.bounds;
    [textLabel sizeToFit];
    textLabel.center = CGPointMake(250/2, 65/2);
    if (self.superview != w)
    {
        [w addSubview: self];
    }
    self.alpha = 0;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.0f;
        [w bringSubviewToFront: self];
    }];
    
    [proxy startTimer: @selector(hide)];
}

- (void)hide
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

@end
