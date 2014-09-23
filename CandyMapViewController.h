//
//  CandyMapViewController.h
//  Candy Store
//
//  Created by Min Xing on 9/17/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Candy.h"

typedef NS_ENUM(NSInteger, MapState) {
    MapStateView,
    MapStateEdit
};

@interface CandyMapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) MapState mapState;
@property (nonatomic, strong) Candy *candy;

@end
