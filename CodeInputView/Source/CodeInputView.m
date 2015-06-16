//
//  CodeInputView.m
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "CodeInputView.h"
#import "FixedLengthTextField.h"
#import "CodeInputDelegateManager.h"

@interface CodeInputView()

@property (nonatomic, assign) NSInteger numberOfInputBox;
@property (nonatomic, strong) NSString *nibNameForTextField;
@property (nonatomic, assign) CGSize boxSize;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGFloat interBoxSpace;
@property (nonatomic, strong) CodeInputDelegateManager *codeInputManager;

@end

@implementation CodeInputView

- (void)layoutSubviews {
  [super layoutSubviews];
  if (!CGSizeEqualToSize(self.boxSize, CGSizeZero)) {
    [self updateTextFieldFrameForBoxSize:self.boxSize];
  }else {
    [self updateTextFieldFrameForInset:self.insets andInterBoxSpace:self.interBoxSpace];
  }
}

- (void)registerNibWithName:(NSString *)nibName {
  self.nibNameForTextField = nibName;
}

- (void)configureWithBoxCount:(NSInteger)numberOfInputBox withBoxSize:(CGSize)boxSize {
  [self layoutIfNeeded];
  self.numberOfInputBox = numberOfInputBox;
  self.boxSize = boxSize;
  NSMutableArray *arrayOfTextFields = [NSMutableArray new];
  for (int i = 0 ; i < self.numberOfInputBox ; i++) {
    FixedLengthTextField *textField = [self createTextField];
    [self addSubview:textField];
    [arrayOfTextFields addObject:textField];
  }
  self.codeInputManager = [[CodeInputDelegateManager alloc]initWithTextFields:arrayOfTextFields];
}

- (void)configureWithBoxCount:(NSInteger)numberOfInputBox withInset:(UIEdgeInsets)insets withInterBoxSpace:(CGFloat)space {
  [self layoutIfNeeded];
  self.numberOfInputBox = numberOfInputBox;
  self.insets = insets;
  self.interBoxSpace = space;
  NSMutableArray *arrayOfTextFields = [NSMutableArray new];
  for (int i = 0 ; i < self.numberOfInputBox ; i++) {
    FixedLengthTextField *textField = [self createTextField];
    [self addSubview:textField];
    [arrayOfTextFields addObject:textField];
  }
  self.codeInputManager = [[CodeInputDelegateManager alloc]initWithTextFields:arrayOfTextFields];
}

- (void)updateTextFieldFrameForBoxSize:(CGSize)boxSize {
  CGFloat horizontalSpacing = (self.frame.size.width - (self.numberOfInputBox * boxSize.width)) / (self.numberOfInputBox + 1);
  CGFloat verticalSpacing = (self.frame.size.height - boxSize.height)/2;
  [self.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
    if ([view isKindOfClass:[FixedLengthTextField class]]) {
      view.frame = CGRectMake(horizontalSpacing + idx * (boxSize.width + horizontalSpacing), verticalSpacing, boxSize.width, boxSize.height);
    }
  }];
}

- (void)updateTextFieldFrameForInset:(UIEdgeInsets)insets andInterBoxSpace:(CGFloat)space {
  CGFloat interSpaceDistance = (self.numberOfInputBox - 1) * space;
  CGFloat width = (self.frame.size.width - interSpaceDistance - insets.left - insets.right)/(self.numberOfInputBox);
  CGFloat height = self.frame.size.height - (insets.top + insets.bottom);
  [self.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
    if ([view isKindOfClass:[FixedLengthTextField class]]) {
      view.frame = CGRectMake(idx * (width+space) + insets.left, insets.top, width, height);
    }
  }];
}

- (FixedLengthTextField *)createTextField {
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
  [self addSubview:textfield];
  textfield.maximumCharacterLimit = 1;
  return textfield;
}

@end
