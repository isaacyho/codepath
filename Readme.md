This is a Swift demo app for calculating tips. It was built in XCode 6.1.1 and tested in the ios simulator (iphone 5, ios 8.1)

Time spent: 8 hours ( including learning Swift from scratch / watching videos, but mostly getting the UIViews to do their thing )

Completed user stories:
- Required: User can input a bill amount, select a tip amount, and see the resulting total change
- Required: User can change the tip amounts to choose from by going to a separate Settings screen
- Optional: Borrow animation from the Tabber example upon editing the bill amount
- Optional: Upon restart, the app will remember the last bill amount ( for 10 minutes )
- New: User can record their tip % and track their historical average
- New: Upon restart, the app wil remember the tip amounts to choose from as well as historical average
- New: User can clear their historical average in the settings page and see it reflected back on the main page

Notes:
I went down the wrong path of trying to use modal view controllers for the tabber/UIView transition---(there's a tutorial online that does something similar but requires the non-deprecated segue types)
which meant a wasted hour plus...

Walkthrough of user stories:


![alt tag](https://github.com/isaacyho/codepath/blob/master/walkthru1.gif)
