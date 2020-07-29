//
//  IdFaceDetailsViewController.h
//  AppItDepedency
//
//  Created by  on 16/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidePanelController.h"

@interface IdFaceDetailsViewController : UIViewController <SidePanelResponse>

@property(nonatomic) NSMutableArray *pageControlFields;

@property(nonatomic) NSString *serviceType;

@property(nonatomic) NSString *serviceIdNumber;

@end
