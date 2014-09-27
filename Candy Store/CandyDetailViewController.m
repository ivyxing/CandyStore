//
//  CandyDetailViewController.m
//  Candy Store
//
//  Created by Min Xing on 9/17/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "CandyDetailViewController.h"
#import "CandyMapViewController.h"
#import "CandyEnlargedImageViewController.h"
#import "Candy.h"
#import "AppDelegate.h"

@interface CandyDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *choosePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *imageAsButton;

@property (nonatomic, retain) UIImagePickerController *imgPicker;

@end

@implementation CandyDetailViewController
@synthesize imgPicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nameTextField setDelegate:self];
    
    // Initialize the image picker.
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.allowsEditing = YES;
    self.imgPicker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.nameTextField.text = self.candy.name;
    
    if (self.state == DetailViewStateReadOnly) {
        UIImage *img = [[UIImage alloc] initWithData:self.candy.imageData];
        [self.imageAsButton setBackgroundImage:img forState:UIControlStateNormal];
        [self.mapButton setTitle:@"Show on Map" forState:UIControlStateNormal];
    } else if (self.state == DetailViewStateReadAndWrite) {
        [self.mapButton setTitle:@"Pin on Map" forState:UIControlStateNormal];
    }
}

#pragma mark - User Interaction

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameTextField resignFirstResponder];
    return YES;
}

#pragma mark - Image Handling

- (IBAction)imagePressed:(id)sender {
    if (self.imageAsButton.currentBackgroundImage) {
        [self performSegueWithIdentifier:@"EnlargeImage" sender:sender];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EnlargeImage"]) {
        CandyEnlargedImageViewController *enlargedImageViewController = segue.destinationViewController;
        enlargedImageViewController.image = self.imageAsButton.currentBackgroundImage;
    }
}
        
- (IBAction)choosePhoto:(id)sender {
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imgPicker animated:YES completion:nil];
}

- (IBAction)takePhoto:(id)sender {
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imgPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
    [self.imageAsButton setBackgroundImage:img forState:UIControlStateNormal];
    self.candy.imageData = UIImagePNGRepresentation(img);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Map Handling

- (IBAction)mapButtonPressed:(id)sender {
    if (self.state == DetailViewStateReadOnly) {
        // Show candy location on map.
    } else if (self.state ==  DetailViewStateReadAndWrite) {
        // Let user pin location on map.
    }
}

#pragma mark - Save Changes

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Save candy name and image.
    self.candy.name = self.nameTextField.text;
    UIImage *img = self.imageAsButton.currentBackgroundImage;
    self.candy.imageData = UIImagePNGRepresentation(img);
    
    // Get the NSManagedObject context.
    NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    // Create an error variable to pass to the save method.
    NSError *error = nil;
    // Attempt to save the context and persist our changes.
    [context save:&error];
    if (error) {
        // Error handling, e.g. display error to user.
    }
}

@end
