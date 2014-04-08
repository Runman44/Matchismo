//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Dennis Anderson on 2/16/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger maxMatchingCards;
@property (nonatomic, readonly) NSUInteger numberOfDealtCards;
@property (nonatomic, readonly) BOOL isDeckEmpty;

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void) drawCard; 
- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;


@end
