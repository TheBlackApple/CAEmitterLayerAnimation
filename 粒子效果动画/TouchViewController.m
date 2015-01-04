//
//  TouchViewController.m
//  粒子效果动画
//
//  Created by Charles Leo on 14/12/23.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "TouchViewController.h"

@interface TouchViewController ()

@property (strong,nonatomic) CAEmitterLayer * ringEmitter;

@end

@implementation TouchViewController
@synthesize ringEmitter;
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
    self.ringEmitter = [CAEmitterLayer layer];
    self.ringEmitter.emitterPosition = CGPointMake(Width / 2, Height/ 2);
    self.ringEmitter.emitterSize = CGSizeMake(50, 0);
    self.ringEmitter.emitterMode = kCAEmitterLayerOutline;
    self.ringEmitter.emitterShape = kCAEmitterLayerCircle;
    self.ringEmitter.renderMode = kCAEmitterLayerBackToFront;
    
    
    
    //
    CAEmitterCell* ring = [CAEmitterCell emitterCell];
    [ring setName:@"ring"];
    
    ring.birthRate			= 0;
    ring.velocity			= 250;
    ring.scale				= 0.5;
    ring.scaleSpeed			=-0.2;
    ring.greenSpeed			=-0.2;	// shifting to green
    ring.redSpeed			=-0.5;
    ring.blueSpeed			=-0.5;
    ring.lifetime			= 2;
    
    ring.color = [[UIColor whiteColor] CGColor];
    ring.contents = (id) [[UIImage imageNamed:@"DazTriangle"] CGImage];
    
    
    CAEmitterCell* circle = [CAEmitterCell emitterCell];
    [circle setName:@"circle"];
    
    circle.birthRate		= 10;			// every triangle creates 20
    circle.emissionLongitude = M_PI * 0.5;	// sideways to triangle vector
    circle.velocity			= 50;
    circle.scale			= 0.5;
    circle.scaleSpeed		=-0.2;
    circle.greenSpeed		=-0.1;	// shifting to blue
    circle.redSpeed			=-0.2;
    circle.blueSpeed		= 0.1;
    circle.alphaSpeed		=-0.2;
    circle.lifetime			= 4;
    
    circle.color = [[UIColor whiteColor] CGColor];
    circle.contents = (id) [[UIImage imageNamed:@"DazRing"] CGImage];
    
    
    CAEmitterCell* star = [CAEmitterCell emitterCell];
    [star setName:@"star"];
    
    star.birthRate		= 10;	// every triangle creates 20
    star.velocity		= 100;
    star.zAcceleration  = -1;
    star.emissionLongitude = -M_PI;	// back from triangle vector
    star.scale			= 0.5;
    star.scaleSpeed		=-0.2;
    star.greenSpeed		=-0.1;
    star.redSpeed		= 0.4;	// shifting to red
    star.blueSpeed		=-0.1;
    star.alphaSpeed		=-0.2;
    star.lifetime		= 2;
    
    star.color = [[UIColor whiteColor] CGColor];
    star.contents = (id) [[UIImage imageNamed:@"DazStarOutline"] CGImage];
    
    // First traigles are emitted, which then spawn circles and star along their path
    self.ringEmitter.emitterCells = [NSArray arrayWithObject:ring];
    ring.emitterCells = [NSArray arrayWithObjects:circle, star, nil];
    //	circle.emitterCells = [NSArray arrayWithObject:star];	// this is SLOW!
    [self.view.layer addSublayer:self.ringEmitter];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    [self touchAtPosition:touchPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    [self touchAtPosition:touchPoint];
}


- (void) touchAtPosition:(CGPoint)position
{
    // Bling bling..
    CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.ring.birthRate"];
    burst.fromValue			= [NSNumber numberWithFloat: 125.0];	// short but intense burst
    burst.toValue			= [NSNumber numberWithFloat: 0.0];		// each birth creates 20 aditional cells!
    burst.duration			= 0.5;
    burst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.ringEmitter addAnimation:burst forKey:@"burst"];
    
    // Move to touch point
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    self.ringEmitter.emitterPosition	= position;
    [CATransaction commit];
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
