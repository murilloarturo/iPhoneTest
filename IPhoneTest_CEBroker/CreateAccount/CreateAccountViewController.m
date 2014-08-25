//
//  CreateAccountViewController.m
//  IPhoneTest_CEBroker
//
//  Created by Arturo Murillo on 8/21/14.
//  Copyright (c) 2014 Arturo Murillo. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "CoreDataController.h"
#import "Person+CRUD.h"
#import "Constants.h"

#import "CustomTextField.h"

#define KEYBOARD_OFFSET 70.0

@interface CreateAccountViewController ()

@property (weak, nonatomic) IBOutlet UILabel *selectedState;
@property (weak, nonatomic) IBOutlet UIPickerView *statePickerView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (weak, nonatomic) IBOutlet CustomTextField *licenseTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *emailTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *loginTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *confirmPasswordTextField;

@property (weak, nonatomic) IBOutlet UILabel *passwordConfirmationLabel;
@end

@implementation CreateAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stateNames = [NSArray arrayWithObjects:@"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming", nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    
    NSLog(@"Frame origin Y %f", self.view.frame.origin.y);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (IBAction)closeViewController:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)selectState:(id)sender
{
    if ([self.statePickerView isHidden]) {
        [self.arrowImageView setImage:[UIImage imageNamed:arrowUpImage]];
    }else{
        [self.arrowImageView setImage:[UIImage imageNamed:arrowDownImage]];
    }
    
    [self.statePickerView setHidden:![self.statePickerView isHidden]];
}

- (IBAction)submit:(id)sender
{
    if ([self.selectedState.text isEqualToString:@"State"]) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                    message:NSLocalizedString(@"You have to select one state...", nil)
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }else if(self.licenseTextField.text.length == 0){
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                    message:NSLocalizedString(@"License cannot be empty...", nil)
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }else if(self.emailTextField.text.length == 0){
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                    message:NSLocalizedString(@"Email cannot be empty...", nil)
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }else if(self.loginTextField.text.length == 0){
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                    message:NSLocalizedString(@"Login cannot be empty...", nil)
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }else if(self.passwordTextField.text.length == 0){
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                    message:NSLocalizedString(@"Password cannot be empty...", nil)
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }else if(self.confirmPasswordTextField.text.length == 0){
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                    message:NSLocalizedString(@"Confirm your password...", nil)
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }else if([Person loginAlreadyExists:self.loginTextField.text orEmail:self.emailTextField.text inManagedObjectContext:[[CoreDataController sharedInstance] mainManagedObjectContext]]){
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                    message:NSLocalizedString(@"There's already an user with this login/email try again...", nil)
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }else{
        [Person savePersonWithLicense:self.licenseTextField.text email:self.emailTextField.text login:self.loginTextField.text password:self.passwordTextField.text inManagedObjectContext:[[CoreDataController sharedInstance] mainManagedObjectContext]];
        
        [self performSegueWithIdentifier:@"ShowNewUser" sender:self];
    }
}

#pragma mark util methods



#pragma mark UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)keyboardWillShow
{
    [self setViewMovedUp:YES];
}

-(void)keyboardWillHide
{
    [self setViewMovedUp:NO];
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if  (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

- (IBAction)confirmPasswordChanged:(id)sender
{
    UITextField *textfield = (UITextField *)sender;
    
    [self.passwordConfirmationLabel setHidden:[self.passwordTextField.text isEqualToString:textfield.text]];
}


//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= KEYBOARD_OFFSET;
        rect.size.height += KEYBOARD_OFFSET;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += KEYBOARD_OFFSET;
        rect.size.height -= KEYBOARD_OFFSET;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

#pragma mark UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.stateNames count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.stateNames objectAtIndex:row];
}

#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    [self.selectedState setText:[self.stateNames objectAtIndex:row]];
}

@end
