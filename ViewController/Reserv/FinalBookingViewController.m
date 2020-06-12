//
//  FinalBookingViewController.m
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 27.05.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import "FinalBookingViewController.h"
#import "BookedHotelPreView.h"

@interface FinalBookingViewController ()

@property (nonatomic, strong) BookedHotelPreView *bookingView;

@end

@implementation FinalBookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"main"];
    
    self.bookingView = [[BookedHotelPreView new] makeBookingView];
    [self.view addSubview:self.bookingView];
    
    
    self.bookingView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.bookingView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:18].active = YES;
    [NSLayoutConstraint constraintWithItem:self.bookingView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:100].active = YES;
    [NSLayoutConstraint constraintWithItem:self.bookingView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-18].active = YES;
    [NSLayoutConstraint constraintWithItem:self.bookingView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:340].active = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
//    UINavigationBar *bar = [self.navigationController navigationBar];
//    [bar setTintColor:[UIColor colorNamed:@"red"]];
//    bar.topItem.title = @"Filters";
//    [bar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Barlow-Regular" size:24]}];
//    [bar setBarTintColor:[UIColor colorNamed:@"main"]];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
