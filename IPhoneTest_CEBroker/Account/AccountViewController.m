//
//  AccountViewController.m
//  IPhoneTest_CEBroker
//
//  Created by Arturo Murillo on 8/21/14.
//  Copyright (c) 2014 Arturo Murillo. All rights reserved.
//

#import "AccountViewController.h"
#import "Constants.h"

#import "LoginService.h"

#define kIncrementToConstraint 327

@interface AccountViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *barButtons;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *popupView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *backgroundViews;
@property CGFloat originalConstant;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation AccountViewController

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
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([[LoginService sharedClient] authenticated]) {
        self.originalConstant = self.bottomHeightConstraint.constant;
        
        self.usernameLabel.text = [[LoginService sharedClient] login];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender
{
    [[LoginService sharedClient] logout];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)openView:(id)sender
{
    if (self.bottomHeightConstraint.constant == self.originalConstant) {
        self.bottomHeightConstraint.constant -= kIncrementToConstraint;
        
        [self.arrowImageView setImage:[UIImage imageNamed:arrowDownImage]];
        
        [UIView animateWithDuration:0.5f
                         animations:^{
                             [[self.backgroundViews firstObject] setAlpha:0.5f];
                             [[self.backgroundViews lastObject] setAlpha:0.5f];
                         }
         ];
        
    }else{
        self.bottomHeightConstraint.constant += kIncrementToConstraint;
        
        [self.arrowImageView setImage:[UIImage imageNamed:arrowUpImage]];
        
        [UIView animateWithDuration:0.5f
                         animations:^{
                             [[self.backgroundViews firstObject] setAlpha:1];
                             [[self.backgroundViews lastObject] setAlpha:1];
                         }
         ];
    }
    
    [self.popupView setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:5 animations:^{
        [self.popupView layoutIfNeeded];
    }];
}

- (IBAction)selectBarButton:(id)sender
{
    if (![sender isSelected]) {
        for (UIButton *button in self.barButtons) {
            [button setSelected:NO];
        }
        
        [sender setSelected:YES];
    }
}
- (IBAction)upgradeNow:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Notification", nil)
                                                    message:@"You will be redirected to the AppStore where you can upgrade your Account"
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                          otherButtonTitles:NSLocalizedString(@"Ok", nil),  nil];
    alert.tag = 1;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        NSLog(@"Nothing to do here");
    }else{
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://itunes.apple.com/en/app/ce-broker/id384461998?mt=8"]];
    }
}

@end
