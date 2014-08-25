//
//  CoreDataController.h
//  IPhoneTest_CEBroker
//
//  Created by Arturo Murillo on 8/21/14.
//  Copyright (c) 2014 Arturo Murillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataController : NSObject

+ (id)sharedInstance;

- (NSManagedObjectContext *)mainManagedObjectContext;
- (void)saveMainContext;

@end
