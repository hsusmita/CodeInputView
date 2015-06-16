//
//  CodeInputView.m
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "SHCodeInputView.h"
#import "SHFixedLengthTextField.h"
#import "SHCodeInputDelegateManager.h"

@interface SHCodeInputView()

@property (nonatomic, assign) NSInteger numberOfInputBox;
@property (nonatomic, assign) NSInteger characterLimit;
@property (nonatomic, strong) NSString *nibNameForTextField;
@property (nonatomic, assign) CGSize boxSize;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGFloat interBoxSpace;
@property (nonatomic, strong) SHCodeInputDelegateManager *codeInputManager;

@end

@implementation SHCodeInputView

#pragma mark - Public methods

- (void)registerNibWithName:(NSString *)nibName {
  self.nibNameForTextField = nibName;
}

- (void)configureWithBoxCount:(NSInteger)numberOfInputBox
           withCharacterLimit:(NSInteger)limit
                  withBoxSize:(CGSize)boxSize {
  [self layoutIfNeeded];
  self.numberOfInputBox = numberOfInputBox;
  self.boxSize = boxSize;
  self.characterLimit = limit;

  NSMutableArray *arrayOfTextFields = [NSMutableArray new];
  for (int i = 0 ; i < self.numberOfInputBox ; i++) {
    SHFixedLengthTextField *textField = [self createTextField];
    [self addSubview:textField];
    [arrayOfTextFields addObject:textField];
  }
  
  self.codeInputManager = [[SHCodeInputDelegateManager alloc]initWithTextFields:arrayOfTextFields];
}

- (void)configureWithBoxCount:(NSInteger)numberOfInputBox
           withCharacterLimit:(NSInteger)limit
                    withInset:(UIEdgeInsets)insets
            withInterBoxSpace:(CGFloat)space {
  [self layoutIfNeeded];
  self.numberOfInputBox = numberOfInputBox;
  self.insets = insets;
  self.interBoxSpace = space;
  self.characterLimit = limit;

  NSMutableArray *arrayOfTextFields = [NSMutableArray new];
  for (int i = 0 ; i < self.numberOfInputBox ; i++) {
    SHFixedLengthTextField *textField = [self createTextField];
    [self addSubview:textField];
    [arrayOfTextFields addObject:textField];
  }
  
  self.codeInputManager = [[SHCodeInputDelegateManager alloc]initWithTextFields:arrayOfTextFields];
}

- (NSString *)codeString {
  __block NSString *finalString = @"";
  [self.codeInputManager.listOfTextFields enumerateObjectsUsingBlock:^(SHFixedLengthTextField *textField, NSUInteger idx, BOOL *stop) {
    finalString = [finalString stringByAppendingString:textField.text];
  }];
  
  return finalString;
}

#pragma mark - Override superclass methods

- (void)layoutSubviews {
  [super layoutSubviews];
  if (!CGSizeEqualToSize(self.boxSize, CGSizeZero)) {
    [self updateTextFieldFrameForBoxSize:self.boxSize];
  }else {
    [self updateTextFieldFrameForInset:self.insets andInterBoxSpace:self.interBoxSpace];
  }
}

#pragma mark - Private methods

- (SHFixedLengthTextField *)createTextField {
  SHFixedLengthTextField *textfield;
  if (self.nibNameForTextField.length == 0) {
    textfield = [[SHFixedLengthTextField alloc]init];
    textfield.backgroundColor = [UIColor grayColor];
  }else {
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:self.nibNameForTextField owner:self options:nil];
    if ([array.firstObject isKindOfClass:[SHFixedLengthTextField class]]) {
      textfield = (SHFixedLengthTextField *) (array.firstObject);
    }else {
      NSAssert(@"No subclass of FixedLengthTextField found", @"");
    }
  }
  [self addSubview:textfield];
  textfield.maximumCharacterLimit = self.characterLimit;
  return textfield;
}

- (void)updateTextFieldFrameForBoxSize:(CGSize)boxSize {
  CGFloat horizontalSpacing = (self.frame.size.width - (self.numberOfInputBox * boxSize.width)) / (self.numberOfInputBox + 1);
  CGFloat verticalSpacing = (self.frame.size.height - boxSize.height)/2;
  [self.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
    if ([view isKindOfClass:[SHFixedLengthTextField class]]) {
      view.frame = CGRectMake(horizontalSpacing + idx * (boxSize.width + horizontalSpacing), verticalSpacing, boxSize.width, boxSize.height);
    }
  }];
}

- (void)updateTextFieldFrameForInset:(UIEdgeInsets)insets andInterBoxSpace:(CGFloat)space {
  CGFloat interSpaceDistance = (self.numberOfInputBox - 1) * space;
  CGFloat width = (self.frame.size.width - interSpaceDistance - insets.left - insets.right)/(self.numberOfInputBox);
  CGFloat height = self.frame.size.height - (insets.top + insets.bottom);
  [self.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
    if ([view isKindOfClass:[SHFixedLengthTextField class]]) {
      view.frame = CGRectMake(idx * (width+space) + insets.left, insets.top, width, height);
    }
  }];
}

@end
