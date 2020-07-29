//
//  SecondViewController.m
//  NewProjectForPageView
//
//  Created by  on 03/10/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import "SecondViewController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "AppDelegate.h"
#import "NSStringUtilsDemo.h"
#import "LabelUtils.h"

@interface SecondViewController ()

@end

@implementation SecondViewController {
    
    UILabel *titleLabel;
    
    bool isVisible, isCapture;
    UIButton *configurationButton;
    UIScrollView *scrollView;
    
    int mAlpha;
    int mLightThreshold, mFocusThreshold, maxFocusThreshold, mGlarePercentage, mMaxImageSize, mImageHeight, mImageWidth, mCaptureButtonTime;
    NSString *dFaceOutlineColor, *dDetectedFaceOutlineColor, *dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutlineColor,*dIdOutlineColor, *dDetectedIdOutlineColor, *dOutsideIdOutlineColor,*dDetectedPOAOutlineColor,*dDetectedIdOutsideOutlineColor,*dDetectedPOAOutsideOutlineColor;
    
    //TextField
    UITextField *idOutlineColorTextField, *idOutlineColorTransTextField, *detectedIdOutlineColorTextField, *detectedIdOutlineColorTransTextField, *colorOutsideOutlineTextField, *colorOutsideOutlineTransTextField, *detectedColorOutsideOutlineTextField, *detectedColorOutsideOutlineTransTextField, *lightThresholdTextField, *minFocusThreshold, *maxFocusThresholdTextField, *glarePercentageTextField, *enableCapBtnTimeTextField, *maxImageSize, *imageWidthTextField, *imageHeightTextField, *showTitleImgTextField;
    
    //Configuration Radio Btn
    UIButton *portraitRadioBtn, *landscapeRadioBtn, *noInstRadioBtn, *yesInstRadioBtn;
    
    //Bool
    bool isPortrait, showInstScreen;
    
    NSArray *_selectedPickerData;
    NSArray *showTitlePickerData;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    UIImageView *resultImage;
    UIButton *recaptureButton;
    UITextField *genericDocTextField;
    
    UIImageView *downUPArrowImage ;
    UILabel *showMSGLabel;
    NSTimer *fiveSecondTimer;
    bool isSnackBarVisible;
    
}

