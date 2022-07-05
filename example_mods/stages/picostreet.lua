local uberkidDead = false
local uberkidIsInFront = false
local deathAnimPlaying = false
local didEmergencyCreate = false
local InCutsceneBus = false

local CountDownOfDeath = 6

function onCreate()

--SETUP GAMEOVER
	setPropertyFromClass('GameOverSubstate', 'characterName', 'pitogameover'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'picodies'); --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd'); --put in mods/music/

	
	
--God bless you Shade from the Psych Engine Discord im too dumb to know how to do this

--ACTUAL SCRIPT

--IMAGES PRECACHE
    precacheImage('characters/pitogameover')

--SOUNDS PRECACHE
	precacheSound('gunshot')
	precacheSound('throwmic')
	precacheSound('gunout')
	precacheSound('micout')
	precacheSound('reload')
	precacheSound('blood')
	precacheSound('bulletfall')
	precacheSound('countdown')
	precacheSound('debug')

--STAGE SHIT
	makeLuaSprite('sky', 'mindchamber/sky', -310, -100);
	setLuaSpriteScrollFactor('sky', 0.8, 0.8);
	scaleObject('sky', 1, 1);

	makeLuaSprite('buildings', 'mindchamber/buildings', -310, -100);
	setLuaSpriteScrollFactor('buildings', 0.9, 0.9);
	scaleObject('buildings', 1, 1);

	makeAnimatedLuaSprite('flickeringlights', 'mindchamber/FlickerLights', -325, -100);
	luaSpriteAddAnimationByPrefix('flickeringlights', 'glow', 'Glow', 1, false);
	luaSpriteAddAnimationByPrefix('flickeringlights', 'flicker', 'Flicker', 12, false);
	luaSpritePlayAnimation('flickeringlights', 'glow');

	scaleObject('flickeringlights', 1, 1);
	setLuaSpriteScrollFactor('flickeringlights', 0.95, 0.95);
	setProperty('flickeringlights.alpha', 0.1);

	makeLuaSprite('floor', 'mindchamber/floor', -310, -100);
	setLuaSpriteScrollFactor('floor', 1, 1);
	scaleObject('floor', 1, 1);


--BUS CUTSCENE SHIT
    makeAnimatedLuaSprite('buscoming', 'mindchamber/BusComing', 250, -9999);
    luaSpriteAddAnimationByPrefix('buscoming', 'bus1', 'BusComing0', 24, false);
    luaSpriteAddAnimationByPrefix('buscoming', 'bus2', 'BusComing2', 24, false);
    luaSpritePlayAnimation('buscoming', 'bus1');
    scaleObject('buscoming', 1.2, 1.2);
    setLuaSpriteScrollFactor('buscoming', 0.9, 0.9);
    setProperty('buscoming.alpha', 1);
 
	makeAnimatedLuaSprite('bgUberkids', 'mindchamber/bgUberkids', 85, 250);
	luaSpriteAddAnimationByPrefix('bgUberkids', 'idle', 'bguberkids0', 24, false);
	luaSpriteAddAnimationByPrefix('bgUberkids', 'bus', 'bguberkidsBUS', 24, false);
	luaSpritePlayAnimation('bgUberkids', 'idle');
	scaleObject('bgUberkids', 1, 1);
	setLuaSpriteScrollFactor('bgUberkids', 0.9, 0.9);

	makeAnimatedLuaSprite('frontbgUberkids', 'mindchamber/frontbgUberkids', -115, 300);
	luaSpriteAddAnimationByPrefix('frontbgUberkids', 'idle', 'frontbguberkids0', 24, false);
	luaSpriteAddAnimationByPrefix('frontbgUberkids', 'bus', 'frontbguberkidsBUS', 24, false);
	luaSpritePlayAnimation('frontbgUberkids', 'idle');
	scaleObject('frontbgUberkids', 1, 1);
	setLuaSpriteScrollFactor('frontbgUberkids', 1.1, 1.1);

	makeAnimatedLuaSprite('otherfrontbgUberkids', 'mindchamber/frontbgUberkids', 440, 300);
	luaSpriteAddAnimationByPrefix('otherfrontbgUberkids', 'idle', 'frontbguberkids0', 24, false);
	luaSpriteAddAnimationByPrefix('otherfrontbgUberkids', 'bus', 'frontbguberkidsBUS', 24, false);
	luaSpritePlayAnimation('otherfrontbgUberkids', 'idle');
	scaleObject('otherfrontbgUberkids', 1, 1);
	setLuaSpriteScrollFactor('otherfrontbgUberkids', 1.1, 1.1);
	setPropertyLuaSprite('otherfrontbgUberkids', 'flipX', true);

