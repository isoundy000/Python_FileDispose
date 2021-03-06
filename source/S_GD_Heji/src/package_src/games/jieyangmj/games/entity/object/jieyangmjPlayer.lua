-------------------------------------------------------------
--  @file   Player.lua
--  @brief  玩家对象
--  @author Zhu Can Qin
--  @DateTime:2016-08-26 18:28:58
--  Version: 1.0.0
--  Company  SteveSoft LLC.
--  Copyright  Copyright (c) 2016
--============================================================
local currentModuleName = ...
local Define 	= require "app.games.common.Define"
local Player 	= import("app.games.common.entity.object.Player")
local jieyangmjPlayer = class("jieyangmjPlayer",Player)
--[[
-- @brief  构造函数
-- @param  void
-- @return void
--]]
-- 实体属性
-- enCreatureEntityProp = {
-- 	USERID  = 1, 	-- 用户id
-- 	NAME 	= 2,	-- 名字  
-- 	LEVEL   = 3,    -- 等级
-- 	GENDER  = 4,    -- 性别
-- 	FORTUNE = 5,    -- 财富
-- 	VIP_EXP = 6,    -- VIP经验
-- 	VIP     = 7,    -- VIP等级
-- 	ICON_ID = 8,    -- 头像 
--  WIN     = 9,    -- 赢
-- 	WIN_PRE = 10,   -- 之前赢
-- 	TOTAL   = 11,  -- 总
-- 	SEX     = 12,   -- 性别
-- 	FLOWER  = 13,   -- 花牌
-- 	BANKER  = 14,   -- 庄家或者是先出牌的玩家
-- 	DOOR_WIND = 15, -- 门风方便显示哪家打牌
-- 	USER_STATUS = 16, 	-- 玩家状态
-- 	TING_STATUS = 17, 	-- 听状态
-- 	SITE 	= 18, 		-- 座次
-- 	OUT_CARD = 19,  -- 打出去的牌列表
-- },
function jieyangmjPlayer:ctor(context)
	jieyangmjPlayer.super.ctor(self, context)
end

--[
-- @brief  初始化函数
-- @param  context 现场
-- @return 本身
--]
function jieyangmjPlayer:initialize(context)
	self.super.initialize(self, context)
	self:setProp(enCreatureEntityProp.FLOWER, 	context.zhuaMaCards or {})
end


return jieyangmjPlayer
