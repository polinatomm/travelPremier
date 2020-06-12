//
//  SearchViewController.m
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 21.04.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultsViewController.h"

@interface SearchViewController ()

@property (nonatomic, strong) UILabel *lableSearch;
@property (nonatomic) UIView *searchView;
@property (nonatomic) UITextField *cityTF;
@property (nonatomic) UITextField *fromTF;
@property (nonatomic) UITextField *toTF;
@property (nonatomic) UITextField *peopleTF;
@property (nonatomic) UIButton *buttonSearch;


@property (nonatomic) UIDatePicker *datePicker;

@end

@implementation SearchViewController

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ([UIColor colorNamed:@"main"]);
    
    [self makeLableUI];
    
    
    // POST _____________________________________________________________
    NSString *postDeviceID = @"something";

    NSString *urlString1 = @"https://bookit-app-278416.oa.r.appspot.com/users";
    NSDictionary *jsonBodyDict = @{
                                    @"email":@"polina@test.org",
                                    @"password":@"Polina"
    };
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];
    // watch out: error is nil here, but you never do that in production code. Do proper checks!

    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";

    // for alternative 1:
    [request setURL:[NSURL URLWithString:urlString1]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonBodyData];

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                NSLog(@"Yay, done! Check for errors in response!");

                                                NSHTTPURLResponse *asHTTPResponse = (NSHTTPURLResponse *) response;
                                                NSLog(@"The response is: %@", asHTTPResponse);
                                                // set a breakpoint on the last NSLog and investigate the response in the debugger

                                                // if you get data, you can inspect that, too. If it's JSON, do one of these:
                                                NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                              options:kNilOptions
                                                                                                                error:nil];
                                                // or
                                                NSArray *forJSONArray = [NSJSONSerialization JSONObjectWithData:data
                                                                                                        options:kNilOptions
                                                                                                          error:nil];

                                                NSLog(@"One of these might exist - object: %@ \n array: %@", forJSONObject, forJSONArray);

                                            }];
    [task resume];
    
    
    
    self.searchView = [[UIView alloc] init];
    self.searchView.layer.cornerRadius = 5;
    self.searchView.layer.masksToBounds = true;
    self.searchView.backgroundColor = [UIColor colorNamed:@"red"];
    
    self.cityTF = [self makeTextField:@"City"];
    self.fromTF = [self makeTextField:@"16 july"];
    self.toTF = [self makeTextField:@"30 july"];
    self.peopleTF = [self makeTextField:@"2 adults - no kids"];
    
    [self makeButtonUI];
    
    [self.searchView addSubview:self.cityTF];
    [self.searchView addSubview:self.fromTF];
    [self.searchView addSubview:self.toTF];
    [self.searchView addSubview:self.peopleTF];
    [self.searchView addSubview:self.buttonSearch];
    
    [self.view addSubview:self.lableSearch];
    [self.view addSubview:self.searchView];
}

- (void) datePickerValueChanged:(UIDatePicker*)datePicker
{
    NSDateFormatter* aFormatter = [[NSDateFormatter alloc] init];
    [aFormatter setDateStyle:NSDateFormatterShortStyle];
    [aFormatter setTimeStyle:NSDateFormatterShortStyle];

    self.fromTF.text = [aFormatter stringFromDate:datePicker.date];
}

-(void)makeLableUI
{
    self.lableSearch = [[UILabel alloc] initWithFrame:CGRectMake(39, 88, self.view.frame.size.width, 38)];
    self.lableSearch.font = [UIFont fontWithName:@"Barlow-Regular" size:36];
    self.lableSearch.textAlignment = NSTextAlignmentLeft;
    self.lableSearch.text = @"Search";
}


