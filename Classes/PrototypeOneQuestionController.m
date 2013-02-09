//
//  PrototypeOneQuestionController.m
//  BNFCPrototype
//
//  Created by mac on 2/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PrototypeOneQuestionController.h"

@implementation PrototypeOneQuestionController

@synthesize parentController;

@synthesize questionTextView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
	NSBundle *mainBundle = [NSBundle mainBundle];
	
	if (self = [super initWithNibName:@"PrototypeOneQuestion" bundle:mainBundle]) {
		// Custom initialization
	}
	
	// [self becomeFirstResponder];
	
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
	    return YES;
	}
	else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		return YES;
	}
	else {
		return NO;
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void) decrementPage {
	
	[self.parentController decrementPage];
}

- (NSMutableString*) getQuestion {
	
	NSMutableString *questionText =
	    [[NSMutableString alloc] initWithString:questionTextView.text];
	
	return questionText;
}

- (void) incrementPage {
	
	[self.parentController incrementPage];
}

- (void) setQuestion:(NSMutableString*)questionText {
	
	questionTextView.text = questionText;
}

- (void) setParent:(PrototypeOneCardsController*)tmpParentController {
	
	self.parentController = tmpParentController;
}

#pragma mark -
#pragma mark Touch Handlers
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	
	BOOL typeFlash = NO;
	
	UITouch *touch = [touches anyObject];
	
	NSUInteger tapCount = [touch tapCount];
	CGPoint tmpPoint = [touch locationInView:self.view];
		
	startPoint = tmpPoint;
	
	switch (tapCount) {
	 
		case 2:
			typeFlash = [self.parentController isCurrentDeckTypeFlash];
			
			if (typeFlash) {
				[parentController switchViews:self];
			}
			
			break;
	}
	
	/*
	 // Warning
	 NSString *warningMsg = 
	 [NSString stringWithFormat:@"Center on an interesting location and then hit the search button to bring results.  (NOTE: In order for the GoogleMap controller to work properly, you must have an iPhone or be near an open Wi-Fi port.  If nothing is presented initially, pinch and unpinch to access cached map data."];
	 
	 UIAlertView *alert = 
	 [[UIAlertView alloc] initWithTitle:@"Info" 
	 message:warningMsg delegate:nil 
	 cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	 
	 [alert show];
	 [alert release];	
	 */	
}

/*
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	
	UITouch *touch = [touches anyObject];
		
	CGPoint currPoint = [touch locationInView:self.view];
		
	CGFloat absDeltaX = fabsf(startPoint.x - currPoint.x);
	CGFloat absDeltaY = fabsf(startPoint.y - currPoint.y);
		
	CGFloat deltaX = startPoint.x - currPoint.x;
	CGFloat deltaY = startPoint.y - currPoint.y;
		
	if ((absDeltaX >= kMinimumGestureLength) && (absDeltaY <= kMaximumVariance)) {
			
		if (deltaX > 0.0) {
				
			[parentController incrementPage];
		}
		else {
				
			[parentController decrementPage];
		}			
	}
}
*/

 - (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
 
	 UITouch *touch = [touches anyObject];
	 
	 CGPoint currPoint = [touch locationInView:self.view];
	 
	 CGFloat absDeltaX = fabsf(startPoint.x - currPoint.x);
	 CGFloat absDeltaY = fabsf(startPoint.y - currPoint.y);
	 
	 CGFloat deltaX = startPoint.x - currPoint.x;
	 CGFloat deltaY = startPoint.y - currPoint.y;
	 
	 if ((absDeltaX >= kMinimumGestureLength) && (absDeltaY <= kMaximumVariance)) {
		 
		 if (deltaX > 0.0) {
			 
			 [parentController nextCard:self];
		 }
		 else {
			 
			 [parentController previousCard:self];
		 }			
	 }
}

@end
