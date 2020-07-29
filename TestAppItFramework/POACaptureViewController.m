//
//  POACaptureViewController.m
//  AppItDepedency
//
//  Created by  on 29/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "POACaptureViewController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "NSStringUtilsDemo.h"
#import "LabelUtils.h"

@interface POACaptureViewController ()

@end

@implementation POACaptureViewController {
    UILabel *titleLabel;
    UIButton *configurationButton;
    UIScrollView *scrollView, *configScrollView;
    bool isVisible;
    
    UIImageView *downUPArrowImage;
    
    int mAlpha;
    int mLightThreshold, mFocusThreshold, maxFocusThreshold, mGlarePercentage, mMaxImageSize, mImageHeight, mImageWidth, mCaptureButtonTime;
    NSString *dFaceOutlineColor, *dDetectedFaceOutlineColor, *dOutsideFaceOutlineColor,*dDetectedOutsideFaceOutlineColor,*dIdOutlineColor, *dDetectedIdOutlineColor, *dOutsideIdOutlineColor,*dDetectedPOAOutlineColor,*dDetectedIdOutsideOutlineColor,*dDetectedPOAOutsideOutlineColor;
    
    //TextField
    UITextField *idOutlineColorTextField, *idOutlineColorTransTextField, *detectedIdOutlineColorTextField, *detectedIdOutlineColorTransTextField, *colorOutsideOutlineTextField, *colorOutsideOutlineTransTextField, *detectedColorOutsideOutlineTextField, *detectedColorOutsideOutlineTransTextField, *lightThresholdTextField, *minFocusThreshold, *maxFocusThresholdTextField, *glarePercentageTextField, *enableCapBtnTimeTextField, *maxImageSize, *imageWidthTextField, *imageHeightTextField, *showTitleImgTextField, *backButtonTextField, *backButtonTransTextField, *retryButtonTextField, *retryButtonTransTextField, *confirmButtonTextField, *confirmButtonTransTextField, *fontStyleTextField, *textColorTextField, *textColorTransTextField;
    
    //Configuration Radio Btn
    UIButton *portraitRadioBtn, *landscapeRadioBtn, *noInstRadioBtn, *yesInstRadioBtn;
    
    //Bool
    bool isPortrait, showInstScreen,isCapture;
    
    NSArray *_selectedPickerData,*_selectedFontStylePickerData;
    NSArray *showTitlePickerData,*showFontStylePickerData;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    UIImageView *resultImage;
    UIButton *recaptureButton;
    
    UITextField *address1TextField, *address2TextField, *countryTextField, *stateTextField, *zipTextField;
    
    UILabel *showMSGLabel;
    NSTimer *fiveSecondTimer;
    bool isSnackBarVisible;
}

-(void)viewDidAppear:(BOOL)animated {
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    isSnackBarVisible = false;

    myPickerView = [[UIPickerView alloc] init];
    isCapture=true;
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    //showTitlePickerData = @[@"None", @"Title Image 1"];
    //_selectedPickerData = @[@"None", @"Title Image 1"];
    [showTitleImgTextField setDelegate:(id)self];
    [fontStyleTextField setDelegate:(id)self];
    
    [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    myPickerView.layer.borderWidth = 1.0;
    myPickerView.layer.cornerRadius = 5.0;
    myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [showTitleImgTextField setInputView:myPickerView];
    [showTitleImgTextField setText:showTitlePickerData[0]];
    [fontStyleTextField setInputView:myPickerView];
    [fontStyleTextField setText:showFontStylePickerData[0]];
    
    [recaptureButton setUserInteractionEnabled:YES];
    
    //Adding Toolbar with 'Done' button on picker view
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerDoneClicked)];
    
    toolbarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
    [toolbarForPicker setItems:toolbarItems];
    
    [showTitleImgTextField setInputView:myPickerView];
    [showTitleImgTextField setInputAccessoryView:toolbarForPicker];
    
    [fontStyleTextField setInputView:myPickerView];
    [fontStyleTextField setInputAccessoryView:toolbarForPicker];
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [showTitleImgTextField resignFirstResponder];
    [fontStyleTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == showTitleImgTextField){
        _selectedPickerData = showTitlePickerData;
        [myPickerView reloadAllComponents];
    } else if (textField == fontStyleTextField){
        _selectedPickerData=showFontStylePickerData;
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
    if([_selectedPickerData isEqualToArray:showFontStylePickerData]){
        [fontStyleTextField setText:showFontStylePickerData[row]];
        [fontStyleTextField setTag:row+1];
    }
}
//Picker Changes End

