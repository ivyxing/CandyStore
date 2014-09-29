//
//  Entity.h
//  Candy Store
//
//  Created by Min Xing on 9/23/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Candy : NSManagedObject

@property (strong, nonatomic) NSData * imageData;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSNumber * latitude;
@property (strong, nonatomic) NSNumber * longitude;

@end
