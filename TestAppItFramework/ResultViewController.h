//
//  ResultViewController.h
//  AppItDepedency
//
//  Created by  on 19/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidePanelController.h"

@interface ResultViewController : UIViewController  <SidePanelResponse>

@property (nonatomic) NSMutableDictionary *resultDictionary;

@property(nonatomic,assign) NSString *reqResponseRawData;

@property(nonatomic,assign) bool isClearFormKey;

@property (nonatomic) NSMutableArray *linearKeyArray;

@end
