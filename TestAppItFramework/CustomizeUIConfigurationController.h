//
//  CustomizeUIConfigurationController.h
//  AppItDepedency
//
//  Created by Sanket Garde on 30/05/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidePanelController.h"
#import "AccountSetUpViewController.h"
#import "ProcessFlowController.h"
#import "ArrayObjectController.h"
#import "LabelUtils.h"
#import "RootPageViewController.h"
#import "CustomizeUIConfigManager.h"
#import "CustomizeUIConfig.h"
#import <AppItFramework/AppItSDK.h>

@interface CustomizeUIConfigurationController : UIViewController<SidePanelResponse>

@property(nonatomic) NSMutableArray *pageControlFields;

@property(nonatomic) NSString *serviceType;

@end

