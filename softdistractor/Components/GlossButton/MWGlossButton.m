//
//  MWGlossButton.m
//  softdistractor
//
//  Created by Mykola Savula on 2/25/15.
//  Copyright (c) 2015 Maliwan. All rights reserved.
//

#import "MWGlossButton.h"

//#define BLACK_HOLE

@interface MWGlossButton ()

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;
@property (nonatomic, strong) CAKeyframeAnimation *animation;

@end

@implementation MWGlossButton

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

- (CGPathRef)pathForRoundedRect:(CGRect)rect radius:(CGFloat)radius
{
    CGMutablePathRef retPath = CGPathCreateMutable();
    
    CGRect innerRect = CGRectInset(rect, radius, radius);
    
    CGFloat inside_right = innerRect.origin.x + innerRect.size.width;
    CGFloat outside_right = rect.origin.x + rect.size.width;
    CGFloat inside_bottom = innerRect.origin.y + innerRect.size.height;
    CGFloat outside_bottom = rect.origin.y + rect.size.height;
    
    CGFloat inside_top = innerRect.origin.y;
    CGFloat outside_top = rect.origin.y;
    CGFloat outside_left = rect.origin.x;
    
    CGPathMoveToPoint(retPath, NULL, innerRect.origin.x, outside_top);
    
    CGPathAddLineToPoint(retPath, NULL, inside_right, outside_top);
    CGPathAddArcToPoint(retPath, NULL, outside_right, outside_top, outside_right, inside_top, radius);
    CGPathAddLineToPoint(retPath, NULL, outside_right, inside_bottom);
    CGPathAddArcToPoint(retPath, NULL,  outside_right, outside_bottom, inside_right, outside_bottom, radius);
    
    CGPathAddLineToPoint(retPath, NULL, innerRect.origin.x, outside_bottom);
    CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_bottom, outside_left, inside_bottom, radius);
    CGPathAddLineToPoint(retPath, NULL, outside_left, inside_top);
    CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_top, innerRect.origin.x, outside_top, radius);
    
    CGPathCloseSubpath(retPath);
    
    return retPath;
}

- (void)setupDefaults
{
    // create emitter layer
    self.emitterLayer = [CAEmitterLayer layer];
    self.emitterLayer.frame = self.bounds;
    
    self.emitterLayer.emitterMode = kCAEmitterLayerOutline;
    self.emitterLayer.emitterPosition = CGPointMake(self.frame.size.width / 2.f, self.frame.size.height / 2.f);
    self.emitterLayer.emitterShape = kCAEmitterLayerCircle;
    self.emitterLayer.renderMode = kCAEmitterLayerAdditive;
    self.emitterLayer.emitterSize = CGSizeMake(self.frame.size.width / 4.f, self.frame.size.height / 4.f);
    
    // create the ball emitter cell
    CAEmitterCell *fire = [CAEmitterCell emitterCell];
    fire.color = [[UIColor lightGrayColor] CGColor];
    fire.contents = (id)[[UIImage imageNamed:@"fire"] CGImage];
    fire.birthRate = 100;
    fire.lifetime = 18;
    fire.velocity = 2;
    fire.emissionRange = 0.01;// M_PI / 2.f;
    [fire setName:@"ball"];
    
#ifdef BLACK_HOLE
    fire.color = [[UIColor colorWithRed:71.0/255.0 green:153.0/255.0 blue:210.0/255.0 alpha:0.1] CGColor];
    fire.contents = (id)[[UIImage imageNamed:@"particle-cloud"] CGImage];
    fire.birthRate = 200;
    fire.lifetime = 1.6;
    fire.velocity = 4;
    fire.emissionRange =  M_PI / 2.f;
#endif
    
    self.emitterLayer.emitterCells = [NSArray arrayWithObject:fire];
}

- (void)startDistration
{
    [self.layer addSublayer:self.emitterLayer];
#ifndef BLACK_HOLE
    [self bringSubviewToFront:self.imageView];
    [self bringSubviewToFront:self.titleLabel];
#endif
}

- (void)stopDistration
{
    [self.emitterLayer removeFromSuperlayer];
}

@end
