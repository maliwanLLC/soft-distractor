//
//  MWOverlayCell.m
//  softdistractor
//
//  Created by Mykola Savula on 2/24/15.
//  Copyright (c) 2015 Maliwan. All rights reserved.
//

#import "MWOverlayCell.h"

@interface MWOverlayCell ()

@property (nonatomic, strong) CABasicAnimation *animation;
@property (nonatomic, strong) CAGradientLayer *gradientMask;

@end

@implementation MWOverlayCell

- (void)awakeFromNib
{
    // Initialization code
    self.gradientMask = [CAGradientLayer layer];
    self.gradientMask.frame = self.bounds;
    CGFloat gradientSize = 120 / self.bounds.size.width;
    UIColor *gradient = [UIColor colorWithWhite:1.0f alpha:0.2f];

    self.animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    
    self.gradientMask.colors = @[(id)self.textLabel.textColor.CGColor,
                                 (id)gradient.CGColor,
                                 (id)self.textLabel.textColor.CGColor];
    self.gradientMask.locations = @[[NSNumber numberWithFloat:0.0f],
                                    [NSNumber numberWithFloat:(gradientSize / 2)],
                                    [NSNumber numberWithFloat:gradientSize]];
    
    self.gradientMask.startPoint = CGPointMake(0 - (gradientSize * 2), 0.5f);
    self.gradientMask.endPoint = CGPointMake(1 + gradientSize, 0.5f);
    
    self.layer.mask = self.gradientMask;
    
    self.animation.fromValue = @[[NSNumber numberWithFloat:0.0f],
                                 [NSNumber numberWithFloat:(gradientSize / 2)],
                                 [NSNumber numberWithFloat:gradientSize]];
    self.animation.toValue = @[[NSNumber numberWithFloat:(1.0f - gradientSize)],
                               [NSNumber numberWithFloat:(1.0f -(gradientSize / 2))],
                               [NSNumber numberWithFloat:1.0f]];;
    self.animation.repeatCount = HUGE_VALF;
    self.animation.duration  = 2.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)startDistration
{
    [self.gradientMask addAnimation:self.animation forKey:@"slideAnimation"];
}

- (void)stopDistration
{
    [self.gradientMask removeAnimationForKey:@"slideAnimation"];
}

@end
