//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Dennis Anderson on 2/16/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic) NSMutableArray *cards; //of cards
@property (nonatomic) Deck* deck;
@end


@implementation CardMatchingGame

- (NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSUInteger) numberOfDealtCards{
   return [self.cards count];
}

- (void)setIsDeckEmpty:(BOOL)isDeckEmpty{
    _isDeckEmpty = isDeckEmpty;
}

- (void) drawCard{
    Card *card = [self.deck drawRandomCard];
    if(card){
        [self setIsDeckEmpty:NO];
        [self.cards addObject:card];
    } else {
       [self setIsDeckEmpty:YES]; 
    }
    
}



- (instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *)deck{
    
    self = [super init];
    if(self){
        _deck = deck;
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int TWO_CARD_GAME = 0;
static const int THREE_CARD_GAME = 1;

- (void) chooseCardAtIndex:(NSUInteger)index{
    
    Card *card = [self cardAtIndex:index];
    NSMutableArray *cards = [NSMutableArray array];
    
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
        } else {
            for (Card *otherCard in self.cards){
               
                    if (otherCard.isChosen && !otherCard.isMatched){
                        [cards addObject:otherCard];
                    }
                 if(([cards count] + 1 == self.maxMatchingCards )){
                   
                    int matchScore = [card match:cards];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        for (Card *card in cards) {
                            card.matched = YES;
                        }
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *card in cards) {
                            card.chosen = NO;
                        }
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    
    }
    
}

- (NSUInteger)maxMatchingCards
{
    Card *card = [self.cards firstObject];
    if (_maxMatchingCards < card.numberOfMatchingCards) {
        _maxMatchingCards = card.numberOfMatchingCards;
    }
    return _maxMatchingCards;
}



@end
