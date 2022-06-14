local reverseTime = false
didskip = false
timeforstart = 16
millisecondsstart = 0
roundedmiliseconds = 0

function onCreatePost()
	if downscroll == true then
		makeLuaText('skip', 'Press Space to Skip Intro', 1270, 0, 25);
	end
	if downscroll == false then
		makeLuaText('skip', 'Press Space to Skip Intro', 1270, 0, 675);
	end

	addLuaText('skip');
	setTextSize('skip', 30)
	--setProperty('skip.alpha', 0.8)
	setTextFont('skip', 'potatpress__.ttf')
	
	--In BEATS --> curBeat 
	if songName == 'penilian' then
		timeforstart = 32
	end

	millisecondsstart = (60000 / bpm) * timeforstart

	roundedmiliseconds = round(millisecondsstart, 4)
	
end

function onUpdatePost()
	if curBeat > timeforstart then

		if downscroll == true then
			doTweenY('skipfuera','skip',getProperty('skip.y') - 50 ,0.1,'linear')
		end
		if downscroll == false then
			doTweenY('skipfuera','skip',getProperty('skip.y') + 50 ,0.1,'linear')
		end
	
	end
	--
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and not getProperty('startingSong') and didskip == false and curBeat < timeforstart then
            didskip = true
			removeLuaText('skip');
            setPropertyFromClass('Conductor', 'songPosition', roundedmiliseconds) -- it is counted by milliseconds, 1000 = 1 second
            setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
            setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
    end

	if curStep > 79 then
	reverseTime = true
	didskip = true
end
end

function round(x, n) --https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end
