//
//  ChatTableViewController.h
//  Candy Store
//
//  Created by Min Xing on 9/23/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLSessionDataDelegate>

@property (strong, nonatomic) NSMutableArray *messages;

- (void)addToArrayJSONDictionary:(NSArray *)msgArray;

@end
