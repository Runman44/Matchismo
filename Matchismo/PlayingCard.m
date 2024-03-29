//
//  PlayingCard.m
//  Matchismo
//
//  Created by Dennis Anderson on 2/11/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSArray *)validSuits{
    return @[@"♠️",@"♥️",@"♣️",@"♦️"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] -1;
}

- (void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

- (void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit{
    return _suit ? _suit : @"?";
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    NSMutableSet *setSuit = [[NSMutableSet alloc]initWithObjects:self.suit, nil];
    NSMutableSet *setRank = [[NSMutableSet alloc]initWithObjects:[NSNumber numberWithInteger:self.rank], nil];

    for (PlayingCard *otherCard in otherCards){
        [setSuit addObject:otherCard.suit];
        [setRank addObject:[NSNumber numberWithInteger:otherCard.rank]];
    }
    if ([setSuit count] != [otherCards count] +1){
        score = 1;
    }
    if ([setRank count] != [otherCards count] +1){
        score = 4;
    }
    return score;
}

@end
