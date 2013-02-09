//
//  PrototypeOneCardsController.m
//  BNFlashCardPrototype
//
//  Created by mac on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>

#import "BNFCPrototypeAppDelegate.h"
#import "PrototypeOneCardsController.h"
#import "PrototypeOneQuestionController.h"
#import "PrototypeOneAnswerController.h"

@implementation PrototypeOneCardsController

@synthesize questionController;
@synthesize answerController;

@synthesize currentDeck;
@synthesize currentCardIndex;

@synthesize currQuestion;
@synthesize currAnswer;

@synthesize parentController;

@synthesize flipButton;
@synthesize backButton;
@synthesize nextButton;

@synthesize timerLabel;

@synthesize startTime;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
	NSBundle *mainBundle = [NSBundle mainBundle];
	
	if (self = [super initWithNibName:@"PrototypeOneCards" bundle:mainBundle]) {
		// Custom initialization
	}
	
	questionShowing        = YES;
	currentDeckIsTypeFlash = YES;
	upswingDetected        = NO;
	
	myTicker  = nil;
	startTime = nil;
	
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
		
	PrototypeOneQuestionController *tmpQuestionController =
	    [[PrototypeOneQuestionController alloc] initWithNibName:@"PrototypeOneQuestion" bundle:nil];
	
	[tmpQuestionController setParent:self];
	
	self.questionController = tmpQuestionController;
	
	PrototypeOneAnswerController *tmpAnswerController =
	    [[PrototypeOneAnswerController alloc] initWithNibName:@"PrototypeOneAnswer" bundle:nil];
	
	[tmpAnswerController setParent:self];
	
	self.answerController = tmpAnswerController;
	
	[self.view insertSubview:tmpQuestionController.view atIndex:0];
	
	[tmpQuestionController release];
	[tmpAnswerController release];
	
	self.currentCardIndex = [[NSNumber alloc] initWithInt:0];	
	
	currQuestion = [[NSMutableString alloc] initWithString:@""];
	currAnswer   = [[NSMutableString alloc] initWithString:@""];
	
	[self assignCurrentDeck:[self.parentController getCurrentDeck]];
	
	UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];	
	accel.delegate = self;
	accel.updateInterval = kUpdateInterval;
	
    [super viewDidLoad];
}

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
	
	[questionController release];
	[answerController release];
	
    [super dealloc];
}

-(id)initWithTabBar:(NSString*)viewType {
	
	if ([self init]) {
		
		//this is the label on the tab button itself
		self.title = viewType;
		
		// UIImage* imageClassic = [UIImage imageNamed:@"parthenon_icon.png"];
		// self.tabBarItem.image = imageClassic;
		
		//use whatever image you want and add it to your project
		self.tabBarItem.image = [UIImage imageNamed:@"CardIcon.png"];
		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title=viewType;
	}
	
	return self;
}

- (void) alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
		[self calculateDurationTime];
	}
}

- (void) calculateDurationTime {
	
	NSDate *endTime = [[NSDate alloc] init];
	[endTime timeIntervalSinceReferenceDate];
	
	NSTimeInterval duration = [endTime timeIntervalSinceDate:self.startTime];
	
	[parentController setCurrentDeckTiming:duration];
	
	[self nullStartTime];
}

- (void) initStartTime {
	
	self.startTime = [[NSDate alloc] init];
	[startTime timeIntervalSinceReferenceDate];
	
	self.timerLabel.text = @"00.00";
	
	myTicker = 
		[NSTimer scheduledTimerWithTimeInterval:0.111 
			target:self 
			selector:@selector(updateTimerLabel) 
			userInfo:nil repeats:YES];
}

- (void) setCurrentCard:(NSNumber*)currCardIndex {

	NSMutableString *currCard = [currentDeck objectAtIndex:[currCardIndex intValue]];
	
	NSArray *cardData = [currCard componentsSeparatedByString:@"|"];

	[currQuestion setString:[cardData objectAtIndex:0]];
	[currAnswer   setString:[cardData objectAtIndex:1]];
	
	[self.questionController setQuestion:currQuestion];
	[self.answerController   setAnswer:currAnswer];
}

- (void) assignCurrentDeck:(NSMutableArray*)tmpCurrentDeck {
	
	if (self.currentDeck == nil) {
		self.currentDeck = [[NSMutableArray alloc] init];
	}
	
	[self.currentDeck removeAllObjects];
	[self.currentDeck addObjectsFromArray:tmpCurrentDeck];
	
	self.currentCardIndex = [[NSNumber alloc] initWithInt:0];
		
	[self setCurrentCard:self.currentCardIndex];
	
	NSString* currentDeckType = [self.parentController getCurrentDeckType];
	if ([currentDeckType isEqualToString:@"F"]) {
		
		currentDeckIsTypeFlash  = YES;
		self.flipButton.enabled = YES;
	}
	else {
		currentDeckIsTypeFlash  = NO;
		self.flipButton.enabled = NO;
		
		if (!questionShowing) {
			[self switchViews:self];
		}
	}
	
	self.timerLabel.text = @"00.00";
}

