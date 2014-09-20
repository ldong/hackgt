//
//  OAuthControllerViewController.m
//  FlySwatter
//
//  Created by Lin Dong on 9/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

#import "OAuthControllerViewController.h"

@interface OAuthControllerViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation OAuthControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)resetUsernameNPassword:(id)sender {
  [[self usernameField] setText: @"john@gmail.com"];
  [[self passwordField] setText: @"********"];
}

- (IBAction)login:(id)sender {
  // getting data
  NSLog(@"username: %@", [[self usernameField] text]);
  NSLog(@"password: %@", [[self passwordField] text]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
