//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Dennis Anderson on 3/3/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck{

    return [[PlayingCardDeck alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.numberOfStartingCards = 35;
    self.maxCardSize = CGSizeMake(80.0, 120.0);
    [self updateUI];
}

- (UIView *)createViewForCard:(Card *)card
{
    PlayingCardView *view = [[PlayingCardView alloc] init];
    [self updateView:view forCard:card];
    return view;
}

- (void)updateView:(UIView *)view forCard:(Card *)card
{
    if (![card isKindOfClass:[PlayingCard class]]) return;
    if (![view isKindOfClass:[PlayingCardView class]]) return;
    PlayingCard *playingCard = (PlayingCard *)card;
    PlayingCardView *playingCardView = (PlayingCardView *)view;
    playingCardView.rank = playingCard.rank;
    playingCardView.suit = playingCard.suit;
    
    if (playingCardView.faceup != playingCard.chosen) {
        [UIView transitionWithView:view
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:nil
                        completion:nil];
    }
    
    playingCardView.faceup = playingCard.chosen;
    
    
}

-(void) removeView:(UIView *)view forCard:(Card *)card{
    [self updateView:view forCard:card];
    view.alpha = 0.6;
}


@end
