//
//  CodeInputManager.m
//  CodeInputView
//
//  Created by sah-fueled on 16/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "SHCodeInputDelegateManager.h"
#import "SHFixedLengthTextField.h"

@interface SHCodeInputDelegateManager()<SHFixedLengthTextFieldDelegate>


@end

@implementation SHCodeInputDelegateManager

- (id)initWithTextFields:(NSArray *)textFields {
  self = [super init];
  if (self) {
    _listOfTextFields = [NSArray arrayWithArray:textFields];
    [self.listOfTextFields enumerateObjectsUsingBlock:^(SHFixedLengthTextField *textField, NSUInteger idx, BOOL *stop) {
      textField.fixedLengthTextFieldDelegate = self;
    }];
  }
  
  return self;
}

- (void)didDeleteFromEmptyTextField:(SHFixedLengthTextField *)textField {
  NSInteger currentIndex = [self.listOfTextFields indexOfObject:textField];
  if (currentIndex > 0) {
    SHFixedLengthTextField *previousTextField = [self.listOfTextFields objectAtIndex:currentIndex - 1];
    [previousTextField becomeFirstResponder];
  }
}

- (void)didInsertToFullTextField:(SHFixedLengthTextField *)textField {
  [self moveNextOfTextField:textField];
}

- (void)didTapReturnKey:(SHFixedLengthTextField *)textField {
  [self moveNextOfTextField:textField];
}

- (void)textLimitReachedForTextField:(SHFixedLengthTextField *)textField {
  [self moveNextOfTextField:textField];
}

- (void)moveNextOfTextField:(UITextField *)textField {
  NSInteger currentIndex = [self.listOfTextFields indexOfObject:textField];
  if (currentIndex == self.listOfTextFields.count) {
    currentIndex = 0;
  }else {
    currentIndex ++;
  }
  if (currentIndex < self.listOfTextFields.count) {
    SHFixedLengthTextField *nextTextField = [self.listOfTextFields objectAtIndex:currentIndex];
    [nextTextField becomeFirstResponder];
  }
}


@end
