//
//  CodeInputView.m
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "CodeInputView.h"
#import "FixedLengthTextField.h"

@interface CodeInputView() <FixedLengthTextFieldDelegate,UITextFieldDelegate>

@property (nonatomic, assign) NSInteger numberOfInputBox;
@property (nonatomic, strong) NSString *nibNameForTextField;

@end

@implementation CodeInputView

- (void)registerNibWithName:(NSString *)nibName {
  self.nibNameForTextField = nibName;
}

- (void)configureWithBoxCount:(NSInteger)numberOfInputBox withBoxSize:(CGSize)boxSize {
  [self layoutIfNeeded];
  self.numberOfInputBox = numberOfInputBox;
  CGFloat horizontalSpacing = (self.frame.size.width - (self.numberOfInputBox * boxSize.width)) / (self.numberOfInputBox + 1);
  CGFloat verticalSpacing = (self.frame.size.height - boxSize.height)/2;
  for (int i = 0 ; i < self.numberOfInputBox ; i++) {
    CGRect frame = CGRectMake(horizontalSpacing + i * (boxSize.width + horizontalSpacing), verticalSpacing, boxSize.width, boxSize.height);
    [self addTextFieldWithFrame:frame withTag:i+1];
  }
}

- (void)configureWithBoxCount:(NSInteger)numberOfInputBox withInset:(UIEdgeInsets)insets withInterBoxSpace:(CGFloat)space {
  [self layoutIfNeeded];
  self.numberOfInputBox = numberOfInputBox;
  CGFloat interSpaceDistance = (self.numberOfInputBox - 1) * space;
  CGFloat width = (self.frame.size.width - interSpaceDistance - insets.left - insets.right)/(self.numberOfInputBox);
  CGFloat height = self.frame.size.height - (insets.top + insets.bottom);
  for (int i = 0 ; i < self.numberOfInputBox ; i++) {
    CGRect frame = CGRectMake(i * (width+space) + insets.left, insets.top, width, height);
    [self addTextFieldWithFrame:frame withTag:i+1];
  }
}

- (void)addTextFieldWithFrame:(CGRect)boxFrame withTag:(NSInteger)tag {
  FixedLengthTextField *textfield;
  if (self.nibNameForTextField.length == 0) {
    textfield = [[FixedLengthTextField alloc]init];
    textfield.backgroundColor = [UIColor grayColor];
  }else {
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:self.nibNameForTextField owner:self options:nil];
    if ([array.firstObject isKindOfClass:[FixedLengthTextField class]]) {
      textfield = (FixedLengthTextField *) (array.firstObject);
    }else {
      NSAssert(@"No subclass of FixedLengthTextField found", @"");
    }
  }
  [textfield setFrame:boxFrame];
  [self addSubview:textfield];
  textfield.tag = tag;
  textfield.maximumCharacterLimit = 1;
  textfield.fixedLengthTextFieldDelegate = self;
}

- (void)didDeleteFromEmptyTextField:(FixedLengthTextField *)textField {
  NSInteger currentIndex = textField.tag;
  FixedLengthTextField *previousTextField = (FixedLengthTextField *)[self viewWithTag:(currentIndex - 1)%self.numberOfInputBox];
  [previousTextField becomeFirstResponder];
}

- (void)didInsertToFullTextField:(FixedLengthTextField *)textField {
  [self moveNextOfTextField:textField];
}

- (void)didTapReturnKey:(FixedLengthTextField *)textField {
  [self moveNextOfTextField:textField];
}

- (void)textLimitReachedForTextField:(FixedLengthTextField *)textField {
  [self moveNextOfTextField:textField];
}

- (void)moveNextOfTextField:(UITextField *)textField {
  NSInteger currentIndex = textField.tag;
  if (currentIndex == self.numberOfInputBox) {
    currentIndex = 0;
  }else {
    currentIndex ++;
  }
  FixedLengthTextField *nextTextField = (FixedLengthTextField *)[self viewWithTag:currentIndex];
  [nextTextField becomeFirstResponder];
}

@end
