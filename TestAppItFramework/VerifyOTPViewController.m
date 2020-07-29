//
//  VerifyOTPViewController.m
//  AppItDepedency
//
//  Created by  on 26/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "VerifyOTPViewController.h"
#import "ArrayObjectController.h"
#import "RootPageViewController.h"
#import "LabelUtils.h"

@interface VerifyOTPViewController ()

@end

@implementation VerifyOTPViewController {
    UITextField *responseOTPField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];
    
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
    [titleLabel setText:[LabelUtils getLabelForKey:@"verify_otp"]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.view addSubview:titleLabel];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, (width/100)*50, (width/100)*0.5)];
    [slideView setBackgroundColor:[ArrayObjectController colorwithHexString:@"#009EA0" alpha:1.0]];
    [self.view addSubview:slideView];
    
    //Select ID Type
   responseOTPField = [[UITextField alloc] initWithFrame:CGRectMake((width/100) * 7, titleLabel.frame.origin.y + titleLabel.frame.size.height + (height/100)*5 , (width/100)*86, (height/100)*7)];
    responseOTPField.textAlignment = UITextAlignmentCenter;
    responseOTPField.layer.cornerRadius = 5;
    responseOTPField.layer.borderWidth = 1.0;
    responseOTPField.layer.borderColor = [[UIColor grayColor]CGColor];
    [responseOTPField setAlpha:0.8];
    [self.view addSubview:responseOTPField];
    
    UILabel *responseOTPLabel = [[UILabel alloc] initWithFrame:CGRectMake(responseOTPField.frame.origin.x + 15, responseOTPField.frame.origin.y - ((height/100)*2), ((responseOTPField.frame.size.width)/100)*35, ((height/100)*4))];
    [responseOTPLabel setText:[LabelUtils getLabelForKey:@"enter_otp"]];
    [responseOTPLabel setFont:[UIFont systemFontOfSize:14]];
    [responseOTPLabel setBackgroundColor:[UIColor whiteColor]];
    [responseOTPLabel setFont:[UIFont systemFontOfSize:13]];
    [responseOTPLabel setTextColor:[UIColor grayColor]];
    [responseOTPLabel setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    [responseOTPLabel setTextAlignment:UITextAlignmentCenter];
    [self.view addSubview:responseOTPLabel];
    
    //Back
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect saveAccountframe = CGRectMake(responseOTPField.frame.origin.x, responseOTPField.frame.origin.y + responseOTPField.frame.size.height + (height/100)*3, (responseOTPField.frame.size.width/100)*48, (height/100)*6);
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
    CGRect editAccountframe = CGRectMake(responseOTPField.frame.origin.x + (responseOTPField.frame.size.width/100)*52, backBtn.frame.origin.y, backBtn.frame.size.width, (height/100)*6);
    [nextBtn setFrame:editAccountframe];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:[LabelUtils getLabelForKey:@"next_capture"] forState:UIControlStateNormal];
    nextBtn.titleLabel.textColor = [UIColor whiteColor];
    [nextBtn addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [nextBtn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:nextBtn];
    
    [responseOTPField setKeyboardType:UIKeyboardTypeNumberPad];
    
}

-(void)backButton:(UIButton*)button {
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setPreviousViewController:[self valueForKey:@"storyboardIdentifier"]];
}

-(void)nextButton:(UIButton*)button {
    
    [ArrayObjectController setResponseType:[[responseOTPField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    RootPageViewController *controller = [ArrayObjectController getPageDelegate];
    [controller setNextViewController:[self valueForKey:@"storyboardIdentifier"]];
}

//Disable keyboard on screen tap
- (void)tapToDismissKeyborad:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
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