--UBERKIDS SHIT
	makeAnimatedLuaSprite('walkingUberkid', 'mindchamber/uberkidWalk', 750, 217);
	luaSpriteAddAnimationByPrefix('walkingUberkid', 'run', 'walk', 24, true);
	luaSpritePlayAnimation('walkingUberkid', 'run');
	setLuaSpriteScrollFactor('walkingUberkid', 1, 1);

	makeAnimatedLuaSprite('boopinUberkid', 'mindchamber/uberkidShit', 500, 1000);
	luaSpriteAddAnimationByPrefix('boopinUberkid', 'bop', 'idle', 24, false);
	luaSpriteAddAnimationByPrefix('boopinUberkid', 'die', 'die', 24, false);
	luaSpritePlayAnimation('boopinUberkid', 'bop');
	setLuaSpriteScrollFactor('boopinUberkid', 1, 1);

--BF SIDE UBERKID
    makeAnimatedLuaSprite('uberkidbf', 'mindchamber/uberkidbf', -350, 217);
    luaSpriteAddAnimationByPrefix('uberkidbf', 'run', 'walkbf', 24, true);
    luaSpriteAddAnimationByPrefix('uberkidbf', 'die', 'diebf', 24, false);
    luaSpritePlayAnimation('uberkidbf', 'run');
    setLuaSpriteScrollFactor('uberkidbf', 1, 1);


--COUNTDOWN NUMBER, YES MY CODE SUCKS BUT IT'LL WORK OK TRUST ME
	makeAnimatedLuaSprite('numbers', 'mindchamber/numbers', 580, 250);
	luaSpriteAddAnimationByPrefix('numbers', 'one', 'one', 24, true);
	luaSpriteAddAnimationByPrefix('numbers', 'two', 'two', 24, true);
	luaSpriteAddAnimationByPrefix('numbers', 'three', 'three', 24, true);

	luaSpritePlayAnimation('numbers', 'three');
	setLuaSpriteScrollFactor('numbers', 1, 1);
	scaleObject('numbers', 2, 2);
	setProperty('numbers.alpha', 0);

--
	makeAnimatedLuaSprite('bulletfall', 'mindchamber/bulletfall', 170, 240);
	luaSpriteAddAnimationByPrefix('bulletfall', 'bulletfall', 'bulletfall', 24, false);
	scaleObject('bulletfall', 1.25, 1.25);
	setProperty('bulletfall.y', 9999);

--STAGE BUILDING

	addLuaSprite('sky', false);
	addLuaSprite('buildings', false);
	addLuaSprite('buscoming', false);
	addLuaSprite('flickeringlights', false);
	addLuaSprite('floor', false);

	addLuaSprite('bgUberkids', false);

	addLuaSprite('walkingUberkid', false);
	addLuaSprite('boopinUberkid', false);
	addLuaSprite('uberkidbf', false);

	addLuaSprite('numbers', true);
	addLuaSprite('bulletfall', true);
	
	addLuaSprite('frontbgUberkids', true);
	addLuaSprite('otherfrontbgUberkids', true);

	makeLuaText('debugText', 'ERROR DUMBASS', 0, 175, 150)
	addLuaText('debugText')
	setProperty('debugText.alpha', 0)
