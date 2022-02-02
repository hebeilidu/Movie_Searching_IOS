I add three Creative Portions and one extra feature(for extra credit) in my Movie App:

Creative Portion:

1. What I implemented:

Apart from the required function. I add 3 creative features:

a. Users can save the current movie's poster image to the photos library.

Users can click the "save image" button and save the current movie's poster image to the photos library.
 
b.User can get to know the overview of the movie if he wants

Users can click the "overview" button to enter a new viewController to see the overview of the movie.

c. From the "my favorite" tableView user can also see the overview of the movie when they click the item.

Apart from delete the item and add the item to the favorite tableView. Users can also see the overview of the movie in the "My Favorite" page when they click the item.

2. How I implemented it

a. For the first part, I modify the Info.plist to ensure the users can save image view to the photo library and use the UIImageWriteToSavedPhotosAlbum() function to save the image.
 
b. For the second part, I add a button and a new viewController in the detailed page. People can see the overview of this movie if they want.

c. For the third part, I created a new view controller for tableView and in the rowdidselect function I push the overview page for the current selected movie item.

3. Why I implemented it

a. For the first part, it will be useful for users to save the current movie posters to their photo library in order for them to share them or watch them after they exit the movie app.

b. For the second part, put all the information in one page is very crowded and not clean. So I created a new page to contain the overview of the movie. If users want to know about the overview of the movie, they can choose to enter the new page.

C. For the third part, when users look at the "my favorite" page, they may forget what the movie they  selected is about. So it is necessary to let them know the overview about the movie in the table view.

Extra Point:

I have implemented a Context Menu for the movies in the UICollectionView. And the menu has “add to 
favorites” option. Users can use it to save the current movie into favorite without enter the detailed page.

