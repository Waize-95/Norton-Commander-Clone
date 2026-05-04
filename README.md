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