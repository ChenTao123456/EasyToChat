//
//  AppDelegate.m
//  EasyToChat
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "FileViewController.h"
#import "NewViewController.h"
#import "PersonViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
   
    MainViewController *main=[[MainViewController alloc]init];
    main.tabBarItem.title=@"聊天中心";
    main.tabBarItem.image=[UIImage imageNamed:@"main@2x"];
    [main.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],UITextAttributeFont, nil] forState:UIControlStateNormal];
    UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:main];
    
    NewViewController *new=[[NewViewController alloc]init];
    new.tabBarItem.title=@"新闻";
    new.tabBarItem.image=[UIImage imageNamed:@"news@2x"];
    [new.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],UITextAttributeFont, nil] forState:UIControlStateNormal];
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:new];
    
    FileViewController *file=[[FileViewController alloc]init];
    file.tabBarItem.title=@"文件";
    file.tabBarItem.image=[UIImage imageNamed:@"file@2x"];
    [file.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],UITextAttributeFont, nil] forState:UIControlStateNormal];
    UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:file];
    
    PersonViewController *person=[[PersonViewController alloc]init];
    person.tabBarItem.title=@"个人";
    person.tabBarItem.image=[UIImage imageNamed:@"person@2x"];
    [person.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],UITextAttributeFont, nil] forState:UIControlStateNormal];
    UINavigationController *nav4=[[UINavigationController alloc]initWithRootViewController:person
    ];
    UITabBarController *tabBar=[[UITabBarController alloc]init];
//    tabBar.viewControllers=@[main,file,new,person];
    tabBar.viewControllers=@[nav1,nav3,nav2,nav4];
    self.window.rootViewController=tabBar;
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
