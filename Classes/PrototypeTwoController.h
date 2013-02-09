//
//  PrototypeTwoController.h
//  BNFCPrototype
//
//  Created by mac on 4/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PrototypeTwoCardsController;

@interface PrototypeTwoController : UITableViewController
<UITableViewDelegate, UITableViewDataSource> {
	
	BOOL            leitnerMode;
	
	NSMutableArray* mathCardDeck;
	NSMutableArray* historyCardDeck;
	NSMutableArray* scienceCardDeck;
	NSMutableArray* shakespeareCardDeck;
	NSMutableArray* shakespeareCardDeck2;
	NSMutableArray* shakespeareCardDeck3;
	
	NSMutableDictionary *deckTypes;
	
	NSMutableDictionary  *categoryDeckNames;
	
	NSMutableDictionary* mathDeckResults;
	NSMutableDictionary* historyDeckResults;
	NSMutableDictionary* scienceDeckResults;
	
	NSMutableDictionary* deckTimings;
	NSMutableDictionary* deckBestTimings;
	
	NSMutableString* currentCategory;	
	NSMutableString* currentDeckName;
	
	// PrototypeOneDeckController  *deckController;
	PrototypeTwoCardsController *cardsController;
	
	NSArray *controllers;
}

- (void) addDeckResult:(NSMutableString*)question
			cardStatus:(NSMutableString*)status;

- (NSMutableDictionary*) retrieveCategoryDeckNames;

- (NSMutableArray*)  getCurrentDeck;

- (NSMutableString*) getCurrentDeckName;

- (NSString*) getCurrentDeckType;

- (NSMutableDictionary*) getDeckTypes;

- (NSMutableArray*) getResultsData;

- (void) initCardDecks;

- (BOOL) isLeitnerModeOn;

- (void) moveToCardView;

- (void) setCurrentDeck:(NSMutableString*)deckNameChoice;

- (void) setCurrentDeckTiming:(NSTimeInterval)deckTiming;

- (void) setLeitnerMode:(BOOL)newMode;

- (void) showResults;

@property (nonatomic, retain) NSMutableArray* mathCardDeck;
@property (nonatomic, retain) NSMutableArray* historyCardDeck;
@property (nonatomic, retain) NSMutableArray* scienceCardDeck;
@property (nonatomic, retain) NSMutableArray* shakespeareCardDeck;
@property (nonatomic, retain) NSMutableArray* shakespeareCardDeck2;
@property (nonatomic, retain) NSMutableArray* shakespeareCardDeck3;

@property (nonatomic, retain) NSMutableDictionary *deckTypes;

@property (nonatomic, retain) NSMutableDictionary *categoryDeckNames;

@property (nonatomic, retain) NSMutableDictionary *mathDeckResults;
@property (nonatomic, retain) NSMutableDictionary *historyDeckResults;
@property (nonatomic, retain) NSMutableDictionary *scienceDeckResults;

@property (nonatomic, retain) NSMutableDictionary *deckTimings;
@property (nonatomic, retain) NSMutableDictionary *deckBestTimings;

@property (nonatomic, retain) NSMutableString* currentCategory;
@property (nonatomic, retain) NSMutableString* currentDeckName;

// @property (nonatomic, retain) PrototypeOneDeckController  *deckController;
@property (nonatomic, retain) PrototypeTwoCardsController *cardsController;

@property (nonatomic, retain) NSArray* controllers;

@end
