//
//  PrototypeOneController.m
//  BNFlashCardPrototype
//
//  Created by mac on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BNFCPrototypeAppDelegate.h"
#import "PrototypeOneController.h"
#import "PrototypeOneDeckController.h"
#import "PrototypeOneCardsController.h"
#import "PrototypeOneResultsController.h"

@implementation PrototypeOneController

@synthesize mathCardDeck;
@synthesize historyCardDeck;
@synthesize scienceCardDeck;
@synthesize	shakespeareCardDeck;

@synthesize deckTypes;

@synthesize mathDeckResults;
@synthesize historyDeckResults;
@synthesize scienceDeckResults;

@synthesize deckTimings;
@synthesize deckBestTimings;

@synthesize currentDeckName;

@synthesize deckController;
@synthesize cardsController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	// Initialize controllers
	[self initCardDecks];
	
	deckTypes = [[NSMutableDictionary alloc] init];
	[deckTypes setValue:@"F" forKey:@"Math"];
	[deckTypes setValue:@"F" forKey:@"History"];
	[deckTypes setValue:@"F" forKey:@"Science"];
	[deckTypes setValue:@"N" forKey:@"Shakespeare"];
	
	deckTimings     = [[NSMutableDictionary alloc] init];
	deckBestTimings = [[NSMutableDictionary alloc] init];
	
	[currentDeckName setString:@"Science"];
	
	NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
	
	PrototypeOneDeckController *tmpDeckController = 
	    [[PrototypeOneDeckController alloc] initWithTabBar:@"Decks"];
	
	[tmpDeckController setParent:self];
	
	self.deckController = tmpDeckController;
	
	PrototypeOneCardsController *tmpCardsController = 
	    [[PrototypeOneCardsController alloc] initWithTabBar:@"Cards"];
	
	[tmpCardsController setParent:self];
	
	self.cardsController = tmpCardsController;

	[tabBarItems addObject:tmpDeckController];
	[tabBarItems addObject:tmpCardsController];
	
	self.viewControllers = tabBarItems;
			
	// Navigate to results button
	UIBarButtonItem *resultsButton = 
		[[UIBarButtonItem alloc] initWithTitle:@"Scores"
								 style:UIBarButtonItemStyleBordered 
								 target:self 
								 action:@selector(showResults)];

	self.navigationItem.rightBarButtonItem = resultsButton;
		
	[resultsButton release];

	// Initialize data (strings, containers, etc.)
	NSMutableString *initialDeck = [[NSMutableString alloc] initWithString:@"Math"];
	currentDeckName = initialDeck;
	
	self.mathDeckResults    = [[NSMutableDictionary alloc] init];
	self.historyDeckResults = [[NSMutableDictionary alloc] init];
	self.scienceDeckResults = [[NSMutableDictionary alloc] init];
				
    [super viewDidLoad];
	
	[tabBarItems release];
	[tmpDeckController release];
	[tmpCardsController release];
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
    [super dealloc];
}

- (void) addDeckResult:(NSMutableString*)question
	cardStatus:(NSMutableString*)status {

	if ([currentDeckName isEqualToString:@"Math"]) {
		[mathDeckResults setValue:status forKey:question];
	}
	else if ([currentDeckName isEqualToString:@"History"]) {
		[historyDeckResults setValue:status forKey:question];
	}
	else if ([currentDeckName isEqualToString:@"Science"]) {
		[scienceDeckResults setValue:status forKey:question];
	}
}

- (void) alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
		[cardsController initStartTime];
	}
	else {
		[cardsController nullStartTime];
	}
}