-(void)viewDidAppear:(BOOL)animated {
    isSnackBarVisible = false;
    isCapture = true;

    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
   // showTitlePickerData = @[@"None", @"Title Image 1"];
   // _selectedPickerData = @[@"None", @"Title Image 1"];
    showTitlePickerData = @[[LabelUtils getLabelForKey:@"none"], [LabelUtils getLabelForKey:@"title_image"]];
    _selectedPickerData = @[[LabelUtils getLabelForKey:@"none"], [LabelUtils getLabelForKey:@"title_image"]];
    [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    myPickerView.layer.borderWidth = 1.0;
    myPickerView.layer.cornerRadius = 5.0;
    myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [showTitleImgTextField setInputView:myPickerView];
    [showTitleImgTextField setText:showTitlePickerData[0]];
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [showTitleImgTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == showTitleImgTextField){
        _selectedPickerData = showTitlePickerData;
        [myPickerView reloadAllComponents];
    }
    return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_selectedPickerData count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_selectedPickerData objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component{
    
    if([_selectedPickerData isEqualToArray:showTitlePickerData]){
        [showTitleImgTextField setText:showTitlePickerData[row]];
        [showTitleImgTextField setTag:row+1];
    }
}
//Picker Changes End

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isVisible = false;
    
    isPortrait = true;
    //showInstScreen = false;
    showInstScreen = true;

    mAlpha = 1;
    mLightThreshold=70, mFocusThreshold=12, maxFocusThreshold = 35, mGlarePercentage=25, mMaxImageSize=500, mImageHeight=1170, mImageWidth=800, mCaptureButtonTime=60;
    dFaceOutlineColor = @"FFAD36", dDetectedFaceOutlineColor = @"6EB24C", dOutsideFaceOutlineColor = @"487D95",dDetectedOutsideFaceOutlineColor = @"487D95",dIdOutlineColor = @"FFAD36", dDetectedIdOutlineColor = @"6EB24C", dOutsideIdOutlineColor = @"487D95",dDetectedPOAOutlineColor = @"6EB24C",dDetectedIdOutsideOutlineColor = @"487D95",dDetectedPOAOutsideOutlineColor = @"487D95";
    
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*0, width - (width/100)*50, (width/100)*10)];
//    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",[ArrayObjectController getTitleStringForDictionary]]];
     [titleLabel setText:[LabelUtils getLabelForKey:@"document_capture"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    [self initUI];
    
    //Configuration Changes
    
    configurationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [configurationButton setBackgroundColor:[UIColor grayColor]];
    //    configurationButton.frame = CGRectMake(0, height - (height/100)*8 - 76, width, (height/100)*8);
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
    
    //    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, height - 76 - (height/100)*50 + (height/100)*50, width, (height/100)*50)];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ArrayObjectController getPageControlY] - (height/100)*50 + (height/100)*50, width, (height/100)*50)];
    [scrollView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#e6fff9" alpha:1.0]];
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView];
    float scrollViewContentSizeHt =  [self scrollViewUI:scrollView];
    
    [scrollView setContentSize:CGSizeMake(width, scrollViewContentSizeHt + (height/100)*3)];
    
    //Add numeric keyboard-Start
    [idOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [detectedIdOutlineColorTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [colorOutsideOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [detectedColorOutsideOutlineTransTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [minFocusThreshold setKeyboardType:UIKeyboardTypeNumberPad];
    [glarePercentageTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [enableCapBtnTimeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [maxImageSize setKeyboardType:UIKeyboardTypeNumberPad];
    [imageWidthTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [imageHeightTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    NSString *idoutlinecolor = [self retrieveSetting:@"idoutlinecolor" defaultValue:dIdOutlineColor];
    NSString *idoutlinetransparency = [self retrieveSetting:@"idoutlinetransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedIdOutlineColor = [self retrieveSetting:@"detectedidoutlinecolor" defaultValue:dDetectedIdOutlineColor];
    NSString *detectedIdOutlineTrans = [self retrieveSetting:@"detectedidoutlinetransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *colorOutsideOutline = [self retrieveSetting:@"idoutsideoutlinecolor" defaultValue:dOutsideIdOutlineColor];
    NSString *colorOutsideOutlineTrans = [self retrieveSetting:@"idoutsideoutlinetransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *detectedidcolorOutsideOutline = [self retrieveSetting:@"detectedidcolorOutsideOutline" defaultValue:dDetectedIdOutsideOutlineColor];
    NSString *detectedidcolorOutsideOutlineTransparency = [self retrieveSetting:@"detectedidcolorOutsideOutlineTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *lightthreshold = [self retrieveSetting:@"lightthreshold_Doc" defaultValue:[@(mLightThreshold) stringValue]];
    NSString *minfocusthreshold = [self retrieveSetting:@"focusthreshold_Doc" defaultValue:[@(mFocusThreshold) stringValue]];
    NSString *maxfocusthreshold = [self retrieveSetting:@"maxfocusthreshold_Doc" defaultValue:[@(maxFocusThreshold) stringValue]];
    NSString *glarepercentage = [self retrieveSetting:@"glarepercentage_Doc" defaultValue:[@(mGlarePercentage) stringValue]];
    NSString *capturebuttontime = [self retrieveSetting:@"capturebuttontime_Doc" defaultValue:[@(mCaptureButtonTime) stringValue]];
    NSString *maximagesize = [self retrieveSetting:@"maximagesize_Doc" defaultValue:[@(mMaxImageSize) stringValue]];
    NSString *imageheight = [self retrieveSetting:@"imageheight_Doc" defaultValue:[@(mImageHeight) stringValue]];
    NSString *imagewidth = [self retrieveSetting:@"imagewidth_Doc" defaultValue:[@(mImageWidth) stringValue]];
    
    [idOutlineColorTextField setText:idoutlinecolor];
    [idOutlineColorTransTextField setText:idoutlinetransparency];
    [detectedIdOutlineColorTextField setText:detectedIdOutlineColor];
    [detectedIdOutlineColorTransTextField setText:detectedIdOutlineTrans];
    [colorOutsideOutlineTextField setText:colorOutsideOutline];
    [colorOutsideOutlineTransTextField setText:colorOutsideOutlineTrans];
    [detectedColorOutsideOutlineTextField setText:detectedidcolorOutsideOutline];
    [detectedColorOutsideOutlineTransTextField setText:detectedidcolorOutsideOutlineTransparency];
    [lightThresholdTextField setText:lightthreshold];
    [minFocusThreshold setText:minfocusthreshold];
    [maxFocusThresholdTextField setText:maxfocusthreshold];
    [glarePercentageTextField setText:glarepercentage];
    [enableCapBtnTimeTextField setText:capturebuttontime];
    [maxImageSize setText:maximagesize];
    [imageWidthTextField setText:imagewidth];
    [imageHeightTextField setText:imageheight];
   // [showTitleImgTextField setText:@"None"];
    [showTitleImgTextField setText:[LabelUtils getLabelForKey:@"none"]];

}

- (float)scrollViewUI:(UIScrollView *)scrollView {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    //Id Outline color
    UILabel *idOutLineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*0,(width/100)*44, (height/100)*0)];
    [idOutLineColorLabel setText:[LabelUtils getLabelForKey:@"id_outline_color"]];
    [idOutLineColorLabel setAlpha:0.7];
    [idOutLineColorLabel setFont:[UIFont systemFontOfSize:11]];
    idOutLineColorLabel.numberOfLines = 0;
    idOutLineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [idOutLineColorLabel setHidden: YES];
    idOutLineColorLabel.hidden = YES;
    [scrollView addSubview:idOutLineColorLabel];
    
    //Id Outline Color Transparency
    UILabel *idOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52, (height/100)*0, (width/100)*44, (height/100)*0)];
    [idOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [idOutlineTransLabel setAlpha:0.7];
    idOutlineTransLabel.numberOfLines = 0;
    idOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [idOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [idOutlineTransLabel setHidden: YES];
    idOutlineTransLabel.hidden = YES;
    [scrollView addSubview:idOutlineTransLabel];
    
    //id outline color TextField
    idOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idOutLineColorLabel.frame.origin.y + idOutLineColorLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [idOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    idOutlineColorTextField.layer.cornerRadius = 5;
    idOutlineColorTextField.layer.borderWidth = 1.0;
    idOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idOutlineColorTextField setAlpha:0.7];
    [idOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [idOutlineColorTextField setHidden: YES];
    idOutlineColorTextField.hidden = YES;
    [scrollView addSubview:idOutlineColorTextField];
    
    //id outline color Trans TextField
    idOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, idOutlineColorTextField.frame.origin.y*0, idOutlineTransLabel.frame.size.width, (height/100)*0)];
    [idOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]]; idOutlineColorTransTextField.layer.cornerRadius = 5;
    idOutlineColorTransTextField.layer.borderWidth = 1.0;
    idOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idOutlineColorTransTextField setAlpha:0.7];
    [idOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [idOutlineColorTransTextField setHidden: YES];
    idOutlineColorTransTextField.hidden = YES;
    [scrollView addSubview:idOutlineColorTransTextField];
    
    //Detected ID Outline Color
    //Detected Id outline Color Label
    UILabel *detectedIdOutLineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idOutlineColorTextField.frame.origin.y + idOutlineColorTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [detectedIdOutLineColorLabel setText:[LabelUtils getLabelForKey:@"detected_id_outline_color"]];
    [detectedIdOutLineColorLabel setAlpha:0.7];
    [detectedIdOutLineColorLabel setFont:[UIFont systemFontOfSize:11]];
    detectedIdOutLineColorLabel.numberOfLines = 0;
    detectedIdOutLineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedIdOutLineColorLabel setHidden: YES];
    detectedIdOutLineColorLabel.hidden = YES;
    [scrollView addSubview:detectedIdOutLineColorLabel];
    
    //Detected Id Outline Color Transparency
    UILabel *detectedIdOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,idOutlineColorTransTextField.frame.origin.y + idOutlineColorTransTextField.frame.size.height +  (height/100)*0, idOutlineColorTransTextField.frame.size.width, (height/100)*0)];
    [detectedIdOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [detectedIdOutlineTransLabel setAlpha:0.7];
    detectedIdOutlineTransLabel.numberOfLines = 0;
    detectedIdOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedIdOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [detectedIdOutlineTransLabel setHidden: YES];
    detectedIdOutlineTransLabel.hidden = YES;
    [scrollView addSubview:detectedIdOutlineTransLabel];
    
    //Detected Id outline Color text field
    detectedIdOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, detectedIdOutLineColorLabel.frame.origin.y + detectedIdOutLineColorLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [detectedIdOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    detectedIdOutlineColorTextField.layer.cornerRadius = 5;
    detectedIdOutlineColorTextField.layer.borderWidth = 1.0;
    detectedIdOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedIdOutlineColorTextField setAlpha:0.7];
    [detectedIdOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedIdOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedIdOutlineColorTextField setHidden: YES];
    detectedIdOutlineColorTextField.hidden = YES;
    [scrollView addSubview:detectedIdOutlineColorTextField];
    
    //Detected Id outline Color Transparency
    detectedIdOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, detectedIdOutlineTransLabel.frame.origin.y + detectedIdOutlineTransLabel.frame.size.height + (height/100)*0, detectedIdOutlineTransLabel.frame.size.width, (height/100)*0)];
    [detectedIdOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    detectedIdOutlineColorTransTextField.layer.cornerRadius = 5;
    detectedIdOutlineColorTransTextField.layer.borderWidth = 1.0;
    detectedIdOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedIdOutlineColorTransTextField setAlpha:0.7];
    [detectedIdOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedIdOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedIdOutlineColorTransTextField setHidden: YES];
    detectedIdOutlineColorTransTextField.hidden = YES;
    [scrollView addSubview:detectedIdOutlineColorTransTextField];
    
    //Color OutsideOutline
    //Color Outside Outline Label
    UILabel *colorOutsideOutLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,detectedIdOutlineColorTextField.frame.origin.y + detectedIdOutlineColorTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [colorOutsideOutLineLabel setText:[LabelUtils getLabelForKey:@"color_outside_outline"]];
    [colorOutsideOutLineLabel setAlpha:0.7];
    [colorOutsideOutLineLabel setFont:[UIFont systemFontOfSize:11]];
    colorOutsideOutLineLabel.numberOfLines = 0;
    colorOutsideOutLineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [colorOutsideOutLineLabel setHidden: YES];
    colorOutsideOutLineLabel.hidden = YES;
    [scrollView addSubview:colorOutsideOutLineLabel];
    
    //Color Outside Outline Transparency
    UILabel *colorOutsideOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,detectedIdOutlineColorTransTextField.frame.origin.y + detectedIdOutlineColorTransTextField.frame.size.height +  (height/100)*0, idOutlineColorTransTextField.frame.size.width, (height/100)*0)];
    [colorOutsideOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [colorOutsideOutlineTransLabel setAlpha:0.7];
    colorOutsideOutlineTransLabel.numberOfLines = 0;
    colorOutsideOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [colorOutsideOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [colorOutsideOutlineTransLabel setHidden: YES];
    colorOutsideOutlineTransLabel.hidden = YES;
    [scrollView addSubview:colorOutsideOutlineTransLabel];
    
    //Color Outside Outline TextField
    colorOutsideOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, colorOutsideOutLineLabel.frame.origin.y + colorOutsideOutLineLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [colorOutsideOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    colorOutsideOutlineTextField.layer.cornerRadius = 5;
    colorOutsideOutlineTextField.layer.borderWidth = 1.0;
    colorOutsideOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [colorOutsideOutlineTextField setAlpha:0.7];
    [colorOutsideOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    colorOutsideOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [colorOutsideOutlineTextField setHidden: YES];
    colorOutsideOutlineTextField.hidden = YES;
    [scrollView addSubview:colorOutsideOutlineTextField];
    
    //Color Outside Outline Transparency TextField
    colorOutsideOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, colorOutsideOutlineTransLabel.frame.origin.y + colorOutsideOutlineTransLabel.frame.size.height + (height/100)*0, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*0)];
    [colorOutsideOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    colorOutsideOutlineTransTextField.layer.cornerRadius = 5;
    colorOutsideOutlineTransTextField.layer.borderWidth = 1.0;
    colorOutsideOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [colorOutsideOutlineTransTextField setAlpha:0.7];
    [colorOutsideOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    colorOutsideOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [colorOutsideOutlineTransTextField setHidden: YES];
    colorOutsideOutlineTransTextField.hidden = YES;
    [scrollView addSubview:colorOutsideOutlineTransTextField];
    
    //Detected Color Outside OutLine
    //Detected Color OutSide OutLine Label
    UILabel *detectedColorOutsideOutLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,colorOutsideOutlineTextField.frame.origin.y + colorOutsideOutlineTextField.frame.size.height +   (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [detectedColorOutsideOutLineLabel setText:[LabelUtils getLabelForKey:@"detected_color_outside_outline"]];
    [detectedColorOutsideOutLineLabel setAlpha:0.7];
    [detectedColorOutsideOutLineLabel setFont:[UIFont systemFontOfSize:11]];
    detectedColorOutsideOutLineLabel.numberOfLines = 0;
    detectedColorOutsideOutLineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedColorOutsideOutLineLabel setHidden: YES];
    detectedColorOutsideOutLineLabel.hidden = YES;
    [scrollView addSubview:detectedColorOutsideOutLineLabel];
    
    //Detected Color Outside Outline Transparency
    UILabel *detectedcolorOutsideOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,colorOutsideOutlineTransTextField.frame.origin.y + colorOutsideOutlineTransTextField.frame.size.height +  (height/100)*0, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*0)];
    [detectedcolorOutsideOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [detectedcolorOutsideOutlineTransLabel setAlpha:0.7];
    detectedcolorOutsideOutlineTransLabel.numberOfLines = 0;
    detectedcolorOutsideOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedcolorOutsideOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [detectedcolorOutsideOutlineTransLabel setHidden: YES];
    detectedcolorOutsideOutlineTransLabel.hidden = YES;
    [scrollView addSubview:detectedcolorOutsideOutlineTransLabel];
    
    //Detected Color Outside Outline TextField
    detectedColorOutsideOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, detectedColorOutsideOutLineLabel.frame.origin.y + detectedColorOutsideOutLineLabel.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [detectedColorOutsideOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    detectedColorOutsideOutlineTextField.layer.cornerRadius = 5;
    detectedColorOutsideOutlineTextField.layer.borderWidth = 1.0;
    detectedColorOutsideOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedColorOutsideOutlineTextField setAlpha:0.7];
    [detectedColorOutsideOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedColorOutsideOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedColorOutsideOutlineTextField setHidden: YES];
    detectedColorOutsideOutlineTextField.hidden = YES;
    [scrollView addSubview:detectedColorOutsideOutlineTextField];
    
    //Detected Color Outside Outline Trans TextField
    detectedColorOutsideOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, detectedColorOutsideOutlineTextField.frame.origin.y*0, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*0)];
    [detectedColorOutsideOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    detectedColorOutsideOutlineTransTextField.layer.cornerRadius = 5;
    detectedColorOutsideOutlineTransTextField.layer.borderWidth = 1.0;
    detectedColorOutsideOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedColorOutsideOutlineTransTextField setAlpha:0.7];
    [detectedColorOutsideOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedColorOutsideOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [detectedColorOutsideOutlineTransTextField setHidden: YES];
    detectedColorOutsideOutlineTransTextField.hidden = YES;
    [scrollView addSubview:detectedColorOutsideOutlineTransTextField];
    
    //Light Threshold
    //Light Threshold Label
    UILabel *lightThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,detectedColorOutsideOutlineTextField.frame.origin.y + detectedColorOutsideOutlineTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [lightThresholdLabel setText:[LabelUtils getLabelForKey:@"light_threshold"]];
    [lightThresholdLabel setAlpha:0.7];
    [lightThresholdLabel setFont:[UIFont systemFontOfSize:11]];
    lightThresholdLabel.numberOfLines = 0;
    lightThresholdLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:lightThresholdLabel];
    
    //Light Threshold Transparency
    UILabel *lightThresholdTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,detectedColorOutsideOutlineTransTextField.frame.origin.y + detectedColorOutsideOutlineTransTextField.frame.size.height +  (height/100)*2, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [lightThresholdTransLabel setText:[LabelUtils getLabelForKey:@"min_focus_threshold"]];
    [lightThresholdTransLabel setAlpha:0.7];
    lightThresholdTransLabel.numberOfLines = 0;
    lightThresholdTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [lightThresholdTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:lightThresholdTransLabel];
    
    //Light Threshold Text Field
    lightThresholdTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, lightThresholdLabel.frame.origin.y + lightThresholdLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [lightThresholdTextField setFont:[UIFont systemFontOfSize:12]];
    lightThresholdTextField.layer.cornerRadius = 5;
    lightThresholdTextField.layer.borderWidth = 1.0;
    lightThresholdTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [lightThresholdTextField setAlpha:0.7];
    [lightThresholdTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    lightThresholdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:lightThresholdTextField];
    
    //Light Threshold Trans Text Field
    minFocusThreshold = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, lightThresholdTextField.frame.origin.y, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [minFocusThreshold setFont:[UIFont systemFontOfSize:12]];
    minFocusThreshold.layer.cornerRadius = 5;
    minFocusThreshold.layer.borderWidth = 1.0;
    minFocusThreshold.layer.borderColor = [[UIColor grayColor]CGColor];
    [minFocusThreshold setAlpha:0.7];
    [scrollView addSubview:minFocusThreshold];
    
    //Max.Focus Threshold
    //Max Focus Threshold Label
    UILabel *maxFocusThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,lightThresholdTextField.frame.origin.y + lightThresholdTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [maxFocusThresholdLabel setText:[LabelUtils getLabelForKey:@"max_focus_threshold"]];
    [maxFocusThresholdLabel setAlpha:0.7];
    [maxFocusThresholdLabel setFont:[UIFont systemFontOfSize:11]];
    maxFocusThresholdLabel.numberOfLines = 0;
    maxFocusThresholdLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:maxFocusThresholdLabel];
    
    //Max Focus Threshold Trans
    UILabel *maxFocusThresholdTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,minFocusThreshold.frame.origin.y + minFocusThreshold.frame.size.height +  (height/100)*2, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [maxFocusThresholdTransLabel setText:[LabelUtils getLabelForKey:@"glare_percentage"]];
    [maxFocusThresholdTransLabel setAlpha:0.7];
    maxFocusThresholdTransLabel.numberOfLines = 0;
    maxFocusThresholdTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [maxFocusThresholdTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:maxFocusThresholdTransLabel];
    
    //Max Focus Threshold TextField
    maxFocusThresholdTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, maxFocusThresholdLabel.frame.origin.y + maxFocusThresholdLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [maxFocusThresholdTextField setFont:[UIFont systemFontOfSize:12]];
    maxFocusThresholdTextField.layer.cornerRadius = 5;
    maxFocusThresholdTextField.layer.borderWidth = 1.0;
    maxFocusThresholdTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [maxFocusThresholdTextField setAlpha:0.7];
    [maxFocusThresholdTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    maxFocusThresholdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:maxFocusThresholdTextField];
    
    //Max Focus Threshold Trans TextField
    glarePercentageTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, maxFocusThresholdTextField.frame.origin.y, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [glarePercentageTextField setFont:[UIFont systemFontOfSize:12]];
    glarePercentageTextField.layer.cornerRadius = 5;
    glarePercentageTextField.layer.borderWidth = 1.0;
    glarePercentageTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [glarePercentageTextField setAlpha:0.7];
    [glarePercentageTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    glarePercentageTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:glarePercentageTextField];
    
    //Enable Capture Button
    //Enable Capture Button Label
    UILabel *enableCaptureButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,maxFocusThresholdTextField.frame.origin.y + maxFocusThresholdTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*5)];
    [enableCaptureButtonLabel setText:[LabelUtils getLabelForKey:@"enable_capture_button_time"]];
    [enableCaptureButtonLabel setAlpha:0.7];
    [enableCaptureButtonLabel setFont:[UIFont systemFontOfSize:11]];
    enableCaptureButtonLabel.numberOfLines = 0;
    enableCaptureButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:enableCaptureButtonLabel];
    
    //Max button Size label
    UILabel *maxButtonSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,glarePercentageTextField.frame.origin.y + glarePercentageTextField.frame.size.height +  (height/100)*2, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [maxButtonSizeLabel setText:[LabelUtils getLabelForKey:@"max_image_size"]];
    [maxButtonSizeLabel setAlpha:0.7];
    maxButtonSizeLabel.numberOfLines = 0;
    maxButtonSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [maxButtonSizeLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:maxButtonSizeLabel];
    
    //Enable Capture Button Time TextField
    enableCapBtnTimeTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, enableCaptureButtonLabel.frame.origin.y + enableCaptureButtonLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [enableCapBtnTimeTextField setFont:[UIFont systemFontOfSize:12]];
    enableCapBtnTimeTextField.layer.cornerRadius = 5;
    enableCapBtnTimeTextField.layer.borderWidth = 1.0;
    enableCapBtnTimeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [enableCapBtnTimeTextField setAlpha:0.7];
    [enableCapBtnTimeTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    enableCapBtnTimeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:enableCapBtnTimeTextField];
    
    //Max Button Size TextField
    maxImageSize = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, enableCapBtnTimeTextField.frame.origin.y, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [maxImageSize setFont:[UIFont systemFontOfSize:12]];
    maxImageSize.layer.cornerRadius = 5;
    maxImageSize.layer.borderWidth = 1.0;
    maxImageSize.layer.borderColor = [[UIColor grayColor]CGColor];
    [maxImageSize setAlpha:0.7];
    [scrollView addSubview:maxImageSize];
    
    //Image Height/Width
    //Image Width label
    UILabel *imageWidthLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,enableCapBtnTimeTextField.frame.origin.y + enableCapBtnTimeTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [imageWidthLabel setText:[LabelUtils getLabelForKey:@"image_width"]];
    [imageWidthLabel setAlpha:0.7];
    [imageWidthLabel setFont:[UIFont systemFontOfSize:11]];
    imageWidthLabel.numberOfLines = 0;
    imageWidthLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:imageWidthLabel];
    
    //Image Height Label
    UILabel *imageHeightLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,maxImageSize.frame.origin.y + maxImageSize.frame.size.height +  (height/100)*2, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [imageHeightLabel setText:[LabelUtils getLabelForKey:@"image_height"]];
    [imageHeightLabel setAlpha:0.7];
    imageHeightLabel.numberOfLines = 0;
    imageHeightLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [imageHeightLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:imageHeightLabel];
    
    //Image Width TextField
    imageWidthTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, imageWidthLabel.frame.origin.y + imageWidthLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [imageWidthTextField setFont:[UIFont systemFontOfSize:12]];
    imageWidthTextField.layer.cornerRadius = 5;
    imageWidthTextField.layer.borderWidth = 1.0;
    imageWidthTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [imageWidthTextField setAlpha:0.7];
    [imageWidthTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    imageWidthTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:imageWidthTextField];
    
    //Image Height TextField
    imageHeightTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, imageWidthTextField.frame.origin.y, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [imageHeightTextField setFont:[UIFont systemFontOfSize:12]];
    imageHeightTextField.layer.cornerRadius = 5;
    imageHeightTextField.layer.borderWidth = 1.0;
    imageHeightTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [imageHeightTextField setAlpha:0.7];
    [imageHeightTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    imageHeightTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:imageHeightTextField];
    
    //Orientation
    //Default Orientation Label
    UILabel *defaultOrientationLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,imageWidthTextField.frame.origin.y + imageWidthTextField.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [defaultOrientationLabel setText:[LabelUtils getLabelForKey:@"default_orientation"]];
    [defaultOrientationLabel setAlpha:0.7];
    [defaultOrientationLabel setFont:[UIFont systemFontOfSize:11]];
    defaultOrientationLabel.numberOfLines = 0;
    defaultOrientationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:defaultOrientationLabel];
    
    //Portrait Radio Btn
    portraitRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    portraitRadioBtn.frame = CGRectMake(idOutLineColorLabel.frame.origin.x, defaultOrientationLabel.frame.origin.y + defaultOrientationLabel.frame.size.height + (height/100)*1, (width/100)*7, (height/100)*4);
    [portraitRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
                      forState:UIControlStateNormal];
    [portraitRadioBtn addTarget:self action:@selector(portraitBtnChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:portraitRadioBtn];
    
    //Portrait Label
    UILabel *portraitLabel = [[UILabel alloc] initWithFrame:CGRectMake(portraitRadioBtn.frame.origin.x + portraitRadioBtn.frame.size.width + (width/100)*2, portraitRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [portraitLabel setText:[LabelUtils getLabelForKey:@"portrait"]];
    [portraitLabel setAlpha:0.7];
    [portraitLabel setFont:[UIFont systemFontOfSize:14]];
    portraitLabel.numberOfLines = 0;
    portraitLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:portraitLabel];
    
    //LandScape Radio Button
    landscapeRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    landscapeRadioBtn.frame = CGRectMake(portraitLabel.frame.origin.x + portraitLabel.frame.size.width + (width/100)*2, defaultOrientationLabel.frame.origin.y + defaultOrientationLabel.frame.size.height + (height/100)*1, (width/100)*7, (height/100)*4);
    [landscapeRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
                       forState:UIControlStateNormal];
    [landscapeRadioBtn addTarget:self action:@selector(landscapeBtnChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:landscapeRadioBtn];
    
    //Landscape Label
    UILabel *landscapeLabel = [[UILabel alloc] initWithFrame:CGRectMake(landscapeRadioBtn.frame.origin.x + landscapeRadioBtn.frame.size.width + (width/100)*2, landscapeRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [landscapeLabel setText:[LabelUtils getLabelForKey:@"landscape"]];
    [landscapeLabel setAlpha:0.7];
    [landscapeLabel setFont:[UIFont systemFontOfSize:14]];
    landscapeLabel.numberOfLines = 0;
    landscapeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:landscapeLabel];
    
    //Show Instruction Screen
    //Show Instruction Screen Label
    UILabel *instructionScreenLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,portraitRadioBtn.frame.origin.y + portraitRadioBtn.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [instructionScreenLabel setText:[LabelUtils getLabelForKey:@"show_inst_screen"]];
    [instructionScreenLabel setAlpha:0.7];
    [instructionScreenLabel setFont:[UIFont systemFontOfSize:11]];
    instructionScreenLabel.numberOfLines = 0;
    instructionScreenLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:instructionScreenLabel];
    [instructionScreenLabel setHidden:YES];
    
    //NoRadio Button
    noInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    noInstRadioBtn.frame = CGRectMake(idOutLineColorLabel.frame.origin.x, instructionScreenLabel.frame.origin.y + instructionScreenLabel.frame.size.height + (height/100)*1, (width/100)*7, (height/100)*4);
//    [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
//                    forState:UIControlStateNormal];
    [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
                    forState:UIControlStateNormal];
    [noInstRadioBtn addTarget:self action:@selector(noInstChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:noInstRadioBtn];
    [noInstRadioBtn setHidden:YES];
    
    //No Label
    UILabel *noInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(noInstRadioBtn.frame.origin.x + noInstRadioBtn.frame.size.width + (width/100)*2, noInstRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [noInstLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [noInstLabel setAlpha:0.7];
    [noInstLabel setFont:[UIFont systemFontOfSize:14]];
    noInstLabel.numberOfLines = 0;
    noInstLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:noInstLabel];
    [noInstLabel setHidden:YES];
    
    //YesRadio Button
    yesInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yesInstRadioBtn.frame = CGRectMake(noInstLabel.frame.origin.x + noInstLabel.frame.size.width + (width/100)*2, noInstRadioBtn.frame.origin.y, (width/100)*7, (height/100)*4);
//    [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
//                     forState:UIControlStateNormal];
    [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
                     forState:UIControlStateNormal];
    [yesInstRadioBtn addTarget:self action:@selector(yesInstChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:yesInstRadioBtn];
    [yesInstRadioBtn setHidden:YES];
    
    //Yes Label
    UILabel *yesInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(yesInstRadioBtn.frame.origin.x + yesInstRadioBtn.frame.size.width + (width/100)*2, yesInstRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [yesInstLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [yesInstLabel setAlpha:0.7];
    [yesInstLabel setFont:[UIFont systemFontOfSize:14]];
    yesInstLabel.numberOfLines = 0;
    yesInstLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:yesInstLabel];
    [yesInstLabel setHidden:YES];
    
    //Show Title Image
    UILabel *showTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,noInstRadioBtn.frame.origin.y + noInstRadioBtn.frame.size.height + (height/100)*0, idOutLineColorLabel.frame.size.width, (height/100)*0)];
    [showTitleLabel setText:[LabelUtils getLabelForKey:@"show_title_image"]];
    [showTitleLabel setAlpha:0.7];
    [showTitleLabel setFont:[UIFont systemFontOfSize:11]];
    showTitleLabel.numberOfLines = 0;
    showTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [showTitleLabel setHidden: YES];
    showTitleLabel.hidden = YES;
    [scrollView addSubview:showTitleLabel];
    
    //Show title Image Edit Spinner
    showTitleImgTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, showTitleLabel.frame.origin.y + showTitleLabel.frame.size.height + (height/100)*0, (width/100)*92, (height/100)*0)];
    [showTitleImgTextField setFont:[UIFont systemFontOfSize:12]];
    showTitleImgTextField.layer.cornerRadius = 5;
    showTitleImgTextField.layer.borderWidth = 1.0;
    showTitleImgTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [showTitleImgTextField setAlpha:0.7];
    [showTitleImgTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    showTitleImgTextField.borderStyle = UITextBorderStyleRoundedRect;
    [showTitleImgTextField setHidden: YES];
    showTitleImgTextField.hidden = YES;
    [scrollView addSubview:showTitleImgTextField];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(showTitleImgTextField.frame.origin.x + showTitleImgTextField.frame.size.width - (width/100)*9 , showTitleImgTextField.frame.origin.y + (showTitleImgTextField.frame.size.height/2) - (height/100)*0, (width/100)*7, (height/100)*0)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [downArrowImage setHidden: YES];
    downArrowImage.hidden = YES;
    [self.view addSubview:downArrowImage];
    
    //Save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(idOutLineColorLabel.frame.origin.x, showTitleImgTextField.frame.origin.y + showTitleImgTextField.frame.size.height + (height/100)*2, idOutlineColorTextField.frame.size.width, (height/100)*6);
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
    CGRect editAccountframe = CGRectMake(idOutlineTransLabel.frame.origin.x, saveBtn.frame.origin.y , saveBtn.frame.size.width, (height/100)*6);
    [resetBtn setFrame:editAccountframe];
    resetBtn.layer.cornerRadius = 20;
    resetBtn.clipsToBounds = YES;
    [resetBtn setTitle:[LabelUtils getLabelForKey:@"reset"] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetButton:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.titleLabel.textColor = [UIColor whiteColor];
    [resetBtn setBackgroundColor:[UIColor blackColor]];
    [resetBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [scrollView addSubview:resetBtn];
    
    //    [scrollView setContentSize:CGSizeMake(width, resetBtn.frame.origin.y + resetBtn.frame.size.height + (height/100)*3)];
    
    return resetBtn.frame.origin.y + resetBtn.frame.size.height;
}

-(void)portraitBtnChkBox:(UIButton*)button {
    if(!isPortrait) {
        [portraitRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        [landscapeRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        isPortrait = true;
    }
}

-(void)landscapeBtnChkBox:(UIButton*)button {
    
    if(isPortrait) {
        [portraitRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        [landscapeRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        isPortrait = false;
    }
}

-(void)noInstChkBox:(UIButton*)button {
    if(showInstScreen) {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        showInstScreen = false;
    }
}

-(void)yesInstChkBox:(UIButton*)button {
    
    if(!showInstScreen) {
        [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
        [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
        showInstScreen = true;
    }
    
}

-(void)saveButton:(UIButton*)button {
    
    int minimumLightThreshold=mLightThreshold, minimumFocusThreshold=mFocusThreshold,maximunFocusThreshold = maxFocusThreshold, GlarePercentage=mGlarePercentage, EnableCaptureButtonTime=mCaptureButtonTime, ImageSize=mMaxImageSize, ImageHeight=mImageHeight,ImageWidth=mImageWidth;
    NSString *idOutlineColor = dIdOutlineColor, *detectedidoutlinecolor = dDetectedIdOutlineColor, *idOutsideOutlineColor = dOutsideIdOutlineColor,*dDetectedIDOutsideOutlineColor = dDetectedIdOutsideOutlineColor;
    int idOutlineColorAlpha = mAlpha,detectedidoutlinetransparency = mAlpha, idOutsideOutlineColorAlpha = mAlpha,detectedidoutlineoutsidecolortrans = mAlpha;
    
    if([NSStringUtilsDemo isInteger:lightThresholdTextField.text]){
        minimumLightThreshold = [lightThresholdTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:maxFocusThresholdTextField.text]){
        minimumLightThreshold = [maxFocusThresholdTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:minFocusThreshold.text]){
        minimumFocusThreshold = [minFocusThreshold.text intValue];
    }
    
    if([NSStringUtilsDemo isInteger:glarePercentageTextField.text]){
        GlarePercentage = [glarePercentageTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:enableCapBtnTimeTextField.text]){
        EnableCaptureButtonTime = [enableCapBtnTimeTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:maxImageSize.text]){
        ImageSize = [maxImageSize.text intValue];
    }
    if([NSStringUtilsDemo isInteger:imageHeightTextField.text]){
        ImageHeight = [imageHeightTextField.text intValue];
    }
    if([NSStringUtilsDemo isInteger:imageWidthTextField.text]){
        ImageWidth = [imageWidthTextField.text intValue];
    }
    
    idOutlineColor = idOutlineColorTextField.text;
    idOutsideOutlineColor = colorOutsideOutlineTextField.text;
    idOutlineColorAlpha = [idOutlineColorTransTextField.text intValue];
    idOutsideOutlineColorAlpha = [colorOutsideOutlineTransTextField.text intValue];
    detectedidoutlinecolor = detectedIdOutlineColorTextField.text;
    detectedidoutlinetransparency = [detectedIdOutlineColorTransTextField.text intValue];
    dDetectedIDOutsideOutlineColor = detectedColorOutsideOutlineTextField.text;
    detectedidoutlineoutsidecolortrans = [detectedColorOutsideOutlineTransTextField.text intValue];
    
    
    [self saveSetting:@"lightthreshold_Doc" value:[NSString stringWithFormat:@"%d", minimumLightThreshold]];
    [self saveSetting:@"focusthreshold_Doc" value:[NSString stringWithFormat:@"%d", minimumFocusThreshold]];
    [self saveSetting:@"maxfocusthreshold_Doc" value:[NSString stringWithFormat:@"%d", maximunFocusThreshold]];
    [self saveSetting:@"glarepercentage_Doc" value:[NSString stringWithFormat:@"%d", GlarePercentage]];
    [self saveSetting:@"capturebuttontime_Doc" value:[NSString stringWithFormat:@"%d", EnableCaptureButtonTime]];
    [self saveSetting:@"maximagesize_Doc" value:[NSString stringWithFormat:@"%d", ImageSize]];
    [self saveSetting:@"imageheight_Doc" value:[NSString stringWithFormat:@"%d", ImageHeight]];
    [self saveSetting:@"imagewidth_Doc" value:[NSString stringWithFormat:@"%d", ImageWidth]];
    
    [self saveSetting:@"idoutlinecolor" value:idOutlineColor];
    [self saveSetting:@"idoutsideoutlinecolor" value:idOutsideOutlineColor];
    [self saveSetting:@"idoutlinetransparency" value:[NSString stringWithFormat:@"%d", idOutlineColorAlpha]];
    [self saveSetting:@"idoutsideoutlinetransparency" value:[NSString stringWithFormat:@"%d", idOutsideOutlineColorAlpha]];
    [self saveSetting:@"detectedidoutlinecolor" value:detectedidoutlinecolor];
    [self saveSetting:@"detectedidoutlinetransparency" value:[NSString stringWithFormat:@"%d", detectedidoutlinetransparency]];
    [self saveSetting:@"detectedidcolorOutsideOutline" value:dDetectedIDOutsideOutlineColor];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency" value:[NSString stringWithFormat:@"%d",detectedidoutlineoutsidecolortrans]];
    
    [self configBtnClickMethod];
    [self snackBarView:[LabelUtils getLabelForKey:@"id_capture_save_msg"]];
}

-(void)resetButton:(UIButton*)button {
    
    [idOutlineColorTextField setText:dIdOutlineColor];
    [idOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [detectedIdOutlineColorTextField setText:dDetectedIdOutlineColor];
    [detectedIdOutlineColorTransTextField setText:[@(mAlpha) stringValue]];
    [colorOutsideOutlineTextField setText:dOutsideIdOutlineColor];
    [colorOutsideOutlineTransTextField setText:[@(mAlpha) stringValue]];
    [detectedColorOutsideOutlineTextField setText:dDetectedIdOutsideOutlineColor];
    [detectedColorOutsideOutlineTransTextField setText:[@(mAlpha) stringValue]];
    [lightThresholdTextField setText:[@(mLightThreshold) stringValue]];
    [minFocusThreshold setText:[@(mFocusThreshold) stringValue]];
    [maxFocusThresholdTextField setText:[@(maxFocusThreshold) stringValue]];
    [glarePercentageTextField setText:[@(mGlarePercentage) stringValue]];
    [enableCapBtnTimeTextField setText:[@(mCaptureButtonTime) stringValue]];
    [maxImageSize setText:[@(mMaxImageSize) stringValue]];
    [imageWidthTextField setText:[@(mImageWidth) stringValue]];
    [imageHeightTextField setText:[@(mImageHeight) stringValue]];
    
    
    [self saveSetting:@"lightthreshold_Doc" value:[NSString stringWithFormat:@"%@", [lightThresholdTextField text]]];
    [self saveSetting:@"focusthreshold_Doc" value:[NSString stringWithFormat:@"%@", [minFocusThreshold text]]];
    [self saveSetting:@"maxfocusthreshold_Doc" value:[NSString stringWithFormat:@"%@", [maxFocusThresholdTextField text]]];
    [self saveSetting:@"glarepercentage_Doc" value:[NSString stringWithFormat:@"%@", [glarePercentageTextField text]]];
    [self saveSetting:@"capturebuttontime_Doc" value:[NSString stringWithFormat:@"%@", [enableCapBtnTimeTextField text]]];
    [self saveSetting:@"maximagesize_Doc" value:[NSString stringWithFormat:@"%@", [maxImageSize text]]];
    [self saveSetting:@"imageheight_Doc" value:[NSString stringWithFormat:@"%@", [imageHeightTextField text]]];
    [self saveSetting:@"imagewidth_Doc" value:[NSString stringWithFormat:@"%@", [imageWidthTextField text]]];
    
    [self saveSetting:@"idoutlinecolor" value:[NSString stringWithFormat:@"%@", [idOutlineColorTextField text]]];
    [self saveSetting:@"idoutsideoutlinecolor" value:[NSString stringWithFormat:@"%@", [colorOutsideOutlineTextField text]]];
    [self saveSetting:@"idoutlinetransparency" value:[NSString stringWithFormat:@"%@", [idOutlineColorTransTextField text]]];
    [self saveSetting:@"idoutsideoutlinetransparency" value:[NSString stringWithFormat:@"%@", [colorOutsideOutlineTransTextField text]]];
    [self saveSetting:@"detectedidoutlinecolor" value:[NSString stringWithFormat:@"%@", [detectedIdOutlineColorTextField text]]];
    [self saveSetting:@"detectedidoutlinetransparency" value:[NSString stringWithFormat:@"%@", [detectedIdOutlineColorTransTextField text]]];
    [self saveSetting:@"detectedidcolorOutsideOutline" value:[NSString stringWithFormat:@"%@", [detectedColorOutsideOutlineTextField text]]];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency" value:[NSString stringWithFormat:@"%@",[detectedColorOutsideOutlineTransTextField text]]];
    
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
    
    UIButton *cameraClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraClickBtn.frame = CGRectMake(cameraClickX, cameraClickY, (width/100)*10, (width/100)*10);
    cameraClickBtn.center = backGroundWhiteView.center;
    [cameraClickBtn setImage:[UIImage imageNamed:@"Document_Capture.png"] forState:UIControlStateNormal];
    [self.view addSubview:cameraClickBtn];
    
    UILabel *captureLabel = [[UILabel alloc] initWithFrame:CGRectMake(cameraClickBtn.frame.origin.x + cameraClickBtn.frame.size.width/2 - (width/100)*15, cameraClickBtn.frame.origin.y + cameraClickBtn.frame.size.height + (height/100)*2, (width/100)*30, (width/100)*5)];
    
    //[captureLabel setText:titlesArray[1]];
    [captureLabel setText:[LabelUtils getLabelForKey:@"capture"]];
    [captureLabel setTextAlignment:NSTextAlignmentCenter];
    [captureLabel setAlpha:0.5];
    [captureLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:captureLabel];
    
    //Generic Document TextField
    genericDocTextField = [[UITextField alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x, backGroundWhiteView.frame.origin.y + backGroundWhiteView.frame.size.height + (height/100)*3, backGroundWhiteView.frame.size.width, (height/100)*8)];
    genericDocTextField.layer.cornerRadius = 5;
    genericDocTextField.layer.borderWidth = 1.0;
    genericDocTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [genericDocTextField setFont:[UIFont systemFontOfSize:14]];
    [genericDocTextField setAlpha:0.7];
    [genericDocTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    genericDocTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:genericDocTextField];
    
    UILabel *genericDocLabel = [[UILabel alloc] initWithFrame:CGRectMake(genericDocTextField.frame.origin.x + 15, genericDocTextField.frame.origin.y - ((height/100)*2), ((genericDocTextField.frame.size.width)/100)*55, ((height/100)*4))];
    [genericDocLabel setText:[LabelUtils getLabelForKey:@"enter_document_name"]];
    [genericDocLabel setFont:[UIFont systemFontOfSize:14]];
    [genericDocLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [genericDocLabel setTextAlignment:NSTextAlignmentCenter];
    [genericDocLabel setTextColor:[UIColor darkGrayColor]];
    [self.view addSubview:genericDocLabel];
    
//    resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (backGroundWhiteView.frame.size.width/100)*25, backGroundWhiteView.frame.origin.y + (backGroundWhiteView.frame.size.height/100)*2, (backGroundWhiteView.frame.size.width/100)*50, backGroundWhiteView.frame.size.height - (backGroundWhiteView.frame.size.height/100)*4)];
    resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (width/100)*1, backGroundWhiteView.frame.origin.y + (height/100)*1, backGroundWhiteView.frame.size.width - (width/100)*2, backGroundWhiteView.frame.size.height - (height/100)*2)];
    resultImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:resultImage];
    
    // Recapture Button
    recaptureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(backGroundWhiteView.frame.origin.x, genericDocTextField.frame.origin.y + genericDocTextField.frame.size.height + (height/100)*3, backGroundWhiteView.frame.size.width, (height/100)*6);
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
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:nextBtn];
}

-(void)captureBtn:(UIButton*)button {
    [self checkCameraPermission];
}
- (void)viewOnTouch:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    if(isCapture){
        [self checkCameraPermission];
    }
}

-(void)saveSetting:(NSString*)key value:(NSString*)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
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

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

-(void)genericDocResponse : (NSMutableDictionary*) result {
    NSString *birthImg = [result objectForKey:@"GENERIC_DOCUMENT"];
    if(nil != birthImg){
        NSData* data = [[NSData alloc] initWithBase64EncodedString:birthImg options:0];
        UIImage* image = [UIImage imageWithData:data];
        [resultImage setImage:image];
        [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
        isCapture=false;
    }
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

-(void)captureDocumentAPICall{
    if(![[[genericDocTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        UIImage *titleImageFace;
        //if([@"None" isEqualToString:[showTitleImgTextField text]]) {
        if([[LabelUtils getLabelForKey:@"none"] isEqualToString:[showTitleImgTextField text]]) {
            titleImageFace = nil;
        } else {
            titleImageFace = [UIImage imageNamed:@"title_image"];
        }
//        [AppItSDK captureGenericDocument:[ArrayObjectController getPageDelegate] capturePortrait:isPortrait minimumLightThreshold:[lightThresholdTextField.text intValue] minimumFocusThreshold:[minFocusThreshold.text intValue] GlarePercentage:[glarePercentageTextField.text intValue] EnableCaptureButtonTime:[enableCapBtnTimeTextField.text intValue] ImageSize:[maxImageSize.text intValue] ImageHeight:[imageHeightTextField.text intValue] ImageWidth:[imageWidthTextField.text intValue] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] idOutlineColor:[idOutlineColorTextField text] idOutlineColorTransparency:[idOutlineColorTransTextField.text intValue] detectedPOAOutlineColor:[detectedIdOutlineColorTextField text] detectedPOAColorOutlineTransperency:[detectedIdOutlineColorTransTextField.text intValue] idOutsideOutlineColor:[colorOutsideOutlineTextField text] idOutsideOutlineColorTransparency:[colorOutsideOutlineTransTextField.text intValue] detectedColorOutsideOutline:[detectedColorOutsideOutlineTextField text] detectedColorOutsideOutlineTransparency:[detectedColorOutsideOutlineTransTextField.text intValue] titleImage:nil showInstruction:showInstScreen instructionimage:nil genericFieldName:[[genericDocTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
      NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
        
        NSString *lightThreshold = [lightThresholdTextField text];
        NSString *minCapFocusThreshold = [minFocusThreshold text];
        NSString *maxCapFocusThreshold = [maxFocusThresholdTextField text];
        NSString *glarePercentage = [glarePercentageTextField text];
        NSString *enableCapBtnTime = [enableCapBtnTimeTextField text];
        NSString *maxCapImageSize = [maxImageSize text];
        NSString *imageHeight = [imageHeightTextField text];
        NSString *imageWidth = [imageWidthTextField text];
        NSString *idOutlineColor = [idOutlineColorTextField text];
        NSString *idOutlineColorTrans = [idOutlineColorTransTextField text];
        NSString *detectedIdOutlineColor = [detectedIdOutlineColorTextField text];
        NSString *detectedIdOutlineColorTrans = [detectedIdOutlineColorTransTextField text];
        NSString *colorOutsideOutline = [colorOutsideOutlineTextField text];
        NSString *colorOutsideOutlineTrans = [colorOutsideOutlineTransTextField text];
        NSString *detectedColorOutsideOutline = [detectedColorOutsideOutlineTextField text];
        NSString *detectedColorOutsideOutlineTrans= [detectedColorOutsideOutlineTransTextField text];
        // NSString *fontStyle= [fontStyleTextField text];
        
        //    NSString *isPortraitMode = (isPortrait) ? @"true" : @"false";
        //    NSString *showInsScreen = (showInstScreen) ? @"true" : @"false";
        NSString *isPortraitMode = (isPortrait) ? @"Y" : @"N";
        NSString *showInsScreen = (showInstScreen) ? @"Y" : @"N";
        
        if(![NSStringUtilsDemo stringIsNilOrEmpty:isPortraitMode]){
            [nsDict setObject:isPortraitMode forKey:@"id_capture_portrait"];
        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:lightThreshold]){
            [nsDict setObject:lightThreshold forKey:@"id_light_threshold"];
        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:minCapFocusThreshold]){
            [nsDict setObject:minCapFocusThreshold forKey:@"id_min_focus_threshold"];
        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:maxCapFocusThreshold]){
            [nsDict setObject:maxCapFocusThreshold forKey:@"id_max_focus_threshold"];
        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:glarePercentage]){
            [nsDict setObject:glarePercentage forKey:@"id_glare_percentage"];
        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:enableCapBtnTime]){
            [nsDict setObject:enableCapBtnTime forKey:@"id_enable_capture_button_time"];
        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:maxCapImageSize]){
            [nsDict setObject:maxCapImageSize forKey:@"id_max_image_size"];
        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:imageHeight]){
            [nsDict setObject:imageHeight forKey:@"id_image_height"];
        }
        if(![NSStringUtilsDemo stringIsNilOrEmpty:imageWidth]){
            [nsDict setObject:imageWidth forKey:@"id_image_width"];
        }
        
//        if(![NSStringUtilsDemo stringIsNilOrEmpty:showInsScreen]){
//            [nsDict setObject:showInsScreen forKey:@"id_show_instruction"];
//        }
      
      // [AppItSDK captureG]
        [AppItSDK captureGenericDocument:[ArrayObjectController getPageDelegate] additionalDictionary:[AppItSDK getAdditionalDataDictionary] uiConfigDictionary:nsDict fieldName:[[genericDocTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
//    [AppItSDK captureGenericDocument:[ArrayObjectController getPageDelegate] capturePortrait:isPortrait minimumLightThreshold:[lightThresholdTextField.text intValue] minimumFocusThreshold:[minFocusThreshold.text intValue] GlarePercentage:[glarePercentageTextField.text intValue] EnableCaptureButtonTime:[enableCapBtnTimeTextField.text intValue] ImageSize:[maxImageSize.text intValue] ImageHeight:[imageHeightTextField.text intValue] ImageWidth:[imageWidthTextField.text intValue] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] idOutlineColor:[idOutlineColorTextField text] idOutlineColorTransparency:[idOutlineColorTransTextField.text intValue] detectedPOAOutlineColor:[detectedIdOutlineColorTextField text] detectedPOAColorOutlineTransperency:[detectedIdOutlineColorTransTextField.text intValue] idOutsideOutlineColor:[colorOutsideOutlineTextField text] idOutsideOutlineColorTransparency:[colorOutsideOutlineTransTextField.text intValue] detectedColorOutsideOutline:[detectedColorOutsideOutlineTextField text] detectedColorOutsideOutlineTransparency:[detectedColorOutsideOutlineTransTextField.text intValue] titleImage:titleImageFace showInstruction:showInstScreen instructionimage:nil genericFieldName:[[genericDocTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    } else {
        [self snackBarView:[LabelUtils getLabelForKey:@"enter_document_name"]];
    }
}

//Run time Permission Asking
-(void) checkCameraPermission {

    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(status == AVAuthorizationStatusAuthorized) { // authorized
        NSLog(@"camera authorized");
        [self captureDocumentAPICall];
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
                        [self captureDocumentAPICall];
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
                    [self captureDocumentAPICall];
                });
            }
        }];
    }
}


@end

