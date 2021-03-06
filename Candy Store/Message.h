//
//  Message.h
//  Candy Store
//
//  Created by Min Xing on 9/23/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *username;

+ (instancetype) messageWithJSONDictionary:(NSDictionary *)dictionary;
- (NSDictionary*) messageToJSONDictionary;

@end
