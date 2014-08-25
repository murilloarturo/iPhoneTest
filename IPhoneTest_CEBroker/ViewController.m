//
//  ViewController.m
//  IPhoneTest_CEBroker
//
//  Created by Arturo Murillo on 8/21/14.
//  Copyright (c) 2014 Arturo Murillo. All rights reserved.
//

#import "ViewController.h"
#import "Person+CRUD.h"
#import "LoginService.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.loginTextField.text = @"";
    self.passwordTextField.text = @"";
    
    [self.loginTextField setAlpha:0];
    [self.passwordTextField setAlpha:0];
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)accessAccount:(id)sender
{
        [UIView animateWithDuration:0.5f
                         animations:^{
                             [self.loginTextField setAlpha:1];
                             [self.passwordTextField setAlpha:1];
                         }
         ];
}

- (IBAction)login:(id)sender
{
    [sender resignFirstResponder];
    
    if (self.loginTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                    message:NSLocalizedString(@"Login cannot be empty...", nil)
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }else if (self.passwordTextField.text.length == 0){
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                    message:NSLocalizedString(@"Password cannot be empty...", nil)
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }else{
        [[LoginService sharedClient] loginUser:self.loginTextField.text password:self.passwordTextField.text];
        
        [self performSegueWithIdentifier:@"ShowUser" sender:self];
    }
}


@end
