//
//  SnippetViewController.h
//  SDKNewDesign
//
//  Created by  on 03/10/18.
//  Copyright © 2018 com.idmission. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnippetViewController : UIViewController

@property(nonatomic) NSString *titleString;

-(void)setResultData:(NSMutableDictionary*) result;
@end
