//
//  BNFlashCardPrototypeAppDelegate.h
//  BNFlashCardPrototype
//
//  Created by mac on 2/25/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NavViewController;

@interface BNFlashCardPrototypeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end

