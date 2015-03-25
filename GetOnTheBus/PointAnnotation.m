//
//  BusStopPointAnnotation.m
//  GetOnTheBus
//
//  Created by Rockstar. on 3/24/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "PointAnnotation.h"

@implementation PointAnnotation

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.address = dictionary[@"_address"];
        self.busID = dictionary[@"_id"];
        self.position = dictionary[@"_position"];
        self.uuid = dictionary[@"_uuid"];
        self.stopName = dictionary[@"cta_stop_name"];
        self.direction = dictionary[@"direction"];
        self.locationLat = dictionary[@"location"][@"latitude"];
        self.locationLong = dictionary[@"location"][@"longitude"];
        self.latitude = dictionary[@"latitude"];
        self.longitude = dictionary[@"longitude"];
        self.routes = dictionary[@"routes"];
        self.stopID = dictionary[@"stop_id"];
        self.ward = dictionary[@"ward"];
        self.intermodal = dictionary[@"inter_modal"];

        double lat = [dictionary[@"latitude"] doubleValue];
        double lon;

        if ([dictionary[@"longitude"] doubleValue] > 0) {
            lon = -[dictionary[@"longitude"] doubleValue];
        }
        else {
            lon = [dictionary[@"longitude"]doubleValue];
        }
        self.coordinate = CLLocationCoordinate2DMake(lat, lon);
    }
    return self;
}

+ (NSMutableArray *)stopsArray {
    NSMutableArray *pinArray = [NSMutableArray new];
    NSString *searchString = [NSString stringWithFormat:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    NSURL *url = [NSURL URLWithString:searchString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *mapDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *mapArray = mapDict[@"row"];
    for (NSDictionary *stops in mapArray) {
        PointAnnotation *pins = [[PointAnnotation alloc] initWithDictionary:stops];
        [pinArray addObject:pins];
    }
    return pinArray;
}
@end
