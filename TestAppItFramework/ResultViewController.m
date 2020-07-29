//
//  ResultViewController.m
//  AppItDepedency
//
//  Created by  on 19/10/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "ResultViewController.h"
#import "ArrayObjectController.h"
#import "SidePanelController.h"
#import "AccountSetUpViewController.h"
#import "ProcessFlowController.h"
#import "AppDelegate.h"
#import "ReqResViewController.h"
#import "LabelUtils.h"

@interface ResultViewController ()

@end

@implementation ResultViewController {
    UIImageView *infoImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[ArrayObjectController colorwithHexString:@"#E3F6F3" alpha:1.0]];
    
//    NSLog(@"*****7 Bef UI Ren: %@",[AppItSDK stringFromTimeInterval]);
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    int iPhoneXPadding = 0;
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        NSLog(@"iPhone");
        int height = (int)[[UIScreen mainScreen] nativeBounds].size.height;
        int width = (int)[[UIScreen mainScreen] nativeBounds].size.width;
        
        switch (height) {
        
            case 2436:
                //"iPhone X"
                iPhoneXPadding = 30;
                break;
            case 2688:
                //iPhoneXMAx
                iPhoneXPadding = 30;
                break;
            case 1792:
                //iPhoneXR
                iPhoneXPadding = 30;
                break;
        }
    }

    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height - (height/100)*10 - navigationHeight - iPhoneXPadding)];
    scrollView.showsVerticalScrollIndicator=YES;
    [scrollView setScrollEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:YES];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView];

    NSMutableDictionary *demoChk = [[NSMutableDictionary alloc] init];
    [demoChk setObject:@"First Key" forKey:@"First Vaue"];
    [demoChk setObject:@"Second Key" forKey:@"Second Vaue"];
    [demoChk setObject:@"Third Key" forKey:@"Third Vaue"];
    [demoChk setObject:@"Four Key" forKey:@"Four Vaue"];
    __block float additionalHeight = 0;
    
    //For Sorted result
//    NSArray *sortedKeys = [[_resultDictionary allKeys] sortedArrayUsingSelector: @selector(compare:)];
    
    for (id object in _linearKeyArray) {
        UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*5, (height/100)*3 + additionalHeight, (width/100)*45 , (height/100)*8)];
        [keyLabel setBackgroundColor:[UIColor whiteColor]];
        [keyLabel setText:[NSString stringWithFormat:@"  %@",object]];
        [keyLabel setAlpha:0.7];
        [keyLabel setFont:[UIFont systemFontOfSize:12]];
        keyLabel.numberOfLines = 0;
        keyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [scrollView addSubview:keyLabel];
        
        UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(keyLabel.frame.origin.x + keyLabel.frame.size.width + (width/100)*1, keyLabel.frame.origin.y, keyLabel.frame.size.width, keyLabel.frame.size.height)];
        [resultLabel setBackgroundColor:[UIColor whiteColor]];
        [resultLabel setText:[NSString stringWithFormat:@"  %@",[_resultDictionary objectForKey:object]]];
        [resultLabel setAlpha:0.7];
        [resultLabel setFont:[UIFont systemFontOfSize:12]];
        resultLabel.numberOfLines = 0;
        resultLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [scrollView addSubview:resultLabel];
        
        additionalHeight = keyLabel.frame.origin.y + keyLabel.frame.size.height + (width/100)*1 - (height/100)*3;
    }
    //  Sorted Result End
    
    // For Un Sorted
    //_resultDictionary
