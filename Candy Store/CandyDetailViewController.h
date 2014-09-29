//
//  CandyDetailViewController.h
//  Candy Store
//
//  Created by Min Xing on 9/17/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Candy;

typedef NS_ENUM(NSInteger, CandyDetailViewControllerViewState) {
    CandyDetailViewControllerViewStateReadOnly,
    CandyDetailViewControllerViewStateEdit
};


@interface CandyDetailViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) Candy *candy;
@property (assign, nonatomic) CandyDetailViewControllerViewState state;

@end
