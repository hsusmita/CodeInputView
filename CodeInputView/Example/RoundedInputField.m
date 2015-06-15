//
//  RoundedInputField.m
//  CodeInputView
//
//  Created by sah-fueled on 15/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "RoundedInputField.h"

@implementation RoundedInputField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  self.layer.cornerRadius = self.frame.size.width/2;
  self.layer.masksToBounds = YES;
}

@end
