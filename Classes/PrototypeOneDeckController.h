//
//  PrototypeOneDeckController.h
//  BNFlashCardPrototype
//
//  Created by mac on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PrototypeOneController.h"

#define kMathDeck        0
#define kHistoryDeck     1
#define kScienceDeck     2
#define kShakespeareDeck 3

@interface PrototypeOneDeckController : UIViewController 
<UIPickerViewDataSource, UIPickerViewDelegate>{

	UIPickerView *deckPicker;
	
	UISwitch *leitnerSwitch;

	PrototypeOneController *parentController;
}

- (IBAction) selectDeck;

- (IBAction) gotoDeck;

-(id)initWithTabBar:(NSString*)viewType;

- (void) setParent:(PrototypeOneController*)tmpParentController;

@property (nonatomic, retain) PrototypeOneController *parentController;

@property (nonatomic, retain) IBOutlet 	UIPickerView *deckPicker;

@property (nonatomic, retain) IBOutlet  UISwitch     *leitnerSwitch;

@end
