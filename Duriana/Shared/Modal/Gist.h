//
//  Gist.h
//  Duriana
//
//  Created by Arafat on 23/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//

#import <Foundation/Foundation.h>


@class GistEntity;

@interface Gist : NSObject

@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *gistID;
@property (nonatomic, retain) NSNumber *is_Deleted;
@property (nonatomic, retain) NSNumber *is_Star;
@property (nonatomic, retain) NSNumber *is_Updated;
@property (nonatomic, retain) NSString *name;

- (id)initWithDictionary:(NSDictionary*)dict;


/* Fetch */
+ (NSMutableArray*) getGistEntity;
+ (NSMutableArray*) getGistEntityWithDeleted:(NSNumber *) deleted;
+ (NSMutableArray*) getGistEntityWithStatus:(NSNumber *) updated;
+ (NSMutableArray*) getGistEntityWithID:(NSString *) gistID;

/* Insert */
+ (void) createGistWithArray:(NSMutableArray *) gistEntities;

/* remove */
+ (void) emptyEntity;
+ (void) removeEntityWithObject:(GistEntity *) gistEntity;



@end
