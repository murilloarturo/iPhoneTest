//
//  LoginService.h
//  IPhoneTest_CEBroker
//
//  Created by Arturo Murillo on 8/21/14.
//  Copyright (c) 2014 Arturo Murillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginService : NSObject

+ (instancetype)sharedClient;

- (NSString *)login;

- (NSString *)password;

- (BOOL)authenticated;

- (void)loginUser:(NSString *)login password:(NSString *)password;

- (void)logout;

@end
