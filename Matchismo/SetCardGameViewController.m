//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Dennis Anderson on 3/3/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck{
    
    return [[SetCardDeck alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.numberOfStartingCards = 16;
    self.maxCardSize = CGSizeMake(120.0, 120.0);
    [self updateUI];
}

- (UIView *)createViewForCard:(Card *)card
{
    SetCardView *view = [[SetCardView alloc] init];
    [self updateView:view forCard:card];
    return view;
}

- (void)updateView:(UIView *)view forCard:(Card *)card
{
    if (![card isKindOfClass:[SetCard class]]) return;
    if (![view isKindOfClass:[SetCardView class]]) return;
    SetCard *setCard = (SetCard *)card;
    SetCardView *setCardView = (SetCardView *)view;
    setCardView.color = setCard.color;
    setCardView.symbol = setCard.symbol;
    setCardView.shading = setCard.shading;
    setCardView.number = setCard.number;
    
    view.alpha = setCard.chosen ? 0.6 : 1.0;
}

- (void)removeView:(UIView *)view forCard:(Card *)card{
    [UIView animateWithDuration:3.0 delay:0.0 options: UIViewAnimationOptionBeginFromCurrentState animations:^{ view.alpha = 0.0;} completion:^(BOOL fin) {
        if(fin) {
            [view removeFromSuperview];
            [super removeView:view forCard:card];
            [self updateUI];
        }
    }];
}

@end
