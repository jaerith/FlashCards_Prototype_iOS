//
//  PrototypeOneQuestionController.h
//  BNFCPrototype
//
//  Created by mac on 2/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PrototypeOneCardsController.h"

#define kMinimumGestureLength 75
#define kMaximumVariance      150

@interface PrototypeOneQuestionController : UIViewController {
	
	CGPoint startPoint;
	
	PrototypeOneCardsController *parentController;
		
	UITextView *questionTextView;
}

- (NSMutableString*) getQuestion;

- (void) setParent:(PrototypeOneCardsController*)tmpParentController;

- (void) setQuestion:(NSMutableString*)questionText;

@property (nonatomic, retain) PrototypeOneCardsController *parentController;

@property (nonatomic, retain) IBOutlet UITextView *questionTextView;

@end
