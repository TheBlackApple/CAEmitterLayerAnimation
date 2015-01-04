//
//  ViewController.m
//  粒子效果动画
//
//  Created by Charles Leo on 14/12/23.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "ViewController.h"
#import "SnowViewController.h"
#import "HeartsViewController.h"
#import "FireViewController.h"
#import "TouchViewController.h"
#import "FireWorksViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;


@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIScreen mainScreen].bounds.size.height / 5.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * titles = @[@"Snow",@"Hearts",@"Fire",@"Touch",@"FireWorks"];
    static NSString * cellID = @"cellIndentifer";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            SnowViewController * snowView = [[SnowViewController alloc]init];
            [self.navigationController pushViewController:snowView animated:YES];
        }
        break;
        case 1:
        {
            HeartsViewController * heartsView = [[HeartsViewController alloc]init];
            [self.navigationController pushViewController:heartsView animated:YES];
        }
        break;
        case 2:
        {
            FireViewController * fireView = [[FireViewController alloc]init];
            [self.navigationController pushViewController:fireView animated:YES];
        }
        break;
        case 3:
        {
            TouchViewController * touchView =[[TouchViewController alloc]init];
            [self.navigationController pushViewController:touchView animated:YES];
        }
        break;
        case 4:
        {
            FireWorksViewController * fireWorksView =[[FireWorksViewController alloc]init];
            [self.navigationController pushViewController:fireWorksView animated:YES];
        }
        break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
