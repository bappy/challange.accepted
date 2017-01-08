//
//  gameViewController.m
//  challange.accepted
//
//  Created by bappy on 12/8/16.
//  Copyright © 2016 bappy. All rights reserved.
//

#import "gameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ballonView.h"
@import AVFoundation;
@import AVKit;

@interface gameViewController ()
{
    int k;
    int i;
    ballonView *ballon;
    NSMutableArray *barray;
    NSMutableArray *index;
    UIActivityIndicatorView* activity;
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController;
    UIButton *btn;
    UIImageView *btnimageview;
    bool createballon;
    NSTimer *autoTimer;
    UIImageView *cat1;
    UIImageView *cat2;
    UIImageView *cat3;
    BOOL cat1_bool;
    BOOL cat2_bool;
    BOOL cat3_bool;
    UILabel *scoreboard;
    int score;
    NSArray *ballon_name;
    
}
@end

@implementation gameViewController

-(void)fly:(ballonView*)object
{
    
    [UIView animateWithDuration:4.0
                     animations:^{
                         k=[object.index intValue];
                         k+=object.frame.size.height/2;
                         [object setCenter:CGPointMake(object.frame.origin.x, k)];
                         object.index=[NSString stringWithFormat:@"%d",k];
                     }
                     completion:^(BOOL finished){
                         //reached at top
                         if((object.center.y<=50)&&(![object isHidden]))
                         {
                             [object removeFromSuperview];
                             
                             
                             
                             if((cat1_bool)&&(cat2_bool))
                             {
                                 
                                 [UIView animateWithDuration:.5
                                                  animations:^{
                                                      
                                                      cat1_bool=NO;
                                                  }
                                                  completion:^(BOOL finished){
                                                      [cat1 removeFromSuperview];
                                                      
                                                  }];
                                 
                             }
                             
                             
                             else  if((!cat1_bool)&&(cat2_bool))
                             {
                                 
                                 [UIView animateWithDuration:.5
                                                  animations:^{
                                                      
                                                      cat2_bool=NO;
                                                  }
                                                  completion:^(BOOL finished){
                                                      [cat2 removeFromSuperview];
                                                      
                                                  }];
                                 
                             }
                             else  if((!cat1_bool)&&(!cat2_bool)&&(cat3_bool))
                             {
                                 
                                 [UIView animateWithDuration:.5
                                                  animations:^{
                                                      
                                                      cat3_bool=NO;
                                                  }
                                                  completion:^(BOOL finished){
                                                      [cat3 removeFromSuperview];
                                                      
                                                  }];
                                 
                                 k=0;
                                 [videoPlayerViewController.moviePlayer pause];
                                 [autoTimer invalidate];
                                 autoTimer=nil;
                             }
                             
                             
                         }
                         
                         
                         
                         
                     }];
    
    
    
}

