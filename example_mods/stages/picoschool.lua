
local InCutscenePenis = false

local flashinglights = false

function onCreate()

	

	initSaveData('flashinglights', 'FreakySaturday')
	flashinglights = getDataFromSave('flashinglights', 'hasflashinglights')

	setPropertyFromClass('GameOverSubstate', 'characterName', 'pitogameover'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'picodies'); --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd'); --put in mods/music/


--ACTUAL SCRIPT

	makeLuaSprite('redflash','cassandra/redflash',150,-25)
	setLuaSpriteScrollFactor('redflash',160,90)
	addLuaSprite('redflash',true)
	scaleObject('redflash',1.5,1.5)
	setObjectCamera('redflash', 'camHUD');
	setProperty('redflash.alpha', 0);
	setObjectOrder("redflash", getObjectOrder('notes') + 1)



--REF FOR POSITIONS
	makeLuaSprite('ref', 'cassandra/ref', 0, 0);
	setLuaSpriteScrollFactor('ref', 1, 1);
	scaleObject('ref', 1.2, 1.2);

	makeLuaSprite('balcony', 'cassandra/balcony', -265, 260);
	setLuaSpriteScrollFactor('balcony', 1, 1);
	scaleObject('balcony', 1.2, 1.2);

	makeLuaSprite('bgBack', 'cassandra/Back', -530, -120);
	setLuaSpriteScrollFactor('bgBack', 1, 1);
	scaleObject('bgBack', 1.2, 1.2);

	makeAnimatedLuaSprite('blood', 'cassandra/blood', 525, 325);
	luaSpriteAddAnimationByPrefix('blood', 'cutscene', 'blood', 24, false);
	setProperty('blood.alpha', 0)
	
	scaleObject('blood', 1.35, 1.35);

	makeAnimatedLuaSprite('punkguy', 'cassandra/punkguy', 520, 240);
	luaSpriteAddAnimationByPrefix('punkguy', 'idle', 'BopGuy1_Idle', 24, false);
	luaSpriteAddAnimationByPrefix('punkguy', 'cutscene', 'PUNKGUY_CUTSCENE', 24, false);
	luaSpritePlayAnimation('punkguy', 'idle');
	scaleObject('punkguy', 1.25, 1.25);

	makeAnimatedLuaSprite('coolguy', 'cassandra/coolguy', 610, 260);
	luaSpriteAddAnimationByPrefix('coolguy', 'idle', 'CoolGuy2_Idle', 24, false);
	luaSpriteAddAnimationByPrefix('coolguy', 'cutscene', 'COOLGUY_CUTSCENE', 24, false);
	luaSpritePlayAnimation('coolguy', 'idle');
	scaleObject('coolguy', 1.25, 1.25);


	makeLuaSprite('bgBack', 'cassandra/Back', -530, -120);
	setLuaSpriteScrollFactor('bgBack', 1, 1);
	scaleObject('bgBack', 1.2, 1.2);

	--setProperty('bgBack.alpha', .5)

	addLuaSprite('ref', false);

	addLuaSprite('bgBack', false);

	
	addLuaSprite('blood', false);

	addLuaSprite('punkguy', true);
	addLuaSprite('coolguy', true);

	addLuaSprite('balcony', false);

	setObjectOrder("balcony", getObjectOrder('boyfriendGroup') - 1)
end

function onEvent(name, value1, value2)
	if name == 'penis' then
		InCutscenePenis = true
		for i = 0, getProperty('playerStrums.length')-1 do
			setPropertyFromGroup('playerStrums',i,'visible',false)
		end
		setProperty('healthBarBG.visible', false);
		setProperty('healthBar.visible', false);

		characterPlayAnim('dad', 'peniscutscene', true);
		setProperty('dad.specialAnim', true);

		setProperty('punkguy.x', 510)
		setProperty('punkguy.y', 230)
		luaSpritePlayAnimation('punkguy', 'cutscene');
		luaSpritePlayAnimation('coolguy', 'cutscene');

		setProperty('blood.alpha', 1)
		luaSpritePlayAnimation('blood', 'cutscene');
	end

	if name == 'endpenis' then
		--InCutscenePenis = false
		for i = 0, getProperty('playerStrums.length')-1 do
			setPropertyFromGroup('playerStrums',i,'visible',true)
		end
		setProperty('healthBarBG.visible', true);
		setProperty('healthBar.visible', true);
		setObjectOrder("punkguy", getObjectOrder('dadGroup') - 1)
		setObjectOrder("coolguy", getObjectOrder('dadGroup') - 1)
	end

	if name == 'redflash' then
		cancelTween('redflash')
		cancelTween('redflashlongIN')
		cancelTween('redflashlongOUT')
		flashinglights = getDataFromSave('flashinglights', 'hasflashinglights')
		if flashinglights == true then
			if value1 == '' then
				setProperty('redflash.alpha', 1);
				doTweenAlpha('redflash', 'redflash', '0', 0.75, 'quadOut')
			end
			if value1 == 'long' then
				setProperty('redflash.alpha', 0);
				doTweenAlpha('redflashlongIN', 'redflash', '1', 0.6, 'quadOut')
			end
		end
	end

	if name == 'cassandrashake' then
		flashinglights = getDataFromSave('flashinglights', 'hasflashinglights')
		if flashinglights == true then
			cameraShake("camGame", 0.02, 3)	
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if InCutscenePenis ==  true then
		flashinglights = getDataFromSave('flashinglights', 'hasflashinglights')
		if flashinglights == true then
			cameraShake("camGame", 0.005, 0.2)	
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)

end


function onTweenCompleted(tag)
	if tag == 'redflashlongIN' then
		doTweenAlpha('redflashlongOUT', 'redflash', '0', 0.6, 'quadOut')
	end
end


function onBeatHit()
	if InCutscenePenis == false then
		luaSpritePlayAnimation('punkguy', 'idle');
		luaSpritePlayAnimation('coolguy', 'idle');
	end

end

function onCountdownTick(counter)
	luaSpritePlayAnimation('punkguy', 'idle');
	luaSpritePlayAnimation('coolguy', 'idle');
end

function onUpdate()

	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F10') then
		removeLuaText('FL_Toggle', false)
    end	
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F9') then

		makeLuaText('FL_Toggle', 'ERROR DUMB SHIT', 0, 175, 150)

		addLuaText('FL_Toggle');

	end
	
	setTextString('FL_Toggle', flashinglights4text)

end

function onUpdatePost()
	--This code FUCKING SUCKS but for some reason I cant put bools in the text string so fuck you
	flashinglights4text = 'ERROR, YOU SUCK'

if flashinglights == true then
	flashinglights4text = 'Flashing Lights: true'
else
	flashinglights4text = 'Flashing Lights: false'
end

end