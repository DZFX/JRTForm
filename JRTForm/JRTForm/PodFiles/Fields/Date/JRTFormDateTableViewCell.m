//Copyright (c) 2015 Juan Carlos Garcia Alfaro. All rights reserved.
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import "JRTFormDateTableViewCell.h"
#import "JRTFormDatePickerViewController.h"

NSString *const kJRTFormFieldDateTableViewCell = @"JRTFormDateTableViewCell";

@interface JRTFormDateTableViewCell ()<JRTDatePickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UILabel *textSelectedLabel;
@property (weak, nonatomic) IBOutlet UIButton *cleanButton;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic) BOOL hideableLabel;

@property (nonatomic, copy) NSString * (^errorMessageInValidationBlock) (NSDate *dateToValidate);

@end

@implementation JRTFormDateTableViewCell

@synthesize name = _name;

#pragma mark - View

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.hideableLabel = self.label.hidden;
    self.labelColor = self.label.textColor;
}

#pragma mark - styles

- (void)setDefaultStyle {
    if (self.labelColor) {
        self.label.textColor = self.labelColor;
    }
    self.label.text = self.name;
    self.placeholderLabel.hidden = YES;
    self.textSelectedLabel.hidden = NO;
    self.cleanButton.hidden = NO;
    if (self.hideableLabel) {
        self.label.hidden = NO;
    }
}

- (void)setEmptyStyle {
    if (self.labelColor) {
        self.label.textColor = self.labelColor;
    }
    self.label.text = self.name;
    self.placeholderLabel.hidden = NO;
    self.textSelectedLabel.hidden = YES;
    self.cleanButton.hidden = YES;
    if (self.hideableLabel) {
        self.label.hidden = YES;
    }
}

- (void)setErrorStyleWithMessage:(NSString *)errorMessage {
    if (self.labelColor) {
        self.label.textColor = [UIColor redColor];
    }
    self.label.text = [NSString stringWithFormat:@"%@ %@", self.name, errorMessage];
    self.textSelectedLabel.hidden = ([self.textSelectedLabel.text length] == 0);
    self.placeholderLabel.hidden = !self.textSelectedLabel.hidden;
    self.cleanButton.hidden = self.textSelectedLabel.hidden;
    if (self.hideableLabel) {
        self.label.hidden = NO;
    }
}

- (void)updateStyle {
    if (!self.isValid) {
        [self setErrorStyleWithMessage:self.errorMessageInValidationBlock(self.date)];
    }
    else if (self.date) {
        [self setDefaultStyle];
    }
    else {
        [self setEmptyStyle];
    }
}

#pragma mark - Getters

- (BOOL)isValid {
    BOOL valid = YES;
    if (self.errorMessageInValidationBlock) {
        NSString *errorMessage = self.errorMessageInValidationBlock(self.date);
        if (errorMessage && ![errorMessage isEqualToString:@""]) {
            valid = NO;
        }
    }
    return valid;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [_dateFormatter setDateFormat:@"MMMM dd, yyyy"];
    }
    return _dateFormatter;
}

#pragma mark - Setters

- (void)setName:(NSString *)name {
    _name = name;
    self.placeholderLabel.text = name;
    self.label.text = name;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    self.textSelectedLabel.text = [self.dateFormatter stringFromDate:date];
    [self updateStyle];
}

- (void)setPlaceholderColor:(UIColor *)color {
    self.placeholderLabel.textColor =  color;
}

#pragma mark - DatePicker

- (void)displayDatePicker {
    JRTFormDatePickerViewController *datePickerViewController = [JRTFormDatePickerViewController new];
    datePickerViewController.delegate = self;
    datePickerViewController.title = self.name;
    [datePickerViewController show];
}

#pragma mark - Actions

- (IBAction)touchUpInside:(id)sender {
    [self displayDatePicker];
}

- (IBAction)cleanAction:(id)sender {
    self.date = nil;
}
@end
