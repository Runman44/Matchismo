//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Dennis Anderson on 3/3/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck{
    
    return [[SetCardDeck alloc]init];
}
- (NSString *)titleForCard:(Card *)card{
    return card.contents;
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardselect" : @"cardfront"];
}

@end
