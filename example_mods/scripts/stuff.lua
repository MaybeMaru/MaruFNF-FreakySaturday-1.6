offsetshitX = 0
offsetshitY = 0
dotheThing = false
flipthebar = false

local initialCamera
local initialMiddleScroll

--Name, BarX, BarY, Hide most shit, Force MiddleScroll Settings, Use Black bars, Allow Debug Mode, Lines of debug mode, Flip Health bar

local setupshit = {
    {'Freaky-Saturday', 80, 0, true, true, true, false, 4, false},
    {'penilian', 0, 0, true, true, true, false, 1, true},
    
};

function onCreate()

    if middlescroll == true then
        initialMiddleScroll = true
    else 
        initialMiddleScroll = false
    end	
    
    if cameraZoomOnBeat == true then
        initialCamera = true
    else
        initialCamera = false
    end

    for i = 1, #setupshit do
        if songName == setupshit[i][1] then

            if setupshit[i][4]== true then
                dotheThing = true    
            end
            
            if setupshit[i][5]== true then
                --God bless you Shade from the Psych Engine Discord
                setPropertyFromClass('ClientPrefs', 'camZooms', false)
                setPropertyFromClass('ClientPrefs', 'middleScroll', true)
            end

            if setupshit[i][6]== true then
                offsetshitX = setupshit[i][2]
                offsetshitY = setupshit[i][3]

                makeLuaText('shit', 'ERROR YOU DUMB FUCK', 400, 0, 100)
                setTextAlignment('shit', "left")
                setTextSize('shit', 25)
                setObjectCamera('shit', "other")
                addLuaText('shit')
                setProperty('shit.alpha', 1)
            
                makeLuaSprite('bs1', '', -250, -100)
                makeGraphic('bs1', 225, 1000, '000000')
                setObjectCamera('bs1', 'game')
                addLuaSprite('bs1', true)
                
                setProperty('bs1.offset.x', offsetshitX);
                setProperty('bs1.offset.y', offsetshitY);
                
                
                makeLuaSprite('bs2', '', 850, -100)
                makeGraphic('bs2', 225, 1000, '000000')
                setObjectCamera('bs2', 'game')
                addLuaSprite('bs2', true)
                
                setProperty('bs2.offset.x', offsetshitX);
                setProperty('bs2.offset.y', offsetshitY);
                
                makeLuaSprite('bars','barsnew',0,0)
                setLuaSpriteScrollFactor('bars',160,90)
                addLuaSprite('bars',true)
                setProperty('bars.antialiasing',false)
                scaleObject('bars',4,4)
                setObjectCamera('bars', 'other');
                setProperty('bars.offset.x', -320);
            end

            if setupshit[i][7]== true then
                makeLuaText('DebugMode', 'DEBUG MODE', 0, 400 - 220, 110)
                setTextSize('DebugMode', 30)
                setTextColor('DebugMode', '008cff')
                setObjectCamera('DebugMode', 'hud')

                --Sexy Big Black Square
                setProperty('testBlackSquare.alpha', 1)
                makeLuaSprite('testBlackSquare', '', 150, 105)
                makeGraphic('testBlackSquare', 230, 21.36 * (3 + setupshit[i][8]), '000000')
                setObjectCamera('testBlackSquare', 'hud')
                addLuaSprite('testBlackSquare')
                addLuaText('DebugMode');

                setProperty('testBlackSquare.alpha', 0)
                setProperty('DebugMode.alpha', 0)
            end

            if setupshit[i][9]== true then
                flipthebar = true
            end
        end
    end
end

function onUpdate()

    setTextString('shit', offsetshitX..'\n'..offsetshitY)

    setProperty('showRating', false)
    setProperty('showCombo', false)

    if flipthebar then
        setProperty('healthBarBG.flipX', true)
        setProperty('healthBar.flipX', true)
    end
    
    if dotheThing then

    setProperty('iconP1.alpha', 0);
    setProperty('iconP2.alpha', 0);
    for i = 0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums',i,'visible',false)
        setPropertyFromGroup('opponentStrums',i,'y',130)
        setPropertyFromGroup('opponentStrums',i,'x',-9999)
        end
        setProperty('gf.visible',false);
        setProperty('scoreTxt.visible', false)
        if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
            setProperty('botplayTxt.y', 536)
        elseif getPropertyFromClass('ClientPrefs', 'downScroll') == true then
            setProperty('botplayTxt.y', 126)
        end
    setProperty('timeBar.visible', false);
    setProperty('timeBarBG.visible', false);
    setProperty('timeTxt.visible', false);  
    

    end

    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F10') then
        setProperty('testBlackSquare.alpha', 0)
        setProperty('DebugMode.alpha', 0)

    end	
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F9') then

        setProperty('testBlackSquare.alpha', .8)
        setProperty('DebugMode.alpha', 1)

    end
end

--Give Back Settings
function onDestroy()
	setPropertyFromClass('ClientPrefs', 'camZooms', initialCamera)
	setPropertyFromClass('ClientPrefs', 'middleScroll', initialMiddleScroll)
end
