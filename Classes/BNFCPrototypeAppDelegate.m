//
//  BNFlashCardPrototypeAppDelegate.m
//  BNFlashCardPrototype
//
//  Created by mac on 2/25/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "BNFCPrototypeAppDelegate.h"

@implementation BNFlashCardPrototypeAppDelegate

@synthesize window;
@synthesize navController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    	
    // Override point for customization after application launch
	[window addSubview:navController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}

@end
