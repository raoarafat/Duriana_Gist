//
//  GistEntity.h
//  Duriana
//
//  Created by Arafat on 23/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Gist.h"

NS_ASSUME_NONNULL_BEGIN

@interface GistEntity : NSManagedObject

/* Fetch */
+ (void) commit;
+ (NSMutableArray*) getGistEntity;
+ (NSMutableArray*) getGistEntityWithDeleted:(NSNumber *) deleted;
+ (NSMutableArray*) getGistEntityWithStatus:(NSNumber *) updated;
+ (NSMutableArray*) getGistEntityWithID:(NSString *) gistID;

/* Insert */
+ (void) createGistWithArray:(NSMutableArray *) gistEntities;

/* remove */
+ (void) emptyEntity;
+ (void) removeEntityWithObject:(GistEntity *) gistEntity;

/* update */
+ (void)  updateGistEntity:(GistEntity *) gistEntity gistEntity:(Gist *) gist;


@end

NS_ASSUME_NONNULL_END

#import "GistEntity+CoreDataProperties.h"
