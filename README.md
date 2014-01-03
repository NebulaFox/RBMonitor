# RBMonitor

Based on [TRVSMonitor](https://github.com/travisjeffery/TRVSMonitor).

It uses the same sort of synchronisation construct as `TRVSMonitor`,
but the condition is based on receiving all signals from a given collection of identifiers.

## Basic Usage

To create an `RBMonitor`, it needs to be initiated with a collection of identifiers.
The collection must conform to the protocol `NSFastEnumerator`.
This allows for all collection `NS` prefixed types. This includes `NSDictionary`.
For `NSDictitionary` the keys will be used.

A simple initiation example

    self.monitor = [[RBMonitor alloc] initWithIdentifers:@( identifier1, identifier2, identifier3 )];
    
To then start waiting

    [self.monitor wait]
    
Or to start waiting for a certain amount of time

    [self.monitor waitForInterval:10.0];
    
To signal the monitor

    [self.monitor signalWithIdentifier:identifier1];


## Additions

There a few properties that can be used to test against.
Say signals were fired like so

    [self.monitor signalWithIdentifier:identifier1];
    [self.monitor signalWithIdentifier:identifier1];
    [self.monitor signalWithIdentifier:identifier1];
    [self.monitor signalWithIdentifier:identifier2];
    [self.monitor signalWithIdentifier:identifier2];

   
`allReceivedIdentifers` gives all the received identifiers that have been signalled to `RBMonitor` in the order they were received.

    > (
        identifier1,
        identifier1,
        identifier1,
        identifier2,
        identifier2,
     )
`receivedIdentifiers` gives the identifiers that have been signalled.
Identifiers only appear once.
    
    > (identifier1, identifier2)
    
`waitingOnIdentifiers` gives the identifiers that have not be signalled yet.

    > (identifier3)