//
//  InfoView.m
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 27.04.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import "InfoView.h"

@interface InfoView()

@property (nonatomic, strong) InfoView *infoView;
@property (nonatomic, strong) UILabel *descriptionLable;
@property (nonatomic, strong) UILabel *descriptionTMPLable;
@property (nonatomic, strong) UILabel *amenityLable;
@property (nonatomic, strong) UILabel *wifiLable;
@property (nonatomic, strong) UILabel *breakfastLable;
@property (nonatomic, strong) UILabel *parkingLable;
@property (nonatomic, strong) UILabel *poolLable;
@property (nonatomic, strong) UILabel *playgraundLable;
@property (nonatomic, strong) UILabel *gardenLable;
@property (nonatomic, strong) UILabel *moreLable;
@property (nonatomic, strong) UILabel *checkInLable;
@property (nonatomic, strong) UILabel *checkOutLable;
@property (nonatomic, strong) UILabel *checkInTimeLable;
@property (nonatomic, strong) UILabel *checkOutTimeLable;

@property (nonatomic, strong) UIImageView *imageSmoking;
@property (nonatomic, strong) UIImageView *imageParties;
@property (nonatomic, strong) UILabel *smokingLable;
@property (nonatomic, strong) UILabel *partiesLable;

@property (nonatomic, strong) NSDictionary *dataHotel;

@end

@implementation InfoView

-(InfoView *) makeInfoView:(NSDictionary *)data
{
    self.infoView = [[InfoView alloc] init];
    self.dataHotel = data;
    [self initItems];
    
    self.descriptionTMPLable.text = [self.dataHotel valueForKey:@"description"];

    //AMENITY _______________________________________________________
    NSDictionary* attributes = @{
      NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]
    };
    
    if ([[self.dataHotel valueForKey:@"wifi"] boolValue]){
        self.wifiLable.text = @"WIFI";
    }
    else {
        self.wifiLable.attributedText = [[NSAttributedString alloc] initWithString:@"WIFI" attributes:attributes];
    }
    if ([[self.dataHotel valueForKey:@"breakfast"] boolValue]){
        self.breakfastLable.text = @"BREAKFAST";
    }
    else{
        self.breakfastLable.attributedText = [[NSAttributedString alloc] initWithString:@"BREAKFAST" attributes:attributes];
    }
    if ([[self.dataHotel valueForKey:@"parking"] boolValue]) {
        self.parkingLable.text = @"PARKING";
    }
    else{
        self.parkingLable.attributedText = [[NSAttributedString alloc] initWithString:@"PARKING" attributes:attributes];
    }
    if ([[self.dataHotel valueForKey:@"pool"] boolValue]) {
        self.poolLable.text = @"POOL";
    }
    else {
        self.poolLable.attributedText = [[NSAttributedString alloc] initWithString:@"POOL" attributes:attributes];
    }
    if ([[self.dataHotel valueForKey:@"playground"] boolValue]) {
        self.playgraundLable.text = @"PLAYGROUND";
    }
    else {
        self.playgraundLable.attributedText = [[NSAttributedString alloc] initWithString:@"PLAYGRAUND" attributes:attributes];
    }
    if ([[self.dataHotel valueForKey:@"garden"] boolValue]) {
        self.gardenLable.text = @"GARDEN";
    }
    else{
        self.gardenLable.attributedText = [[NSAttributedString alloc] initWithString:@"GARDEN" attributes:attributes];
    }

    //MORE _________________________________________________________
    self.checkInTimeLable.text = [self.dataHotel valueForKey:@"check_in"];
    self.checkOutTimeLable.text = [self.dataHotel valueForKey:@"check_out"];
    
    if ([[self.dataHotel valueForKey:@"smoking"] boolValue]) {
        self.imageSmoking.image = [UIImage imageNamed:@"check"];
    }
    else
    {
        self.imageSmoking.image = [UIImage imageNamed:@"close"];
    }
    
    if ([[self.dataHotel valueForKey:@"parties"] boolValue]) {
        self.imageParties.image = [UIImage imageNamed:@"check"];
    }
    else
    {
        self.imageParties.image = [UIImage imageNamed:@"close"];
    }

    [self makeConstaint];
    return self.infoView;
}

- (void)initItems
{
    //MAIN LABLES _______________________________________________________
    self.descriptionLable = [self makeMainLable:@"Description:"];
    self.amenityLable = [self makeMainLable:@"Amenities:"];
    self.moreLable = [self makeMainLable:@"More:"];
    
    //DESCRIPTION _______________________________________________________
    self.descriptionTMPLable = [self makeLable];
    self.descriptionTMPLable.numberOfLines = 0;
    self.descriptionTMPLable.lineBreakMode = NSLineBreakByWordWrapping;
    
    //AMENITY _______________________________________________________
    self.wifiLable = [self makeLable];
    self.breakfastLable = [self makeLable];
    self.parkingLable = [self makeLable];
    self.poolLable = [self makeLable];
    self.playgraundLable = [self makeLable];
    self.gardenLable = [self makeLable];
    
    //MORE _________________________________________________________
    self.checkInLable = [self makeLableCheck:@"check in"];
    self.checkOutLable = [self makeLableCheck:@"check out"];
    self.checkInTimeLable = [self makeLableCheck:@" "];
    self.checkOutTimeLable = [self makeLableCheck:@" "];
    self.imageSmoking = [[UIImageView alloc] init];
    self.smokingLable = [self makeLable];
    self.smokingLable.text = @"smoking";
    self.imageParties = [[UIImageView alloc] init];
    self.partiesLable = [self makeLable];
    self.partiesLable.text = @"parties";
    
    //ADD SUBVIEWS __________________________________________________
    [self.infoView addSubview:self.descriptionLable];
    [self.infoView addSubview:self.amenityLable];
    [self.infoView addSubview:self.moreLable];
    
    [self.infoView addSubview:self.descriptionTMPLable];
    
    [self.infoView addSubview:self.wifiLable];
    [self.infoView addSubview:self.breakfastLable];
    [self.infoView addSubview:self.parkingLable];
    [self.infoView addSubview:self.poolLable];
    [self.infoView addSubview:self.playgraundLable];
    [self.infoView addSubview:self.gardenLable];
    
    [self.infoView addSubview:self.checkInLable];
    [self.infoView addSubview:self.checkOutLable];
    [self.infoView addSubview:self.checkInTimeLable];
    [self.infoView addSubview:self.checkOutTimeLable];
    [self.infoView addSubview:self.imageSmoking];
    [self.infoView addSubview:self.smokingLable];
    [self.infoView addSubview:self.imageParties];
    [self.infoView addSubview:self.partiesLable];
    
}

