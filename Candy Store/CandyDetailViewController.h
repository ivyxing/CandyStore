//
//  CandyDetailViewController.h
//  Candy Store
//
//  Created by Min Xing on 9/17/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DetailViewState) {
    DetailViewStateReadOnly,
    DetailViewStateReadAndWrite
};

@class Candy;

@interface CandyDetailViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) Candy *candy;
@property (nonatomic, assign) DetailViewState state;

@end
