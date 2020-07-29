//
//  ReqResViewController.h
//  AppItDepedency
//
//  Created by  on 30/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidePanelController.h"
#import <AppItFramework/AppItSDK.h>

@interface ReqResViewController : UIViewController <UIDocumentInteractionControllerDelegate, SidePanelResponse> {
    UIDocumentInteractionController *documentInteractionController;
}

@property(nonatomic) NSString* requestResponseType;

@end
