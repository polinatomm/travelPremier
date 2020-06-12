//
//  HotelViewController.m
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 26.04.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import "HotelViewController.h"
#import "InfoView.h"
#import "HotelOptionsViewController.h"
#import "NSModelClass.h"

@interface HotelViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImage *imageHeart;
@property (nonatomic, strong) UIImageView *imageHotel;
@property (nonatomic, strong) UICollectionView *imageCollection;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) UICollectionViewCell *cell;

@property (nonatomic, strong) UILabel *hotelLable;
@property (nonatomic, strong) UIImageView *star;
@property (nonatomic, strong) UIView *datePriceView;
@property (nonatomic, strong) UILabel *fromLable;
@property (nonatomic, strong) UILabel *toLable;
@property (nonatomic, strong) UILabel *fromTMPLable;
@property (nonatomic, strong) UILabel *toTMPLable;
@property (nonatomic, strong) UILabel *nightsLable;
@property (nonatomic, strong) UILabel *priceLable;
@property (nonatomic, strong) UIView *lineV;
@property (nonatomic, strong) UIView *lineG;
@property (nonatomic, strong) UIButton *optionsButton;
@property (nonatomic, strong) UIView *mapView;
@property (nonatomic, strong) IBOutlet MKMapView *map;
@property (nonatomic, strong) UILabel *adressLable;

@property (nonatomic, strong) InfoView *infoView;

@property (nonatomic, strong) NSDictionary *dataHotel;

@end

@implementation HotelViewController

- (instancetype)init:(NSDictionary*)dataHotel
{
    self = [super init];
    if (self) {
        self.dataHotel = dataHotel;
        NSLog(@"%@", self.dataHotel);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.backgroundColor = [UIColor colorNamed:@"main"];
    
    NSLog(@"HOTEL NAME -  %@", [self.dataHotel valueForKey:@"propertyName"]);
    //[self.dataHotel valueForKey:@"Hotel"];
    
    [self uploadUI];
    
    [self.view addSubview:self.scrollView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setTintColor:[UIColor colorNamed:@"main"]];
    bar.topItem.title = [self.dataHotel valueForKey:@"hotel_name"];
    [bar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor colorNamed:@"main"], NSFontAttributeName:[UIFont fontWithName:@"Barlow-Regular" size:24]}];
    [bar setBarTintColor:[UIColor colorNamed:@"red"]];
    
    self.imageHeart = [UIImage imageNamed:@"heart"];
    UIBarButtonItem *add=[[UIBarButtonItem alloc] initWithImage:self.imageHeart style:UIBarButtonItemStylePlain target:self action:@selector(buttonLiked)];
    self.navigationItem.rightBarButtonItem =add;
}

- (void) buttonLiked
{
    if (self.imageHeart == [UIImage imageNamed:@"heart"])
    {
        self.imageHeart = [UIImage imageNamed:@"heartFilled"];
        self.navigationItem.rightBarButtonItem.image = self.imageHeart;
        NSLog(@"liked");
    }
    else{
        self.imageHeart = [UIImage imageNamed:@"heart"];
        self.navigationItem.rightBarButtonItem.image = self.imageHeart;
        NSLog(@"disliked");
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillDisappear:animated];
}

- (void)uploadUI
{
    [self makePhotoCollection];
    
    self.hotelLable = [[UILabel alloc] init];
    self.hotelLable.font = [UIFont fontWithName:@"Barlow-Regular" size:24];
    self.hotelLable.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:self.hotelLable];
    
    self.star = [[UIImageView alloc] init];
    [self.scrollView addSubview:self.star];
    
    
    self.datePriceView = [[UIView alloc] init];
    self.datePriceView.userInteractionEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    
    
    //DATA________________________________________________________
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [self.dataHotel valueForKey:@"image"]]];
    self.imageHotel.image = [UIImage imageWithData:imageData];
    self.hotelLable.text = [self.dataHotel valueForKey:@"hotel_name"];
    
    NSNumber *num = [self.dataHotel valueForKey:@"stars"];
    NSLog(@"Image stars count - %@", num);
    
    NSString *starsImg = [NSString stringWithFormat:@"%@-stars", num];
    NSLog(@"Image stars img - %@", starsImg);
    self.star.image = [UIImage imageNamed:starsImg];
    
    
    [self makeDatePriceView];
    [self.scrollView addSubview:self.datePriceView];
    
    [self makeMap];
    
    
    self.infoView = [[InfoView new] makeInfoView:self.dataHotel];
    [self.scrollView addSubview:self.infoView];
    
    
    [self makeConstaint];
}

