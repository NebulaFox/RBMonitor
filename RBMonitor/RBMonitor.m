//
//  RBMonitor.m
//
//  Created by Robbie Bykowski on 19/12/2013.
//  Copyright (c) 2013 Helium End. All rights reserved.
//

#import "RBMonitor.h"

@interface RBMonitor ()

@property ( nonatomic, copy ) NSSet * identifiers;
@property ( nonatomic, strong ) NSMutableArray * mutReceivedIdentifiers;
@property ( nonatomic, strong ) NSMutableSet * mutWaitingOnIdentifiers;

@end

@implementation RBMonitor

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"InitError" reason:@"Please call initWithIdentiferArray:" userInfo:nil];
}

- (instancetype)initWithIdentifiers:(id <NSFastEnumeration>)identifers
{
    self = [super init];
    if ( self )
    {
        NSMutableSet * newIdentifiers = [NSMutableSet new];
        for ( id identifier in identifers )
        {
            if ( [identifier conformsToProtocol:@protocol(NSObject)])
            {
                [newIdentifiers addObject:identifier];
            }
        }
        
        self.identifiers = [newIdentifiers copy];
        
        self.mutReceivedIdentifiers = [NSMutableArray new];
        self.mutWaitingOnIdentifiers = newIdentifiers;
    }
    return self;
}

- (BOOL)signalWithIdentifier:(id <NSObject>)identifier
{
    BOOL success = NO;
    
    if ( [self.identifiers containsObject:identifier] )
    {
        [self.mutReceivedIdentifiers addObject:identifier];
        [self.mutWaitingOnIdentifiers removeObject:identifier];
        
        success = YES;
    }
    
    return success;
}

- (BOOL)wait
{
    BOOL looping = YES;
    
    while ( looping )
    {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        if ( self.mutWaitingOnIdentifiers.count == 0 )
        {
            looping = NO;
        }
    }
    
    return YES;
}

- (BOOL)waitForInterval:(NSTimeInterval)interval
{
    BOOL looping = YES;
    BOOL success = NO;
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    
    while ( looping )
    {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        
        NSTimeInterval current = [NSDate timeIntervalSinceReferenceDate];
        
        if ( self.mutWaitingOnIdentifiers.count == 0 )
        {
            looping = NO;
            success = YES;
        }
        else if ( current - start > interval )
        {
            looping = NO;
        }
    }
    
    return success;
}

- (NSOrderedSet *)receivedIdentifiers
{
    return [NSOrderedSet orderedSetWithArray:self.mutReceivedIdentifiers];
}

- (NSArray *)allReceivedIdentifiers
{
    return [self.mutReceivedIdentifiers copy];
}

- (NSSet *)waitingOnIdentifiers
{
    return [self.mutWaitingOnIdentifiers copy];
}

@end
