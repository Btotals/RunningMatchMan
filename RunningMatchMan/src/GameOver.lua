require("Cocos2d")

local GameOver = class("GameOver", function()
    return cc.LayerColor:create(cc.c4b(255,255,255,255))
end)

function GameOver.create(currentHeroCount,score)
    local scene = cc.Scene:create()
	local layer = GameOver.new()
    layer:initWithCurrentHeroCountAndScore(currentHeroCount,score)
    
    scene:addChild(layer)
	
    return scene
end

function GameOver.createScene(currentHeroCount,score)
	local scene = cc.Scene:create()
	local layer = GameOver.create(currentHeroCount, score)
    scene:addChild(layer)
    return scene
end

function GameOver:initWithCurrentHeroCountAndScore(currentHeroCount,score)
    self._currentHeroCount = currentHeroCount
    self._score = score
    
    local visibleSize = cc.Director:getInstance():getVisibleSize()


    -- --add background
    local background = cc.Sprite:create("background.jpg")
    self:addChild(background, 0)
    self.setScale(background, 1.5)
    background:setPosition(visibleSize.width / 2, visibleSize.height / 2)
    
    local scoreLabel = cc.Label:createWithTTF("","fonts/Marker Felt.ttf", 32)
    scoreLabel:setColor(cc.c3b(0, 0, 0))
    scoreLabel:setString(string.sub(score, 1, 4))
    self:addChild(scoreLabel)
    scoreLabel:setPosition(visibleSize.width / 2, visibleSize.height - 30)
    

    -- add hehe, the hero charater
    local cache = cc.SpriteFrameCache:getInstance()
    cache:addSpriteFrames("hehe.plist")
    
    local hehe = cc.Sprite:createWithSpriteFrameName("hehe_00.png")
    self:addChild(hehe)
    hehe:setPosition(visibleSize.width / 2, visibleSize.height - hehe:getContentSize().height / 2 - 130)

    local animFrames = {}
    for i = 2, 3 do 
        local frame = cache:getSpriteFrame(string.format("hehe_%02d.png", i) )
        animFrames[i] = frame
    end

    local animation = cc.Animation:createWithSpriteFrames(animFrames, 0.1)
    local animate = cc.Animate:create(animation);
    hehe:runAction(cc.RepeatForever:create(animate))




    local gameOver = cc.Sprite:create("game_over.png")
    gameOver:setScale(0.8)
    self:addChild(gameOver)
    gameOver:setPosition(visibleSize.width / 2, visibleSize.height - hehe:getContentSize().height / 2 - 210)
    
    local function menuCallbackRestart()
        cc.Director:getInstance():replaceScene(require("GameScene").createScene(self._currentHeroCount))
    end

    local restart = cc.MenuItemImage:create("restart.png", "restart.png")
    restart:setPosition(0, 30)
    restart:registerScriptTapHandler(menuCallbackRestart)

    local function menuCallbackMainMenu()
        cc.Director:getInstance():replaceScene(require("MenuScene").createScene())
    end

    local mainMenu = cc.MenuItemImage:create("main.png", "main.png")
    mainMenu:setPosition(0, -120)
    mainMenu:registerScriptTapHandler(menuCallbackMainMenu)
    
    local menu = cc.Menu:create(restart, mainMenu)
    self:addChild(menu)
end

return GameOver