end


function onEvent(name, value1, value2)
	--MAKE THE UBERKID START GOING
    if name == 'makeuberkidRUN' then
		if deathAnimPlaying == true then
			didEmergencyCreate = true	
			--setProperty('boopinUberkid.alpha', 0);
			setProperty('boopinUberkid.x', 500)
			setProperty('boopinUberkid.y', 1000)
			uberkidDead = false
			uberkidIsInFront = false	
			
		end
		if uberkidDead == false and uberkidIsInFront == false  then
			--setProperty('boopinUberkid.alpha', 0);
			setProperty('boopinUberkid.y', 1000)
			cancelTween('hegointoPico')
			setProperty('walkingUberkid.x', 750)
			doTweenX('hegointoPico', 'walkingUberkid', 500, 1, 'linear')
		end
    end

	if name == 'Play Animation' then
		if value1 == "weaponOut" then
			if value2 == "BF" then
				playSound('gunout', 1)
			end
		end

		if value1 == "weaponOut" then
			if value2 == "Dad" then
				playSound('micout', 1)
			end
		end

	end

	if name == 'bus' then
		InCutsceneBus = true
		for i = 0, getProperty('playerStrums.length')-1 do
			setPropertyFromGroup('playerStrums',i,'visible',false)
		end
		setProperty('healthBarBG.visible', false);
		setProperty('healthBar.visible', false);

		doTweenZoom('begin', 'camGame', '1.3', 1, 'quadOut')

		characterPlayAnim('boyfriend', 'buscutscene', true);
		setProperty('boyfriend.specialAnim', true);

		characterPlayAnim('dad', 'bus', true);
		setProperty('dad.specialAnim', true);

		setProperty('bgUberkids.x', -310)
		setProperty('bgUberkids.y', 40)
		luaSpritePlayAnimation('bgUberkids', 'bus');

		setProperty('frontbgUberkids.offset.x', 269);
		setProperty('frontbgUberkids.offset.y', 49);
		setProperty('otherfrontbgUberkids.offset.x', 120);
		setProperty('otherfrontbgUberkids.offset.y', 49);
		luaSpritePlayAnimation('frontbgUberkids', 'bus');
	    luaSpritePlayAnimation('otherfrontbgUberkids', 'bus');

		luaSpritePlayAnimation('buscoming', 'bus1');
		setProperty('buscoming.y', 150)
	

	end

	if name == 'endbus' then
		setProperty('bgUberkids.y', -9999)
		setProperty('buscoming.y', -9999)
		for i = 0, getProperty('playerStrums.length')-1 do
			setPropertyFromGroup('playerStrums',i,'visible',true)
		end
		setProperty('healthBarBG.visible', true);
		setProperty('healthBar.visible', true);

		doTweenZoom('end', 'camGame', '1.2', 1, 'quadOut')

	end

	if name == 'bfattack' then
		if difficulty == 0 then
		setProperty('uberkidbf.x', -350)
		cancelTween('hegointoBF')
		luaSpritePlayAnimation('uberkidbf', 'run');
	    doTweenX('hegointoBF', 'uberkidbf', -100, (((60000/curBpm)*3)/1000) -0.05, 'linear')
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'BulletNote' then

		if uberkidIsInFront == false or uberkidIsInFront == true and uberkidDead == true then
			playSound('reload', 1)
			for i = 1, 10, 1 do
				characterPlayAnim('boyfriend', 'reload', true);
				setProperty('boyfriend.specialAnim', true);
			end
		end

		if uberkidIsInFront == true and uberkidDead == false then
		
			cancelTimer('countForDEATH')

			CountDownOfDeath = 6
			uberkidDead = true

			playSound('gunshot', 0.7)
	
			--cameraFlash('camGame', 'ffffff', 0.15, true);
			cameraShake('camGame', 0.015, 0.15);
	
			playSound('blood', 1)

			--I OUTSMART BULLET
	        
	        luaSpritePlayAnimation('bulletfall', 'bulletfall');
			setProperty('bulletfall.y', 240);
		    --playSound('bulletfall', 1)

			
			for i = 1, 10, 1 do
				characterPlayAnim('boyfriend', 'shoot', true);
				setProperty('boyfriend.specialAnim', true);
				deathAnimPlaying = true
				setProperty('boopinUberkid.x', 450)
				luaSpritePlayAnimation('boopinUberkid', 'die');
			end

			doTweenAlpha('AppearCoundownNumbers', 'numbers', '0', 0.3, 'linear')
			doTweenY('AppearCoundownNumbersY', 'numbers', '250', 0.3, 'linear')

			runTimer('waitfortheDeadAnim', 0.7, 1)

		end

	end
