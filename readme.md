# Simon - A Game by Thomas Vaeth
### About
Simon is an electronic memory game. Four colored buttons each produce a tone and light when pressed. A round of the game consists of a button being activated by the computer and the player has to repeat the pattern. Each round repeats the same pattern and adds an additional button. The game opens with a pattern of 24 colors when first turned on, then starts with 1 after a few seconds. When the player makes a wrong move a buzzer will sound and a new game will start in a few seconds.
[Simon Wikipedia](https://en.wikipedia.org/wiki/Simon_(game))

### Technologies Used
* HTML
* CSS
* JavaScript
* jQuery
* Animate.CSS

### Approach Taken
I put CSS as a low priority. The game was built using a column of four different colored square divs, which was later turned to buttons, without sound. When the basic functionality was working I spent time on the CSS. The hardest part of the desktop CSS was getting the buttons to be rounded on the outside, but resolved after a day of searching. After the main CSS was done I spent a lot of time tinkering. I found an article about reverse engineering the game, so tried to get a lot of the timing to be similar. I gave media queries a shot when everything was done. I also added on extra features such as Animate.CSS to improve the look of the page.

### Unsolved Problems
* Player is able to click button when the computer is still doing the sequence.
* Player can turn the game off, but the computer will still complete the sequence.
* I did not build the page thinking mobile first, so there are problems with the landscape view.

### Desktop Screenshot
![Simon](https://github.com/thomasvaeth/ga-simon/blob/master/images/screenshot.png "Simon screenshot")