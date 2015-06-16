//
//  CodeInputManager.h
//  CodeInputView
//
//  Created by sah-fueled on 16/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHCodeInputDelegateManager : NSObject

@property (nonatomic,strong) NSArray *listOfTextFields;

- (id)initWithTextFields:(NSArray *)textFields;

@end
