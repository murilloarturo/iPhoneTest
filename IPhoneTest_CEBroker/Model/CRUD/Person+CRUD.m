//
//  Person+CRUD.m
//  IPhoneTest_CEBroker
//
//  Created by Arturo Murillo on 8/21/14.
//  Copyright (c) 2014 Arturo Murillo. All rights reserved.
//

#import "Person+CRUD.h"
#import "LoginService.h"

@implementation Person (CRUD)

+ (Person *)savePersonWithLicense:(NSString *)license email:(NSString *)email login:(NSString *)login password:(NSString *)password inManagedObjectContext:(NSManagedObjectContext *)context
{
    Person *person = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    request.predicate = [NSPredicate predicateWithFormat:@"license == %@", license];
    
    NSError *error;
    NSArray *persons = [context executeFetchRequest:request error:&error];
    
    if (!persons || error) {
        //show error
    }else if ([persons count]){
        //send tag
        person = [persons firstObject];
    }else {
        person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
        
        person.license = license;
        person.email = email;
        person.login = login;
        person.password = password;
        
        [context save:nil];
    }
    
    [[LoginService sharedClient] loginUser:login password:password];
    return person;
}

+(BOOL)loginAlreadyExists:(NSString *)login orEmail:(NSString *)email inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    request.predicate = [NSPredicate predicateWithFormat:@"login == %@ OR email == %@", login, email];
    
    NSError *error;
    NSArray *persons = [context executeFetchRequest:request error:&error];
    
    if (!persons || error) {
        //show error
        return NO;
    }else if ([persons count]){
        //send tag
        return YES;
    }else {
        return NO;
    }
}

+(BOOL)loginUser:(NSString *)login withPassword:(NSString *)password inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    request.predicate = [NSPredicate predicateWithFormat:@"login == %@ AND password == %@", login, password];
    
    NSError *error;
    NSArray *persons = [context executeFetchRequest:request error:&error];
    
    if (!persons || error) {
        //show error
        return NO;
    }else if ([persons count]){
        //send tag
        return YES;
    }else {
        return NO;
    }
}

@end
