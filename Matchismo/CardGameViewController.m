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
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet PlayingCardView *PlayingCardView;


@end

@implementation CardGameViewController

- (IBAction)swipe:(UITapGestureRecognizer *)sender {
    self.PlayingCardView.faceup = !self.PlayingCardView.faceup;
}

- (CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self numberOfStartingCards] usingDeck:[self createDeck]];
    return _game;
}

- (NSMutableArray *)cardViews
{
    if (!_cardViews) _cardViews = [NSMutableArray arrayWithCapacity:self.numberOfStartingCards];
    return _cardViews;
}


- (IBAction)touchDealButton:(UIButton *)sender {
    _game = nil;
    self.cardViews = nil;
    [self updateUI];
}

- (void) viewDidLoad{
    self.PlayingCardView.suit = @"♥️";
    self.PlayingCardView.rank = 13;
}

- (void)updateUI{

    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (Deck *)createDeck{ //abstract
    return nil;
}


@end
