//
//  CodeInputManager.m
//  CodeInputView
//
//  Created by sah-fueled on 16/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "CodeInputDelegateManager.h"
#import "FixedLengthTextField.h"

@interface CodeInputDelegateManager()<FixedLengthTextFieldDelegate>

@property (nonatomic,strong) NSArray *listOfTextFields;

@end

@implementation CodeInputDelegateManager

- (id)initWithTextFields:(NSArray *)textFields {
  self = [super init];
  if (self) {
    _listOfTextFields = [NSArray arrayWithArray:textFields];
    [self.listOfTextFields enumerateObjectsUsingBlock:^(FixedLengthTextField *textField, NSUInteger idx, BOOL *stop) {
      textField.fixedLengthTextFieldDelegate = self;
    }];
  }
  
  return self;
}

- (void)didDeleteFromEmptyTextField:(FixedLengthTextField *)textField {
  NSInteger currentIndex = [self.listOfTextFields indexOfObject:textField];
  if (currentIndex > 0) {
    FixedLengthTextField *previousTextField = [self.listOfTextFields objectAtIndex:currentIndex - 1];
    [previousTextField becomeFirstResponder];
  }
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
  NSInteger currentIndex = [self.listOfTextFields indexOfObject:textField];
  if (currentIndex == self.listOfTextFields.count) {
    currentIndex = 0;
  }else {
    currentIndex ++;
  }
  if (currentIndex < self.listOfTextFields.count) {
    FixedLengthTextField *nextTextField = [self.listOfTextFields objectAtIndex:currentIndex];
    [nextTextField becomeFirstResponder];
  }
}


@end