-(UILabel *)makeMainLable:(NSString *)name
{
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont fontWithName:@"Barlow-Bold" size:18];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.text = name;
    
    return lable;
}

-(UILabel *)makeLable
{
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont fontWithName:@"Barlow-Regular" size:18];
    lable.textAlignment = NSTextAlignmentLeft;
    
    return lable;
}

-(UILabel *)makeLableCheck:(NSString *)name
{
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont fontWithName:@"Barlow-Regular" size:18];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = name;
    
    return lable;
}


- (void)makeConstaint
{
    self.descriptionLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.descriptionLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.descriptionLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.descriptionLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.descriptionLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    self.descriptionTMPLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.descriptionTMPLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.descriptionTMPLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.descriptionTMPLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.descriptionLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    
    // amenityLable ________________________________________________________________
    self.amenityLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.amenityLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.amenityLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.amenityLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.descriptionTMPLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.amenityLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    self.wifiLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.wifiLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:40].active = YES;
    [NSLayoutConstraint constraintWithItem:self.wifiLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.amenityLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.wifiLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    self.poolLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.poolLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.wifiLable
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:35].active = YES;
    [NSLayoutConstraint constraintWithItem:self.poolLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.poolLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.amenityLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.poolLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.poolLable
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.wifiLable
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:26].active = YES;
    
    
    self.breakfastLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.breakfastLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:40].active = YES;
    [NSLayoutConstraint constraintWithItem:self.breakfastLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.wifiLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:2].active = YES;
    [NSLayoutConstraint constraintWithItem:self.breakfastLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    self.playgraundLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.playgraundLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.breakfastLable
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:35].active = YES;
    [NSLayoutConstraint constraintWithItem:self.playgraundLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.playgraundLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.poolLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:2].active = YES;
    [NSLayoutConstraint constraintWithItem:self.playgraundLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.playgraundLable
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.breakfastLable
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:26].active = YES;
    
    
    self.parkingLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.parkingLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:40].active = YES;
    [NSLayoutConstraint constraintWithItem:self.parkingLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.breakfastLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:2].active = YES;
    [NSLayoutConstraint constraintWithItem:self.parkingLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    self.gardenLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.gardenLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.parkingLable
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:35].active = YES;
    [NSLayoutConstraint constraintWithItem:self.gardenLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.gardenLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.playgraundLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:2].active = YES;
    [NSLayoutConstraint constraintWithItem:self.gardenLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.gardenLable
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.parkingLable
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:26].active = YES;
    
    
    
    // moreLable __________________________________________________________________
    self.moreLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.moreLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.moreLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.moreLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.parkingLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.moreLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    
    self.checkInTimeLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.checkInTimeLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.checkInTimeLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.moreLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.checkInTimeLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    self.checkOutTimeLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.checkOutTimeLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.checkInTimeLable
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.checkOutTimeLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.checkOutTimeLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.moreLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.checkOutTimeLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.checkOutTimeLable
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.checkInTimeLable
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0].active = YES;
    
    
    self.checkInLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.checkInLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.checkInLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.checkInTimeLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.checkInLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:18].active = YES;
    
    self.checkOutLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.checkOutLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.checkInLable
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.checkOutLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.checkOutLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.checkOutTimeLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.checkOutLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:18].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.checkOutLable
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.checkInLable
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0].active = YES;
    
    self.imageSmoking.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.imageSmoking
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:50].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageSmoking
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.smokingLable
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:-10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageSmoking
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.checkInLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:35].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageSmoking
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageSmoking
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:20].active = YES;
    
    self.smokingLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.smokingLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.checkInLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:30].active = YES;
    [NSLayoutConstraint constraintWithItem:self.smokingLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:30].active = YES;
    
    
    self.imageParties.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.imageParties
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.smokingLable
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageParties
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.partiesLable
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:-10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageParties
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.checkOutLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:35].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageParties
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageParties
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:20].active = YES;

    self.partiesLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.partiesLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.partiesLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.checkInLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:30].active = YES;
    [NSLayoutConstraint constraintWithItem:self.partiesLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:30].active = YES;

    [NSLayoutConstraint constraintWithItem:self.partiesLable
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.smokingLable
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0].active = YES;
    
    // infoView - удлинение
    [NSLayoutConstraint constraintWithItem:self.infoView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.smokingLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:20].active = YES;
}


@end
