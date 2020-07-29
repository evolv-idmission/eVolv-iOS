//
//  GenerateOTPViewController.m
//  AppItDepedency
//
//  Created by  on 26/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "GenerateOTPViewController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "LabelUtils.h"

@interface GenerateOTPViewController ()

@end

@implementation GenerateOTPViewController {
    NSArray *_selectedPickerData;
    NSArray *langFieldPickerData;
    UIPickerView *myPickerView;
    UITextField *notiTypeTextField;
    UITextField *emailIdTextField;
    UITextField *mobNumTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    
    langFieldPickerData = @[@"EMAIL", @"SMS", @"BOTH"];
    
    _selectedPickerData = @[@"EMAIL", @"SMS", @"BOTH"];

    UITapGestureRecognizer *tapGestureRecognizerForView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyborad:)];
    tapGestureRecognizerForView.numberOfTapsRequired = 1;
    tapGestureRecognizerForView.enabled = YES;
    tapGestureRecognizerForView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizerForView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - (width/100)*25, (height/100)*0, width - (width/100)*50, (width/100)*10)];
    //[titleLabel setText:[[NSString alloc]initWithFormat:@"%@",@"IDCaptureFront"]];
//    [titleLabel setText:[[NSString alloc]initWithFormat:@"%@",[ArrayObjectController getTitleStringForDictionary]]];
    [titleLabel setText:[LabelUtils getLabelForKey:@"generate_otp"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    
    //Select ID Type
    emailIdTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, titleLabel.frame.origin.y + titleLabel.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    emailIdTextField.textAlignment = UITextAlignmentCenter;
    emailIdTextField.layer.cornerRadius = 5;
    emailIdTextField.layer.borderWidth = 1.0;
    emailIdTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [emailIdTextField setAlpha:0.8];
    [self.view addSubview:emailIdTextField];
    
    UILabel *emailIdTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(emailIdTextField.frame.origin.x + 15, emailIdTextField.frame.origin.y - ((height/100)*2), ((emailIdTextField.frame.size.width)/100)*35, ((height/100)*4))];
    [emailIdTypeLabel setText:[LabelUtils getLabelForKey:@"enter_email_id"]];
    [emailIdTypeLabel setFont:[UIFont systemFontOfSize:14]];
    [emailIdTypeLabel setBackgroundColor:[UIColor whiteColor]];
    [emailIdTypeLabel setFont:[UIFont systemFontOfSize:13]];
    [emailIdTypeLabel setTextColor:[UIColor grayColor]];
    [emailIdTypeLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [emailIdTypeLabel setTextAlignment:UITextAlignmentCenter];
    [self.view addSubview:emailIdTypeLabel];
    
    mobNumTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,emailIdTextField.frame.origin.y + emailIdTextField.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    mobNumTextField.textAlignment = UITextAlignmentCenter;
    mobNumTextField.layer.cornerRadius = 5;
    mobNumTextField.layer.borderWidth = 1.0;
    mobNumTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [mobNumTextField setAlpha:0.8];
    [self.view addSubview:mobNumTextField];
    
    UILabel *emailIDTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(mobNumTextField.frame.origin.x + 15, mobNumTextField.frame.origin.y - ((height/100)*2), ((mobNumTextField.frame.size.width)/100)*38, ((height/100)*4))];
    [emailIDTypeLabel setText:[LabelUtils getLabelForKey:@"enter_mobile_number"]];
    [emailIDTypeLabel setFont:[UIFont systemFontOfSize:14]];
    [emailIDTypeLabel setBackgroundColor:[UIColor whiteColor]];
    [emailIDTypeLabel setFont:[UIFont systemFontOfSize:13]];
    [emailIDTypeLabel setTextColor:[UIColor grayColor]];
    [emailIDTypeLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [emailIDTypeLabel setTextAlignment:UITextAlignmentCenter];
    [self.view addSubview:emailIDTypeLabel];
    
    notiTypeTextField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7,mobNumTextField.frame.origin.y + mobNumTextField.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    notiTypeTextField.textAlignment = UITextAlignmentCenter;
    notiTypeTextField.layer.cornerRadius = 5;
    notiTypeTextField.layer.borderWidth = 1.0;
    notiTypeTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    [notiTypeTextField setAlpha:0.8];
    [self.view addSubview:notiTypeTextField];
    
    UILabel *notiTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(notiTypeTextField.frame.origin.x + 15, notiTypeTextField.frame.origin.y - ((height/100)*2), ((notiTypeTextField.frame.size.width)/100)*38, ((height/100)*4))];
    [notiTypeLabel setText:[LabelUtils getLabelForKey:@"select_notification_type"]];
    [notiTypeLabel setFont:[UIFont systemFontOfSize:14]];
    [notiTypeLabel setBackgroundColor:[UIColor whiteColor]];
    [notiTypeLabel setFont:[UIFont systemFontOfSize:13]];
    [notiTypeLabel setTextColor:[UIColor grayColor]];
    [notiTypeLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [notiTypeLabel setTextAlignment:UITextAlignmentCenter];
    [self.view addSubview:notiTypeLabel];
    
    //Down Arrow Image
    UIImageView *downArrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(notiTypeTextField.frame.origin.x + notiTypeTextField.frame.size.width - (width/100)*9 , notiTypeTextField.frame.origin.y + (notiTypeTextField.frame.size.height/2) - (height/100)*2, (width/100)*7, (height/100)*4)];
    [downArrowImage setImage:[UIImage imageNamed:@"drop_down.png"]];
    [self.view addSubview:downArrowImage];
    
    //Back
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(notiTypeTextField.frame.origin.x, notiTypeTextField.frame.origin.y + notiTypeTextField.frame.size.height + (height/100)*3, (notiTypeTextField.frame.size.width/100)*48, (height/100)*6);
    [backBtn setFrame:saveAccountframe];
    backBtn.layer.cornerRadius = 20;
    backBtn.clipsToBounds = YES;
    [backBtn setTitle:[LabelUtils getLabelForKey:@"back_capture"] forState:UIControlStateNormal];
    backBtn.titleLabel.textColor = [UIColor whiteColor];
    [backBtn setBackgroundColor:[UIColor blackColor]];
    [backBtn addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:backBtn];
    
    //Next
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake(notiTypeTextField.frame.origin.x + (notiTypeTextField.frame.size.width/100)*52, backBtn.frame.origin.y, backBtn.frame.size.width, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:nextBtn];
    
    [mobNumTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [myPickerView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    myPickerView.layer.borderWidth = 1.0;
    myPickerView.layer.cornerRadius = 5.0;
    myPickerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [notiTypeTextField setInputView:myPickerView];
    [notiTypeTextField setText:langFieldPickerData[0]];
}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    
    [ArrayObjectController setemailId:[[emailIdTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    [ArrayObjectController setMobNum:[[mobNumTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    [ArrayObjectController setNotType:[[notiTypeTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
}

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

//Picker Data Changes Start
-(void)pickerDoneClicked{
    NSLog(@"Picker Done Clicked!");
    [notiTypeTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == notiTypeTextField){
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
        [notiTypeTextField setText:langFieldPickerData[row]];
        [notiTypeTextField setTag:row+1];
    }
}
//Picker Changes End

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
