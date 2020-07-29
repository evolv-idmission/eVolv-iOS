//
//  SecondaryIdFaceDetailsViewController.h
//  AppItDepedency
//
//  Created by Sanket Garde on 08/06/20.
//  Copyright © 2020 idmission solutions pvt ltd . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidePanelController.h"

@interface SecondaryIdFaceDetailsViewController : UIViewController <SidePanelResponse>

@property(nonatomic) NSMutableArray *pageControlFields;

@property(nonatomic) NSString *serviceType;

@property(nonatomic) NSString *serviceIdNumber;

@end
