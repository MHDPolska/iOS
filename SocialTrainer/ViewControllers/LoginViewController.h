//
//  LoginViewController.h
//  SocialTrainer
//
//  Created by Adam Szeptycki on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)userDidTapLoginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *login;

@end
