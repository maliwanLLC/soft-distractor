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
    
    // create emitter cell
    CAEmitterCell *fire = [CAEmitterCell emitterCell];
    fire.color = [[UIColor lightGrayColor] CGColor];
    fire.contents = (id)[[UIImage imageNamed:@"fire"] CGImage];
    fire.birthRate = 100;
    fire.lifetime = 18;
    fire.velocity = 2;
    fire.emissionRange = 0.01;
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
