//
//  LoopedAppDelegate.m
//  Looped
//
//  Created by Barbara Wong on 4/20/14.
//  Copyright (c) 2014 Barbara Wong. All rights reserved.
//

#import "LoopedAppDelegate.h"
#import "Parse/Parse.h"
#import "NewsfeedViewController.h"
#import "ExploreViewController.h"
#import "ProfileViewController.h"
#import "SoundsViewController.h"
#import "SettingsViewController.h"
#import "FacebookSDK/FacebookSDK.h"


@implementation LoopedAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"XFsTOWNqoJwp7p59x6gMZR31KydV5FtjAe3v9bhH"
                  clientKey:@"Uqn4AGGs5i4kKogMqKStmzr1Zc2yA4nkbyCcOyVS"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [PFFacebookUtils initializeFacebook];
    

    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

/*
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if(flagOrientationToPortrait == YES){
        printf("flag: YES\n");
        return UIInterfaceOrientationPortrait;
    } else {
        printf("flag: NO\n");
        return UIInterfaceOrientationLandscapeLeft;
    }
}
*/
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
