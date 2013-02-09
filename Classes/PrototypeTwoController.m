//
//  PrototypeTwoController.m
//  BNFCPrototype
//
//  Created by mac on 4/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BNFCPrototypeAppDelegate.h"
#import "PrototypeTwoController.h"
#import "PrototypeTwoDeckChoiceController.h"
#import "PrototypeTwoCardsController.h"

/*
#import "BNFCPrototypeAppDelegate.h"
#import "PrototypeOneController.h"
#import "PrototypeOneDeckController.h"
#import "PrototypeOneCardsController.h"
#import "PrototypeOneResultsController.h"
*/

@implementation PrototypeTwoController

@synthesize mathCardDeck;
@synthesize historyCardDeck;
@synthesize scienceCardDeck;
@synthesize	shakespeareCardDeck;
@synthesize shakespeareCardDeck2;
@synthesize shakespeareCardDeck3;

@synthesize deckTypes;

@synthesize categoryDeckNames;

@synthesize mathDeckResults;
@synthesize historyDeckResults;
@synthesize scienceDeckResults;

@synthesize deckTimings;
@synthesize deckBestTimings;

@synthesize currentCategory;
@synthesize currentDeckName;

// @synthesize deckController;
@synthesize cardsController;

@synthesize controllers;

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
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
	
	self.title = @"Categories";
	
	leitnerMode = NO;
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	/*
	// First Prototype
	PrototypeOneController *prototypeOneController = 
	[[PrototypeOneController alloc] init];
	
	prototypeOneController.title = @"Prototype #1";
	// prototypeOneController.rowImage = nil;
	
	[array addObject:prototypeOneController];
	[prototypeOneController release];
	
	// Second Prototype
	PrototypeTwoController *prototypeTwoController = 
	[[PrototypeTwoController alloc] init];
	
	prototypeTwoController.title = @"Prototype #2";
	// prototypeOneController.rowImage = nil;
	
	[array addObject:prototypeTwoController];
	[prototypeTwoController release];	
	*/
		
	[self initCardDecks];
	
	deckTypes = [[NSMutableDictionary alloc] init];
	[deckTypes setValue:@"F" forKey:@"Math"];
	[deckTypes setValue:@"F" forKey:@"History"];
	[deckTypes setValue:@"F" forKey:@"Science"];
	[deckTypes setValue:@"N" forKey:@"Shakespeare"];
	
	deckTimings     = [[NSMutableDictionary alloc] init];
	deckBestTimings = [[NSMutableDictionary alloc] init];
	
	[currentDeckName setString:@"Science"];
	
	// NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
	

	/*PrototypeOneDeckController *tmpDeckController = 
	[[PrototypeOneDeckController alloc] initWithTabBar:@"Decks"];
	
	[tmpDeckController setParent:self];
	
	self.deckController = tmpDeckController;
	
	PrototypeOneCardsController *tmpCardsController = 
	[[PrototypeOneCardsController alloc] initWithTabBar:@"Cards"];
	
	[tmpCardsController setParent:self];
	
	self.cardsController = tmpCardsController;
		
	self.viewControllers = tabBarItems;
	*/

	/*
	// Navigate to results button
	UIBarButtonItem *resultsButton = 
	[[UIBarButtonItem alloc] initWithTitle:@"Scores"
									 style:UIBarButtonItemStyleBordered 
									target:self 
									action:@selector(showResults)];
	
	self.navigationItem.rightBarButtonItem = resultsButton;
	
	[resultsButton release];
	*/
	
	// Initialize data (strings, containers, etc.)
	NSMutableString *initialDeck = [[NSMutableString alloc] initWithString:@"Math"];
	currentDeckName = initialDeck;
	
	self.mathDeckResults    = [[NSMutableDictionary alloc] init];
	self.historyDeckResults = [[NSMutableDictionary alloc] init];
	self.scienceDeckResults = [[NSMutableDictionary alloc] init];

	/*
	[tmpDeckController release];
	[tmpCardsController release];
	*/
	
	// Finishing touches
	self.controllers = array;
	[array release];
	
    [super viewDidLoad];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[controllers release];
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
	
	// The Tempest
	shakespeareCardDeck2 = [[NSMutableArray alloc] init];
	[shakespeareCardDeck2 addObject:@"Prospero\nThe play’s protagonist and Miranda’s father. Twelve years before the events of the play, Prospero was the duke of Milan. His brother, Antonio, in concert with Alonso, king of Naples, usurped him, forcing him to flee in a boat with his daughter. The honest lord Gonzalo aided Prospero in his escape.|xxx"];
	[shakespeareCardDeck2 addObject:@"Miranda\nProspero’s daughter, whom he brought with him to the island when she was still a small child. Miranda has never seen any men other than her father and Caliban, although she dimly remembers being cared for by female servants as an infant. Because she has been sealed off from the world for so long, Miranda’s perceptions of other people tend to be naïve and non-judgmental.|xxx"];
	[shakespeareCardDeck2 addObject:@"Ariel\nProspero’s spirit helper, a powerful supernatural being whom Prospero controls completely. Rescued by Prospero from a long imprisonment (within a tree) at the hands of the witch Sycorax, Ariel is Prospero’s servant until Prospero decides to release him. He is mischievous and ubiquitous, able to traverse the length of the island in an instant and change shapes at will.|xxx"];
	[shakespeareCardDeck2 addObject:@"Caliban\nAnother of Prospero’s servants. Caliban, the son of the now-deceased witch Sycorax, acquainted Prospero with the island when Prospero arrived. Caliban believes that the island rightfully belongs to him and that Prospero stole it.|xxx"];
	[shakespeareCardDeck2 addObject:@"Ferdinand\nSon and heir of Alonso. Ferdinand seems in some ways to be as pure and naïve as Miranda. He falls in love with her upon first sight and happily submits to servitude in order to win Prospero’s approval.|xxx"];
	[shakespeareCardDeck2 addObject:@"Alonso\nKing of Naples and father of Ferdinand. Alonso aided Antonio in unseating Prospero as duke of Milan twelve years before. Over the course of the play, Alonso comes to regret his past actions and desire a reconciliation with Prospero.|xxx"];
	[shakespeareCardDeck2 addObject:@"Antonio\nProspero’s thoroughly wicked brother who betrayed Prospero’s trust and stole his dukedom years before the play begins. Once on the island, Antonio wastes no time demonstrating that he is still power-hungry and murderous, persuading Sebastian to help him kill Alonso.|xxx"];
	[shakespeareCardDeck2 addObject:@"Sebastian\nAlonso’s brother. Like Antonio, Sebastian is wicked and underhanded. Antonio easily persuades him to agree to kill Alonso. Also like Antonio, Sebastian is unrepentant at the end of the play.|xxx"];
	
	/*
	 The Tempest
	 Prospero
	 The play’s protagonist and Miranda’s father. Twelve years before the events of the play, Prospero was the duke of Milan. His brother, Antonio, in concert with Alonso, king of Naples, usurped him, forcing him to flee in a boat with his daughter. The honest lord Gonzalo aided Prospero in his escape. Prospero has spent his twelve years on an island refining the magic that gives him the power he needs to punish and reconcile with his enemies.
	 Miranda
	 Prospero’s daughter, whom he brought with him to the island when she was still a small child. Miranda has never seen any men other than her father and Caliban, although she dimly remembers being cared for by female servants as an infant. Because she has been sealed off from the world for so long, Miranda’s perceptions of other people tend to be naïve and non-judgmental. She is compassionate, generous, and loyal to her father.
	 Ariel
	 Prospero’s spirit helper, a powerful supernatural being whom Prospero controls completely. Rescued by Prospero from a long imprisonment (within a tree) at the hands of the witch Sycorax, Ariel is Prospero’s servant until Prospero decides to release him. He is mischievous and ubiquitous, able to traverse the length of the island in an instant and change shapes at will. Ariel carries out virtually every task Prospero needs accomplished in the play.
	 Caliban
	 Another of Prospero’s servants. Caliban, the son of the now-deceased witch Sycorax, acquainted Prospero with the island when Prospero arrived. Caliban believes that the island rightfully belongs to him and that Prospero stole it. Caliban’s speech and behavior is sometimes coarse and brutal, sometimes eloquent and sensitive, as in his rebukes of Prospero in Act 1, scene 2, and in his description of the eerie beauty of the island.
	 Ferdinand
	 Son and heir of Alonso. Ferdinand seems in some ways to be as pure and naïve as Miranda. He falls in love with her upon first sight and happily submits to servitude in order to win Prospero’s approval.
	 Alonso
	 King of Naples and father of Ferdinand. Alonso aided Antonio in unseating Prospero as duke of Milan twelve years before. Over the course of the play, Alonso comes to regret his past actions and desire a reconciliation with Prospero.
	 Antonio
	 Prospero’s thoroughly wicked brother who betrayed Prospero’s trust and stole his dukedom years before the play begins. Once on the island, Antonio wastes no time demonstrating that he is still power-hungry and murderous, persuading Sebastian to help him kill Alonso. Though Prospero forgives him at the end of the play, Antonio never repents for his misdeeds.
	 Sebastian
	 Alonso’s brother. Like Antonio, Sebastian is wicked and underhanded. Antonio easily persuades him to agree to kill Alonso. Also like Antonio, Sebastian is unrepentant at the end of the play.
	 */	

	// Twelfth Night
	shakespeareCardDeck3 = [[NSMutableArray alloc] init];
	[shakespeareCardDeck3 addObject:@"Viola\nA young woman of aristocratic birth, and the play’s protagonist. Washed up on the shore of Illyria when her ship is wrecked in a storm, Viola decides to make her own way in the world. She disguises herself as a young man, calling herself “Cesario,” and becomes a page to Duke Orsino.|xxx"];
	[shakespeareCardDeck3 addObject:@"Orsino\nA powerful nobleman in the country of Illyria. Orsino is lovesick for the beautiful Lady Olivia, but finds himself becoming more and more fond of his handsome new page boy, Cesario, who is actually a woman—Viola. Orsino is a vehicle through whom Shakespeare explores the absurdity of love.|xxx"];
	[shakespeareCardDeck3 addObject:@"Olivia\nA wealthy, beautiful, and noble Illyrian lady. Olivia is courted by Orsino and Sir Andrew Aguecheek, but to each of them she insists that she is in mourning for her recently deceased brother and will not marry for seven years.|xxx"];
	[shakespeareCardDeck3 addObject:@"Sebastian\nViola’s lost twin brother. When Sebastian arrives in Illyria, traveling with Antonio, his close friend and protector, he discovers that many people seem to think that they know him.|xxx"];
	[shakespeareCardDeck3 addObject:@"Malvolio\nThe straitlaced steward—or head servant—in the household of Lady Olivia. Malvolio is very efficient but also very self-righteous, and he has a poor opinion of drinking, singing, and fun.|xxx"];
	[shakespeareCardDeck3 addObject:@"Fool\nThe clown, or court jester, of Olivia’s household. The Fool, also known as Feste, moves between Olivia’s and Orsino’s homes, earning his living by making pointed jokes, singing old songs, being generally witty, and offering good advice cloaked under a layer of foolishness.|xxx"];
	[shakespeareCardDeck3 addObject:@"Sir Toby Belch\nOlivia’s uncle. Olivia lets Sir Toby live with her but does not approve of his rowdy behavior, practical jokes, heavy drinking, late-night carousing, or friends (specifically the idiotic Sir Andrew). But Sir Toby has an ally—and eventually a mate—in Olivia’s sharp-witted serving-woman, Maria.|xxx"];
	[shakespeareCardDeck3 addObject:@"Maria\nOlivia’s clever, daring young serving-woman. Maria is remarkably similar to her antagonist, Malvolio, who harbors aspirations of rising in the world through marriage.|xxx"];
	[shakespeareCardDeck3 addObject:@"Sir Andrew\nA friend of Sir Toby’s. Sir Andrew Aguecheek attempts to court Olivia, but he doesn’t stand a chance. He thinks that he is witty, brave, young, and good at languages and dancing, but he is actually a complete idiot.|xxx"];
	[shakespeareCardDeck3 addObject:@"Antonio\nA man who rescues Sebastian after his shipwreck. Antonio has become very fond of Sebastian, caring for him, accompanying him to Illyria, and furnishing him with money—all because of a love so strong that it seems to be romantic in nature.|xxx"];
	 
	/*
	[shakespeareCardDeck3 addObject:@"Viola\nA young woman of aristocratic birth, and the play’s protagonist. Washed up on the shore of Illyria when her ship is wrecked in a storm, Viola decides to make her own way in the world. She disguises herself as a young man, calling herself “Cesario,” and becomes a page to Duke Orsino. She ends up falling in love with Orsino—even as Olivia, the woman Orsino is courting, falls in love with Cesario. Thus, Viola finds that her clever disguise has entrapped her: she cannot tell Orsino that she loves him, and she cannot tell Olivia why she, as Cesario, cannot love her. Viola’s poignant plight is the central conflict in the play.
	Orsino
	A powerful nobleman in the country of Illyria. Orsino is lovesick for the beautiful Lady Olivia, but finds himself becoming more and more fond of his handsome new page boy, Cesario, who is actually a woman—Viola. Orsino is a vehicle through whom Shakespeare explores the absurdity of love. A supreme egotist, Orsino mopes around complaining how heartsick he is over Olivia, when it is clear that he is chiefly in love with the idea of being in love and enjoys making a spectacle of himself.
		Olivia
		A wealthy, beautiful, and noble Illyrian lady. Olivia is courted by Orsino and Sir Andrew Aguecheek, but to each of them she insists that she is in mourning for her recently deceased brother and will not marry for seven years. Olivia and Orsino are similar characters in that each seems to enjoy wallowing in his or her own misery. Viola’s arrival in the masculine guise of Cesario enables Olivia to break free of her self-indulgent melancholy.
			Sebastian
			Viola’s lost twin brother. When Sebastian arrives in Illyria, traveling with Antonio, his close friend and protector, he discovers that many people seem to think that they know him. Furthermore, the beautiful Lady Olivia, whom Sebastian has never met, wants to marry him.
			Malvolio
			The straitlaced steward—or head servant—in the household of Lady Olivia. Malvolio is very efficient but also very self-righteous, and he has a poor opinion of drinking, singing, and fun. His priggishness and haughty attitude earn him the enmity of Sir Toby, Sir Andrew, and Maria, who play a cruel trick on him, making him believe that Olivia is in love with him. In his fantasies about marrying his mistress, Malvolio reveals a powerful ambition to rise above his social class.
			Fool
			The clown, or court jester, of Olivia’s household. The Fool, also known as Feste, moves between Olivia’s and Orsino’s homes, earning his living by making pointed jokes, singing old songs, being generally witty, and offering good advice cloaked under a layer of foolishness. In spite of being a professional fool, Feste often seems the wisest character in the play.
			Sir Toby Belch
			Olivia’s uncle. Olivia lets Sir Toby live with her but does not approve of his rowdy behavior, practical jokes, heavy drinking, late-night carousing, or friends (specifically the idiotic Sir Andrew). But Sir Toby has an ally—and eventually a mate—in Olivia’s sharp-witted serving-woman, Maria. Together, they bring about the triumph of fun and disorder, which Sir Toby embodies, and the humiliation of the controlling, self-righteous Malvolio.
			Maria
			Olivia’s clever, daring young serving-woman. Maria is remarkably similar to her antagonist, Malvolio, who harbors aspirations of rising in the world through marriage. However, Maria succeeds where Malvolio fails—perhaps because she is more in tune than Malvolio with the anarchic, topsy-turvy spirit that animates the play.
			Sir Andrew
			A friend of Sir Toby’s. Sir Andrew Aguecheek attempts to court Olivia, but he doesn’t stand a chance. He thinks that he is witty, brave, young, and good at languages and dancing, but he is actually a complete idiot.
			Antonio
			A man who rescues Sebastian after his shipwreck. Antonio has become very fond of Sebastian, caring for him, accompanying him to Illyria, and furnishing him with money—all because of a love so strong that it seems to be romantic in nature. When the principal characters marry at the end of the play, Antonio is left out, his love for Sebastian unrequited.
	 */	
}

