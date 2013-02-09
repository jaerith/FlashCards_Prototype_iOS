//
//  PrototypeTwoCardsController.h
//  BNFCPrototype
//
//  Created by mac on 4/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#define kYUpAccelerationThreshold    2.0
#define kYDownAccelerationThreshold -2.0
#define kUpdateInterval             (1.0f/10.0f)

#import <UIKit/UIKit.h>

@class PrototypeTwoQuestionController;
@class PrototypeTwoAnswerController;

#import "PrototypeTwoController.h"

@interface PrototypeTwoCardsController : UIViewController 
<UIAccelerometerDelegate, UIAlertViewDelegate> {
	
	BOOL questionShowing;
	BOOL currentDeckIsTypeFlash;
	BOOL upswingDetected;
	
	PrototypeTwoQuestionController *questionController;
	PrototypeTwoAnswerController *answerController;
	
	NSMutableArray *currentDeck;
	NSNumber *currentCardIndex;
	
	NSMutableString *currQuestion;
	NSMutableString *currAnswer;
	
	PrototypeTwoController *parentController;
	
	UIBarButtonItem* flipButton;
	UIBarButtonItem* backButton;
	UIBarButtonItem* nextButton;
	
	UILabel *timerLabel;
	
	NSTimer *myTicker;
	NSDate  *startTime;
}

@property (retain, nonatomic) PrototypeTwoQuestionController *questionController;
@property (retain, nonatomic) PrototypeTwoAnswerController *answerController;

@property (retain, nonatomic) NSMutableArray *currentDeck;
@property (retain, nonatomic) NSNumber       *currentCardIndex;

@property (retain, nonatomic) NSMutableString *currQuestion;
@property (retain, nonatomic) NSMutableString *currAnswer;

@property (retain, nonatomic) PrototypeTwoController *parentController;

@property (nonatomic, retain) IBOutlet UIBarButtonItem* flipButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* backButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* nextButton;

@property (nonatomic, retain) IBOutlet UILabel *timerLabel;

@property (nonatomic, retain) NSDate *startTime;

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

- (void) setParent:(PrototypeTwoController*)tmpParentController;

- (void) updateTimerLabel;

-(IBAction)curlPageBack:(id)sender;

-(IBAction)curlPageForward:(id)sender;

-(IBAction)switchViews:(id)sender;

-(IBAction)switchViewsClick:(id)sender;

-(IBAction)previousCard:(id)sender;

-(IBAction)nextCard:(id)sender;

@end
