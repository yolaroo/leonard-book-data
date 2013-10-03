//
//  LeonardData.m
//  worknow
//
//  Created by MGM on 9/23/13.
//  Copyright (c) 2013 Yolaroo. All rights reserved.
//

#import "BookLoad.h"
#import "BookData.h"

@implementation BookLoad

#pragma mark - The Data

- (NSArray*) loadSentenceData {
    
    NSArray*mySentences = [NSArray arrayWithObjects:
                        @"Leonard's Pond.",
                        @"This strong cat is Leonard. He's a lion.",
                        @"His hair is gold and brown. It smells like grass.",
                        @"He has big paws and a small short tail.",
                        @"He roams from the big rock to the river trail.",
                        
                        @"Leonard likes to relax and enjoy life.",
                        @"Today he sits and watches the wind blow.",
                        @"Yesterday he sat and viewed the grass grow.",
                        @"Tomorrow Leonard will take a long nap.",
                        
                        @"Everywhere Leonard went he made a mess.",
                        @"All of his things were laid about and growing pests.",
                        @"Big trouble had spawned just beyond the pond.",
                        @"Dark as a storm there flew a great fly swarm.",
                        
                        @"Ten, a hundred, a thousand flies came in",
                        @"to his cave buzzing building homes all night.",
                        @"The flies loved him and his genius for blight.",
                        @"He wished the bugs would turn fast round and go,",
                        @"but the den was a perfect pest chateau.",
                        
                        @"Leonard could not sleep and he could not eat",
                        @"on his eyes his ears his food they put their feet.",
                        @"Leonard said, 'Please be quiet. Leave me alone.'",
                        @"Nature ignored the sound of his sad groan.",
                        
                        @"His wild feline body let out a roar.",
                        @"Taking his things he left through the door.",
                        @"He spoke as he walked 'I'm leaving. I’m gone.",
                        @"I admit defeat. I retreat. I move on.'",
                        
                        @"Leonard found a den far from river or stream.",
                        @"He laid down his things and began to dream.",
                        @"But soon his ears could hear a familiar buzz.",
                        @"Swiftly the flies had tracked him to where he was.",
                        
                        @"Cross deserts, mountains and sea they'd sworn to go.",
                        @"Those who live in junk should expect it so.",
                        @"His anger arose and travelled up from his toes.",
                        @"In lion's fire his hands became clenched and closed.",
                        
                        @"Cats with sharp claws and giant white deadly teeth",
                        @"cannot battle flies. He cracked underneath.",
                        @"He looked on in fear. He ran until it hurt.",
                        @"His paws dug a hole. He hid in the dirt.",
                        
                        @"He coughed and he sneezed. He kicked and he wheezed.",
                        @"With a burrow as a home he was very displeased.",
                        @"He wished his calm past would soon be reprised,",
                        @"but crawling on his mane were ten little flies.",
                        @"Despair overtook him. His hopes had fled.",
                        @"Dirt burned. His eyes were made muddy brown red.",
                        
                        @"Slowly his faith and his courage he regained.",
                        @"His feet jumped up refused to be chained.",
                        @"On his path grass became rock. Rivers turned to vast lakes.",
                        @"Great long hills he climbed. His bones did not break.",
                        
                        @"For miles he traveled with no stops for rest.",
                        @"He found the highest tree. He climbed to its crest.",
                        @"High above the clouds the branches bowed.",
                        @"His weight was too great. The crack echoed loud.",
                        
                        @"Leonard slid down to the far below ground.",
                        @"His hands let go.  His feet hit the snow.",
                        @"He sat. He cried while his sighs floated up high in the sky.",
                        
                        @"'Shhh be quiet. Stop the noise.' Leonard heard.",
                        @"He looked down and saw a dozen flies had stirred.",
                        @"They sat on his chest and would not depart.",
                        @"They found comfort next to his strong lion heart.",
                        
                        @"Where to go? What paths were there to travel?",
                        @"His legs wobbled and began to unravel.",
                        @"The cold mountain air caught him. He sailed.",
                        @"He was covered in snow from his nose to his tail.",
                        @"Slowly he rolled. He began to tumble.",
                        @"He stopped at the bottom of the mountain.",
                        @"He was broken, crumbled.",
                        
                        @"He crawled to a lake and fell in to his thighs.",
                        @"The gentle waves cleaned his fur of the flies.",
                        @"Five fat frogs who were brothers all named Fred",
                        @"they sat and ate till all the flies were dead.",
                        
                        @"Ribbiting they spoke, 'Beware. Come back to the land.",
                        @"The lake is cold. Sit here on the warm sand.",
                        @"In these waters there lives a mean crocodile named Crunch.",
                        @"He'll eat you for a snack before lunch.'",
                        @"Leonard swam ashore happy that the pests did not win.",
                        @"He lay on the beach with a big kitty grin.",
                        
                        @"Far off Crunch's eyes glared bright in the sun.",
                        @"Yum yum yum. Today his food would be fun.",
                        
                        @"The End",

                        nil];
    
    return mySentences;
    
}

