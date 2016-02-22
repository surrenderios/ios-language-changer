//
//  ViewController.m
//  Language Changer
//
//  Created by Alan Chung on 25/11/2014.
//  Copyright (c) 2014 Alan Chung. All rights reserved.
//

#import "ViewController.h"
#import "LanguageManager.h"
#import "Locale.h"
#import "Constants.h"

#import "INAppLanguageManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.flagImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self setIsRegisterINAppChangeLanguage:YES];
    
    /*
    LanguageManager *languageManager = [LanguageManager sharedLanguageManager];
    
    NSInteger selectedIndex = 0;
    
    Locale *selectedLocale = [languageManager getSelectedLocale];
    
    selectedIndex = [languageManager.availableLocales indexOfObject:selectedLocale];
    
    // Move the picker to match what was selected previously.
    [self.localePicker selectRow:selectedIndex inComponent:0 animated:YES];
    
    [self setupLocalisableElements];
     */
    
    INAppLanguageManager *languageManager = [INAppLanguageManager shareINAppLanguageManager];
    NSInteger selectedIndex = 0;
    LocalLanguage *selectedLocale = [languageManager selectedLocalLanguage];
    
    selectedIndex = [languageManager.availableLocalLanguages indexOfObject:selectedLocale];
    
    // Move the picker to match what was selected previously.
    [self.localePicker selectRow:selectedIndex inComponent:0 animated:YES];
    
    [self setupLocalisableElements];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    // Scroll back to the top of the text.
    self.textView.contentOffset = CGPointZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Localisation

/*!
 * @function setupLocalisableElements
 *
 * @abstract
 * Update the strings and images in the view depending on the currently selected localisation.
 *
 * @discussion
 * Should be called whenever the localisation is set.
 */
- (void)setupLocalisableElements {
    
    /*
    self.title = CustomLocalisedString(@"Title", @"The string to display in the navigation bar.");
    
    self.textView.text = CustomLocalisedString(@"Text", @"The string to display in the text view.");
    self.textView.contentOffset = CGPointZero;
    
    // Flag images are named after the country code of the Localisation.
    UIImage *flagImage = [UIImage imageNamed:[[LanguageManager sharedLanguageManager] getSelectedLocale].countryCode];
    [self.flagImageView setImage:flagImage];
     */
    self.title = INAppLocalisedString(@"Title", @"The string to display in the navigation bar.");
    
    self.textView.text = INAppLocalisedString(@"Text", @"The string to display in the text view.");
    self.textView.contentOffset = CGPointZero;
    
    // Flag images are named after the country code of the Localisation.
    UIImage *flagImage = [UIImage imageNamed:[[INAppLanguageManager shareINAppLanguageManager] selectedLocalLanguage].countryCode];
    [self.flagImageView setImage:flagImage];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    //return [LanguageManager sharedLanguageManager].availableLocales.count;
    return [INAppLanguageManager shareINAppLanguageManager].availableLocalLanguages.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
//    Locale *localeForRow = [LanguageManager sharedLanguageManager].availableLocales[row];
//    
//    return localeForRow.name;
    
    LocalLanguage *localeForRow = [INAppLanguageManager shareINAppLanguageManager].availableLocalLanguages[row];
    
    return localeForRow.languageName;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    /*
     * Set the localisation that the user has just picked.
     */
    
    /*
    LanguageManager *languageManager = [LanguageManager sharedLanguageManager];
    
    Locale *localeForRow = languageManager.availableLocales[row];
    
    NSLog(@"Language selected: %@", localeForRow.name);
    
    [languageManager setLanguageWithLocale:localeForRow];
    
    [self setupLocalisableElements];
     */
    INAppLanguageManager *languageManager = [INAppLanguageManager shareINAppLanguageManager];
    
    LocalLanguage *localeForRow = languageManager.availableLocalLanguages[row];
    
    NSLog(@"Language selected: %@", localeForRow.languageName);
    
    [languageManager setLanguageWithLocale:localeForRow];
}

- (void)INAppLanguageChanged:(NSNotification *)noti
{
    [self setupLocalisableElements];
}

@end
