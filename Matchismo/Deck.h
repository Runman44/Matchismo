//
//  Deck.h
//  Matchismo
//
//  Created by Dennis Anderson on 2/11/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
