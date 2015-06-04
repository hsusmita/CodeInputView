//
//  CodeInputView.m
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "CodeInputView.h"
#import "CodeInputCell.h"
#import "FixedLengthTextField.h"

@interface CodeInputView() <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIBarPositioningDelegate,FixedLengthTextFieldDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UICollectionView *codeCollectionView;

@end

@implementation CodeInputView

- (void)awakeFromNib {
  [self configureCodeInputView];
}

- (void)configureCodeInputView {
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
  self.codeCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
  self.codeCollectionView.dataSource = self;
  self.codeCollectionView.delegate = self;
  self.codeCollectionView.backgroundColor = [UIColor grayColor];
  [self.codeCollectionView registerClass:[CodeInputCell class] forCellWithReuseIdentifier:@"codeInputCell"];
  [self addSubview:self.codeCollectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.numberOfInputBox;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"codeInputCell" forIndexPath:indexPath];
  cell.backgroundColor = [UIColor blackColor];
  FixedLengthTextField *textField = [[FixedLengthTextField alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
  textField.fixedLengthTextFieldDelegate = self;
  textField.keyboardType = UIKeyboardTypeNumberPad;
  textField.backgroundColor = [UIColor lightGrayColor];
  textField.maximumCharacterLimit = 1;
  textField.textAlignment = NSTextAlignmentCenter;
  textField.delegate = self;
  [cell addSubview:textField];
  textField.tag = indexPath.row + 1;
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(60, 60);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 20;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)didDeleteFromEmptyTextField:(FixedLengthTextField *)textField {
  NSInteger currentIndex = textField.tag;
  FixedLengthTextField *previousTextField = (FixedLengthTextField *)[self viewWithTag:(currentIndex - 1)%4];
  [previousTextField becomeFirstResponder];
}

- (void)didInsertToFullTextField:(FixedLengthTextField *)textField {
  NSInteger currentIndex = textField.tag;
  if (currentIndex == 4) {
    currentIndex = 0;
  }else {
    currentIndex ++;
  }
  FixedLengthTextField *nextTextField = (FixedLengthTextField *)[self viewWithTag:currentIndex];
  [nextTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  NSInteger currentIndex = textField.tag;
  if (currentIndex == 4) {
    currentIndex = 0;
  }else {
    currentIndex ++;
  }
  FixedLengthTextField *nextTextField = (FixedLengthTextField *)[self viewWithTag:currentIndex];
  [nextTextField becomeFirstResponder];
  
  return YES;
}

- (void)textLimitReachedForTextField:(FixedLengthTextField *)textField {
  NSInteger currentIndex = textField.tag;
  if (currentIndex == 4) {
    currentIndex = 0;
  }else {
    currentIndex ++;
  }
  FixedLengthTextField *nextTextField = (FixedLengthTextField *)[self viewWithTag:currentIndex];
  [nextTextField becomeFirstResponder];
}

@end