-(void)makeButtonUI
{
    self.buttonSearch = [[UIButton alloc] init];
    self.buttonSearch.backgroundColor = [UIColor colorNamed:@"buttonColor"];
    self.buttonSearch.layer.cornerRadius = 10;
    [self.buttonSearch setTitle:@"find" forState:UIControlStateNormal];
    [self.buttonSearch setTitleColor:[UIColor colorNamed:@"red"] forState:UIControlStateNormal];
    self.buttonSearch.titleLabel.font = [UIFont fontWithName:@"Barlow-Regular" size:36];
    
    [self.buttonSearch addTarget:self action:@selector(buttonPressed:)
    forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonPressed:(UIButton *)button {
    NSLog(@"Button Pressed - find");
    SearchResultsViewController *srVC = [[SearchResultsViewController alloc] init];
    UINavigationController *navigationController = self.navigationController;
    [navigationController pushViewController:srVC animated:YES];
}

-(UITextField*) makeTextField:(NSString*)lable
{
    UITextField * tf = [[UITextField alloc] init];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:lable attributes:@{ NSForegroundColorAttributeName : [UIColor colorNamed:@"preText"] }];
    tf.attributedPlaceholder = str;
    tf.font = [UIFont fontWithName:@"Barlow-Regular" size:23];
    tf.layer.cornerRadius = 10;
    tf.layer.borderWidth = 1;
    tf.layer.borderColor = ([UIColor colorNamed:@"searchBoxBorder"].CGColor);
    tf.backgroundColor = [UIColor colorNamed:@"searchBox"];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    tf.leftView = paddingView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    return tf;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    [self makeConstraint];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillDisappear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)makeConstraint
{
    [self makeSearchViewConstraint];
    [self makeTFLongConstraint:self.cityTF before:nil main:self.searchView];
    [self makeTFShortConstraint:self.fromTF left:self.toTF before:self.cityTF main:self.searchView];
    [self makeTFLongConstraint:self.peopleTF before:self.fromTF main:self.searchView];

    self.buttonSearch.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.buttonSearch
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.searchView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.buttonSearch
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.searchView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.buttonSearch
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.peopleTF
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.buttonSearch
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:57].active = YES;
    [NSLayoutConstraint constraintWithItem:self.buttonSearch
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.searchView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-10].active = YES;
    
}

-(void) makeSearchViewConstraint
{
    self.searchView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.searchView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:12].active = YES;
    [NSLayoutConstraint constraintWithItem:self.searchView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-12].active = YES;
    [NSLayoutConstraint constraintWithItem:self.searchView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.lableSearch
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:12].active = YES;
}

-(void) makeTFLongConstraint:(UITextField*)tf
                      before:(UITextField*)beforeTF
                        main:(UIView*)mainView
{
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:mainView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:mainView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-10].active = YES;
    if (beforeTF == nil)
    {
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:mainView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:10].active = YES;
    }
    else
    {
        [NSLayoutConstraint constraintWithItem:tf
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:beforeTF
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:10].active = YES;
    }
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:57].active = YES;
}

-(void) makeTFShortConstraint:(UITextField*)tf
                        left:(UITextField*)tf2
                      before:(UITextField*)beforeTF
                        main:(UIView*)mainView
{
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    [self makeTFShortConstraintTrailingOnLeading:tf main:beforeTF LayoutAttribute1:NSLayoutAttributeTop LayoutAttribute2:NSLayoutAttributeBottom];
    [self makeTFShortConstraintHeight:tf];
    [self makeTFShortConstraintTrailingOnLeading:tf main:mainView LayoutAttribute1:NSLayoutAttributeLeading LayoutAttribute2:NSLayoutAttributeLeading];
    
    
    tf2.translatesAutoresizingMaskIntoConstraints = NO;
    [self makeTFShortConstraintTrailingOnLeading:tf2 main:beforeTF LayoutAttribute1:NSLayoutAttributeTop LayoutAttribute2:NSLayoutAttributeBottom];
    [self makeTFShortConstraintHeight:tf2];
    [self makeTFShortConstraintTrailingOnLeading:tf2 main:mainView LayoutAttribute1:NSLayoutAttributeTrailing LayoutAttribute2:NSLayoutAttributeTrailing];
    
    [self makeTFShortConstraintTrailingOnLeading:tf2 main:tf LayoutAttribute1:NSLayoutAttributeLeading LayoutAttribute2:NSLayoutAttributeTrailing];
    [self makeTFShortConstraintTrailingOnLeading:tf main:tf2 LayoutAttribute1:NSLayoutAttributeWidth LayoutAttribute2:NSLayoutAttributeWidth];
}

-(void) makeTFShortConstraintHeight:(UITextField*)tf
{
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:57].active = YES;
}

-(void) makeTFShortConstraintTrailingOnLeading:(UITextField*)tf
                                          main:(UIView*)mainView
                               LayoutAttribute1:(NSLayoutAttribute)attr1
                               LayoutAttribute2:(NSLayoutAttribute)attr2
{
    int num = 10;
    if (attr1 == NSLayoutAttributeTrailing) num*=-1;
    if (attr1 == NSLayoutAttributeWidth) num*=0;
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:attr1
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:mainView
                                 attribute:attr2
                                multiplier:1.0
                                  constant:num].active = YES;
}



@end

