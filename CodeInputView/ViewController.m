//
//  ViewController.m
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "ViewController.h"
#import "SHCodeInputView.h"
#import "RoundedInputField.h"
#import "SHCodeInputDelegateManager.h"
#import "SHFixedLengthTextField.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet SHCodeInputView *codeInputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet SHFixedLengthTextField *firstField;
@property (weak, nonatomic) IBOutlet SHFixedLengthTextField *secondField;
@property (weak, nonatomic) IBOutlet SHFixedLengthTextField *thirdField;
@property (weak, nonatomic) IBOutlet SHFixedLengthTextField *fourthField;
@property (strong, nonatomic) SHCodeInputDelegateManager *codeInputManager;


@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
// self.codeInputManager = [[CodeInputManager alloc]initWithTextFields:@[self.firstField,self.secondField,self.thirdField,self.fourthField]];
  [self.codeInputView registerNibWithName:NSStringFromClass([RoundedInputField class])];
//  [self.codeInputView configureWithBoxCount:5 withCharacterLimit:2 withBoxSize:CGSizeMake(60, 60)];
  [self.codeInputView configureWithBoxCount:5 withCharacterLimit:2 withInset:UIEdgeInsetsMake(10, 10, 10, 10) withInterBoxSpace:20];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)updateHeight:(id)sender {
  NSLog(@"The code is = %@",self.codeInputView.codeString);
  
}
- (IBAction)adjustConstraint:(UIStepper*)stepper {
  self.heightConstraint.constant = stepper.value;
  
}

@end
