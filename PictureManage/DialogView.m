//
//  DialogView.m
//  almondz
//
//  Created by Wu Jianjun on 11-6-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DialogView.h"
//#import "ELCAssetTablePicker.h"

@implementation DialogView
@synthesize okButton = _okButton;
@synthesize textField = _textField;
@synthesize detailTextField = _detailTextField;
@synthesize pickerView = _pickerView;
@synthesize delegate;
- (void)closeKeyboard {
    [_textField resignFirstResponder];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [super init];
        if (self) {
           
            }
            else{
                //提示没有分组
            }
            
        }
        return self;
        
    }



- (IBAction)showPickerView:(id)sender{
    [_textField resignFirstResponder];
    [_detailTextField resignFirstResponder];
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
    _categoryArray = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil] copy];
    [_pickerView reloadAllComponents];
    _pickerView.hidden = NO;


}


- (void)dealloc
{
    [_okButton release];
    [_textField release];
    [_detailTextField release];
    [_pickerView release];
    [super dealloc];
}

- (IBAction)closeWindows:(id)sender {
    self.alpha = 0.f;
    [self closeKeyboard:nil];
}

- (IBAction)closeKeyboard:(id)sender {
    [_textField resignFirstResponder];
    [_detailTextField resignFirstResponder];
}

- (IBAction)okButtonPressed:(id)sender {
    if([delegate respondsToSelector:@selector(importImageswithCategory:detial:)]){
    [delegate importImageswithCategory:_textField.text detial:_detailTextField.text];
    [self closeKeyboard:nil];
    self.alpha = 0.f;
    }
}

#pragma mark - pickerView Delegate Method

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_categoryArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_categoryArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _textField.text = [_categoryArray objectAtIndex:row];
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
