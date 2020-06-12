//
//  NSModelClass.m
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 21.05.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import "NSModelClass.h"
#import "SearchResultsViewController.h"

@interface NSModelClass() <NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableArray *dataSearch;
@property (nonatomic, strong) NSDictionary *dataHotel;
@property (nonatomic, strong) NSDictionary *dataPersonal;
@property (nonatomic, strong) NSMutableArray *dataOptionsHotel;
@property (nonatomic, strong) NSMutableData *responseData;

@end


@implementation NSModelClass

-(NSMutableArray *)searchData
{

    
    //[self readDataFromJson];
     [self requestURL:@"https://bookit-app-278416.oa.r.appspot.com/polyatest"];
    
//    NSDictionary *dictionary = @{@"name": @"Sunbath Milan Resort",
//                                 @"price": @"from 65 350 ₽",
//                                 @"night": @"for 41 nights",
//                                 @"star": @"star",
//                                 @"image": @"https://i.ibb.co/SXqC237/rclhmcc02jun19-800x600.jpg"
//    };
//    NSDictionary *dictionary1 = @{@"name": @"Sunbath Milan Resort",
//                                 @"price": @"from 65 350 ₽",
//                                 @"night": @"for 41 nights",
//                                 @"star": @"star",
//                                 @"image": @"https://i.ibb.co/SXqC237/rclhmcc02jun19-800x600.jpg"
//    };
//
//    self.dataSearch = [[NSMutableArray alloc] init];
//    [self.dataSearch addObject:dictionary];
//    [self.dataSearch addObject:dictionary1];
    
    return self.dataSearch;
}

-(void)readDataFromJson
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    // insert whatever URL you would like to connect to
    [request setURL:[NSURL URLWithString:@"https://bookit-app-278416.oa.r.appspot.com/polyatest"]];

    [self requestURL:@"https://bookit-app-278416.oa.r.appspot.com/polyatest"];
    
//    NSLog(@"json: %@", self.dataSearch);
//    NSLog(@"Name_____________________json: %@", [self.dataSearch[0] valueForKey:@"night"]);
//    NSLog(@"Night_____________________json: %@", [self.dataSearch valueForKey:@"address"]);
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

    self.dataSearch = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:NULL];
    
    [[SearchResultsViewController new] makeUI];
    
    NSLog(@"Responce:%@",self.dataSearch);
}


-(NSMutableArray *)hotelOptionsData
{
    NSDictionary *dictionary = @{@"name": @"Studio With Old-Town view",
                                 @"id": @"1234",
                                 @"price": @"65 350 ₽",
                                 @"people": @"price for 2 people",
                                 @"bed": @"one bedroom with king-size bed",
                                 @"size": @"45 m2",
                                 @"image": @"https://i.ibb.co/SXqC237/rclhmcc02jun19-800x600.jpg"
    };
    
    NSDictionary *dictionary1 = @{@"name": @"Studio With SSea View",
                                  @"id": @"123456",
                                 @"price": @"176 350 ₽",
                                 @"people": @"price for 2 people",
                                 @"bed": @"two bedrooms with king-size beds",
                                 @"size": @"80 m2",
                                 @"image": @"https://i.ibb.co/SXqC237/rclhmcc02jun19-800x600.jpg"
    };
    NSDictionary *dictionary2 = @{@"name": @"Studio With SSea View",
                                  @"id": @"12345678",
                                 @"price": @"176 350 ₽",
                                 @"people": @"price for 2 people",
                                 @"bed": @"two bedrooms with king-size beds",
                                 @"size": @"80 m2",
                                 @"image": @"https://i.ibb.co/SXqC237/rclhmcc02jun19-800x600.jpg"
    };
    
    
    self.dataOptionsHotel = [[NSMutableArray alloc] init];
    [self.dataOptionsHotel addObject:dictionary];
    [self.dataOptionsHotel addObject:dictionary1];
    [self.dataOptionsHotel addObject:dictionary2];
    return self.dataOptionsHotel;
}

-(NSDictionary *)hotelData
{
    self.dataHotel = @{@"name": @"Sunbath Milan Resort",
                     @"price": @"65 350 ₽",
                     @"night": @"for 41 nights",
                     @"star": @"star",
                     @"image": @"https://i.ibb.co/SXqC237/rclhmcc02jun19-800x600.jpg",
                     @"from": @"5 may",
                     @"to": @"15 june",
                       @"latitude": @45.469854,
                       @"longitude": @9.182881,
                       @"address": @"Address: 12 Ires Road, Glasgow, Scotland",
                     @"description": @"Located on the hills of Nice, a short distance from the famous Promenade des Anglais, Hotel Anis is one of the hotels in the Costa Azzurra (or Blue Coast) able to satisfy the different needs of its guests with comfort and first rate services. It is only 2 km from the airport and from highway exits. The hotel has a large parking area , a real luxury in a city like Nice.",
                     @"wifi": @YES,
                     @"breakfast": @YES,
                     @"parking": @NO,
                     @"pool": @NO,
                     @"playgraund": @NO,
                     @"garden": @YES,
                     @"parties": @YES,
                     @"smoking": @NO,
                     @"check_in": @"11:00 AM - 11:00 PM",
                     @"check_out": @"10:00 AM"
    };
    
    return self.dataHotel;
}

-(NSDictionary *)perData
{
    self.dataPersonal = @{@"name": @"Polina",
                          @"surname": @"Tomm",
                          @"telephone": @"",
                          @"email": @"tommpv.98@mail.ru"
    };
    
    return self.dataPersonal;
}

-(void)perDataPost:(NSDictionary*)dic
{
    //post data to server
}



@end