end

--CHECKS FOR WHEN THE UBERKID DEATH ANIMATION IS DONE
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'waitfortheDeadAnim' then
		--doTweenX('yeahHeDead1', 'boopinUberkid', 2000, 0.5, 'linear')

		if didEmergencyCreate == false then
			deathAnimPlaying = false
			--setProperty('boopinUberkid.alpha', 0);
			setProperty('boopinUberkid.y', 1000)
			setProperty('boopinUberkid.x', 500)
			for i = 1, 10, 1 do
				uberkidDead = false
				uberkidIsInFront = false	
			end
		end
		if didEmergencyCreate == true then
			deathAnimPlaying = false
			didEmergencyCreate = false
		end
	end

	if tag == 'countForDEATH' then

		setProperty('numbers.scale.y', 3);
		setProperty('numbers.scale.x', 3);

		doTweenX('numbersxsize', 'numbers.scale', 2, 0.3, circInOut)
		doTweenY('numbersysize', 'numbers.scale', 2, 0.3, circInOut)

		CountDownOfDeath = CountDownOfDeath - 1

		--YANDERE DEV TYPE CODE, TOO LAZY TO MAKE IT BETTER
		if CountDownOfDeath == 1 then
			luaSpritePlayAnimation('numbers', 'one');
		end
		if CountDownOfDeath == 2 then
			luaSpritePlayAnimation('numbers', 'two');
		end
		if CountDownOfDeath == 3 then
			luaSpritePlayAnimation('numbers', 'three');
		end

		if CountDownOfDeath < 4 then
			if CountDownOfDeath > 0 then
				doTweenAlpha('AppearCoundownNumbers', 'numbers', '1', 0.3, 'linear')
				doTweenY('AppearCoundownNumbersY', 'numbers', '150', 0.3, 'linear')
				playSound('countdown', 1)
			end
		end
	end

	if tag == 'FlickerLights' then
		luaSpritePlayAnimation('flickeringlights', 'flicker');
	end
end

function onTweenCompleted(tag)

	--STUFF WHEN UBERKID IS IN FRONT OF PICO
	if tag == 'hegointoPico' then
		uberkidDead = false
		uberkidIsInFront = true

		--START TIMER
		runTimer('countForDEATH', 1.069, 6)

		cancelTween('hegointoPico')
		setProperty('walkingUberkid.x', 750)
		setProperty('boopinUberkid.y', 217)
		--setProperty('boopinUberkid.alpha', 1);
	end

	if tag == 'hegointoBF' then
		cancelTween('hegointoBF')
		characterPlayAnim('dad', 'micattack', true);
		setProperty('dad.specialAnim', true);

		playSound('throwmic', 1)
		cameraShake('camGame', 0.015, 0.15);
	    playSound('blood', 1)
		
		luaSpritePlayAnimation('uberkidbf', 'die');
	end

end


