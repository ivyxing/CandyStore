//
//  ChatTableViewController.m
//  Candy Store
//
//  Created by Min Xing on 9/23/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "ChatViewController.h"
#import "Message.h"

@interface ChatViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.messages = [NSMutableArray array];
}

#pragma mark - User Interaction

- (IBAction)sendMessage:(id)sender {
    Message *msg = [Message new];
    msg.username = @"Test-ReturnButton";
    msg.content = self.textField.text;
    [self sendMessageToServer:[msg messageToJSONDictionary]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Hide keyboard.
    [self.textField resignFirstResponder];
    // Store message attributes and send message.
    Message *msg = [Message new];
    msg.username = @"Test-ReturnButton";
    msg.content = textField.text;
    [self sendMessageToServer:[msg messageToJSONDictionary]];
    return YES;
}

#pragma mark - Server communication

- (void)sendMessageToServer:(NSDictionary*)dictionary {
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/collections/test"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    
    // Convert dictionary to NSData.
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];

    [request setHTTPBody:jsonData];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession
                                sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        if (responseStatusCode == 200 && data) {
            NSArray *downloadedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self addToArrayJSONDictionary:downloadedJSON];
        } else {
            // error handling
        }
    }];
    
    [dataTask resume];
}

- (void)addToArrayJSONDictionary:(NSArray *)msgArray {
    for (NSDictionary *jsonMsg in msgArray) {
        Message *msg = [Message messageWithJSONDictionary:jsonMsg];
        [self.messages insertObject:msg atIndex:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (void)viewWillAppear:(BOOL)animated {
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/collections/test"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession
                                sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        if (responseStatusCode == 200 && data) {
            NSArray *downloadedJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0 error:nil];
            [self addToArrayJSONDictionary:downloadedJSON];
        } else {
            // error handling
        }
    }];
    
    [dataTask resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text = [self.messages[indexPath.row] content];
    
    return cell;
}

@end
