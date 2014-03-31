//
//  SetCard.m
//  Matchismo
//
//  Created by Dennis Anderson on 3/3/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString *)contents
{
    return [NSString stringWithFormat:@"%@:%@:%@:%lu", self.symbol, self.color, self.shading, (unsigned long)self.number];
}

@synthesize color = _color, symbol = _symbol, shading = _shading;

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) _color = color;
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) _symbol = symbol;
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) _shading = shading;
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber]) _number = number;
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validSymbols
{
    return @[@"oval", @"squiggle", @"diamond"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"open", @"striped"];
}

+ (NSUInteger)maxNumber
{
    return 3;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
        NSMutableSet *setColor = [[NSMutableSet alloc]initWithObjects:self.color, nil];
        NSMutableSet *setSymbol = [[NSMutableSet alloc]initWithObjects:self.symbol, nil];
        NSMutableSet *setShading = [[NSMutableSet alloc]initWithObjects:self.shading, nil];
        NSMutableSet *setNumber = [[NSMutableSet alloc]initWithObjects:[NSNumber numberWithInteger:self.number], nil];
        for (SetCard *otherCard in otherCards) {
            [setColor addObject:otherCard.color];
            [setSymbol addObject:otherCard.symbol];
            [setShading addObject:otherCard.shading];
            [setNumber addObject:[NSNumber numberWithInteger:otherCard.number]];
            if (([setColor count] == [otherCards count] +1 || [setColor count] == 1)
                && ([setSymbol count] == [otherCards count] +1 || [setSymbol count] == 1)
                && ([setShading count] == [otherCards count] +1 || [setShading count] == 1)
                && ([setNumber count] == [otherCards count] +1 || [setNumber count] == 1 )){
                score = 4;
            }
        }
    return score;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.numberOfMatchingCards = 3;
    }
    
    return self;
}

+ (NSArray *)cardsFromText:(NSString *)text
{
    NSString *pattern = [NSString stringWithFormat:@"(%@):(%@):(%@):(\\d+)",
                         [[SetCard validSymbols] componentsJoinedByString:@"|"],
                         [[SetCard validColors] componentsJoinedByString:@"|"],
                         [[SetCard validShadings] componentsJoinedByString:@"|"]];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) return nil;
    NSArray *matches = [regex matchesInString:text
                                      options:0
                                        range:NSMakeRange(0, [text length])];
    if (![matches count]) return nil;
    
    NSMutableArray *setCards = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *match in matches) {
        SetCard *setCard = [[SetCard alloc] init];
        setCard.symbol = [text substringWithRange:[match rangeAtIndex:1]];
        setCard.color = [text substringWithRange:[match rangeAtIndex:2]];
        setCard.shading = [text substringWithRange:[match rangeAtIndex:3]];
        setCard.number = [[text substringWithRange:[match rangeAtIndex:4]] intValue];
        [setCards addObject:setCard];
    }
    
    return setCards;
}


@end
