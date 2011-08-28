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
        // Initialization code
//        [self addTarget:self action:@selector(closeKeyboard) forControlEvents:UIControlEventTouchDown];
//        self.backgroundColor = [UIColor blackColor];
//        _textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
//        _textField.backgroundColor = [UIColor whiteColor];
//        [self addSubview:_textField];
//        
//        _okButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 50, 30)];
//        [_okButton setTitle:@"OK" forState:UIControlStateNormal];
//        _okButton.backgroundColor = [UIColor whiteColor];
//        [self addSubview:_okButton];
        
//        NSString *path = [NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()];
//        _categoryArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    }
    return self;
}

- (IBAction)showPickerView:(id)sender{
    
//    if (!_categoryArray) {
//        _categoryArray = [[NSArray alloc] init];
//    }
//    else 
//        [_categoryArray removeAllObjects];
    [_textField resignFirstResponder];
    [_detailTextField resignFirstResponder];
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
    _categoryArray = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil] copy];
    [_pickerView reloadAllComponents];
    _pickerView.hidden = NO;


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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
//    [self removeFromSuperview];
}

- (IBAction)closeKeyboard:(id)sender {
    [_textField resignFirstResponder];
    [_detailTextField resignFirstResponder];
}

- (IBAction)okButtonPressed:(id)sender {
    [delegate importImageswithCategory:_textField.text detial:_detailTextField.text];
    [self closeKeyboard:nil];
//    [self removeFromSuperview];
    self.alpha = 0.f;
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
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    [_textField resignFirstResponder];
//    [_detailTextField resignFirstResponder];
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
