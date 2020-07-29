//
//  VideoViewController.h
//  SDKNewDesign
//
//  Created by  on 03/10/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController

@property(nonatomic) NSString *titleString;

-(void)videoResponse:(NSMutableDictionary*) result;

@end
