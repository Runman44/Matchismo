//
//  PlayingCard.h
//  Matchismo
//
//  Created by Dennis Anderson on 2/11/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
