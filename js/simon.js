var colorArr = ['green', 'red', 'yellow', 'blue'];
var playerTurn = false;
var simonArr = [];
var playerArr = [];
var randomColor = 0;
var playerGuess = '';
var idx = 0;
var count = 0;
var gamePower = true;

var greenSound = new Audio('https://s3.amazonaws.com/freecodecamp/simonSound4.mp3');
var redSound = new Audio('https://s3.amazonaws.com/freecodecamp/simonSound3.mp3');
var yellowSound = new Audio('https://s3.amazonaws.com/freecodecamp/simonSound2.mp3');
var blueSound = new Audio('https://s3.amazonaws.com/freecodecamp/simonSound1.mp3');
var soundsArr = [greenSound, redSound, yellowSound, blueSound];

// Getting a color and pushing it to an array of computer moves.
function nextColor() {
	randomColor = colorArr[Math.floor(Math.random() * 4)];
	simonArr.push(randomColor);
	console.log(simonArr);
	return simonArr;
}

// Adding a glow effect and adding sound to computer moves.
function lightAndSound(simon) {
	// First setTimeout is delay between player move ending and computer move starting.
	setTimeout(function() {
		for (var i = 0; i < simon.length; i++) {
			(function(order) {
				// Second setTimeout is for delay between computer moves.
				setTimeout(function() {
					soundIdx = colorArr.indexOf(simon[order]);
					soundsArr[soundIdx].play();
					$('.' + simon[order]).addClass(simon[order] + '-glow');
					// Third setTimeout is for delay between removing glow effect.
					setTimeout(function() {
						$('.' + simon[order]).removeClass(simon[order] + '-glow')
					}, 500);
				}, order * 750);
			})(i);
		}
	}, 1000);
	playerTurn = true;
}

// Adding to the current score.
function score() {
	count++;
	if (count < 10) {
		$('.count').html('0' + count);
	} else {
		$('.count').html(count);
	}
}

$(document).ready(function() {
	$('.game-container').on('click', '.gameboard', function(e) {
		e.stopPropagation();
		if (playerTurn === true) {
			playerGuess = $(this)[0].id;
			playerArr.push(playerGuess);
			console.log(playerArr);

			$(this).fadeOut(200).fadeIn(200);
			soundIdx = colorArr.indexOf(playerGuess);
			soundsArr[soundIdx].play();

			if (simonArr[idx] === playerArr[idx]) {
				if (idx === simonArr.length - 1) {
					score();
					playerTurn = false;
					playerArr = [];
					idx = 0;
					nextColor();
					lightAndSound(simonArr);
				} else {
					idx++;
				}
			} else {
				alert('Loser!');
				playerTurn = false;
				simonArr = [];
				playerArr = [];
				idx = 0;
				count = 0;
				$('.count').html('--');
			}
		}
	});

	// Turns the game on and off.
	$('.power').on("click", function() {
		if (gamePower === true) {
			gamePower = false;
			$('.count').html('--');
			nextColor();
			lightAndSound(simonArr);
		} else {
			gamePower = true;
			$('.count').html('');
		}
	});

});