ios-language-changer
====================

iOS language changer example app

A simple app that allows the user to change language in-app, independent of the device setting.

See http://createdineden.com/blog/2014/december/12/language-changer-in-app-language-selection-in-ios/ for the accompanying tutorial.


### What Did I Changed

Make all files into INAppLanguageManager.h && INAppLanguageManager.m, make it more easy to use.

### How to use INAppLanguageManager

1. after didFinishLaunchingWithOptions, init the  INAppLanguageManager with code 
   
   [INAppLanguageManager shareINAppLanguageManager];
   
2. register notification in where you want to change language, usually in UIViewController,ViewDidLoad methods with code
   
   [self setIsRegisterINAppChangeLanguage:YES];

3. Implemente method 
   
   - (void)INAppLanguageChanged:(NSNotification *)noti,

In this method you could change localized string with 

   INAppLocalisedString(@"key",nil)

### More you can clone the rep.
