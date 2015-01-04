//
//  HeartsViewController.m
//  粒子效果动画
//
//  Created by Charles Leo on 14/12/23.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "HeartsViewController.h"

@interface HeartsViewController ()
@property (strong,nonatomic) CAEmitterLayer * heartsEmitter;
@end

@implementation HeartsViewController
@synthesize heartsEmitter;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.heartsEmitter = [CAEmitterLayer layer];
    self.heartsEmitter.emitterPosition = self.view.center;
    self.heartsEmitter.emitterSize = CGSizeMake(10, 10);
    
    
    
    self.heartsEmitter.emitterMode = kCAEmitterLayerVolume;
    self.heartsEmitter.emitterShape = kCAEmitterLayerRectangle;
    self.heartsEmitter.renderMode = kCAEmitterLayerAdditive;
    
    
    CAEmitterCell * heart = [CAEmitterCell emitterCell];
    heart.name = @"heart";
    
    
    heart.emissionLongitude = M_PI/2.0; // up
    heart.emissionRange = 0.55 * M_PI;  // in a wide spread
    heart.birthRate		= 0.0;			// emitter is deactivated for now
    heart.lifetime		= 10.0;			// hearts vanish after 10 seconds
    
    heart.velocity		= -120;			// particles get fired up fast
    heart.velocityRange = 60;			// with some variation
    heart.yAcceleration = 20;			// but fall eventually
    
    heart.contents		= (id) [[UIImage imageNamed:@"DazHeart"] CGImage];
    heart.color			= [[UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:0.5] CGColor];
    heart.redRange		= 0.3;			// some variation in the color
    heart.blueRange		= 0.3;
    heart.alphaSpeed	= -0.5 / heart.lifetime;  // fade over the lifetime
    
    heart.scale			= 0.15;			// let them start small
    heart.scaleSpeed	= 0.5;			// but then 'explode' in size
    heart.spinRange		= 2.0 * M_PI;	// and
    
    self.heartsEmitter.emitterCells = [NSArray arrayWithObject:heart];
    [self.view.layer addSublayer:heartsEmitter];
    
    
    CABasicAnimation *heartsBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.heart.birthRate"];
    heartsBurst.fromValue		= [NSNumber numberWithFloat:10.0];
    heartsBurst.toValue			= [NSNumber numberWithFloat:  0.0];
    heartsBurst.duration		= 60.0;
    heartsBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.heartsEmitter addAnimation:heartsBurst forKey:@"heartsBurst"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
