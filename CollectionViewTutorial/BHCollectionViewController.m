//
//  BHViewController.m
//  CollectionViewTutorial
//
//  Created by Bryan Hansen on 11/3/12.
//  Copyright (c) 2012 Bryan Hansen. All rights reserved.
//

#import "BHCollectionViewController.h"
#import "BHAlbum.h"
#import "BHPhoto.h"
#import "BHAlbumPhotoCell.h"
#import "BHPhotoAlbumLayout.h"
#import "UIColor+CollectionViewTutorial.h"

static NSString * const PhotoCellIdentifier = @"PhotoCell";

@interface BHCollectionViewController ()

@property (nonatomic, strong) IBOutlet BHPhotoAlbumLayout *photoAlbumLayout;

@end

@implementation BHCollectionViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor albumBrowserBackgroundColor];
    self.photoAlbumLayout.itemInsets = UIEdgeInsetsMake(25.0f, 25.0f, 25.0f, 25.0f);
    self.photoAlbumLayout.itemSize = CGSizeMake(125.0f, 125.0f);
    
    self.albums = [NSMutableArray array];

    NSURL *urlPrefix = [NSURL URLWithString:@"https://raw.github.com/ShadoFlameX/PhotoCollectionView/master/Images/Photos/"];
	
    for (int a=0; a<10; a++) {
        BHAlbum *album = [[BHAlbum alloc] init];
        
        for (int p=0; p<10; p++) {
            NSString *photoFilename = [NSString stringWithFormat:@"photo%d.jpg",1]; //TODO: load some other photos
            
            BHPhoto *photo = [BHPhoto photoWithImageURL:[urlPrefix URLByAppendingPathComponent:photoFilename]];
            [album addPhoto:photo];
        }
        
        [self.albums addObject:album];
    }
    
    [self.collectionView registerClass:[BHAlbumPhotoCell class] forCellWithReuseIdentifier:PhotoCellIdentifier];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ((BHAlbum *)[self.albums objectAtIndex:section]).photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BHAlbumPhotoCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier forIndexPath:indexPath];

    return photoCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.albums.count;
}


@end
