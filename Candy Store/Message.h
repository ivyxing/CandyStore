//
//  Message.h
//  Candy Store
//
//  Created by Min Xing on 9/23/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *username;

+ (instancetype)msgWithJSONDictionary:(NSDictionary *)dictionary;
- (NSDictionary*) toDictionary;

@end
