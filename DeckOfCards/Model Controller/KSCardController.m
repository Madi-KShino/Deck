//
//  KSCardController.m
//  DeckOfCards
//
//  Created by Madison Kaori Shino on 7/2/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

#import "KSCardController.h"
#import "KSCard.h"

@implementation KSCardController

+ (KSCardController *)sharedController
{
    static KSCardController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [KSCardController new];
    });
    return sharedController;
}

- (void)drawANewCard:(void (^)(NSArray *))completion
{
    NSURL *url = [NSURL URLWithString:@"https://deckofcardsapi.com/api/deck/new/draw/?count=1"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          if (error)
          {
              NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
              completion(nil);
              return;
          }
          if (response)
          {
              NSLog(@"%@", response);
          }
          if (data)
          {
              NSDictionary *topDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
              if (!topDictionary)
              {
                  NSLog(@"Error parsing the JSON: %@", error);
                  completion(nil);
                  return;
              }
              NSArray *cardDicArray = topDictionary[@"cards"];
              NSMutableArray *cardPlaceholder = [NSMutableArray new];
              
              for (NSDictionary *cardDictionary in cardDicArray)
              {
                  KSCard *card = [[KSCard alloc] initWithDictionary:cardDictionary];
                  [cardPlaceholder addObject:card];
              }
              completion(cardPlaceholder);
          }
      }]resume];
}

- (void)fetchImageFromCard:(KSCard *)card completion:(void (^)(UIImage *))completion
{
    NSURL *imageURL = [NSURL URLWithString:card.image];
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          if (error)
          {
              NSLog(@"Error: %@, %@", error, [error localizedDescription]);
              completion(nil);
              return;
          }
          if (response)
          {
              NSLog(@"%@", response);
          }
          if (data)
          {
              UIImage *image = [UIImage imageWithData:data];
              completion(image);
          }
      }]resume];
}

@end
