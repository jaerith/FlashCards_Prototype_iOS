//
//  PrototypeOneResultsController.h
//  BNFCPrototype
//
//  Created by mac on 3/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PrototypeOneController.h"

@interface PrototypeOneResultsController :  UITableViewController
<UITableViewDelegate, UITableViewDataSource> {
	
	NSMutableArray *results;
	
	PrototypeOneController *parentController;
}

@property (nonatomic, retain) NSMutableArray* results;

@property (retain, nonatomic) PrototypeOneController *parentController;

- (void) retrieveData;

- (void) setParent:(PrototypeOneController*)tmpParentController;

@end
