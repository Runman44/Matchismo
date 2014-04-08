//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dennis Anderson on 2/11/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardView.h"
#import "Grid.h"

@interface CardGameViewController ()

@property (nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (nonatomic) Grid *grid;
@property (weak, nonatomic) IBOutlet UIButton *addCards;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


@end

@implementation CardGameViewController

- (CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self numberOfStartingCards] usingDeck:[self createDeck]];
    return _game;
}

- (Grid *)grid{
    if (!_grid)
    {
    _grid = [[Grid alloc] init];
    _grid.cellAspectRatio = self.maxCardSize.width / self.maxCardSize.height;
    _grid.minimumNumberOfCells = self.numberOfStartingCards;
    _grid.maxCellWidth = self.maxCardSize.width;
    _grid.maxCellHeight = self.maxCardSize.height;
    _grid.size = self.gridView.frame.size;
    }
return _grid;
}


- (NSMutableArray *)cardViews
{
    if (!_cardViews) _cardViews = [NSMutableArray arrayWithCapacity:self.numberOfStartingCards];
    return _cardViews;
}


- (IBAction)touchDealButton:(UIButton *)sender {
    for (UIView *view in self.cardViews){
     [view removeFromSuperview];
    }
    self.cardViews = nil;
    self.game = nil;
    [self updateUI];
}

#define CARDSPACINGINPERCENT 0.08

- (void)updateUI{
    for (NSUInteger cardIndex = 0;
         cardIndex < self.game.numberOfDealtCards;
         cardIndex++) {
        Card *card = [self.game cardAtIndex:cardIndex];
        NSUInteger viewIndex = [self.cardViews indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]]) {
                if (((UIView *)obj).tag == cardIndex) return YES;
            }
            return NO;
        }];
        UIView *cardView;
        if (viewIndex == NSNotFound) {
            if (!card.matched) {
            
            cardView = [self createViewForCard:card];
            cardView.tag = cardIndex;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(touchCard:)];
            [cardView addGestureRecognizer:tap];
            [self.cardViews addObject:cardView];
            viewIndex = [self.cardViews indexOfObject:cardView];
            [self.gridView addSubview:cardView];
            }
        } else {
            cardView = self.cardViews[viewIndex];
            if (card.matched) {
                [self removeView:cardView forCard:card];
            } else {
                [self updateView:cardView forCard:card];
            }
        }
        CGRect frame = [self.grid frameOfCellAtRow:viewIndex / self.grid.columnCount
                                          inColumn:viewIndex % self.grid.columnCount];
        frame = CGRectInset(frame, frame.size.width * CARDSPACINGINPERCENT, frame.size.height * CARDSPACINGINPERCENT);
        cardView.frame = frame;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (void)touchCard:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self.game chooseCardAtIndex:gesture.view.tag];
        [self updateUI];
    }
}

- (IBAction)addCard:(UIButton *)sender {
    
    
}

- (UIView *)createViewForCard:(Card *)card //abstract
{
    return nil;
}

- (void)removeView:(UIView *)view forCard:(Card *)card 
{
    // make this work ! 
    [UIView animateWithDuration:5.0 delay:0.0 options: UIViewAnimationOptionBeginFromCurrentState animations:^{ view.alpha = 0.0;} completion:^(BOOL fin) { if(fin) [view removeFromSuperview]; }];
    [self.cardViews removeObject:view];
}

- (void)updateView:(UIView *)view forCard:(Card *)card //abstract
{
}

- (Deck *)createDeck{ //abstract
    return nil;
}


@end
