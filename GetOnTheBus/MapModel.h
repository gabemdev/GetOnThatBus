//
//  MapModel.h
//  MobileMapper
//
//  Created by Rockstar. on 3/24/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapModel : NSObject
@property NSString *address;
@property NSString *busID;
@property NSString *position;
@property NSString *uuid;
@property NSString *stopName;
@property float latitude;
@property float longitude;
@property NSString *locationLat;
@property NSString *locationLong;
@property NSString *routes;
@property NSString *ward;
@property NSString *completeLocation;
@property MKPointAnnotation *annotation;
@property NSMutableArray *pinArray;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)getPinsArray;



@end
