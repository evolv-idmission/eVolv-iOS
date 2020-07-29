//
//  UINavigationController+Orientation.m
//  AppItDepedency
//
//  Created by  on 13/11/18.
//  Copyright © 2018 idmission solutions pvt ltd . All rights reserved.
//

#import "UINavigationController+Orientation.h"

@implementation UINavigationController (Orientation)

-(NSUInteger)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

@end
