//
//  SelfieCaptureController.h
//  AppItDepedency
//
//  Created by  on 10/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfieCaptureController : UIViewController

@property(nonatomic) NSString *titleString;

-(void)setResultImage:(NSMutableDictionary*) result;

@end
