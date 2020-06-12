//
//  FiltersViewController.m
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 11.05.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import "FiltersViewController.h"

@interface FiltersViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIImage *close;
@property (nonatomic, strong) NSArray *budget;
@property (nonatomic, strong) NSArray *allocation;
@property (nonatomic, strong) NSArray *facilities;

@property (nonatomic, strong) NSMutableArray *filters;

@property (nonatomic, strong) UILabel *budgetLable;
@property (nonatomic, strong) UILabel *allocationLable;
@property (nonatomic, strong) UILabel *facilitiesLable;
@property (nonatomic, strong) UICollectionView *budgetCV;
@property (nonatomic, strong) UICollectionView *allocationCV;
@property (nonatomic, strong) UICollectionView *facilitiesCV;


@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIButton *button;


@end

@implementation FiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"main"];
    
    
    self.budget = @[@"up to 1000€", @"from 1000€ to 5000€", @"from 5000€"];
    self.allocation = @[@"hotel", @"villa", @"apartments"];
    self.facilities = @[@"breakfast", @"parking", @"wifi", @"pool", @"pets", @"garden", @"fitness center", @"playground", @"restaurant", @"balcony", @"beach", @"smoking"];
    
    self.filters = [[NSMutableArray alloc] init];
    
    [self makeUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setTintColor:[UIColor colorNamed:@"red"]];
    bar.topItem.title = @"Filters";
    [bar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Barlow-Regular" size:24]}];
    [bar setBarTintColor:[UIColor colorNamed:@"main"]];
    
    self.close = [UIImage imageNamed:@"close"];
    UIBarButtonItem *closeButton=[[UIBarButtonItem alloc] initWithImage:self.close style:UIBarButtonItemStylePlain target:self action:@selector(buttonClose:)];
    self.navigationItem.leftBarButtonItem = closeButton;
    
    UIBarButtonItem *resetButton=[[UIBarButtonItem alloc] initWithTitle:@"reset" style:UIBarButtonItemStylePlain target:self action:@selector(buttonReset:)];
    self.navigationItem.rightBarButtonItem = resetButton;
    
}

- (void)buttonClose:(UIButton *)button {
    NSLog(@"Button Pressed - back");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonReset:(UIButton *)button {
    NSLog(@"Button Pressed - Reset");
    [self.filters removeAllObjects];
    [self makeUI];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.tabBarController.tabBar.hidden = NO;
    [super viewWillAppear:animated];
}


-(void)makeUI
{
    self.budgetLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 110, self.view.bounds.size.width - 16, 30)];
    self.budgetLable.font = [UIFont fontWithName:@"Barlow-Regular" size:20];
    self.budgetLable.textAlignment = NSTextAlignmentLeft;
    self.budgetLable.text = @"Budget:";
    
    self.allocationLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 260, self.view.bounds.size.width - 16, 30)];
    self.allocationLable.font = [UIFont fontWithName:@"Barlow-Regular" size:20];
    self.allocationLable.textAlignment = NSTextAlignmentLeft;
    self.allocationLable.text = @"Type of allocation:";
    
    self.facilitiesLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 360, self.view.bounds.size.width - 16, 30)];
    self.facilitiesLable.font = [UIFont fontWithName:@"Barlow-Regular" size:20];
    self.facilitiesLable.textAlignment = NSTextAlignmentLeft;
    self.facilitiesLable.text = @"Facilities:";
    
    [self.view addSubview:self.budgetLable];
    [self.view addSubview:self.allocationLable];
    [self.view addSubview:self.facilitiesLable];

    
    UICollectionViewLeftAlignedLayout *layout=[[UICollectionViewLeftAlignedLayout alloc] init];
    layout.minimumInteritemSpacing = 8;
    layout.minimumLineSpacing = 8;
    
    UICollectionViewLeftAlignedLayout *layout1=[[UICollectionViewLeftAlignedLayout alloc] init];
    layout1.minimumInteritemSpacing = 8;
    layout1.minimumLineSpacing = 8;
    
    UICollectionViewLeftAlignedLayout *layout2=[[UICollectionViewLeftAlignedLayout alloc] init];
    layout2.minimumInteritemSpacing = 8;
    layout2.minimumLineSpacing = 8;
    
    self.budgetCV=[[UICollectionView alloc] initWithFrame:CGRectMake(8, 150, self.view.frame.size.width - 20, 100) collectionViewLayout:layout];
    [self.budgetCV setDataSource:self];
    [self.budgetCV setDelegate:self];
    
    self.allocationCV=[[UICollectionView alloc] initWithFrame:CGRectMake(8, 300, self.view.frame.size.width - 20, 50) collectionViewLayout:layout1];
    [self.allocationCV setDataSource:self];
    [self.allocationCV setDelegate:self];
    
    self.facilitiesCV=[[UICollectionView alloc] initWithFrame:CGRectMake(8, 400, self.view.frame.size.width - 20, 300) collectionViewLayout:layout2];
    [self.facilitiesCV setDataSource:self];
    [self.facilitiesCV setDelegate:self];
    
    [self.budgetCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.budgetCV setBackgroundColor:[UIColor colorNamed:@"main"]];
    [self.allocationCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.allocationCV setBackgroundColor:[UIColor colorNamed:@"main"]];
    [self.facilitiesCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.facilitiesCV setBackgroundColor:[UIColor colorNamed:@"main"]];

    [self.view addSubview:self.budgetCV];
    [self.view addSubview:self.allocationCV];
    [self.view addSubview:self.facilitiesCV];
    

    [self makeButton];
 
}

