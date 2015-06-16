//
//  CodeInputView.h
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCodeInputView : UIView

- (void)configureWithBoxCount:(NSInteger)numberOfInputBox
           withCharacterLimit:(NSInteger)limit
                  withBoxSize:(CGSize)boxSize;
- (void)configureWithBoxCount:(NSInteger)numberOfInputBox
           withCharacterLimit:(NSInteger)limit
                    withInset:(UIEdgeInsets)insets
            withInterBoxSpace:(CGFloat)space;
- (void)registerNibWithName:(NSString *)nibName;
- (NSString *)codeString;

@end
