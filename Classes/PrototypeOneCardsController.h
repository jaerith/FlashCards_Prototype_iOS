//
//  PrototypeOneCardsController.h
//  BNFlashCardPrototype
//
//  Created by mac on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#define kYUpAccelerationThreshold    2.0
#define kYDownAccelerationThreshold -2.0
#define kUpdateInterval             (1.0f/10.0f)

#import <UIKit/UIKit.h>

@class PrototypeOneQuestionController;
@class PrototypeOneAnswerController;

#import "PrototypeOneController.h"

@interface PrototypeOneCardsController : UIViewController 
    <UIAccelerometerDelegate, UIAlertViewDelegate> {

	BOOL questionShowing;
	BOOL currentDeckIsTypeFlash;
	BOOL upswingDetected;
		
	PrototypeOneQuestionController *questionController;
	PrototypeOneAnswerController *answerController;
	
	NSMutableArray *currentDeck;
	NSNumber *currentCardIndex;
	
	NSMutableString *currQuestion;
	NSMutableString *currAnswer;
	
	PrototypeOneController *parentController;
	
	UIBarButtonItem* flipButton;
	UIBarButtonItem* backButton;
	UIBarButtonItem* nextButton;
		
	UILabel *timerLabel;
	
	NSTimer *myTicker;
	NSDate  *startTime;
}

@property (retain, nonatomic) PrototypeOneQuestionController *questionController;
@property (retain, nonatomic) PrototypeOneAnswerController *answerController;

@property (retain, nonatomic) NSMutableArray *currentDeck;
@property (retain, nonatomic) NSNumber       *currentCardIndex;

@property (retain, nonatomic) NSMutableString *currQuestion;
@property (retain, nonatomic) NSMutableString *currAnswer;

@property (retain, nonatomic) PrototypeOneController *parentController;

@property (nonatomic, retain) IBOutlet UIBarButtonItem* flipButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* backButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* nextButton;

@property (nonatomic, retain) IBOutlet UILabel *timerLabel;

@property (nonatomic, retain) NSDate *startTime;

-(id)initWithTabBar:(NSString*)viewType;

- (void) assignCurrentDeck:(NSMutableArray*)tmpCurrentDeck;

- (void) calculateDurationTime;

- (void) decrementPage;

- (void) initStartTime;

- (BOOL) isCurrentDeckTypeFlash;

- (void) incrementPage;

- (void) moveCurrentCardToEnd;

- (void) nullStartTime;

- (void) shuffleCards;

- (void) setCurrentCard:(NSNumber*)currCardIndex;

- (void) setParent:(PrototypeOneController*)tmpParentController;

- (void) updateTimerLabel;

-(IBAction)switchViews:(id)sender;

-(IBAction)switchViewsClick:(id)sender;

-(IBAction)previousCard:(id)sender;

-(IBAction)nextCard:(id)sender;

@end
