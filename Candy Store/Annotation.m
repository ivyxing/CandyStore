//
//  Annotation.m
//  Candy Store
//
//  Created by Min Xing on 9/21/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title {
    if ((self = [super init])) {
        self.coordinate = coordinate;
        self.title = title;
    }
    return self;
}

@end