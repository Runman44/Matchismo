//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Dennis Anderson on 3/3/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck{

    return [[PlayingCardDeck alloc]init];
}

@end
