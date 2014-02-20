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
@property (nonatomic, strong) NSArray *lastChosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;
@end


@implementation CardMatchingGame

- (NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSUInteger) chosenType{
    if(!_chosenType) _chosenType = 0;
    return _chosenType;
}

- (instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *)deck{
    
    self = [super init];
    
    if(self){
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

- (void) chooseCardAtIndex:(NSUInteger)index{
    
    Card *card = [self cardAtIndex:index];
    NSMutableArray *cards = [NSMutableArray array];
    
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
            self.lastChosenCards = nil;
        } else {
            for (Card *otherCard in self.cards){
               
                    if (otherCard.isChosen && !otherCard.isMatched){
                        [cards addObject:otherCard];
                        self.lastChosenCards = [cards arrayByAddingObject:card];
                        self.lastScore = 0;
                    }
                 if((self.chosenType == 0 && [cards count] == 1) || (self.chosenType == 1 && [cards count] == 2)){
                   
                    int matchScore = [card match:cards];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        self.lastScore = matchScore * MATCH_BONUS;
                        card.matched = YES;
                        for (Card *card in cards) {
                            card.matched = YES;
                        }
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        self.lastScore = - MISMATCH_PENALTY;
                        for (Card *card in cards) {
                            card.chosen = NO;
                        }
                    }
                    break;
                }
                self.lastChosenCards = [cards arrayByAddingObject:card];
                 self.lastScore = 0;
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



@end
