//
//  FirstViewController.m
//  NewProjectForPageView
//
//  Created by  on 03/10/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import "FirstViewController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "AppDelegate.h"
#import "LabelUtils.h"

@interface FirstViewController ()

@end

@implementation FirstViewController {
    //UILabel *leftLabel;
    UILabel *titleLabel;
    UIButton *recaptureButton;
    UIButton *configurationButton;
    UIImageView *resultImage;
    UIButton *cameraClickBtn;
    UILabel *captureLabel;
    bool isCapture;
    
    UIScrollView *scrollView;
    UIImageView *downUPArrowImage;
    UITextField *voiceRecTimeTextField;
    bool isVisible;
    UIButton *isTransparentCheckBox;
    bool isTransparent;
}
//@synthesize labelLeft, labelRight;
- (void)viewDidLoad {
    [super viewDidLoad];
    isCapture = true;
    isTransparent = false;
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSArray *titlesArray = [ArrayObjectController getSnippetFieldDict];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*0, width - (width/100)*50, (width/100)*10)];
//    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",titlesArray[0]]];
//    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",[ArrayObjectController getTitleStringForDictionary]]];
    [titleLabel setText:[LabelUtils getLabelForKey:@"signature_capture_tab"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    [self initUI];
    
    configurationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [configurationButton setBackgroundColor:[UIColor grayColor]];
    configurationButton.frame = CGRectMake(0, [ArrayObjectController getPageControlY] - (height/100)*8, width, (height/100)*8);
    [configurationButton setTitle:[LabelUtils getLabelForKey:@"configuration"] forState:UIControlStateNormal];
    [configurationButton addTarget:self action:@selector(configurationBtnClicked:)
                  forControlEvents:UIControlEventTouchUpInside];
    [ArrayObjectController addLinearGradientToView:configurationButton TopColor:[ArrayObjectController colorwithHexString:@"#00A579" alpha:1.0] BottomColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:configurationButton];
    
    //    //Down Arrow Image
    downUPArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(configurationButton.frame.origin.x + configurationButton.frame.size.width/2 - (width/100)*29, configurationButton.frame.origin.y + (configurationButton.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downUPArrowImage setImage:[UIImage imageNamed:@"Up_Arrow.png"]];
    [self.view addSubview:downUPArrowImage];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ArrayObjectController getPageControlY] - (height/100)*25 + (height/100)*25, width, (height/100)*25)];
    [scrollView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#e6fff9" alpha:1.0]];
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView];
    float scrollViewContentSizeHt =  [self scrollViewUI:scrollView];
    
    [scrollView setContentSize:CGSizeMake(width, scrollViewContentSizeHt + (height/100)*3)];
    
    [voiceRecTimeTextField setDelegate:(id)self];
    [voiceRecTimeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [voiceRecTimeTextField setText:[self retrieveSetting:@"voiceRecordingTime" defaultValue:@"15"]];
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
    [cameraClickBtn setImage:[UIImage imageNamed:@"Signature.png"] forState:UIControlStateNormal];
    [self.view addSubview:cameraClickBtn];
    
    captureLabel = [[UILabel alloc] initWithFrame:CGRectMake(cameraClickBtn.frame.origin.x + cameraClickBtn.frame.size.width/2 - (width/100)*15, cameraClickBtn.frame.origin.y + cameraClickBtn.frame.size.height + (height/100)*2, (width/100)*30, (width/100)*5)];
    
    //[captureLabel setText:titlesArray[0]];
    [captureLabel setText:[LabelUtils getLabelForKey:@"capture"]];
    [captureLabel setTextAlignment:NSTextAlignmentCenter];
    [captureLabel setAlpha:0.5];
    [captureLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:captureLabel];
    
    resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (backGroundWhiteView.frame.size.width/100)*25, backGroundWhiteView.frame.origin.y + (backGroundWhiteView.frame.size.height/100)*2, (backGroundWhiteView.frame.size.width/100)*50, backGroundWhiteView.frame.size.height - (backGroundWhiteView.frame.size.height/100)*4)];
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
    CGRect editAccountframe = CGRectMake(recaptureButton.frame.origin.x + (recaptureButton.frame.size.width/100)*55, backBtn.frame.origin.y , (recaptureButton.frame.size.width/100)*45, (height/100)*6);
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
    if(isTransparent){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"Y" forKey:@"signature_capture_background"];
        [AppItSDK captureSignature:[ArrayObjectController getPageDelegate] uiConfigDictionary:dic];
    }else{
        [AppItSDK captureSignature:[ArrayObjectController getPageDelegate]];
    }
}

