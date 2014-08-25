//
//  LoginService.m
//  IPhoneTest_CEBroker
//
//  Created by Arturo Murillo on 8/21/14.
//  Copyright (c) 2014 Arturo Murillo. All rights reserved.
//

#import "LoginService.h"
#import "Person+CRUD.h"
#import "CoreDataController.h"

@implementation LoginService

+ (instancetype)sharedClient
{
    static LoginService *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[LoginService alloc] init];
    });
    
    return sharedClient;
}

- (NSString *)login
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"login_user"];
}

- (void)setLogin:(NSString*)login
{
    [[NSUserDefaults standardUserDefaults] setValue:login forKey:@"login_user"];
}

- (NSString *)password
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"password_user"];
}

- (void)setPassword:(NSString*)password
{
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password_user"];
}

- (BOOL)authenticated
{
    //NSLog(@"username %@ password %@", [self username], [self password]);
    
    return [self login] && [self password];
}

- (void)loginUser:(NSString *)login password:(NSString *)password
{
    if ([Person loginUser:login withPassword:password inManagedObjectContext:[[CoreDataController sharedInstance] mainManagedObjectContext]]) {
        [self setLogin:login];
        [self setPassword:password];
    }
}

- (void)logout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login_user"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password_user"];
}

@end
