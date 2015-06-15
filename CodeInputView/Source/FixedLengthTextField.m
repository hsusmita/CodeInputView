//
//  FixedLengthTextField.m
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "FixedLengthTextField.h"

@implementation FixedLengthTextField

- (void)deleteBackward {
  [super deleteBackward];
  if (self.text.length == 0) {
    if ([self.fixedLengthTextFieldDelegate respondsToSelector:@selector(didDeleteFromEmptyTextField:)]) {
      [self.fixedLengthTextFieldDelegate didDeleteFromEmptyTextField:self];
    }
  }
}

- (void)insertText:(NSString *)text {
  [super insertText:text];
  if ([text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location != NSNotFound) {
    if ([self.fixedLengthTextFieldDelegate respondsToSelector:@selector(didTapReturnKey:)]) {
      [self.fixedLengthTextFieldDelegate didTapReturnKey:self];
    }
  }
  self.text = [[self.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
 [self truncateCharactersIfRequired];
}

- (void)paste:(id)sender {
  [super paste:sender];
  [self truncateCharactersIfRequired];
}

- (void)truncateCharactersIfRequired {
  if (self.text.length == self.maximumCharacterLimit) {
    if ([self.fixedLengthTextFieldDelegate respondsToSelector:@selector(textLimitReachedForTextField:)]) {
      [self.fixedLengthTextFieldDelegate textLimitReachedForTextField:self];
    }
  }else if (self.text.length > self.maximumCharacterLimit) {
    NSString *string = [self.text substringWithRange:NSMakeRange(0, self.maximumCharacterLimit)];
    self.text = string;
    if ([self.fixedLengthTextFieldDelegate respondsToSelector:@selector(didInsertToFullTextField:)]) {
      [self.fixedLengthTextFieldDelegate didInsertToFullTextField:self];
    }
  }
}


@end
