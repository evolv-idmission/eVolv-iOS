//
//  SidePanelController.m
//  SDKNewDesign
//
//  Created by  on 30/09/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import "SidePanelController.h"
#import "AccountSetUpViewController.h"
#import "ArrayObjectController.h"
#import "LabelUtils.h"

@interface SidePanelController ()

@end

@implementation SidePanelController
@synthesize sidePanel, transV;
bool isSnackBarVisible;
UILabel *showMSGLabel;
NSTimer *fiveSecondTimer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    _accountSetUpBtn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    _accountSetUpBtn.titleLabel.numberOfLines = 2;
    
    _appName.lineBreakMode = UILineBreakModeWordWrap;
    [_appName setFont:[UIFont boldSystemFontOfSize:18]];
    _appName.numberOfLines = 2;
    
    isSnackBarVisible = false;
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSidePanel:)];
    tapper.numberOfTapsRequired = 1;
    [transV addGestureRecognizer:tapper];
    
    [transV setHidden:NO];
    [UIView transitionWithView:sidePanel duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        CGRect frame = sidePanel.frame;
        frame.origin.x = 0;
        sidePanel.frame = frame;
        
    } completion:nil];
    
    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if (!version) {
        version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    }
    NSString * buildnumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSMutableString *versionString = [NSMutableString stringWithFormat:@"%@ %@(%@)", [LabelUtils getLabelForKey:@"sdk_version"], version, buildnumber];
    
    [_versionNumber setText:versionString];
    [_aboutUsBtn setTitle:[LabelUtils getLabelForKey:@"about_us"] forState:UIControlStateNormal];
    [_processFlowBtn setTitle:[LabelUtils getLabelForKey:@"process_flow"] forState:UIControlStateNormal];
    [_accountSetUpBtn setTitle:[LabelUtils getLabelForKey:@"account_setup"] forState:UIControlStateNormal];
    [_appName setText:[LabelUtils getLabelForKey:@"evolve_test_application"]];
}

-(void)hideSidePanel:(UIGestureRecognizer *)gesture {
    
    if(gesture.state == UIGestureRecognizerStateEnded) {
        [transV setHidden:YES];
        [UIView transitionWithView:sidePanel duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = sidePanel.frame;
            frame.origin.x = -sidePanel.frame.size.width;
            sidePanel.frame = frame;
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }];
    }
}

- (IBAction)accountSetUpBtn:(id)sender {
    NSLog(@"Account Btn Clicked");
    [transV setHidden:YES];
        [UIView transitionWithView:sidePanel duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = sidePanel.frame;
            frame.origin.x = -sidePanel.frame.size.width;
            sidePanel.frame = frame;
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            [_delegate sidePanelBtnClicked:@"AccountSetUP"];
        }];
}

- (IBAction)processFlowBtn:(id)sender {
    if([ArrayObjectController getServiceDetails]>0){
    NSLog(@"Process Flow Btn Clicked");
    [transV setHidden:YES];
    [UIView transitionWithView:sidePanel duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        CGRect frame = sidePanel.frame;
        frame.origin.x = -sidePanel.frame.size.width;
        sidePanel.frame = frame;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        [_delegate sidePanelBtnClicked:@"ProcessFlow"];
    }];
    }else {
         [self snackBarView:@"Initialize Account Setup First"];
    }
}
-(void)snackBarView:(NSString*)snackMessage {

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if(!isSnackBarVisible) {
        showMSGLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height - (height/100)*8 + (height/100)*8, width, (height/100)*8)];
        [showMSGLabel setText:snackMessage];
        [showMSGLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#5D5A59" alpha:1.0]];
        [showMSGLabel setTextAlignment:NSTextAlignmentCenter];
        [showMSGLabel setTextColor:[UIColor whiteColor]];
        //    [self.navigationController.view addSubview:showMSGLabel];
        [self.navigationController.view addSubview:showMSGLabel];
        [self.navigationController.view bringSubviewToFront:showMSGLabel];
        isSnackBarVisible = true;
        [UIView transitionWithView:showMSGLabel duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect frame = showMSGLabel.frame;
            frame.origin.y = showMSGLabel.frame.origin.y - (height/100)*8;
            showMSGLabel.frame = frame;
            
        } completion:^(BOOL finished) {
            [self startTimedTask];
        }];
    }
}

- (void)startTimedTask
{
    fiveSecondTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(performBackgroundTask) userInfo:nil repeats:NO];
}
- (void)performBackgroundTask
{
    //Update UI
    int width = self.navigationController.view.frame.size.width;
    int height = self.navigationController.view.frame.size.height;
    [UIView transitionWithView:showMSGLabel duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        CGRect frame = showMSGLabel.frame;
        frame.origin.y = showMSGLabel.frame.origin.y + (height/100)*8;
        showMSGLabel.frame = frame;
        [self startTimedTask];
        
    } completion:^(BOOL finished) {
        [showMSGLabel removeFromSuperview];
        [fiveSecondTimer invalidate];
        isSnackBarVisible = false;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(NSString*)retrieveSetting:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:key];
}

-(NSString*)retrieveSetting:(NSString*)key defaultValue:(NSString*)defaultValue{
    NSString *val = [self retrieveSetting:key];
    if(val != nil){
        return val;
    }else{
        return defaultValue;
    }
}

@end
