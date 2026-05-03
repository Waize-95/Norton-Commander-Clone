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