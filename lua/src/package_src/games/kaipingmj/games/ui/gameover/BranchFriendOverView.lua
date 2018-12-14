local FriendOverView = require("app.games.common.ui.gameover.FriendOverView")

local Mj            = require "app.games.common.mahjong.Mj"

local BranchFriendOverView = class("BranchFriendOverView",FriendOverView)

function BranchFriendOverView:ctor(data)
    BranchFriendOverView.super.ctor(self.super,data)
end
function BranchFriendOverView:onInit()
    self.super.onInit(self)
end
function BranchFriendOverView:onClose()
    BranchFriendOverView.super.onClose()
end

------------------------
-- 设置玩家详情
-- @param lab_fan       待设置的玩家详情label
-- @param scoreitems    玩家详情Table
function BranchFriendOverView:setPlayerDetail(lab_fan, scoreitems)
   lab_fan:setString("")
    -- 只显示赢的玩家
    if scoreitems.result == enResult.WIN then
        lab_fan:setVisible(true)
    else
        lab_fan:setVisible(false)
    end
    -- 显示胡牌提示
    local detail = ""
    local pon = scoreitems.policyName or {}
    if #pon > 0  
        and #pon > 0 then
        local policyName = ""
        for i=1, #pon do
            policyName = pon[i].." "
            detail = detail..policyName
        end
    end
     -- 显示花牌数量
    if #scoreitems.flowerCards > 0 then
        local flower = #scoreitems.flowerCards
        if self.gameOverDatas.huCount > 1 then
            flower = #scoreitems.flowerCards
        end
        local huaStr = string.format("%d马", flower)
        detail = detail .. " " .. huaStr
    end
    lab_fan:setString(detail)
