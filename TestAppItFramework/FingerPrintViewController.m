//
//  FingerPrintViewController.m
//  NewProjectForPageView
//
//  Created by  on 03/10/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import "FingerPrintViewController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "NSStringUtilsDemo.h"
#import "LabelUtils.h"
#import "LabelUtils.h"
#import "FinalStepController.h"

@interface FingerPrintViewController ()

@end

@implementation FingerPrintViewController {
    UILabel *titleLabel;
    UIButton *recaptureButton;
    UIButton *configurationButton;
    UIScrollView *scrollView;
    bool isVisible;
    UITextField *fingThreshold;
    UIImageView *resultImage;
    
    NSMutableArray *imageArray;
    NSMutableArray *imageNameArray, *showFontStylePickerData,*_selectedFontStylePickerData;
    UILabel *fingerName;
    
    UIImageView *downUPArrowImage;
    NSArray *_selectedPickerData;
    NSArray *selectFingerPickerData;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    UITextField *selectFingerTextField,*showTitleImgTextField, *fontStyleTextField, *textColorTextField, *textColorTransTextField, *instContinueButtonTextField, *instContinueButtonTransTextField, *instContinueButtonTextColorField, *instContinueButtonTransTextColorField;
    bool isSnackBarVisible,isCapture,showInstScreen;
    UILabel *showMSGLabel;
    NSTimer *fiveSecondTimer;
    UIButton *clearBtn, *backBtn, *nextBtn, *noInstRadioBtn, *yesInstRadioBtn;
    UILabel *loginIdLabel;
    UIImageView *selectFingerDownArrowImage;
    CGSize loginSize;
    int mAlpha;
    NSString *dFontStyle, *dTextColor, *dInstContinueButtonColor, *dInstContinueButtonTextColor;
    
    UITextField *min_threshold_text_index, *min_threshold_text_middle, *min_threshold_text_ring, *min_threshold_text_baby;
    UITextField *max_threshold_text_index, *max_threshold_text_middle, *max_threshold_text_ring, *max_threshold_text_baby;
    UITextField *zoom_level_text;
    
    UIButton *keep_index_finger_button, *keep_middle_finger_button, *keep_ring_finger_button, *keep_baby_finger_button;
    UIButton *process_4k_frames_button;
    
    NSString *min_threshold_text_index_thresh, *min_threshold_text_middle_thresh, *min_threshold_text_ring_thresh, *min_threshold_text_baby_thresh;
    NSString *max_threshold_text_index_thresh, *max_threshold_text_middle_thresh, *max_threshold_text_ring_thresh, *max_threshold_text_baby_thresh;
    NSString *zoom_threshold_text_thresh;
    
    NSString *keep_index_finger_button_thresh, *keep_middle_finger_button_thresh, *keep_ring_finger_button_thresh, *keep_baby_finger_button_thresh;
    NSString *process_4k_frames_button_thresh;
    
    int recapture_btn_full_width, recapture_btn_half_width;
}

-(void)viewDidAppear:(BOOL)animated {
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    isSnackBarVisible = false;
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    [fontStyleTextField setDelegate:(id)self];

    selectFingerPickerData = @[@"ALL", @"LLFINGER", @"LIFINGER", @"LRFINGER", @"LMFINGER", @"RRFINGER", @"RIFINGER", @"RLFINGER", @"RMFINGER"];
    _selectedPickerData = @[@"ALL", @"LLFINGER", @"LIFINGER", @"LRFINGER", @"LMFINGER", @"RRFINGER", @"RIFINGER", @"RLFINGER", @"RMFINGER"];
    showFontStylePickerData = @[@"Default",@"Helvetica", @"Helvetica Bold", @"Helvetica Bold Oblique",@"Helvetica Light",@"Helvetica Light Oblique",@"Helvetica Neue",@"Helvetica Neue Bold",@"Helvetica Neue Bold Italic",@"Helvetica Neue Condensed Black",@"Helvetica Neue Condensed Bold",@"Helvetica Neue Italic",@"Helvetica Neue Light",@"Helvetica Neue Light Italic",@"Helvetica Neue Medium",@"Helvetica Neue Medium Italic",@"Helvetica Neue Thin",@"Helvetica Neue Thin Italic",@"Helvetica Neue UltraLight",@"Helvetica Neue UltraLight Italic",@"Helvetica Oblique"];
    _selectedFontStylePickerData = @[@"Helvetica", @"Helvetica Bold", @"Helvetica Bold Oblique",@"Helvetica Light",@"Helvetica Light Oblique",@"Helvetica Neue",@"Helvetica Neue Bold",@"Helvetica Neue Bold Italic",@"Helvetica Neue Condensed Black",@"Helvetica Neue Condensed Bold",@"Helvetica Neue Italic",@"Helvetica Neue Light",@"Helvetica Neue Light Italic",@"Helvetica Neue Medium",@"Helvetica Neue Medium Italic",@"Helvetica Neue Thin",@"Helvetica Neue Thin Italic",@"Helvetica Neue UltraLight",@"Helvetica Neue UltraLight Italic",@"Helvetica Oblique"];
    [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    myPickerView.layer.borderWidth = 1.0;
    myPickerView.layer.cornerRadius = 5.0;
    myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [selectFingerTextField setInputView:myPickerView];
    [selectFingerTextField setText:selectFingerPickerData[0]];
    
    [fontStyleTextField setInputView:myPickerView];
    [fontStyleTextField setText:showFontStylePickerData[0]];
    
    //Adding Toolbar with 'Done' button on picker view
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerDoneClicked)];
    
    toolbarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
    [toolbarForPicker setItems:toolbarItems];
    [selectFingerTextField setInputAccessoryView:toolbarForPicker];
    
    [fontStyleTextField setInputView:myPickerView];
    [fontStyleTextField setInputAccessoryView:toolbarForPicker];
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [selectFingerTextField resignFirstResponder];
    [fontStyleTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == selectFingerTextField){
        _selectedPickerData = selectFingerPickerData;
        [myPickerView reloadAllComponents];
    }else if (textField == fontStyleTextField){
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
    
    if([_selectedPickerData isEqualToArray:selectFingerPickerData]){
        [selectFingerTextField setText:selectFingerPickerData[row]];
        [selectFingerTextField setTag:row+1];
    }
    if([_selectedPickerData isEqualToArray:showFontStylePickerData]){
        [fontStyleTextField setText:showFontStylePickerData[row]];
        [fontStyleTextField setTag:row+1];
    }
}
//Picker Changes End

- (void)viewDidLoad {
    [super viewDidLoad];
    isVisible = false;
    isCapture = true;
    showInstScreen = true;

    mAlpha = 1;
    dFontStyle=@"Default", dTextColor=@"FFFFFF", dInstContinueButtonColor=@"FFFFFF", dInstContinueButtonTextColor=@"487D95";
    
    min_threshold_text_index_thresh = @"70";
    min_threshold_text_middle_thresh = @"70";
    min_threshold_text_ring_thresh = @"70";
    min_threshold_text_baby_thresh = @"40";

    max_threshold_text_index_thresh = @"100";
    max_threshold_text_middle_thresh = @"100";
    max_threshold_text_ring_thresh = @"100";
    max_threshold_text_baby_thresh = @"70";
        
    keep_index_finger_button_thresh = @"Y";
    keep_middle_finger_button_thresh = @"N";
    keep_ring_finger_button_thresh = @"N";
    keep_baby_finger_button_thresh = @"N";
    
    process_4k_frames_button_thresh = @"N";
    
    zoom_threshold_text_thresh = @"2";
    
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*30, (height/100)*0, width - (width/100)*40, (width/100)*10)];
    [titleLabel setText:[LabelUtils getLabelForKey:@"fingerprint_capture_4f_tab"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*60, (width/100)*0.5)];
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
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ArrayObjectController getPageControlY] - (height/100)*50 + (height/100)*50, width, (height/100)*50)];
    [scrollView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#e6fff9" alpha:1.0]];
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView];
    float scrollViewContentSizeHt =  [self scrollViewUI:scrollView];
    
    [scrollView setContentSize:CGSizeMake(width, scrollViewContentSizeHt + (height/100)*3)];
    
    [fingThreshold setDelegate:(id)self];
    [fingThreshold setKeyboardType:UIKeyboardTypeNumberPad];
    [fingThreshold setText:[self retrieveSetting:@"fingerThreshold" defaultValue:@"15"]];
    
    NSString *textColor = [self retrieveSetting:@"textColor" defaultValue:dTextColor];
    NSString *textColorTrans = [self retrieveSetting:@"textColorTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueButton = [self retrieveSetting:@"instContinueButton" defaultValue:dInstContinueButtonColor];
    NSString *instContinueButtonTrans = [self retrieveSetting:@"instContinueButtonTransparency" defaultValue:[@(mAlpha) stringValue]];
    NSString *instContinueTextColor = [self retrieveSetting:@"instContinueButtonText" defaultValue:dInstContinueButtonTextColor];
    NSString *instContinueTextColorTrans = [self retrieveSetting:@"instContinueButtonTextTransparency" defaultValue:[@(mAlpha) stringValue]];
    
    [textColorTextField setText:textColor];
    [textColorTransTextField setText:textColorTrans];
    [instContinueButtonTextField setText:instContinueButton];
    [instContinueButtonTransTextField setText:instContinueButtonTrans];
    [instContinueButtonTextColorField setText:instContinueTextColor];
    [instContinueButtonTransTextColorField setText:instContinueTextColorTrans];
    
    [self setUITextFieldStyle:min_threshold_text_index];
    [min_threshold_text_index setText:[self retrieveSetting:@"min_threshold_text_index" defaultValue:min_threshold_text_index_thresh]];
    
    [self setUITextFieldStyle:max_threshold_text_index];
    [max_threshold_text_index setText:[self retrieveSetting:@"max_threshold_text_index" defaultValue:max_threshold_text_index_thresh]];
    
    [self setUITextFieldStyle:min_threshold_text_middle];
    [min_threshold_text_middle setText:[self retrieveSetting:@"min_threshold_text_middle" defaultValue:min_threshold_text_middle_thresh]];
    
    [self setUITextFieldStyle:max_threshold_text_middle];
    [max_threshold_text_middle setText:[self retrieveSetting:@"max_threshold_text_middle" defaultValue:max_threshold_text_middle_thresh]];
    
    [self setUITextFieldStyle:min_threshold_text_ring];
    [min_threshold_text_ring setText:[self retrieveSetting:@"min_threshold_text_ring" defaultValue:min_threshold_text_ring_thresh]];
    
    [self setUITextFieldStyle:max_threshold_text_ring];
    [max_threshold_text_ring setText:[self retrieveSetting:@"max_threshold_text_ring" defaultValue:max_threshold_text_ring_thresh]];
    
    [self setUITextFieldStyle:min_threshold_text_baby];
    [min_threshold_text_baby setText:[self retrieveSetting:@"min_threshold_text_baby" defaultValue:min_threshold_text_baby_thresh]];
    
    [self setUITextFieldStyle:max_threshold_text_baby];
    [max_threshold_text_baby setText:[self retrieveSetting:@"max_threshold_text_baby" defaultValue:max_threshold_text_baby_thresh]];
    
    [self setUITextFieldStyle:zoom_level_text];
    [zoom_level_text setText:[self retrieveSetting:@"zoom_level_text" defaultValue:zoom_threshold_text_thresh]];
    
}

