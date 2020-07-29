//
//  AccountSetUpViewController.m
//  NewSDKDesign
//
//  Created by  on 27/09/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import "AccountSetUpViewController.h"
#import "SidePanelController.h"
#import "ProcessFlowController.h"
#import "ArrayObjectController.h"
#import "NSStringUtilsDemo.h"
#import "AppDelegate.h"
#import "ResultViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LabelUtils.h"
#import "CustomizeUIConfigManager.h"

@interface AccountSetUpViewController ()

@end

@implementation AccountSetUpViewController {
    UITextField *urlTextField, *loginIdTextField, *passwordTextField, *merchantIdField
    , *productIdTextField, *productNameTextField, *languageTextField;
    UILabel *urlLabel, *loginIdLabel, *passwordLabel, *merchantIdLabel, *productIdLabel, *productNameLabel, *languageLabel, *debugMode, *onLabel, *offLabel, *navigationLabel, *customizedUIConfig;
    NSArray *_selectedPickerData;
    NSArray *langFieldPickerData;
    UIPickerView *myPickerView;
    UIToolbar *toolbarForPicker;
    UILabel *showMSGLabel;
    NSTimer *fiveSecondTimer;
    bool isSnackBarVisible;
    UIButton *toggleButton, *toggleButton_customized;
    bool isDebugToggleOn, isCustomizedConfigUIOn;
    bool isPremissionStatus;
    UIButton *Continuebutton, *qrCodeScanButton;
    bool isIPhone4_5;
}

-(void)viewDidAppear:(BOOL)animated {
    isSnackBarVisible = false;
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    langFieldPickerData = @[@"English", @"Spanish", @"Myanmar"];
    _selectedPickerData = @[@"English", @"Spanish", @"Myanmar"];
    [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    myPickerView.tintColor = [ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0];
    //    myPickerView.layer.borderWidth = 1.0;
    //    myPickerView.layer.cornerRadius = 5.0;
    myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    //Adding Toolbar with 'Done' button on picker view
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerDoneClicked)];
    
    toolbarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
    [toolbarForPicker setItems:toolbarItems];
    [languageTextField setInputView:myPickerView];
    [languageTextField setInputAccessoryView:toolbarForPicker];
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [languageTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == languageTextField){
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
    
    if([_selectedPickerData isEqualToArray:langFieldPickerData]){
        [languageTextField setText:langFieldPickerData[row]];
        [languageTextField setTag:row+1];
        
        if([@"Spanish" isEqualToString:langFieldPickerData[row]]) {
            [self saveSetting:@"language" value:@"es"];
        }else if([@"Myanmar"isEqualToString:langFieldPickerData[row]]){
            [self saveSetting:@"language" value:@"my"];
        }else {
            [self saveSetting:@"language" value:@"en"];
        }
        
        NSString *language = [self retrieveSetting:@"language" defaultValue:@"en"];
        
        [CustomizeUIConfigManager reinitWithLanguageChange:language];
        
        [CustomizeUIConfigManager initCustomizeUIConfig];
        
        [AppItSDK customizeUserInterface:[CustomizeUIConfigManager getCompleteUIConfigDictionary]];
        
        [self reloadLabel];
    }
}
//Picker Changes End