end
function BranchFriendOverView:addPlayers()
   
   local players  = self.gameSystem:gameStartGetPlayers()       -- 玩家信息    
    self.playerNum = #players
    local itemInterval = 10              --默认四人房
    local offsetY = 30

    --修改 20171110 start 竖版换皮  diyal.yin
    --修改 20171110 end 竖版换皮 diyal.yin

    if self.playerNum == 3 then 
        itemInterval = itemInterval + 30
        offsetY = offsetY - 20
    elseif self.playerNum == 2 then
        itemInterval = itemInterval + 60
    end
    local bg = ccui.Helper:seekWidgetByName(self.m_pWidget, "bg2");
    local bg_size = bg:getContentSize()
    local itemModel = ccs.GUIReader:getInstance():widgetFromBinaryFile("games/common/game/mj_over_item.csb")
    math.randomseed(os.time())

    local data = self.gameSystem:getGameOverDatas();
    for i = 1, #players do
        self.m_PlayerCardList[i] = self.m_PlayerCardList[i] or {}
        local item  = itemModel:clone()
        item:setPosition(cc.p(14, bg_size.height - offsetY -(item:getContentSize().height + itemInterval) * i ))
        bg:addChild(item, 1);
        table.insert(self.playerPanels, item)
        local scoreitem = self.m_scoreitems[i]

        local lab_fan = ccui.Helper:seekWidgetByName(item, "event_text");
        self:setPlayerDetail(lab_fan, scoreitem)
        self:initHeadImage(item,players[i])
        self:initZhuangImg(item,players[i])
        self:initPlayerName(item,scoreitem)  
        self:initScore(item,scoreitem)                -- 区分正负，如果大于0就是正数，小于等于0就默认显示   
        self:initHuImage(item,scoreitem)

        local pan_mj = ccui.Helper:seekWidgetByName(item, "left_card_panel");  
        pan_mj.player = players[i]  
        self:addPlayerMjs(i,pan_mj)

        local line = ccui.Helper:seekWidgetByName(item, "line")
        line:setVisible(#scoreitem.flowerCards > 0)

        local hua_mj = ccui.Helper:seekWidgetByName(item, "right_card_panel")
        local lFlowerCards = self:showFlower(scoreitem.flowerCards, hua_mj)
        self.m_PlayerCardList[i].FlowerCards = lFlowerCards

                 ----马数
        local fanmaList = data.score[i].fanMaCards;
        local zhongmaList = data.score[i].zhongMaCards;
        if #fanmaList>0 then
            self:showFanMa(item, fanmaList, zhongmaList)
        end
    end
end
function BranchFriendOverView:showFlower(flowerCards, parent)
    self.super.showFlower(self,flowerCards,parent)
    if flowerCards and #flowerCards > 0 then
        local zhongma = display.newSprite("package_res/games/kaipingmj/fanma/zhongma.png")
        zhongma:addTo(parent)
        zhongma:setPosition(cc.p(-20,parent:getContentSize().height/2))
    end   
    parent:setPosition(cc.p(parent:getPositionX()+13,parent:getPositionY())) 
end

-- function BranchFriendOverView:initHuImage(item,scoreitems)
--     local img_hu = ccui.Helper:seekWidgetByName(item, "img_hu");
--     if scoreitems.result == enResult.WIN then --胡牌玩家
--         if self.gameOverDatas.winType == 1 then
--                 img_hu:loadTexture("games/common/game/friendRoom/mjOver/zimo.png", ccui.TextureResType.localType)
--             elseif self.gameOverDatas.winType == 2 then
--                 img_hu:loadTexture("games/common/game/friendRoom/mjOver/hupai.png", ccui.TextureResType.localType)
--             else
--                 img_hu:loadTexture("package_res/games/kaipingmj/friendRoom/qianganghu.png", ccui.TextureResType.localType)
--         end
--         img_hu:setVisible(true)
--     elseif (scoreitems.result == enResult.FANGPAO or scoreitems.result == enResult.FAILED)
--         and self.gameOverDatas.winType == enGameOverType.FANG_PAO then
--         img_hu:setVisible(true)
--         img_hu:loadTexture("games/common/game/friendRoom/mjOver/fangpao.png", ccui.TextureResType.localType)
--     elseif (scoreitems.result == enResult.FANGPAO or scoreitems.result == enResult.FAILED) -- 加入抢杠胡
--         and self.gameOverDatas.winType == enGameOverType.QIANG_GANG_HU then
--         img_hu:setVisible(true)
--         img_hu:loadTexture("games/common/game/friendRoom/mjOver/icon_qianggang.png", ccui.TextureResType.localType)
--     else
--         img_hu:setVisible(false)
--     end
-- end
function BranchFriendOverView:showFanMa(item, fanmaList, zhongmaList)
        local hua_mj = ccui.Helper:seekWidgetByName(item, "right_card_panel")
        local count=0
        for i,v in pairs(fanmaList) do
            Log.i("fanmaList//",v)
            local flowSp = Mj.new(enMjType.MYSELF_PENG, v)
            local mjSize = flowSp:getContentSize()
            flowSp:setScaleX(20 / mjSize.width)
            flowSp:setScaleY(28 / mjSize.height)

            mjSize.width = mjSize.width * flowSp:getScaleX()
            mjSize.height = mjSize.height * flowSp:getScaleY()

            local index_x = (i - 1)%12
            flowSp:setPosition(cc.p((mjSize.width + 1) * index_x + mjSize.width * 0.5, (mjSize.height + 6) * (1 + math.floor((i-1)/12)) + mjSize.height / 2 - 4))
            flowSp:addTo(hua_mj)
            local isMa = false
           for j,k in pairs(zhongmaList) do 
            Log.i("zhongmaList",k)
                if v == k then 
                     -- flowSp:setColor(cc.c3b(166, 166, 166))
                     isMa = true
                else
                    count= count + 1
                end
            end
            if not isMa then 
               flowSp:setColor(cc.c3b(166, 166, 166))
            end
        end
            local img=display.newSprite("package_res/games/kaipingmj/fanma/zhongma.png")
            img:setPosition(cc.p(767, item:getContentSize().height*0.5 + 5))
            img:setAnchorPoint(cc.p(0.5, 0.5))
            item:addChild(img)
end

return BranchFriendOverView