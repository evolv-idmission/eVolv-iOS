//
//  ProcessFlowController.h
//  SDKNewDesign
//
//  Created by  on 30/09/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidePanelController.h"
#import <AppItFramework/AppItSDK.h>

@interface ProcessFlowController : UIViewController <SidePanelResponse, AppItSDKResponse>

@property (retain) NSMutableArray *sortedPageControlArray;
@end
