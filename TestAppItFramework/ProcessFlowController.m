
//
//  ProcessFlowController.m
//  SDKNewDesign
//
//  Created by  on 30/09/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import "ProcessFlowController.h"
#import "ArrayObjectController.h"
#import "SidePanelController.h"
#import "AccountSetUpViewController.h"
#import "IdFaceDetailsViewController.h"
#import "AppDelegate.h"
#import "RootPageViewController.h"
#import "NSStringUtilsDemo.h"
#import "LabelUtils.h"
#import "CustomizeUIConfigurationController.h"

@interface ProcessFlowController ()

@end

@implementation ProcessFlowController {
    UIScrollView *scrollView;
    UIButton *toggleAddFeatButton;
    UIButton *toggleButton;
    bool isDebugToggleOn;
    int counter;
    NSArray *fieldArray;
    NSMutableDictionary *pageControlArray;
    UITextField *selectServiceTextField;
    NSArray *_selectedPickerData;
    NSArray *langFieldPickerData;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    UILabel *idvalidationLabel;
    bool isFirstTime;
    NSArray *_selectedValidationLabel;
    UILabel *showMSGLabel;
    NSTimer *fiveSecondTimer;
    bool isSnackBarVisible;
    UIButton *continueProcessBtn,*initializeSDKBtn;
    UIButton *videoRecCheckBox, *videoFunctionButton, *videoHelpButton,
             *fingerPrintCapCheckBox, *fingerPrintCapFunctionButton, *fingerPrintHelpButton,
            *voiceCapCheckBox, *voiceCapFunctionButton, *voiceHelpButton,
            *videoConfCapCheckBox, *videoConfFunctionButton, *videoConfHelpButton, *secIdCapCheckBox, *secIdCapFunctionButton, *secIdCapHelpButton;
}

-(void)viewWillAppear:(BOOL)animated {
      [self navigationCode];
}

