//
//  FinalStepController.h
//  AppItDepedency
//
//  Created by  on 17/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidePanelController.h"
#import <AppItFramework/AppItSDK.h>

@interface FinalStepController : UIViewController <SidePanelResponse>

@property(nonatomic) NSString *serviceType;
//@property (nonatomic) NSMutableDictionary *getAdditionalDataDictionary;
@property (nonatomic) NSMutableDictionary *customProductDefinationDict;
@end
