//
//  HotelOptionsViewController.m
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 19.05.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import "HotelOptionsViewController.h"
#import "NSModelClass.h"
#import "BookingPersonalInfoViewController.h"

@interface HotelOptionsViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewCell *cell;

@property (nonatomic, strong) UILabel *roomName;
@property (nonatomic, strong) UILabel *people;
@property (nonatomic, strong) UILabel *bed;
@property (nonatomic, strong) UILabel *size;
@property (nonatomic, strong) UILabel *price;


@property (nonatomic, strong) UIImageView *roomPhoto;
@property (nonatomic, strong) UIImageView *peopleIcon;
@property (nonatomic, strong) UIImageView *bedIcon;
@property (nonatomic, strong) UIImageView *sizeIcon;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *buttonLable;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation HotelOptionsViewController

- (instancetype)init:(NSMutableArray*)optionData
{
    self = [super init];
    if (self) {
        self.data = optionData;
        NSLog(@"%@", self.data);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"red"];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.backgroundColor = [UIColor colorNamed:@"main"];
    
    //self.data = [[NSModelClass alloc] hotelOptionsData];
    
    [self uploadUI];
    
    [self.view addSubview:self.scrollView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setTintColor:[UIColor colorNamed:@"main"]];
    bar.topItem.title = @"Options";
    [bar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor colorNamed:@"main"], NSFontAttributeName:[UIFont fontWithName:@"Barlow-Regular" size:24]}];
    [bar setBarTintColor:[UIColor colorNamed:@"red"]];
}

-(void)uploadUI
{
    NSLog(@"uploadUI __________________________");
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.scrollView.frame.size.height) collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor colorNamed:@"main"]];
    self.collectionView.userInteractionEnabled = YES;
    
    [self.scrollView addSubview:self.collectionView];
    
}

