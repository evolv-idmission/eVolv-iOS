//
//  SecondaryIDCaptureFrontController.h
//  AppItDepedency
//
//  Created by Sanket Garde on 28/08/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AppItFramework/AppItSDK.h>

@interface SecondaryIDCaptureFrontController : UIViewController

@property(nonatomic) NSString *titleString;

-(void)captureResponse : (NSMutableDictionary*) result;

@end

