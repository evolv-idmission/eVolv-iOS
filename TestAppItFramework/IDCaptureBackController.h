//
//  IDCaptureBackController.h
//  AppItDepedency
//
//  Created by  on 10/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppItFramework/AppItSDK.h>

@interface IDCaptureBackController : UIViewController

@property(nonatomic) NSString *titleString;
-(void)setResultImage:(UIImage *)resImage;

-(void)captureResponse : (NSMutableDictionary*) result;
@end
