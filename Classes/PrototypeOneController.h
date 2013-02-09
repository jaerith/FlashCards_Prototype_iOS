//
//  PrototypeOneController.h
//  BNFlashCardPrototype
//
//  Created by mac on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PrototypeOneDeckController;
@class PrototypeOneCardsController;

@interface PrototypeOneController : 
    UITabBarController <UIAlertViewDelegate> {
	
	NSMutableArray* mathCardDeck;
	NSMutableArray* historyCardDeck;
	NSMutableArray* scienceCardDeck;
	NSMutableArray* shakespeareCardDeck;
	
	NSMutableDictionary *deckTypes;
	
	NSMutableDictionary* mathDeckResults;
	NSMutableDictionary* historyDeckResults;
	NSMutableDictionary* scienceDeckResults;
	
	NSMutableDictionary* deckTimings;
	NSMutableDictionary* deckBestTimings;
	
	NSMutableString* currentDeckName;
		
	PrototypeOneDeckController  *deckController;
	PrototypeOneCardsController *cardsController;	
}

- (void) addDeckResult:(NSMutableString*)question
			cardStatus:(NSMutableString*)status;

- (NSMutableArray*)  getCurrentDeck;

- (NSMutableString*) getCurrentDeckName;

- (NSString*) getCurrentDeckType;

- (NSMutableArray*) getResultsData;

- (void) initCardDecks;

- (BOOL) isLeitnerModeOn;

- (void) setCurrentDeck:(NSMutableString*)deckNameChoice;

- (void) setCurrentDeckTiming:(NSTimeInterval)deckTiming;

- (void) showResults;

- (void) tabToCardView;
		 
@property (nonatomic, retain) NSMutableArray* mathCardDeck;
@property (nonatomic, retain) NSMutableArray* historyCardDeck;
@property (nonatomic, retain) NSMutableArray* scienceCardDeck;
@property (nonatomic, retain) NSMutableArray* shakespeareCardDeck;

@property (nonatomic, retain) NSMutableDictionary *deckTypes;

@property (nonatomic, retain) NSMutableDictionary *mathDeckResults;
@property (nonatomic, retain) NSMutableDictionary *historyDeckResults;
@property (nonatomic, retain) NSMutableDictionary *scienceDeckResults;

@property (nonatomic, retain) NSMutableDictionary *deckTimings;
@property (nonatomic, retain) NSMutableDictionary *deckBestTimings;

@property (nonatomic, retain) NSMutableString* currentDeckName;

@property (nonatomic, retain) PrototypeOneDeckController  *deckController;
@property (nonatomic, retain) PrototypeOneCardsController *cardsController;

@end
