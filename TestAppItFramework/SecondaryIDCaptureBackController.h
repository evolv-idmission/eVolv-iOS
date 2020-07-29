//
//  SecondaryIDCaptureBackController.h
//  AppItDepedency
//
//  Created by Sanket Garde on 28/08/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppItFramework/AppItSDK.h>

@interface SecondaryIDCaptureBackController : UIViewController

@property(nonatomic) NSString *titleString;
-(void)setResultImage:(UIImage *)resImage;

-(void)captureResponse : (NSMutableDictionary*) result;
@end

