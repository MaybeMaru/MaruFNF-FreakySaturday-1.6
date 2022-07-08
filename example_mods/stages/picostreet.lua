didthebusShit = false
canShoot = false

shitToTweenCOLOR = {
    {'boyfriend'},
    {'dad'},
    {'floor'},
    {'buildings'},
    {'bgUberkids'},
    {'walkingUberkid'},
    {'UberkidCorpse'},
    {'buscoming'},
    {'bulletfall'},
    {'uberkidbf'},
    {'frontbgUberkids'},
    {'frontbgUberkidsSide'},
    {'uberkidbfCorpse'},
    {'boopingUberkid'},
    {'DeaduberkidbfCorpse'},
}

guysWithIdles = {
    {'bgUberkids', 'idle', true},
    {'frontbgUberkids', 'idle', true},
    {'frontbgUberkidsSide', 'idle', true},
    {'boopingUberkid', 'idle', false}
}

soundsPrecache = {
    {'gunshot'},
    {'throwmic'},
    {'gunout'},
    {'micout'},
    {'reload'},
    {'blood'},
    {'bulletfall'},
    {'countdown'},
    {'debug'},
}

imagePrecache = {
    {'characters/pitogameover'},
}

function onCreate()

    --SETUP GAMEOVER
        setPropertyFromClass('GameOverSubstate', 'characterName', 'pitogameover'); --Character json file for the death animation
        setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'picodies'); --put in mods/sounds/
        setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver'); --put in mods/music/
        setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd'); --put in mods/music/
    

    --HOW TO MAKE SHIT WITH FUNCTIONS

        --makeBgIMAGES(name, foldername, x, y, scroll, scale, front, alpha, flip)
        --makebgANIMATED(name, foldername, x, y, scroll, scale, front, alpha, flip)
        --addbgANIMATION(name, animationName, animationNameXML, framerate, loop, defaultAnimation)

    --STAGE SHIT

        makeBgIMAGES('sky', 'sky', -310, -100, 0.8, 1, false, 1, false)

        makeBgIMAGES('buildings', 'buildings', -310, -100, 0.9, 1, false, 1, false)

        makebgANIMATED('buscoming', 'BusComing', 250, -9999, 0.9, 1.2, false, 1, false)
        addbgANIMATION('buscoming', 'bus1', 'BusComing0', 24, false, 'bus1')
        addbgANIMATION('buscoming', 'bus2', 'BusComing2', 24, false, 'bus1')

        makebgANIMATED('flickeringlights', 'FlickerLights', -325, -100, 0.95, 1, false, 0.1, false)
        addbgANIMATION('flickeringlights', 'glow', 'Glow', 1, false, 'glow')
        addbgANIMATION('flickeringlights', 'flicker', 'Flicker', 12, false, 'glow')

        makeBgIMAGES('floor', 'floor', -310, -100, 1, 1, false, 1, false)
    
        makebgANIMATED('bgUberkids', 'bgUberkids', 85, 250, 0.9, 1, false, 1, false)
        addbgANIMATION('bgUberkids', 'idle', 'bguberkids0', 24, false, 'idle')
        addbgANIMATION('bgUberkids', 'bus', 'bguberkidsBUS', 24, false, 'idle')

        makebgANIMATED('walkingUberkid', 'uberkidWalk', 750, 217, 1, 1, false, 1, false)
        addbgANIMATION('walkingUberkid', 'run', 'walk', 24, true, 'run')

        makebgANIMATED('boopingUberkid', 'uberkidShit', 500, 217, 1, 1, false, 1, false)
        addbgANIMATION('boopingUberkid', 'idle', 'idle', 24, false, 'idle')

        makebgANIMATED('UberkidCorpse', 'uberkidbf', 500, 225, 1, 1, false, 1, true)
        addbgANIMATION('UberkidCorpse', 'die', 'diebf', 24, false, 'die')

        makebgANIMATED('uberkidbf', 'uberkidbf', -350, 217, 1, 1, false, 1, false)
        addbgANIMATION('uberkidbf', 'run', 'walkbf', 24, true, 'run')

        makebgANIMATED('DeaduberkidbfCorpse', 'uberkidbf', -100, 9999, 1, 1, false, 1, false)
        addbgANIMATION('DeaduberkidbfCorpse', 'die', 'diebf', 24, false, 'die')

        makebgANIMATED('numbers', 'numbers', 580, 250, 1, 2, true, 0, false)
        addbgANIMATION('numbers', '1', 'one', 24, true, '3')
        addbgANIMATION('numbers', '2', 'two', 24, true, '3')
        addbgANIMATION('numbers', '3', 'three', 24, true, '3')

        makebgANIMATED('bulletfall', 'bulletfall', 170, 9999, 1, 1.25, true, 1, false)
        addbgANIMATION('bulletfall', 'bulletfall', 'bulletfall', 24, false, 'bulletfall')

        makebgANIMATED('frontbgUberkids', 'frontbgUberkids', -180, 300, 1.1, 1.25, true, 1, false)
        addbgANIMATION('frontbgUberkids', 'idle', 'frontbguberkids0', 24, false, 'idle')
        addbgANIMATION('frontbgUberkids', 'bus', 'frontbguberkidsBUS', 24, false, 'idle')

        makebgANIMATED('frontbgUberkidsSide', 'frontbgUberkids', 440, 300, 1.1, 1.25, true, 1, true)
        addbgANIMATION('frontbgUberkidsSide', 'idle', 'frontbguberkids0', 24, false, 'idle')
        addbgANIMATION('frontbgUberkidsSide', 'bus', 'frontbguberkidsBUS', 24, false, 'idle')
    
        offsetThing('UberkidCorpse', 0, 9999)
        offsetThing('boopingUberkid', 0, 9999)

        --makeLuaText('debugText', 'ERROR DUMBASS', 0, 175, 150)
        --addLuaText('debugText')
        --setProperty('debugText.alpha', 1)
    end

    function onEvent(name, value1, value2)

        if name == 'makeuberkidRUN' and (not canShoot) then
                doTheResetTweenThing('walkingUberkid', 'tweenUberkidPico', 750, 500, 1, 'linear', true, 'x')
        end
    
        if name == 'Play Animation' then
            if value1 == "weaponOut" then
                if value2 == "BF" then
                    playSound('gunout', 1)
                else
                    playSound('micout', 1)
                end
            end
        end
    
        if name == 'bus' then
            didthebusShit = true
            StartBusShit(false)
        end
    
        if name == 'endbus' then
            StartBusShit(true)
        end
    
        if name == 'bfattack' then
            if difficulty == 0 then
            setProperty('uberkidbf.x', -350)
            cancelTween('BFuberkidTWEEN')
            luaSpritePlayAnimation('uberkidbf', 'run');
            doTweenX('BFuberkidTWEEN', 'uberkidbf', -100, (((60000/curBpm)*3)/1000) -0.05, 'linear')
            end
        end
    end

    --offsetThing(name, offsetX, offsetY)

    function StartBusShit(bool)
        for i = 0, getProperty('playerStrums.length')-1 do
            setPropertyFromGroup('playerStrums',i,'visible',bool)
        end
        setProperty('healthBarBG.visible', bool);
        setProperty('healthBar.visible', bool);
        if not bool then
            characterPlayAnim('boyfriend', 'buscutscene', true);
            setProperty('boyfriend.specialAnim', true);
            characterPlayAnim('dad', 'bus', true);
            setProperty('dad.specialAnim', true);

            setProperty('bgUberkids.x', -310)
            setProperty('bgUberkids.y', 40)
            luaSpritePlayAnimation('bgUberkids', 'bus');

            offsetThing('frontbgUberkids', 300, 55)
            offsetThing('frontbgUberkidsSide', 120, 49)

            luaSpritePlayAnimation('frontbgUberkids', 'bus');
            luaSpritePlayAnimation('frontbgUberkidsSide', 'bus');
    
            luaSpritePlayAnimation('buscoming', 'bus1');
            setProperty('buscoming.y', 150)

        else
            setProperty('bgUberkids.y', -9999)
            setProperty('buscoming.y', -9999)
        end
    end

    
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'BulletNote' then

		if not canShoot then
			playSound('reload', 1)
			characterPlayAnim('boyfriend', 'reload', true);
			setProperty('boyfriend.specialAnim', true);
        else
            canShoot = false
            cancelTimer('StartCountdownStuff')

			playSound('gunshot', 0.7)
	        cameraShake('camGame', 0.015, 0.15);
			playSound('blood', 1)
	        
	        luaSpritePlayAnimation('bulletfall', 'bulletfall');
			setProperty('bulletfall.y', 240);

			characterPlayAnim('boyfriend', 'shoot', true);
			setProperty('boyfriend.specialAnim', true);

            offsetThing('boopingUberkid', 0, 9999)
            offsetThing('UberkidCorpse', 0, 0)
            luaSpritePlayAnimation('UberkidCorpse', 'die');

            doTweenAlpha('HideCoundownNumbersAlphaTween', 'numbers', '0', 0.3, 'linear')
			doTweenY('HideCoundownNumbersYTween', 'numbers', '250', 0.3, 'linear')

		end

	end
