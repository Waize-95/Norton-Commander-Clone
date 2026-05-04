# Norton-Commander-Clone
A DOS-style text-based file manager built in x86 Assembly (8086 real mode). Inspired by Norton Commander.

## Features
- Dual-panel UI
- Keyboard navigation
- Directory browsing

#### Daily Progress Report

##### - Day-1
Starting out my file manager, will be building it slowly and thoroughly. The first steps for today are clearing
the screen and making it blue; copying the color schemes of the norton commander; and after that print two
distinct boxes that will split the screen into two panels...After that we will move to reading files and populating the panels
##### Report
I am done with the panes and the background, the screen is successfully divided into two different smaller screens.

##### - Day-2
For the day 2 my goal is to make resuable functions like draw horizontal, draw vertical that will take any character,
attribute the x and y position and print that character throughout the screen either horizontally or verically
Also i will make the functions that will take a null terminated string and print that anywhere on the screen.
The string can contain either alphabets or numbers or special characters, it does not matter.
I am yet not making the checks regarding file names or any other thing, we will come to that later. Right now i am just making a file viewer, i will add the options to add and remove files and make files and directiories later.

##### Report
I have successfully made the utility functions, print, print horizontal and print vertical, now that utility functions are done, its time to use the utility functions and complete the interface of the file manager
![alt text](image.png)
May 4th, 3:11 AM, ui done and it looks like this, now only the file extraction logic is left which is harder :)

##### - Day-3
Today i will move onto making the selection logic, the selection logic includes the highlight text and higlighting the window pane options based on the bar that the user is currently using, we will also add keyboard handling. Whenever user presses ↑ ↓ the highlight bar will move up and down and whenever the user presses the tab key the active window will change. One more important feature is that whenever the higlight bar moves, only the two active rows will refresh not the whole ui design

##### Report
Successfully made the text highligher that works on both panes seperately.
![alt text](image-1.png)
Working for pane 1
![alt text](image-2.png)
Working for pane 2

Now the manager is fully keyboard controlled
- pressing the down arrow move to the next row
- pressing the up arrow moves to the previous row
- pressing the tab changed the pain
- pressing the esc exits the program

###### important features
When at the last row, pressing the down arrow key moves to the first row of the file listings
similarly when at the first row, pressing the up arrow key moves to the last accessible file.

##### Next Steps
i cant jump straight onto the file reading logic from the System, i still have a long way to go because i still
have to figure out how will i handle navigation, how will i handle directories vs files so first of all i am 
going to create a list of fake files(no directories yet) than i will map those files to rows and also add the 
navigation meaning that if the number of file exceeds the limit of rows on which i can map them, i will scroll
down to view more and when i scroll back up the previous files will be loaded.
After i successfully do this, i will move onto the directories issue and than the file reading , file writing 
and file editing and if later i want i can also add a column showing the extensions of the files.