- (void)makePhotoCollection
{
    
    self.imageArray = [self.dataHotel valueForKey:@"images"];
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.imageCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 290) collectionViewLayout:flowLayout];
        
    [self.imageCollection setBackgroundColor:[UIColor colorNamed:@"main"]];
    
    [self.imageCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self.imageCollection setDataSource:self];
    [self.imageCollection setDelegate:self];
    
    [self.scrollView addSubview:self.imageCollection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.imageArray[indexPath.item]]];
    NSLog(@"Image url - %@", self.imageArray[indexPath.item]);
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, [UIScreen mainScreen].bounds.size.width)];
    image.image = [UIImage imageWithData:imageData];
    image.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.cell addSubview:image];
    
    return self.cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(290, [UIScreen mainScreen].bounds.size.width);
}

- (void)makeMap
{
    NSLog(@"Making MAP");
    self.mapView = [[UIView alloc] init];
    self.mapView.backgroundColor = [UIColor colorNamed:@"searchBoxBorder"];
    
    self.map = [[MKMapView alloc] init];
    MKCoordinateRegion mapRegion;
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.dataHotel valueForKey:@"latitude"] doubleValue];
    coordinate.longitude = [[self.dataHotel valueForKey:@"longitude"] doubleValue];
    mapRegion.center = coordinate;
    mapRegion.span.latitudeDelta = 0.01;
    mapRegion.span.longitudeDelta = 0.01;

    [self.map setRegion:mapRegion animated: YES];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinate];
    [annotation setTitle:@"Hotel"]; //You can set the subtitle too
    [self.map addAnnotation:annotation];
    
    self.adressLable = [[UILabel alloc] init];
    self.adressLable.font = [UIFont fontWithName:@"Barlow-Regular" size:18];
    self.adressLable.textAlignment = NSTextAlignmentLeft;
    NSLog(@"address - %@", [self.dataHotel valueForKey:@"address"]);
    NSLog(@"address - %@", [[self.dataHotel valueForKey:@"address"] valueForKey:@"city"]);
    self.adressLable.text = [NSString stringWithFormat:@"Address: %@, %@, %@ ", [[self.dataHotel valueForKey:@"address"] valueForKey:@"line1"], [[self.dataHotel valueForKey:@"address"] valueForKey:@"city"], [[self.dataHotel valueForKey:@"address"] valueForKey:@"country"]];
    
    
    [self.mapView addSubview:self.map];
    [self.mapView addSubview:self.adressLable];
    [self.scrollView addSubview:self.mapView];
}

