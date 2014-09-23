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

@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;

@end
