//
//  PrototypeTwoResultsController.h
//  BNFCPrototype
//
//  Created by mac on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "PrototypeTwoController.h"

@interface PrototypeTwoResultsController :  UITableViewController
<UITableViewDelegate, UITableViewDataSource> {
	
	NSMutableArray *results;
	
	PrototypeTwoController *parentController;
}

@property (nonatomic, retain) NSMutableArray* results;

@property (retain, nonatomic) PrototypeTwoController *parentController;

- (void) retrieveData;

- (void) setParent:(PrototypeTwoController*)tmpParentController;

@end
