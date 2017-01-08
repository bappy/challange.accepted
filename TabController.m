//
//  TabController.m
//  challange.accepted
//
//  Created by bappy on 12/5/16.
//  Copyright © 2016 bappy. All rights reserved.
//

#import "TabController.h"
#import "LoginScreenTableViewController.h"
#import "FirstController.h"
#import "SecondController.h"
@interface TabController ()

@end

@implementation TabController
- (IBAction)close:(id)sender {
[self dismissViewControllerAnimated:YES completion:nil];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstController* vc1 = [[FirstController alloc]init];
    SecondController* vc2 = [[SecondController alloc] init];
    vc1.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"information" image:[UIImage imageNamed:@"1480810984_info-large"] tag:0];
    vc2.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Leader Board" image:[UIImage imageNamed:@"trophy (1)"] tag:1];
    NSArray *myViewControllers = @[vc1,vc2];
    [self setViewControllers:myViewControllers animated:YES];
   
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"yyyyy");
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"xxx");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
