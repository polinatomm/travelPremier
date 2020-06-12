//
//  BookingPersonalInfoViewController.m
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 27.05.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import "BookingPersonalInfoViewController.h"
#import "NSModelClass.h"
#import "FinalBookingViewController.h"

@interface BookingPersonalInfoViewController ()

@property (nonatomic, strong) NSString *itemID;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *surnameTF;
@property (nonatomic, strong) UITextField *telephoneTF;
@property (nonatomic, strong) UITextField *emailTF;
@property (nonatomic, strong) UILabel *transfer;
@property (nonatomic, strong) UILabel *transferInstractions;
@property (nonatomic, strong) UISwitch *transferSwitch;
@property (nonatomic) BOOL *isSwitch;

@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) NSDictionary *data;



@end

@implementation BookingPersonalInfoViewController

- (instancetype)init:(NSString*)itemID
{
    self = [super init];
    if (self) {
        self.itemID = itemID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"main"];
    

    
//    self.data = [[NSModelClass new] personalData];
    self.data = [[NSModelClass new] perData];
    
    NSLog(@"GET ITEMID FOR NEXT USE ______ %@", self.itemID);
    
    [self uploadUI];
    
}

- (void) uploadUI
{
    [self initItemsOfUI];
    
    
    //Work With Data _____________________________________
    if (![[self.data valueForKey:@"name"] isEqualToString:@""]) {
        self.nameTF.text = [self.data valueForKey:@"name"];
    }
    if (![[self.data valueForKey:@"surname"] isEqualToString:@""]) {
        self.surnameTF.text = [self.data valueForKey:@"surname"];
    }
    if (![[self.data valueForKey:@"telephone"] isEqualToString:@""]) {
        self.telephoneTF.text = [self.data valueForKey:@"telephone"];
    }
    if (![[self.data valueForKey:@"email"] isEqualToString:@""]) {
        self.emailTF.text = [self.data valueForKey:@"email"];
    }
    
    
}

- (void)initItemsOfUI
{
    self.nameTF = [self makeTextField:@"name"];
    self.surnameTF = [self makeTextField:@"surname"];
    self.emailTF = [self makeTextField:@"email"];
    self.telephoneTF = [self makeTextField:@"phone"];
    
    self.transfer = [[UILabel alloc] init];
    self.transfer.font = [UIFont fontWithName:@"Barlow-Regular" size:23];
    self.transfer.text = @"I need transfer";
    
    self.transferInstractions = [[UILabel alloc] init];
    self.transferInstractions.font = [UIFont fontWithName:@"Barlow-Regular" size:18];
    self.transferInstractions.textColor = [UIColor colorNamed:@"preText"];
    self.transferInstractions.numberOfLines = 0;
    self.transferInstractions.lineBreakMode = NSLineBreakByWordWrapping;
    self.transferInstractions.text = @"Hotel manager will contant you for follow instractions";
    
    self.transferSwitch = [[UISwitch alloc] init];
    [self.transferSwitch addTarget:self action:@selector(switchToggled:) forControlEvents: UIControlEventTouchUpInside];
    
    [self makeButton];
    
    [self.view addSubview:self.nameTF];
    [self.view addSubview:self.surnameTF];
    [self.view addSubview:self.emailTF];
    [self.view addSubview:self.telephoneTF];
    
    [self.view addSubview:self.transfer];
    [self.view addSubview:self.transferInstractions];
    [self.view addSubview:self.transferSwitch];
    
    
    [self makeTFLongConstraint:self.nameTF before:nil];
    [self makeTFLongConstraint:self.surnameTF before:self.nameTF];
    [self makeTFLongConstraint:self.emailTF before:self.surnameTF];
    [self makeTFLongConstraint:self.telephoneTF before:self.emailTF];
    
    [self makeConstraint];
}

- (void) switchToggled:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
        self.isSwitch = true;
        NSLog(@"its on!");
    } else {
        self.isSwitch = false;
        NSLog(@"its off!");
    }
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
    
    [self.button addTarget:self action:@selector(nextButtonPressed:)
    forControlEvents:UIControlEventTouchUpInside];
}

- (void)nextButtonPressed:(UIButton *)button
{
    if ([self isAllTFFull]) {
        NSDictionary *pers = @{@"name":self.nameTF.text,
                               @"surname":self.surnameTF.text,
                               @"telephone":self.telephoneTF.text,
                               @"email":self.emailTF.text
        };
        NSLog(@"%@", pers);
        FinalBookingViewController *fbvc = [[FinalBookingViewController alloc] init];
        UINavigationController *navigationController = self.navigationController;
        [navigationController pushViewController:fbvc animated:YES];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning!"
                                   message:@"Fill all fields to continue booking"
                                   preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {}];

        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (BOOL)isAllTFFull
{
    if ([self.nameTF hasText] && [self.surnameTF hasText] && [self.telephoneTF hasText] && [self.emailTF hasText]) {
        return true;
    }
    return false;
}

-(UITextField*) makeTextField:(NSString*)lable
{
    UITextField * tf = [[UITextField alloc] init];
    //tf.placeholder = lable;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:lable attributes:@{ NSForegroundColorAttributeName : [UIColor colorNamed:@"preText"] }];
    tf.attributedPlaceholder = str;
    
    tf.font = [UIFont fontWithName:@"Barlow-Regular" size:23];
    tf.layer.borderWidth = 1;
    tf.layer.borderColor = ([UIColor colorNamed:@"preText"].CGColor);
    tf.backgroundColor = [UIColor colorNamed:@"main"];
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    tf.leftView = paddingView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    
    return tf;
}

-(void)makeConstraint
{
    self.transfer.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.transfer
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.transfer
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.telephoneTF
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.transfer
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.transfer
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:25].active = YES;
    [NSLayoutConstraint constraintWithItem:self.transfer
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:300].active = YES;
    
    self.transferInstractions.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.transferInstractions
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.transferInstractions
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.transfer
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.transferInstractions
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50].active = YES;
    [NSLayoutConstraint constraintWithItem:self.transferInstractions
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:350].active = YES;
    
    self.transferSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.transferSwitch
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.transferInstractions
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.transferSwitch
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.telephoneTF
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:30].active = YES;
    [NSLayoutConstraint constraintWithItem:self.transferSwitch
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:-20].active = YES;
    [NSLayoutConstraint constraintWithItem:self.transferSwitch
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:40].active = YES;
    [NSLayoutConstraint constraintWithItem:self.transferSwitch
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50].active = YES;
    

}


-(void) makeTFLongConstraint:(UITextField*)tf
                      before:(UITextField*)beforeTF
{
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0
                                  constant:-1].active = YES;
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0
                                  constant:1].active = YES;
    if (beforeTF == nil)
    {
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:100].active = YES;
    }
    else
    {
        [NSLayoutConstraint constraintWithItem:tf
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:beforeTF
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:-1].active = YES;
    }
    [NSLayoutConstraint constraintWithItem:tf
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:70].active = YES;
}



@end
