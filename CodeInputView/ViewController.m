//
//  ViewController.m
//  CodeInputView
//
//  Created by hsusmita on 04/06/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "ViewController.h"
#import "CodeInputView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CodeInputView *codeInputView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.codeInputView.numberOfInputBox = 4;
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
