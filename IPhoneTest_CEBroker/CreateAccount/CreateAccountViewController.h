//
//  CreateAccountViewController.h
//  IPhoneTest_CEBroker
//
//  Created by Arturo Murillo on 8/21/14.
//  Copyright (c) 2014 Arturo Murillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccountViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *stateNames;

@end
