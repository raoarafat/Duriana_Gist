//
//  GistVC.h
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GistEntity.h"

@interface GistVC : UIViewController{
    
    GistEntity * gistEntity;
}

@property (nonatomic , weak) IBOutlet UITableView * tblView;

@end