-(void)viewDidAppear:(BOOL)animated {
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    isSnackBarVisible = false;
    if(isFirstTime) {
        isFirstTime = false;
        [self initUI];
        
        //Picker Set Up
        myPickerView = [[UIPickerView alloc] init];
        myPickerView.delegate = self;
        myPickerView.dataSource = self;
        
        //get keys
        NSArray *keys = [[ArrayObjectController getServiceDetails] allKeys];

        //sorted keys number
        NSMutableArray *sortKey = [[NSMutableArray alloc]init];

        for(NSString *service in keys){
            NSString *serviceID= [service substringWithRange:NSMakeRange(0, 3)];
            NSString *trimmedServiceID = [serviceID stringByTrimmingCharactersInSet:
                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSInteger *serviceIdNumber=[trimmedServiceID integerValue];
            [sortKey addObject:[NSNumber numberWithInt:serviceIdNumber]];
        }
        
        //sorted keys
        NSArray *sortedArray = [sortKey sortedArrayUsingComparator:
                                ^NSComparisonResult(id obj1, id obj2){
                                    return [obj1 compare:obj2];
                                }];
        NSMutableArray *sortedKey = [[NSMutableArray alloc]init];
        NSMutableArray *sortedValues = [[NSMutableArray alloc]init];
        for(NSNumber *sorted_key in sortedArray){
            for(NSString *unsorted_key in keys){
                NSString *serviceID= [unsorted_key substringWithRange:NSMakeRange(0, 3)];
                NSString *trimmedServiceID = [serviceID stringByTrimmingCharactersInSet:
                                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                 NSInteger serviceIdNumber=[trimmedServiceID integerValue];
                if(sorted_key.integerValue== serviceIdNumber){
                    [sortedKey addObject:unsorted_key];
                    [sortedValues addObject:[[ArrayObjectController getServiceDetails] objectForKey:unsorted_key]];
                }
            }
        }
        
        _selectedPickerData=sortedKey;
        langFieldPickerData=sortedKey;
        _selectedValidationLabel=sortedValues;
        
//        _selectedValidationLabel = @[@"ID Validation and Face Match without customer enrollment: Service ID 10",@"ID Validation and Face Match with customer enrollment: Service ID 50",@"Face Match with customer enrollment: Service ID 60",@"Face Match without customer enrollment: Service ID 65",@"Customer Update: Service ID 70",@"Customer Verification: Service ID 100",@"Address Matching: Service ID 200",@"Employee Verification: Service ID 300",@"Face Match with employee enrollment: Service ID 310",@"OTP Generation: Service ID 400",@"OTP Verification: Service ID 410"];
        
//        _selectedValidationLabel = @[@"ID Validation Only: Service ID 20",@"ID Validation ONLY with Customer Enrollment: Service ID 25",@"ID Validation ONLY with Employee Enrollment: Service ID 30",@"ID Validation and Face Match without customer enrollment: Service ID 10",@"ID Validation and Face Match with customer enrollment: Service ID 50",@"ID Validation and Face Match with employee enrollment: Service ID 55",@"ID Validation and Face Match with Video Recording: Service ID 155",@"ID Validation and Face Match with Video Recording and Customer Enrollment: Service ID 160",@"ID Validation and Face Match with Video Recording and Employee Enrollment: Service ID 165",@"Face Match with customer enrollment: Service ID 60",@"Face Match without customer enrollment: Service ID 65",@"Customer Update: Service ID 70",@"Customer Verification: Service ID 100",@"Address Matching: Service ID 200",@"Employee Verification: Service ID 300",@"Face Match with employee enrollment: Service ID 310",@"Create Customer: Service ID 320",@"Create Employee(Override): Service ID 330",@"Customer Enrollment with FP Biometrics: Service ID:175",@"Employee Enrollment with FP Biometrics: Service ID:180",@"Generate Token: Service ID 401",@"OTP Generation: Service ID 400",@"OTP Verification: Service ID 410",@"Id Validation & Face Match(Primary ID) 360",@"Face Match Between Secondary ID and Selfie 361"];
        
//        _selectedValidationLabel = @[@"ID Validation and Facial Biometric Matching: Service ID 10",@"ID Validation Only: Service ID 20",@"ID Validation Only w/Customer Enrollment: Service ID 25",@"ID Validation Only w/Employee Enrollment: Service ID 30",@"ID Validation and Facial Biometric Matching w/Customer Enrollment: Service ID 50",@"ID Validation and Facial Biometric Matching w/Employee Enrollment: Service ID 55",@"Facial Biometric Matching Only w/Customer Enrollment: Service ID 60",@"Facial Biometric Matching Only: Service ID 65",@"Customer Update: Service ID 70",@"Employee Update: Service ID 75",@"Customer Biometric Verification: Service ID 100",@"ID Validation and Facial Biometric Matching with Video Recording instead of Photo/Live Face Detection: Service ID 155",@"ID Validation and Facial Biometric Matching with Video Recording instead of Photo/Live Face Detection w/Customer Enrollment: Service ID 160",@"ID Validation and Facial Biometric Matching with Video Recording instead of Photo/Live Face Detection w/Employee Enrollment: Service ID 165",@"Customer Enrollment with FP Biometrics: Service ID 175",@"Employee Enrollment with FP Biometrics: Service ID 180",@"Address Matching / Verification: Service ID 200",@"Employee Biometric Verification: Service ID 300",@"Facial Biometric Matching Only w/Employee Enrollment: Service ID 310",@"Create Customer using override feature: Service ID 320",@"Create Employee using override feature: Service ID 330",@"Id Validation & Face Match(Primary ID) 360",@"Face Match Between Secondary ID and Selfie 361",@"One Time PIN Generation: Service ID 400",@"Token Number Generation: Service ID 401",@"One Time PIN Verification: Service ID 410"];
//
//        langFieldPickerData = @[@"10 IDV+Face Match",@"20 IDV Only",@"25 IDV Only w/Cust Enroll",@"30 IDV Only w/Emp Enroll",@"50 IDV+Face Match w/Cust Enroll",@"55 IDV+Face Match w/Emp Enroll",@"60 Face Match Only w/Cust Enroll",@"65 Face Match Only",@"70 Customer Update",@"75 Employee Update",@"100 Customer Verification",@"155 IDV+Video Match",@"160 IDV+Video Match w/Cust Enroll",@"165 IDV+Video Match w/Emp Enroll",@"175 Cust Enroll w/FP",@"180 Emp Enroll w/FP",@"200 Address Processing",@"300 Employee Verification",@"310 Face Match Only w/Emp Enroll",@"320 Create Customer(Override)",@"330 Create Employee(Override)",@"360 Id Validation & Face Match(Primary ID)",@"361 Id Validation & Face Match(Secondary ID)",@"400 OTP Generation",@"401 Token Generation",@"410 OTP Verification"];
////        _selectedPickerData = @[@"ID Validation", @"Face Match", @"ID Validation and Face Match"];
//        
//        _selectedPickerData =  @[@"10 IDV+Face Match",@"20 IDV Only",@"25 IDV Only w/Cust Enroll",@"30 IDV Only w/Emp Enroll",@"50 IDV+Face Match w/Cust Enroll",@"55 IDV+Face Match w/Emp Enroll",@"60 Face Match Only w/Cust Enroll",@"65 Face Match Only",@"70 Customer Update",@"75 Employee Update",@"100 Customer Verification",@"155 IDV+Video Match",@"160 IDV+Video Match w/Cust Enroll",@"165 IDV+Video Match w/Emp Enroll",@"175 Cust Enroll w/FP",@"180 Emp Enroll w/FP",@"200 Address Processing",@"300 Employee Verification",@"310 Face Match Only w/Emp Enroll",@"320 Create Customer(Override)",@"330 Create Employee(Override)",@"360 Id Validation & Face Match(Primary ID)",@"361 Id Validation & Face Match(Secondary ID)",@"400 OTP Generation",@"401 Token Generation",@"410 OTP Verification"];
//
        [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
        //myPickerView.layer.borderWidth = 1.0;
        //myPickerView.layer.cornerRadius = 5.0;
        myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        //Adding Toolbar with 'Done' button on picker view
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerDoneClicked)];
        
        toolbarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
        NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
        [toolbarForPicker setItems:toolbarItems];
        
        [selectServiceTextField setInputView:myPickerView];
        [selectServiceTextField setInputAccessoryView:toolbarForPicker];
        [selectServiceTextField setText:langFieldPickerData[0]];
        [idvalidationLabel setText:_selectedValidationLabel[0]];
    }
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [selectServiceTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == selectServiceTextField){
        _selectedPickerData = langFieldPickerData;
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
    //Clearing Values
    [AppItSDK setCallExecutionParameter: [ArrayObjectController clearCallExecutionParameter]];

    if([_selectedPickerData isEqualToArray:langFieldPickerData]){
        [selectServiceTextField setText:langFieldPickerData[row]];
        [idvalidationLabel setText:_selectedValidationLabel[row]];
        [selectServiceTextField setTag:row+1];
        
        NSString *serviceID = [[[selectServiceTextField text] substringToIndex:3]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if([@"155" isEqualToString:serviceID] || [@"160" isEqualToString:serviceID] || [@"165" isEqualToString:serviceID]) {
            [videoRecCheckBox setAlpha:0.3];
            [videoHelpButton setAlpha:0.3];
            [videoFunctionButton setAlpha:0.3];
            [videoRecCheckBox setUserInteractionEnabled:NO];
            [videoHelpButton setUserInteractionEnabled:NO];
        } else {
            [videoRecCheckBox setAlpha:1];
            [videoHelpButton setAlpha:1];
            [videoFunctionButton setAlpha:1];
            [videoRecCheckBox setUserInteractionEnabled:YES];
            [videoHelpButton setUserInteractionEnabled:YES];
        }
        if([@"175" isEqualToString:serviceID] || [@"180" isEqualToString:serviceID] || [@"105" isEqualToString:serviceID] || [@"305" isEqualToString:serviceID] || [@"185" isEqualToString:serviceID] || [@"190" isEqualToString:serviceID]) {
            
            [fingerPrintCapCheckBox setAlpha:0.3];
            [fingerPrintHelpButton setAlpha:0.3];
            [fingerPrintCapFunctionButton setAlpha:0.3];
            [fingerPrintCapCheckBox setUserInteractionEnabled:NO];
            [fingerPrintHelpButton setUserInteractionEnabled:NO];
            
            [voiceCapCheckBox setAlpha:0.3];
            [voiceHelpButton setAlpha:0.3];
            [voiceCapFunctionButton setAlpha:0.3];
            [voiceCapCheckBox setUserInteractionEnabled:NO];
            [voiceHelpButton setUserInteractionEnabled:NO];
        } else {
            [fingerPrintCapCheckBox setAlpha:1];
            [fingerPrintHelpButton setAlpha:1];
            [fingerPrintCapFunctionButton setAlpha:1];
            [fingerPrintCapCheckBox setUserInteractionEnabled:YES];
            [fingerPrintHelpButton setUserInteractionEnabled:YES];
            
            [voiceCapCheckBox setAlpha:1];
            [voiceHelpButton setAlpha:1];
            [voiceCapFunctionButton setAlpha:1];
            [voiceCapCheckBox setUserInteractionEnabled:YES];
            [voiceHelpButton setUserInteractionEnabled:YES];
        }
        
        if([@"500" isEqualToString:serviceID]
           || [@"505" isEqualToString:serviceID]
           || [@"510" isEqualToString:serviceID]
           || [@"515" isEqualToString:serviceID]) {
            [videoConfCapCheckBox setAlpha:0.3];
            [videoConfHelpButton setAlpha:0.3];
            [videoConfFunctionButton setAlpha:0.3];
            [videoConfCapCheckBox setUserInteractionEnabled:NO];
            [videoConfHelpButton setUserInteractionEnabled:NO];
        }else{
            [videoConfCapCheckBox setAlpha:1];
            [videoConfHelpButton setAlpha:1];
            [videoConfFunctionButton setAlpha:1];
            [videoConfCapCheckBox setUserInteractionEnabled:YES];
            [videoConfHelpButton setUserInteractionEnabled:YES];
        }
        
        if([@"175" isEqualToString:serviceID] || [@"70" isEqualToString:serviceID] || [@"105" isEqualToString:serviceID] || [@"305" isEqualToString:serviceID] || [@"75" isEqualToString:serviceID] || [@"180" isEqualToString:serviceID] || [@"185" isEqualToString:serviceID] || [@"190" isEqualToString:serviceID]) {
            
            if([[secIdCapCheckBox currentTitle] isEqual:@"Check"]) {
                [secIdCapCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
                [secIdCapCheckBox setTitle:@"UnCheck" forState:UIControlStateNormal];
                
                //12 key is for SecondaryIdCapture
                if([pageControlArray objectForKey:@"12"]) {
                    [pageControlArray removeObjectForKey:@"12"];
                }
            }
            
            [secIdCapCheckBox setAlpha:0.3];
            [secIdCapHelpButton setAlpha:0.3];
            [secIdCapFunctionButton setAlpha:0.3];
            [secIdCapCheckBox setUserInteractionEnabled:NO];
            [secIdCapHelpButton setUserInteractionEnabled:NO];
        } else {
            [secIdCapCheckBox setAlpha:1];
            [secIdCapHelpButton setAlpha:1];
            [secIdCapFunctionButton setAlpha:1];
            [secIdCapCheckBox setUserInteractionEnabled:YES];
            [secIdCapHelpButton setUserInteractionEnabled:YES];
        }
        
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    label.text = [NSString stringWithFormat:@"%@", [_selectedPickerData objectAtIndex:row]];
    label.textAlignment = NSTextAlignmentCenter; //Changed to NS as UI is deprecated.
    label.backgroundColor = [UIColor clearColor];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    [label setNumberOfLines:2];
    return label;
}

//Picker Changes End

-(void)navigationCode {
    
    int height = self.view.frame.size.height;
    int width = self.view.frame.size.width;
    self.navigationController.navigationBar.clipsToBounds = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UINavigationItem* navItem = [[UINavigationItem alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    self.navigationItem.titleView = label;
    label.text = [LabelUtils getLabelForKey:@"process_flow"];
    [label sizeToFit];
    
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,(width/100)*8,(width/100)*8);
    [button1 setBackgroundImage:[UIImage imageNamed: @"navdrawer.png"]
                       forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(navigationDrawerBtn:)
      forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithCustomView:button1];
    UIImage *dataImage = [UIImage imageNamed:@"navdrawer.png"];
    [cancelBtn setBackgroundImage:dataImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = cancelBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isFirstTime = true;
    counter = 0;
    pageControlArray = [[NSMutableDictionary alloc] init];
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
//    [self initUI];
}

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

- (void)initUI {
    int height = self.view.frame.size.height;
    int width = self.view.frame.size.width;
    isDebugToggleOn = true;
    UIView *backgroundColorView = [[UIView alloc]init];
    [backgroundColorView setBackgroundColor:[self colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [self.view addSubview:backgroundColorView];
    
    selectServiceTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, (height/100)*3 , width - (width/100)*14, (width/100)*15)];
    selectServiceTextField.textAlignment = UITextAlignmentCenter;
    selectServiceTextField.layer.cornerRadius = 5;
    selectServiceTextField.layer.borderWidth = 1.0;
    selectServiceTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.view addSubview:selectServiceTextField];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(selectServiceTextField.frame.origin.x + selectServiceTextField.frame.size.width - (width/100)*9 , selectServiceTextField.frame.origin.y + (selectServiceTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [self.view addSubview:downArrowImage];
    
    //To avoid Overlapping of Text on downArowImage
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (width/100)*9, (height/100)*4)];
    selectServiceTextField.rightView = paddingView;
    selectServiceTextField.rightViewMode = UITextFieldViewModeAlways;

    NSString *selectServicecn = [LabelUtils getLabelForKey:@"select_service"];
    CGSize selectServiceSize = [NSStringUtilsDemo getUILabelSizeFromLabel:selectServicecn size:14];
    UILabel *urlLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectServiceTextField.frame.origin.x + 15, selectServiceTextField.frame.origin.y - (selectServiceSize.height/2), selectServiceSize.width, selectServiceSize.height)];
    [urlLabel setText:selectServicecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:urlLabel];
    [urlLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:urlLabel];
    
    //IDvalidation Label
    idvalidationLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectServiceTextField.frame.origin.x, selectServiceTextField.frame.origin.y + selectServiceTextField.frame.size.height + (height/100)*0.5, selectServiceTextField.frame.size.width, (height/100)*13)];
    [idvalidationLabel setFont:[UIFont systemFontOfSize:12]];
    idvalidationLabel.numberOfLines = 0;
    idvalidationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:idvalidationLabel];
    
//    //Debug Mode Label
//    int debugModeWidth = (selectServiceTextField.frame.size.width/100)*63;
//    int debugModeHeight= (width/100)*10;
//    UILabel *debugMode = [[UILabel alloc] initWithFrame:CGRectMake(selectServiceTextField.frame.origin.x, idvalidationLabel.frame.origin.y +idvalidationLabel.frame.size.height + (height/100)*2, debugModeWidth, debugModeHeight)];
//    [debugMode setTextAlignment:UITextAlignmentLeft];
//    [debugMode setText:@"Debug Mode"];
//    [debugMode setFont:[UIFont systemFontOfSize:14]];
//    [self.view addSubview:debugMode];
//
//    //On Label
//    int onLabelWidth = (selectServiceTextField.frame.size.width/100)*10;
//    int onLabelHeight = (width/100)*10;
//    UILabel *onLabel = [[UILabel alloc] initWithFrame:CGRectMake(debugMode.frame.origin.x + debugMode.frame.size.width + (selectServiceTextField.frame.size.width/100)*1, debugMode.frame.origin.y, onLabelWidth, onLabelHeight)];
//    [onLabel setTextAlignment:NSTextAlignmentRight];
//    [onLabel setText:@"Off"];
//    [onLabel setFont:[UIFont systemFontOfSize:14]];
//    [self.view addSubview:onLabel];
//
//    //Toggle Button
//    //    int toggleBtnX = onLabel.frame.origin.x + onLabel.frame.size.width + (selectServiceTextField.frame.size.width/100)*1;
//    int toggleBtnX = onLabel.frame.origin.x + onLabel.frame.size.width + (width/100)*5;
//    int toggleBtnY = debugMode.frame.origin.y;
//    int toggleBtnWidth = (selectServiceTextField.frame.size.width/100)*10;
//    int toggleBtnHeight = (width/100)*10;
//    toggleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [toggleButton setFrame:CGRectMake(toggleBtnX, toggleBtnY, toggleBtnWidth, toggleBtnHeight)];
//    [toggleButton addTarget:self action:@selector(debugToggleBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [toggleButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
//    toggleButton.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:toggleButton];
//
//    //Off Label
//    int offLabelWidth = (selectServiceTextField.frame.size.width/100)*10;
//    int offLabelHeight = (width/100)*10;
//    UILabel *offLabel = [[UILabel alloc] initWithFrame:CGRectMake(toggleButton.frame.origin.x + toggleButton.frame.size.width + (width/100)*5, debugMode.frame.origin.y, offLabelWidth, offLabelHeight)];
//    [offLabel setTextAlignment:NSTextAlignmentLeft];
//    [offLabel setText:@"On"];
//    [offLabel setFont:[UIFont systemFontOfSize:14]];
//    [self.view addSubview:offLabel];
    
    //Need Additional Feature
    int additionalLabelWidth = (selectServiceTextField.frame.size.width/100)*63;
    int additionalLabelHeight= (width/100)*10;
    UILabel *additionalLabel = [[UILabel alloc] initWithFrame:CGRectMake(selectServiceTextField.frame.origin.x, idvalidationLabel.frame.origin.y +idvalidationLabel.frame.size.height + (height/100)*2, additionalLabelWidth, additionalLabelHeight)];
    [additionalLabel setTextAlignment:UITextAlignmentLeft];
    [additionalLabel setText:[LabelUtils getLabelForKey:@"need_additional_features"]];
    [additionalLabel setFont:[UIFont systemFontOfSize:14]];
    additionalLabel.lineBreakMode = UILineBreakModeWordWrap;
    additionalLabel.numberOfLines = 2;
    [self.view addSubview:additionalLabel];
    
    //On Label
    int onLabelAddFeatWidth = (selectServiceTextField.frame.size.width/100)*10;
    int onLabelAddFeatHeight = (width/100)*10;
    UILabel *onAddFeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(additionalLabel.frame.origin.x + additionalLabel.frame.size.width + (selectServiceTextField.frame.size.width/100)*1, additionalLabel.frame.origin.y, onLabelAddFeatWidth, onLabelAddFeatHeight)];
    [onAddFeatLabel setTextAlignment:NSTextAlignmentRight];
    [onAddFeatLabel setText:[LabelUtils getLabelForKey:@"no"]];
    onAddFeatLabel.lineBreakMode = UILineBreakModeWordWrap;
    onAddFeatLabel.numberOfLines = 2;
    [onAddFeatLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:onAddFeatLabel];
    
    //Toggle Button
    //    int toggleBtnX = onLabel.frame.origin.x + onLabel.frame.size.width + (selectServiceTextField.frame.size.width/100)*1;
    int toggleAddFeatBtnX = onAddFeatLabel.frame.origin.x + onAddFeatLabel.frame.size.width + (width/100)*5;
    int toggleAddFeatBtnY = onAddFeatLabel.frame.origin.y;
    int toggleAddFeatBtnWidth = (selectServiceTextField.frame.size.width/100)*10;
    int toggleAddFeatBtnHeight = (width/100)*10;
    toggleAddFeatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toggleAddFeatButton setFrame:CGRectMake(toggleAddFeatBtnX, toggleAddFeatBtnY, toggleAddFeatBtnWidth, toggleAddFeatBtnHeight)];
    [toggleAddFeatButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    [toggleAddFeatButton addTarget:self action:@selector(additionalFeatureToggleBtn:) forControlEvents:UIControlEventTouchUpInside];
    toggleAddFeatButton.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:toggleAddFeatButton];
    
    //Off Label
    int offLabelAddFeatWidth = (selectServiceTextField.frame.size.width/100)*10;
    int offLabelAddFeatHeight = (width/100)*10;
    UILabel *offAddFeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(toggleAddFeatButton.frame.origin.x + toggleAddFeatButton.frame.size.width + (width/100)*5, onAddFeatLabel.frame.origin.y, offLabelAddFeatWidth, offLabelAddFeatHeight)];
    [offAddFeatLabel setTextAlignment:NSTextAlignmentLeft];
    [offAddFeatLabel setText:[LabelUtils getLabelForKey:@"yes"]];
    offAddFeatLabel.lineBreakMode = UILineBreakModeWordWrap;
    offAddFeatLabel.numberOfLines = 2;
    [offAddFeatLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:offAddFeatLabel];
    
    [backgroundColorView setFrame:CGRectMake(0, 0, width, additionalLabel.frame.origin.y + additionalLabel.frame.size.height + (height/100)*3)];
    
    // Initialize SDK Button
    initializeSDKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [initializeSDKBtn setFrame:CGRectMake((width/100)*1,height - (height/100)*8.5, width - (width/100)*2, (height/100)*8)];
    [initializeSDKBtn setTitle:@"INITIALIZE SDK" forState:UIControlStateNormal];
    [initializeSDKBtn setBackgroundColor:[UIColor blackColor]];
    initializeSDKBtn.titleLabel.textColor = [UIColor whiteColor];
    [initializeSDKBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    initializeSDKBtn.layer.cornerRadius = 20;
    initializeSDKBtn.clipsToBounds = YES;
    [initializeSDKBtn addTarget:self action:@selector(continueButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:initializeSDKBtn];
//    [self addLinearGradientToView:initializeSDKBtn TopColor:[ArrayObjectController colorwithHexString:@"#00A579" alpha:1.0] BottomColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
   
    //Continue Button
    continueProcessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [continueProcessBtn setFrame:CGRectMake((width/100)*1,height - (height/100)*8.5, width - (width/100)*2, (height/100)*8)];
    [continueProcessBtn setTitle:[LabelUtils getLabelForKey:@"continue_btn"] forState:UIControlStateNormal];
    [continueProcessBtn setBackgroundColor:[UIColor blackColor]];
    continueProcessBtn.titleLabel.textColor = [UIColor whiteColor];
    [continueProcessBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    continueProcessBtn.layer.cornerRadius = 20;
    continueProcessBtn.clipsToBounds = YES;
    [continueProcessBtn addTarget:self action:@selector(continueProcessButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:continueProcessBtn];
    
//    if([ArrayObjectController getIsContinueProcess]) {
//        [initializeSDKBtn setFrame:CGRectMake((width/100)*1,height - (height/100)*8.5, (width/2) - (width/100)*2, (height/100)*8)];
////        [self addLinearGradientToView:initializeSDKBtn TopColor:[ArrayObjectController colorwithHexString:@"#00A579" alpha:1.0] BottomColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
//        [continueProcessBtn setFrame:CGRectMake((width/2) + (width/100)*1,height - (height/100)*8.5, initializeSDKBtn.frame.size.width, initializeSDKBtn.frame.size.height)];
////        [self addLinearGradientToView:continueProcessBtn TopColor:[ArrayObjectController colorwithHexString:@"#00A579" alpha:1.0] BottomColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
//       // [continueProcessBtn setHidden:NO];
//        [initializeSDKBtn setHidden:NO];
//    } else {
//        //[continueProcessBtn setHidden:YES];
//        [initializeSDKBtn setHidden:YES];
//    }
    [initializeSDKBtn setHidden:YES];

    //ScrollView Implementation
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, backgroundColorView.frame.origin.y + backgroundColorView.frame.size.height, width, height - backgroundColorView.frame.size.height - initializeSDKBtn.frame.size.height)];
    scrollView.showsVerticalScrollIndicator=YES;
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView];
    [self.view bringSubviewToFront:initializeSDKBtn];
    
    float endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*6 functionName:[LabelUtils getLabelForKey:@"signature_capture"]];
    endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*3 + endViewPosition functionName:[LabelUtils getLabelForKey:@"document_capture"]];
    endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*3 + endViewPosition functionName:[LabelUtils getLabelForKey:@"voice_capture"]];
    endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*3 + endViewPosition functionName:[LabelUtils getLabelForKey:@"fingerprint_capture_4F"]];
    endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*3 + endViewPosition functionName:[LabelUtils getLabelForKey:@"location_capture"]];
    endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*3 + endViewPosition functionName:[LabelUtils getLabelForKey:@"video_capture"]];
    endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*3 + endViewPosition functionName:[LabelUtils getLabelForKey:@"image_snippet_OCR"]];
    endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*3 + endViewPosition functionName:[LabelUtils getLabelForKey:@"barcode_scan"]];
    endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*3 + endViewPosition functionName:[LabelUtils getLabelForKey:@"video_conference"]];
    endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*3 + endViewPosition functionName:[LabelUtils getLabelForKey:@"card_capture"]];
    endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*3 + endViewPosition functionName:[LabelUtils getLabelForKey:@"slant_capture"]];
     endViewPosition = [self addDataInScrollView:scrollView scrollY:(width/100)*3 + endViewPosition functionName:[LabelUtils getLabelForKey:@"capture_sec_id"]];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width,  endViewPosition + (width/100)*3)];
    
    fieldArray = @[@"SignatureCapture",@"DocumentCapture",@"VoiceCapture",@"FingerPrint",@"LocationView",@"VideoView",@"SnippetView",@"BarcodeScan",@"VideoConference",@"CardScan",@"SlantCapture",@"SecondaryIdCapture"];
    
    [scrollView setAlpha:0.5];
    [scrollView setUserInteractionEnabled:NO];
    [scrollView setScrollEnabled:false];
}

