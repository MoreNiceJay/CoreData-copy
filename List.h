//
//  List.h
//  
//
//  Created by Lee Janghyup on 8/9/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface List : NSManagedObject

@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * qty;
@property (nonatomic, retain) NSString * item;

@end