- (NSMutableArray*) getResultsData {
	
	NSMutableArray *resultsData = [[NSMutableArray alloc] init];
	
	int nMathDeckResultCount    = [mathDeckResults count];
	int nHistoryDeckResultCount = [historyDeckResults count];
	int nScienceDeckResultCount = [scienceDeckResults count];
	
	int nMathDeckCorrectCount    = 0;
	int nHistoryDeckCorrectCount = 0;
	int nScienceDeckCorrectCount = 0;
	
	float fMathDeckSuccessRate    = 0.0;
	float fHistoryDeckSuccessRate = 0.0;
	float fScienceDeckSuccessRate = 0.0;
	
	NSArray *unsortedMathResults    = [self.mathDeckResults allKeys];
	NSArray *unsortedHistoryResults = [self.historyDeckResults allKeys];
	NSArray *unsortedScienceResults = [self.scienceDeckResults allKeys];

	for (id key in unsortedMathResults) {
		
		NSMutableString* question = key;
		NSMutableString* result   = [self.mathDeckResults valueForKey:question];
		
		if ([result isEqualToString:@"Correct"]) {
			
			nMathDeckCorrectCount++;
		}
	}
	
	for (id key in unsortedHistoryResults) {

		NSMutableString* question = key;
		NSMutableString* result   = [self.historyDeckResults valueForKey:question];

		if ([result isEqualToString:@"Correct"]) {
			
			nHistoryDeckCorrectCount++;
		}
	}

	for (id key in unsortedScienceResults) {
		
		NSMutableString* question = key;
		NSMutableString* result   = [self.scienceDeckResults valueForKey:question];
		
		if ([result isEqualToString:@"Correct"]) {
			
			nScienceDeckCorrectCount++;
		}
	}
	
	NSNumber *currMathDeckTiming = [self.deckTimings valueForKey:@"Math"];
	NSNumber *bestMathDeckTiming = [self.deckBestTimings valueForKey:@"Math"];
	NSNumber *currHistDeckTiming = [self.deckTimings valueForKey:@"History"];
	NSNumber *bestHistDeckTiming = [self.deckBestTimings valueForKey:@"History"];
	NSNumber *currSciDeckTiming  = [self.deckTimings valueForKey:@"Science"];
	NSNumber *bestSciDeckTiming  = [self.deckBestTimings valueForKey:@"Science"];
	
	if (bestMathDeckTiming == nil) {
		bestMathDeckTiming = currMathDeckTiming;
	}
	
	if (bestHistDeckTiming == nil) {
		bestHistDeckTiming = currHistDeckTiming;
	}
	
	if (bestSciDeckTiming == nil) {
		bestSciDeckTiming = currSciDeckTiming;
	}
	
	if (nMathDeckResultCount > 0) {
	    fMathDeckSuccessRate = 
	        ((float) nMathDeckCorrectCount / nMathDeckResultCount) * 100.00;
	}
	
	if (nHistoryDeckResultCount > 0) {
	    fHistoryDeckSuccessRate = 
	        ((float) nHistoryDeckCorrectCount / nHistoryDeckResultCount) * 100.00;
	}
	
	if (nScienceDeckResultCount > 0) {
	    fScienceDeckSuccessRate = 
	        ((float) nScienceDeckCorrectCount / nScienceDeckResultCount) * 100.00;
	}

	NSString* mathResultsEntry = 
	    [NSString stringWithFormat:@"Math Deck|(LastTm: %.2f s) (BestTm: %.2f s)|%.2f %@ of %d cards", 
		    [currMathDeckTiming floatValue]
		    , [bestMathDeckTiming floatValue]
		    , fMathDeckSuccessRate
		    , @"%"
		    , nMathDeckResultCount];
	
	NSString* historyResultsEntry = 
        [NSString stringWithFormat:@"History Deck|(LastTm: %.2f s) (BestTm: %.2f s)|%.2f %@ of %d cards", 
		    [currHistDeckTiming floatValue]
		    , [bestHistDeckTiming floatValue]
			, fHistoryDeckSuccessRate
		    , @"%"
			, nHistoryDeckResultCount];
	
	NSString* scienceResultsEntry = 
	    [NSString stringWithFormat:@"Science Deck|(LastTm: %.2f s) (BestTm: %.2f s)|%.2f %@ of %d cards", 
		    [currSciDeckTiming floatValue]
		    , [bestSciDeckTiming floatValue]
		    , fScienceDeckSuccessRate
		    , @"%"
	        , nScienceDeckResultCount];
	
	[resultsData addObject:mathResultsEntry];
	[resultsData addObject:historyResultsEntry];
	[resultsData addObject:scienceResultsEntry];
	
	return resultsData;
}

