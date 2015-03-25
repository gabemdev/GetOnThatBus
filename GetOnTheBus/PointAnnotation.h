//
//  BusStopPointAnnotation.h
//  GetOnTheBus
//
//  Created by Rockstar. on 3/24/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface PointAnnotation : MKPointAnnotation
/*
 Steps for Adding an Annotation to the Map
 The steps for implementing and using annotations in your map-based app are shown below. It’s assumed that your app incorporates an MKMapView object somewhere in its interface.

 Define an appropriate annotation object using one of the following options:
 Use the MKPointAnnotation class to implement a simple annotation. This type of annotation contains properties for specifying the title and subtitle strings to display in the annotation’s callout bubble.
 Define a custom object that conforms to the MKAnnotation protocol, as described in Defining a Custom Annotation Object. A custom annotation can store any type of data you want.
 Define an annotation view to present the annotation data on screen. How you define your annotation view depends on your needs and may be one of the following:
 If you want to use a standard pin annotation, create an instance of the MKPinAnnotationView class; see Using the Standard Annotation Views.
 If the annotation can be represented by a custom static image, create an instance of the MKAnnotationView class and assign the image to its image property; see Using the Standard Annotation Views.
 If a static image is insufficient for representing your annotation, subclass MKAnnotationView and implement the custom drawing code needed to present it. For information about how to implement custom annotation views, see Defining a Custom Annotation View.
 Implement the mapView:viewForAnnotation: method in your map view delegate.
 In your implementation of this method, dequeue an existing annotation view if one exists; if not, create a new annotation view. If your app supports multiple types of annotations, include logic in this method to create a view of the appropriate type for the provided annotation object. For more information about implementing the mapView:viewForAnnotation: method, see Creating Annotation Views from Your Delegate Object.

 Add your annotation object to the map view using the addAnnotation: (or addAnnotations:) method.
 */

@property NSString *address;
@property NSString *busID;
@property NSString *position;
@property NSString *uuid;
@property NSString *stopName;
@property NSString *latitude;
@property NSString *longitude;
@property NSString *locationLat;
@property NSString *locationLong;
@property NSString *routes;
@property NSString *ward;
@property NSString *completeLocation;
@property MKPointAnnotation *annotation;
@property NSMutableArray *pinArray;

@property NSString *stopID;
@property NSString *direction;
@property NSString *intermodal;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)stopsArray;


@end
