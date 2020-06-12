//
//  HotelViewController.h
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 26.04.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotelViewController : UIViewController <MKMapViewDelegate>

- (instancetype)init:(NSDictionary*)dataHotel;

@end

NS_ASSUME_NONNULL_END
