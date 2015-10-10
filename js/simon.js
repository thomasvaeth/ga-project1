var colorArr = ['green', 'red', 'yellow', 'blue'];
var simonArr = [];
var playerArr = [];
var randomColor = 0;

var greenSound = new Audio('https://s3.amazonaws.com/freecodecamp/simonSound4.mp3');
var redSound = new Audio('https://s3.amazonaws.com/freecodecamp/simonSound3.mp3');
var yellowSound = new Audio('https://s3.amazonaws.com/freecodecamp/simonSound2.mp3');
var blueSound = new Audio('https://s3.amazonaws.com/freecodecamp/simonSound1.mp3');
var sound = [greenSound, redSound, yellowSound, blueSound];

function nextColor() {
	randomColor = colorArr[Math.floor(Math.random() * 4)];
	simonArr.push(randomColor);
	return simonArr;
}


$(document).ready(function() {

});