//
//  PrototypeTwoAnswerController.h
//  BNFCPrototype
//
//  Created by mac on 4/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PrototypeTwoCardsController.h"

#define kMinimumGestureLength 75
#define kMaximumVariance      150

#define kFlagCorrect 0
#define kFlagWrong   1

@interface PrototypeTwoAnswerController : UIViewController {
	
	CGPoint startPoint;
	
	UITextView *answerTextView;
	
	PrototypeTwoCardsController *parentController;
	
	UISegmentedControl *resultFlag;
}

@property (nonatomic, retain) PrototypeTwoCardsController *parentController;

@property (nonatomic, retain) IBOutlet UITextView *answerTextView;

@property (nonatomic, retain) IBOutlet UISegmentedControl *resultFlag;

- (NSMutableString*) getAnswerStatus;

- (void) resetAnswerStatus;

- (void) setAnswer:(NSMutableString*)answerText;

- (void) setParent:(PrototypeTwoCardsController*)tmpParentController;

@end
