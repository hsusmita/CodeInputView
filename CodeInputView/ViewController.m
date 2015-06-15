//
//  ViewController.m
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "ViewController.h"
#import "CodeInputView.h"
#import "RoundedInputField.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CodeInputView *codeInputView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.codeInputView registerNibWithName:NSStringFromClass([RoundedInputField class])];
  [self.codeInputView configureWithBoxCount:5 withBoxSize:CGSizeMake(60, 60)];
//  [self.codeInputView configureWithBoxCount:4 withInset:UIEdgeInsetsMake(10, 10, 10, 10) withInterBoxSpace:10];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
