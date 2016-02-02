colorArr = ['green', 'red', 'yellow', 'blue']
playerTurn = false
simonArr = []
playerArr = []
randomColor = 0
playerGuess = ''
idx = 0
count = 0
gamePower = true
# Start sequence could be randomized, but this is the sequence I saw on a video online.
startSequence = ['green', 'red', 'blue', 'green', 'yellow', 'red', 'blue', 'green', 'yellow', 'red', 'green', 'red', 'green', 'yellow', 'blue', 'red', 'green', 'blue', 'red', 'yellow', 'green', 'red', 'blue', 'yellow']

# Making variables for all audio that is needed.
greenSound = new Audio 'https://s3.amazonaws.com/freecodecamp/simonSound4.mp3'
redSound = new Audio 'https://s3.amazonaws.com/freecodecamp/simonSound3.mp3'
yellowSound = new Audio 'https://s3.amazonaws.com/freecodecamp/simonSound2.mp3'
blueSound = new Audio 'https://s3.amazonaws.com/freecodecamp/simonSound1.mp3'
soundsArr = [greenSound, redSound, yellowSound, blueSound]
# Wrong sound isn't correct, but good enough for demo.
wrongSound = new Audio('https://www.freesound.org/data/previews/142/142608_1840739-lq.mp3')

# Start sequence doesn't have any sound in this version since I could not find one but a 6 second sound clip can be added.
startItUp = (sequence) ->
	# First setTimeout is delay between pressing start and starting intro sequence.
	setTimeout ->
		for i in [0...sequence.length]
			((order) ->
				# Second setTimeout is for delay between computer moves.
				setTimeout ->
					$('.' + sequence[order]).addClass(sequence[order] + '-glow')
					# Third setTimeout is for delay between removing glow effect.
					setTimeout ->
						$('.' + sequence[order]).removeClass(sequence[order] + '-glow')
					, 200
				, order * 250
			)(i)
	, 100
	# Fourth setTimeout is for delay before starting game waiting for initial sequence to end.
	setTimeout ->
		nextColor()
		lightAndSound(simonArr)
	, 7100

# Getting a color and pushing it to an array of computer moves.
nextColor = ->
	randomColor = colorArr[Math.floor(Math.random() * 4)]
	simonArr.push(randomColor)
	simonArr

# Adding a glow effect and sound to computer moves.
lightAndSound = (simon) ->
	# First setTimeout is delay between player move ending and computer move starting.
	setTimeout ->
		for i in [0...simon.length]
			((order) ->
				# Second setTimeout is for delay between computer moves.
				setTimeout ->
					soundIdx = colorArr.indexOf(simon[order])
					soundsArr[soundIdx].play()
					$('.' + simon[order]).addClass(simon[order] + '-glow')
					# Third setTimeout is for delay between removing glow effect.
					setTimeout ->
						$('.' + simon[order]).removeClass(simon[order] + '-glow')
					, speed()
				, order * (speed() + 50)
			)(i)
	, 850
	playerTurn = true

# Determining the time between computer moves based on skill level.
speed = ->
	if count < 5
		700
	else if count < 13
		650
	else
		600

# Adding to the current score.
score = ->
	count++
	if count < 10
		$('.count').html('0' + count)
	else
		$('.count').html(count)

$(document).ready ->
	$('.game-container').on('click', '.gameboard', (e) ->
		e.stopPropagation()
		if playerTurn == true
			playerGuess = $(this)[0].id
			playerArr.push(playerGuess)

			if simonArr[idx] == playerArr[idx]
				# Moved sound in this if else statement, so if move is wrong it will not play both sounds.
				soundIdx = colorArr.indexOf(playerGuess)
				soundsArr[soundIdx].play()
				# If the index number is now the same number as the computer array the turn has ended so player turns get reset.
				if idx == simonArr.length - 1
					score()
					playerTurn = false
					playerArr = []
					idx = 0
					nextColor()
					lightAndSound(simonArr)
				# Else the index increases by one and player goes again.
				else
					idx++
			else
				# If the player move is wrong everything is reset before a new game begins.
				wrongSound.play()
				playerTurn = false
				simonArr = []
				playerArr = []
				idx = 0
				count = 0
				$('.count').html('--')
				# Starts a new game in 3 seconds just like the real game.
				setTimeout ->
					nextColor()
					lightAndSound(simonArr)
				, 3000
	)

	# Turns the game on and off.
	$('.power').on('click', ->
		if gamePower == true
			gamePower = false
			$('.gameboard').removeAttr('disabled')
			$('.arrow').hide()
			$('.count').html('--')
			startItUp(startSequence)
		else
			gamePower = true
			$('.arrow').show()
			$('.count').html('')
			playerTurn = false
			$('.gameboard').attr('disabled', 'disabled')
			simonArr = []
			playerArr = []
			idx = 0
			count = 0
	)

	# Disables mobile scrolling.
	$(document).bind('touchmove', (e) ->
		e.preventDefault()
	)

	setTimeout ->
		$('.arrow').show()
	, 1250

# Reverse engineering a Simon game: http://goo.gl/pblIfM
