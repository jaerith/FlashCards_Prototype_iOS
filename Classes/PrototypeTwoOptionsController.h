//
//  PrototypeTwoOptionsController.h
//  BNFCPrototype
//
//  Created by mac on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "PrototypeTwoController.h"

@interface PrototypeTwoOptionsController : UIViewController {
	
	PrototypeTwoController *parentController;
	
	UISwitch *leitnerSwitch;
}

- (IBAction) leitnerModeChanged:(id)sender;

- (void) setParent:(PrototypeTwoController*)tmpParentController;

@property (retain, nonatomic) PrototypeTwoController *parentController;

@property (nonatomic, retain) IBOutlet  UISwitch     *leitnerSwitch;

@end