-(void)setUITextFieldProperty:(UITextField*)uiTextField{
    [uiTextField setDelegate:(id)self];
    [uiTextField setKeyboardType:UIKeyboardTypeNumberPad];
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

-(void)configurationBtnClicked:(UIButton*)button {
    [self configBtnClickedMethod];
}

-(void)configBtnClickedMethod {
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

-(void)setLabelStyle:(UILabel*)ui_label{
    [ui_label setAlpha:0.7];
    [ui_label setFont:[UIFont systemFontOfSize:14]];
    ui_label.numberOfLines = 0;
    ui_label.lineBreakMode = NSLineBreakByWordWrapping;
}

-(void)setUITextFieldStyle:(UITextField*)ui_label{
    [ui_label setFont:[UIFont systemFontOfSize:12]];
    ui_label.layer.cornerRadius = 5;
    ui_label.layer.borderWidth = 1.0;
    ui_label.layer.borderColor = [[UIColor grayColor]CGColor];
    [ui_label setAlpha:0.7];
    [ui_label setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    ui_label.borderStyle = UITextBorderStyleRoundedRect;
    [ui_label setKeyboardType:UIKeyboardTypeNumberPad];
}

-(void)toggleCameraBtnClick:(UIButton*)button {    
    if([button tag] == 0){
        [button setTag:1];
        [button setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    }else{
        [button setTag:0];
        [button setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    }
}

-(int)getTagFromNSString:(NSString*)tag_value{
    if([tag_value isEqualToString:@"N"]){
        return 0;
    }else{
        return 1;
    }
}

-(UIImage*)getCorrectToggleImage:(NSString*)tag_value{
    if([tag_value isEqualToString:@"N"]){
        return [UIImage imageNamed:@"toggleOf.png"];
    }else{
        return [UIImage imageNamed:@"toggleOn.png"];
    }
}

-(NSString*)getNSStringFromTag:(int)tag_value{
    if(tag_value == 0){
        return @"N";
    }else{
        return @"Y";
    }
}

- (float)scrollViewUI:(UIScrollView *)scrollView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    
    CGRect last_element_frame;
    
    float each_element_height = 30.0;
    float each_element_width = (width*0.40);
    
//    float first_element_x_position = (width/100)*4;
    float first_element_x_position = width*0.05;
    float first_element_y_position = (height/100)*2;
    float second_element_x_position = first_element_x_position*2 + each_element_width;
    float next_rows_y_position = first_element_y_position;
    
    UILabel *min_threshold_label_index = [[UILabel alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [min_threshold_label_index setText:@"Index Finger(Min)"];
    [self setLabelStyle:min_threshold_label_index];
    [scrollView addSubview:min_threshold_label_index];
    
    UILabel *max_threshold_label_index = [[UILabel alloc] initWithFrame:CGRectMake(second_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [max_threshold_label_index setText:@"Index Finger(Max)"];
    [self setLabelStyle:max_threshold_label_index];
    [scrollView addSubview:max_threshold_label_index];
    
    next_rows_y_position = next_rows_y_position + min_threshold_label_index.frame.size.height;
    
    min_threshold_text_index = [[UITextField alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [self setUITextFieldStyle:min_threshold_text_index];
    [scrollView addSubview:min_threshold_text_index];
    
    max_threshold_text_index = [[UITextField alloc] initWithFrame:CGRectMake(second_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [self setUITextFieldStyle:max_threshold_text_index];
    [scrollView addSubview:max_threshold_text_index];
    
    next_rows_y_position = next_rows_y_position + min_threshold_text_index.frame.size.height;
    
    UILabel *min_threshold_label_middle = [[UILabel alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [min_threshold_label_middle setText:@"Middle Finger(Min)"];
    [self setLabelStyle:min_threshold_label_middle];
    [scrollView addSubview:min_threshold_label_middle];
    
    UILabel *max_threshold_label_middle = [[UILabel alloc] initWithFrame:CGRectMake(second_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [max_threshold_label_middle setText:@"Middle Finger(Max)"];
    [self setLabelStyle:max_threshold_label_middle];
    [scrollView addSubview:max_threshold_label_middle];
    
    next_rows_y_position = next_rows_y_position + min_threshold_label_index.frame.size.height;
    
    min_threshold_text_middle = [[UITextField alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [self setUITextFieldStyle:min_threshold_text_middle];
    [scrollView addSubview:min_threshold_text_middle];
    
    max_threshold_text_middle = [[UITextField alloc] initWithFrame:CGRectMake(second_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [self setUITextFieldStyle:max_threshold_text_middle];
    [scrollView addSubview:max_threshold_text_middle];
    
    next_rows_y_position = next_rows_y_position + min_threshold_text_middle.frame.size.height;
    
    UILabel *min_threshold_label_ring = [[UILabel alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [min_threshold_label_ring setText:@"Ring Finger(Min)"];
    [self setLabelStyle:min_threshold_label_ring];
    [scrollView addSubview:min_threshold_label_ring];
    
    UILabel *max_threshold_label_ring = [[UILabel alloc] initWithFrame:CGRectMake(second_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [max_threshold_label_ring setText:@"Ring Finger(Max)"];
    [self setLabelStyle:max_threshold_label_ring];
    [scrollView addSubview:max_threshold_label_ring];
    
    next_rows_y_position = next_rows_y_position + min_threshold_label_ring.frame.size.height;
    
    min_threshold_text_ring = [[UITextField alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [self setUITextFieldStyle:min_threshold_text_ring];
    [scrollView addSubview:min_threshold_text_ring];
    
    max_threshold_text_ring = [[UITextField alloc] initWithFrame:CGRectMake(second_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [self setUITextFieldStyle:max_threshold_text_ring];
    [scrollView addSubview:max_threshold_text_ring];
    
    next_rows_y_position = next_rows_y_position + min_threshold_text_ring.frame.size.height;
    
    UILabel *min_threshold_label_baby = [[UILabel alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [min_threshold_label_baby setText:@"Baby Finger(Min)"];
    [self setLabelStyle:min_threshold_label_baby];
    [scrollView addSubview:min_threshold_label_baby];
    
    UILabel *max_threshold_label_baby = [[UILabel alloc] initWithFrame:CGRectMake(second_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [max_threshold_label_baby setText:@"Baby Finger(Max)"];
    [self setLabelStyle:max_threshold_label_baby];
    [scrollView addSubview:max_threshold_label_baby];
    
    next_rows_y_position = next_rows_y_position + max_threshold_label_baby.frame.size.height;
    
    min_threshold_text_baby = [[UITextField alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [self setUITextFieldStyle:min_threshold_text_baby];
    [scrollView addSubview:min_threshold_text_baby];
    
    max_threshold_text_baby = [[UITextField alloc] initWithFrame:CGRectMake(second_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [self setUITextFieldStyle:max_threshold_text_baby];
    [scrollView addSubview:max_threshold_text_baby];
    
    next_rows_y_position = next_rows_y_position + min_threshold_text_baby.frame.size.height;
    
    UILabel *zoom_threshold_label = [[UILabel alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [zoom_threshold_label setText:@"Zoom"];
    [self setLabelStyle:zoom_threshold_label];
    [scrollView addSubview:zoom_threshold_label];
    
    next_rows_y_position = next_rows_y_position + zoom_threshold_label.frame.size.height;
    
    zoom_level_text = [[UITextField alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [self setUITextFieldStyle:zoom_level_text];
    [scrollView addSubview:zoom_level_text];
    
    next_rows_y_position = next_rows_y_position + zoom_level_text.frame.size.height;
    
    //Show Instruction Screen
    //Show Instruction Screen Label
    UILabel *instructionScreenLabel = [[UILabel alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [instructionScreenLabel setText:[LabelUtils getLabelForKey:@"show_inst_screen"]];
    [self setLabelStyle:instructionScreenLabel];
    [scrollView addSubview:instructionScreenLabel];
    
    next_rows_y_position = next_rows_y_position + instructionScreenLabel.frame.size.height;
    
//    NoRadio Button
    noInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    noInstRadioBtn.frame = CGRectMake(first_element_x_position, next_rows_y_position, 50, 50);
    [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"] forState:UIControlStateNormal];
    [noInstRadioBtn addTarget:self action:@selector(noInstChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:noInstRadioBtn];
    
    //No Label
    UILabel *noInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(noInstRadioBtn.frame.origin.x + noInstRadioBtn.frame.size.width, next_rows_y_position, 50, 50)];
    [noInstLabel setText:[LabelUtils getLabelForKey:@"no"]];
    [self setLabelStyle:noInstLabel];
    [scrollView addSubview:noInstLabel];
    
    //YesRadio Button
    yesInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yesInstRadioBtn.frame = CGRectMake(noInstLabel.frame.origin.x + noInstLabel.frame.size.width, next_rows_y_position, 50, 50);
    [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"] forState:UIControlStateNormal];
    [yesInstRadioBtn addTarget:self action:@selector(yesInstChkBox:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:yesInstRadioBtn];
    
    //Yes Label
    UILabel *yesInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(yesInstRadioBtn.frame.origin.x + yesInstRadioBtn.frame.size.width, next_rows_y_position, 50, 50)];
    [yesInstLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    [self setLabelStyle:yesInstLabel];
    [scrollView addSubview:yesInstLabel];
    
    next_rows_y_position = next_rows_y_position + noInstRadioBtn.frame.size.height;
    
    UILabel *keep_index_finger_label = [[UILabel alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [keep_index_finger_label setText:@"Keep index finger"];
    [self setLabelStyle:keep_index_finger_label];
    [scrollView addSubview:keep_index_finger_label];
    
    keep_index_finger_button = [UIButton buttonWithType:UIButtonTypeCustom];
    keep_index_finger_button.frame = CGRectMake(second_element_x_position, next_rows_y_position, 40, 40);
    [keep_index_finger_button setImage:[self getCorrectToggleImage:keep_index_finger_button_thresh] forState:UIControlStateNormal];
    keep_index_finger_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    [keep_index_finger_button addTarget:self action:@selector(toggleCameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [keep_index_finger_button setTag:[self getTagFromNSString:keep_index_finger_button_thresh]];
    [scrollView addSubview:keep_index_finger_button];
    
    next_rows_y_position = next_rows_y_position + keep_index_finger_button.frame.size.height;
    
    UILabel *keep_middle_finger_label = [[UILabel alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [keep_middle_finger_label setText:@"Keep middle finger"];
    [self setLabelStyle:keep_middle_finger_label];
    [scrollView addSubview:keep_middle_finger_label];
    
    keep_middle_finger_button = [UIButton buttonWithType:UIButtonTypeCustom];
    keep_middle_finger_button.frame = CGRectMake(second_element_x_position, next_rows_y_position, 40, 40);
    [keep_middle_finger_button setImage:[self getCorrectToggleImage:keep_middle_finger_button_thresh] forState:UIControlStateNormal];
    keep_middle_finger_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    [keep_middle_finger_button addTarget:self action:@selector(toggleCameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [keep_middle_finger_button setTag:[self getTagFromNSString:keep_middle_finger_button_thresh]];
    [scrollView addSubview:keep_middle_finger_button];
    
    next_rows_y_position = next_rows_y_position + keep_middle_finger_button.frame.size.height;
    
    UILabel *keep_ring_finger_label = [[UILabel alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [keep_ring_finger_label setText:@"Keep ring finger"];
    [self setLabelStyle:keep_ring_finger_label];
    [scrollView addSubview:keep_ring_finger_label];
    
    keep_ring_finger_button = [UIButton buttonWithType:UIButtonTypeCustom];
    keep_ring_finger_button.frame = CGRectMake(second_element_x_position, next_rows_y_position, 40, 40);
    [keep_ring_finger_button setImage:[self getCorrectToggleImage:keep_ring_finger_button_thresh] forState:UIControlStateNormal];
    keep_ring_finger_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    [keep_ring_finger_button addTarget:self action:@selector(toggleCameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [keep_ring_finger_button setTag:[self getTagFromNSString:keep_ring_finger_button_thresh]];
    [scrollView addSubview:keep_ring_finger_button];
    
    next_rows_y_position = next_rows_y_position + keep_ring_finger_button.frame.size.height;
    
    UILabel *keep_baby_finger_label = [[UILabel alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [keep_baby_finger_label setText:@"Keep baby finger"];
    [self setLabelStyle:keep_baby_finger_label];
    [scrollView addSubview:keep_baby_finger_label];
    
    keep_baby_finger_button = [UIButton buttonWithType:UIButtonTypeCustom];
    keep_baby_finger_button.frame = CGRectMake(second_element_x_position, next_rows_y_position, 40, 40);
    [keep_baby_finger_button setImage:[self getCorrectToggleImage:keep_baby_finger_button_thresh] forState:UIControlStateNormal];
    keep_baby_finger_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    [keep_baby_finger_button addTarget:self action:@selector(toggleCameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [keep_baby_finger_button setTag:[self getTagFromNSString:keep_baby_finger_button_thresh]];
    [scrollView addSubview:keep_baby_finger_button];
    
    next_rows_y_position = next_rows_y_position + keep_baby_finger_button.frame.size.height;
    next_rows_y_position = next_rows_y_position + keep_baby_finger_button.frame.size.height; //Extra space
    
    UILabel *process_4k_frames_label = [[UILabel alloc] initWithFrame:CGRectMake(first_element_x_position, next_rows_y_position, each_element_width, each_element_height)];
    [process_4k_frames_label setText:@"Process 4K Frames"];
    [self setLabelStyle:process_4k_frames_label];
    [scrollView addSubview:process_4k_frames_label];
    
    process_4k_frames_button = [UIButton buttonWithType:UIButtonTypeCustom];
    process_4k_frames_button.frame = CGRectMake(second_element_x_position, next_rows_y_position, 40, 40);
    [process_4k_frames_button setImage:[self getCorrectToggleImage:process_4k_frames_button_thresh] forState:UIControlStateNormal];
    process_4k_frames_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    [process_4k_frames_button addTarget:self action:@selector(toggleCameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [process_4k_frames_button setTag:[self getTagFromNSString:process_4k_frames_button_thresh]];
    [scrollView addSubview:process_4k_frames_button];
    
    next_rows_y_position = next_rows_y_position + process_4k_frames_button.frame.size.height;

    
    last_element_frame = process_4k_frames_button.frame;
    
//    //Id Outline color
//    UILabel *focusThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,(width/100)*44, (height/100)*2)];
//    [focusThresholdLabel setText:[LabelUtils getLabelForKey:@"finger_print_threshold"]];
//    [focusThresholdLabel setAlpha:0.7];
//    [focusThresholdLabel setFont:[UIFont systemFontOfSize:14]];
//    focusThresholdLabel.numberOfLines = 0;
//    focusThresholdLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [scrollView addSubview:focusThresholdLabel];
//
//    //id outline color TextField
//    fingThreshold = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, focusThresholdLabel.frame.origin.y + focusThresholdLabel.frame.size.height + (height/100)*1, (width/100)*88, (height/100)*4)];
//    [fingThreshold setFont:[UIFont systemFontOfSize:12]];
//    fingThreshold.layer.cornerRadius = 5;
//    fingThreshold.layer.borderWidth = 1.0;
//    fingThreshold.layer.borderColor = [[UIColor grayColor]CGColor];
//    [fingThreshold setAlpha:0.7];
//    [fingThreshold setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
//    fingThreshold.borderStyle = UITextBorderStyleRoundedRect;
//    [scrollView addSubview:fingThreshold];
//
//    //Show Instruction Screen
//    //Show Instruction Screen Label
//    UILabel *instructionScreenLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,fingThreshold.frame.origin.y+25 + focusThresholdLabel.frame.size.height + (height/100)*2, fingThreshold.frame.size.width, (height/100)*2)];
//    [instructionScreenLabel setText:[LabelUtils getLabelForKey:@"show_inst_screen"]];
//    [instructionScreenLabel setAlpha:0.7];
//    [instructionScreenLabel setFont:[UIFont systemFontOfSize:11]];
//    instructionScreenLabel.numberOfLines = 0;
//    instructionScreenLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [scrollView addSubview:instructionScreenLabel];
//
//    //NoRadio Button
//    noInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    noInstRadioBtn.frame = CGRectMake(focusThresholdLabel.frame.origin.x, instructionScreenLabel.frame.origin.y + instructionScreenLabel.frame.size.height + (height/100)*1, (width/100)*7, (height/100)*4);
//    //    [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
//    //                    forState:UIControlStateNormal];
//    [noInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
//                    forState:UIControlStateNormal];
//    [noInstRadioBtn addTarget:self action:@selector(noInstChkBox:) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:noInstRadioBtn];
//
//    //No Label
//    UILabel *noInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(noInstRadioBtn.frame.origin.x + noInstRadioBtn.frame.size.width + (width/100)*2, noInstRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
//    [noInstLabel setText:[LabelUtils getLabelForKey:@"no"]];
//    [noInstLabel setAlpha:0.7];
//    [noInstLabel setFont:[UIFont systemFontOfSize:14]];
//    noInstLabel.numberOfLines = 0;
//    noInstLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [scrollView addSubview:noInstLabel];
//
//    //YesRadio Button
//    yesInstRadioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    yesInstRadioBtn.frame = CGRectMake(noInstLabel.frame.origin.x + noInstLabel.frame.size.width + (width/100)*2, noInstRadioBtn.frame.origin.y, (width/100)*7, (height/100)*4);
//    //    [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnUnChk.png"]
//    //                     forState:UIControlStateNormal];
//    [yesInstRadioBtn setImage:[UIImage imageNamed:@"radioBtnChk.png"]
//                     forState:UIControlStateNormal];
//    [yesInstRadioBtn addTarget:self action:@selector(yesInstChkBox:) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:yesInstRadioBtn];
//
//    //Yes Label
//    UILabel *yesInstLabel = [[UILabel alloc] initWithFrame:CGRectMake(yesInstRadioBtn.frame.origin.x + yesInstRadioBtn.frame.size.width + (width/100)*2, yesInstRadioBtn.frame.origin.y, (width/100)*25, (height/100)*4)];
//    [yesInstLabel setText:[LabelUtils getLabelForKey:@"yes"]];
//    [yesInstLabel setAlpha:0.7];
//    [yesInstLabel setFont:[UIFont systemFontOfSize:14]];
//    yesInstLabel.numberOfLines = 0;
//    yesInstLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [scrollView addSubview:yesInstLabel];
//
//    //Font Style
//    //Font Style Label
//    UILabel *textFontStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,noInstLabel.frame.origin.y + noInstLabel.frame.size.height +   (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
//    [textFontStyleLabel setText:[LabelUtils getLabelForKey:@"text_font_style"]];
//    [textFontStyleLabel setAlpha:0.7];
//    [textFontStyleLabel setFont:[UIFont systemFontOfSize:11]];
//    textFontStyleLabel.numberOfLines = 0;
//    textFontStyleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [textFontStyleLabel setHidden: YES];
//    textFontStyleLabel.hidden = YES;
//    [scrollView addSubview:textFontStyleLabel];
//
//    //Font Style TextField
//    fontStyleTextField = [[UITextField alloc] initWithFrame: CGRectMake(focusThresholdLabel.frame.origin.x, textFontStyleLabel.frame.origin.y + textFontStyleLabel.frame.size.height + (height/100)*0, (width/100)*88, (height/100)*0)];
//    [fontStyleTextField setFont:[UIFont systemFontOfSize:12]];
//    fontStyleTextField.layer.cornerRadius = 5;
//    fontStyleTextField.layer.borderWidth = 1.0;
//    fontStyleTextField.layer.borderColor = [[UIColor grayColor]CGColor];
//    [fontStyleTextField setAlpha:0.7];
//    [fontStyleTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
//    fontStyleTextField.borderStyle = UITextBorderStyleRoundedRect;
//    [fontStyleTextField setHidden: YES];
//    fontStyleTextField.hidden = YES;
//    [scrollView addSubview:fontStyleTextField];
//
//    //Continue Button Text color Label
////    UILabel *continueButtonTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightThresholdLabel.frame.origin.x,instContinueButtonTextField.frame.origin.y + instContinueButtonTextField.frame.size.height +   (height/100)*2, lightThresholdLabel.frame.size.width, (height/100)*2)];
////    [continueButtonTextColorLabel setText:@"Instruction Button Text Color"];
////    [continueButtonTextColorLabel setAlpha:0.7];
////    [continueButtonTextColorLabel setFont:[UIFont systemFontOfSize:11]];
////    continueButtonTextColorLabel.numberOfLines = 0;
////    continueButtonTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
////    [scrollView addSubview:continueButtonTextColorLabel];
////
////    //Transparency Label
////    UILabel *continueButtonTransTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,instContinueButtonTransTextField.frame.origin.y + instContinueButtonTransTextField.frame.size.height +  (height/100)*2, focusThresholdLabel.frame.size.width, (height/100)*2)];
////    [continueButtonTransTextColorLabel setText:@"Transparency(1-100)"];
////    [continueButtonTransTextColorLabel setAlpha:0.7];
////    continueButtonTransTextColorLabel.numberOfLines = 0;
////    continueButtonTransTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
////    [continueButtonTransTextColorLabel setFont:[UIFont systemFontOfSize:11]];
////    [scrollView addSubview:continueButtonTransTextColorLabel];
//
//   //  UILabel *focusThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52, (height/100)*2, (width/100)*44, (height/100)*2)];
//   // UILabel *lightThresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*4, (height/100)*2,(width/100)*44, (height/100)*2)];
//
//    //Text Color/transparency
//    //Text Color Label
//    UILabel *textColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,fontStyleTextField.frame.origin.y + fontStyleTextField.frame.size.height +   (height/100)*2, (width/100)*44, (height/100)*0)];
//    [textColorLabel setText:[LabelUtils getLabelForKey:@"text_label_color"]];
//    [textColorLabel setAlpha:0.7];
//    [textColorLabel setFont:[UIFont systemFontOfSize:11]];
//    textColorLabel.numberOfLines = 0;
//    textColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [textColorLabel setHidden: YES];
//    textColorLabel.hidden = YES;
//    [scrollView addSubview:textColorLabel];
//
//    //Text Color TextField
//    textColorTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, textColorLabel.frame.origin.y + textColorLabel.frame.size.height + (height/100)*1, focusThresholdLabel.frame.size.width, (height/100)*4)];
//    [textColorTextField setFont:[UIFont systemFontOfSize:12]];
//    textColorTextField.layer.cornerRadius = 5;
//    textColorTextField.layer.borderWidth = 1.0;
//    textColorTextField.layer.borderColor = [[UIColor grayColor]CGColor];
//    [textColorTextField setAlpha:0.7];
//    [textColorTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
//    textColorTextField.borderStyle = UITextBorderStyleRoundedRect;
//    [textColorTextField setHidden: YES];
//    textColorTextField.hidden = YES;
//    [scrollView addSubview:textColorTextField];
//
//    //Transparency Label
//    UILabel *textColorTransLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*52,textColorLabel.frame.origin.y, textColorLabel.frame.size.width, (height/100)*2)];
//    [textColorTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
//    [textColorTransLabel setAlpha:0.7];
//    textColorTransLabel.numberOfLines = 0;
//    textColorTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [textColorTransLabel setFont:[UIFont systemFontOfSize:11]];
//    [textColorTransLabel setHidden: YES];
//    textColorTransLabel.hidden = YES;
//    [scrollView addSubview:textColorTransLabel];
//
//    //Transparency TextField
//    textColorTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(textColorTransLabel.frame.origin.x, textColorTextField.frame.origin.y, textColorTransLabel.frame.size.width, (height/100)*4)];
//    [textColorTransTextField setFont:[UIFont systemFontOfSize:12]];
//    textColorTransTextField.layer.cornerRadius = 5;
//    textColorTransTextField.layer.borderWidth = 1.0;
//    textColorTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
//    [textColorTransTextField setAlpha:0.7];
//    [textColorTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
//    textColorTransTextField.borderStyle = UITextBorderStyleRoundedRect;
//    textColorTransTextField.keyboardType = UIKeyboardTypeNumberPad;
//    [textColorTransTextField setHidden: YES];
//    textColorTransTextField.hidden = YES;
//    [scrollView addSubview:textColorTransTextField];
//
//    //Instruction continue Button/Transparency
//    //continue Button Label
//    UILabel *continueButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,textColorTextField.frame.origin.y + textColorTextField.frame.size.height +   (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
//    [continueButtonLabel setText:[LabelUtils getLabelForKey:@"instruction_button_color"]];
//    [continueButtonLabel setAlpha:0.7];
//    [continueButtonLabel setFont:[UIFont systemFontOfSize:11]];
//    continueButtonLabel.numberOfLines = 0;
//    continueButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [continueButtonLabel setHidden: YES];
//    continueButtonLabel.hidden = YES;
//    [scrollView addSubview:continueButtonLabel];
//
//    //continue Button TextField
//    instContinueButtonTextField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, continueButtonLabel.frame.origin.y + continueButtonLabel.frame.size.height + (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
//    [instContinueButtonTextField setFont:[UIFont systemFontOfSize:12]];
//    instContinueButtonTextField.layer.cornerRadius = 5;
//    instContinueButtonTextField.layer.borderWidth = 1.0;
//    instContinueButtonTextField.layer.borderColor = [[UIColor grayColor]CGColor];
//    [instContinueButtonTextField setAlpha:0.7];
//    [instContinueButtonTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
//    instContinueButtonTextField.borderStyle = UITextBorderStyleRoundedRect;
//    [instContinueButtonTextField setHidden: YES];
//    instContinueButtonTextField.hidden = YES;
//    [scrollView addSubview:instContinueButtonTextField];
//
//    //Transparency Label
//    UILabel *continueButtonTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(textColorTransTextField.frame.origin.x,textColorTransTextField.frame.origin.y + textColorTransTextField.frame.size.height +  (height/100)*0, textColorTransTextField.frame.size.width, (height/100)*0)];
//    [continueButtonTransLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
//    [continueButtonTransLabel setAlpha:0.7];
//    continueButtonTransLabel.numberOfLines = 0;
//    continueButtonTransLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [continueButtonTransLabel setFont:[UIFont systemFontOfSize:11]];
//    [continueButtonTransLabel setHidden: YES];
//    continueButtonTransLabel.hidden = YES;
//    [scrollView addSubview:continueButtonTransLabel];
//
//    //Transparency TextField
//    instContinueButtonTransTextField = [[UITextField alloc] initWithFrame:CGRectMake(continueButtonTransLabel.frame.origin.x, continueButtonTransLabel.frame.origin.y + continueButtonTransLabel.frame.size.height + (height/100)*0, continueButtonTransLabel.frame.size.width, (height/100)*0)];
//    [instContinueButtonTransTextField setFont:[UIFont systemFontOfSize:12]];
//    instContinueButtonTransTextField.layer.cornerRadius = 5;
//    instContinueButtonTransTextField.layer.borderWidth = 1.0;
//    instContinueButtonTransTextField.layer.borderColor = [[UIColor grayColor]CGColor];
//    [instContinueButtonTransTextField setAlpha:0.7];
//    [instContinueButtonTransTextField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
//    instContinueButtonTransTextField.borderStyle = UITextBorderStyleRoundedRect;
//    instContinueButtonTransTextField.keyboardType = UIKeyboardTypeNumberPad;
//    [instContinueButtonTransTextField setHidden: YES];
//    instContinueButtonTransTextField.hidden = YES;
//    [scrollView addSubview:instContinueButtonTransTextField];
//
//    //Instruction continue Text color Button/Transparency
//    //Continue Button Text color Label
//    UILabel *continueButtonTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x,instContinueButtonTransTextField.frame.origin.y + instContinueButtonTransTextField.frame.size.height +   (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
//    [continueButtonTextColorLabel setText:[LabelUtils getLabelForKey:@"instruction_button_text_color"]];
//    [continueButtonTextColorLabel setAlpha:0.7];
//    [continueButtonTextColorLabel setFont:[UIFont systemFontOfSize:11]];
//    continueButtonTextColorLabel.numberOfLines = 0;
//    continueButtonTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [continueButtonTextColorLabel setHidden: YES];
//    continueButtonTextColorLabel.hidden = YES;
//    [scrollView addSubview:continueButtonTextColorLabel];
//
//    //Continue Button text color TextField
//    instContinueButtonTextColorField = [[UITextField alloc] initWithFrame:CGRectMake(focusThresholdLabel.frame.origin.x, continueButtonTextColorLabel.frame.origin.y + continueButtonTextColorLabel.frame.size.height + (height/100)*0, focusThresholdLabel.frame.size.width, (height/100)*0)];
//    [instContinueButtonTextColorField setFont:[UIFont systemFontOfSize:12]];
//    instContinueButtonTextColorField.layer.cornerRadius = 5;
//    instContinueButtonTextColorField.layer.borderWidth = 1.0;
//    instContinueButtonTextColorField.layer.borderColor = [[UIColor grayColor]CGColor];
//    [instContinueButtonTextColorField setAlpha:0.7];
//    [instContinueButtonTextColorField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
//    instContinueButtonTextColorField.borderStyle = UITextBorderStyleRoundedRect;
//    [instContinueButtonTextColorField setHidden: YES];
//    instContinueButtonTextColorField.hidden = YES;
//    [scrollView addSubview:instContinueButtonTextColorField];
//
//    //Transparency Label
//    UILabel *continueButtonTransTextColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(instContinueButtonTransTextField.frame.origin.x,instContinueButtonTransTextField.frame.origin.y + instContinueButtonTransTextField.frame.size.height +  (height/100)*0, instContinueButtonTransTextField.frame.size.width, (height/100)*0)];
//    [continueButtonTransTextColorLabel setText:[LabelUtils getLabelForKey:@"transparency"]];
//    [continueButtonTransTextColorLabel setAlpha:0.7];
//    continueButtonTransTextColorLabel.numberOfLines = 0;
//    continueButtonTransTextColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [continueButtonTransTextColorLabel setFont:[UIFont systemFontOfSize:11]];
//    [continueButtonTransTextColorLabel setHidden: YES];
//    continueButtonTransTextColorLabel.hidden = YES;
//    [scrollView addSubview:continueButtonTransTextColorLabel];
//
//
//    //Transparency TextField
//    instContinueButtonTransTextColorField= [[UITextField alloc] initWithFrame:CGRectMake(continueButtonTransTextColorLabel.frame.origin.x, continueButtonTransTextColorLabel.frame.origin.y + continueButtonTransTextColorLabel.frame.size.height + (height/100)*0, continueButtonTransTextColorLabel.frame.size.width, (height/100)*0)];
//    [instContinueButtonTransTextColorField setFont:[UIFont systemFontOfSize:12]];
//    instContinueButtonTransTextColorField.layer.cornerRadius = 5;
//    instContinueButtonTransTextColorField.layer.borderWidth = 1.0;
//    instContinueButtonTransTextColorField.layer.borderColor = [[UIColor grayColor]CGColor];
//    [instContinueButtonTransTextColorField setAlpha:0.7];
//    [instContinueButtonTransTextColorField setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
//    instContinueButtonTransTextColorField.borderStyle = UITextBorderStyleRoundedRect;
//    instContinueButtonTransTextColorField.keyboardType = UIKeyboardTypeNumberPad;
//    [instContinueButtonTransTextColorField setHidden: YES];
//    instContinueButtonTransTextColorField.hidden = YES;
//    [scrollView addSubview:instContinueButtonTransTextColorField];
    
    //Save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(first_element_x_position, last_element_frame.origin.y + last_element_frame.size.height + (height/100)*2, (width/100)*44, (height/100)*6);
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

-(void)saveButton:(UIButton*)button {
    NSString *fontStyle=dFontStyle, *textColor=dTextColor, *instContinueButtonColor=dInstContinueButtonColor, *instContinueButtonTextColor=dInstContinueButtonTextColor;
    
    int textColorTrans=mAlpha, instContinueButtonTrans=mAlpha, instContinueButtonTransText=mAlpha;
    
    fontStyle = fontStyleTextField.text;
    textColorTrans=[textColorTransTextField.text intValue];
    textColor = textColorTextField.text;
    instContinueButtonColor = instContinueButtonTextField.text;
    instContinueButtonTextColor = instContinueButtonTextColorField.text;
    instContinueButtonTrans=[instContinueButtonTransTextField.text intValue];
    instContinueButtonTransText=[instContinueButtonTransTextColorField.text intValue];
    
    [self saveSetting:@"textColor" value:textColor];
    [self saveSetting:@"instContinueButton" value:instContinueButtonColor];
    [self saveSetting:@"instContinueButtonText" value:instContinueButtonTextColor];
    [self saveSetting:@"textColorTransparency" value:[NSString stringWithFormat:@"%d",textColorTrans]];
    [self saveSetting:@"instContinueButtonTransparency" value:[NSString stringWithFormat:@"%d",instContinueButtonTrans]];
    [self saveSetting:@"instContinueButtonTextTransparency" value:[NSString stringWithFormat:@"%d",instContinueButtonTransText]];
    
    [self saveSetting:@"fingerThreshold" value:[fingThreshold text]];
    
    [self saveSetting:@"min_threshold_text_index" value:[min_threshold_text_index text]];
    [self saveSetting:@"min_threshold_text_middle" value:[min_threshold_text_middle text]];
    [self saveSetting:@"min_threshold_text_ring" value:[min_threshold_text_ring text]];
    [self saveSetting:@"min_threshold_text_baby" value:[min_threshold_text_baby text]];
    
    [self saveSetting:@"max_threshold_text_index" value:[max_threshold_text_index text]];
    [self saveSetting:@"max_threshold_text_middle" value:[max_threshold_text_middle text]];
    [self saveSetting:@"max_threshold_text_ring" value:[max_threshold_text_ring text]];
    [self saveSetting:@"max_threshold_text_baby" value:[max_threshold_text_baby text]];
    
    [self saveSetting:@"zoom_level_text" value:[zoom_level_text text]];
    
    [self configBtnClickedMethod];
    [self snackBarView:[LabelUtils getLabelForKey:@"id_capture_save_msg"]];
}

-(void)resetButton:(UIButton*)button {
    [textColorTextField setText:dTextColor];
    [textColorTransTextField setText:[@(mAlpha) stringValue]];
    [instContinueButtonTextField setText:dInstContinueButtonColor];
    [instContinueButtonTransTextField setText:[@(mAlpha) stringValue]];
    [instContinueButtonTextColorField setText:dInstContinueButtonTextColor];
    [instContinueButtonTransTextColorField setText:[@(mAlpha) stringValue]];
    
    [fingThreshold setText:@"15"];
    [self saveSetting:@"fingerThreshold" value:[fingThreshold text]];
    
    
    [min_threshold_text_index setText:min_threshold_text_index_thresh];
    [max_threshold_text_index setText:max_threshold_text_index_thresh];
    [self saveSetting:@"min_threshold_text_index" value:[NSString stringWithFormat:@"%@", [min_threshold_text_index text]]];
    [self saveSetting:@"max_threshold_text_index" value:[NSString stringWithFormat:@"%@", [max_threshold_text_index text]]];
    
    [min_threshold_text_middle setText:min_threshold_text_middle_thresh];
    [max_threshold_text_middle setText:max_threshold_text_middle_thresh];
    [self saveSetting:@"min_threshold_text_middle" value:[NSString stringWithFormat:@"%@", [min_threshold_text_middle text]]];
    [self saveSetting:@"max_threshold_text_middle" value:[NSString stringWithFormat:@"%@", [max_threshold_text_middle text]]];
    
    [min_threshold_text_ring setText:min_threshold_text_ring_thresh];
    [max_threshold_text_ring setText:max_threshold_text_ring_thresh];
    [self saveSetting:@"min_threshold_text_ring" value:[NSString stringWithFormat:@"%@", [min_threshold_text_ring text]]];
    [self saveSetting:@"max_threshold_text_ring" value:[NSString stringWithFormat:@"%@", [max_threshold_text_ring text]]];
    
    [min_threshold_text_baby setText:min_threshold_text_baby_thresh];
    [max_threshold_text_baby setText:max_threshold_text_baby_thresh];
    [self saveSetting:@"min_threshold_text_baby" value:[NSString stringWithFormat:@"%@", [min_threshold_text_baby text]]];
    [self saveSetting:@"max_threshold_text_baby" value:[NSString stringWithFormat:@"%@", [max_threshold_text_baby text]]];
    
    
    [zoom_level_text setText:zoom_threshold_text_thresh];
    [self saveSetting:@"zoom_level_text" value:[NSString stringWithFormat:@"%@", [zoom_level_text text]]];
    
    [self saveSetting:@"textColor" value:[NSString stringWithFormat:@"%@", [textColorTextField text]]];
    [self saveSetting:@"instContinueButton" value:[NSString stringWithFormat:@"%@", [instContinueButtonTextField text]]];
    [self saveSetting:@"instContinueButtonText" value:[NSString stringWithFormat:@"%@", [instContinueButtonTextColorField text]]];
    [self saveSetting:@"textColorTransparency" value:[NSString stringWithFormat:@"%@",[textColorTransTextField text]]];
    [self saveSetting:@"instContinueButtonTransparency" value:[NSString stringWithFormat:@"%@",[instContinueButtonTransTextField text]]];
    [self saveSetting:@"instContinueButtonTextTransparency" value:[NSString stringWithFormat:@"%@",[instContinueButtonTransTextColorField text]]];
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
    [cameraClickBtn setImage:[UIImage imageNamed:@"Fingureprint_capture.png"] forState:UIControlStateNormal];
    [self.view addSubview:cameraClickBtn];
    
    UILabel *captureLabel = [[UILabel alloc] initWithFrame:CGRectMake(cameraClickBtn.frame.origin.x + cameraClickBtn.frame.size.width/2 - (width/100)*15, cameraClickBtn.frame.origin.y + cameraClickBtn.frame.size.height + (height/100)*2, (width/100)*30, (width/100)*5)];
    
   // [captureLabel setText:titlesArray[3]];
    [captureLabel setText:[LabelUtils getLabelForKey:@"capture"]];
    [captureLabel setTextAlignment:NSTextAlignmentCenter];
    [captureLabel setAlpha:0.5];
    [captureLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:captureLabel];
    
    fingerName = [[UILabel alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (backGroundWhiteView.frame.size.width/100)*50 - (width/100)*15, backGroundWhiteView.frame.origin.y, (width/100)*30, (height/100)*5)];
    [fingerName setTextAlignment:NSTextAlignmentCenter];
    [fingerName setAlpha:0.7];
    [fingerName setFont:[UIFont boldSystemFontOfSize:13]];
    [self.view addSubview:fingerName];
    
    resultImage = [[UIImageView alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x + (backGroundWhiteView.frame.size.width/100)*25, fingerName.frame.origin.y + fingerName.frame.size.height, (backGroundWhiteView.frame.size.width/100)*50, backGroundWhiteView.frame.size.height - fingerName.frame.size.height)];
    resultImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:resultImage];
    
    [resultImage setTag:-1];
    
    imageArray = [[NSMutableArray alloc] initWithCapacity:5];//It will expand automatically when needed
    imageNameArray = [[NSMutableArray alloc] initWithCapacity:5];//It will expand automatically when needed
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resultImageViewTapped:)];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [tapGestureRecognizer setNumberOfTouchesRequired:1];
    [resultImage addGestureRecognizer:tapGestureRecognizer];
    [resultImage setUserInteractionEnabled:YES];
    [resultImage setContentMode:UIViewContentModeScaleAspectFit];
    
    //Select Finger
    selectFingerTextField = [[UITextField alloc] initWithFrame:CGRectMake(backGroundWhiteView.frame.origin.x, backGroundWhiteView.frame.origin.y + backGroundWhiteView.frame.size.height + (height/100)*3, (backGroundWhiteView.frame.size.width/100)*48, (height/100)*6)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:selectFingerTextField];
//    [self.view addSubview:selectFingerTextField];
    
    //Down Arrow Image
    selectFingerDownArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(selectFingerTextField.frame.origin.x + selectFingerTextField.frame.size.width - (width/100)*9 , selectFingerTextField.frame.origin.y + (selectFingerTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [selectFingerDownArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
//    [self.view addSubview:selectFingerDownArrowImage];
    
    NSString *logincn = [LabelUtils getLabelForKey:@"select_finger"];
    loginSize = [NSStringUtilsDemo getUILabelSizeFromLabel:logincn size:14];
    loginIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectFingerTextField.frame.origin.x + 15, selectFingerTextField.frame.origin.y - (loginSize.height/2), loginSize.width, loginSize.height)];
    [loginIdLabel setText:logincn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:loginIdLabel];
//    [self.view addSubview:loginIdLabel];
    
    //Clear Button
    clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect clearBtnframe = CGRectMake(backGroundWhiteView.frame.origin.x + (backGroundWhiteView.frame.size.width/100)*52, selectFingerTextField.frame.origin.y , selectFingerTextField.frame.size.width, (height/100)*6);
    [clearBtn setFrame:clearBtnframe];
    clearBtn.layer.cornerRadius = 20;
    clearBtn.clipsToBounds = YES;
    [clearBtn setTitle:[LabelUtils getLabelForKey:@"clear"] forState:UIControlStateNormal];
    clearBtn.titleLabel.textColor = [UIColor whiteColor];
    [clearBtn addTarget:self action:@selector(clearBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:clearBtn];
//    [clearBtn setHidden:YES];
    [clearBtn setEnabled:false];
    [loginIdLabel setHidden:YES];
    [selectFingerDownArrowImage setHidden:YES];
    [selectFingerTextField setHidden:YES];
    
    // Recapture Button
    recaptureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    recapture_btn_full_width = backGroundWhiteView.frame.size.width;
    recapture_btn_half_width = selectFingerTextField.frame.size.width;
//    CGRect frame = CGRectMake(backGroundWhiteView.frame.origin.x, selectFingerTextField.frame.origin.y, selectFingerTextField.frame.size.width, (height/100)*6);
    CGRect frame = CGRectMake(backGroundWhiteView.frame.origin.x, selectFingerTextField.frame.origin.y, recapture_btn_full_width, (height/100)*6);
    [recaptureButton setFrame:frame];
    recaptureButton.layer.cornerRadius = 20;
    recaptureButton.clipsToBounds = YES;
    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"capture"] forState:UIControlStateNormal];
    recaptureButton.titleLabel.textColor = [UIColor whiteColor];
    [recaptureButton setBackgroundColor:[UIColor blackColor]];
    [recaptureButton addTarget:self action:@selector(captureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recaptureButton];
    
    //Back
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(recaptureButton.frame.origin.x, recaptureButton.frame.origin.y + recaptureButton.frame.size.height + (height/100)*2, selectFingerTextField.frame.size.width, (height/100)*6);
    [backBtn setFrame:saveAccountframe];
    backBtn.layer.cornerRadius = 20;
    backBtn.clipsToBounds = YES;
    [backBtn setTitle:[LabelUtils getLabelForKey:@"back_capture"] forState:UIControlStateNormal];
    backBtn.titleLabel.textColor = [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:backBtn];
    
    //Next
    nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    CGRect editAccountframe = CGRectMake(backBtn.frame.origin.x + backBtn.frame.size.width + (recaptureButton.frame.size.width/100)*5, backBtn.frame.origin.y , (recaptureButton.frame.size.width/100)*45, (width/100)*12);
    CGRect editAccountframe = CGRectMake(backGroundWhiteView.frame.origin.x + (backGroundWhiteView.frame.size.width/100)*52, backBtn.frame.origin.y , selectFingerTextField.frame.size.width, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:nextBtn];
    
}

-(void)clearResultImages{
    [imageArray removeAllObjects];
    [imageNameArray removeAllObjects];
    [fingerName setText:@""];
    [self refreshResultImageView];
}


-(void)refreshResultImageView {
    NSInteger tag = [resultImage tag];
    tag = tag+1;
    
    if([imageArray count] > 0){
        if(tag < [imageArray count]){
            [resultImage setTag:tag];
            [resultImage setImage:imageArray[tag]];
            [fingerName setText:imageNameArray[tag]];
        }else{
            [resultImage setTag:0];
            [resultImage setImage:imageArray[0]];
            //[resultImageLabel setText:imageNameArray[0]];
            [fingerName setText:imageNameArray[0]];
        }
    }else{
        [resultImage setImage:nil];
        fingerName.text = @"";
    }
}
- (void)viewOnTouch:(UITapGestureRecognizer *)recognizer
{
    [recognizer locationInView:[recognizer.view superview]];
    
    if(isCapture){
        int focus = 15;
        
        if(![NSStringUtilsDemo stringIsNilOrEmpty:fingThreshold.text]){
            focus = [fingThreshold.text intValue];
        }
        
        NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
        NSString *fontStyle= [fontStyleTextField text];
        NSString *textColor= [textColorTextField text];
        NSString *textColorTrans= [textColorTransTextField text];
        NSString *instContinueButton= [instContinueButtonTextField text];
        NSString *instContinueButtonTrans= [instContinueButtonTransTextField text];
        NSString *instContinueButtonTextColor= [instContinueButtonTextColorField text];
        NSString *instContinueButtonTransTextColor= [instContinueButtonTransTextColorField text];
        NSString *showInsScreen = (showInstScreen) ? @"true" : @"false";
        
        if(![NSStringUtilsDemo stringIsNilOrEmpty:showInsScreen]){
            [nsDict setObject:showInsScreen forKey:@"cfc_show_instruction_screen"];
        }
//        if(![NSStringUtilsDemo stringIsNilOrEmpty:textColor]){
//            [nsDict setObject:textColor forKey:@"textColor"];
//        }
//        if(![NSStringUtilsDemo stringIsNilOrEmpty:textColorTrans]){
//            [nsDict setObject:textColorTrans forKey:@"textColorTrans"];
//        }
//        if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButtonTrans]){
//            [nsDict setObject:instContinueButtonTrans forKey:@"instructionButtonColorAlpha"];
//        }
//        if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButton]){
//            [nsDict setObject:instContinueButton forKey:@"instructionButtonColor"];
//        }
//        if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButtonTextColor]){
//            [nsDict setObject:instContinueButtonTextColor forKey:@"instructionButtonTXTColor"];
//        }
//        if(![NSStringUtilsDemo stringIsNilOrEmpty:instContinueButtonTransTextColor]){
//            [nsDict setObject:instContinueButtonTransTextColor forKey:@"instructionButtonTXTColorAlpha"];
//        }
        
       // [AppItSDK captureFourFingerprint:[ArrayObjectController getPageDelegate] focusThreshold:focus];
//          [AppItSDK captureFourFingerprint:[ArrayObjectController getPageDelegate] focusThreshold:focus uiConfigDict:nsDict];
        [AppItSDK captureFourFingerprint:[ArrayObjectController getPageDelegate] cameraFingerCaptureConfig:nsDict];
    }
}

-(void)captureBtn:(UIButton*)button {
    [self checkCameraPermission];
}

-(void)fingerPrintCaptureAPICall{
    
    NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
    
    NSString *showInsScreen = (showInstScreen) ? @"Y" : @"N";
    if(![NSStringUtilsDemo stringIsNilOrEmpty:showInsScreen]){
        [nsDict setObject:showInsScreen forKey:@"cfc_show_instruction_screen"];
    }

    NSString *minI = [self retrieveSetting:@"min_threshold_text_index" defaultValue:min_threshold_text_index_thresh];
    NSString *minM = [self retrieveSetting:@"min_threshold_text_middle" defaultValue:min_threshold_text_middle_thresh];
    NSString *minR = [self retrieveSetting:@"min_threshold_text_ring" defaultValue:min_threshold_text_ring_thresh];
    NSString *minB = [self retrieveSetting:@"min_threshold_text_baby" defaultValue:min_threshold_text_baby_thresh];
    
    NSString *maxI = [self retrieveSetting:@"max_threshold_text_index" defaultValue:max_threshold_text_index_thresh];
    NSString *maxM = [self retrieveSetting:@"max_threshold_text_middle" defaultValue:max_threshold_text_middle_thresh];
    NSString *maxR = [self retrieveSetting:@"max_threshold_text_ring" defaultValue:max_threshold_text_ring_thresh];
    NSString *maxB = [self retrieveSetting:@"max_threshold_text_baby" defaultValue:max_threshold_text_baby_thresh];
    
    NSString *zoom = [self retrieveSetting:@"zoom_level_text" defaultValue:zoom_threshold_text_thresh];
    
    NSString *keepI = [self getNSStringFromTag:(int)[keep_index_finger_button tag]];
    NSString *keepM = [self getNSStringFromTag:(int)[keep_middle_finger_button tag]];
    NSString *keepR = [self getNSStringFromTag:(int)[keep_ring_finger_button tag]];
    NSString *keepB = [self getNSStringFromTag:(int)[keep_baby_finger_button tag]];
    
    NSString *process4K = [self getNSStringFromTag:(int)[process_4k_frames_button tag]];
    
    [nsDict setObject:minI forKey:@"cfc_indexfinger_min_threshold"];
    [nsDict setObject:minM forKey:@"cfc_middlefinger_min_threshold"];
    [nsDict setObject:minR forKey:@"cfc_ringfinger_min_threshold"];
    [nsDict setObject:minB forKey:@"cfc_babyfinger_min_threshold"];
    
    [nsDict setObject:maxI forKey:@"cfc_indexfinger_threshold"];
    [nsDict setObject:maxM forKey:@"cfc_middlefinger_threshold"];
    [nsDict setObject:maxR forKey:@"cfc_ringfinger_threshold"];
    [nsDict setObject:maxB forKey:@"cfc_babyfinger_threshold"];
    
    [nsDict setObject:keepI forKey:@"cfc_keep_index_finger"];
    [nsDict setObject:keepM forKey:@"cfc_keep_middle_finger"];
    [nsDict setObject:keepR forKey:@"cfc_keep_ring_finger"];
    [nsDict setObject:keepB forKey:@"cfc_keep_baby_finger"];
    
    [nsDict setObject:zoom forKey:@"cfc_zoom_camera"];
    [nsDict setObject:process4K forKey:@"cfc_process_4k_image"];

    
    [AppItSDK captureFourFingerprint:[ArrayObjectController getPageDelegate] cameraFingerCaptureConfig:nsDict];
}

//Run time Permission Asking
-(void) checkCameraPermission {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(status == AVAuthorizationStatusAuthorized) { // authorized
        NSLog(@"camera authorized");
        [self fingerPrintCaptureAPICall];
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
                        [self fingerPrintCaptureAPICall];
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
                    [self fingerPrintCaptureAPICall];
                });
            }
        }];
    }
}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
   // RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    //[controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
    int service_id = [ArrayObjectController getServiceId];
    
    if(service_id == 185 || service_id == 190) {
        FinalStepController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FinalStepController"];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        RootPageViewController *controller = [ArrayObjectController getPageDelegate];
        [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
    }
}

-(void)clearBtnClicked:(UIButton*)button {
    
    NSInteger currentlyDisplayedFingerIndex = [resultImage tag];
    if(currentlyDisplayedFingerIndex != -1){
        NSString *currentlyDisplayedFingerName = imageNameArray[currentlyDisplayedFingerIndex];
        [self remove_finger_image_in_result:currentlyDisplayedFingerName];
        [AppItSDK clearSelectedFingerPrint:self selectedFinger:currentlyDisplayedFingerName];
        [self refreshResultImageView];
        
        if([imageNameArray count] == 0) {
            [self hideSelectFingerPrintFields];
            [recaptureButton setTitle:[LabelUtils getLabelForKey:@"capture"] forState:UIControlStateNormal];
        }
        [self snackBarView:[LabelUtils getLabelForKey:@"clear_fp_data"]];
    }
    
//    if([@"ALL" isEqualToString:[selectFingerTextField text]]) {
//        [self remove_finger_image_in_result:@"LIFINGER"];
//        [self remove_finger_image_in_result:@"LMFINGER"];
//        [self remove_finger_image_in_result:@"LRFINGER"];
//        [self remove_finger_image_in_result:@"LLFINGER"];
//        [self remove_finger_image_in_result:@"RIFINGER"];
//        [self remove_finger_image_in_result:@"RMFINGER"];
//        [self remove_finger_image_in_result:@"RRFINGER"];
//        [self remove_finger_image_in_result:@"RLFINGER"];
//        [self refreshResultImageView];
//       // [fingerName setHidden:true];
//        fingerName.text = @"";
//
//        [AppItSDK clearAllFingerprints:self];
//    } else {
//        if([imageNameArray containsObject:[selectFingerTextField text]]) {
//            [self remove_finger_image_in_result:[selectFingerTextField text]];
//            [self refreshResultImageView];
//            [AppItSDK clearSelectedFingerPrint:self selectedFinger:[selectFingerTextField text]];
//        }
//    }
//    if([imageNameArray count] == 0) {
//        [self hideSelectFingerPrintFields];
//        [recaptureButton setTitle:[LabelUtils getLabelForKey:@"capture"] forState:UIControlStateNormal];
//    }
//    [self snackBarView:[LabelUtils getLabelForKey:@"clear_fp_data"]];
}

-(void) hideSelectFingerPrintFields {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
//    [clearBtn setHidden:YES];
    [clearBtn setEnabled:false];
    [loginIdLabel setHidden:YES];
    [selectFingerDownArrowImage setHidden:YES];
    [selectFingerTextField setHidden:YES];
        
    [recaptureButton setFrame:CGRectMake(recaptureButton.frame.origin.x, recaptureButton.frame.origin.y, recapture_btn_full_width, recaptureButton.frame.size.height)];
    
//    [recaptureButton setFrame:CGRectMake(recaptureButton.frame.origin.x, recaptureButton.frame.origin.y - (selectFingerTextField.frame.size.height) - (height/100)*2, recaptureButton.frame.size.width, recaptureButton.frame.size.height)];
//
//    [nextBtn setFrame:CGRectMake(nextBtn.frame.origin.x, nextBtn.frame.origin.y - (selectFingerTextField.frame.size.height) - (height/100)*2, nextBtn.frame.size.width, nextBtn.frame.size.height)];
//
//    [backBtn setFrame:CGRectMake(backBtn.frame.origin.x, backBtn.frame.origin.y - (selectFingerTextField.frame.size.height) - (height/100)*2, backBtn.frame.size.width, backBtn.frame.size.height)];
    
}

-(void) showSelectFingerPrintFields {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
//    [clearBtn setHidden:YES];
    [clearBtn setEnabled:false];
    [loginIdLabel setHidden:YES];
    [selectFingerDownArrowImage setHidden:YES];
    [selectFingerTextField setHidden:YES];
    
    [recaptureButton setFrame:CGRectMake(recaptureButton.frame.origin.x, recaptureButton.frame.origin.y, recapture_btn_full_width, recaptureButton.frame.size.height)];
    
//    [recaptureButton setFrame:CGRectMake(recaptureButton.frame.origin.x, recaptureButton.frame.origin.y + (selectFingerTextField.frame.size.height) + (height/100)*2, recaptureButton.frame.size.width, recaptureButton.frame.size.height)];
//
//    [nextBtn setFrame:CGRectMake(nextBtn.frame.origin.x, nextBtn.frame.origin.y + (selectFingerTextField.frame.size.height) + (height/100)*2, nextBtn.frame.size.width, nextBtn.frame.size.height)];
//
//    [backBtn setFrame:CGRectMake(backBtn.frame.origin.x, backBtn.frame.origin.y + (selectFingerTextField.frame.size.height) + (height/100)*2, backBtn.frame.size.width, backBtn.frame.size.height)];
    
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

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

-(void)fourFingerResponse:(NSMutableDictionary *)result {
    
    if([selectFingerTextField isHidden]) {
        NSString *status = [result objectForKey:@"StatusCode"];
        if([status isEqual:@"0"]){
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat height = [UIScreen mainScreen].bounds.size.height;
            //        [clearBtn setHidden:NO];
            [clearBtn setEnabled:true];
            [loginIdLabel setHidden:NO];
            [selectFingerDownArrowImage setHidden:NO];
            [selectFingerTextField setHidden:NO];
            
            [recaptureButton setFrame:CGRectMake(recaptureButton.frame.origin.x, recaptureButton.frame.origin.y, recapture_btn_half_width, recaptureButton.frame.size.height)];
            
            //        [recaptureButton setFrame:CGRectMake(recaptureButton.frame.origin.x, recaptureButton.frame.origin.y + (selectFingerTextField.frame.size.height) + (height/100)*2, recaptureButton.frame.size.width, recaptureButton.frame.size.height)];
            //
            //        [nextBtn setFrame:CGRectMake(nextBtn.frame.origin.x, nextBtn.frame.origin.y + (selectFingerTextField.frame.size.height) + (height/100)*2, nextBtn.frame.size.width, nextBtn.frame.size.height)];
            //
            //        [backBtn setFrame:CGRectMake(backBtn.frame.origin.x, backBtn.frame.origin.y + (selectFingerTextField.frame.size.height) + (height/100)*2, backBtn.frame.size.width, backBtn.frame.size.height)];
        }
    }
    
   // [self clearResultImages];
    [recaptureButton setTitle:[LabelUtils getLabelForKey:@"re_capture"] forState:UIControlStateNormal];
    
    NSString *LIFINGER = [result objectForKey:@"LIFINGER"];
    NSString *LMFINGER = [result objectForKey:@"LMFINGER"];
    NSString *LRFINGER = [result objectForKey:@"LRFINGER"];
    NSString *LLFINGER = [result objectForKey:@"LLFINGER"];
    NSString *RIFINGER = [result objectForKey:@"RIFINGER"];
    NSString *RMFINGER = [result objectForKey:@"RMFINGER"];
    NSString *RRFINGER = [result objectForKey:@"RRFINGER"];
    NSString *RLFINGER = [result objectForKey:@"RLFINGER"];
    
    [self add_finger_image_in_result:@"LIFINGER" fingerValue:LIFINGER];
    [self add_finger_image_in_result:@"LMFINGER" fingerValue:LMFINGER];
    [self add_finger_image_in_result:@"LRFINGER" fingerValue:LRFINGER];
    [self add_finger_image_in_result:@"LLFINGER" fingerValue:LLFINGER];
    [self add_finger_image_in_result:@"RIFINGER" fingerValue:RIFINGER];
    [self add_finger_image_in_result:@"RMFINGER" fingerValue:RMFINGER];
    [self add_finger_image_in_result:@"RRFINGER" fingerValue:RRFINGER];
    [self add_finger_image_in_result:@"RLFINGER" fingerValue:RLFINGER];
    
    [self refreshResultImageView];
    isCapture=false;
    
}

-(void)add_finger_image_in_result:(NSString*)fingerName fingerValue:(NSString*)fingerValue{
    if(nil != fingerValue){
        NSData* data = [[NSData alloc] initWithBase64EncodedString:fingerValue options:0];
        UIImage* image = [UIImage imageWithData:data];
        
        if([imageNameArray containsObject:fingerName]){
            NSInteger index = [imageNameArray indexOfObject:fingerName];
            [imageArray replaceObjectAtIndex:index withObject:image];
        }else{
            [imageNameArray addObject:fingerName];
            [imageArray addObject:image];
        }
    }
}

- (void)resultImageViewTapped:(UIGestureRecognizer *)gestureRecognizer {
    [self refreshResultImageView];
}

-(void) remove_finger_image_in_result:(NSString*)value {
    NSInteger index = [imageNameArray indexOfObject:value];
    if(NSNotFound == index) {
    } else {
        [imageArray removeObjectAtIndex:index];
        [imageNameArray removeObjectAtIndex:index];
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

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end

