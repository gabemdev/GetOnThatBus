//
//  DetailViewController.m
//  GetOnTheBus
//
//  Created by Rockstar. on 3/24/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *stopName;
@property (weak, nonatomic) IBOutlet UILabel *routesLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UILabel *intermodalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stopImageView;
@property (weak, nonatomic) IBOutlet UILabel *stopIDLabel;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *routes;
@property (weak, nonatomic) IBOutlet UILabel *direction;
@property (weak, nonatomic) IBOutlet UILabel *intermodal;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.annotation.stopName;
    self.addressButton.layer.cornerRadius = 3;

    [self loadLabels];

}

#pragma mark - Helper Methods
- (void)loadLabels {
    self.addressLabel.text = self.annotation.address;
    self.routesLabel.text = self.annotation.routes;
    self.stopIDLabel.text = self.annotation.stopID;
    self.directionLabel.text = self.annotation.direction;
    self.intermodalLabel.text = self.annotation.intermodal;

    if ([self.annotation.intermodal isEqualToString:@"Metra"]) {
        self.stopImageView.image = [UIImage imageNamed:@"ring-red"];
        [self.stopImageView sizeToFit];
        self.stopIDLabel.textColor = [UIColor colorWithRed:0.83 green:0.27 blue:0.27 alpha:1.00];
        self.intermodal.textColor = self.stopIDLabel.textColor;
        self.direction.textColor = self.stopIDLabel.textColor;
        self.routes.textColor = self.stopIDLabel.textColor;
        self.address.textColor = self.stopIDLabel.textColor;

        [self.addressButton setBackgroundColor:self.stopIDLabel.textColor];
        [self.addressButton setTitle:self.annotation.intermodal forState:UIControlStateNormal];
    }
    else if ([self.annotation.intermodal isEqualToString:@"Pace"]) {
        self.stopImageView.image = [UIImage imageNamed:@"ring-purple"];
        [self.stopImageView sizeToFit];
        self.stopIDLabel.textColor = [UIColor colorWithRed:0.49 green:0.35 blue:0.79 alpha:1.00];
        [self.addressButton setBackgroundColor:self.stopIDLabel.textColor];
        self.intermodal.textColor = self.stopIDLabel.textColor;
        self.direction.textColor = self.stopIDLabel.textColor;
        self.routes.textColor = self.stopIDLabel.textColor;
        self.address.textColor = self.stopIDLabel.textColor;

        [self.addressButton setBackgroundColor:self.stopIDLabel.textColor];
        [self.addressButton setTitle:self.annotation.intermodal forState:UIControlStateNormal];

    }
    else {
        self.stopImageView.image = [UIImage imageNamed:@"ring-white"];
        [self.stopImageView sizeToFit];
        self.stopIDLabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
        self.intermodal.hidden = YES;
        self.direction.textColor = self.stopIDLabel.textColor;
        self.routes.textColor = self.stopIDLabel.textColor;
        self.address.textColor = self.stopIDLabel.textColor;
        [self.addressButton setBackgroundColor:self.stopIDLabel.textColor];
        [self.addressButton setTitle:@"WebView" forState:UIControlStateNormal];
    }

}


@end
