//
//  ChatTableViewController.h
//  Candy Store
//
//  Created by Min Xing on 9/23/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface ChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLSessionDataDelegate>

@property (nonatomic, strong) NSMutableArray *messages;

- (void)addToArrayJSONDictionary:(NSArray *)msgArray;

@end