- (void)makeDatePriceView
{
    NSLog(@"Making makeDatePriceView");
    //[self smallLableMake:self.fromLable];
    self.fromLable = [[UILabel alloc] init];
    self.fromLable.font = [UIFont fontWithName:@"Barlow-Regular" size:13];
    self.fromLable.textColor = [UIColor colorNamed:@"textCard"];
    self.fromLable.textAlignment = NSTextAlignmentLeft;
    self.fromLable.text = @"from";
    [self.datePriceView addSubview:self.fromLable];
    
    self.fromTMPLable = [[UILabel alloc] init];
    self.fromTMPLable.font = [UIFont fontWithName:@"Barlow-Regular" size:20];
    self.fromTMPLable.textAlignment = NSTextAlignmentLeft;
    [self.datePriceView addSubview:self.fromTMPLable];
    
    self.toLable = [[UILabel alloc] init];
    self.toLable.font = [UIFont fontWithName:@"Barlow-Regular" size:13];
    self.toLable.textColor = [UIColor colorNamed:@"textCard"];
    self.toLable.textAlignment = NSTextAlignmentLeft;
    self.toLable.text = @"to";
    [self.datePriceView addSubview:self.toLable];
    
    self.toTMPLable = [[UILabel alloc] init];
    self.toTMPLable.font = [UIFont fontWithName:@"Barlow-Regular" size:20];
    self.toTMPLable.textAlignment = NSTextAlignmentLeft;
    [self.datePriceView addSubview:self.toTMPLable];
    
    self.nightsLable = [[UILabel alloc] init];
    self.nightsLable.font = [UIFont fontWithName:@"Barlow-Regular" size:13];
    self.nightsLable.textColor = [UIColor colorNamed:@"textCard"];
    self.nightsLable.textAlignment = NSTextAlignmentLeft;
    [self.datePriceView addSubview:self.nightsLable];
    
    self.priceLable = [[UILabel alloc] init];
    self.priceLable.font = [UIFont fontWithName:@"Barlow-Regular" size:24];
    self.priceLable.textColor = [UIColor colorNamed:@"red"];
    self.priceLable.textAlignment = NSTextAlignmentLeft;
    [self.datePriceView addSubview:self.priceLable];
    
    self.lineG = [[UIView alloc] init];
    self.lineV = [[UIView alloc] init];
    self.lineG.backgroundColor = [UIColor colorNamed:@"buttonColor"];
    self.lineV.backgroundColor = [UIColor colorNamed:@"buttonColor"];
    [self.datePriceView addSubview:self.lineG];
    [self.datePriceView addSubview:self.lineV];
    
    self.optionsButton = [[UIButton alloc] init];
    self.optionsButton.backgroundColor = [UIColor colorNamed:@"red"];
    [self.optionsButton setTitle:@"see your options" forState:UIControlStateNormal];
    [self.optionsButton setTitleColor:[UIColor colorNamed:@"main"] forState:UIControlStateNormal];
    self.optionsButton.titleLabel.font = [UIFont fontWithName:@"Barlow-Regular" size:18];
    
    [self.optionsButton addTarget:self action:@selector(buttonPressed:)
    forControlEvents:UIControlEventTouchUpInside];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFrom  = [dateFormatter dateFromString:[self.dataHotel valueForKey:@"date_from"]];
    NSDate *dateTo  = [dateFormatter dateFromString:[self.dataHotel valueForKey:@"date_to"]];
    
    [dateFormatter setDateFormat:@"d MMMM"];
    NSLog(@"date - %@", [dateFormatter stringFromDate:dateFrom]);
    self.fromTMPLable.text = [dateFormatter stringFromDate:dateFrom];
    self.toTMPLable.text = [dateFormatter stringFromDate:dateTo];
    self.nightsLable.text = [NSString stringWithFormat:@"Price for %@ nights", [[self.dataHotel valueForKey:@"nights"] stringValue]];
    self.priceLable.text = [NSString stringWithFormat:@"from %d%@ ",[[self.dataHotel valueForKey:@"min_price"] intValue], [self.dataHotel valueForKey:@"currency"]];
    
    [self.datePriceView addSubview:self.optionsButton];
}

- (void)buttonPressed:(UIButton *)button {
    NSLog(@"Button optionsButton Pressed");
    HotelOptionsViewController *hOvc = [[HotelOptionsViewController alloc] init:[self.dataHotel valueForKey:@"properties"]];
    UINavigationController *navigationController = self.navigationController;
    [navigationController pushViewController:hOvc animated:YES];
}


- (void)smallLableMake:(UILabel*)label
{
    label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"Barlow-Regular" size:13];
    label.textColor = [UIColor colorNamed:@"textCard"];
    label.textAlignment = NSTextAlignmentLeft;
}

- (void)bigLableMake:(UILabel*)label
{
    label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"Barlow-Regular" size:20];
    label.textAlignment = NSTextAlignmentLeft;
    [self.datePriceView addSubview:label];
}

