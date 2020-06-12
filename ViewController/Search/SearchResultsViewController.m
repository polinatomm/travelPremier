//
//  SearchResultsViewController.m
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 21.04.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "HotelViewController.h"
#import "FiltersViewController.h"
#import "NSModelClass.h"

@interface SearchResultsViewController () <UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) NSMutableData *responseData;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UICollectionViewCell *cell;
@property (nonatomic, strong) UILabel *hotelLable;
@property (nonatomic, strong) UILabel *priceLable;
@property (nonatomic, strong) UILabel *nightLable;
@property (nonatomic, strong) UIImageView *star;
@property (nonatomic, strong) UIView *navBarView;
@property (nonatomic, strong) UILabel *cityDateLable;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation SearchResultsViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];


    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.backgroundColor = [UIColor colorNamed:@"main"];
    
    [self makeNavBar];
    
    [self.view addSubview:self.scrollView];
    
    [self requestURL:@"https://bookit-app-278416.oa.r.appspot.com/search?datefrom=2020-07-03&dateto=2020-07-10"];
}

//Connection request
-(void)requestURL:(NSString *)strURL
{
   // Create the request.
   NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strURL]];

   // Create url connection and fire request
   NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}

//Delegate methods
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
   NSLog(@"Did Receive Response %@", response);
    self.responseData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
   //NSLog(@"Did Receive Data %@", data);
    [self.responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
   NSLog(@"Did Fail");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Did Finish");

    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSURLConnectionDidFinish" object:nil];

    self.data = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:NULL];
    NSLog(@"Responce:%@",self.data);
    
    [self makeUI];
}

-(void) makeUI
{
    NSLog(@"Start makeUI!");
    [self makeCollection];
}

-(void)initArray
{
    
    
    NSLog(@"Items in array - %lu", (unsigned long)[self.data count]);
    NSLog(@"HOTEL NAME -  %@", [self.data[0] valueForKey:@"propertyName"]);
    NSLog(@"NIGHTS -  %@", [self.data[0] valueForKey:@"night"]);
    NSLog(@"PRICE -  %@", [self.data[0] valueForKey:@"price"]);
    NSLog(@"PIC -  %@", [self.data[0] valueForKey:@"stars"]);
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
    


-(void)makeNavBar
{
    self.navBarView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 20, 52)];
    self.navBarView.layer.cornerRadius = 5;
    self.navBarView.backgroundColor = [UIColor colorNamed:@"red"];
    
    UIButton *buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(8, 7, 22, 38)];
    UIImage *btnImage = [UIImage imageNamed:@"back"];
    [buttonBack setImage:btnImage forState:UIControlStateNormal];
    
    [buttonBack addTarget:self action:@selector(buttonBackPressed:)
    forControlEvents:UIControlEventTouchUpInside];
    
    self.cityDateLable = [[UILabel alloc] initWithFrame:CGRectMake(41, 7, self.navBarView.bounds.size.width - 103, 38)];
    self.cityDateLable.backgroundColor = [UIColor colorNamed:@"main"];
    self.cityDateLable.layer.borderWidth = 1;
    self.cityDateLable.layer.cornerRadius = 5;
    self.cityDateLable.layer.masksToBounds = YES;
    self.cityDateLable.layer.borderColor = [UIColor colorNamed:@"searchBoxBorder"].CGColor;
    self.cityDateLable.font = [UIFont fontWithName:@"Barlow-Regular" size:23];
    self.cityDateLable.textAlignment = NSTextAlignmentCenter;
    self.cityDateLable.textColor = [UIColor colorNamed:@"preText"];
    
    self.cityDateLable.text = @"Milan · 5 may - 15 june";
    
    UIButton *buttonFilter = [[UIButton alloc] initWithFrame:CGRectMake(self.navBarView.bounds.size.width - 58, 0, 52, 52)];
    UIImage *btnFilterImage = [UIImage imageNamed:@"filter"];
    [buttonFilter setImage:btnFilterImage forState:UIControlStateNormal];
    
    [buttonFilter addTarget:self action:@selector(buttonFilterPressed:)
    forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.navBarView addSubview:buttonBack];
    [self.navBarView addSubview:self.cityDateLable];
    [self.navBarView addSubview:buttonFilter];
    [self.scrollView addSubview:self.navBarView];

}

- (void)buttonBackPressed:(UIButton *)button {
    NSLog(@"Button Pressed - back");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)buttonFilterPressed:(UIButton *)button {
    FiltersViewController *fVC = [[FiltersViewController alloc] init];

    
    UINavigationController *navigationController = self.navigationController;
    self.tabBarController.tabBar.hidden = YES;
    [navigationController pushViewController:fVC animated:YES];
}




