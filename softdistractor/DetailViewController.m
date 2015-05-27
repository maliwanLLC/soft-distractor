//
//  DetailViewController.m
//  softdistractor
//
//  Created by Mykola Savula on 2/24/15.
//  Copyright (c) 2015 Maliwan. All rights reserved.
//

#import "DetailViewController.h"

#import "MWPulsatingDot.h"
#import "MWGlossButton.h"


@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet MWPulsatingDot *pulsar;
@property (nonatomic, weak) IBOutlet MWGlossButton *glossButton;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    [self.pulsar startDistration];
    [self.glossButton startDistration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