- (void)initCardDecks {
	
	mathCardDeck = [[NSMutableArray alloc] init];
	[mathCardDeck addObject:@"2+2=|4"];
	[mathCardDeck addObject:@"6*6=|36"];
	[mathCardDeck addObject:@"8-2=|6"];
	[mathCardDeck addObject:@"72/9=|8"];
	[mathCardDeck addObject:@"2^8=|256"];
	[mathCardDeck addObject:@"6!=|720"];
	[mathCardDeck addObject:@"0.03%=|0.0003"];
	[mathCardDeck addObject:@"13*13=|169"];
	[mathCardDeck addObject:@"13/0=|undefined"];
	[mathCardDeck addObject:@"13/1=|13"];	
	
	historyCardDeck = [[NSMutableArray alloc] init];
	[historyCardDeck addObject:@"Who was the leader of the British Commonwealth?|Oliver Cromwell"];
	[historyCardDeck addObject:@"Which country had the king who declared 'The state?  It's me.'?|France"];
	[historyCardDeck addObject:@"What 19th art movement in France challenged traditional painting?|Impressionism"];
	[historyCardDeck addObject:@"What famous German city was bombed during the Battle of the Bulge?|Dresden"];
	[historyCardDeck addObject:@"What unit of currency became the standard for the founding of the EU?|Euro"];
	[historyCardDeck addObject:@"During what war did the British attack and demolish the White House?|War of 1812"];
	[historyCardDeck addObject:@"What 12th-century treaty changed the role of the British King?|Magna Carta"];
	[historyCardDeck addObject:@"What famous leader was Mao Zedong's nemesis before World War II?|Chiang Kai-shek"];
	[historyCardDeck addObject:@"What famous group challenged the Russian government following the death of Alexander I and then slaughtered?|The Decembrists"];
	[historyCardDeck addObject:@"Which scientist challenged Edison by creating AC electricity?|Tesla"];
	
	scienceCardDeck = [[NSMutableArray alloc] init];
	[scienceCardDeck addObject:@"Which element is the heaviest?|Copernicium"];
	[scienceCardDeck addObject:@"What is the term for the maximum speed of descent from a freefall?|Terminal velocity"];
	[scienceCardDeck addObject:@"What is an organism that survives extremely warm temperatures?|Thermaphile"];
	[scienceCardDeck addObject:@"How many centimeters are in one inch?|2.54"];
	[scienceCardDeck addObject:@"What is the sphere of area which surrounds the sun?|Heliosphere"];
	[scienceCardDeck addObject:@"What is the branch of science that studies insects?|Entymology"];
	[scienceCardDeck addObject:@"The larger type of chamber of the heart is called what?|Ventricle"];
	[scienceCardDeck addObject:@"What is the branch of the culinary arts which experiments with cuisine?|Molecular gastronomy"];
	[scienceCardDeck addObject:@"What kind of chemical bond shares a pair of electrons?|Covalent"];
	[scienceCardDeck addObject:@"Which is the deepest part of the ocean?|Mariana Trench"];

	shakespeareCardDeck = [[NSMutableArray alloc] init];
	[shakespeareCardDeck addObject:@"Othello\nThe play’s protagonist and hero. Othello is the highly respected general of the armies of Venice, although he is not a native of Venice but rather a Moor, or North African. He is an eloquent and powerful figure, respected by all those around him.|xxx"];
	[shakespeareCardDeck addObject:@"Desdemona\nThe daughter of the Venetian senator Brabantio. Desdemona and Othello are secretly married before the play begins. While in some ways stereotypically pure and meek, Desdemona is also determined and self-possessed.|xxx"];
	[shakespeareCardDeck addObject:@"Iago\nOthello’s ensign (a senior position also known as “ancient” or “standard-bearer”), a twenty-eight-year-old military veteran from Venice. Iago is the villain of the play.|xxx"];
	[shakespeareCardDeck addObject:@"Michael Cassio\nOthello’s lieutenant, or second-in-command. Cassio is highly educated but young and inexperienced in battle. Iago resents Cassio’s high position and dismisses him as a bookkeeper.|xxx"];
	[shakespeareCardDeck addObject:@"Emilia\nIago’s wife and Desdemona’s attendant. A cynical, worldly woman, Emilia is deeply attached to her mistress and distrustful of her husband.|xxx"];
	[shakespeareCardDeck addObject:@"Roderigo\nA jealous suitor of Desdemona. Young, rich, and foolish, Roderigo is convinced that if he gives Iago all of his money, Iago will help him win Desdemona’s hand.|xxx"];	
	/*
	[shakespeareCardDeck addObject:@"Othello\nThe play’s protagonist and hero. Othello is the highly respected general of the armies of Venice, although he is not a native of Venice but rather a Moor, or North African. He is an eloquent and powerful figure, respected by all those around him. In spite of his elevated status, Othello is nevertheless easy prey to insecurities because of his age, his life as a soldier, and his self-consciousness about being a racial and cultural outsider. He possesses a free and open nature that his ensign Iago exploits to twist Othello’s love for his wife, Desdemona, into a powerful and destructive jealousy.|xxx"];
	[shakespeareCardDeck addObject:@"Desdemona\nThe daughter of the Venetian senator Brabantio. Desdemona and Othello are secretly married before the play begins. While in some ways stereotypically pure and meek, Desdemona is also determined and self-possessed. She is equally capable of defending her marriage, jesting bawdily with Iago, and responding with dignity to Othello’s incomprehensible jealousy.|xxx"];
	[shakespeareCardDeck addObject:@"Iago\nOthello’s ensign (a senior position also known as “ancient” or “standard-bearer”), a twenty-eight-year-old military veteran from Venice. Iago is the villain of the play. Although he is obsessive, relentless, bold, and ingenius in his efforts to manipulate and deceive the other characters—particularly Othello—Iago’s motivations are notoriously murky. At various points in the play, he claims to be motivated by different things: resentment that Othello passed him over for a promotion in favor of Michael Cassio; jealousy because he heard a rumor that Othello slept with Iago’s wife, Emilia; suspicion that Cassio slept with Emilia too. Iago gives the impression that he’s tossing out plausible motivations as he thinks of them, and that we’ll never understand what really drives his villainy. He hates women and is obsessed with other people’s sex lives.|xxx"];
	[shakespeareCardDeck addObject:@"Michael Cassio\nOthello’s lieutenant, or second-in-command. Cassio is highly educated but young and inexperienced in battle. Iago resents Cassio’s high position and dismisses him as a bookkeeper. Truly devoted to Othello, Cassio is ashamed after being implicated in a drunken brawl on Cyprus and losing his place as lieutenant. Iago uses Cassio’s youth, good looks, and flirtatious manner with women to play on Othello’s insecurities about Desdemona’s fidelity.|xxx"];
	[shakespeareCardDeck addObject:@"Emilia\nIago’s wife and Desdemona’s attendant. A cynical, worldly woman, Emilia is deeply attached to her mistress and distrustful of her husband.|xxx"];
	[shakespeareCardDeck addObject:@"Roderigo\nA jealous suitor of Desdemona. Young, rich, and foolish, Roderigo is convinced that if he gives Iago all of his money, Iago will help him win Desdemona’s hand. Repeatedly frustrated as Othello marries Desdemona and then takes her to Cyprus, Roderigo is ultimately desperate enough to agree to help Iago kill Cassio after Iago points out that Cassio is another potential rival for Desdemona.|xxx"];
	*/
}

