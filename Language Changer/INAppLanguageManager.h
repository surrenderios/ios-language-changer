//
//  INAppLanguageManager.h
//  Language Changer
//
//  Created by Alex on 16/2/19.
//  Copyright © 2016年 Alex Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define INAppLocalisedString(key, comment) \
[[INAppLanguageManager shareINAppLanguageManager] customerLocalizedStringForKey:key]

#define INApp_Se_Language_Code @"INApp_Selected_Language_Code"

extern NSString *const INAppLanguageChangeNotification;

@protocol INAppLanguage;

@interface LocalLanguage : NSObject
@property (nonatomic, copy) NSString *languageName;
@property (nonatomic, copy) NSString *languageCode;
@property (nonatomic, copy) NSString *countryCode;
- (instancetype)initWithLanguageName:(NSString *)languageName
                                code:(NSString *)languageCode
                         countryCode:(NSString *)countryCode;
@end

@interface INAppLanguageManager : NSObject

/**
 *  available languages in your application
 */
@property (nonatomic, copy) NSArray *availableLocalLanguages;

/**
 *  Singleton
 *
 *  @return Singleton for INAppLanguageManager
 */
+ (INAppLanguageManager *)shareINAppLanguageManager;

/**
 *  get current selected language model
 *
 *  @return selected language model
 */
- (LocalLanguage *)selectedLocalLanguage;

/**
 *  setlocalized language
 *
 *  @param locale NSLocal language
 */
- (void)setLanguageWithLocale:(LocalLanguage *)locale;

/**
 *  get locallized string with key
 *
 *  @param key your localized key
 *
 *  @return localized string
 */
- (NSString *)customerLocalizedStringForKey:(NSString *)key;
@end


/**
 *  achive this method in where you want custom language
 */

@interface UIViewController(INAppLanguage)
/**
 *  是否注册接受语言改变的通知,如果接受了通知,则在方法
 *  - (void)INAppLanguageChanged:(NSNotification *)noti 中更新显示
 *  请在主线程中更新UI,以免造成问题
 *
 *  @param isRegisterINAppChangeLanguage 是否注册语言更新通知
 */
- (void)setIsRegisterINAppChangeLanguage:(BOOL)isRegisterINAppChangeLanguage;
@end

//***************common language Name & Code & countryCode**************************
// more visit https://docs.oracle.com/cd/E13214_01/wli/docs92/xref/xqisocodes.html
//***********************************end********************************************

