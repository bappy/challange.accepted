//
//  ViewController.m
//  challange.accepted
//
//  Created by bappy on 12/2/16.
//  Copyright © 2016 bappy. All rights reserved.
//

#import "ViewController.h"
#import "CollectonCollectionViewController.h"
#import "LoginScreenTableViewController.h"
#import "gameViewController.h"
#import "GameRootController.h"
@interface ViewController ()
@property (nonatomic) CAPSPageMenu *pageMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.title = @"PAGE MENU";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor orangeColor]};
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<-" style:UIBarButtonItemStyleDone target:self action:@selector(didTapGoToLeft)];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"->" style:UIBarButtonItemStyleDone target:self action:@selector(didTapGoToRight)];
   
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CollectonCollectionViewController *controller1 = [storyboard instantiateViewControllerWithIdentifier:@"Main"];
    controller1.view.backgroundColor=[UIColor blueColor];
    LoginScreenTableViewController *login=[storyboard instantiateViewControllerWithIdentifier:@"Login"];
   gameViewController *game=[storyboard instantiateViewControllerWithIdentifier:@"game"];
   GameRootController *game_root=[storyboard instantiateViewControllerWithIdentifier:@"GameRoot_Controller"];
    game.title=@"Game";
    controller1.title=@"Main";
    login.title=@"Login";
    game_root.title=@"Game";
    
    NSArray *controllerArray = @[controller1,login,game_root];
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0],
                                 CAPSPageMenuOptionViewBackgroundColor: [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:1.0],
                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor orangeColor],
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0],
                                 CAPSPageMenuOptionMenuItemFont: [UIFont fontWithName:@"HelveticaNeue" size:18.0],
                                 CAPSPageMenuOptionMenuHeight: @(40.0),
                                 CAPSPageMenuOptionMenuItemWidth: @(90.0),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES),
                                 CAPSPageMenuOptionMenuItemSeparatorWidth: @(4.3),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(YES),
                                 CAPSPageMenuOptionMenuItemSeparatorPercentageHeight: @(0.1)
                                 };
    
    
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0,[UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
    _pageMenu.delegate=self;
    _pageMenu.scrollMenuBackgroundColor=[UIColor blackColor];
    _pageMenu.menuMargin=20.0;
   // _pageMenu.menuItemWidth=10.0;
    game.Menu=_pageMenu;
    [self.view addSubview:_pageMenu.view];
    
    

}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
-(void)clickedTitle
{
    [_pageMenu moveToPage:1];
    
}
- (void)willMoveToPage:(UIViewController *)controller index:(NSInteger)index {

    
}

- (void)didMoveToPage:(UIViewController *)controller index:(NSInteger)index {


}
- (void)didTapGoToLeft {
    NSInteger currentIndex = self.pageMenu.currentPageIndex;
    
    if (currentIndex > 0) {
        [_pageMenu moveToPage:currentIndex - 1];
    }
}

- (void)didTapGoToRight {
    NSInteger currentIndex = self.pageMenu.currentPageIndex;
    
    if (currentIndex < self.pageMenu.controllerArray.count) {
        [self.pageMenu moveToPage:currentIndex + 1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
