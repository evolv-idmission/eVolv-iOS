//
//  SlantViewController.h
//  AppItDepedency
//
//  Created by Dipen Patel on 29/08/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AppItFramework/AppItSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface SlantViewController : UIViewController

@property(nonatomic) NSString *titleString;

-(void)captureResponse : (NSMutableDictionary*) result;

@end

NS_ASSUME_NONNULL_END
