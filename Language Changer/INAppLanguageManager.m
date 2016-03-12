//
//  INAppLanguageManager.m
//  Language Changer
//
//  Created by Alex on 16/2/19.
//  Copyright © 2016年 Alex Wu. All rights reserved.
//

#import "INAppLanguageManager.h"

NSString *const INAppLanguageChangeNotification = @"INAppLanguageChangeNotification";

@implementation LocalLanguage
- (instancetype)initWithLanguageName:(NSString *)languageName
                                code:(NSString *)languageCode
                         countryCode:(NSString *)countryCode;
{
    if (self = [self init]) {
        _languageName = languageName;
        _languageCode = languageCode;
        _countryCode  = countryCode;
    }
    return self;
}
@end

@implementation INAppLanguageManager
+ (INAppLanguageManager *)shareINAppLanguageManager
{
    static INAppLanguageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ manager = [[INAppLanguageManager alloc] init]; });
    return manager;
}

- (instancetype)init
{
    if (self = [super init])
    {
        // Manually create a list of available localisations
        LocalLanguage *english = [[LocalLanguage alloc]initWithLanguageName:@"United Kingdom" code:@"en" countryCode:@"US"];
//        LocalLanguage *chinese = [[LocalLanguage alloc]initWithLanguageName:@"中文" code:@"zh" countryCode:@"CN"];
//        LocalLanguage *combdia = [[LocalLanguage alloc]initWithLanguageName:@"Cambodia" code:@"km-KH" countryCode:@"KH"];
        
        LocalLanguage *french = [[LocalLanguage alloc]initWithLanguageName:@"France" code:@"fr" countryCode:@"fr"];
        LocalLanguage *japanese = [[LocalLanguage alloc]initWithLanguageName:@"日本" code:@"ja" countryCode:@"jp"];
        LocalLanguage *german = [[LocalLanguage alloc]initWithLanguageName:@"Deutschland" code:@"de" countryCode:@"de"];
        
        _availableLocalLanguages = @[english,french,japanese,german];

        //init read language
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (![userDefaults stringForKey:INApp_Se_Language_Code])
        {
            NSLocale *currentLocale = [NSLocale currentLocale];
            
            for (LocalLanguage *localisation in _availableLocalLanguages) {
                
                NSString *code = [currentLocale objectForKey:NSLocaleLanguageCode];
                
                if ([localisation.languageCode caseInsensitiveCompare:code] == NSOrderedSame)
                {
                    [self setLanguageWithLocale:localisation withPostChange:NO];
                    break;
                }
            }
            if (![userDefaults stringForKey:INApp_Se_Language_Code]) {
                
                NSLog(@"Couldn't find the right localisation - using default.");
                [self setLanguageWithLocale:_availableLocalLanguages[0] withPostChange:NO];
            }
        }
    }
    return self;
}


- (NSArray *)availableLocalLanguages
{
    return _availableLocalLanguages;
}

- (LocalLanguage *)selectedLocalLanguage;
{
    LocalLanguage *selectedLocale = nil;
    
    // Get the language code.
    NSString *languageCode = [[NSUserDefaults standardUserDefaults] stringForKey:INApp_Se_Language_Code] ;
    
    for (LocalLanguage *locale in _availableLocalLanguages) {
        if ([locale.languageCode caseInsensitiveCompare:languageCode] == NSOrderedSame) {
            selectedLocale = locale;
            break;
        }
    }
    
    return selectedLocale;
}

- (void)setLanguageWithLocale:(LocalLanguage *)locale;
{
    [self setLanguageWithLocale:locale withPostChange:YES];
}

- (void)setLanguageWithLocale:(LocalLanguage *)locale withPostChange:(BOOL)isPost
{
    [[NSUserDefaults standardUserDefaults] setObject:locale.languageCode forKey:INApp_Se_Language_Code];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (isPost)
    {
        NSDictionary *dic = @{@"localLanguage":locale};
        [[NSNotificationCenter defaultCenter] postNotificationName:INAppLanguageChangeNotification object:dic];
    }
}

- (NSString *)customerLocalizedStringForKey:(NSString *)key;
{
    NSString *languageCode = [[NSUserDefaults standardUserDefaults] stringForKey:INApp_Se_Language_Code];

    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:languageCode ofType:@"lproj"];
    NSBundle *languageBundle = nil;
    if (!bundlePath) { languageBundle = [NSBundle mainBundle]; }
    else { languageBundle = [NSBundle bundleWithPath:bundlePath]; }
    
    NSString *translatedString = [languageBundle localizedStringForKey:key value:@"" table:nil];
    
    if (translatedString.length < 1) {
        translatedString = NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], key, key);
    }
    
    return translatedString;
}
@end

@implementation UIViewController(INAppLanguage)
- (void)setIsRegisterINAppChangeLanguage:(BOOL)isRegisterINAppChangeLanguage;
{
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    if (isRegisterINAppChangeLanguage) {
        [noti addObserver:self selector:@selector(INAppLanguageChanged:) name:INAppLanguageChangeNotification object:nil];
    }else{
        [noti removeObserver:self name:INAppLanguageChangeNotification object:nil];
    }
}

- (void)INAppLanguageChanged:(NSNotification *)noti
{
   //UIViewController achive this method will be called
}


#warning 写的时候没有意识到是在Category里面,相当于替换了系统的方法,这样会导致崩溃
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
@end