- (NSMutableArray*) getCurrentDeck {
	
	if ( [self.currentDeckName isEqualToString:@"Math"]) {
		
	    return self.mathCardDeck;
	}
	else if ( [self.currentDeckName isEqualToString:@"History"]) {
		
	    return self.historyCardDeck;
	}
	else if ( [self.currentDeckName isEqualToString:@"Science"]) {
		
	    return self.scienceCardDeck;
	}
	else if ( [self.currentDeckName isEqualToString:@"Shakespeare"] ) {
		
		return self.shakespeareCardDeck;
	}
	else {
		NSMutableArray *unknown = [[NSMutableArray alloc] init];
		return unknown;
	}
}

- (NSMutableString*) getCurrentDeckName {
	
	return currentDeckName;
}

- (NSString*) getCurrentDeckType {
	
	return [deckTypes valueForKey:self.currentDeckName];
}

- (BOOL) isLeitnerModeOn {
	
	return deckController.leitnerSwitch.on;
}

- (void) setCurrentDeck:(NSMutableString*)deckNameChoice {
	
	currentDeckName = deckNameChoice;
	
	if ( [currentDeckName isEqualToString:@"Math"]) {
		
	    [self.cardsController assignCurrentDeck:mathCardDeck];
	}
	else if ( [currentDeckName isEqualToString:@"History"]) {
		
	    [self.cardsController assignCurrentDeck:historyCardDeck];
	}
	else if ( [currentDeckName isEqualToString:@"Science"]) {
		
	    [self.cardsController assignCurrentDeck:scienceCardDeck];
	}
	else if ( [currentDeckName isEqualToString:@"Shakespeare"]) {
		
	    [self.cardsController assignCurrentDeck:shakespeareCardDeck];
	}	

	/*
	[self.mathDeckResults removeAllObjects];
	[self.historyDeckResults removeAllObjects];
	[self.scienceDeckResults removeAllObjects];
	*/
}

