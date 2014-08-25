//
//  Person.h
//  IPhoneTest_CEBroker
//
//  Created by Arturo Murillo on 8/21/14.
//  Copyright (c) 2014 Arturo Murillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * license;
@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * state;

@end
