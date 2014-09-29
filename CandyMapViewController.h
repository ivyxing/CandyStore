//
//  CandyMapViewController.h
//  Candy Store
//
//  Created by Min Xing on 9/17/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class Candy;

typedef NS_ENUM(NSInteger, CandyMapViewControllerViewState) {
    CandyMapViewControllerViewStateReadOnly,
    CandyMapViewControllerViewStateEdit
};

@interface CandyMapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) CandyMapViewControllerViewState viewState;
@property (strong, nonatomic) Candy *candy;

@end
