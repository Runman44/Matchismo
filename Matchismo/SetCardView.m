//
//  SetCardView.m
//  Matchismo
//
//  Created by Dennis Anderson on 4/6/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

- (void)setColor:(NSString*)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setShading:(NSString *)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setSymbol:(NSString *)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setNumber:(NSUInteger)number
{
    _number = number;
    [self setNeedsDisplay];
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    [self drawSymbolsOnCount];
}

#define SYMBOL_OFFSET 0.2;
#define SYMBOL_LINE_WIDTH 0.02;

- (void) drawSymbolsOnCount{
    [[self strokeColor] setStroke];
    CGPoint point = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    if (self.number == 1) {
        [self drawSymbolsOnPoint:point];
        return;
    }
    CGFloat dx = self.bounds.size.width * SYMBOL_OFFSET;
    if (self.number == 2) {
        [self drawSymbolsOnPoint:CGPointMake(point.x - dx / 2, point.y)];
        [self drawSymbolsOnPoint:CGPointMake(point.x + dx / 2, point.y)];
        return;
    }
    if (self.number == 3) {
        [self drawSymbolsOnPoint:point];
        [self drawSymbolsOnPoint:CGPointMake(point.x - dx, point.y)];
        [self drawSymbolsOnPoint:CGPointMake(point.x + dx, point.y)];
        return;
    }
}

- (UIColor *)strokeColor
{
    if ([self.color isEqualToString:@"red"]) return [UIColor redColor];
    if ([self.color isEqualToString:@"green"]) return [UIColor greenColor];
    if ([self.color isEqualToString:@"purple"]) return [UIColor purpleColor];
    return nil;
}


- (void) drawSymbolsOnPoint:(CGPoint)point{
    if ([self.symbol isEqualToString:@"diamond"]) {
        [self drawDiamondAtPoint:point];
    } else if ([self.symbol isEqualToString:@"oval"]) [self drawOvalAtPoint:point];
    else if ([self.symbol isEqualToString:@"squiggle"]) [self drawSquiggleAtPoint:point];
}



#define DIAMOND_WIDTH 0.15
#define DIAMOND_HEIGHT 0.4

- (void)drawDiamondAtPoint:(CGPoint)point {
    
    CGFloat dx = self.bounds.size.width * DIAMOND_WIDTH / 2.0;
    CGFloat dy = self.bounds.size.height * DIAMOND_HEIGHT / 2.0;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(point.x, point.y - dy)];
    [path addLineToPoint:CGPointMake(point.x + dx, point.y)];
    [path addLineToPoint:CGPointMake(point.x, point.y + dy)];
    [path addLineToPoint:CGPointMake(point.x - dx, point.y)];
    [path closePath];

    [path stroke];
    
}

#define OVAL_WIDTH 0.12
#define OVAL_HEIGHT 0.4

- (void)drawOvalAtPoint:(CGPoint)point;
{
    CGFloat dx = self.bounds.size.width * OVAL_WIDTH / 2.0;
    CGFloat dy = self.bounds.size.height * OVAL_HEIGHT / 2.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x - dx, point.y - dy, 2.0 * dx, 2.0 * dy)
                                                    cornerRadius:dx];
    path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
    [self shadePath:path];
    [path stroke];
}

#define SQUIGGLE_WIDTH 0.12
#define SQUIGGLE_HEIGHT 0.3
#define SQUIGGLE_FACTOR 0.8

- (void)drawSquiggleAtPoint:(CGPoint)point;
{
    CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH / 2.0;
    CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT / 2.0;
    CGFloat dsqx = dx * SQUIGGLE_FACTOR;
    CGFloat dsqy = dy * SQUIGGLE_FACTOR;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
    [path addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
                 controlPoint:CGPointMake(point.x - dsqx, point.y - dy - dsqy)];
    [path addCurveToPoint:CGPointMake(point.x + dx, point.y + dy)
            controlPoint1:CGPointMake(point.x + dx + dsqx, point.y - dy + dsqy)
            controlPoint2:CGPointMake(point.x + dx - dsqx, point.y + dy - dsqy)];
    [path addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
                 controlPoint:CGPointMake(point.x + dsqx, point.y + dy + dsqy)];
    [path addCurveToPoint:CGPointMake(point.x - dx, point.y - dy)
            controlPoint1:CGPointMake(point.x - dx - dsqx, point.y + dy - dsqy)
            controlPoint2:CGPointMake(point.x - dx + dsqx, point.y - dy + dsqy)];
    path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;
    [self shadePath:path];
    [path stroke];
}

#define STRIPES_OFFSET 0.06
#define STRIPES_ANGLE 5

- (void)shadePath:(UIBezierPath *)path
{
    if ([self.shading isEqualToString:@"solid"]) {
        [[self strokeColor] setFill];
        [path fill];
    } else if ([self.shading isEqualToString:@"striped"]) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        [path addClip];
        UIBezierPath *stripes = [[UIBezierPath alloc] init];
        CGPoint start = self.bounds.origin;
        CGPoint end = start;
        CGFloat dy = self.bounds.size.height * STRIPES_OFFSET;
        end.x += self.bounds.size.width;
        start.y += dy * STRIPES_ANGLE;
        for (int i = 0; i < 1 / STRIPES_OFFSET; i++) {
            [stripes moveToPoint:start];
            [stripes addLineToPoint:end];
            start.y += dy;
            end.y += dy;
        }
        stripes.lineWidth = self.bounds.size.width / 2 * SYMBOL_LINE_WIDTH;
        [stripes stroke];
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
    } else if ([self.shading isEqualToString:@"open"]) {
        [[UIColor clearColor] setFill];
    }
}

#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
