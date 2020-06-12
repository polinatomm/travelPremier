//
//  InfoView.h
//  CameraAndGalleryExample
//
//  Created by Полина Томм on 27.04.2020.
//  Copyright © 2020 Полина Томм. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoView : UIView

-(InfoView *) makeInfoView:(NSDictionary *)data;
- (void)makeConstaint;
- (void)initItems;

@end

NS_ASSUME_NONNULL_END