//    [_resultDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        NSLog(@"%@->%@",key,obj);
//
//        UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake((width/100)*5, (height/100)*3 + additionalHeight, (width/100)*45 , (height/100)*8)];
//        [keyLabel setBackgroundColor:[UIColor whiteColor]];
//        [keyLabel setText:[NSString stringWithFormat:@"  %@",key]];
//        [keyLabel setAlpha:0.7];
//        [keyLabel setFont:[UIFont systemFontOfSize:12]];
//        keyLabel.numberOfLines = 0;
//        keyLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [scrollView addSubview:keyLabel];
//
//        UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(keyLabel.frame.origin.x + keyLabel.frame.size.width + (width/100)*1, keyLabel.frame.origin.y, keyLabel.frame.size.width, keyLabel.frame.size.height)];
//        [resultLabel setBackgroundColor:[UIColor whiteColor]];
//        [resultLabel setText:[NSString stringWithFormat:@"  %@",obj]];
//        [resultLabel setAlpha:0.7];
//        [resultLabel setFont:[UIFont systemFontOfSize:12]];
//        resultLabel.numberOfLines = 0;
//        resultLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [scrollView addSubview:resultLabel];
//
//        additionalHeight = keyLabel.frame.origin.y + keyLabel.frame.size.height + (width/100)*1 - (height/100)*3;
//    }];
    //For UnSorted Ends

    [scrollView setContentSize:CGSizeMake(width, additionalHeight + (height/100)*10)];
    
    //Save Account
    UIButton *rawDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    CGRect saveAccountframe = CGRectMake(width/2 - (width/100)*45, languageTextField.frame.origin.y + productNameTextField.frame.size.height + (height/100)*5, urlTextField.frame.size.width/2 - (urlTextField.frame.size.width/100) * 2, (width/100)*15);
    CGRect saveAccountframe = CGRectMake((width/100)*3, scrollView.frame.origin.y + scrollView.frame.size.height + (height/100)*1,width/100*45, (height/100)*6);
    [rawDataButton setFrame:saveAccountframe];
    rawDataButton.layer.cornerRadius = 20;
    rawDataButton.clipsToBounds = YES;
    [rawDataButton setTitle:[LabelUtils getLabelForKey:@"show_result_raw_data"] forState:UIControlStateNormal];
    [rawDataButton addTarget:self action:@selector(showRawDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rawDataButton.titleLabel.textColor = [UIColor whiteColor];
    [rawDataButton setBackgroundColor:[UIColor blackColor]];
    [rawDataButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    rawDataButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    rawDataButton.titleLabel.numberOfLines = 2;
    rawDataButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:rawDataButton];
    
//    //Info Image
//    infoImage = [[UIImageView alloc] initWithFrame:CGRectMake(rawDataButton.frame.origin.x + rawDataButton.frame.size.width - (width/100)*9 , rawDataButton.frame.origin.y + (rawDataButton.frame.size.height/2) - (height/100)*1.5, (width/100)*5, (height/100)*3)];
//    [infoImage setImage:[UIImage imageNamed:@"info_white.png"]];
//    [self.view addSubview:infoImage];
    
    //Edit Account
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect editAccountframe = CGRectMake((width/100)*52, rawDataButton.frame.origin.y, rawDataButton.frame.size.width, (height/100)*6);
    [doneButton setFrame:editAccountframe];
    doneButton.layer.cornerRadius = 20;
    doneButton.clipsToBounds = YES;
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTitle:[LabelUtils getLabelForKey:@"done"] forState:UIControlStateNormal];
    doneButton.titleLabel.textColor = [UIColor whiteColor];
    [doneButton setBackgroundColor:[UIColor blackColor]];
    [doneButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:doneButton];
    
//    NSLog(@"*****8 Aft UI Ren: %@",[AppItSDK stringFromTimeInterval]);
}

-(void)doneButton:(UIButton*)button {
    if(![ArrayObjectController getClearFormKey]) {
        [ArrayObjectController setIsContinueProcess:true];
        ProcessFlowController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ProcessFlowController"];
        [self.navigationController pushViewController:controller animated:YES];
        
    } else {
        [ArrayObjectController setIsContinueProcess:false];
        AccountSetUpViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountSetUpViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(void)showRawDataBtnClick:(UIButton*)button {
    NSLog(@"");
    [ArrayObjectController setIsContinueProcess:false];
    ReqResViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ReqResController"];
    controller.requestResponseType = _reqResponseRawData;
    [self.navigationController pushViewController:controller animated:YES];
    
}


-(void)viewDidAppear:(BOOL)animated {

    //Initializa label dictionary
    [LabelUtils initializeCurrentLabels:[self retrieveSetting:@"language" defaultValue:@"en"]];

    [self navigationCode];
}

-(void)navigationCode {
    int width = self.view.frame.size.width;
    self.navigationController.navigationBar.clipsToBounds = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    self.navigationItem.titleView = label;
    label.text = [LabelUtils getLabelForKey:@"result"];
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

-(void)navigationDrawerBtn:(UIButton*)button {
    
    [ArrayObjectController setIsContinueProcess:false];
    
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

-(void)sidePanelBtnClicked : (NSString*) controllerType{
    NSLog(@"Side Panel Button Clicked");
    
    if([controllerType isEqualToString:@"AccountSetUP"]) {
        AccountSetUpViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountSetUpViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if([controllerType isEqualToString:@"ProcessFlow"]) {
        ProcessFlowController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ProcessFlowController"];
        [self.navigationController pushViewController:controller animated:YES];
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
