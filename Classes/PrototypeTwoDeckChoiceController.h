//
//  PrototypeTwoDeckChoiceController.h
//  BNFCPrototype
//
//  Created by mac on 4/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PrototypeTwoController;

@interface PrototypeTwoDeckChoiceController : UITableViewController
<UITableViewDelegate, UITableViewDataSource> {
		
	PrototypeTwoController *parentController;
		
	NSMutableString *currentCategory;
	
	NSMutableDictionary *currentDeckNames;
	
	NSMutableString *chosenDeck;
}

- (void) assignCurrentCategory:(NSMutableString*) targetCategory;

- (void) showOptions;

@property (nonatomic, retain) PrototypeTwoController *parentController;

@property (nonatomic, retain) NSMutableString *currentCategory;

@property (nonatomic, retain) NSMutableDictionary *currentDeckNames;

@property (nonatomic, retain) NSMutableString *chosenDeck;

@end
