//
//  VideoConfViewController.m
//  AppItDepedency
//
//  Created by Dipen Patel on 11/08/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import "VideoConfViewController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "LabelUtils.h"

@interface VideoConfViewController ()

@end

@implementation VideoConfViewController{
    UILabel *titleLabel;
    UIButton *recaptureButton;
    UIImageView *resultImage;
    UIButton *cameraClickBtn;
    UILabel *captureLabel;
    bool isCapture;
    
    UILabel *showMSGLabel;
    NSTimer *fiveSecondTimer;
    bool isSnackBarVisible;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    isCapture = true;
    isSnackBarVisible=false;
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    //    int height = self.view.frame.size.height;
    //    int width = self.view.frame.size.width;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSArray *titlesArray = [ArrayObjectController getSnippetFieldDict];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*0, width - (width/100)*50, (width/100)*10)];
    //    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",titlesArray[0]]];
    //    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",[ArrayObjectController getTitleStringForDictionary]]];
    [titleLabel setText:[LabelUtils getLabelForKey:@"video_conference"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    [self initUI];
}

-(void)initUI {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSArray *titlesArray = [ArrayObjectController getSnippetFieldDict];
    
    UIView *backGroundWhiteView = [[UIView alloc] initWithFrame:CGRectMake((width/100)*5, titleLabel.frame.origin.y + titleLabel.frame.size.height + (height/100)*2, (width/100)*90, (height/100)*35)];
    [backGroundWhiteView setBackgroundColor:[UIColor whiteColor]];
    backGroundWhiteView.layer.borderWidth = 0.2;
    backGroundWhiteView.layer.cornerRadius = 5.0;
    backGroundWhiteView.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:backGroundWhiteView];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(viewOnTouch:)];
    [backGroundWhiteView addGestureRecognizer:singleFingerTap];
    
    
    float cameraClickX = (backGroundWhiteView.frame.origin.x + backGroundWhiteView.frame.size.width)/2 - (width/100)*1;
    float cameraClickY = (backGroundWhiteView.frame.origin.y + backGroundWhiteView.frame.size.height)/2 - (width/100)*1;
    
    cameraClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraClickBtn.frame = CGRectMake(cameraClickX, cameraClickY, (width/100)*10, (width/100)*10);
    cameraClickBtn.center = backGroundWhiteView.center;
    [cameraClickBtn setImage:[UIImage imageNamed:@"panelcamera.png"] forState:UIControlStateNormal];
    [self.view addSubview:cameraClickBtn];
    
//    captureLabel = [[UILabel alloc] initWithFrame:CGRectMake(cameraClickBtn.frame.origin.x + cameraClickBtn.frame.size.width/2 - (width/100)*15, cameraClickBtn.frame.origin.y + cameraClickBtn.frame.size.height + (height/100)*2, (width/100)*30, (width/100)*5)];

    captureLabel = [[UILabel alloc] initWithFrame:CGRectMake(backGroundWhiteView.bounds.origin.x + backGroundWhiteView.bounds.size.width*0.10, cameraClickBtn.frame.origin.y + cameraClickBtn.frame.size.height + (height/100)*2, backGroundWhiteView.bounds.size.width - backGroundWhiteView.bounds.size.width*0.10, backGroundWhiteView.bounds.size.height*0.30)];
    
    [captureLabel setText:[LabelUtils getLabelForKey:@"capture"]];
    [captureLabel setTextAlignment:NSTextAlignmentCenter];
    [captureLabel setAlpha:0.5];
    [captureLabel setFont:[UIFont systemFontOfSize:14]];
    [captureLabel setNumberOfLines:0];
    [captureLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.view addSubview:captureLabel];
    
    //    resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (backGroundWhiteView.frame.size.width/100)*25, backGroundWhiteView.frame.origin.y + (backGroundWhiteView.frame.size.height/100)*2, (backGroundWhiteView.frame.size.width/100)*50, backGroundWhiteView.frame.size.height - (backGroundWhiteView.frame.size.height/100)*4)];
    resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (width/100)*1, backGroundWhiteView.frame.origin.y + (height/100)*1, backGroundWhiteView.frame.size.width - (width/100)*2, backGroundWhiteView.frame.size.height - (height/100)*2)];
    resultImage.contentMode = UIViewContentModeScaleAspectFit;
    //[resultImage setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:resultImage];
    
    // Recapture Button
    recaptureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(backGroundWhiteView.frame.origin.x, backGroundWhiteView.frame.origin.y + backGroundWhiteView.frame.size.height + (height/100)*3, backGroundWhiteView.frame.size.width, (height/100)*6);
    [recaptureButton setFrame:frame];
    recaptureButton.layer.cornerRadius = 20;
    recaptureButton.clipsToBounds = YES;
    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"capture"] forState:UIControlStateNormal];
    recaptureButton.titleLabel.textColor = [UIColor whiteColor];
    [recaptureButton setBackgroundColor:[UIColor blackColor]];
    [recaptureButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [recaptureButton addTarget:self action:@selector(captureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recaptureButton];
    
    //Back
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(recaptureButton.frame.origin.x, recaptureButton.frame.origin.y + recaptureButton.frame.size.height + (height/100)*2, (recaptureButton.frame.size.width/100)*48, (height/100)*6);
    [backBtn setFrame:saveAccountframe];
    backBtn.layer.cornerRadius = 20;
    backBtn.clipsToBounds = YES;
    [backBtn setTitle:[LabelUtils getLabelForKey:@"back_capture"] forState:UIControlStateNormal];
    backBtn.titleLabel.textColor = [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [backBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:backBtn];
    
    //Next
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    CGRect editAccountframe = CGRectMake(backBtn.frame.origin.x + backBtn.frame.size.width + (recaptureButton.frame.size.width/100)*5, backBtn.frame.origin.y , (recaptureButton.frame.size.width/100)*45, (width/100)*12);
    CGRect editAccountframe = CGRectMake(recaptureButton.frame.origin.x + (recaptureButton.frame.size.width/100)*52, backBtn.frame.origin.y , (recaptureButton.frame.size.width/100)*48, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:nextBtn];
    
}
- (void)viewOnTouch:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    if(isCapture){
        [self checkCameraPermission];
    }
}

-(void)captureBtn:(UIButton*)button {
    [self checkCameraPermission];
}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)setResult:(NSMutableDictionary *)resultDic{
    NSLog(@"Result:: %@", resultDic);
    
    if([[resultDic objectForKey:@"statusCode"] isEqualToString:@"0"]){
        [captureLabel setText:@"Conference Complete"];
        [recaptureButton setEnabled:false];
        [recaptureButton setAlpha:0.3];
    }else{
        [captureLabel setText:@"Conference is incomplete. Please click again to re-join"];
    }
}