-(void)reloadLabel{
    
    NSString *language = [self retrieveSetting:@"language" defaultValue:@"en"];
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:language];
    
    [self setTextForLabel:urlLabel labelText:[LabelUtils getLabelForKey:@"test_url"]];
    [self setTextForLabel:loginIdLabel labelText:[LabelUtils getLabelForKey:@"login_id"]];
    [self setTextForLabel:passwordLabel labelText:[LabelUtils getLabelForKey:@"password"]];
    [self setTextForLabel:merchantIdLabel labelText:[LabelUtils getLabelForKey:@"merchant_id"]];
    [self setTextForLabel:productIdLabel labelText:[LabelUtils getLabelForKey:@"product_id"]];
    [self setTextForLabel:productNameLabel labelText:[LabelUtils getLabelForKey:@"product"]];
    [self setTextForLabel:languageLabel labelText:[LabelUtils getLabelForKey:@"language"]];
    [debugMode setText:[LabelUtils getLabelForKey:@"debaug_mode"]];
    [onLabel setText:[LabelUtils getLabelForKey:@"on"]];
    [offLabel setText:[LabelUtils getLabelForKey:@"off"]];
    [customizedUIConfig setText:[LabelUtils getLabelForKey:@"customize_ui_config"]];
    [navigationLabel setText:[LabelUtils getLabelForKey:@"account_setup"]];
    [Continuebutton setTitle:[LabelUtils getLabelForKey:@"initialize"] forState:UIControlStateNormal];
    if(![language isEqualToString:@"en"] || isIPhone4_5) {
        [qrCodeScanButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    } else {

        [qrCodeScanButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    }
    [qrCodeScanButton setTitle:[LabelUtils getLabelForKey:@"qr_button_title"] forState:UIControlStateNormal];
}

-(void) setTextForLabel:(UILabel *) changedLabel labelText:(NSString *)labelText {
    NSString *labelName = labelText;
    CGSize urlSize;
    urlSize = [NSStringUtilsDemo getUILabelSizeFromLabel:labelName size:14];
    [changedLabel setFrame:CGRectMake(changedLabel.frame.origin.x, changedLabel.frame.origin.y, urlSize.width, urlSize.height)];
    [changedLabel setText:labelName];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:changedLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isPremissionStatus=false;
    isIPhone4_5 = false;
    [ArrayObjectController setIsContinueProcess:false];
    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    
    [self initUI];
    [self navigationCode];
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    [self reloadLabel];
    
    //CustomizeUIConfigToggle
    if([ArrayObjectController getCustomizedUIConfig]) {
        [toggleButton_customized setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        isCustomizedConfigUIOn = true;
    } else {
        [toggleButton_customized setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        isCustomizedConfigUIOn = false;
    }
}

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

-(void)navigationCode {
    int width = self.view.frame.size.width;
    self.navigationController.navigationBar.clipsToBounds = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    navigationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    navigationLabel.backgroundColor = [UIColor clearColor];
    //navigationLabel.font = [UIFont boldSystemFontOfSize:18];
    navigationLabel.numberOfLines = 2;
    navigationLabel.font = [UIFont boldSystemFontOfSize:18];
    navigationLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    navigationLabel.textAlignment = UITextAlignmentCenter;
    self.navigationItem.titleView = navigationLabel;
    //navigationLabel.text = [@"Account Setup"];
    navigationLabel.text=[LabelUtils getLabelForKey:@"account_setup"];
    navigationLabel.lineBreakMode = UILineBreakModeWordWrap;
    [navigationLabel sizeToFit];
    
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

-(void)initUI {
    
    isIPhone4_5 = false;
    bool iphone_X = false;
    
    
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        NSLog(@"iPhone");
        int height = (int)[[UIScreen mainScreen] nativeBounds].size.height;
        int width = (int)[[UIScreen mainScreen] nativeBounds].size.width;
        
        switch (height) {
                
            case 960:
                //"iPhone 4 4s"
                isIPhone4_5 = true;
                iphone_X = false;
                break;
            case 1136:
                //"iPhone 5 or 5S or 5C"
                isIPhone4_5 = true;
                iphone_X = false;
                break;
            case 2436:
                //"iPhone X"
                iphone_X = true;
                break;
            case 1792:
                //"iPhone X"
                iphone_X = true;
                break;
        }
    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view setBackgroundColor:[self colorwithHexString:@"#E3F6F3" alpha:1.0]];
    int navigationHeight = 0;
    int height = self.view.frame.size.height;
    int width = self.view.frame.size.width;
    isDebugToggleOn = false;
    isCustomizedConfigUIOn = false;
    
    urlTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100)*5, (height/100)*3 +navigationHeight, width - (width/100)*10, (height/100)*8)];
    [urlTextField setFont:[UIFont systemFontOfSize:14]];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:urlTextField];
    [self.view addSubview:urlTextField];
    
    //    NSString *urlcn = @"Test URL";
    NSString *urlcn = @"Test URL";
    CGSize urlSize = [NSStringUtilsDemo getUILabelSizeFromLabel:urlcn size:14];
    urlLabel = [[UILabel alloc] initWithFrame:CGRectMake(urlTextField.frame.origin.x + 15, urlTextField.frame.origin.y - urlSize.height/2, urlSize.width, urlSize.height)];
    [urlLabel setText:urlcn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:urlLabel];
    [self.view addSubview:urlLabel];
    
    //Login Id
    loginIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(urlTextField.frame.origin.x, ((height/100)*3 + (height/100)*8) + (height/100)*3 + navigationHeight, urlTextField.frame.size.width/2 - (urlTextField.frame.size.width/100) * 2, (height/100)*8)];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:loginIdTextField];
    [self.view addSubview:loginIdTextField];
    
    NSString *logincn = @"Login ID";
    CGSize loginSize = [NSStringUtilsDemo getUILabelSizeFromLabel:logincn size:14];
    loginIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(loginIdTextField.frame.origin.x + 15, loginIdTextField.frame.origin.y - (loginSize.height/2), loginSize.width, loginSize.height)];
    [loginIdLabel setText:logincn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:loginIdLabel];
    [self.view addSubview:loginIdLabel];
    
    //Password
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(loginIdTextField.frame.origin.x + loginIdTextField.frame.size.width + (urlTextField.frame.size.width/100) * 4, navigationHeight + ((height/100)*3 + (height/100)*8) + (height/100)*3, loginIdTextField.frame.size.width, (height/100)*8)];
    [passwordTextField setFont:[UIFont systemFontOfSize:14]];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:passwordTextField];
    passwordTextField.secureTextEntry = YES;
    [self.view addSubview:passwordTextField];
    
    NSString *passwordcn = @"Password";
    CGSize passwordSize = [NSStringUtilsDemo getUILabelSizeFromLabel:passwordcn size:14];
    passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(passwordTextField.frame.origin.x + 15, passwordTextField.frame.origin.y - (passwordSize.height/2), passwordSize.width, passwordSize.height)];
    [passwordLabel setText:passwordcn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:passwordLabel];
    [self.view addSubview:passwordLabel];
    
    //Merchant ID
    merchantIdField = [[UITextField alloc] initWithFrame:CGRectMake(urlTextField.frame.origin.x, loginIdTextField.frame.origin.y + loginIdTextField.frame.size.height + (height/100)*3, urlTextField.frame.size.width/2 - (urlTextField.frame.size.width/100) * 2, (height/100)*8)];
    [merchantIdField setFont:[UIFont systemFontOfSize:14]];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:merchantIdField];
    [merchantIdField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.view addSubview:merchantIdField];
    
    NSString *merchantIdcn = @"Merchant ID";
    CGSize merchantSize = [NSStringUtilsDemo getUILabelSizeFromLabel:merchantIdcn size:14];
    merchantIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(merchantIdField.frame.origin.x + 15, merchantIdField.frame.origin.y - (merchantSize.height/2), merchantSize.width, merchantSize.height)];
    [merchantIdLabel setText:merchantIdcn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:merchantIdLabel];
    [self.view addSubview:merchantIdLabel];
    
    //Product ID
    productIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(loginIdTextField.frame.origin.x + loginIdTextField.frame.size.width + (urlTextField.frame.size.width/100) * 4, loginIdTextField.frame.origin.y + loginIdTextField.frame.size.height + (height/100)*3, loginIdTextField.frame.size.width, (height/100)*8)];
    [productIdTextField setFont:[UIFont systemFontOfSize:14]];
    [productIdTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:productIdTextField];
    [self.view addSubview:productIdTextField];
    
    NSString *productIDcn = @"Product ID";
    CGSize productSize = [NSStringUtilsDemo getUILabelSizeFromLabel:productIDcn size:14];
    productIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(productIdTextField.frame.origin.x + 15, productIdTextField.frame.origin.y - (productSize.height/2), productSize.width, productSize.height)];
    [productIdLabel setText:productIDcn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:productIdLabel];
    [self.view addSubview:productIdLabel];
    
    //Product Name
    //    UITextField *productNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(width/2 - (width/100)*45, merchantIdField.frame.origin.y + merchantIdField.frame.size.height + (height/100)*5, (width/100)*90, (width/100)*15)];
    productNameTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100)*5, merchantIdField.frame.origin.y + merchantIdField.frame.size.height + (height/100)*3, width - (width/100)*10, (height/100)*8)];
    [productNameTextField setFont:[UIFont systemFontOfSize:14]];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:productNameTextField];
    [self.view addSubview:productNameTextField];
    
    NSString *productNamecn = @"Product Name";
    CGSize productNameSize = [NSStringUtilsDemo getUILabelSizeFromLabel:productNamecn size:14];
    productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(productNameTextField.frame.origin.x + 15, productNameTextField.frame.origin.y - (productNameSize.height/2), productNameSize.width, productNameSize.height)];
    [productNameLabel setText:productNamecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:productNameLabel];
    [self.view addSubview:productNameLabel];
    
    //Language
    //    UITextField *languageTextField = [[UITextField alloc] initWithFrame:CGRectMake(width/2 - (width/100)*45, productNameTextField.frame.origin.y + productNameTextField.frame.size.height + (height/100)*5, (width/100)*90, (width/100)*15)];
    languageTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100)*5, productNameTextField.frame.origin.y + productNameTextField.frame.size.height + (height/100)*3, width - (width/100)*10, (height/100)*8)];
    [languageTextField setText:@"English"];
    [languageTextField setFont:[UIFont systemFontOfSize:14]];
    [NSStringUtilsDemo setEditTextUITextFieldStyle:languageTextField];
    [self.view addSubview:languageTextField];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(languageTextField.frame.origin.x + languageTextField.frame.size.width - (width/100)*9 , languageTextField.frame.origin.y + (languageTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [self.view addSubview:downArrowImage];
    
    NSString *languagecn = @"Language";
    CGSize languageSize = [NSStringUtilsDemo getUILabelSizeFromLabel:languagecn size:14];
    languageLabel = [[UILabel alloc] initWithFrame:CGRectMake(languageTextField.frame.origin.x + 15, languageTextField.frame.origin.y - (languageSize.height/2), languageSize.width, languageSize.height)];
    [languageLabel setText:languagecn];
    [NSStringUtilsDemo setOtherEditTextUILabelStyle:languageLabel];
    [self.view addSubview:languageLabel];
    
    //Debug Mode Label
    int debugModeWidth = (languageTextField.frame.size.width/100)*50;
    int debugModeHeight= (width/100)*10;
    debugMode = [[UILabel alloc] initWithFrame:CGRectMake(languageTextField.frame.origin.x, languageTextField.frame.origin.y +languageTextField.frame.size.height + (height/100)*2, debugModeWidth, debugModeHeight)];
    [debugMode setTextAlignment:UITextAlignmentLeft];
    [debugMode setText:@"Debug Mode"];
    if(isIPhone4_5) {
        [debugMode setFont:[UIFont systemFontOfSize:12]];
    } else {
        [debugMode setFont:[UIFont systemFontOfSize:14]];
    }
    [self.view addSubview:debugMode];
    
    //On Label
    int onLabelWidth = (languageTextField.frame.size.width/100)*20;
    int onLabelHeight = (width/100)*10;
    //    onLabel = [[UILabel alloc] initWithFrame:CGRectMake(debugMode.frame.origin.x + debugMode.frame.size.width + (languageTextField.frame.size.width/100)*1, debugMode.frame.origin.y, onLabelWidth, onLabelHeight)];
    onLabel = [[UILabel alloc] initWithFrame:CGRectMake(debugMode.frame.origin.x + debugMode.frame.size.width, debugMode.frame.origin.y, onLabelWidth, onLabelHeight)];
    [onLabel setTextAlignment:NSTextAlignmentRight];
    [onLabel setText:@"Off"];
    [onLabel setHidden:YES];
    
    if(isIPhone4_5) {
        [onLabel setFont:[UIFont systemFontOfSize:12]];
    } else {
        [onLabel setFont:[UIFont systemFontOfSize:14]];
    }
    [self.view addSubview:onLabel];
    
    //Toggle Button
    //    int toggleBtnX = onLabel.frame.origin.x + onLabel.frame.size.width + (selectServiceTextField.frame.size.width/100)*1;
    int toggleBtnX = onLabel.frame.origin.x + onLabel.frame.size.width + (languageTextField.frame.size.width/100)*2.5;
    int toggleBtnY = debugMode.frame.origin.y;
    int toggleBtnWidth = (languageTextField.frame.size.width/100)*10;
    int toggleBtnHeight = (width/100)*10;
    toggleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toggleButton setFrame:CGRectMake(toggleBtnX, toggleBtnY, toggleBtnWidth, toggleBtnHeight)];
    [toggleButton addTarget:self action:@selector(debugToggleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [toggleButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    toggleButton.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:toggleButton];
    
    //Off Label
    int offLabelWidth = (languageTextField.frame.size.width/100)*20;
    int offLabelHeight = (width/100)*10;
    offLabel = [[UILabel alloc] initWithFrame:CGRectMake(toggleButton.frame.origin.x + toggleButton.frame.size.width + (languageTextField.frame.size.width/100)*2.5, debugMode.frame.origin.y, offLabelWidth, offLabelHeight)];
    [offLabel setTextAlignment:NSTextAlignmentLeft];
    [offLabel setText:@"On"];
    [offLabel setHidden:YES];

    if(isIPhone4_5) {
        [offLabel setFont:[UIFont systemFontOfSize:12]];
    } else {
        [offLabel setFont:[UIFont systemFontOfSize:14]];
    }
    [self.view addSubview:offLabel];
    
    customizedUIConfig = [[UILabel alloc] initWithFrame:CGRectMake(languageTextField.frame.origin.x, debugMode.frame.origin.y +debugMode.frame.size.height + (height/100)*1, (languageTextField.frame.size.width/100)*70, debugModeHeight)];
    [customizedUIConfig setTextAlignment:UITextAlignmentLeft];
    [customizedUIConfig setText:[LabelUtils getLabelForKey:@"customize_ui_config"]];
    if(isIPhone4_5) {
        [customizedUIConfig setFont:[UIFont systemFontOfSize:12]];
    } else {
        [customizedUIConfig setFont:[UIFont systemFontOfSize:14]];
    }
    [self.view addSubview:customizedUIConfig];
    
    toggleButton_customized = [UIButton buttonWithType:UIButtonTypeCustom];
    [toggleButton_customized setFrame:CGRectMake(toggleBtnX, customizedUIConfig.frame.origin.y, toggleBtnWidth, toggleBtnHeight)];
    [toggleButton_customized addTarget:self action:@selector(customizedUIToggleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [toggleButton_customized setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
    toggleButton_customized.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:toggleButton_customized];
    
    //Save Account
    UIButton *saveAccountbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    CGRect saveAccountframe = CGRectMake(width/2 - (width/100)*45, languageTextField.frame.origin.y + productNameTextField.frame.size.height + (height/100)*5, urlTextField.frame.size.width/2 - (urlTextField.frame.size.width/100) * 2, (width/100)*15);
    CGRect saveAccountframe = CGRectMake((width/100)*5, languageTextField.frame.origin.y + productNameTextField.frame.size.height + (height/100)*3, urlTextField.frame.size.width/2 - (urlTextField.frame.size.width/100) * 2, (([UIScreen mainScreen].bounds.size.height)/100)*6);
    [saveAccountbutton setFrame:saveAccountframe];
    saveAccountbutton.layer.cornerRadius = 20;
    saveAccountbutton.clipsToBounds = YES;
    [saveAccountbutton setTitle:@"Save Account" forState:UIControlStateNormal];
    [saveAccountbutton addTarget:self action:@selector(saveAccountButton:) forControlEvents:UIControlEventTouchUpInside];
    saveAccountbutton.titleLabel.textColor = [UIColor whiteColor];
    [saveAccountbutton setBackgroundColor:[UIColor blackColor]];
    [saveAccountbutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:saveAccountbutton];
    
    [saveAccountbutton setHidden:true];
    
    //Edit Account
    UIButton *editAccountbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake(loginIdTextField.frame.origin.x + loginIdTextField.frame.size.width + (urlTextField.frame.size.width/100) * 4, languageTextField.frame.origin.y + languageTextField.frame.size.height + (height/100)*3, loginIdTextField.frame.size.width, (([UIScreen mainScreen].bounds.size.height)/100)*6);
    [editAccountbutton setFrame:editAccountframe];
    editAccountbutton.layer.cornerRadius = 20;
    editAccountbutton.clipsToBounds = YES;
    [editAccountbutton addTarget:self action:@selector(editAccountButton:) forControlEvents:UIControlEventTouchUpInside];
    [editAccountbutton setTitle:@"Edit Account" forState:UIControlStateNormal];
    editAccountbutton.titleLabel.textColor = [UIColor whiteColor];
    [editAccountbutton setBackgroundColor:[UIColor blackColor]];
    [editAccountbutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:editAccountbutton];
    
    [editAccountbutton setHidden:true];
    
    // Continue
    Continuebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(width/2 - (width/100)*25, customizedUIConfig.frame.origin.y + customizedUIConfig.frame.size.height + (height/100)*3, (width/100)*50, (([UIScreen mainScreen].bounds.size.height)/100)*6);
    [Continuebutton setFrame:frame];
    Continuebutton.layer.cornerRadius = 20;
    Continuebutton.clipsToBounds = YES;
    [Continuebutton addTarget:self action:@selector(continueButton:) forControlEvents:UIControlEventTouchUpInside];
    [Continuebutton setTitle:@"INITIALIZE SDK" forState:UIControlStateNormal];
    Continuebutton.titleLabel.textColor = [UIColor whiteColor];
    [Continuebutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [Continuebutton setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:Continuebutton];
    
    //QRCode Scan Button
    qrCodeScanButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    CGRect frame = CGRectMake(width/2 - (width/100)*25, editAccountbutton.frame.origin.y + editAccountbutton.frame.size.height + (height/100)*3, (width/100)*50, (([UIScreen mainScreen].bounds.size.height)/100)*6);
    CGRect qrCodeFrame;
    if(iphone_X) {
        qrCodeFrame = CGRectMake(width/2 - (width/100)*46, Continuebutton.frame.origin.y + Continuebutton.frame.size.height + (height/100)*4, (width/100)*92 , (height/100)*7);
    } else {
        qrCodeFrame = CGRectMake(languageTextField.frame.origin.x, Continuebutton.frame.origin.y + Continuebutton.frame.size.height + (height/100)*4, languageTextField.frame.size.width, (height/100)*8);
    }
    [qrCodeScanButton setFrame:qrCodeFrame];
    qrCodeScanButton.layer.cornerRadius = 20;
    qrCodeScanButton.clipsToBounds = YES;
    [qrCodeScanButton addTarget:self action:@selector(qrCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    [qrCodeScanButton setTitle:@"Scan QR Code to Fill Account Details" forState:UIControlStateNormal];
    qrCodeScanButton.titleLabel.textColor = [UIColor whiteColor];
    [qrCodeScanButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
//    [qrCodeScanButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 1.0, 0.0, 0.0)];
    [qrCodeScanButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.2, 0.0, 5.0)];
    [qrCodeScanButton setImage:[UIImage imageNamed:@"qrone.png"] forState:UIControlStateNormal];
    qrCodeScanButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    qrCodeScanButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    qrCodeScanButton.titleLabel.numberOfLines = 2;
    [qrCodeScanButton setBackgroundColor:[UIColor blackColor]];
    qrCodeScanButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:qrCodeScanButton];
    
    //Setting Value
//    NSString *url = [self retrieveSetting:@"url" defaultValue:@"https://evolv.idmission.com/IDS/service/integ/idm/thirdparty/upsert"];
    NSString *url = [self retrieveSetting:@"url" defaultValue:@"https://demo.idmission.com/IDS/service/integ/idm/thirdparty/upsert"];
//    NSString *url = [self retrieveSetting:@"url" defaultValue:@"https://lab.idmission.com:9043/IDS/service/integ/idm/thirdparty/upsert"];
    NSString *loginid = [self retrieveSetting:@"loginid"];
    NSString *password = [self retrieveSetting:@"password"];
    NSString *merchantid = [self retrieveSetting:@"merchantid"];
    NSString *productid = [self retrieveSetting:@"productid"];
    NSString *productname = [self retrieveSetting:@"productname" defaultValue:@"Identity_Validation_and_Face_Matching"];
    NSString *language = [self retrieveSetting:@"language" defaultValue:@"en"];
    
    if([@"es" isEqualToString:language]) {
        language = @"Spanish";
    } else if ([@"my" isEqualToString:language]){
        language = @"Myanmar";
    }else {
        language = @"English";
    }
    
    [urlTextField setText:url];
    [loginIdTextField setText:loginid];
    [passwordTextField setText:password];
    [merchantIdField setText:merchantid];
    [productIdTextField setText:productid];
    [productNameTextField setText:productname];
    [languageTextField setText:language];
    
    UIColor *testColor = [urlTextField textColor];
    
    NSLog(@"");
    if(nil == loginid && nil == password && nil == merchantid && nil == productid) {
        [self setEnableDisabled:true];
    } else {
        //        [self setEnableDisabled:false];
        [self setEnableDisabled:true];
    }
    
}
-(void)debugToggleBtn:(UIButton*)button {
    NSLog(@"Debug Additional Feature");
    if(isDebugToggleOn) {
        [toggleButton setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        isDebugToggleOn = false;
    } else {
        [toggleButton setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        isDebugToggleOn = true;
    }
}

-(void)customizedUIToggleBtn:(UIButton*)button {
    NSLog(@"Debug Additional Feature");
    if(isCustomizedConfigUIOn) {
        [toggleButton_customized setImage:[UIImage imageNamed:@"toggleOf.png"] forState:UIControlStateNormal];
        isCustomizedConfigUIOn = false;
    } else {
        [toggleButton_customized setImage:[UIImage imageNamed:@"toggleOn.png"] forState:UIControlStateNormal];
        isCustomizedConfigUIOn = true;
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

-(void)editAccountButton:(UIButton*)button {
    //    [urlTextField setEnabled:true];
    //    [loginIdTextField setEnabled:true];
    //    [passwordTextField setEnabled:true];
    //    [merchantIdField setEnabled:true];
    //    [productIdTextField setEnabled:true];
    //    [productNameTextField setEnabled:true];
    //    [languageTextField setEnabled:true];
    [self setEnableDisabled:true];
}
-(void)saveAccountButton:(UIButton*)button {
    [self checkAndSaveAccountDetails:false];
}

-(bool)checkAndSaveAccountDetails:(bool)isFromContinueBtn {
    
    if([NSStringUtilsDemo  stringIsNilOrEmpty:[[urlTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        if(!isFromContinueBtn) {
            [self snackBarView:[LabelUtils getLabelForKey:@"enter_url"]];
        }
    } else if ([NSStringUtilsDemo  stringIsNilOrEmpty:[[loginIdTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        if(!isFromContinueBtn) {
            [self snackBarView:[LabelUtils getLabelForKey:@"enter_login_id"]];
        }
    } else if([NSStringUtilsDemo  stringIsNilOrEmpty:[[passwordTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        if(!isFromContinueBtn) {
            [self snackBarView:[LabelUtils getLabelForKey:@"enter_password"]];
        }
    } else if([NSStringUtilsDemo  stringIsNilOrEmpty:[[merchantIdField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        if(!isFromContinueBtn) {
            [self snackBarView:[LabelUtils getLabelForKey:@"enter_merchant_id"]];
        }
    } else if([NSStringUtilsDemo  stringIsNilOrEmpty:[[productIdTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        if(!isFromContinueBtn) {
            [self snackBarView:[LabelUtils getLabelForKey:@"enter_product_id"]];
        }
    } else if([NSStringUtilsDemo  stringIsNilOrEmpty:[[productNameTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        if(!isFromContinueBtn) {
            [self snackBarView:[LabelUtils getLabelForKey:@"enter_product_name"]];
        }
    } else if([NSStringUtilsDemo  stringIsNilOrEmpty:[[languageTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        if(!isFromContinueBtn) {
            [self snackBarView:@"Enter Language"];
        }
    } else {
        
        //        [urlTextField setEnabled:false];
        //        [loginIdTextField setEnabled:false];
        //        [passwordTextField setEnabled:false];
        //        [merchantIdField setEnabled:false];
        //        [productIdTextField setEnabled:false];
        //        [productNameTextField setEnabled:false];
        //        [languageTextField setEnabled:false];
        
        //        [self setEnableDisabled:false];
        [self setEnableDisabled:true];
        
        [self saveSetting:@"url" value:[urlTextField text]];
        [self saveSetting:@"loginid" value:[loginIdTextField text]];
        [self saveSetting:@"password" value:[passwordTextField text]];
        [self saveSetting:@"merchantid" value:[merchantIdField text]];
        [self saveSetting:@"productid" value:[productIdTextField text]];
        [self saveSetting:@"productname" value:[productNameTextField text]];
        NSString *lang = @"en";
        if([@"English" isEqualToString:[languageTextField text]]) {
            lang = @"en";
        } else if([@"Spanish" isEqualToString:[languageTextField text]]) {
            lang = @"es";
        }else if([@"Myanmar" isEqualToString:[languageTextField text]]){
            lang = @"my";
        }
        [self saveSetting:@"language" value:lang];
        
        return true;
    }
    
    return false;
}

-(void)setEnableDisabled:(bool)isEnable {
    [urlTextField setEnabled:isEnable];
    [loginIdTextField setEnabled:isEnable];
    [passwordTextField setEnabled:isEnable];
    [merchantIdField setEnabled:isEnable];
    [productIdTextField setEnabled:isEnable];
    [productNameTextField setEnabled:isEnable];
    [languageTextField setEnabled:isEnable];
    
    if(!isEnable) {
        
        [urlTextField setTextColor:[UIColor grayColor]];
        [loginIdTextField setTextColor:[UIColor grayColor]];
        [passwordTextField setTextColor:[UIColor grayColor]];
        [merchantIdField setTextColor:[UIColor grayColor]];
        [productIdTextField setTextColor:[UIColor grayColor]];
        [productNameTextField setTextColor:[UIColor grayColor]];
        [languageTextField setTextColor:[UIColor grayColor]];
        
    } else {
        
        [urlTextField setTextColor:[UIColor blackColor]];
        [loginIdTextField setTextColor:[UIColor blackColor]];
        [passwordTextField setTextColor:[UIColor blackColor]];
        [merchantIdField setTextColor:[UIColor blackColor]];
        [productIdTextField setTextColor:[UIColor blackColor]];
        [productNameTextField setTextColor:[UIColor blackColor]];
        [languageTextField setTextColor:[UIColor blackColor]];
        
    }
}

-(void)qrCodeButton:(UIButton*)button {
    [AppItSDK scanBarcode:self showPortraitBarcodeScreen:true barcodeScanText:[LabelUtils getLabelForKey:@"qr_code_inst"]];
}

-(void)continueButton:(UIButton*)button {
    
    //    if([self checkAndSaveAccountDetails:true]) {
    
    if([self checkAndSaveAccountDetails:false]) {
        [self checkCameraPermission];
        if(isPremissionStatus){
            NSString *url = [ArrayObjectController retrieveSetting:@"url"];
            NSString *loginid = [ArrayObjectController retrieveSetting:@"loginid"];
            NSString *password = [ArrayObjectController retrieveSetting:@"password"];
            NSString *merchantid = [ArrayObjectController retrieveSetting:@"merchantid"];
            NSString *productid = [ArrayObjectController retrieveSetting:@"productid"];
            NSString *productname = [ArrayObjectController retrieveSetting:@"productname"];
            NSString *language = [ArrayObjectController retrieveSetting:@"language"];
            
            [AppItSDK deleteData];
            [self resettingValues];
            [AppItSDK customizeUserInterface:[CustomizeUIConfigManager getCompleteUIConfigDictionary]];
            [AppItSDK initializeAppItSDK:self url:url loginId:loginid password:password merchantID:merchantid productID:productid productName:productname Language:language EnableDebug:isDebugToggleOn enableGPS:false];
            
            //        ProcessFlowController *controller = [self.storyboard    instantiateViewControllerWithIdentifier:@"ProcessFlowController"];
            //        [self.navigationController pushViewController:controller animated:YES];
        }
    } else {
        //        [self snackBarView:@"Save Account Details First"];
    }
}

- (void)resettingValues {
    NSMutableDictionary *additionalDataDict = [NSMutableDictionary new];
    
    [ArrayObjectController setAdditionalDataDictionary:additionalDataDict];
    [ArrayObjectController setAddressDataDictionary:additionalDataDict];
    
    [ArrayObjectController setIdType:@""];
    [ArrayObjectController setCountryType:@""];
    [ArrayObjectController setStateType:@""];
    [ArrayObjectController setSecondaryIdType:@""];
    [ArrayObjectController setSecondaryCountryType:@""];
    [ArrayObjectController setSecondaryStateType:@""];
//    //Clearing Values
//    NSMutableDictionary *callExeParam = [[NSMutableDictionary alloc] init];
//    [callExeParam setObject:@"" forKey:@"Service_ID"];
//    [callExeParam setObject:@"" forKey:@"Manual_Review_Required"];
//    [callExeParam setObject:@"" forKey:@"Bypass_Age_Validation"];
//    [callExeParam setObject:@"" forKey:@"Bypass_Name_Matching"];
//    [callExeParam setObject:@"" forKey:@"Deduplication_Required"];
//    [callExeParam setObject:@"" forKey:@"Need_Immediate_Response"];
    [AppItSDK setCallExecutionParameter: [ArrayObjectController clearCallExecutionParameter]];
}

-(void)scanBarcodeResponse : (NSMutableDictionary*) result {
    if([[result objectForKey:@"statusCode"] isEqualToString:@"0"]) {
        NSLog(@"Barcode Scan Response");
        if([[result objectForKey:@"format"] isEqualToString:@"QR Code"]) {
            NSString *contentData = [result objectForKey:@"content"];
            if([[contentData substringToIndex:1] isEqualToString:@"["]) {
                
                NSData* data = [contentData dataUsingEncoding:NSUTF8StringEncoding];
        
                NSArray *credentialContentArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if([credentialContentArray count] > 0) {
                    NSMutableDictionary *credentialContentDict = [credentialContentArray firstObject];
                    [self setAccountCredentailafromQRcodeResponse:credentialContentDict];
                }
                NSLog(@"");
            }
        }
    }
}

-(void)setAccountCredentailafromQRcodeResponse:(NSMutableDictionary *)accountCredentialDict {
    
    if([accountCredentialDict objectForKey:@"URL"]) {
        [urlTextField setText:[NSString stringWithFormat:@"%@", [accountCredentialDict objectForKey:@"URL"]]];
    }
    if([accountCredentialDict objectForKey:@"LoginId"]) {
        [loginIdTextField setText:[NSString stringWithFormat:@"%@", [accountCredentialDict objectForKey:@"LoginId"]]];
    }
    if([accountCredentialDict objectForKey:@"Password"]) {
        [passwordTextField setText:[NSString stringWithFormat:@"%@", [accountCredentialDict objectForKey:@"Password"]]];
    }
    if([accountCredentialDict objectForKey:@"ProductId"]) {
        [productIdTextField setText:[NSString stringWithFormat:@"%@", [accountCredentialDict objectForKey:@"ProductId"]]];
    }
    if([accountCredentialDict objectForKey:@"MerchantId"]) {
        [merchantIdField setText:[NSString stringWithFormat:@"%@", [accountCredentialDict objectForKey:@"MerchantId"]]];
    }
    if([accountCredentialDict objectForKey:@"PRODUCT_NAME"]) {
        [productNameTextField setText:[NSString stringWithFormat:@"%@", [accountCredentialDict objectForKey:@"PRODUCT_NAME"]]];
    }
}

-(void)initializeSDKResponse : (NSMutableDictionary*) result {
    NSLog(@"");
    NSMutableDictionary *resultDict = [result objectForKey:@"Result"];
    NSMutableDictionary *defaultServiceDict=[AccountSetUpViewController getDefaultService];
    NSMutableDictionary *serviceFromServerDict=[[NSMutableDictionary alloc] init];
    int val = [[result objectForKey:@"StatusCode"] intValue];
    if(val == 0) {
        NSString *serviceId=[resultDict  objectForKey:@"SUBSCRIBED_SDK_SERVICES"];
        NSArray *serverServiceID = [serviceId componentsSeparatedByString: @","];
        NSMutableArray *serverServiceIdList = [NSMutableArray arrayWithCapacity:[serverServiceID count]];
        [serverServiceIdList addObjectsFromArray:serverServiceID];
        if([serverServiceIdList count] == 0) {
            serverServiceIdList = [ArrayObjectController getPrevServiceNumberArray];
        }
        NSMutableArray *savingServiceIdMutableArray = [[NSMutableArray alloc] init]; //Need to save service details to second time initialization call
        for(NSString *service in defaultServiceDict){
            NSString *serviceID= [service substringWithRange:NSMakeRange(0, 3)];
            NSString *trimmedServiceID = [serviceID stringByTrimmingCharactersInSet:
                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if([serverServiceIdList containsObject:trimmedServiceID]){
                [savingServiceIdMutableArray addObject:trimmedServiceID];
                NSString *value = [defaultServiceDict objectForKey:service];
                [serviceFromServerDict setObject:value forKey:service];
            }
        }
        [ArrayObjectController setServiceDetails:serviceFromServerDict];
        [ArrayObjectController setPrevServiceNumberArray:savingServiceIdMutableArray];
        [ArrayObjectController setCustomizedUIConfig:isCustomizedConfigUIOn];
        ProcessFlowController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ProcessFlowController"];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        if(nil != resultDict) {
            //Servers Response
            [self snackBarView:[resultDict objectForKey:@"Status_Message"]];
        } else {
            [self snackBarView:[result objectForKey:@"statusMessage"]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)navigationDrawerBtn:(UIButton*)button {
    NSLog(@"Navigation Drawer Btn clicked");
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
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

-(UIImage*)imageFromColor:(UIColor *)color withSize:(CGSize)sizeImage
{
    UIImage *resultImage = nil;
    
    UIGraphicsBeginImageContext(sizeImage);
    
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0.0f, 0.0f, sizeImage.width, sizeImage.height));
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

-(void)sidePanelBtnClicked : (NSString*) controllerType{
    NSLog(@"Side Panel Button Clicked");
    if([controllerType isEqualToString:@"AccountSetUp"]) {
        
        
    }
    if([controllerType isEqualToString:@"ProcessFlow"]) {
        ProcessFlowController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ProcessFlowController"];
        [self.navigationController pushViewController:controller animated:YES];
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

+(NSMutableDictionary*)getDefaultService{
    NSMutableDictionary *nsDict = [[NSMutableDictionary alloc] init];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_face_match_des"] forKey:[LabelUtils getLabelForKey:@"idv_face_match"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_only_des"] forKey:[LabelUtils getLabelForKey:@"idv_only"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_only_cust_des"] forKey:[LabelUtils getLabelForKey:@"idv_only_cust"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_only_emp_des"] forKey:[LabelUtils getLabelForKey:@"idv_only_emp"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_face_match_cust_des"] forKey:[LabelUtils getLabelForKey:@"idv_face_match_cust"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_face_match_emp_des"] forKey:[LabelUtils getLabelForKey:@"idv_face_match_emp"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"face_match_cus_des"] forKey:[LabelUtils getLabelForKey:@"face_match_cus"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"face_match_only_des"] forKey:[LabelUtils getLabelForKey:@"face_match_only"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"customer_update_service_des"] forKey:[LabelUtils getLabelForKey:@"customer_update_service"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"employee_update_service_des"] forKey:[LabelUtils getLabelForKey:@"employee_update_service"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_face_match_cust_enroll_77_des"] forKey:[LabelUtils getLabelForKey:@"idv_face_match_cust_enroll_77"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_face_match_cust_enroll_78_des"] forKey:[LabelUtils getLabelForKey:@"idv_face_match_cust_enroll_78"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_face_match_cust_minor_des"] forKey:[LabelUtils getLabelForKey:@"idv_face_match_cust_minor"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"customer_verification_des"] forKey:[LabelUtils getLabelForKey:@"customer_verification"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"customer_verification_des"] forKey:[LabelUtils getLabelForKey:@"customer_verification_105"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_video_match_des"] forKey:[LabelUtils getLabelForKey:@"idv_video_match"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_video_match_cust_des"] forKey:[LabelUtils getLabelForKey:@"idv_video_match_cust"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_video_match_emp_des"] forKey:[LabelUtils getLabelForKey:@"idv_video_match_emp"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"cust_enroll_biometrics_des"] forKey:[LabelUtils getLabelForKey:@"cust_enroll_biometrics"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"emp_enroll_biometrics_des"] forKey:[LabelUtils getLabelForKey:@"emp_enroll_biometrics"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"address_processing_des"] forKey:[LabelUtils getLabelForKey:@"address_processing"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"employee_verification_des"] forKey:[LabelUtils getLabelForKey:@"employee_verification"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"employee_verification_des"] forKey:[LabelUtils getLabelForKey:@"employee_verification_305"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"face_match_only_emp_des"] forKey:[LabelUtils getLabelForKey:@"face_match_only_emp"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"create_customer_override_service_des"] forKey:[LabelUtils getLabelForKey:@"create_customer_override_service"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"create_employee_override_service_des"] forKey:[LabelUtils getLabelForKey:@"create_employee_override_service"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"id_validation_face_match_primary_id_des"] forKey:[LabelUtils getLabelForKey:@"id_validation_face_match_primary_id"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"id_validation_face_match_secondary_id_des"] forKey:[LabelUtils getLabelForKey:@"id_validation_face_match_secondary_id"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"otp_generation_des"] forKey:[LabelUtils getLabelForKey:@"otp_generation"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"token_generation_des"] forKey:[LabelUtils getLabelForKey:@"token_generation"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"otp_verification_des"] forKey:[LabelUtils getLabelForKey:@"otp_verification"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"customer_search_des"] forKey:[LabelUtils getLabelForKey:@"customer_search"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"employee_search_des"] forKey:[LabelUtils getLabelForKey:@"employee_search"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"identify_cus_with_biometrics_des"] forKey:[LabelUtils getLabelForKey:@"identify_cus_with_biometrics"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"identify_emp_with_biometrics_des"] forKey:[LabelUtils getLabelForKey:@"identify_emp_with_biometrics"]];
    
    [nsDict setObject:[LabelUtils getLabelForKey:@"video_conference_facematch_des"] forKey:[LabelUtils getLabelForKey:@"video_conference_face_match"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_video_conference_match_des"] forKey:[LabelUtils getLabelForKey:@"idv_video_conference_match"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_video_conference_cust_enroll_des"] forKey:[LabelUtils getLabelForKey:@"idv_video_conference_cust_enroll"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"idv_video_conference_emp_enroll_des"] forKey:[LabelUtils getLabelForKey:@"idv_video_conference_emp_enroll"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"offline_face_service_des"] forKey:[LabelUtils getLabelForKey:@"offline_face_service"]];
    [nsDict setObject:[LabelUtils getLabelForKey:@"auto_fill_service_des"] forKey:@"620 Auto Fill(MRZ, BARCODE)"];
    
    return nsDict;
}

//Run time Permission Asking
-(void) checkCameraPermission {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(status == AVAuthorizationStatusAuthorized) { // authorized
        NSLog(@"Authorized");
        isPremissionStatus=true;
    }
    else if(status == AVAuthorizationStatusDenied){ // denied
        isPremissionStatus=true;
        //        if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType: completionHandler:)]) {
        //            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        //                // Will get here on both iOS 7 & 8 even though camera permissions weren't required
        //                // until iOS 8. So for iOS 7 permission will always be granted.
        //
        //                NSLog(@"DENIED");
        //
        //                if (granted) {
        //                    // Permission has been granted. Use dispatch_async for any UI updating
        //                    // code because this block may be executed in a thread.
        //                    dispatch_async(dispatch_get_main_queue(), ^{
        //                        isPremissionStatus=true;
        //                    });
        //                } else {
        //                    NSLog(@"Not Authorized");
        //                    // Permission has been denied.
        //                    dispatch_async(dispatch_get_main_queue(), ^{
        //                        isPremissionStatus=true;
        //                    });
        //                }
        //            }];
        //       }
    }
    else if(status == AVAuthorizationStatusRestricted){ // restricted
        NSLog(@"Restricted");
        isPremissionStatus=true;
    }
    else if(status == AVAuthorizationStatusNotDetermined){ // not determined
        NSLog(@"NotDetermined");
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                NSLog(@"camera authorized");
                dispatch_async(dispatch_get_main_queue(), ^{
                    isPremissionStatus=false;
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    isPremissionStatus=false;
                });
            }
        }];
    }
}
@end