- (void)viewDidLoad {
    [super viewDidLoad];
    showTitlePickerData = @[@"None", @"Title Image 1"];
    _selectedPickerData = @[@"None", @"Title Image 1"];
    
    showFontStylePickerData = @[@"Default",@"Helvetica", @"Helvetica Bold", @"Helvetica Bold Oblique",@"Helvetica Light",@"Helvetica Light Oblique",@"Helvetica Neue",@"Helvetica Neue Bold",@"Helvetica Neue Bold Italic",@"Helvetica Neue Condensed Black",@"Helvetica Neue Condensed Bold",@"Helvetica Neue Italic",@"Helvetica Neue Light",@"Helvetica Neue Light Italic",@"Helvetica Neue Medium",@"Helvetica Neue Medium Italic",@"Helvetica Neue Thin",@"Helvetica Neue Thin Italic",@"Helvetica Neue UltraLight",@"Helvetica Neue UltraLight Italic",@"Helvetica Oblique"];
    _selectedFontStylePickerData = @[@"Helvetica", @"Helvetica Bold", @"Helvetica Bold Oblique",@"Helvetica Light",@"Helvetica Light Oblique",@"Helvetica Neue",@"Helvetica Neue Bold",@"Helvetica Neue Bold Italic",@"Helvetica Neue Condensed Black",@"Helvetica Neue Condensed Bold",@"Helvetica Neue Italic",@"Helvetica Neue Light",@"Helvetica Neue Light Italic",@"Helvetica Neue Medium",@"Helvetica Neue Medium Italic",@"Helvetica Neue Thin",@"Helvetica Neue Thin Italic",@"Helvetica Neue UltraLight",@"Helvetica Neue UltraLight Italic",@"Helvetica Oblique"];
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
    [titleLabel setText:[LabelUtils getLabelForKey:@"poa_capture_tab"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    
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
    configScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ArrayObjectController getPageControlY] - (height/100)*50 + (height/100)*50, width, (height/100)*50)];
    [configScrollView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#e6fff9" alpha:1.0]];
    [configScrollView setScrollEnabled:YES];
    [configScrollView setShowsHorizontalScrollIndicator:YES];
    [configScrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:configScrollView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, slideView.frame.origin.y + slideView.frame.size.height + (height/100)*2, width, [ArrayObjectController getPageControlY] - (height/100)*8 - slideView.frame.origin.y - slideView.frame.size.height - (height/100)*2)];
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView];
    float scrollContentHt = [self initUI:scrollView];
    
    [scrollView setContentSize:CGSizeMake(width, scrollContentHt + (height/100)*2)];
    
    float scrollViewContentSizeHt =  [self scrollViewUI:configScrollView];
    [configScrollView setContentSize:CGSizeMake(width, scrollViewContentSizeHt + (height/100)*3)];
    
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
    NSString *lightthreshold = [self retrieveSetting:@"lightthreshold" defaultValue:[@(mLightThreshold) stringValue]];
    NSString *minfocusthreshold = [self retrieveSetting:@"focusthreshold" defaultValue:[@(mFocusThreshold) stringValue]];
    NSString *maxfocusthreshold = [self retrieveSetting:@"maxfocusthreshold" defaultValue:[@(maxFocusThreshold) stringValue]];
    NSString *glarepercentage = [self retrieveSetting:@"glarepercentage" defaultValue:[@(mGlarePercentage) stringValue]];
    NSString *capturebuttontime = [self retrieveSetting:@"capturebuttontime" defaultValue:[@(mCaptureButtonTime) stringValue]];
    NSString *maximagesize = [self retrieveSetting:@"maximagesize" defaultValue:[@(mMaxImageSize) stringValue]];
    NSString *imageheight = [self retrieveSetting:@"imageheight" defaultValue:[@(mImageHeight) stringValue]];
    NSString *imagewidth = [self retrieveSetting:@"imagewidth" defaultValue:[@(mImageWidth) stringValue]];
    
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
    [showTitleImgTextField setText:@"None"];
    
    [self.view bringSubviewToFront:configScrollView];
    [self.view bringSubviewToFront:configurationButton];
    [self.view bringSubviewToFront:downUPArrowImage];
}

