//
//  FixedLengthTextField.h
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SHFixedLengthTextFieldDelegate;

IB_DESIGNABLE

@interface SHFixedLengthTextField : UITextField  <UIKeyInput>

@property (nonatomic,assign) IBInspectable NSInteger maximumCharacterLimit;
@property (nonatomic,weak) id<SHFixedLengthTextFieldDelegate> fixedLengthTextFieldDelegate;

@end

@protocol SHFixedLengthTextFieldDelegate <NSObject>

- (void)didDeleteFromEmptyTextField:(SHFixedLengthTextField *)textField;
- (void)didInsertToFullTextField:(SHFixedLengthTextField *)textField;
- (void)textLimitReachedForTextField:(SHFixedLengthTextField *)textField;
- (void)didTapReturnKey:(SHFixedLengthTextField *)textField;

@end