-(ballonView*)createBallon:(CGFloat)x
{
    
    ballonView *object=[[ballonView alloc]initWithFrame:CGRectMake(x, self.view.frame.size.height-ballon.frame.size.height-50, 100, 100)];
    [object setImage:[UIImage imageNamed:ballon_name[arc4random() % (ballon_name.count)]]];
    object.index=@"0";//initializing with zero value.
    return object;
    
}
- (NSString *)platformRawString {
    
   NSLog(@"%@",[[UIDevice currentDevice] localizedModel]);
  return [[UIDevice currentDevice] localizedModel];;
}
- (NSString *)platformNiceString {
    NSString *platform = [self platformRawString];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad 1";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (4G,2)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (4G,3)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *deviceType = [self platformRawString];
    NSLog(@"%@",deviceType);
    k=0;
    cat1_bool=YES;
    cat2_bool=YES;
    cat3_bool=YES;
    
    barray=[[NSMutableArray alloc]init];
    index=[[NSMutableArray alloc]init];
    [self playVideo];
    createballon=YES;
    ballon_name=[NSArray arrayWithObjects:@"balloon-downshift",@"balloon-ds",@"balloon-robot",@"balloon-jelly",@"balloon-challenge-accepted", nil];
    
    
}
- (CGPoint)getPoint:(CGRect)r
{
    CGPoint point = r.origin;
    
    point.x = arc4random_uniform((u_int32_t) CGRectGetWidth(r));
    point.y = arc4random_uniform((u_int32_t) CGRectGetHeight(r));
    return point;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onRun:(NSString *)timer {
    
    
    
    if(createballon)
    {
        CGPoint x=[self getPoint:CGRectMake(self.view.frame.origin.x
                                            , self.view.frame.origin.y, self.view.frame.size.width-ballon.frame.size.width, self.view.frame.size.height-ballon.frame.size.height-50)];
        ballon=[self createBallon:x.x];
        ballon.userInteractionEnabled=NO;
        [self.view addSubview:ballon];
        [self.view  bringSubviewToFront:ballon];
        [self fly:ballon];
        [barray addObject:ballon];
    }
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touch_location =[((UITouch *)[touches anyObject]) locationInView:self.view];
    ballonView *temp ;
    for(int counter=0;counter<[barray count];counter++)
    {
        temp=[barray objectAtIndex:counter];
        CGRect point= [temp.layer.presentationLayer frame];
        BOOL contains= CGRectContainsPoint(point, touch_location);
        
        if(contains)
        {
            
            
            [UIView animateWithDuration:.5
                             animations:^{
                                 temp.alpha=0;
                                 
                             }
                             completion:^(BOOL finished){
                                 [temp setHidden:YES];
                                 [temp removeFromSuperview];
                                 score++;
                                 if((cat2_bool)||(cat1_bool)||(cat3_bool))
                                 scoreboard.text=[NSString stringWithFormat:@"%d",score];
                                 k=0;
                             }];
            
            
        }
        
    }
}




- (void) playVideo
{
    
    
    videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"wZZ7oFKsKzY"];//wZZ7oFKsKzY
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(moviePlayerPlaybackStateDidChange:)  name:MPMoviePlayerPlaybackStateDidChangeNotification  object:videoPlayerViewController.moviePlayer];
    
    videoPlayerViewController.moviePlayer.fullscreen=YES;
    videoPlayerViewController.moviePlayer.scalingMode=MPMovieScalingModeAspectFill;
    videoPlayerViewController.moviePlayer.controlStyle=MPMovieControlStyleNone;
    self.view.userInteractionEnabled=YES;
    activity=[[UIActivityIndicatorView alloc]init];
    activity.backgroundColor=[UIColor blackColor];
    activity.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    activity.hidden=NO;
    [activity startAnimating];
    activity.center=CGPointMake(self.view.center.x, self.view.center.y);
    UIImageView *imageview_background=[[UIImageView alloc]initWithFrame:self.view.frame];
    [imageview_background setImage:[UIImage imageNamed:@"bg-game-screen"]];
    [self.view addSubview:imageview_background];
    [imageview_background bringSubviewToFront:self.view];
    NSLog(@"%f",self.view.frame.size.height);
    if(self.view.frame.size.height>600)//6s
    {
    videoPlayerViewController.view.frame=CGRectMake(27, 100, self.view.frame.size.width-60, 300);
    }
    else if((self.view.frame.size.height>500)&&(self.view.frame.size.height<600))
    {
        videoPlayerViewController.view.frame=CGRectMake(30,80, self.view.frame.size.width-60, self.view.frame.size.height-400);
    }
    //UIView *screen=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-32, self.view.frame.size.width, 32)];
    
    //[screen setBackgroundColor:[UIColor blackColor]];
    btn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x, self.view.frame.size.height-300, 50, 50)];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(PlayPause:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"button-pause"] forState:UIControlStateNormal];
    //[btn setTitle:@"Pause" forState:UIControlStateNormal];
    btn.tag=0;
    
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:btn];
    UIButton *close;
    close=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-16, [[UIApplication sharedApplication]statusBarFrame].size.height/2, 16, 16)];
    [close setBackgroundColor:[UIColor clearColor]];
    [close addTarget:self action:@selector(closeWindow:) forControlEvents:UIControlEventTouchUpInside];
    [close setBackgroundImage:[UIImage imageNamed:@"close-button"] forState:UIControlStateNormal];
    close.imageView.layer.cornerRadius = 7.0f;
    close.layer.shadowRadius = 3.0f;
    close.layer.shadowColor = [UIColor blackColor].CGColor;
    close.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    close.layer.shadowOpacity = 0.5f;
    close.layer.masksToBounds = NO;
    [self.view addSubview:close];
    
    //life
    cat1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    cat1.image=[UIImage imageNamed:@"cat"];
    
    [self.view addSubview:cat1];
    
    
    cat2=[[UIImageView alloc]initWithFrame:CGRectMake(2+cat1.frame.size.width+2,0, 20, 20)];
    cat2.image=[UIImage imageNamed:@"cat"];
    cat2.image=[UIImage imageNamed:@"cat"];
    [self.view addSubview:cat2];
    
    
    cat3=[[UIImageView alloc]initWithFrame:CGRectMake(2+cat1.frame.size.width+cat2.frame.size.width, 0,20, 20)];
    cat3.image=[UIImage imageNamed:@"cat"];
    cat3.image=[UIImage imageNamed:@"cat"];
    [self.view addSubview:cat3];
    //life
    //score board//
    scoreboard=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 50, 20)];
    [scoreboard setBackgroundColor:[UIColor colorWithRed:0.44 green:0.54 blue:0.67 alpha:1.0]];
    score=0;
    scoreboard.text=[NSString stringWithFormat:@"%d",score];
    scoreboard.textColor=[UIColor whiteColor];
    [self.view addSubview:scoreboard];
    
    //score board//
    
    [videoPlayerViewController.moviePlayer.view addSubview:activity];
   
    [self.view addSubview:videoPlayerViewController.view];
    
}
-(void)closeWindow:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)PlayPause:(UIButton *)sender
{
    NSLog(@"play and pause btn");
    if(btn.tag==0)
    {
        
        //pasue
        [videoPlayerViewController.moviePlayer pause];
        [btn setBackgroundImage:[UIImage imageNamed:@"button-play"] forState:UIControlStateNormal];
        btn.tag=1;
        createballon=NO;
        [autoTimer invalidate];
        autoTimer = nil;
        
    }
    else if(btn.tag==1)
    {
        //start
        [videoPlayerViewController.moviePlayer play];
        [btn setBackgroundImage:[UIImage imageNamed:@"button-pause"] forState:UIControlStateNormal];
        btn.tag=0;
        createballon=YES;
        //[autoTimer invalidate];
    }
}
-(void)moviePlayerPlaybackStateDidChange:(NSNotification*)notification
{
    
    if(videoPlayerViewController.moviePlayer.playbackState==MPMoviePlaybackStatePlaying)
    {
        autoTimer=[NSTimer scheduledTimerWithTimeInterval: 2
                                                   target: self
                                                 selector:@selector(onRun:)
                                                 userInfo: nil repeats:YES];
        [activity stopAnimating];
        [activity setHidden:YES];
        //[_activity removeFromSuperview];
    }
}
- (void) moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:notification.object];
    MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
    if (finishReason == MPMovieFinishReasonPlaybackError)
    {
        NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
        // Handle error
    }
}
@end