- (float)scrollViewUI:(UIScrollView *)scrollView {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    //Id Outline color
    UILabel *idOutLineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,(width/100)*44, (height/100)*2)];
    [idOutLineColorLabel setText:[LabelUtils getLabelForKey:@"id_outline_color"]];
    [idOutLineColorLabel setAlpha:0.7];
    [idOutLineColorLabel setFont:[UIFont systemFontOfSize:11]];
    idOutLineColorLabel.numberOfLines = 0;
    idOutLineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:idOutLineColorLabel];
    
    //Id Outline Color Transparency
    UILabel *idOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52, (height/100)*2, (width/100)*44, (height/100)*2)];
    [idOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [idOutlineTransLabel setAlpha:0.7];
    idOutlineTransLabel.numberOfLines = 0;
    idOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [idOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:idOutlineTransLabel];
    
    //id outline color TextField
    idOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, idOutLineColorLabel.frame.origin.y + idOutLineColorLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [idOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    idOutlineColorTextField.layer.cornerRadius = 5;
    idOutlineColorTextField.layer.borderWidth = 1.0;
    idOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idOutlineColorTextField setAlpha:0.7];
    [idOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:idOutlineColorTextField];
    
    //id outline color Trans TextField
    idOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, idOutlineColorTextField.frame.origin.y, idOutlineTransLabel.frame.size.width, (height/100)*4)];
    [idOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]]; idOutlineColorTransTextField.layer.cornerRadius = 5;
    idOutlineColorTransTextField.layer.borderWidth = 1.0;
    idOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [idOutlineColorTransTextField setAlpha:0.7];
    [idOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    idOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:idOutlineColorTransTextField];
    
    //Detected ID Outline Color
    //Detected Id outline Color Label
    UILabel *detectedIdOutLineColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,idOutlineColorTextField.frame.origin.y + idOutlineColorTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [detectedIdOutLineColorLabel setText:[LabelUtils getLabelForKey:@"detected_id_outline_color"]];
    [detectedIdOutLineColorLabel setAlpha:0.7];
    [detectedIdOutLineColorLabel setFont:[UIFont systemFontOfSize:11]];
    detectedIdOutLineColorLabel.numberOfLines = 0;
    detectedIdOutLineColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:detectedIdOutLineColorLabel];
    
    //Detected Id Outline Color Transparency
    UILabel *detectedIdOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,idOutlineColorTransTextField.frame.origin.y + idOutlineColorTransTextField.frame.size.height +  (height/100)*2, idOutlineColorTransTextField.frame.size.width, (height/100)*2)];
    [detectedIdOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [detectedIdOutlineTransLabel setAlpha:0.7];
    detectedIdOutlineTransLabel.numberOfLines = 0;
    detectedIdOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedIdOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:detectedIdOutlineTransLabel];
    
    //Detected Id outline Color text field
    detectedIdOutlineColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, detectedIdOutLineColorLabel.frame.origin.y + detectedIdOutLineColorLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [detectedIdOutlineColorTextField setFont:[UIFont systemFontOfSize:12]];
    detectedIdOutlineColorTextField.layer.cornerRadius = 5;
    detectedIdOutlineColorTextField.layer.borderWidth = 1.0;
    detectedIdOutlineColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedIdOutlineColorTextField setAlpha:0.7];
    [detectedIdOutlineColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedIdOutlineColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:detectedIdOutlineColorTextField];
    
    //Detected Id outline Color Transparency
    detectedIdOutlineColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, detectedIdOutlineTransLabel.frame.origin.y + detectedIdOutlineTransLabel.frame.size.height + (height/100)*1, detectedIdOutlineTransLabel.frame.size.width, (height/100)*4)];
    [detectedIdOutlineColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    detectedIdOutlineColorTransTextField.layer.cornerRadius = 5;
    detectedIdOutlineColorTransTextField.layer.borderWidth = 1.0;
    detectedIdOutlineColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedIdOutlineColorTransTextField setAlpha:0.7];
    [detectedIdOutlineColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedIdOutlineColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:detectedIdOutlineColorTransTextField];
    
    //Color OutsideOutline
    //Color Outside Outline Label
    UILabel *colorOutsideOutLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,detectedIdOutlineColorTextField.frame.origin.y + detectedIdOutlineColorTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [colorOutsideOutLineLabel setText:[LabelUtils getLabelForKey:@"color_outside_outline"]];
    [colorOutsideOutLineLabel setAlpha:0.7];
    [colorOutsideOutLineLabel setFont:[UIFont systemFontOfSize:11]];
    colorOutsideOutLineLabel.numberOfLines = 0;
    colorOutsideOutLineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:colorOutsideOutLineLabel];
    
    //Color Outside Outline Transparency
    UILabel *colorOutsideOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,detectedIdOutlineColorTransTextField.frame.origin.y + detectedIdOutlineColorTransTextField.frame.size.height +  (height/100)*2, idOutlineColorTransTextField.frame.size.width, (height/100)*2)];
    [colorOutsideOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [colorOutsideOutlineTransLabel setAlpha:0.7];
    colorOutsideOutlineTransLabel.numberOfLines = 0;
    colorOutsideOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [colorOutsideOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:colorOutsideOutlineTransLabel];
    
    //Color Outside Outline TextField
    colorOutsideOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, colorOutsideOutLineLabel.frame.origin.y + colorOutsideOutLineLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [colorOutsideOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    colorOutsideOutlineTextField.layer.cornerRadius = 5;
    colorOutsideOutlineTextField.layer.borderWidth = 1.0;
    colorOutsideOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [colorOutsideOutlineTextField setAlpha:0.7];
    [colorOutsideOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    colorOutsideOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:colorOutsideOutlineTextField];
    
    //Color Outside Outline Transparency TextField
    colorOutsideOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, colorOutsideOutlineTransLabel.frame.origin.y + colorOutsideOutlineTransLabel.frame.size.height + (height/100)*1, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [colorOutsideOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    colorOutsideOutlineTransTextField.layer.cornerRadius = 5;
    colorOutsideOutlineTransTextField.layer.borderWidth = 1.0;
    colorOutsideOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [colorOutsideOutlineTransTextField setAlpha:0.7];
    [colorOutsideOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    colorOutsideOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:colorOutsideOutlineTransTextField];
    
    //Detected Color Outside OutLine
    //Detected Color OutSide OutLine Label
    UILabel *detectedColorOutsideOutLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,colorOutsideOutlineTextField.frame.origin.y + colorOutsideOutlineTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*5)];
    [detectedColorOutsideOutLineLabel setText:[LabelUtils getLabelForKey:@"detected_color_outside_outline"]];
    [detectedColorOutsideOutLineLabel setAlpha:0.7];
    [detectedColorOutsideOutLineLabel setFont:[UIFont systemFontOfSize:11]];
    detectedColorOutsideOutLineLabel.numberOfLines = 0;
    detectedColorOutsideOutLineLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:detectedColorOutsideOutLineLabel];
    
    //Detected Color Outside Outline Transparency
    UILabel *detectedcolorOutsideOutlineTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,colorOutsideOutlineTransTextField.frame.origin.y + colorOutsideOutlineTransTextField.frame.size.height +  (height/100)*2, colorOutsideOutlineTransTextField.frame.size.width, (height/100)*2)];
    [detectedcolorOutsideOutlineTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [detectedcolorOutsideOutlineTransLabel setAlpha:0.7];
    detectedcolorOutsideOutlineTransLabel.numberOfLines = 0;
    detectedcolorOutsideOutlineTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [detectedcolorOutsideOutlineTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:detectedcolorOutsideOutlineTransLabel];
    
    //Detected Color Outside Outline TextField
    detectedColorOutsideOutlineTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, detectedColorOutsideOutLineLabel.frame.origin.y + detectedColorOutsideOutLineLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [detectedColorOutsideOutlineTextField setFont:[UIFont systemFontOfSize:12]];
    detectedColorOutsideOutlineTextField.layer.cornerRadius = 5;
    detectedColorOutsideOutlineTextField.layer.borderWidth = 1.0;
    detectedColorOutsideOutlineTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedColorOutsideOutlineTextField setAlpha:0.7];
    [detectedColorOutsideOutlineTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedColorOutsideOutlineTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:detectedColorOutsideOutlineTextField];
    
    //Detected Color Outside Outline Trans TextField
    detectedColorOutsideOutlineTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, detectedColorOutsideOutlineTextField.frame.origin.y, colorOutsideOutlineTransLabel.frame.size.width, (height/100)*4)];
    [detectedColorOutsideOutlineTransTextField setFont:[UIFont systemFontOfSize:12]];
    detectedColorOutsideOutlineTransTextField.layer.cornerRadius = 5;
    detectedColorOutsideOutlineTransTextField.layer.borderWidth = 1.0;
    detectedColorOutsideOutlineTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [detectedColorOutsideOutlineTransTextField setAlpha:0.7];
    [detectedColorOutsideOutlineTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    detectedColorOutsideOutlineTransTextField.borderStyle = UITextBorderStyleRoundedRect;
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
    
    //Font Style
    //Font Style Label
    UILabel *textFontStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,imageWidthTextField.frame.origin.y + imageWidthTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [textFontStyleLabel setText:[LabelUtils getLabelForKey:@"text_font_style"]];
    [textFontStyleLabel setAlpha:0.7];
    [textFontStyleLabel setFont:[UIFont systemFontOfSize:11]];
    textFontStyleLabel.numberOfLines = 0;
    textFontStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:textFontStyleLabel];
    
    //Font Style TextField
    fontStyleTextField = [[UITextField alloc] initWithFrame: CGRectMake(idOutLineColorLabel.frame.origin.x, textFontStyleLabel.frame.origin.y + textFontStyleLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [fontStyleTextField setFont:[UIFont systemFontOfSize:12]];
    fontStyleTextField.layer.cornerRadius = 5;
    fontStyleTextField.layer.borderWidth = 1.0;
    fontStyleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [fontStyleTextField setAlpha:0.7];
    [fontStyleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    fontStyleTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:fontStyleTextField];
    
    //Text Color/transparency
    //Text Color Label
    UILabel *textColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,fontStyleTextField.frame.origin.y + fontStyleTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [textColorLabel setText:[LabelUtils getLabelForKey:@"text_label_color"]];
    [textColorLabel setAlpha:0.7];
    [textColorLabel setFont:[UIFont systemFontOfSize:11]];
    textColorLabel.numberOfLines = 0;
    textColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:textColorLabel];
    
    //Transparency Label
    UILabel *textColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,fontStyleTextField.frame.origin.y + fontStyleTextField.frame.size.height +  (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [textColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [textColorTransLabel setAlpha:0.7];
    textColorTransLabel.numberOfLines = 0;
    textColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [textColorTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:textColorTransLabel];
    
    //Text Color TextField
    textColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, textColorLabel.frame.origin.y + textColorLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [textColorTextField setFont:[UIFont systemFontOfSize:12]];
    textColorTextField.layer.cornerRadius = 5;
    textColorTextField.layer.borderWidth = 1.0;
    textColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColorTextField setAlpha:0.7];
    [textColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:textColorTextField];
    
    //Transparency TextField
    textColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, textColorTransLabel.frame.origin.y + textColorTransLabel.frame.size.height + (height/100)*1, textColorTransLabel.frame.size.width, (height/100)*4)];
    [textColorTransTextField setFont:[UIFont systemFontOfSize:12]];
    textColorTransTextField.layer.cornerRadius = 5;
    textColorTransTextField.layer.borderWidth = 1.0;
    textColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [textColorTransTextField setAlpha:0.7];
    [textColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    textColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    textColorTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:textColorTransTextField];
    
    //Back Button/transparency
    //Back button Label
    UILabel *backButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,textColorTextField.frame.origin.y + textColorTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [backButtonLabel setText:[LabelUtils getLabelForKey:@"back_button_color"]];
    [backButtonLabel setAlpha:0.7];
    [backButtonLabel setFont:[UIFont systemFontOfSize:11]];
    backButtonLabel.numberOfLines = 0;
    backButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:backButtonLabel];
    
    //Transparency Label
    UILabel *backButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,textColorTransTextField.frame.origin.y + textColorTransTextField.frame.size.height +  (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [backButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [backButtonTransLabel setAlpha:0.7];
    backButtonTransLabel.numberOfLines = 0;
    backButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    textColorTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [scrollView addSubview:backButtonTransLabel];
    
    //Back Button TextField
    backButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, backButtonLabel.frame.origin.y + backButtonLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [backButtonTextField setFont:[UIFont systemFontOfSize:12]];
    backButtonTextField.layer.cornerRadius = 5;
    backButtonTextField.layer.borderWidth = 1.0;
    backButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [backButtonTextField setAlpha:0.7];
    [backButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    backButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:backButtonTextField];
    
    //Transparency TextField
    backButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, backButtonTransLabel.frame.origin.y + backButtonTransLabel.frame.size.height + (height/100)*1, backButtonTransLabel.frame.size.width, (height/100)*4)];
    [backButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
    backButtonTransTextField.layer.cornerRadius = 5;
    backButtonTransTextField.layer.borderWidth = 1.0;
    backButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [backButtonTransTextField setAlpha:0.7];
    [backButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    backButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    backButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:backButtonTransTextField];
    
    //Retry Button/Transparency
    //Retry Button Label
    UILabel *retryButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,backButtonTextField.frame.origin.y + backButtonTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [retryButtonLabel setText:[LabelUtils getLabelForKey:@"retry_button_color"]];
    [retryButtonLabel setAlpha:0.7];
    [retryButtonLabel setFont:[UIFont systemFontOfSize:11]];
    retryButtonLabel.numberOfLines = 0;
    retryButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:retryButtonLabel];
    
    //Transparency Label
    UILabel *retryButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,backButtonTransTextField.frame.origin.y + backButtonTransTextField.frame.size.height +  (height/100)*2, backButtonTransTextField.frame.size.width, (height/100)*2)];
    [retryButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [retryButtonTransLabel setAlpha:0.7];
    retryButtonTransLabel.numberOfLines = 0;
    retryButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [retryButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:retryButtonTransLabel];
    
    //Retry Button TextField
    retryButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, retryButtonLabel.frame.origin.y + retryButtonLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [retryButtonTextField setFont:[UIFont systemFontOfSize:12]];
    retryButtonTextField.layer.cornerRadius = 5;
    retryButtonTextField.layer.borderWidth = 1.0;
    retryButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonTextField setAlpha:0.7];
    [retryButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:retryButtonTextField];
    
    //Transparency TextField
    retryButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, retryButtonTransLabel.frame.origin.y + retryButtonTransLabel.frame.size.height + (height/100)*1, retryButtonTransLabel.frame.size.width, (height/100)*4)];
    [retryButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
    retryButtonTransTextField.layer.cornerRadius = 5;
    retryButtonTransTextField.layer.borderWidth = 1.0;
    retryButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [retryButtonTransTextField setAlpha:0.7];
    [retryButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    retryButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    retryButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:retryButtonTransTextField];
    
    //Confirm Button/Transparency
    //Confirm Button Label
    UILabel *confirmButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,retryButtonTextField.frame.origin.y + retryButtonTextField.frame.size.height +   (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [confirmButtonLabel setText:[LabelUtils getLabelForKey:@"confirm_button_color"]];
    [confirmButtonLabel setAlpha:0.7];
    [confirmButtonLabel setFont:[UIFont systemFontOfSize:11]];
    confirmButtonLabel.numberOfLines = 0;
    confirmButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:confirmButtonLabel];
    
    //Transparency Label
    UILabel *confirmButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x,retryButtonTextField.frame.origin.y + retryButtonTextField.frame.size.height +  (height/100)*2, retryButtonTextField.frame.size.width, (height/100)*2)];
    [confirmButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
    [confirmButtonTransLabel setAlpha:0.7];
    confirmButtonTransLabel.numberOfLines = 0;
    confirmButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [confirmButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
    [scrollView addSubview:confirmButtonTransLabel];
    
    //Confirm Button TextField
    confirmButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, confirmButtonLabel.frame.origin.y + confirmButtonLabel.frame.size.height + (height/100)*1, idOutLineColorLabel.frame.size.width, (height/100)*4)];
    [confirmButtonTextField setFont:[UIFont systemFontOfSize:12]];
    confirmButtonTextField.layer.cornerRadius = 5;
    confirmButtonTextField.layer.borderWidth = 1.0;
    confirmButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonTextField setAlpha:0.7];
    [confirmButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:confirmButtonTextField];
    
    //Transparency TextField
    confirmButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutlineTransLabel.frame.origin.x, confirmButtonTransLabel.frame.origin.y + confirmButtonTransLabel.frame.size.height + (height/100)*1, confirmButtonTransLabel.frame.size.width, (height/100)*4)];
    [confirmButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
    confirmButtonTransTextField.layer.cornerRadius = 5;
    confirmButtonTransTextField.layer.borderWidth = 1.0;
    confirmButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [confirmButtonTransTextField setAlpha:0.7];
    [confirmButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    confirmButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
    confirmButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
    [scrollView addSubview:confirmButtonTransTextField];
    
    //Orientation
    //Default Orientation Label
    UILabel *defaultOrientationLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,confirmButtonTextField.frame.origin.y + confirmButtonTextField.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
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
    
    //NoRadio Button
    noInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    noInstRadioBtn.frame = CGRectMake(idOutLineColorLabel.frame.origin.x, instructionScreenLabel.frame.origin.y + instructionScreenLabel.frame.size.height + (height/100)*1, (width/100)*7, (height/100)*4);
    //    [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
    //                    forState:UIControlStateNormal];
    [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
                    forState:UIControlStateNormal];
    [noInstRadioBtn addTarget:self action:@selector(noInstChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:noInstRadioBtn];
    
    //No Label
    UILabel *noInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(noInstRadioBtn.frame.origin.x + noInstRadioBtn.frame.size.width + (width/100)*2, noInstRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [noInstLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [noInstLabel setAlpha:0.7];
    [noInstLabel setFont:[UIFont systemFontOfSize:14]];
    noInstLabel.numberOfLines = 0;
    noInstLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:noInstLabel];
    
    //YesRadio Button
    yesInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yesInstRadioBtn.frame = CGRectMake(noInstLabel.frame.origin.x + noInstLabel.frame.size.width + (width/100)*2, noInstRadioBtn.frame.origin.y, (width/100)*7, (height/100)*4);
    //    [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
    //                     forState:UIControlStateNormal];
    [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
                     forState:UIControlStateNormal];
    [yesInstRadioBtn addTarget:self action:@selector(yesInstChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:yesInstRadioBtn];
    
    //Yes Label
    UILabel *yesInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(yesInstRadioBtn.frame.origin.x + yesInstRadioBtn.frame.size.width + (width/100)*2, yesInstRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
    [yesInstLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [yesInstLabel setAlpha:0.7];
    [yesInstLabel setFont:[UIFont systemFontOfSize:14]];
    yesInstLabel.numberOfLines = 0;
    yesInstLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:yesInstLabel];
    
    //Show Title Image
    UILabel *showTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x,noInstRadioBtn.frame.origin.y + noInstRadioBtn.frame.size.height + (height/100)*2, idOutLineColorLabel.frame.size.width, (height/100)*2)];
    [showTitleLabel setText:[LabelUtils getLabelForKey:@"show_title_image"]];
    [showTitleLabel setAlpha:0.7];
    [showTitleLabel setFont:[UIFont systemFontOfSize:11]];
    showTitleLabel.numberOfLines = 0;
    showTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:showTitleLabel];
    
    //Show title Image Edit Spinner
    showTitleImgTextField = [[UITextField alloc] initWithFrame:CGRectMake(idOutLineColorLabel.frame.origin.x, showTitleLabel.frame.origin.y + showTitleLabel.frame.size.height + (height/100)*1, (width/100)*92, (height/100)*6)];
    [showTitleImgTextField setFont:[UIFont systemFontOfSize:12]];
    showTitleImgTextField.layer.cornerRadius = 5;
    showTitleImgTextField.layer.borderWidth = 1.0;
    showTitleImgTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [showTitleImgTextField setAlpha:0.7];
    [showTitleImgTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    showTitleImgTextField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:showTitleImgTextField];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(showTitleImgTextField.frame.origin.x + showTitleImgTextField.frame.size.width - (width/100)*9 , showTitleImgTextField.frame.origin.y + (showTitleImgTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
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
    
    
    [self saveSetting:@"lightthreshold" value:[NSString stringWithFormat:@"%d", minimumLightThreshold]];
    [self saveSetting:@"focusthreshold" value:[NSString stringWithFormat:@"%d", minimumFocusThreshold]];
    [self saveSetting:@"maxfocusthreshold" value:[NSString stringWithFormat:@"%d", maximunFocusThreshold]];
    [self saveSetting:@"glarepercentage" value:[NSString stringWithFormat:@"%d", GlarePercentage]];
    [self saveSetting:@"capturebuttontime" value:[NSString stringWithFormat:@"%d", EnableCaptureButtonTime]];
    [self saveSetting:@"maximagesize" value:[NSString stringWithFormat:@"%d", ImageSize]];
    [self saveSetting:@"imageheight" value:[NSString stringWithFormat:@"%d", ImageHeight]];
    [self saveSetting:@"imagewidth" value:[NSString stringWithFormat:@"%d", ImageWidth]];
    
    [self saveSetting:@"idoutlinecolor" value:idOutlineColor];
    [self saveSetting:@"idoutsideoutlinecolor" value:idOutsideOutlineColor];
    [self saveSetting:@"idoutlinetransparency" value:[NSString stringWithFormat:@"%d", idOutlineColorAlpha]];
    [self saveSetting:@"idoutsideoutlinetransparency" value:[NSString stringWithFormat:@"%d", idOutsideOutlineColorAlpha]];
    [self saveSetting:@"detectedidoutlinecolor" value:detectedidoutlinecolor];
    [self saveSetting:@"detectedidoutlinetransparency" value:[NSString stringWithFormat:@"%d", detectedidoutlinetransparency]];
    [self saveSetting:@"detectedidcolorOutsideOutline" value:dDetectedIDOutsideOutlineColor];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency" value:[NSString stringWithFormat:@"%d",detectedidoutlineoutsidecolortrans]];
    
    [self configBtnClickBtn];
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
    
    
    [self saveSetting:@"lightthreshold" value:[NSString stringWithFormat:@"%@", [lightThresholdTextField text]]];
    [self saveSetting:@"focusthreshold" value:[NSString stringWithFormat:@"%@", [minFocusThreshold text]]];
    [self saveSetting:@"maxfocusthreshold" value:[NSString stringWithFormat:@"%@", [maxFocusThresholdTextField text]]];
    [self saveSetting:@"glarepercentage" value:[NSString stringWithFormat:@"%@", [glarePercentageTextField text]]];
    [self saveSetting:@"capturebuttontime" value:[NSString stringWithFormat:@"%@", [enableCapBtnTimeTextField text]]];
    [self saveSetting:@"maximagesize" value:[NSString stringWithFormat:@"%@", [maxImageSize text]]];
    [self saveSetting:@"imageheight" value:[NSString stringWithFormat:@"%@", [imageHeightTextField text]]];
    [self saveSetting:@"imagewidth" value:[NSString stringWithFormat:@"%@", [imageWidthTextField text]]];
    
    [self saveSetting:@"idoutlinecolor" value:[NSString stringWithFormat:@"%@", [idOutlineColorTextField text]]];
    [self saveSetting:@"idoutsideoutlinecolor" value:[NSString stringWithFormat:@"%@", [colorOutsideOutlineTextField text]]];
    [self saveSetting:@"idoutlinetransparency" value:[NSString stringWithFormat:@"%@", [idOutlineColorTransTextField text]]];
    [self saveSetting:@"idoutsideoutlinetransparency" value:[NSString stringWithFormat:@"%@", [colorOutsideOutlineTransTextField text]]];
    [self saveSetting:@"detectedidoutlinecolor" value:[NSString stringWithFormat:@"%@", [detectedIdOutlineColorTextField text]]];
    [self saveSetting:@"detectedidoutlinetransparency" value:[NSString stringWithFormat:@"%@", [detectedIdOutlineColorTransTextField text]]];
    [self saveSetting:@"detectedidcolorOutsideOutline" value:[NSString stringWithFormat:@"%@", [detectedColorOutsideOutlineTextField text]]];
    [self saveSetting:@"detectedidcolorOutsideOutlineTransparency" value:[NSString stringWithFormat:@"%@",[detectedColorOutsideOutlineTransTextField text]]];
    
}

-(void)captureBtn:(UIButton*)button {
    [AppItSDK captureAddressProof:[ArrayObjectController getPageDelegate] capturePortrait:isPortrait minimumLightThreshold:[lightThresholdTextField.text intValue] minimumFocusThreshold:[minFocusThreshold.text intValue] GlarePercentage:[glarePercentageTextField.text intValue] EnableCaptureButtonTime:[enableCapBtnTimeTextField.text intValue] ImageSize:[maxImageSize.text intValue] ImageHeight:[imageHeightTextField.text intValue] ImageWidth:[imageWidthTextField.text intValue] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] idOutlineColor:[idOutlineColorTextField text] idOutlineColorTransparency:[idOutlineColorTransTextField.text intValue] detectedPOAOutlineColor:[detectedIdOutlineColorTextField text] detectedPOAColorOutlineTransperency:[detectedIdOutlineColorTransTextField.text intValue] idOutsideOutlineColor:[colorOutsideOutlineTextField text] idOutsideOutlineColorTransparency:[colorOutsideOutlineTransTextField.text intValue] detectedColorOutsideOutline:[detectedColorOutsideOutlineTextField text] detectedColorOutsideOutlineTransparency:[detectedColorOutsideOutlineTransTextField.text intValue] titleImage:nil showInstruction:showInstScreen instructionimage:nil];
}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    
    [ArrayObjectController setAddressDataDictionary:[self getAddressDataDictionary]];
    
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    NSString *restorationId1 = [self valueForKey:@"storyboardIdentifier"];
    [controller setNextViewController:restorationId1];
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


-(void)setResultImage:(UIImage *)resImage {
    isCapture=false;
    [resultImage setImage:resImage];
    [recaptureButton setTitle:@"Recapture" forState:UIControlStateNormal];
}

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

-(void)configBtnClickBtn {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if(!isVisible) {
        [UIView transitionWithView:configScrollView duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect buttonFrame = configurationButton.frame;
            buttonFrame.origin.y = configScrollView.frame.origin.y - configScrollView.frame.size.height- buttonFrame.size.height;
            configurationButton.frame = buttonFrame;
            
            CGRect frame = configScrollView.frame;
            frame.origin.y = frame.origin.y - frame.size.height;
            configScrollView.frame = frame;
            isVisible = true;
            
            CGRect arrowFrame = downUPArrowImage.frame;
            arrowFrame.origin.y = configurationButton.frame.origin.y + (configurationButton.frame.size.height/2) - (height/100)*2;
            downUPArrowImage.frame = arrowFrame;
            
        } completion:^(BOOL finished) {
            [downUPArrowImage setImage:[UIImage imageNamed:@"Down_Arrow.png"]];
        }];
    } else {
        [UIView transitionWithView:configScrollView duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            CGRect buttonFrame = configurationButton.frame;
            buttonFrame.origin.y = configScrollView.frame.origin.y + configScrollView.frame.size.height - buttonFrame.size.height;
            configurationButton.frame = buttonFrame;
            
            CGRect frame = configScrollView.frame;
            frame.origin.y =frame.origin.y +configScrollView.frame.size.height;
            configScrollView.frame = frame;
            isVisible = false;
            
            CGRect arrowFrame = downUPArrowImage.frame;
            arrowFrame.origin.y = configurationButton.frame.origin.y + (configurationButton.frame.size.height/2) - (height/100)*2;
            downUPArrowImage.frame = arrowFrame;
            
        } completion:^(BOOL finished) {
            [downUPArrowImage setImage:[UIImage imageNamed:@"Up_Arrow.png"]];
        }];
    }
}

-(void)configurationBtnClicked:(UIButton*)button {
    [self configBtnClickBtn];
}

-(float)initUI:(UIScrollView *)scrollView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UIView *backGroundWhiteView = [[UIView alloc] initWithFrame:CGRectMake((width/100)*5,(height/100)*2, (width/100)*90, (height/100)*35)];
    [backGroundWhiteView setBackgroundColor:[UIColor whiteColor]];
    backGroundWhiteView.layer.borderWidth = 0.2;
    backGroundWhiteView.layer.cornerRadius = 5.0;
    backGroundWhiteView.layer.borderColor = [[UIColor grayColor] CGColor];
    [scrollView addSubview:backGroundWhiteView];
    
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
    [scrollView addSubview:cameraClickBtn];
    
    UILabel *captureLabel = [[UILabel alloc] initWithFrame:CGRectMake(cameraClickBtn.frame.origin.x + cameraClickBtn.frame.size.width/2 - (width/100)*15, cameraClickBtn.frame.origin.y + cameraClickBtn.frame.size.height + (height/100)*2, (width/100)*32, (width/100)*5)];
    
    [captureLabel setText:[LabelUtils getLabelForKey:@"capture"]];
    [captureLabel setTextAlignment:NSTextAlignmentCenter];
    [captureLabel setAlpha:0.5];
    [captureLabel setFont:[UIFont systemFontOfSize:14]];
    [scrollView addSubview:captureLabel];
    
    //Address 1 TextField
    address1TextField = [[UITextField alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x, backGroundWhiteView.frame.origin.y + backGroundWhiteView.frame.size.height + (height/100)*3, backGroundWhiteView.frame.size.width, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:address1TextField];
    [scrollView addSubview:address1TextField];
    
    NSString *addresscn = [LabelUtils getLabelForKey:@"address_1"];
    CGSize address1Size = [NSStringUtilsDemo getUILabelSizeFromLabel:addresscn size:14];
    UILabel *address1Label = [[UILabel alloc] initWithFrame:CGRectMake(address1TextField.frame.origin.x + 15, address1TextField.frame.origin.y - (address1Size.height/2), address1Size.width, address1Size.height)];
    [address1Label setText:addresscn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:address1Label];
    [scrollView addSubview:address1Label];
    
    //Address 2 TextField
    address2TextField = [[UITextField alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x, address1TextField.frame.origin.y + address1TextField.frame.size.height + (height/100)*2, backGroundWhiteView.frame.size.width, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:address2TextField];
    [scrollView addSubview:address2TextField];
    
    NSString *address2cn = [LabelUtils getLabelForKey:@"address_2"];
    CGSize address2Size = [NSStringUtilsDemo getUILabelSizeFromLabel:address2cn size:14];
    UILabel *address2Label = [[UILabel alloc] initWithFrame:CGRectMake(address2TextField.frame.origin.x + 15, address2TextField.frame.origin.y - (address2Size.height/2), address2Size.width, address2Size.height)];
    [address2Label setText:address2cn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:address2Label];
    [scrollView addSubview:address2Label];
    
    //Country TextField
    countryTextField = [[UITextField alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x, address2TextField.frame.origin.y + address2TextField.frame.size.height + (height/100)*2, backGroundWhiteView.frame.size.width, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:countryTextField];
    [scrollView addSubview:countryTextField];
    
    NSString *countrycn = [LabelUtils getLabelForKey:@"country"];
    CGSize countrySize = [NSStringUtilsDemo getUILabelSizeFromLabel:countrycn size:14];
    UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(countryTextField.frame.origin.x + 15, countryTextField.frame.origin.y - (countrySize.height/2), countrySize.width, countrySize.height)];
    [countryLabel setText:countrycn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:countryLabel];
    [scrollView addSubview:countryLabel];
    
    //State TextField
    stateTextField = [[UITextField alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x, countryTextField.frame.origin.y + countryTextField.frame.size.height + (height/100)*2, backGroundWhiteView.frame.size.width, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:stateTextField];
    [scrollView addSubview:stateTextField];
    
    NSString *statecn = [LabelUtils getLabelForKey:@"state"];
    CGSize stateSize = [NSStringUtilsDemo getUILabelSizeFromLabel:statecn size:14];
    UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(stateTextField.frame.origin.x + 15, stateTextField.frame.origin.y - (stateSize.height/2), stateSize.width, stateSize.height)];
    [stateLabel setText:statecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:stateLabel];
    [scrollView addSubview:stateLabel];
    
    //Zip Code Text Field
    zipTextField = [[UITextField alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x, stateTextField.frame.origin.y + stateTextField.frame.size.height + (height/100)*2, backGroundWhiteView.frame.size.width, (height/100)*7)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:zipTextField];
    [scrollView addSubview:zipTextField];
    
    NSString *zipcodecn = [LabelUtils getLabelForKey:@"postal_code"];
    CGSize zipcodeSize = [NSStringUtilsDemo getUILabelSizeFromLabel:zipcodecn size:14];
    UILabel *zipLabel = [[UILabel alloc] initWithFrame:CGRectMake(stateTextField.frame.origin.x + 15, zipTextField.frame.origin.y - (zipcodeSize.height/2), zipcodeSize.width, zipcodeSize.height)];
    [zipLabel setText:zipcodecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:zipLabel];
    [scrollView addSubview:zipLabel];
    
    // Recapture Button
    UIButton *recaptureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(backGroundWhiteView.frame.origin.x, zipTextField.frame.origin.y + zipTextField.frame.size.height + (height/100)*3, backGroundWhiteView.frame.size.width, (height/100)*6);
    [recaptureButton setFrame:frame];
    recaptureButton.layer.cornerRadius = 20;
    recaptureButton.clipsToBounds = YES;
    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
    recaptureButton.titleLabel.textColor = [UIColor whiteColor];
    [recaptureButton setBackgroundColor:[UIColor blackColor]];
    [recaptureButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [recaptureButton addTarget:self action:@selector(captureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:recaptureButton];
    
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
    [scrollView addSubview:backBtn];
    
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
    [scrollView addSubview:nextBtn];
    
    resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (width/100)*1, backGroundWhiteView.frame.origin.y + (height/100)*1, backGroundWhiteView.frame.size.width - (width/100)*2, backGroundWhiteView.frame.size.height - (height/100)*2)];
    resultImage.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:resultImage];
    
    return nextBtn.frame.size.height + nextBtn.frame.origin.y;
}

- (void)viewOnTouch:(UITapGestureRecognizer *)recognizer
{
    [recognizer locationInView:[recognizer.view superview]];
    if(isCapture){
        [AppItSDK captureAddressProof:[ArrayObjectController getPageDelegate] capturePortrait:isPortrait minimumLightThreshold:[lightThresholdTextField.text intValue] minimumFocusThreshold:[minFocusThreshold.text intValue] GlarePercentage:[glarePercentageTextField.text intValue] EnableCaptureButtonTime:[enableCapBtnTimeTextField.text intValue] ImageSize:[maxImageSize.text intValue] ImageHeight:[imageHeightTextField.text intValue] ImageWidth:[imageWidthTextField.text intValue] additionalDictionary:[ArrayObjectController getAdditionalDataDictionary] idOutlineColor:[idOutlineColorTextField text] idOutlineColorTransparency:[idOutlineColorTransTextField.text intValue] detectedPOAOutlineColor:[detectedIdOutlineColorTextField text] detectedPOAColorOutlineTransperency:[detectedIdOutlineColorTransTextField.text intValue] idOutsideOutlineColor:[colorOutsideOutlineTextField text] idOutsideOutlineColorTransparency:[colorOutsideOutlineTransTextField.text intValue] detectedColorOutsideOutline:[detectedColorOutsideOutlineTextField text] detectedColorOutsideOutlineTransparency:[detectedColorOutsideOutlineTransTextField.text intValue] titleImage:nil showInstruction:showInstScreen instructionimage:nil];
    }
}

-(NSMutableDictionary*)getAddressDataDictionary {
    
    NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
    
    NSString *add1TextField = [[address1TextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *add2TextField = [[address2TextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *couTextField = [[countryTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *staTextField = [[stateTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *zipCodeTxtField = [[zipTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:add1TextField]){
        [nsDict setObject:add1TextField forKey:@"AddrLine1"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:add2TextField]){
        [nsDict setObject:add1TextField forKey:@"AddrLine2"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:couTextField]){
        [nsDict setObject:add1TextField forKey:@"Country"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:staTextField]){
        [nsDict setObject:add1TextField forKey:@"State"];
    }
    
    if(![NSStringUtilsDemo stringIsNilOrEmpty:zipCodeTxtField]){
        [nsDict setObject:add1TextField forKey:@"ZipCode"];
    }
    
    if([nsDict count] > 0){
        return nsDict;
    }
    return nil;
    
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

@end