-(void)continueProcessButton:(UIButton*)button {
    [self pageSetUpMethod];
}

-(void)continueButton:(UIButton*)button {
    NSString *url = [ArrayObjectController retrieveSetting:@"url"];
    NSString *loginid = [ArrayObjectController retrieveSetting:@"loginid"];
    NSString *password = [ArrayObjectController retrieveSetting:@"password"];
    NSString *merchantid = [ArrayObjectController retrieveSetting:@"merchantid"];
    NSString *productid = [ArrayObjectController retrieveSetting:@"productid"];
    NSString *productname = [ArrayObjectController retrieveSetting:@"productname"];
    NSString *language = [ArrayObjectController retrieveSetting:@"language"];
    
    [AppItSDK deleteData];
    
    [AppItSDK initializeAppItSDK:self url:url loginId:loginid password:password merchantID:merchantid productID:productid productName:productname Language:language EnableDebug:false enableGPS:false];
    
}

-(void)debugToggleBtn:(UIButton*)button {
    NSLog(@"Debug Additional Feature");
    if(isDebugToggleOn) {
        [toggleButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        isDebugToggleOn = false;
    } else {
        [toggleButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        isDebugToggleOn = true;
    }
}

-(void)additionalFeatureToggleBtn:(UIButton*)button {
    NSLog(@"Need Additional Feature");
    if([scrollView isScrollEnabled]) {
        [scrollView setAlpha:0.5];
        [scrollView setScrollEnabled:false];
        [scrollView setUserInteractionEnabled:NO];
        [toggleAddFeatButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    } else {
        [scrollView setAlpha:1.0];
        [scrollView setScrollEnabled:true];
        [scrollView setUserInteractionEnabled:YES];
        [toggleAddFeatButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
    }
}

-(float)addDataInScrollView:(UIScrollView *)scrollView scrollY:(float)scrollY functionName:(NSString*)functionName {
    int width = self.view.frame.size.width;
    counter++;
    UIButton *checkBox = [[UIButton alloc] initWithFrame:CGRectMake((width/100)*2, scrollY, (width/100)*8, (width/100)*8)];
    [checkBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [checkBox setTag:counter];
    [checkBox setTitle:@"UnCheck" forState:UIControlStateNormal];
    [checkBox addTarget:self action:@selector(chkUnChkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:checkBox];
    
    UIButton *functionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if([functionName isEqualToString:@"Fingerprint Capture(4F)"]) {
        [functionButton setFrame:CGRectMake(((UIButton *) checkBox).frame.origin.x + ((UIButton *) checkBox).frame.size.width + (width/100)*10, ((UIButton *) checkBox).frame.origin.y, (width/100)*80, (width/100)*10)];
    } else {
        [functionButton setFrame:CGRectMake(((UIButton *) checkBox).frame.origin.x + ((UIButton *) checkBox).frame.size.width + (width/100)*10, ((UIButton *) checkBox).frame.origin.y, (width/100)*60, (width/100)*10)];
    }
    [functionButton setTitle:functionName forState:UIControlStateNormal];
    functionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [functionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    functionButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    functionButton.titleLabel.numberOfLines = 2;
    [scrollView addSubview:functionButton];
    
    UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [helpButton setFrame:CGRectMake(width - (width/100)*15, functionButton.frame.origin.y + functionButton.frame.size.height/2 - (width/100)*3, (width/100)*6, (width/100)*6)];
    [helpButton addTarget:self action:@selector(questionMarkButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [helpButton setImage:[UIImage imageNamed:@"questionmark.png"] forState:UIControlStateNormal];
    [scrollView addSubview:helpButton];
    
    UIView *addLineView = [[UIView alloc] initWithFrame:CGRectMake((width/100)*3, functionButton.frame.origin.y + functionButton.frame.size.height + (width/100)*5, width - (width/100)*6, (width/100)*0.2)];
    [addLineView setBackgroundColor:[UIColor grayColor]];
    [scrollView addSubview:addLineView];
    
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width,  addLineView.frame.size.height)];
    if([functionName isEqualToString:@"Video Capture"]) {
        videoRecCheckBox = checkBox;
        videoFunctionButton = functionButton;
        videoHelpButton = helpButton;
    } else if([functionName isEqualToString:@"Fingerprint Capture(4F)"]) {
        fingerPrintCapCheckBox = checkBox;
        fingerPrintCapFunctionButton = functionButton;
        fingerPrintHelpButton = helpButton;
    } else if([functionName isEqualToString:@"Voice Capture"]) {
        voiceCapCheckBox = checkBox;
        voiceCapFunctionButton = functionButton;
        voiceHelpButton = helpButton;
    }else if([functionName isEqualToString:@"Video Conference"]) {
        videoConfCapCheckBox = checkBox;
        videoConfFunctionButton = functionButton;
        videoConfHelpButton = helpButton;
    } else if([functionName isEqualToString:[LabelUtils getLabelForKey:@"capture_sec_id"]]) {
        secIdCapCheckBox = checkBox;
        secIdCapFunctionButton = functionButton;
        secIdCapHelpButton = helpButton;
    }
    
    return (addLineView.frame.origin.y + addLineView.frame.size.height);
}

- (IBAction)chkUnChkBtn:(id)sender {
    
    int inte = [sender tag];
    NSArray *subViews = [scrollView subviews];
    for(UIButton *view in subViews) {
        if(inte == [view tag]) {
            NSLog(@"Checking");
            if ([[view currentTitle] isEqual:@"UnCheck"] ){
               [view setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
               [view setTitle:@"Check" forState:UIControlStateNormal];
                switch (inte) {
                    case 0:
                        [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 1:
                       [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 2:
                        [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 3:
                        [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 4:
                       [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 5:
                        [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 6:
                       [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 7:
                        [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 8:
                        [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 9:
                        [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 10:
                        [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 11:
                        [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 12:
                        [pageControlArray setObject:fieldArray[inte - 1] forKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    default:
                        break;
                }
        
            } else{
            
                [view setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
                [view setTitle:@"UnCheck" forState:UIControlStateNormal];
                switch (inte) {
                    case 0:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 1:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 2:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 3:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 4:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 5:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 6:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 7:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 8:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 9:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 10:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 11:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    case 12:
                        [pageControlArray removeObjectForKey:[NSString stringWithFormat:@"%d", inte]];
                        break;
                    default:
                        break;
                }
            }
        }
    }
}

-(void)questionMarkButtonClicked:(UIButton*)button {
    NSLog(@"questionMarkButton Clicked");
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:[LabelUtils getLabelForKey:@"help"]message:@"Greyhond divisively hello coldly wonderfully marginally far upon excluding. Greyhond divisively hello coldly" delegate:self cancelButtonTitle:[LabelUtils getLabelForKey:@"okay"] otherButtonTitles:nil, nil];
    
    [av show];
}

-(void)navigationDrawerBtn:(UIButton*)button {
    NSLog(@"Navigation Drawer Btn clicked");
    SidePanelController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SidePanelController"];
    controller.view.backgroundColor = [UIColor clearColor];

    UIViewController *childViewController = [self.navigationController.childViewControllers lastObject];
    if(![childViewController isKindOfClass:controller.class]) {
        controller.delegate = self;
        [self.navigationController addChildViewController:controller];
        [self.navigationController.view addSubview:controller.view];
        [controller.view layoutIfNeeded];
        [controller didMoveToParentViewController:self];
    }
}

-(void)initializeSDKResponse : (NSMutableDictionary*) result {
    NSLog(@"");
    NSMutableDictionary *resultDict = [result objectForKey:@"Result"];
    int val = [[result objectForKey:@"StatusCode"] intValue];
    if(val == 0) {
        NSString * serviceIds=[resultDict  objectForKey:@"Parameter_Value"];
         [self pageSetUpMethod];
    } else {
        if(nil != resultDict) {
            //Servers Response
            [self snackBarView:[resultDict objectForKey:@"Status_Message"]];
        } else {
            [self snackBarView:[result objectForKey:@"statusMessage"]];
        }
    }
}

-(NSArray *) stringToNeumericArray:(NSArray *)keyArrays {
    
    NSMutableArray *intArray = [[NSMutableArray alloc] init];
    for(NSString *key in keyArrays) {
        int intKey = [key intValue];
        [intArray addObject:[NSNumber numberWithInt:intKey]];
    }
    
    return intArray;
}

-(NSArray *) neumericToStringArray:(NSArray *)keyArrays {
    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
    for(NSString *key in keyArrays) {
        NSString *stringKey = [NSString stringWithFormat:@"%@", key];
        [stringArray addObject:stringKey];
    }
    return stringArray;
}

-(void)pageSetUpMethod {
    NSArray *sortedKeys = [pageControlArray.allKeys sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
    NSArray *sortedValues = [[NSMutableArray alloc] init];
    NSArray *neumericKeyArray = [self stringToNeumericArray:sortedKeys];
//    NSArray *sortedArray = [pageControlArray objectsForKeys:neumericKeyArray notFoundMarker:@""];
    NSArray *sortedArrayKeys = [neumericKeyArray sortedArrayUsingSelector:@selector(compare:)];
    NSArray *sortedStringKeyArray = [self neumericToStringArray:sortedArrayKeys];
    sortedValues = [pageControlArray objectsForKeys:sortedStringKeyArray notFoundMarker:@""];
//    sortedValues = [[[[pageControlArray allKeys] sortedArrayUsingSelector:@selector(compare:)] reverseObjectEnumerator] allObjects];
    NSMutableArray *sortedMutableArray = [NSMutableArray arrayWithArray:sortedValues];
    
    if(nil != sortedMutableArray && [sortedMutableArray containsObject:@"SecondaryIdCapture"]) {
        [sortedMutableArray removeObject:@"SecondaryIdCapture"];
        [sortedMutableArray addObject:@"SecondaryIdFaceDetailsViewController"];
        [sortedMutableArray addObject:@"SecondaryIDCaptureFront"];
        [sortedMutableArray addObject:@"SecondaryIDCaptureBack"];
        
        [ArrayObjectController setIsSecondaryIdCaptureImage:true];
    } else {
        [ArrayObjectController setIsSecondaryIdCaptureImage:false];
    }
    
    NSString *select_service = [selectServiceTextField text];
    NSString *serviceID = [select_service substringToIndex:3];
    NSString *serviceIDDetail = [select_service stringByReplacingOccurrencesOfString:serviceID withString:@""];
    [ArrayObjectController setServiceId:[serviceID intValue]];
    NSString *navBarTitle = serviceIDDetail;
    bool openIdFaceScreen = true;
    
    if([@"20" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"ID Validation Only";
        openIdFaceScreen = true;
    } else if([@"25" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"ID Validation with Customer Enrollment";
        openIdFaceScreen = true;
    } else if([@"30" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"DataCapture" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"employeeData" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"ID Validation with Employee Enrollment";
        openIdFaceScreen = true;
    } else if([@"10" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] || [@"50" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] || [@"77" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] || [@"78" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] || [@"80" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
//        [sortedMutableArray insertObject:@"SlantCapture" atIndex:0];//////Temp
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"ID Validation And Face Match";
    } else if([@"55" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
//        [sortedMutableArray insertObject:@"employeeData" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"employeeData" atIndex:[sortedMutableArray count]];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
        openIdFaceScreen = true;
//        navBarTitle = @"ID Validation And Face Match with Employee Enrollment";
    } else if([@"155" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"VideoView" atIndex:[sortedMutableArray count]];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
        openIdFaceScreen = true;
//        navBarTitle = @"IDV+Video Match";
        
    } else if([@"160" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"VideoView" atIndex:[sortedMutableArray count]];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
        openIdFaceScreen = true;
//        navBarTitle = @"IDV+Video Match w/Cust Enroll";
    } else if([@"165" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"VideoView" atIndex:[sortedMutableArray count]];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
        [sortedMutableArray insertObject:@"employeeData" atIndex:[sortedMutableArray count]];
        openIdFaceScreen = true;
//        navBarTitle = @"IDV+Video Match w/Emp Enroll";
    } else if([@"60" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] || [@"65" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Face Match";
        openIdFaceScreen = false;
    } else if([@"70" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Customer Update";
        openIdFaceScreen = false;
    }else if([@"75" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"employeeData" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Employee Update";
        openIdFaceScreen = false;
    }else if([@"100" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]){
        [sortedMutableArray insertObject:@"FingerPrint" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Customer Verification";
        openIdFaceScreen = false;
    } else if([@"105" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]){
        [sortedMutableArray insertObject:@"FingerPrint" atIndex:0];
        [sortedMutableArray insertObject:@"VoiceCapture" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Customer Verification";
        openIdFaceScreen = false;
    } else if([@"400" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"GenerateOTPNew" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Generate OTP";
        openIdFaceScreen = false;
    } else if([@"410" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"VerifyOTPNew" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Verify OTP";
        openIdFaceScreen = false;
    } else if([@"200" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"poacaptureview" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Address Matching";
        openIdFaceScreen = false;
    } else if([@"300" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"employeeData" atIndex:0];
        [sortedMutableArray insertObject:@"FingerPrint" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Employee Verification";
        openIdFaceScreen = false;
    } else if([@"305" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"employeeData" atIndex:0];
        [sortedMutableArray insertObject:@"VoiceCapture" atIndex:0];
        [sortedMutableArray insertObject:@"FingerPrint" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Employee Verification";
        openIdFaceScreen = false;
    } else if([@"310" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"employeeData" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Face Match with Employee Enrollment";
        openIdFaceScreen = false;
    } else if([@"401" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Generate Token";
        openIdFaceScreen = false;
    } else if([@"320" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        
        //[sortedMutableArray insertObject:@"employeeData" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieEmployee" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Create Customer";
        openIdFaceScreen = false;
        
    } else if([@"330" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        
        [sortedMutableArray insertObject:@"employeeData" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieEmployee" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Create Employee";
        openIdFaceScreen = false;
    } else if([@"175" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        
        [sortedMutableArray insertObject:@"FingerPrint" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"VoiceCapture" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Customer Enrollment with FP";
        openIdFaceScreen = false;
    } else if([@"180" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"employeeData" atIndex:0];
        [sortedMutableArray insertObject:@"FingerPrint" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"VoiceCapture" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Employee Enrollment with FP";
        openIdFaceScreen = false;
    } else if([@"360" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"employeeData" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:0];
//        [sortedMutableArray insertObject:@"SelfieEmployee" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"DefineProduct" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Id Validation & Face Match(Primary ID) 360";
        openIdFaceScreen = true;
    } else if([@"361" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"employeeData" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:0];
//        [sortedMutableArray insertObject:@"SelfieEmployee" atIndex:0];
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"DefineProduct" atIndex:[sortedMutableArray count]];
//        navBarTitle = @"Id Validation & Face Match(Primary ID) 361";
        openIdFaceScreen = true;
    }else if([@"186" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
        //        navBarTitle = @"Customer Update";
        openIdFaceScreen = false;
    }else if([@"191" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"employeeData" atIndex:[sortedMutableArray count]];
        //        navBarTitle = @"Employee Update";
        openIdFaceScreen = false;
    }else if([@"500" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        
        //[sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"VideoConference" atIndex:0];
       // [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
        openIdFaceScreen = false;
    }else if([@"505" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        
        [sortedMutableArray insertObject:@"VideoConference" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
          [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
        openIdFaceScreen = true;
    }else if([@"510" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        
        [sortedMutableArray insertObject:@"VideoConference" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
        openIdFaceScreen = true;
    }else if([@"515" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        
        [sortedMutableArray insertObject:@"VideoConference" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureBack" atIndex:0];
        [sortedMutableArray insertObject:@"IDCaptureFront" atIndex:0];
        [sortedMutableArray insertObject:@"employeeData" atIndex:[sortedMutableArray count]];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
        openIdFaceScreen = true;
    }else if([@"185" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"VoiceCapture" atIndex:[sortedMutableArray count]];
        [sortedMutableArray insertObject:@"FingerPrint" atIndex:[sortedMutableArray count]];
        openIdFaceScreen = false;
    }else if([@"190" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"VoiceCapture" atIndex:[sortedMutableArray count]];
        [sortedMutableArray insertObject:@"FingerPrint" atIndex:[sortedMutableArray count]];
        openIdFaceScreen = false;
    }else if([@"660" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]){
        [sortedMutableArray insertObject:@"SelfieCapture" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
        openIdFaceScreen = false;
    } else if([@"620" isEqualToString:[serviceID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        [sortedMutableArray insertObject:@"AutofillBackController" atIndex:0];
        [sortedMutableArray insertObject:@"AutofillFrontController" atIndex:0];
        [sortedMutableArray insertObject:@"DataCapture" atIndex:[sortedMutableArray count]];
    }
    
    if(openIdFaceScreen) {
        IdFaceDetailsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"IdFaceDetailsViewController"];
        controller.serviceType = navBarTitle;
        controller.serviceIdNumber = serviceID;
        controller.pageControlFields = sortedMutableArray;
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        if([ArrayObjectController getCustomizedUIConfig]) {
            CustomizeUIConfigurationController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomizeUIConfiguration"];
            controller.pageControlFields = sortedMutableArray;
            controller.serviceType = navBarTitle;
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            RootPageViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"RootPageViewController"];
            controller.pageControlFields = sortedMutableArray;
            controller.serviceType = navBarTitle;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

-(UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)addLinearGradientToView:(UIView*)view TopColor:(UIColor*)topColor BottomColor:(UIColor*)bottomColor
{
    for(CALayer* layer in view.layer.sublayers)
    {
        if ([layer isKindOfClass:[CAGradientLayer class]])
        {
            [layer removeFromSuperlayer];
        }
    }
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    //top down gradient
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.frame = view.bounds;
    
    
    
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    
    [view.layer insertSublayer:gradientLayer atIndex:0];
    
}

-(void)sidePanelBtnClicked : (NSString*) controllerType{
    NSLog(@"Side Panel Button Clicked");
    if([controllerType isEqualToString:@"AccountSetUP"]) {
        
        AccountSetUpViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountSetUpViewController"];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    else if([controllerType isEqualToString:@"ProcessFlow"]) {
    }
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(void)snackBarView:(NSString*)snackMessage {
    
    //    int width = self.navigationController.view.frame.size.width;
    //    int height = self.navigationController.view.frame.size.height;
    
    //    int height = self.view.frame.size.height;
    //    int width = self.view.frame.size.width;
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
