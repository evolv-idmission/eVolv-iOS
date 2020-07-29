//
//  LocationViewController.h
//  SDKNewDesign
//
//  Created by  on 03/10/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController

@property(nonatomic) NSString *titleString;

-(void)gpsResponse : (NSMutableDictionary*) result;

@end
