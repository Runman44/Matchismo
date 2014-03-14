//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Dennis Anderson on 3/3/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "HistoryViewController.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck{

    return [[PlayingCardDeck alloc]init];
}

- (NSAttributedString *)titleForCard:(Card *)card{
    NSAttributedString *title = [[NSAttributedString alloc]
                                 initWithString:card.chosen ? card.contents : @""];
    
    return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
           [segue.destinationViewController setHistory:self.historyList];
        }
    }
}





@end
