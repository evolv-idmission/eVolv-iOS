//
//  LocationViewController.m
//  NewProjectForPageView
//
//  Created by  on 03/10/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import "LocationViewController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "AppDelegate.h"
#import "LabelUtils.h"

@interface LocationViewController ()

@end

@implementation LocationViewController {
    UILabel *titleLabel;
    UIButton *recaptureButton;
    UIButton *cameraClickBtn;
    UILabel *captureLabel;
    UILabel *latitudeValueLabel, *longitudeValueLabel;
    UILabel *locationLabel, *latitudeLabel, *longitudeLabel;
    bool isCapture;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    isCapture=true;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*30, (height/100)*0, width - (width/100)*40, (width/100)*10)];
//    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",[ArrayObjectController getTitleStringForDictionary]]];
    [titleLabel setText:[LabelUtils getLabelForKey:@"location_capture"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*60, (width/100)*0.5)];
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
    [cameraClickBtn setImage:[UIImage imageNamed:@"Location_Capture.png"] forState:UIControlStateNormal];
    [self.view addSubview:cameraClickBtn];
    
    captureLabel = [[UILabel alloc] initWithFrame:CGRectMake(cameraClickBtn.frame.origin.x + cameraClickBtn.frame.size.width/2 - (width/100)*15, cameraClickBtn.frame.origin.y + cameraClickBtn.frame.size.height + (height/100)*2, (width/100)*30, (width/100)*5)];
    
    //[captureLabel setText:titlesArray[4]];
    [captureLabel setText:[LabelUtils getLabelForKey:@"capture"]];
    [captureLabel setTextAlignment:NSTextAlignmentCenter];
    [captureLabel setAlpha:0.5];
    [captureLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:captureLabel];
    
    //Location label
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(cameraClickBtn.frame.origin.x + cameraClickBtn.frame.size.width/2 - (width/100)*15, cameraClickBtn.frame.origin.y - (height/100)*5, (width/100)*30, (height/100)*7)];
    [locationLabel setText:[LabelUtils getLabelForKey:@"location"]];
    [locationLabel setTextAlignment:NSTextAlignmentCenter];
    [locationLabel setAlpha:0.7];
    [locationLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:locationLabel];
    
    //LatitudeLabel
    latitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(locationLabel.frame.origin.x + locationLabel.frame.size.width/2 - (width/100)*25, locationLabel.frame.origin.y + locationLabel.frame.size.height, (width/100)*25, (height/100)*5)];
    [latitudeLabel setText:[LabelUtils getLabelForKey:@"latitude"]];
    [latitudeLabel setTextAlignment:NSTextAlignmentCenter];
    [latitudeLabel setAlpha:0.5];
    [latitudeLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:latitudeLabel];
    
    //Latitude Value label
    latitudeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(locationLabel.frame.origin.x + locationLabel.frame.size.width/2, locationLabel.frame.origin.y + locationLabel.frame.size.height, (width/100)*25, (height/100)*5)];
    [latitudeValueLabel setTextAlignment:NSTextAlignmentCenter];
    [latitudeValueLabel setAlpha:0.5];
    [latitudeValueLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:latitudeValueLabel];
    
    //Longitude Value
    longitudeLabel = [[UILabel alloc] initWithFrame:CGRectMake(locationLabel.frame.origin.x + locationLabel.frame.size.width/2 - (width/100)*25, latitudeValueLabel.frame.origin.y + latitudeValueLabel.frame.size.height, (width/100)*25, (height/100)*5)];
    [longitudeLabel setText:[LabelUtils getLabelForKey:@"longitude"]];
    [longitudeLabel setTextAlignment:NSTextAlignmentCenter];
    [longitudeLabel setAlpha:0.5];
    [longitudeLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:longitudeLabel];
    
    //Longitude Value Label
    longitudeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(locationLabel.frame.origin.x + locationLabel.frame.size.width/2, longitudeLabel.frame.origin.y, (width/100)*25, (height/100)*5)];
    [longitudeValueLabel setTextAlignment:NSTextAlignmentCenter];
    [longitudeValueLabel setAlpha:0.5];
    [longitudeValueLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:longitudeValueLabel];

    [latitudeValueLabel setHidden:YES];
    [longitudeValueLabel setHidden:YES];
    [locationLabel setHidden:YES];
    [latitudeLabel setHidden:YES];
    [longitudeLabel setHidden:YES];
    
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
    [backBtn setBackgroundColor:[UIColor blackColor]];
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:backBtn];
    
    //Next
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake(recaptureButton.frame.origin.x + (recaptureButton.frame.size.width/100)*52, backBtn.frame.origin.y , (recaptureButton.frame.size.width/100)*48, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:nextBtn];
    
}

-(void)captureBtn:(UIButton*)button {
     [AppItSDK getGPSCoordinate:[ArrayObjectController getPageDelegate]];
}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
}
- (void)viewOnTouch:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    if(isCapture){
        [AppItSDK getGPSCoordinate:[ArrayObjectController getPageDelegate]];
    }
}
-(void)gpsResponse : (NSMutableDictionary*) result {
    
    if([[result objectForKey:@"statusCode"] isEqualToString:@"0"]) {
        NSString *latitude = [result objectForKey:@"latitude"];
        NSString *longitude = [result objectForKey:@"longitude"];
        [cameraClickBtn setHidden:YES];
        [captureLabel setHidden:YES];
        
        [latitudeValueLabel setHidden:NO];
        [longitudeValueLabel setHidden:NO];
        [locationLabel setHidden:NO];
        [latitudeLabel setHidden:NO];
        [longitudeLabel setHidden:NO];
        
        [latitudeValueLabel setText:latitude];
        [longitudeValueLabel setText:longitude];
        [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
        isCapture=false;
    }
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