end

--CHECKS FOR WHEN THE UBERKID DEATH ANIMATION IS DONE
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'FlickerLights' then
		luaSpritePlayAnimation('flickeringlights', 'flicker');
	end

    if tag == 'StartCountdownStuff' then

        makeboopAnimationTweens('numbers', 2, 2, 3, 3, 0.3, 'circInOut')
        luaSpritePlayAnimation('numbers', loopsLeft);

		if (loopsLeft < 4) and (loopsLeft > 0)  then
				doTweenAlpha('AppearCoundownNumbersAlphaTween', 'numbers', '1', 0.3, 'linear')
				doTweenY('AppearCoundownNumbersYTween', 'numbers', '150', 0.3, 'linear')
				playSound('countdown', 1)
		end
        if (loopsLeft == 0) and canShoot then
            setProperty('health', -500)
        end
    
	end
end

function onTweenCompleted(tag)

	if tag == 'BFuberkidTWEEN' then
        setProperty('uberkidbf.x', -350)
        cancelTween('BFuberkidTWEEN')
		characterPlayAnim('dad', 'micattack', true);
		setProperty('dad.specialAnim', true);

		playSound('throwmic', 1)
        playSound('blood', 1)
		cameraShake('camGame', 0.015, 0.15);
		
        setProperty('DeaduberkidbfCorpse.y', 217)
		luaSpritePlayAnimation('DeaduberkidbfCorpse', 'die');
	end

    if tag == 'tweenUberkidPico' then
        canShoot = true
        offsetThing('boopingUberkid', 0, 0)
        doTheResetTweenThing('walkingUberkid', 'tweenUberkidPico', 750, 500, 1, 'linear', false, 'x')
        runTimer('StartCountdownStuff', 1, 6)
    end