//Run time Permission Asking
-(void) checkCameraPermission {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(status == AVAuthorizationStatusAuthorized) { // authorized
        NSLog(@"camera authorized");
        [AppItSDK startVideoConferencing:[ArrayObjectController getPageDelegate] videoConferenceData:nil];
    }
    else if(status == AVAuthorizationStatusDenied){ // denied
        if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType: completionHandler:)]) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                // Will get here on both iOS 7 & 8 even though camera permissions weren't required
                // until iOS 8. So for iOS 7 permission will always be granted.
                
                NSLog(@"DENIED");
                
                if (granted) {
                    // Permission has been granted. Use dispatch_async for any UI updating
                    // code because this block may be executed in a thread.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [AppItSDK startVideoConferencing:[ArrayObjectController getPageDelegate] videoConferenceData:nil];
                    });
                } else {
                    NSLog(@"Not Authorized");
                    // Permission has been denied.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self snackBarView:@"Need to enable CAMERA permission."];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
                            if (canOpenSettings)
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                        });
                    });
                }
            }];
        }
    }
    else if(status == AVAuthorizationStatusRestricted){ // restricted
        [self snackBarView:@"Need to enable CAMERA permission."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
            if (canOpenSettings)
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        });
    }
    else if(status == AVAuthorizationStatusNotDetermined){ // not determined
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                NSLog(@"camera authorized");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [AppItSDK startVideoConferencing:[ArrayObjectController getPageDelegate] videoConferenceData:nil];
                });
            }
        }];
    }
}

//SnackBar
-(void)snackBarView:(NSString*)snackMessage {
    
    int width = self.navigationController.view.frame.size.width;
    int height = self.navigationController.view.frame.size.height;
    
    if(!isSnackBarVisible) {
        showMSGLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height - (height/100)*8 + (height/100)*8, width, (height/100)*8)];
        [showMSGLabel setText:snackMessage];
        [showMSGLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#5D5A59" alpha:1.0]];
        [showMSGLabel setTextAlignment:NSTextAlignmentCenter];
        [showMSGLabel setTextColor:[UIColor whiteColor]];
        
        //if(![showMSGLabel isDescendantOfView:self.navigationController.view]) {
        isSnackBarVisible = true;
        [self.navigationController.view addSubview:showMSGLabel];
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
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        //Do background work
    //        dispatch_async(dispatch_get_main_queue(), ^{
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
    
    //       });
    //    });
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
