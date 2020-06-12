//
//  OneViewController.m
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 21.04.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import "BookingViewController.h"
#import "BookedHotelPreView.h"

@interface BookingViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *booking;
@property (nonatomic, strong) UILabel *favorites;

@property (nonatomic, strong) BookedHotelPreView *bookingView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewCell *cell;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *lableCity;

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"main"];
    
    [self uploadUI];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)uploadUI
{
    self.booking = [[UILabel alloc] init];
    self.booking.font = [UIFont fontWithName:@"Barlow-Regular" size:36];
    self.booking.textAlignment = NSTextAlignmentLeft;
    self.booking.text = @"Booking";
    
    self.favorites = [[UILabel alloc] init];
    self.favorites.font = [UIFont fontWithName:@"Barlow-Regular" size:26];
    self.favorites.textAlignment = NSTextAlignmentLeft;
    self.favorites.text = @"Favorites";
    
    self.bookingView = [[BookedHotelPreView new] makeBookingView];
    
    self.scrollView = [[UIScrollView alloc] init];
    
    
//    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//
//    self.collectionView = [[FavAndHistoryCollectionViewController alloc]
//                           init];
    
//    self.collectionView = [[FavAndHistoryCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
//
//    [self addChildViewController:self.collectionView];
//    [self.scrollView addSubview:self.collectionView.view];
//    [self.collectionView didMoveToParentViewController:self];
//    self.collectionView.view.userInteractionEnabled = YES;
    
    [self makeCollection];
    
    [self.view addSubview:self.booking];
    [self.view addSubview:self.favorites];
    [self.view addSubview:self.bookingView];
    [self.view addSubview:self.scrollView];
    
    [self makeConstraint];
    
}

- (void)makeCollection
{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170) collectionViewLayout:flowLayout];
        
    [self.collectionView setBackgroundColor:[UIColor colorNamed:@"main"]];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    [self.scrollView addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 125)];
    self.image.image = [UIImage imageNamed:@"hotel"];
    self.image.layer.cornerRadius = 5;
    self.image.layer.masksToBounds = YES;
    
    
    self.lableCity = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, 200, 25)];
    self.lableCity.font = [UIFont fontWithName:@"Barlow-Regular" size:18];
    self.lableCity.textAlignment = NSTextAlignmentCenter;
    self.lableCity.text = @"Tenerife";
    
    [self.cell addSubview:self.image];
    [self.cell addSubview:self.lableCity];
    
    //[self makeConstraintCollection];
    
    return self.cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200, 170);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did selected!!");
}
-(void)makeConstraintCollection
{
    self.image.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.image
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.image
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.image
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.image
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:125].active = YES;
    
    self.lableCity.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.lableCity
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.lableCity
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.image
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.lableCity
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.lableCity
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:25].active = YES;
}


-(void)makeConstraint
{
    self.booking.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.booking
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:40].active = YES;
    [NSLayoutConstraint constraintWithItem:self.booking
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:88].active = YES;
    [NSLayoutConstraint constraintWithItem:self.booking
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.booking
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:45].active = YES;
    
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
                                    toItem:self.booking
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10].active = YES;
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
    
    self.favorites.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.favorites
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:40].active = YES;
    [NSLayoutConstraint constraintWithItem:self.favorites
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.bookingView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:30].active = YES;
    [NSLayoutConstraint constraintWithItem:self.favorites
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-18].active = YES;
    [NSLayoutConstraint constraintWithItem:self.favorites
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:32].active = YES;
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.scrollView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.scrollView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.favorites
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.scrollView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.scrollView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:170].active = YES;
}

@end
