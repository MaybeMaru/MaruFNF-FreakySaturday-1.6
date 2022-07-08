
didthepenisShit = false

flashinglights = false

guysWithIdles = {
    {'punkguy', 'idle', true},
	{'coolguy', 'idle', true},
}

soundsPrecache = {
    {},
}

imagePrecache = {
    {},
}

function onCreate()

	initSaveData('flashinglights', 'FreakySaturday')
	flashinglights = getDataFromSave('flashinglights', 'hasflashinglights')

	setPropertyFromClass('GameOverSubstate', 'characterName', 'pitogameover'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'picodies'); --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd'); --put in mods/music/


    makeBgIMAGES('bgBack', 'Back', -530, -120, 1, 1.2, false, 1, false)

	makebgANIMATED('blood', 'blood', 525, 325, 1, 1.35, false, 0, false)
	addbgANIMATION('blood', 'cutscene', 'blood', 24, false, 'blood')

	makebgANIMATED('punkguy', 'punkguy', 520, 240, 1, 1.25, true, 1, false)
	addbgANIMATION('punkguy', 'idle', 'BopGuy1_Idle', 24, false, 'idle')
	addbgANIMATION('punkguy', 'cutscene', 'PUNKGUY_CUTSCENE', 24, false, 'idle')

	makebgANIMATED('coolguy', 'coolguy', 610, 260, 1, 1.25, true, 1, false)
	addbgANIMATION('coolguy', 'idle', 'CoolGuy2_Idle', 24, false, 'idle')
	addbgANIMATION('coolguy', 'cutscene', 'COOLGUY_CUTSCENE', 24, false, 'idle')

    makeBgIMAGES('balcony', 'balcony', -265, 260, 1, 1.2, false, 1, false)
	setObjectOrder('balcony', getObjectOrder('boyfriendGroup') - 1)

	makeBgIMAGES('redflash', 'redflash', 150, -25, 1, 1.5, true, 0, false)
	setObjectCamera('redflash', 'camHUD');
	setObjectOrder("redflash", getObjectOrder('notes') + 1)

end

function onEvent(name, value1, value2)
	if name == 'penis' then
		didthepenisShit = true
		Startcutsceneshit(false)
	end

	if name == 'endpenis' then
		Startcutsceneshit(true)
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
			else
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

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if InCutscenePenis ==  true then
		flashinglights = getDataFromSave('flashinglights', 'hasflashinglights')
		if flashinglights == true then
			cameraShake("camGame", 0.005, 0.2)	
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'redflashlongIN' then
		doTweenAlpha('redflashlongOUT', 'redflash', '0', 0.6, 'quadOut')
	end
end

function onBeatHit()
	idleBgGuys()


end

function onCountdownTick(counter)
	idleBgGuys()
end

function onUpdatePost(elapsed)

	dothiscrap = false

	if dothiscrap then
		if not didthepenisShit  then
			SexZooms('camGame', 0.2, 'linear', 1.2, 2)
		else
			SexZooms('camGame', 0.1, 'linear', 1.2, 1.3)
		end
	end
end

function SexZooms(whatcam, time, tweentype, zoom1, zoom2)
	if mustHitSection then
		cancelTween('thecoolershituhhhzoom')
		doTweenZoom('thecoolershituhhhzoom', whatcam, zoom1, time, tweentype)
    else
		cancelTween('shituhhhzoom')
		doTweenZoom('shituhhhzoom', whatcam, zoom2, time, tweentype)
    end
end

function Startcutsceneshit(bool)
	for i = 0, getProperty('playerStrums.length')-1 do
		setPropertyFromGroup('playerStrums',i,'visible',bool)
	end
	setProperty('healthBarBG.visible', bool);
	setProperty('healthBar.visible', bool);

	if not bool then
		characterPlayAnim('dad', 'peniscutscene', true);
		setProperty('dad.specialAnim', true);

		offsetThing('punkguy', -10, -10)
		luaSpritePlayAnimation('punkguy', 'cutscene');
		luaSpritePlayAnimation('coolguy', 'cutscene');
	
		setProperty('blood.alpha', 1)
		luaSpritePlayAnimation('blood', 'cutscene');
	else
		setObjectOrder("punkguy", getObjectOrder('dadGroup') - 1)
		setObjectOrder("coolguy", getObjectOrder('dadGroup') - 1)
	end

end

function idleBgGuys()
    for i = 1, #guysWithIdles do
        if not guysWithIdles[i][3] then
            luaSpritePlayAnimation(guysWithIdles[i][1], guysWithIdles[i][2])
        else
            if not didthepenisShit then
                luaSpritePlayAnimation(guysWithIdles[i][1], guysWithIdles[i][2])
            end
        end
    end
end

function precacheShit()
        for i = 1, #soundsPrecache do
            precacheImage(imagePrecache[i][1])
        end

        for i = 1, #soundsPrecache do
            precacheSound(soundsPrecache[i][1])
        end
end

function makeBgIMAGES(name, foldername, x, y, scroll, scale, front, alpha, flip)
    makeLuaSprite(name, 'cassandra/'..foldername, x, y);
    setLuaSpriteScrollFactor(name, scroll, scroll);
    scaleObject(name, scale, scale);
    setProperty(name..'.alpha', alpha);
    setPropertyLuaSprite(name, 'flipX', flip);
    addLuaSprite(name, front);
end

function makebgANIMATED(name, foldername, x, y, scroll, scale, front, alpha, flip)
    makeAnimatedLuaSprite(name, 'cassandra/'..foldername, x, y);
    setLuaSpriteScrollFactor(name, scroll, scroll);
    scaleObject(name, scale, scale);
    setProperty(name..'.alpha', alpha);
    setPropertyLuaSprite(name, 'flipX', flip);
    addLuaSprite(name, front);
end

function addbgANIMATION(name, animationName, animationNameXML, framerate, loop, defaultAnimation)
    luaSpriteAddAnimationByPrefix(name, animationName, animationNameXML, framerate, loop);
    luaSpritePlayAnimation(name, defaultAnimation);
end

function offsetThing(name, offsetX, offsetY)
    setProperty(name..'.offset.x', offsetX);
    setProperty(name..'.offset.y', offsetY);
end

function makeboopAnimationTweens(name, ogx, ogy, bigx, bigy, time, tweentype)
    setProperty(name..'.scale.x', bigx);
    setProperty(name..'.scale.y', bigy);
    doTweenX(name..'xboopsizetween', name..'.scale', ogx, time, tweentype)
    doTweenY(name..'yboopsizetween', name..'.scale', ogy, time, tweentype)
end