- (NSMutableDictionary*) retrieveCategoryDeckNames {
	
	NSMutableDictionary *tmpCategoryDeckNames = [[NSMutableDictionary alloc] init];
	
	/*
	[tmpCategoryDeckNames 
		setValue:[self.deckTypes valueForKey:self.currentCategory] 
		forKey:self.currentCategory];
	*/
	
	if ([currentCategory isEqualToString:@"Shakespeare"]) {
		[tmpCategoryDeckNames setValue:@"N" forKey:@"Othello"];
		[tmpCategoryDeckNames setValue:@"N" forKey:@"Twelfth Night"];
		[tmpCategoryDeckNames setValue:@"N" forKey:@"The Tempest"];
	}
	else {
		[tmpCategoryDeckNames setValue:@"F" forKey:@"Random Mix"];
	}
	
	return tmpCategoryDeckNames;
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
	else if ( [self.currentDeckName isEqualToString:@"Shakespeare2"] ) {
		
		return self.shakespeareCardDeck2;
	}
	else if ( [self.currentDeckName isEqualToString:@"Shakespeare3"] ) {
		
		return self.shakespeareCardDeck3;
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

- (NSMutableDictionary*) getDeckTypes {
	
	return deckTypes;
}

- (BOOL) isLeitnerModeOn {
	
	return leitnerMode;
	// return YES;
	// return deckController.leitnerSwitch.on;
}

- (void) setCurrentDeck:(NSMutableString*)deckNameChoice {
	
	currentDeckName = deckNameChoice;
	
	/*
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
	*/
	
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

- (void) setLeitnerMode:(BOOL)newMode {
	
	leitnerMode = newMode;
}

- (void) showResults {
	
	/*
	BNFlashCardPrototypeAppDelegate *delegate = 
		(BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
	
	PrototypeOneResultsController *resultsController = 
		[[PrototypeOneResultsController alloc] init];
	
	[resultsController setParent:self];
	
	resultsController.title = @"Decks' Scores";
	
	[delegate.navController pushViewController:resultsController animated:YES];	
	*/
}

- (void) moveToCardView {
	
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
		// [cardsController nullStartTime];
	}	
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger) tableView:(UITableView*)tableView
  numberOfRowsInSection:(NSInteger)section {
	
	return [self.deckTypes count];
}

- (UITableViewCell*) tableView:(UITableView*)tableView
		 cellForRowAtIndexPath:(NSIndexPath*)indexPath{
	
	static NSString *PrototypeTwoControllerCell = @"PrototypeTwoControllerCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PrototypeTwoControllerCell];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] 
				 initWithFrame:CGRectZero reuseIdentifier:PrototypeTwoControllerCell] autorelease];
	}
	
	// Configure the cell
	NSArray *unsortedSelection = [self.deckTypes allKeys];	
	NSArray *selection = [unsortedSelection sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	
	NSString *name = [selection objectAtIndex:[indexPath row]];
	// NSString *type = [self.deckTypes valueForKey:name];
	
	NSString* deckListEntry = 
		// [NSString stringWithFormat:@"%@ (%@)", name, type];
		[NSString stringWithFormat:@"%@", name];
	
	cell.text = deckListEntry;
	// cell.image = controller.rowImage;
	
	return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (UITableViewCellAccessoryType) tableView:(UITableView*)tableView
		  accessoryTypeForRowWithIndexPath:(NSIndexPath*)indexPath {
	
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (void) tableView:(UITableView*)tableView
didSelectRowAtIndexPath:(NSIndexPath*)indexPath {

	NSUInteger row = [indexPath row];
	
	// Configure the cell
	NSArray *unsortedSelection = [self.deckTypes allKeys];	
	NSArray *selection         = [unsortedSelection sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	
	NSString        *name  = [selection objectAtIndex:row];
	
	self.currentCategory = [[NSMutableString alloc] initWithString:name];
	
	PrototypeTwoDeckChoiceController *nextController =
		[[PrototypeTwoDeckChoiceController alloc] init];
	
	nextController.parentController = self;
	
	[nextController assignCurrentCategory:self.currentCategory];
	
	BNFlashCardPrototypeAppDelegate *delegate = 
		(BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
	
	[delegate.navController pushViewController:nextController animated:YES];
	
	/*
	if (row == kPrototypeOne) {
		
		PrototypeOneController *nextController = 
		[self.controllers objectAtIndex:row];
		
		BNFlashCardPrototypeAppDelegate *delegate = 
		(BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
		
		[delegate.navController pushViewController:nextController animated:YES];	
	}
	else if (row == kPrototypeTwo) {
		
		PrototypeTwoController *nextController = 
		[self.controllers objectAtIndex:row];
		
		BNFlashCardPrototypeAppDelegate *delegate = 
		(BNFlashCardPrototypeAppDelegate*) [[UIApplication sharedApplication] delegate];
		
		[delegate.navController pushViewController:nextController animated:YES];	
	}
	*/
	/*
	 else {
	 
	 SecondLevelViewController *nextController = [self.controllers objectAtIndex:row];
	 
	 BiblioPhileAppDelegate *delegate = 
	 (BiblioPhileAppDelegate*) [[UIApplication sharedApplication] delegate];
	 
	 [delegate.navController pushViewController:nextController animated:YES];
	 }
	 */	
}

@end
