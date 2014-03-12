//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Dennis Anderson on 3/3/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init{
    self = [super init];
    
    if (self){
        for (NSString *suit in [SetCard validSuits]){
                SetCard *card = [[SetCard alloc] init];
                card.suit = suit;
                [self addCard:card];
        }
    }
    return self;
}




@end