-(void)makeCollection
{
    NSLog(@"Start Make Collection!");
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 110) collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];

    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor colorNamed:@"main"]];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);

    [self.scrollView addSubview:self.collectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.data count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    [self initCollectionItems];

    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[self.data[indexPath.item] valueForKey:@"images"] firstObject]]];
    NSLog(@"Image url - %@", [[self.data[indexPath.item] valueForKey:@"images"] firstObject]);
    self.imageView.image = [UIImage imageWithData:imageData];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    NSLog(@"hotelLable - %@", [self.data[indexPath.item] valueForKey:@"hotel_name"]);
    self.hotelLable.text = [self.data[indexPath.item] valueForKey:@"hotel_name"];
    
    NSLog(@"priceLable - %d", [[self.data[indexPath.item] valueForKey:@"min_price"] intValue]);
    self.priceLable.text = [NSString stringWithFormat:@"from %d%@ ", [[self.data[indexPath.item] valueForKey:@"min_price"] intValue], [self.data[indexPath.item] valueForKey:@"currency"]];
    
    NSNumber *num = [self.data[indexPath.section] valueForKey:@"stars"];
    NSLog(@"Image stars count - %@", num);
    
    NSString *starsImg = [NSString stringWithFormat:@"%@-stars", num];
    NSLog(@"Image stars img - %@", starsImg);
    self.star.image = [UIImage imageNamed:starsImg];
    
    self.nightLable.text = [NSString stringWithFormat:@"for %@ nights", [[self.data[indexPath.item] valueForKey:@"nights"] stringValue]];
    
    
    [self makeConstraint];
    
    return self.cell;
}

- (void)initCollectionItems
{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.layer.cornerRadius = 5;
    self.imageView.clipsToBounds = YES;
    [self.cell addSubview:self.imageView];
    
    self.hotelLable = [[UILabel alloc] init];
    self.hotelLable.font = [UIFont fontWithName:@"Barlow-Regular" size:18];
    self.hotelLable.textAlignment = NSTextAlignmentLeft;
    [self.cell addSubview:self.hotelLable];
    
    self.priceLable = [[UILabel alloc] init];
    self.priceLable.font = [UIFont fontWithName:@"Barlow-Regular" size:18];
    self.priceLable.textAlignment = NSTextAlignmentRight;
    self.priceLable.textColor = [UIColor colorNamed:@"red"];
    [self.cell addSubview:self.priceLable];
    
    self.star = [[UIImageView alloc] init];
    [self.cell addSubview:self.star];
    
    self.nightLable = [[UILabel alloc] init];
    self.nightLable.font = [UIFont fontWithName:@"Barlow-Regular" size:13];
    self.nightLable.textAlignment = NSTextAlignmentRight;
    self.nightLable.textColor = [UIColor colorNamed:@"preText"];
    [self.cell addSubview:self.nightLable];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width - 18, 215);
}


-(void)makeConstraint
{
    NSLog(@"makeConstraint - start");
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.cell
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:3].active = YES;
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:180].active = YES;
    
    [self makeTFShortConstraint:self.hotelLable left:self.priceLable before:self.imageView main:self.cell];
    
    [self makeImageAndLableConstraint:self.star left:self.nightLable before:self.hotelLable main:self.cell];
    
    
}

-(void) makeTFShortConstraint:(UILabel*)tf
                         left:(UILabel*)tf2
                       before:(UIImageView *)beforeTF
                         main:(UIView*)mainView
{
    NSLog(@"makeTFShortConstraint - start");
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:beforeTF
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:23].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:beforeTF
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    
    tf2.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:tf2
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:beforeTF
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:23].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf2
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:mainView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf2
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:tf
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf2
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:140].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                    toItem:tf2
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0].active = YES;
    NSLog(@"makeTFShortConstraint - finish");
}


-(void) makeImageAndLableConstraint:(UIImageView*)tf
                                left:(UILabel*)tf2
                                before:(UILabel *)beforeTF
                                main:(UIView*)mainView
{
    NSLog(@"makeImageAndLableConstraint - start");
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    tf2.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:beforeTF
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    NSLog(@"makeImageAndLableConstraint - 1");
    [NSLayoutConstraint constraintWithItem:tf2
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:tf
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:13].active = YES;
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:60].active = YES;
    [NSLayoutConstraint constraintWithItem:tf2
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:15].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:mainView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:tf2
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:mainView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf2
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:tf
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf2
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                    toItem:tf
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:mainView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Collection item selected!!");
    HotelViewController *hvc = [[HotelViewController alloc] init:self.data[indexPath.item]];
    UINavigationController *navigationController = self.navigationController;
    [navigationController pushViewController:hvc animated:YES];
    
}


@end
