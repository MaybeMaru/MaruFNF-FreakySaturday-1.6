--OPTIONS MENU

local menuEnabled = true; -- controls if the menu should show up at all

local menuStarted = false;

--OPTIONS SHIT
function onStartCountdown()
    if menuEnabled == true and menuStarted == false and songName == 'penilian' then
        menuStarted = true;
        return Function_Stop;
    end
    return Function_Continue;
end

function onCreatePost()
	
    if menuEnabled and songName == 'penilian' then

		initSaveData('flashinglights', 'FreakySaturday')

		--This makes it so if you dont have a save file it creates one activated by default
		if  getDataFromSave('flashinglights', 'hasflashinglights') == true or getDataFromSave('flashinglights', 'hasflashinglights') == false then

		else
			setDataFromSave('flashinglights', 'hasflashinglights', true)
			flushSaveData('flashinglights')
		end
		
        playMusic('offsetSong', 1);

        makeLuaSprite('optionsMenuBG', 'generalshit/ngTransition', -50, 0);
        addLuaSprite('optionsMenuBG');

		makeLuaText('warningText', 'WARNING!', 0, 0);
        setTextSize('warningText', 80);
        screenCenter('warningText', 'X');
		setProperty('warningText.y', getProperty('warningText.y') + 30);
		setProperty('warningText.x', getProperty('warningText.x') - 30);
        addLuaText('warningText');

		makeAnimatedLuaSprite('checkbox', 'checkboxanim', 0, 140);
        addAnimationByPrefix('checkbox', 'unchecked', 'checkbox anim reverse0', 24, false);
        addAnimationByPrefix('checkbox', 'unchecked2', 'checkbox0', 24, false);
        addAnimationByPrefix('checkbox', 'checked', 'checkbox anim0', 24, false);
        screenCenter('checkbox', 'X');
        addLuaSprite('checkbox');

        makeLuaText('selectedOptionText', 'Screen Effects', 0, 0);
        setTextSize('selectedOptionText', 64);
        screenCenter('selectedOptionText', 'XY');
        setProperty('selectedOptionText.y', getProperty('selectedOptionText.y') - 70);
        addLuaText('selectedOptionText');

        makeLuaText('descText', '\n\n\n\nThis song has some flashing colors\nand screen shaking.\nYou can toggle them ON and OFF here.\nRecommended to turn ON for the best experience\n\nPress Y to turn ON.\nPress N to turn OFF.\nPress BACK to play.\n', 0, 0);
        setTextSize('descText', 32);
        screenCenter('descText', 'XY');
		setProperty('descText.y', getProperty('descText.y') + 40);
        addLuaText('descText');

		setProperty('selectedOptionText.offset.x', -40);
		setProperty('descText.offset.x', -40);

		setTextFont('warningText', 'potatpress__.ttf')
		setTextFont('selectedOptionText', 'potatpress__.ttf')
		setTextFont('descText', 'potatpress__.ttf')

		setTextColor('warningText', 'ff0000')
		setTextColor('selectedOptionText', '008cff')

        setObjectCamera('optionsMenuBG', 'other');
		setObjectCamera('selectedOptionText', 'other');
		setObjectCamera('warningText', 'other');
        setObjectCamera('descText', 'other');
        setObjectCamera('valueText', 'other');
		setObjectCamera('checkbox', 'other');

		if getDataFromSave('flashinglights', 'hasflashinglights') == true then
			setProperty('checkbox.offset.x', 38);
			setProperty('checkbox.offset.y', 25);
			luaSpritePlayAnimation('checkbox', 'checked');
		end
		if getDataFromSave('flashinglights', 'hasflashinglights') == false then
			setProperty('checkbox.offset.x', 0);
			setProperty('checkbox.offset.y', 0);
			luaSpritePlayAnimation('checkbox', 'unchecked2');
		end
    end

end

function onUpdatePost(elapsed)
    if menuEnabled == true and menuStarted == true and songName == 'penilian' then

        if keyJustPressed('back') then
			if  getDataFromSave('flashinglights', 'hasflashinglights') == true or getDataFromSave('flashinglights', 'hasflashinglights') == false then
				playSound('confirmMenu', 0.6);
				flushSaveData('flashinglights')
				startCountdown();
				menuStarted = false;
	
				soundFadeOut('', getPropertyFromClass('Conductor', 'crochet') / 1000, 0);
	
				-- set the alpha of everything to 
				local duration = 1;
				doTweenX('0', 'optionsMenuBG', 3000, duration, 'cubeOut');
				doTweenX('2', 'selectedOptionText', 3000, duration, 'cubeOut');
				doTweenX('3', 'checkbox', 3000, duration, 'cubeOut');
				doTweenX('4', 'descText', 3000, duration, 'cubeOut');
				doTweenX('5', 'warningText', 3000, duration, 'cubeOut');
			end
        end

        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Y') then
			if getDataFromSave('flashinglights', 'hasflashinglights') == false then
				playSound('scrollMenu', 0.6);
				setProperty('checkbox.offset.x', 38);
				setProperty('checkbox.offset.y', 25);
				luaSpritePlayAnimation('checkbox', 'checked');
			end
		   setDataFromSave('flashinglights', 'hasflashinglights', true)
		   flashinglights = getDataFromSave('flashinglights', 'hasflashinglights')
        end

		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.N') then

			if getDataFromSave('flashinglights', 'hasflashinglights') == true then
				setProperty('checkbox.offset.x', 28);
				setProperty('checkbox.offset.y', 29);
				luaSpritePlayAnimation('checkbox', 'unchecked');
				playSound('scrollMenu', 0.6);
			end
			if getDataFromSave('flashinglights', 'hasflashinglights') == false then
				setProperty('checkbox.offset.x', 0);
				setProperty('checkbox.offset.y', 0);
				luaSpritePlayAnimation('checkbox', 'unchecked2');
			end

			setDataFromSave('flashinglights', 'hasflashinglights', false)
			flashinglights = getDataFromSave('flashinglights', 'hasflashinglights')
        end
	end

	if getProperty('checkbox.animation.curAnim.name') == 'unchecked' then
        if getProperty('checkbox.animation.curAnim.finished') then
			setProperty('checkbox.offset.x', 0);
			setProperty('checkbox.offset.y', 0);
			luaSpritePlayAnimation('checkbox', 'unchecked2');
         end
    end
end