function onBeatHit()
	
	--MAKES SURE TO NOT BOP WHILE BEING DEAD
	if InCutsceneBus == false then
		luaSpritePlayAnimation('bgUberkids', 'idle');
		luaSpritePlayAnimation('frontbgUberkids', 'idle');
		luaSpritePlayAnimation('otherfrontbgUberkids', 'idle');
		
	end
	if uberkidDead == false then
		luaSpritePlayAnimation('boopinUberkid', 'bop');
	end

	if curBeat % 4 == 0 then
        if math.random(1, 50) <= 15 then
			runTimer('FlickerLights', math.random(0.1, 0.6), math.random(1, 4))
        end
    end

end

function onUpdate()

	if getProperty('uberkidbf.animation.curAnim.name') == 'die' and getProperty('uberkidbf.animation.curAnim.finished') == true then
	    setProperty('uberkidbf.x', -350)
	end

	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F10') then

		setProperty('debugText.alpha', 0)
	end	
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F9') then

		
		setProperty('debugText.alpha', 1)
	end

	if CountDownOfDeath == 0 then
		if uberkidDead == false then
			setProperty('health', -500)
		end
	end

end	

function onCountdownTick(counter)

	luaSpritePlayAnimation('bgUberkids', 'idle');
	luaSpritePlayAnimation('frontbgUberkids', 'idle');
	luaSpritePlayAnimation('otherfrontbgUberkids', 'idle');

	if counter == 3 then--GO!
--SHITTY COLOR TWEENS
		doTweenColor('nighttimebaby', 'boyfriend', '4B45A5', 90, 'linear')
		doTweenColor('nighttimebaby2', 'dad', '4B45A5', 90, 'linear')
		doTweenColor('nighttimebaby3', 'floor', '4B45A5', 90, 'linear')
		doTweenColor('nighttimebaby4', 'buildings', '4B45A5', 90, 'linear')


		doTweenColor('nighttimebaby5', 'sky', '2B218A', 90, 'linear')

		doTweenColor('nighttimebaby6', 'bgUberkids', '4B45A5', 90, 'linear')
		doTweenColor('nighttimebaby7', 'walkingUberkid', '4B45A5', 90, 'linear')
		doTweenColor('nighttimebaby8', 'boopinUberkid', '4B45A5', 90, 'linear')

		
		doTweenAlpha('nighttimebaby9', 'flickeringlights', 0.15, 90, 'linear')

		doTweenColor('nighttimebaby10', 'buscoming', '4B45A5', 90, 'linear')

		doTweenColor('nighttimebaby11', 'bulletfall', '4B45A5', 90, 'linear')

		doTweenColor('nighttimebaby12', 'uberkidbf', '4B45A5', 90, 'linear')
		doTweenColor('nighttimebaby13', 'frontbgUberkids', '4B45A5', 90, 'linear')
		doTweenColor('nighttimebaby14', 'otherfrontbgUberkids', '4B45A5', 90, 'linear')

		
	end
end

function onUpdatePost()
	--This code FUCKING SUCKS but for some reason I cant put bools in the text string so fuck you
uberkidDead4text = 'ERROR, YOU SUCK'
uberkidIsInFront4text = 'ERROR, YOU SUCK'
deathAnimPlaying4text = 'ERROR, YOU SUCK'
didEmergencyCreate4text = 'ERROR, YOU SUCK'

if uberkidDead == true then
	uberkidDead4text = 'Dead Kid: true'
else
	uberkidDead4text = 'Dead Kid: false'
end
if uberkidIsInFront == true then
	uberkidIsInFront4text = 'In Front: true'
else
	uberkidIsInFront4text = 'In Front: false'
end
if deathAnimPlaying == true then
	deathAnimPlaying4text = 'Death Anim: true'
else
	deathAnimPlaying4text = 'Death Anim: false'
end
if didEmergencyCreate == true then
	didEmergencyCreate4text = 'Emergency: true'
else
	didEmergencyCreate4text = 'Emergency: false'
end

	setTextString('debugText', uberkidDead4text..'\n'..uberkidIsInFront4text..'\n'..deathAnimPlaying4text..'\n'..didEmergencyCreate4text..'\n'..'Countdown: '..CountDownOfDeath..'\n')
end