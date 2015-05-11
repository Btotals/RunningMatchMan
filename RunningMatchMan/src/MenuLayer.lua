
local MenuLayer = class("MenuLayer", function()
    return cc.LayerColor:create(cc.c4b(255,255,255,255))
end)

function MenuLayer:init()
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    
    self:addBtns()


    -- --add background
    local background = cc.Sprite:create("background.jpg")
    self:addChild(background, 0)
    self.setScale(background, 1.5)
    background:setPosition(visibleSize.width / 2, visibleSize.height / 2)
    
    -- add hehe
    local cache = cc.SpriteFrameCache:getInstance()
    cache:addSpriteFrames("hehe.plist")
    
    local hehe = cc.Sprite:createWithSpriteFrameName("hehe_00.png")
    self:addChild(hehe)
    hehe:setPosition(110, visibleSize.height - hehe:getContentSize().height / 2 - 100)

    local animFrames = {}
    for i = 2, 3 do 
        local frame = cache:getSpriteFrame(string.format("hehe_%02d.png", i) )
        animFrames[i] = frame
    end

    local animation = cc.Animation:createWithSpriteFrames(animFrames, 0.1)
    local animate = cc.Animate:create(animation);
    hehe:runAction(cc.RepeatForever:create(animate))

    
    -- add split
    -- local split = cc.Sprite:create("split.png")
    -- self:addChild(split)
    -- split:setPosition(175, visibleSize.height - hehe:getContentSize().height / 2 - 100)
    
    -- add hero and runAction
    local cache = cc.SpriteFrameCache:getInstance()
    cache:addSpriteFrames("hero.plist")
    
    local hero = cc.Sprite:createWithSpriteFrameName("hero_00.png")
    self:addChild(hero)
    hero:setPosition(295, visibleSize.height - hero:getContentSize().height / 2 - 80)

    local animFrames = {}
    for i = 0, 3 do 
        local frame = cache:getSpriteFrame(string.format("hero_%02d.png", i) )
        animFrames[i] = frame
    end

    local animation = cc.Animation:createWithSpriteFrames(animFrames, 0.1)
    local animate = cc.Animate:create(animation);
    hero:runAction(cc.RepeatForever:create(animate))



    -- add title
    local title = cc.Sprite:create("title.png")
    self:addChild(title)
    title:setPosition(visibleSize.width / 2 + 200, visibleSize.height - title:getContentSize().height / 2 - 140)
    
    return true
end

function MenuLayer:addBtns()
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    
    local function menuCallbackOpenNormal()
        cc.Director:getInstance():replaceScene(require("GameScene").createScene(2))
    end
    
    local normal = cc.MenuItemImage:create("diff_0.png", "diff_0.png")
    self.setScale(normal, 0.8)
    normal:setPosition(0, 120)
    normal:registerScriptTapHandler(menuCallbackOpenNormal)
    
    local function menuCallbackOpenNightmare()
        cc.Director:getInstance():replaceScene(require("GameScene").createScene(3))
    end
    
    local nightmare = cc.MenuItemImage:create("diff_1.png", "diff_1.png")
    self.setScale(nightmare, 0.8)
    nightmare:setPosition(0, -20)
    nightmare:registerScriptTapHandler(menuCallbackOpenNightmare)
    
    local function menuCallbackOpenHell()
        cc.Director:getInstance():replaceScene(require("GameScene").createScene(4))
    end
    
    local hell = cc.MenuItemImage:create("diff_2.png", "diff_2.png")
    self.setScale(hell, 0.8)
    hell:setPosition(0, - 160)
    hell:registerScriptTapHandler(menuCallbackOpenHell)
    
    local function menuCallbackOpenInferno()
        cc.Director:getInstance():replaceScene(require("GameScene").createScene(5))
    end
    
    local inferno = cc.MenuItemImage:create("diff_3.png", "diff_3.png")
    self.setScale(inferno, 0.8)
    inferno:setPosition(0, - 300)
    inferno:registerScriptTapHandler(menuCallbackOpenInferno)
    
    local menu = cc.Menu:create(normal, nightmare, hell, inferno)
    self:addChild(menu, 1)
end

return MenuLayer