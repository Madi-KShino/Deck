//
//  KSCard.m
//  DeckOfCards
//
//  Created by Madison Kaori Shino on 7/2/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

#import "KSCard.h"

@implementation KSCard

- (instancetype)initWithCardSuit:(NSString *)suit image:(NSString *)image
{
    self = [super init];
    if (self)
    {
        _suit = suit;
        _image = image;
    }
    return self;
}

@end

@implementation KSCard (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *suit = dictionary[@"suit"];
    NSString *image = dictionary[@"image"];
    return [self initWithCardSuit:suit image:image];
}

@end
