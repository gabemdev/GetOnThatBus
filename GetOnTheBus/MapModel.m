//
//  MapModel.m
//  MobileMapper
//
//  Created by Rockstar. on 3/24/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "MapModel.h"

#define API @"https://s3.amazonaws.com/mobile-makers-lib/bus.json"

@implementation MapModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.address = dictionary[@"_address"];
        self.busID = dictionary[@"_id"];
        self.position = dictionary[@"_position"];
        self.uuid = dictionary[@"_uuid"];
        self.stopName = dictionary[@"cta_stop_name"];
//        self.direction = dictionary[@"direction"];
        self.locationLat = dictionary[@"location"][@"latitude"];
        self.locationLong = dictionary[@"location"][@"longitude"];
        self.latitude = [dictionary[@"latitude"] doubleValue];
        self.longitude = [dictionary[@"longitude"] doubleValue];
        self.routes = dictionary[@"routes"];
//        self.stopID = dictionary[@"stop_id"];
        self.ward = dictionary[@"ward"];
        
        self.annotation.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    }
    return self;
}

+ (NSMutableArray *)getPinsArray {
    NSMutableArray *pinArray = [NSMutableArray new];
    NSString *searchString = [NSString stringWithFormat:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    NSURL *url = [NSURL URLWithString:searchString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSDictionary *mapDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
            NSArray *mapArray = mapDict[@"row"];
            for (NSDictionary *stops in mapArray) {
                MapModel *model = [[MapModel alloc] initWithDictionary:stops];
                NSLog(@"%@", model.routes);

            }
        }
    }];
    return pinArray;
}

@end
