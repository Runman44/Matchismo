//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dennis Anderson on 2/11/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardView.h"

@interface CardGameViewController ()

@property (nonatomic) CardMatchingGame *game;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet PlayingCardView *PlayingCardView;


@end

@implementation CardGameViewController

- (IBAction)swipe:(UITapGestureRecognizer *)sender {
    self.PlayingCardView.faceup = !self.PlayingCardView.faceup;
}

- (CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)touchDealButton:(UIButton *)sender {
    _game = nil;
    [self updateUI];
}

- (void) viewDidLoad{
    self.PlayingCardView.suit = @"♥️";
    self.PlayingCardView.rank = 13;
}

- (void)updateUI{

    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card]
                              forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
    [self history];
}

- (void)history{
    if (self.game) {
        NSString *description = @"";
        if ([self.game.lastChosenCards count]) {
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards) {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@" "];
            
        }
        
        if (self.game.lastScore > 0) {
            description = [NSString stringWithFormat:@"Matched %@ for %ld points.", description, (long)self.game.lastScore];
        } else if (self.game.lastScore < 0) {
            
            description = [NSString stringWithFormat:@"%@ don’t match! %ld point penalty!", description, (long)self.game.lastScore];
        }
        
        self.historyLabel.text = description;
    }
}

- (NSAttributedString  *)titleForCard:(Card *)card{
    return nil; //abstract
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return nil; //abstract
}

- (Deck *)createDeck{ //abstract
    return nil;
}


@end
