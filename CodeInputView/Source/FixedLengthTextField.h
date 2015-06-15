//
//  FixedLengthTextField.h
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FixedLengthTextFieldDelegate;

@interface FixedLengthTextField : UITextField  <UIKeyInput>

@property (nonatomic,assign) NSInteger maximumCharacterLimit;
@property (nonatomic,weak) id<FixedLengthTextFieldDelegate> fixedLengthTextFieldDelegate;

@end

@protocol FixedLengthTextFieldDelegate <NSObject>

- (void)didDeleteFromEmptyTextField:(FixedLengthTextField *)textField;
- (void)didInsertToFullTextField:(FixedLengthTextField *)textField;
- (void)textLimitReachedForTextField:(FixedLengthTextField *)textField;
- (void)didTapReturnKey:(FixedLengthTextField *)textField;

@end

