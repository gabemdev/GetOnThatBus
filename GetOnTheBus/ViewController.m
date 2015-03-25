//
//  ViewController.m
//  GetOnTheBus
//
//  Created by Rockstar. on 3/24/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "PointAnnotation.h"
#import "DetailViewController.h"

@interface ViewController ()<MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *stopTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property NSMutableArray *mapPins;
@property PointAnnotation *main;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Map";
    //Get data from model
    self.mapPins = [PointAnnotation stopsArray];

    //Add annotation to map for every item in our array
    for (PointAnnotation *annotation in self.mapPins) {
        [self.mapView addAnnotation:annotation];
    }

    //Show annotations on map
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.49 green:0.35 blue:0.79 alpha:1.00]];
}

#pragma mark - Segment Control
/**
 *  Switch indexes from segments. 
 *  If selected index is 0, hide the tableview and show the map.
 *  If selected index is 1, hide the map and show the tableview.
 *  Add navbar title just for design.
 *
 *  @param sender UISegmentControl when tapped.
 */
- (IBAction)onSegmentTapped:(id)sender {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        self.mapView.hidden = NO;
        self.stopTableView.hidden = YES;
        self.title = @"Map";
    } else if(self.segmentControl.selectedSegmentIndex == 1) {
        self.mapView.hidden = YES;
        self.stopTableView.hidden = NO;
        self.title = @"List";
        [self.stopTableView reloadData];
    }
    
}


#pragma mark - MapKit
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    PointAnnotation *newAnnotation = annotation;
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
    /**
     *  Set initial annotatinos to stop name and routes.
     */
    newAnnotation.title = newAnnotation.stopName;
    newAnnotation.subtitle = [NSString stringWithFormat:@"Routes: %@",newAnnotation.routes];

    /**
     *  If intermodal matches "Metra", change the pin image to purple
     *  If intermodal matches "Pace", change pin to red
     */
    if ([newAnnotation.intermodal isEqualToString:@"Metra"]) {
        pin.image = [UIImage imageNamed:@"FindARide_MapUI_PinBig_DropOff_Up"];
    } else if ([newAnnotation.intermodal isEqualToString:@"Pace"]) {
        pin.image = [UIImage imageNamed:@"FindARide_MapUI_PinBig_PickUp_Up"];
    } else {
        pin.image = [UIImage imageNamed:@"FindARide_MapUI_Pin_EndPin"];
    }

    /**
     *  Display pin with button desclosure
     */
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return pin;
}

/**
 *  Method that detects tap on accessory control. We override MKAnnotationView and pass our PointAnnotation, asing the selcted pin to
 *  Our PointAnnotation property. We then use performSegueWithIdentifier  and use MKPointAnnotation as the sender.
 *
 *  @param view    MKAnnotationView has a property of annotation. We pass that value to PointAnnotation
 *
 */
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    PointAnnotation *selectedPin = view.annotation;
        self.main = selectedPin;
    [self performSegueWithIdentifier:@"detailView" sender:selectedPin];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mapPins.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    PointAnnotation *annotation = [self.mapPins objectAtIndex:indexPath.row];

    /**
     *  Updtate cell image and title text color depending on intermodal text.
     */
    if ([annotation.intermodal isEqualToString:@"Metra"]) {
        cell.textLabel.textColor = [UIColor colorWithRed:0.83 green:0.27 blue:0.27 alpha:1.00];
        cell.imageView.image = [UIImage imageNamed:@"FindARide_MapUI_Pin_DropOff_Up"];

    } else if ([annotation.intermodal isEqualToString:@"Pace"]) {
        cell.textLabel.textColor = [UIColor colorWithRed:0.49 green:0.35 blue:0.79 alpha:1.00];
        cell.imageView.image = [UIImage imageNamed:@"FindARide_MapUI_Pin_PickUp_Up"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"FindARide_MapUI_Pin_Default_Up"];
    }

    cell.textLabel.text = annotation.stopName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Available Routes:\n%@", annotation.routes];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /**
     *  Detect the index of the selected path based on the row. Assing it to our PointAnnotation and then perform segue.
     */
    PointAnnotation *selectedPin = [self.mapPins objectAtIndex:indexPath.row];
    self.main = selectedPin;
    [self performSegueWithIdentifier:@"detailView" sender:selectedPin];
}

#pragma mark - Actions & Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /**
     *  We simply pass our model and assing it to the oen in the destination view controller.
     */
        DetailViewController *vc = segue.destinationViewController;
        vc.annotation = self.main;
}
@end
