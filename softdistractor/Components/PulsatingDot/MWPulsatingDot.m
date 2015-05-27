//
//  MWPulsatingDot.m
//  softdistractor
//
//  Created by Mykola Savula on 2/25/15.
//  Copyright (c) 2015 Maliwan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MWPulsatingDot.h"

@interface MWPulsatingDot ()

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UIImageView *circleImageView;

@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation MWPulsatingDot

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self != nil)
    {
        [self setupDefaults];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self != nil)
    {
        [self setupDefaults];
    }
    
    return self;
}

- (void)setupDefaults
{
    self.circleImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.circleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.circleImageView.image = [UIImage imageNamed:@"ring"];
    [self addSubview:self.circleImageView];
    
    self.dotView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, self.bounds.size.width / 3.f, self.bounds.size.height / 3.f)];
    self.dotView.backgroundColor = [UIColor blueColor];
    self.dotView.layer.cornerRadius = self.dotView.bounds.size.width / 2.f;
    [self addSubview:self.dotView];
    
    self.animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    self.animation.duration = 0.8;
    self.animation.repeatCount = HUGE_VAL;
    self.animation.autoreverses = YES;
    self.animation.fromValue = [NSNumber numberWithFloat:1.2];
    self.animation.toValue = [NSNumber numberWithFloat:0.8];
}

- (void)startDistration
{
    [self.circleImageView.layer addAnimation:self.animation forKey:@"pulsation"];
}

- (void)stopDistration
{
    [self.circleImageView.layer removeAnimationForKey:@"pulsation"];
}

@end
