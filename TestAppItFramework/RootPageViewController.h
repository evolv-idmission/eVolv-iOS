//
//  RootPageViewController.h
//  SDKNewDesign
//
//  Created by  on 03/10/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidePanelController.h"
#import <AppItFramework/AppItSDK.h>
#import "IDCaptureBackController.h"
#import "SelfieCaptureController.h"

@interface RootPageViewController : UIPageViewController <UIPageViewControllerDataSource, SidePanelResponse,UIPageViewControllerDelegate>

@property(nonatomic) NSMutableArray *pageControlFields;

@property(nonatomic) UIPageViewController *pageViewControler;

@property(nonatomic) NSString *serviceType;

-(void)setNextViewController:(NSString *)storyID;

-(void)setPreviousViewController:(NSString *)storyBoardID;

-(void)dismissViewController;

-(void)settingSelfieEmployeeIndex;

@end
