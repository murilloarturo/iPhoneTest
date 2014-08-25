//
//  Person+CRUD.h
//  IPhoneTest_CEBroker
//
//  Created by Arturo Murillo on 8/21/14.
//  Copyright (c) 2014 Arturo Murillo. All rights reserved.
//

#import "Person.h"

@interface Person (CRUD)

+ (Person *)savePersonWithLicense:(NSString *)license email:(NSString *)email login:(NSString *)login password:(NSString *)password inManagedObjectContext:(NSManagedObjectContext *)context;

+(BOOL)loginAlreadyExists:(NSString *)login orEmail:(NSString *)email inManagedObjectContext:(NSManagedObjectContext *)context;

+(BOOL)loginUser:(NSString *)login withPassword:(NSString *)password inManagedObjectContext:(NSManagedObjectContext *)context;

@end
