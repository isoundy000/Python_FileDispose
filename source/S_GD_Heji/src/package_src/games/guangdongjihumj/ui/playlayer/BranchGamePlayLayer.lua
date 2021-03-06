--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local GamePlayLayer = require("app.games.common.ui.playlayer.GamePlayLayer")
local HandCardsPanel 	= require("package_src.games.guangdongjihumj.ui.playlayer.BranchHandCardsPanel")
local BranchGamePlayLayer = class("BranchGamePlayLayer",GamePlayLayer)

function BranchGamePlayLayer:ctor()
    self.super.ctor(self)
end
--[[
-- @brief  初始化玩家版块函数
-- @param  void
-- @return void
--]]

function BranchGamePlayLayer:initPlayers()
    if self.playerPannel ~= nil and #self.playerPannel>0 then
        for i,v in pairs(self.playerPannel) do
            v:dtor()
            v:removeFromParent()
        end
        self.playerPannel = {}
    end
    self.super.initPlayers(self)
	if self.playerPannel[enSiteDirection.SITE_MYSELF] ~= nil then
        self.playerPannel[enSiteDirection.SITE_MYSELF]:dtor()
        self.playerPannel[enSiteDirection.SITE_MYSELF]:removeFromParent()
        self.playerPannel[enSiteDirection.SITE_MYSELF] = nil
    end
    self.playerPannel[enSiteDirection.SITE_MYSELF]	= HandCardsPanel.new(self.mjGroups):addTo(self)
end

--[[
-- @brief  吃碰杠等操作逻辑函数
-- @param  void
-- @return void
--]]
function BranchGamePlayLayer:onAction()
    -- 显示吃碰杠摆放的牌
	local operateData 	= self.operateSystem:getOperateSystemDatas()
	local operateSite   = self.gamePlaySystem:getPlayerSiteById(operateData.userid)
    Log.i("operateData.losIds.............",operateData.losIds,#operateData.losIds)
    if operateData.actionID == enOperate.OPERATE_JIA_GANG 
         and (operateData.losIds ~= nil and #operateData.losIds > 0) then
            MjMediator.getInstance():getEventServer():dispatchCustomEvent(enMjNtfEvent.GAME_ACT_ANIMATE_FINISH_NTF)
            return
    end

    self.super.onAction(self)
	
    if operateData.actionID == enOperate.OPERATE_QIANG_GANG_HU then
		--------------------------回放相关---------------------------
		if VideotapeManager.getInstance():isPlayingVideo() then
			self.playerPannel[operateSite]:playActionAnimation("AnimationHU", operateSite, 1, false)
		else
			self.playerPannel[operateSite]:playActionAnimation("AnimationHU", operateSite, 1)
		end
        --胡时把手牌全制为不能打出状态
        local myCards    = self.playerPannel[enSiteDirection.SITE_MYSELF]:getHandCardsList()
    	for i=1,#myCards do
    		myCards[i]:setMjState(enMjState.MJ_STATE_TOUCH_INVALID)
    	end
		--------------------------------------------------------------
        --音效
        local player = MjMediator:getInstance():getSystemManager():getSystem(enSystemDef.GAME_PLAY_SYSTEM):gameStartGetPlayerByUserid(operateData.userid);
        local sex = player:getProp(enCreatureEntityProp.SEX);
        _GameEffectActionHu(sex);

    end
end
return BranchGamePlayLayer
--endregion