-(void)captureBtn:(UIButton*)button {

    if(isTransparent){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"Y" forKey:@"signature_capture_background"];
        [AppItSDK captureSignature:[ArrayObjectController getPageDelegate] uiConfigDictionary:dic];
    }else{
        [AppItSDK captureSignature:[ArrayObjectController getPageDelegate]];
    }
}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)setResultImage:(UIImage *)resImage {
    isCapture=false;
    [cameraClickBtn setHidden:YES];
    [captureLabel setHidden:YES];
    [resultImage setImage:resImage];
    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
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

- (float)scrollViewUI:(UIScrollView *)scrollView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    isTransparentCheckBox = [UIButton buttonWithType:UIButtonTypeCustom];
    isTransparentCheckBox.frame = CGRectMake((width/100)*4, (height/100)*2,(width/100)*7, (height/100)*4);
    if(isTransparent){
        [isTransparentCheckBox setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    }else{
        [isTransparentCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    }
    [isTransparentCheckBox addTarget:self action:@selector(finalSubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:isTransparentCheckBox];
    
    //Id Outline color
//    UILabel *voiceRecTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,(width/100)*70, (height/100)*2)];
    UILabel *voiceRecTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(isTransparentCheckBox.frame.origin.x + isTransparentCheckBox.frame.size.width, isTransparentCheckBox.frame.origin.y, (width/100)*88, (height/100)*4)];
    [voiceRecTimeLabel setText:[LabelUtils getLabelForKey:@"transparent_background"]];
    [voiceRecTimeLabel setAlpha:0.7];
    [voiceRecTimeLabel setFont:[UIFont systemFontOfSize:14]];
    voiceRecTimeLabel.numberOfLines = 0;
    voiceRecTimeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:voiceRecTimeLabel];
    
    //id outline color TextField
    voiceRecTimeTextField = [[UITextField alloc] initWithFrame:CGRectMake(voiceRecTimeLabel.frame.origin.x, voiceRecTimeLabel.frame.origin.y + voiceRecTimeLabel.frame.size.height + (height/100)*1, (width/100)*88, (height/100)*4)];
    [voiceRecTimeTextField setFont:[UIFont systemFontOfSize:12]];
    voiceRecTimeTextField.layer.cornerRadius = 5;
    voiceRecTimeTextField.layer.borderWidth = 1.0;
    voiceRecTimeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [voiceRecTimeTextField setAlpha:0.7];
    [voiceRecTimeTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    voiceRecTimeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:voiceRecTimeTextField];
    [voiceRecTimeTextField setHidden:true];
    
    //Save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(isTransparentCheckBox.frame.origin.x, voiceRecTimeTextField.frame.origin.y + voiceRecTimeTextField.frame.size.height + (height/100)*2, (width/100)*44, (height/100)*6);
    [saveBtn setFrame:saveAccountframe];
    saveBtn.layer.cornerRadius = 20;
    saveBtn.clipsToBounds = YES;
    [saveBtn setTitle:[LabelUtils getLabelForKey:@"save"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.titleLabel.textColor = [UIColor whiteColor];
    [saveBtn setBackgroundColor:[UIColor blackColor]];
    [saveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:saveBtn];
    
    //Reset Button
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake((width/100)*52 , saveBtn.frame.origin.y , saveBtn.frame.size.width, (height/100)*6);
    [resetBtn setFrame:editAccountframe];
    resetBtn.layer.cornerRadius = 20;
    resetBtn.clipsToBounds = YES;
    [resetBtn setTitle:[LabelUtils getLabelForKey:@"reset"] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetButton:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.titleLabel.textColor = [UIColor whiteColor];
    [resetBtn setBackgroundColor:[UIColor blackColor]];
    [resetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:resetBtn];
    
    return resetBtn.frame.origin.y + resetBtn.frame.size.height;
}

-(void)configurationBtnClicked:(UIButton*)button {
    [self configBtnClickMethod];
}

-(void)configBtnClickMethod {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if(!isVisible) {
        [UIView transitionWithView:scrollView duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect buttonFrame = configurationButton.frame;
            buttonFrame.origin.y = scrollView.frame.origin.y - scrollView.frame.size.height- buttonFrame.size.height;
            configurationButton.frame = buttonFrame;
            
            CGRect frame = scrollView.frame;
            frame.origin.y = frame.origin.y - frame.size.height;
            scrollView.frame = frame;
            isVisible = true;
            
            CGRect arrowFrame = downUPArrowImage.frame;
            arrowFrame.origin.y = configurationButton.frame.origin.y + (configurationButton.frame.size.height/2) - (height/100)*2;
            downUPArrowImage.frame = arrowFrame;
            
        } completion:^(BOOL finished) {
            [downUPArrowImage setImage:[UIImage imageNamed:@"Down_Arrow.png"]];
        }];
    } else {
        [UIView transitionWithView:scrollView duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect buttonFrame = configurationButton.frame;
            buttonFrame.origin.y = scrollView.frame.origin.y + scrollView.frame.size.height - buttonFrame.size.height;
            configurationButton.frame = buttonFrame;
            
            CGRect frame = scrollView.frame;
            frame.origin.y =frame.origin.y +scrollView.frame.size.height;
            scrollView.frame = frame;
            isVisible = false;
            
            CGRect arrowFrame = downUPArrowImage.frame;
            arrowFrame.origin.y = configurationButton.frame.origin.y + (configurationButton.frame.size.height/2) - (height/100)*2;
            downUPArrowImage.frame = arrowFrame;
            
        } completion:^(BOOL finished) {
            [downUPArrowImage setImage:[UIImage imageNamed:@"Up_Arrow.png"]];
        }];
    }
}

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

-(void)finalSubmitBtn:(UIButton*)button {
    if(isTransparent) {
        [isTransparentCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        isTransparent = false;
    } else {
        [isTransparentCheckBox setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        isTransparent = true;
    }
}

-(void)saveButton:(UIButton*)button {
//    [self saveSetting:@"voiceCaptureTime" value:[voiceRecTimeTextField text]];
    [self configBtnClickMethod];
//    [self snackBarView:[LabelUtils getLabelForKey:@"id_capture_save_msg"]];
}

-(void)resetButton:(UIButton*)button {
//    [voiceRecTimeTextField setText:@"15"];
//    [self saveSetting:@"voiceCaptureTime" value:[voiceRecTimeTextField text]];
}

@end