- (NSArray*) loadPageData {
    
    NSArray *countSentencesByPage = [NSArray arrayWithObjects:
                                     @"5",@"4",@"4",@"5",@"4",
                                     @"4",@"4",@"4",@"4",@"6",
                                     @"4",@"4",@"3",@"4",@"7",
                                     @"4",@"6",@"2",@"1",
                                     nil];
    
    return countSentencesByPage;
}

#pragma mark - Write sentence numbers for each page

- (NSArray* ) pageCount {

    NSArray*mySentences = [self loadSentenceData];
    NSMutableArray *myPageCount = [NSMutableArray arrayWithCapacity:[mySentences count]];

    NSArray *countSentencesByPage = [self loadPageData];

    int theMainCount = 0;
    int theSmallCount = 0;
    NSString*theMainCountString;
    NSString*theSmallCountString;
    
    for (int j=0;j<[mySentences count];j++) {
        
        theSmallCount ++;
        theSmallCountString = [NSString stringWithFormat: @"%d", theSmallCount];
        theMainCountString = [NSString stringWithFormat: @"%d", theMainCount+1];
        [myPageCount insertObject:theMainCountString atIndex:(int)j];
        
        if ([theSmallCountString isEqualToString:[countSentencesByPage objectAtIndex:theMainCount]]) {
            theMainCount++;
            theSmallCount=0;
        }
    }
    //NSLog(@"%@",myPageCount);
    return [myPageCount copy];
}

#pragma mark - Create the Object

- (NSArray*) loadBookData {

    NSArray*mySentences = [self loadSentenceData];
    NSArray*myPageSentenceCountData = [self pageCount];
    NSMutableArray* myBook=[NSMutableArray arrayWithCapacity:[mySentences count]];

    for(int i=0;i<[mySentences count];i++) {
        BookData*myBookData = [[BookData alloc] init];
        myBookData.thePageNumber=[[myPageSentenceCountData objectAtIndex:i] integerValue];

        //NSLog(@"%d",myBookData.thePageNumber);

        myBookData.theSentenceNumber=i;
        myBookData.theSentence=[mySentences objectAtIndex:i];
        [myBook insertObject:myBookData atIndex:i];
        
    }
    return [myBook copy];
}

@end

/*
- (NSArray*) sentenceCount {
    
    NSArray*mySentences = [self loadSentenceData];
    
    NSMutableArray *sentenceCount = [NSMutableArray arrayWithCapacity:[mySentences count]];
    
    for(int i=0;i<[mySentences count];i++) {
        NSString*myString = [NSString stringWithFormat: @"%d", i];
        [sentenceCount insertObject:myString atIndex:(int)i];
    }
    
    return [sentenceCount copy];
}
*/


