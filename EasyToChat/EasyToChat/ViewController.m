//
//  ViewController.m
//  EasyToChat
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "LoginViewController.h"
@interface ViewController (){
    UIImageView *img;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden=YES;
    
    img=[[UIImageView alloc]initWithFrame:self.view.frame];
    img.image=[UIImage imageNamed:@"6"];
    [self.view addSubview:img];
    
    [UIView animateWithDuration:1 animations:^{
        img.alpha=0.5;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view.window cache:YES];
            [img removeFromSuperview];
            
            LoginViewController *loginVC=[[LoginViewController alloc]init];
            UINavigationController *navic=[[UINavigationController alloc]initWithRootViewController:loginVC];
            self.view.window.rootViewController=navic;
          
        }];
    }];
    
    
    
    
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