end

function onBeatHit()
	
    idleBgGuys()

	if curBeat % 4 == 0 then
        if math.random(1, 50) <= 15 then
			runTimer('FlickerLights', math.random(0.1, 0.6), math.random(1, 4))
        end
    end
end

function onUpdate()
    --setTextString('debugText', canShoot)
end	

function onCountdownTick()
    idleBgGuys()
end

function onSongStart()
    precacheShit()
    coolNightTweens(90, '4B45A5', 'linear')
end

function coolNightTweens(time, color, tweentype)

    doTweenColor('SkyTween', 'sky', '2B218A', time, tweentype)
    doTweenAlpha('LightsTween', 'flickeringlights', 0.15, time, tweentype)
    
    for i = 1, #shitToTweenCOLOR do
        doTweenColor('nightTimeTween'..i, shitToTweenCOLOR[i][1], color, time, tweentype)
    end
end

function idleBgGuys()
    for i = 1, #guysWithIdles do
        if not guysWithIdles[i][3] then
            luaSpritePlayAnimation(guysWithIdles[i][1], guysWithIdles[i][2])
        else
            if not didthebusShit then
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
    makeLuaSprite(name, 'mindchamber/'..foldername, x, y);
    setLuaSpriteScrollFactor(name, scroll, scroll);
    scaleObject(name, scale, scale);
    setProperty(name..'.alpha', alpha);
    setPropertyLuaSprite(name, 'flipX', flip);
    addLuaSprite(name, front);
end

function makebgANIMATED(name, foldername, x, y, scroll, scale, front, alpha, flip)
    makeAnimatedLuaSprite(name, 'mindchamber/'..foldername, x, y);
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

function doTheResetTweenThing(guyname, tweenname, ogcoord, newcoord, time, tweentype, shouldtween, typeXY)
    cancelTween(tweenname)
    if typeXY == 'x' then
        setProperty(guyname..'.x', ogcoord)
    else
        setProperty(guyname..'.y', ogcoord)
    end
    
    if shouldtween then
        if typeXY == 'x' then
            doTweenX(tweenname, guyname, newcoord, time, tweentype)
        else
            doTweenY(tweenname, guyname, newcoord, time, tweentype)
        end
    end
end

function makeboopAnimationTweens(name, ogx, ogy, bigx, bigy, time, tweentype)
    setProperty(name..'.scale.x', bigx);
    setProperty(name..'.scale.y', bigy);
    doTweenX(name..'xboopsizetween', name..'.scale', ogx, time, tweentype)
    doTweenY(name..'yboopsizetween', name..'.scale', ogy, time, tweentype)
end