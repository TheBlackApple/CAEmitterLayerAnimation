//
//  SnowViewController.m
//  粒子效果动画
//
//  Created by Charles Leo on 14/12/23.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "SnowViewController.h"

@interface SnowViewController ()

@end

@implementation SnowViewController

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
    //粒子放射器
    CAEmitterLayer * snowEmitter = [CAEmitterLayer layer];
    snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width /2 , -30);
    snowEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    snowEmitter.emitterMode = kCAEmitterLayerOutline;
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    
    //雪花飘落
    CAEmitterCell * snowFlake = [CAEmitterCell emitterCell];
    snowFlake.birthRate = 1.5;              //每一秒产生的粒子个数
    snowFlake.lifetime = 120.0;             //粒子存在时间
    snowFlake.velocity = -10;               //速度
    snowFlake.velocityRange = 10;           //速度
    snowFlake.yAcceleration = 5;            //y方向上的加速度
    snowFlake.emissionRange = 0.5 * M_PI;   //发射范围
    snowFlake.spinRange = 0.25 * M_PI;      //自旋范围
    snowFlake.contents = (id)[[UIImage imageNamed:@"snow"] CGImage];
    //snowFlake.color = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius = 0.0;
    snowEmitter.shadowOffset = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor = [UIColor whiteColor].CGColor;
    
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowFlake];
    [self.view.layer insertSublayer:snowEmitter atIndex:0];

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
