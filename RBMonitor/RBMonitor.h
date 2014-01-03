//
//  RBMonitor.h
//
//  Created by Robbie Bykowski on 19/12/2013.
//  Copyright (c) 2013 Helium End. All rights reserved.
//

#import <Foundation/Foundation.h>

/// A synchronization construct with the ability to wait until signalled that a condition has been met
/**
 Each signal is identifered by an unique identifer.
 As you find a condition meet fire a signal with a unique identifer.
 This allows the ability to check for identifers that have not been fired.
 
 This class is designed to used for one use.
 
 It is ARC complient
 It uses Grand Central Dispatch
 */
@interface RBMonitor : NSObject

/// Signals received once in order
@property ( nonatomic, readonly ) NSOrderedSet * receivedIdentifiers;

/// All signals received in order
@property ( nonatomic, readonly ) NSArray * allReceivedIdentifiers;

/// The identifers that have not been signaled
@property ( nonatomic, readonly ) NSSet * waitingOnIdentifiers;

/// Creates an istance with an array of predefiend identifiers
/**
 @note identifiers are anything that has complies to NSObject protocol.
 Anything that does not comply will be ignored.
 
 @param a collection of identifiers
 */
- (instancetype)initWithIdentifiers:(id <NSFastEnumeration>)identifiers;

/// Fires a signal with identifier
/**
 @note an identifier that is not contained in the identefier array will be ignore and returns NO
 
 @param identifier one of the identifers in identifier array

 @returns the success of whether a signal could be fired with matching identifier
 */
- (BOOL)signalWithIdentifier:(id <NSObject>)identifier;

/// Blocks the current thread until all signals are received
- (BOOL)wait;

/// Blocks the current thread until all signals are received or centain amout of time has passed
/**
 @param interval the amount of time to wait until in seconds
 */
- (BOOL)waitForInterval:(NSTimeInterval)interval;

@end