- (void) decrementPage {
	
	int nCurrPage = [self.currentCardIndex intValue];

	if (nCurrPage > 0) {
		
		int selectedResult = [answerController.resultFlag selectedSegmentIndex];
		
		if ([parentController isLeitnerModeOn] && (selectedResult > 0)) {
			[self moveCurrentCardToEnd];
		}
		else{
			--nCurrPage;
		}
	}
	
	self.currentCardIndex = [[NSNumber alloc] initWithInt:nCurrPage];
	
	[self setCurrentCard:self.currentCardIndex];
}

- (BOOL) isCurrentDeckTypeFlash {
	
	return currentDeckIsTypeFlash;
}

- (void) moveCurrentCardToEnd {
	
	if ([parentController isLeitnerModeOn]) {
	
		int nCurrPage = [self.currentCardIndex intValue];
		int nCount    = [self.currentDeck count];
	
		if (nCurrPage < (nCount-1)) {	
	
			NSMutableString *currentCard = 
				[self.currentDeck objectAtIndex:nCurrPage];
	
			[self.currentDeck removeObjectAtIndex:nCurrPage];
	
			[self.currentDeck addObject:currentCard];			
		}
	}
}

- (void) incrementPage {

	int nCurrPage = [self.currentCardIndex intValue];
	int nCount    = [self.currentDeck count];
	
	if (nCurrPage < (nCount-1)) {
		
		int selectedResult = [answerController.resultFlag selectedSegmentIndex];
		
		if ([parentController isLeitnerModeOn] && (selectedResult > 0)) {
			[self moveCurrentCardToEnd];
		}
		else {
			++nCurrPage;
		}
	}
	else {
		
		if (self.startTime != nil) {
			
			// Question
			NSString *timerQuestion = 
			    [NSString 
			        stringWithFormat:@"Would you like to stop the timer?"];
			
			UIAlertView *question = 
			    [[UIAlertView alloc] initWithTitle:@"Question" 
									 message:timerQuestion delegate:self 
							         cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
						
			[question show];
			[question release];
			
		}
	}
	
	self.currentCardIndex = [[NSNumber alloc] initWithInt:nCurrPage];
	
	[self setCurrentCard:self.currentCardIndex];
}

- (void) nullStartTime {
	
	self.startTime = nil;
	
	if (myTicker != nil) {
		[myTicker invalidate];
		myTicker = nil;
	}
}

- (void)shuffleCards {
	
	NSUInteger count = [currentDeck count];
	for (NSUInteger i = 0; i < count; ++i) {
		
		// Select a random element between i and end of array to swap with.
		int nElements = count - i;
		int n = (random() % nElements) + i;
		[currentDeck exchangeObjectAtIndex:i withObjectAtIndex:n];
	}
	
	self.currentCardIndex = [[NSNumber alloc] initWithInt:0];
	
	[self setCurrentCard:self.currentCardIndex];
}

- (void) setParent:(PrototypeOneController*)tmpParentController {
	
	self.parentController = tmpParentController;
}

- (void) updateTimerLabel {
	
	NSDate *endTime = [[NSDate alloc] init];
	[endTime timeIntervalSinceReferenceDate];
	
	NSTimeInterval duration = [endTime timeIntervalSinceDate:self.startTime];
	
	NSString* updatedTimer = 
		[NSString stringWithFormat:@"%.2f", duration];
	
	self.timerLabel.text = updatedTimer;
}

#pragma mark -
#pragma mark Interface Handlers
-(IBAction)previousCard:(id)sender {
	
	if (!questionShowing) {
		
		[parentController 
			addDeckResult:[questionController getQuestion] 
			cardStatus:[answerController getAnswerStatus]];
	}	
	
	[self decrementPage];
	
	if (!questionShowing) {
		[self switchViews:self];
	}
	
	[answerController.resultFlag setSelectedSegmentIndex:0];
}

-(IBAction)nextCard:(id)sender {

	if (!questionShowing) {

		[parentController 
			addDeckResult:[questionController getQuestion] 
			cardStatus:[answerController getAnswerStatus]];
	}

	[self incrementPage];
	
	if (!questionShowing) {
		[self switchViews:self];
	}
	
	[answerController.resultFlag setSelectedSegmentIndex:0];
}

-(IBAction)switchViewsClick:(id)sender {
	
	if (!questionShowing) {
		
		[parentController 
			addDeckResult:[questionController getQuestion] 
			cardStatus:[answerController getAnswerStatus]];
		
		int selectedResult = [answerController.resultFlag selectedSegmentIndex];
			
		if ([parentController isLeitnerModeOn] && (selectedResult > 0)) {
			[self moveCurrentCardToEnd];
			[self setCurrentCard:self.currentCardIndex];
		}
	}

	[self switchViews:sender];
	
	[answerController.resultFlag setSelectedSegmentIndex:0];
}

-(IBAction)switchViews:(id)sender {
	
	/*
	 BNFlashCardPrototypeAppDelegate *delegate = 
	 (BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
	 
	 // [delegate.navController pushViewController:etwSearchResultsController animated:YES];
	 */
		
	if (self.answerController == nil) {
		
		PrototypeOneAnswerController *tmpAnswerController =
		    [[PrototypeOneAnswerController alloc] initWithNibName:@"PrototypeOneAnswer" bundle:nil];
		
		self.answerController = tmpAnswerController;
		
		[tmpAnswerController release];
	}
		
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:0.50];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	if (self.questionController.view.superview == nil) {
		
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight 
							   forView:self.view 
								 cache:YES];
		
		[questionController viewWillAppear:YES];
		[answerController viewWillDisappear:YES];
		
		[answerController.view removeFromSuperview];
		[self.view insertSubview:questionController.view atIndex:0];
		
		[answerController viewDidDisappear:YES];
		[questionController viewDidAppear:YES];
		
		questionShowing = YES;
		
		// backButton.enabled = YES;
		// nextButton.enabled = YES;		
	}
	else {
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft 
							   forView:self.view 
								 cache:YES];
		
		[answerController viewWillAppear:YES];
		[questionController viewWillDisappear:YES];
		
		[questionController.view removeFromSuperview];
		[self.view insertSubview:answerController.view atIndex:0];
		
		[questionController viewDidDisappear:YES];
		[answerController viewDidAppear:YES];
		
		questionShowing = NO;
		
		[self.answerController setAnswer:currAnswer];
		
		// backButton.enabled = NO;
		// nextButton.enabled = NO;
	}
	
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Acceleration Handlers
- (void) accelerometer:(UIAccelerometer*) accelerometer
		 didAccelerate:(UIAcceleration*) acceleration {

	/*
	// Warning
	NSString *debugMsg1 = 
	    [NSString stringWithFormat:@"DEBUG: Detected motion."];
	
	UIAlertView *alert1 = 
	    [[UIAlertView alloc] initWithTitle:@"Info" 
						     message:debugMsg1 delegate:nil 
					         cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	
	[alert1 show];
	[alert1 release];
	*/
	
	if (acceleration.y > kYUpAccelerationThreshold) {

		/*
		// Warning
		NSString *debugMsg2 = 
	    [NSString stringWithFormat:@"DEBUG: Upswing detected."];
		
		UIAlertView *alert2 = 
	    [[UIAlertView alloc] initWithTitle:@"Info" 
						     message:debugMsg2 delegate:nil 
						     cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		
		[alert2 show];
		[alert2 release];
		*/
				
		if (!upswingDetected) {
			
			upswingDetected = YES;
		}
	}
	else if (acceleration.y < kYDownAccelerationThreshold) {
		
		if (upswingDetected) {
			
			// Play audio to signal the user that the save was successful
			NSString *audioFile = 
			    [[NSBundle mainBundle] pathForResource:@"shuffle_cards" ofType:@"wav"];
			
			SystemSoundID soundID;
			
			AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:audioFile], 
											 &soundID);
			
			AudioServicesPlaySystemSound(soundID);	
			
			// Randomly sort the data
			[self shuffleCards];
			
			upswingDetected = NO;
		}
	}
}

