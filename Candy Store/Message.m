//
//  Message.m
//  Candy Store
//
//  Created by Min Xing on 9/23/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (instancetype)msgWithJSONDictionary:(NSDictionary *)dictionary {
    Message *msg = [Message new];
    msg.username = dictionary[@"username"];
    msg.content = dictionary[@"content"];

    return msg;
}
- (NSDictionary*) toDictionary {
    NSDictionary* newDic = @{@"username":self.username, @"content":self.content};
    return newDic;
}

@end
