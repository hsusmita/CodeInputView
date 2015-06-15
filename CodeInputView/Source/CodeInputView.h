//
//  CodeInputView.h
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeInputView : UIView

- (void)configureWithBoxCount:(NSInteger)numberOfInputBox withBoxSize:(CGSize)boxSize;
- (void)configureWithBoxCount:(NSInteger)numberOfInputBox withInset:(UIEdgeInsets)insets withInterBoxSpace:(CGFloat)space;
- (void)registerNibWithName:(NSString *)nibName;

@end