- (void)makeConstaint
{
    self.imageCollection.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.imageCollection
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageCollection
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageCollection
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageCollection
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:290].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageCollection
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0].active = YES;
    
    
    self.hotelLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.hotelLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.hotelLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.hotelLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.imageCollection
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:5].active = YES;
    [NSLayoutConstraint constraintWithItem:self.hotelLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:30].active = YES;
    
    self.star.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.star
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.star
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.hotelLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.star
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:13].active = YES;
    [NSLayoutConstraint constraintWithItem:self.star
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:60].active = YES;
    
    
    //datePriceView _____________________________________________________________
    self.datePriceView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.datePriceView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.datePriceView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.datePriceView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.star
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10].active = YES;
    
    
    self.fromLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.fromLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:5].active = YES;
    [NSLayoutConstraint constraintWithItem:self.fromLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.fromLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:14].active = YES;
    [NSLayoutConstraint constraintWithItem:self.fromLable
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:115].active = YES;
    
    self.fromTMPLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.fromTMPLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:5].active = YES;
    [NSLayoutConstraint constraintWithItem:self.fromTMPLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.fromLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.fromTMPLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    [NSLayoutConstraint constraintWithItem:self.fromTMPLable
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:115].active = YES;
    
    self.lineG.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.lineG
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.lineG
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.fromTMPLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:3].active = YES;
    [NSLayoutConstraint constraintWithItem:self.lineG
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:1].active = YES;
    [NSLayoutConstraint constraintWithItem:self.lineG
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:117].active = YES;
    
    self.toLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.toLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:5].active = YES;
    [NSLayoutConstraint constraintWithItem:self.toLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.lineG
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:3].active = YES;
    [NSLayoutConstraint constraintWithItem:self.toLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:14].active = YES;
    [NSLayoutConstraint constraintWithItem:self.toLable
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:115].active = YES;
    
    self.toTMPLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.toTMPLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:5].active = YES;
    [NSLayoutConstraint constraintWithItem:self.toTMPLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.toLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.toTMPLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    [NSLayoutConstraint constraintWithItem:self.toTMPLable
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:115].active = YES;
    
    self.lineV.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.lineV
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.fromLable
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:1].active = YES;
    [NSLayoutConstraint constraintWithItem:self.lineV
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:1].active = YES;
    [NSLayoutConstraint constraintWithItem:self.lineV
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.toTMPLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:1].active = YES;
    [NSLayoutConstraint constraintWithItem:self.lineV
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:1].active = YES;
    
    
    self.nightsLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.nightsLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.lineV
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:8].active = YES;
    [NSLayoutConstraint constraintWithItem:self.nightsLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.nightsLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:14].active = YES;
    [NSLayoutConstraint constraintWithItem:self.nightsLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-1].active = YES;
    
    self.priceLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.priceLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.lineV
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:8].active = YES;
    [NSLayoutConstraint constraintWithItem:self.priceLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.nightsLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.priceLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:30].active = YES;
    [NSLayoutConstraint constraintWithItem:self.priceLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-1].active = YES;
    
    self.optionsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.optionsButton
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.lineV
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:8].active = YES;
    [NSLayoutConstraint constraintWithItem:self.optionsButton
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.priceLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:6].active = YES;
    [NSLayoutConstraint constraintWithItem:self.optionsButton
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:37].active = YES;
    [NSLayoutConstraint constraintWithItem:self.optionsButton
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-1].active = YES;
    
    
    [NSLayoutConstraint constraintWithItem:self.datePriceView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.toTMPLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    
    
    // mapView ______________________________________________________________
    self.mapView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.mapView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.mapView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.mapView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.datePriceView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:20].active = YES;
//    [NSLayoutConstraint constraintWithItem:self.mapView
//                                 attribute:NSLayoutAttributeHeight
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:nil
//                                 attribute:NSLayoutAttributeNotAnAttribute
//                                multiplier:1.0
//                                  constant:300].active = YES;
    
    
    self.map.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.map
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.mapView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.map
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.mapView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.map
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.mapView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.map
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:150].active = YES;
    
    self.adressLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.adressLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.mapView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:15].active = YES;
    [NSLayoutConstraint constraintWithItem:self.adressLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.mapView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.adressLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.map
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:5].active = YES;
    [NSLayoutConstraint constraintWithItem:self.adressLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:24].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.mapView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.adressLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:2].active = YES;
    
    
    // infoView - определение
    self.infoView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.infoView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:12].active = YES;
    [NSLayoutConstraint constraintWithItem:self.infoView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-12].active = YES;
    [NSLayoutConstraint constraintWithItem:self.infoView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.mapView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:12].active = YES;
    
    
    // scrollView - продлинение
    [NSLayoutConstraint constraintWithItem:self.scrollView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.infoView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
}


@end
