//
//  CustomizeUIConfig.m
//  AppItDepedency
//
//  Created by Sanket Garde on 04/06/19.
//  Copyright © 2019 idmission solutions pvt ltd . All rights reserved.
//

#import "CustomizeUIConfig.h"

@implementation CustomizeUIConfig {
    NSMutableDictionary *uiConfiguration, *labelConfiguration;
}

-(NSMutableDictionary *)getUIConfiguration {
    return uiConfiguration;
}
-(void)setUiConfiguration:(NSMutableDictionary*)UIConfiguration {
    uiConfiguration = UIConfiguration;
}

-(NSMutableDictionary *)getLabelConfiguration {
    return labelConfiguration;
}
-(void)setLabelConfiguration:(NSMutableDictionary*)LabelConfiguration {
    labelConfiguration = LabelConfiguration;
}

@end
