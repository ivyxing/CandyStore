//
//  CandyListTableViewController.m
//  Candy Store
//
//  Created by Min Xing on 9/17/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "CandyListTableViewController.h"
#import "CandyDetailViewController.h"
#import "Candy.h"
#import "AppDelegate.h"

@interface CandyListTableViewController ()

@end

@implementation CandyListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _candies = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.candies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CandyCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.candies[indexPath.row] name];
//    cell.imageView.image = [self.candies[indexPath.row] image];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowCandy"]) {
        // Show selected candy.
        CandyDetailViewController *candyDetailViewController = [segue destinationViewController];
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        candyDetailViewController.candy = self.candies[selectedIndexPath.row];
        // Change detail view state to view only.
        candyDetailViewController.state = DetailViewStateReadOnly;
    } else if ([segue.identifier isEqualToString:@"AddCandy"]) {
        // Show add candy detail view.
//        Candy *candy = [Candy new];
        // get access to the managed object context
        NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
        // create a new object using the entity description
        Candy *candy = [NSEntityDescription insertNewObjectForEntityForName:@"Candy" inManagedObjectContext:context];
        CandyDetailViewController *candyDetailViewController = [segue destinationViewController];
        candyDetailViewController.candy = candy;
        // Change detail view state to allow edit.
        candyDetailViewController.state = DetailViewStateReadAndWrite;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.tableView reloadData];
    
    // get access to the managed object context
    NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    // get entity description for entity we are selecting
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Candy" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // create an error variable to pass to the execute method
    NSError *error;
    // retrieve results
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (array == nil) {
        //error handling, e.g. display error to user
    }
    
    self.candies = [array mutableCopy];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the context.
    NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    // Get and delete object
    Candy *candy = [self.candies objectAtIndex:indexPath.row];
    [context deleteObject:candy];
    // create an error variable to pass to the save method
    NSError *error = nil;
    // attempt to save the context and persist our changes
    [context save:&error];
    if (error) {
        //error
    }
    [self.candies removeObjectAtIndex:indexPath.row];
    // Delete entry in the UI.
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