-(void)makeButton
{
    self.buttonView = [[UIButton alloc] initWithFrame:CGRectMake(-1, self.view.bounds.size.height - 100, self.view.bounds.size.width + 2, 100)];
    self.buttonView.layer.borderColor = [UIColor colorNamed:@"preText"].CGColor;
    self.buttonView.layer.borderWidth = 1;
    self.buttonView.layer.masksToBounds = YES;
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(14, 14, self.buttonView.bounds.size.width - 30, 55)];
    self.button.backgroundColor = [UIColor colorNamed:@"red"];
    self.button.layer.cornerRadius = 2;
    self.button.layer.masksToBounds = YES;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.button.bounds.size.width, 35)];
    lable.font = [UIFont fontWithName:@"Barlow-Regular" size:24];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor colorNamed:@"main"];
    lable.text = @"apply";
    
    [self.button addSubview:lable];
    [self.buttonView addSubview:self.button];
    [self.view addSubview:self.buttonView];
    
    [self.button addTarget:self action:@selector(applyButtonPressed:)
    forControlEvents:UIControlEventTouchUpInside];
}

- (void)applyButtonPressed:(UIButton *)button
{
    NSLog(@"Button applyButtonPressed Pressed");
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont fontWithName:@"Barlow-Regular" size:20];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.tag = 100;
    
    if (collectionView == self.budgetCV)
    {
        lable.text = self.budget[indexPath.row];
                     
    }
    else if (collectionView == self.allocationCV)
    {
        lable.text = self.allocation[indexPath.row];
    }
    else
    {
        lable.text = self.facilities[indexPath.row];
    }
    
    [lable sizeToFit];
    
    [cell addSubview:lable];
    
    cell.backgroundColor = [UIColor colorNamed:@"main"];
    cell.layer.borderWidth = 1;
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    cell.layer.borderColor = [UIColor colorNamed:@"red"].CGColor;
    
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:lable
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:cell
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:lable
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:cell
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-10].active = YES;
    [NSLayoutConstraint constraintWithItem:lable
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:cell
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:8].active = YES;
    
    
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.budgetCV)
    {
        return [self.budget count];
    }
    else if (collectionView == self.allocationCV)
    {
        return [self.allocation count];
    }
    else
    {
        return [self.facilities count];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width;
    if (collectionView == self.budgetCV)
    {
        width = [self getStringSizeWithText:self.budget[indexPath.row]];

    }
    else if (collectionView == self.allocationCV){
        width = [self getStringSizeWithText:self.allocation[indexPath.row]];
    }
    else
    {
        width = [self getStringSizeWithText:self.facilities[indexPath.row]];;
    }
    
    return CGSizeMake(width, 40);
}

- (CGFloat)getStringSizeWithText:(NSString *)string{

    UILabel *label = [[UILabel alloc] init];
    label.text = string;
    label.font = [UIFont fontWithName:@"Barlow-Regular" size:20];

    return label.attributedText.size.width + 25;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *lable = [cell viewWithTag:100];

    if ([cell.contentView.backgroundColor isEqual:[UIColor colorNamed:@"red"]])
    {
        cell.contentView.backgroundColor = [UIColor colorNamed:@"main"];
        lable.textColor = [UIColor blackColor];
        
        if (collectionView == self.budgetCV)
        {
            NSLog(@"Filter %@ UNselected!", self.budget[indexPath.row]);
            [self removeItemFromFilters:self.budget[indexPath.row]];
        }
        else if (collectionView == self.allocationCV){
            NSLog(@"Filter %@ UNselected!", self.allocation[indexPath.row]);
            [self removeItemFromFilters:self.allocation[indexPath.row]];
        }
        else
        {
            NSLog(@"Filter %@ UNselected!", self.facilities[indexPath.row]);
            [self removeItemFromFilters:self.facilities[indexPath.row]];
        }
    }
    else
    {
        cell.contentView.backgroundColor = [UIColor colorNamed:@"red"];
        lable.textColor = [UIColor colorNamed:@"main"];
        
        if (collectionView == self.budgetCV)
        {
            NSLog(@"Filter %@ selected!", self.budget[indexPath.row]);
            [self.filters addObject:self.budget[indexPath.row]];
            NSLog(@"%@", self.filters);

        }
        else if (collectionView == self.allocationCV){
            NSLog(@"Filter %@ selected!", self.allocation[indexPath.row]);
            [self.filters addObject:self.allocation[indexPath.row]];
            NSLog(@"%@", self.filters);
        }
        else
        {
            NSLog(@"Filter %@ selected!", self.facilities[indexPath.row]);
            [self.filters addObject:self.facilities[indexPath.row]];
            NSLog(@"%@", self.filters);
        }
    }
}

-(void)removeItemFromFilters:(NSObject *)itemToDelete
{
    for(id item in self.filters) {
        if([item isEqual:itemToDelete]) {
            [self.filters removeObject:item];
            break;
        }
    }
    NSLog(@"%@", self.filters);
}


@end