-(void)initCollectiomItems
{
    
    NSLog(@"initCollectiomItems __________________________");
    self.roomName = [[UILabel alloc] init];
    self.roomName.font = [UIFont fontWithName:@"Barlow-Regular" size:20];
    self.roomName.textAlignment = NSTextAlignmentLeft;
    
    self.people = [[UILabel alloc] init];
    self.people.font = [UIFont fontWithName:@"Barlow-Regular" size:15];
    self.people.textAlignment = NSTextAlignmentLeft;
    
    self.bed = [[UILabel alloc] init];
    self.bed.font = [UIFont fontWithName:@"Barlow-Regular" size:15];
    self.bed.textAlignment = NSTextAlignmentLeft;
    
    self.size = [[UILabel alloc] init];
    self.size.font = [UIFont fontWithName:@"Barlow-Regular" size:15];
    self.size.textAlignment = NSTextAlignmentLeft;
    
    self.price = [[UILabel alloc] init];
    self.price.font = [UIFont fontWithName:@"Barlow-Bold" size:24];
    self.price.textColor = [UIColor colorNamed:@"red"];
    self.price.textAlignment = NSTextAlignmentLeft;
    
    self.roomPhoto = [[UIImageView alloc] init];
    self.roomPhoto.contentMode = UIViewContentModeScaleAspectFill;
    self.roomPhoto.layer.masksToBounds = YES;
    self.peopleIcon = [[UIImageView alloc] init];
    self.peopleIcon.image = [UIImage imageNamed:@"person"];
    self.bedIcon = [[UIImageView alloc] init];
    self.bedIcon.image = [UIImage imageNamed:@"bed"];
    self.sizeIcon = [[UIImageView alloc] init];
    self.sizeIcon.image = [UIImage imageNamed:@"size"];
    
    self.button = [[UIButton alloc] init];
    self.button.backgroundColor = [UIColor colorNamed:@"main"];
    self.button.layer.borderWidth = 1;
    self.button.layer.masksToBounds = YES;
    self.button.layer.borderColor = [UIColor colorNamed:@"red"].CGColor;
    
    [self.button addTarget:self action:@selector(buttonPressed:)
    forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonLable = [[UILabel alloc] init];
    self.buttonLable.font = [UIFont fontWithName:@"Barlow-Regular" size:18];
    self.buttonLable.textColor = [UIColor colorNamed:@"red"];
    self.buttonLable.textAlignment = NSTextAlignmentCenter;
    self.buttonLable.text = @"make a reservation";
    
    [self.button addSubview:self.buttonLable];
}

- (void)buttonPressed:(UIButton *)button {
    NSLog(@"Button optionsButton Pressed");
    
    NSString *dataThatWasPassed = (NSString *)[button.layer valueForKey:@"item"];
    NSLog(@"My passed-thru data was: %@", dataThatWasPassed);

    BookingPersonalInfoViewController *bPIvc = [[BookingPersonalInfoViewController alloc] init:dataThatWasPassed];

    UINavigationController *navigationController = self.navigationController;
    [navigationController pushViewController:bPIvc animated:YES];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSLog(@"collectionView cell __________________________");
    self.cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    [self initCollectiomItems];
    
    NSLog(@"collectionView cell 2 __________________________");
    NSLog(@"property_name = %@", [self.data[indexPath.item] valueForKey:@"property_name"]);
    self.roomName.text = [self.data[indexPath.item] valueForKey:@"property_name"];
    
    NSLog(@"people = %@", [self.data[indexPath.item] valueForKey:@"capacity"]);
    self.people.text = [[self.data[indexPath.item] valueForKey:@"capacity"] stringValue];
    NSLog(@"bed = %@", [[self.data[indexPath.item] valueForKey:@"beds_number"] stringValue]);
    self.bed.text =[[self.data[indexPath.item] valueForKey:@"beds_number"] stringValue];
    
    NSLog(@"size_m = %d", [[self.data[indexPath.item] valueForKey:@"size_m"] intValue]);
    self.size.text = [NSString stringWithFormat:@"size: %d",[[self.data[indexPath.item] valueForKey:@"size_m"] intValue]];
    NSLog(@"price = %d", [[self.data[indexPath.item] valueForKey:@"price"] intValue]);
    self.price.text = [[self.data[indexPath.item] valueForKey:@"price"] stringValue];
    
    NSString *dataIWantToPass = [NSString stringWithFormat:@"%@",[self.data[indexPath.item] valueForKey:@"property_internal_id"]];
    [self.button.layer setValue:dataIWantToPass forKey:@"item"];
    
//    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [self.data[indexPath.item] valueForKey:@"image"]]];
//    self.roomPhoto.image = [UIImage imageWithData:imageData];
    self.roomPhoto.image = [UIImage imageNamed:@"room"];

    
    [self.cell addSubview:self.roomName];
    [self.cell addSubview:self.people];
    [self.cell addSubview:self.bed];
    [self.cell addSubview:self.size];
    [self.cell addSubview:self.price];
    [self.cell addSubview:self.roomPhoto];
    [self.cell addSubview:self.peopleIcon];
    [self.cell addSubview:self.bedIcon];
    [self.cell addSubview:self.sizeIcon];
    [self.cell addSubview:self.button];
    
    [self makeConstraint];
    
    return self.cell;
}


-(void)makeConstraint
{
    NSLog(@"makeConstraint - start");
    
    //ROOM _______________________________________________________________
    self.roomName.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.roomName
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.roomName
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.roomName
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-5].active = YES;
    [NSLayoutConstraint constraintWithItem:self.roomName
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:24].active = YES;
    
    
    self.roomPhoto.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.roomPhoto
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.roomPhoto
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.roomName
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:8].active = YES;
    [NSLayoutConstraint constraintWithItem:self.roomPhoto
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:80].active = YES;
    [NSLayoutConstraint constraintWithItem:self.roomPhoto
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:115].active = YES;
    
    //PEOPLE _______________________________________________________________
    
    [self iconConstraint:self.peopleIcon trailing:self.roomPhoto bottom:self.roomName];
    [self lableConstraint:self.people trailing:self.peopleIcon top:self.roomName];
    
    //BED _______________________________________________________________
    
    [self iconConstraint:self.bedIcon trailing:self.roomPhoto bottom:self.peopleIcon];
    [self lableConstraint:self.bed trailing:self.bedIcon top:self.people];
    
    //SIZE _______________________________________________________________
    
    [self iconConstraint:self.sizeIcon trailing:self.roomPhoto bottom:self.bedIcon];
    [self lableConstraint:self.size trailing:self.sizeIcon top:self.bed];
    
    //PRICE _______________________________________________________________
        
    self.price.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.price
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.roomPhoto
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.price
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.sizeIcon
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:15].active = YES;
    [NSLayoutConstraint constraintWithItem:self.price
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-5].active = YES;
    [NSLayoutConstraint constraintWithItem:self.price
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:26].active = YES;
    
    //BUTTON _______________________________________________________________
    
    self.buttonLable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.buttonLable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.button
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:8].active = YES;
    [NSLayoutConstraint constraintWithItem:self.buttonLable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.button
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:6].active = YES;
    [NSLayoutConstraint constraintWithItem:self.buttonLable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.button
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-8].active = YES;
    [NSLayoutConstraint constraintWithItem:self.buttonLable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:24].active = YES;
    
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.button
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.button
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.roomPhoto
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:8].active = YES;
    [NSLayoutConstraint constraintWithItem:self.button
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.button
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.buttonLable
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:6].active = YES;
    

    
}


-(void)iconConstraint:(UIImageView*)icon trailing:(UIImageView*)trailing bottom:(UIView*)bottom
{
    icon.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:icon
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:trailing
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:icon
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:bottom
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:8].active = YES;
    [NSLayoutConstraint constraintWithItem:icon
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:17].active = YES;
    [NSLayoutConstraint constraintWithItem:icon
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:18].active = YES;
}

-(void)lableConstraint:(UILabel*)lable trailing:(UIImageView*)trailing top:(UIView*)top
{
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:lable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:trailing
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:lable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:top
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:8].active = YES;
    [NSLayoutConstraint constraintWithItem:lable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-5].active = YES;
    [NSLayoutConstraint constraintWithItem:lable
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:18].active = YES;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.data count];
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width - 18, 200);
}


@end
