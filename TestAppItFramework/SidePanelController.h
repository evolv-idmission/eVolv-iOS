//
//  SidePanelController.h
//  SDKNewDesign
//
//  Created by  on 30/09/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SidePanelResponse <NSObject>
@required
-(void)sidePanelBtnClicked : (NSString*) controllerType;
@end

@interface SidePanelController : UIViewController {
    
    IBOutlet UIView *transV;
    IBOutlet UIView *sidePanel;
    
}

@property(nonatomic)IBOutlet UIView *sidePanel;
@property(nonatomic)IBOutlet UIView *transV;
@property(nonatomic,assign)id delegate;
@property (weak, nonatomic) IBOutlet UILabel *versionNumber;
@property (weak, nonatomic) IBOutlet UILabel *appName;

@property(nonatomic)IBOutlet UIButton *accountSetUpBtn;
@property(nonatomic)IBOutlet UIButton *processFlowBtn;
@property(nonatomic)IBOutlet UIButton *aboutUsBtn;

- (IBAction)accountSetUpBtn:(id)sender;
- (IBAction)processFlowBtn:(id)sender;


@end
