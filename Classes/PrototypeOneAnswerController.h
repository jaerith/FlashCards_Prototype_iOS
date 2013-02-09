//
//  PrototypeOneAnswerController.h
//  BNFCPrototype
//
//  Created by mac on 2/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PrototypeOneCardsController.h"

#define kMinimumGestureLength 75
#define kMaximumVariance      150

#define kFlagCorrect 0
#define kFlagWrong   1

@interface PrototypeOneAnswerController : UIViewController {
	
	CGPoint startPoint;
	
	UITextView *answerTextView;
	
	PrototypeOneCardsController *parentController;
	
	UISegmentedControl *resultFlag;
}

@property (nonatomic, retain) PrototypeOneCardsController *parentController;

@property (nonatomic, retain) IBOutlet UITextView *answerTextView;

@property (nonatomic, retain) IBOutlet UISegmentedControl *resultFlag;

- (NSMutableString*) getAnswerStatus;

- (void) resetAnswerStatus;

- (void) setAnswer:(NSMutableString*)answerText;

- (void) setParent:(PrototypeOneCardsController*)tmpParentController;

@end