- (void) setCurrentDeckTiming:(NSTimeInterval)deckTiming {
	
	NSNumber *numDeckTiming = [[NSNumber alloc] initWithFloat:deckTiming];
	
	[self.deckTimings setValue:numDeckTiming forKey:self.currentDeckName];
	
	NSNumber *bestDeckTiming = [self.deckBestTimings valueForKey:self.currentDeckName];
	
	if (bestDeckTiming != nil) {
		double dCurrDeckTiming = [numDeckTiming doubleValue];
		double dBestDeckTiming = [bestDeckTiming doubleValue];
		
		if (dBestDeckTiming > dCurrDeckTiming) {
			[self.deckBestTimings setValue:numDeckTiming forKey:self.currentDeckName];
		}
	}
	else {
		[self.deckBestTimings setValue:numDeckTiming forKey:self.currentDeckName];
	}
}

- (void) showResults {
	
	BNFlashCardPrototypeAppDelegate *delegate = 
	    (BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
	
	PrototypeOneResultsController *resultsController = 
		[[PrototypeOneResultsController alloc] init];
	
	[resultsController setParent:self];
	
	resultsController.title = @"Decks' Scores";

	[delegate.navController pushViewController:resultsController animated:YES];	
}

- (void) tabToCardView {
	
	NSString *currDeckType = 
	    [self.deckTypes valueForKey:self.currentDeckName];
	
	if ([currDeckType isEqualToString:@"F"]) { 
		
		// Question
		NSString *timerQuestion = 
			[NSString 
			    stringWithFormat:@"Would you like to start the timer?"];
	 
		UIAlertView *question = 
			[[UIAlertView alloc] initWithTitle:@"Question" 
								 message:timerQuestion delegate:self 
	                             cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
		
		[question show];
		[question release];
	}
	else {
		[cardsController nullStartTime];
	}
	
	self.selectedViewController = cardsController;	
}

@end
