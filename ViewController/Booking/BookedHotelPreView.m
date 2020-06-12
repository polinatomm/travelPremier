//
//  BookedHotelPreView.m
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 19.05.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import "BookedHotelPreView.h"

@interface BookedHotelPreView()

@property (nonatomic, strong) BookedHotelPreView *bookingView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *hotelLable;
@property (nonatomic, strong) UIImageView *star;

@property (nonatomic, strong) UILabel *fromLable;
@property (nonatomic, strong) UILabel *toLable;
@property (nonatomic, strong) UILabel *fromTMPLable;
@property (nonatomic, strong) UILabel *toTMPLable;
@property (nonatomic, strong) UIView *lineV;
@property (nonatomic, strong) UIView *lineG;

@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *room;

@property (nonatomic, strong) NSDictionary *data;

@end

@implementation BookedHotelPreView

- (BookedHotelPreView *) makeBookingView
//(NSDictionary*)data
{
//    self.data = data;
    
    self.bookingView = [[BookedHotelPreView alloc] initWithFrame:CGRectMake(0, 0, 340, 340)];
    self.bookingView.backgroundColor = [UIColor colorNamed:@"bookingPallet"];
    self.bookingView.layer.cornerRadius = 5;
    self.bookingView.layer.masksToBounds = YES;
    
    [self initItems];
    
    [self uploadUI];
    
//    [self makeConstaint];
    
    return self.bookingView;
}

- (void)initItems
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 340, 160)];
    self.imageView.layer.cornerRadius = 5;
    self.imageView.clipsToBounds = YES;
    [self.bookingView addSubview:self.imageView];
    
    self.hotelLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 175, 340, 40)];
    self.hotelLable.font = [UIFont fontWithName:@"Barlow-Regular" size:20];
    self.hotelLable.textAlignment = NSTextAlignmentLeft;
    [self.bookingView addSubview:self.hotelLable];
    
    self.star = [[UIImageView alloc] initWithFrame:CGRectMake(20, 205, 60, 13)];
    [self.bookingView addSubview:self.star];
    
    self.fromLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 225, 110, 15)];
    self.fromLable.font = [UIFont fontWithName:@"Barlow-Regular" size:13];
    self.fromLable.textColor = [UIColor colorNamed:@"textCard"];
    self.fromLable.textAlignment = NSTextAlignmentLeft;
    [self.bookingView addSubview:self.fromLable];
    
    self.fromTMPLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 245, 110, 25)];
    self.fromTMPLable.font = [UIFont fontWithName:@"Barlow-Regular" size:20];
    self.fromTMPLable.textAlignment = NSTextAlignmentLeft;
    [self.bookingView addSubview:self.fromTMPLable];
    
    self.toLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 277, 110, 15)];
    self.toLable.font = [UIFont fontWithName:@"Barlow-Regular" size:13];
    self.toLable.textColor = [UIColor colorNamed:@"textCard"];
    self.toLable.textAlignment = NSTextAlignmentLeft;
    [self.bookingView addSubview:self.toLable];
    
    self.toTMPLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 297, 110, 25)];
    self.toTMPLable.font = [UIFont fontWithName:@"Barlow-Regular" size:20];
    self.toTMPLable.textAlignment = NSTextAlignmentLeft;
    [self.bookingView addSubview:self.toTMPLable];
    
    self.lineG = [[UIView alloc] initWithFrame:CGRectMake(20, 275, 110, 1)];
    self.lineV = [[UIView alloc] initWithFrame:CGRectMake(131, 225, 1, 102)];
    self.lineG.backgroundColor = [UIColor colorNamed:@"buttonColor"];
    self.lineV.backgroundColor = [UIColor colorNamed:@"buttonColor"];
    [self.bookingView addSubview:self.lineG];
    [self.bookingView addSubview:self.lineV];
    
    self.address = [[UILabel alloc] initWithFrame:CGRectMake(140, 225, 230, 37)];
    self.address.font = [UIFont fontWithName:@"Barlow-Regular" size:15];
    self.address.textAlignment = NSTextAlignmentLeft;
    self.address.numberOfLines = 0;
    self.address.lineBreakMode = NSLineBreakByWordWrapping;
    [self.bookingView addSubview:self.address];
    
    self.room = [[UILabel alloc] initWithFrame:CGRectMake(140, 262, 230, 37)];
    self.room.font = [UIFont fontWithName:@"Barlow-Regular" size:15];
    self.room.textAlignment = NSTextAlignmentLeft;
    self.room.numberOfLines = 0;
    self.room.lineBreakMode = NSLineBreakByWordWrapping;
    [self.bookingView addSubview:self.room];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(140, 299, 230, 17)];
    self.price.font = [UIFont fontWithName:@"Barlow-Regular" size:15];
    self.price.textAlignment = NSTextAlignmentLeft;
    [self.bookingView addSubview:self.price];
    

}

- (void)uploadUI
{
    self.imageView.image = [UIImage imageNamed:@"hotel"];
    self.hotelLable.text = [self.data valueForKey:@"name"];
    self.star.image = [UIImage imageNamed:@"star"];
    self.fromLable.text = [self.data valueForKey:@"check_in"];
    self.fromTMPLable.text = [self.data valueForKey:@"datefrom"];
    self.toLable.text = [self.data valueForKey:@"check_out"];
    self.toTMPLable.text = [self.data valueForKey:@"dateto"];
    
    self.address.text = [self.data valueForKey:@"address"];
    self.price.text = @"Price: 72 000 $";
    self.room.text = @"Room: Studio with Old Town View";
    
}

- (void)makeConstaint
{
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.bookingView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.bookingView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.bookingView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:160].active = YES;
    
}


@end
