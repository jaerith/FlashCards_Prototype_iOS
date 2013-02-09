//
//  PrototypeTwoQuestionController.h
//  BNFCPrototype
//
//  Created by mac on 4/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "PrototypeTwoCardsController.h"

#define kMinimumGestureLength 75
#define kMaximumVariance      150

@interface PrototypeTwoQuestionController : UIViewController {
	
	CGPoint startPoint;
	
	PrototypeTwoCardsController *parentController;
	
	UITextView *questionTextView;
}

- (NSMutableString*) getQuestion;

- (void) setParent:(PrototypeTwoCardsController*)tmpParentController;

- (void) setQuestion:(NSMutableString*)questionText;

@property (nonatomic, retain) PrototypeTwoCardsController *parentController;

@property (nonatomic, retain) IBOutlet UITextView *questionTextView;

@end