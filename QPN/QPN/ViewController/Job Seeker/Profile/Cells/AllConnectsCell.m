//
//  AllConnectsCell.m
//  QPN
//
//  Created by Muhammad Usman on 04/05/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "AllConnectsCell.h"
#import "ConnectUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation AllConnectsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.connectsCollectionView.dataSource = self;
    self.connectsCollectionView.delegate = self;
    
    [self.connectsCollectionView registerNib:[UINib nibWithNibName:@"ConnnectCell" bundle:nil] forCellWithReuseIdentifier:@"ConnnectCell"];
    
}
-(void) populateConnectData
{
    self.seeAllBtn.hidden = NO;
    if (self.connectsArray.count == 0)
    {
        self.seeAllHeight.constant = 0.0;
        self.seeAllBtn.hidden = YES;
    }
    
    self.connectsCount.text = [NSString stringWithFormat:@"Connects(%lu)",(unsigned long)self.connectsArray.count];
    
    [self.connectsCollectionView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)seeAllPressed:(UIButton *)sender {
    
    if(self.delegate&&[self.delegate respondsToSelector:@selector(seeAllConnects)]){
        [self.delegate seeAllConnects];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.connectsArray.count > 6) {
        return 6;
    } else {
        return self.connectsArray.count;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ConnectUser *user = [self.connectsArray objectAtIndex:indexPath.row];
    ConnnectCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConnnectCell" forIndexPath:indexPath];
    
    [cell.dpImage sd_setImageWithURL:[NSURL URLWithString:user.avatar_file_name]
                      placeholderImage:nil
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 if(image){
                                 }else{
                                     
                                 }
                             }];
    cell.name.text = user.name;
    
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;

    
    return CGSizeMake(screenWidth/3.0, (screenWidth/3.0)+ 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(connectPressed:)]){
        [self.delegate connectPressed:indexPath];
    }
    
}


@end
