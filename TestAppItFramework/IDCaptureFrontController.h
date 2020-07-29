//
//  IDCaptureFrontController.h
//  AppItDepedency
//
//  Created by  on 10/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AppItFramework/AppItSDK.h>

@interface IDCaptureFrontController : UIViewController

@property(nonatomic) NSString *titleString;

-(void)captureResponse : (NSMutableDictionary*) result;
@end
