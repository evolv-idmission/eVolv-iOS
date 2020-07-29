//
//  CustomizeUIConfig.h
//  AppItDepedency
//
//  Created by Sanket Garde on 04/06/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomizeUIConfig : NSObject

@property(nonatomic) NSMutableDictionary *uiConfiguration;
@property(nonatomic) NSMutableDictionary *labelConfiguration;

-(NSMutableDictionary *)getUIConfiguration;
-(void)setUiConfiguration:(NSMutableDictionary*)UIConfiguration;

-(NSMutableDictionary *)getLabelConfiguration;
-(void)setLabelConfiguration:(NSMutableDictionary*)LabelConfiguration;

@end


