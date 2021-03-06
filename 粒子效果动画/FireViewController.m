//
//  FireViewController.m
//  粒子效果动画
//
//  Created by Charles Leo on 14/12/23.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "FireViewController.h"

@interface FireViewController ()
@property (strong,nonatomic) CAEmitterLayer * fireEmitter;

@property (strong,nonatomic) CAEmitterLayer * smokeEmitter;

@end

@implementation FireViewController
@synthesize fireEmitter,smokeEmitter;
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
    self.fireEmitter = [CAEmitterLayer layer];
    self.smokeEmitter = [CAEmitterLayer layer];
    
    self.fireEmitter.emitterPosition = CGPointMake(Width/2, Height);
    self.fireEmitter.emitterSize = CGSizeMake(Width / 2 , 0);
    self.fireEmitter.emitterMode = kCAEmitterLayerOutline;
    self.fireEmitter.emitterShape = kCAEmitterLayerLine;
    self.fireEmitter.renderMode = kCAEmitterLayerAdditive;
    
    
    self.smokeEmitter.emitterPosition = CGPointMake(Width/2, Height);
    self.smokeEmitter.emitterMode = kCAEmitterLayerPoints;
    
    //火粒子
    CAEmitterCell * fire = [CAEmitterCell emitterCell];
    fire.name = @"fire";
    fire.birthRate			= 100;
    fire.emissionLongitude  = M_PI;
    fire.velocity			= -80;
    fire.velocityRange		= 30;
    fire.emissionRange		= 1.1;
    fire.yAcceleration		= -200;
    fire.scaleSpeed			= 0.3;
    fire.lifetime			= 50;
    fire.lifetimeRange		= (50.0 * 0.35);
    
    fire.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    fire.contents = (id) [[UIImage imageNamed:@"DazFire"] CGImage];
    
    
    //烟粒子
    CAEmitterCell* smoke = [CAEmitterCell emitterCell];
    [smoke setName:@"smoke"];
    
    smoke.birthRate			= 11;
    smoke.emissionLongitude = -M_PI / 2;
    smoke.lifetime			= 10;
    smoke.velocity			= -40;
    smoke.velocityRange		= 20;
    smoke.emissionRange		= M_PI / 4;
    smoke.spin				= 1;
    smoke.spinRange			= 6;
    smoke.yAcceleration		= -160;
    smoke.contents			= (id) [[UIImage imageNamed:@"DazSmoke"] CGImage];
    smoke.scale				= 0.1;
    smoke.alphaSpeed		= -0.12;
    smoke.scaleSpeed		= 0.7;
    
    
    self.smokeEmitter.emitterCells	= [NSArray arrayWithObject:smoke];
    self.fireEmitter.emitterCells	= [NSArray arrayWithObject:fire];
    [self.view.layer addSublayer:self.smokeEmitter];
    [self.view.layer addSublayer:self.fireEmitter];

    [self setFireAmount:0.9];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self controlFireHeight:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self controlFireHeight:event];
}

- (void) controlFireHeight:(UIEvent *)event
{
    UITouch *touch			= [[event allTouches] anyObject];
    CGPoint touchPoint		= [touch locationInView:self.view];
    float distanceToBottom	= self.view.bounds.size.height - touchPoint.y;
    float percentage		= distanceToBottom / self.view.bounds.size.height;
    percentage				= MAX(MIN(percentage, 1.0), 0.1);
    [self setFireAmount:2 *percentage];
}


- (void) setFireAmount:(float)zeroToOne
{
    // Update the fire properties
    [self.fireEmitter setValue:[NSNumber numberWithInt:(zeroToOne * 500)]
                    forKeyPath:@"emitterCells.fire.birthRate"];
    [self.fireEmitter setValue:[NSNumber numberWithFloat:zeroToOne]
                    forKeyPath:@"emitterCells.fire.lifetime"];
    [self.fireEmitter setValue:[NSNumber numberWithFloat:(zeroToOne * 0.35)]
                    forKeyPath:@"emitterCells.fire.lifetimeRange"];
    self.fireEmitter.emitterSize = CGSizeMake(50 * zeroToOne, 0);
    
    [self.smokeEmitter setValue:[NSNumber numberWithInt:zeroToOne * 4]
                     forKeyPath:@"emitterCells.smoke.lifetime"];
    [self.smokeEmitter setValue:(id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:zeroToOne * 0.3] CGColor]
                     forKeyPath:@"emitterCells.smoke.color"];
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
