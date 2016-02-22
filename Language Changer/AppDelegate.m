//
//  AppDelegate.m
//  Language Changer
//
//  Created by Alan Chung on 25/11/2014.
//  Copyright (c) 2014 Alan Chung. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import "LanguageManager.h"
#import "Locale.h"

#import "INAppLanguageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [INAppLanguageManager shareINAppLanguageManager];
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    LanguageManager *languageManager = [LanguageManager sharedLanguageManager];
//    
//    /*
//     * Check the user defaults to find whether a localisation has been set before.
//     * If it hasn't been set, (i.e. first run of the app), select the locale based
//     * on the device locale setting.
//     */
//    
//    // Check whether the language code has already been set.
//    if (![userDefaults stringForKey:DEFAULTS_KEY_LANGUAGE_CODE]) {
//        
//        NSLog(@"No language set - trying to find the right setting for the device locale.");
//        
//        NSLocale *currentLocale = [NSLocale currentLocale];
//        
//        // Iterate through available localisations to find the matching one for the device locale.
//        for (Locale *localisation in languageManager.availableLocales) {
//            
//            if ([localisation.languageCode caseInsensitiveCompare:[currentLocale objectForKey:NSLocaleLanguageCode]] == NSOrderedSame) {
//                
//                [languageManager setLanguageWithLocale:localisation];
//                break;
//            }
//        }
//        
//        // If the device locale doesn't match any of the available ones, just pick the first one.
//        if (![userDefaults stringForKey:DEFAULTS_KEY_LANGUAGE_CODE]) {
//            
//            NSLog(@"Couldn't find the right localisation - using default.");
//            [languageManager setLanguageWithLocale:languageManager.availableLocales[0]];
//        }
//    }
//    else {
//        
//        NSLog(@"The language has already been set :)");
//    }
    
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
