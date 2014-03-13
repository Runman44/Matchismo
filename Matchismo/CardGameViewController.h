//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Dennis Anderson on 2/11/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (strong, nonatomic) NSMutableArray *historyList;

// protected
- (Deck *)createDeck; //abstract
- (UIImage *)backgroundImageForCard:(Card *)card; //abstract
- (NSAttributedString  *)titleForCard:(Card *)card; //abstract
- (void)updateUI;

@end