#pragma mark -
#pragma mark Touch Handlers
/*
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	
	UITouch *touch = [touches anyObject];
	
	NSUInteger tapCount = [touch tapCount];
	CGPoint tmpPoint = [touch locationInView:self.view];
	
 	// startPoint = tmpPoint;
	
}
*/

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
 
 [self incrementPage];
 }
 else {
 
 [self decrementPage];
 }			
 }
 }
 */

/*
 - (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
 
 UITouch *touch = [touches anyObject];
 
 CGPoint endPoint = [touch locationInView:self.view];
 
 CGFloat deltaX = fabsf(startPoint.x - endPoint.x);
 CGFloat deltaY = fabsf(startPoint.y - endPoint.y);	
 
 if ((deltaX <= 5.0) && (deltaY <= 5.0)) {
 
 [self saveCurrentScreen];
 }
 if ((deltaX >= kMinimumGestureLength) && (deltaY <= kMaximumVariance)) {
 
 if (currColorVal == kGreenColor) {
 currColorVal = kWhiteColor;
 selectedQuote.textColor = [UIColor whiteColor];
 }
 else if (currColorVal == kWhiteColor) {
 currColorVal = kRedColor;
 selectedQuote.textColor = [UIColor redColor];
 }
 else if (currColorVal == kRedColor) {
 currColorVal = kBlueColor;
 selectedQuote.textColor = [UIColor blueColor];
 }
 else if (currColorVal == kBlueColor) {
 currColorVal = kYellowColor;
 selectedQuote.textColor = [UIColor yellowColor];
 }
 else if (currColorVal == kYellowColor) {
 currColorVal = kBlackColor;
 selectedQuote.textColor = [UIColor blackColor];
 }
 else if (currColorVal == kBlackColor) {
 currColorVal = kGreenColor;
 selectedQuote.textColor = [UIColor greenColor];
 }
 
 [self.view setNeedsDisplay];
 }
 }
 */

@end
