--进入游戏界面
function enterGame(data)
    cc.SpriteFrameCache:getInstance():addSpriteFrames("games/common/mj/majiang_pai.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("games/common/mj/shezi.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("games/common/mj/flow.plist")
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("games/common/mj/armature/CpghAnimation.csb")
    Log.i("common###########enterGame",data)

    MjMediator:getInstance():onGameEntry(data)

end

--加载公共模块
require("app.games.common.GameConfig");

require("package_src.games.huizhoumj.GameAudioConfig");

-- CONFIG_GAEMID = 10023;--游戏ID
--是否支持用户自定义聊天
_gameUserChatTxt = true;

-- 翻牌显示图片
GC_TurnLaiziPath = "games/common/mj/games/fanpai.png"

--HONGZHONG_SUODUAN = true
NOT_DISPLAY_HONGZHONG  = true


-- 新手引导提示
_gameNewerContentText = "小提示：找您身边正在玩本游戏的朋友，加入麻友群，在群里随时组局，立刻约战！\n或者您自己组建一个麻友群，多找些身边麻友，在群里发条消息，几十人中总会有空闲的，玩上十几分钟也能过过瘾！完全和去棋牌室一样哦！现在还能得66元现金红包，赶快联系客服吧！"

-- 是否显示房卡
_isDiamondVisible = false
-- 是否显示方言
_isShowDialect    = false
-- 是否显示房间内右上角的微信
_isOpenWeiXin = true

--游戏动画文件配置
_gameArmatureFileInfoCfg ={
    ["dianpao"] = "games/common/mj/armature/dianpao.csb",           --点炮
    ["hu"] = "games/common/mj/armature/jingdeng.csb",               --胡碰杠补花等
    ["liuju"] = "games/common/mj/armature/liuju.csb",               --流局
    ["yaoshaizi"] = "games/common/mj/armature/yaoshaizi.csb",       --摇塞子
    ["yipaoduoxiang"] = "games/common/mj/armature/yipaoduoxiang.csb"--一炮多响
};
--朋友开房的玩法
FriendRoomPalyingTable = {
    ["zimo"] = {[1]     ="自摸底翻番" ,  [2] = "自摸底不翻番"},
    ["dianpao"]={[1]    = "带点炮胡",    [2] = "不带点炮胡"},
    ["dianpao"]={[1] = "带点炮胡",[2]="不带点炮胡"},
}

-- 游戏玩法规则
-- fangpaokehu|sihui|qihui|kepeng|bukebaoting|baotingjiafan
_gamePalyingName={
    [1] = {title = "di",            ch = "底"},
    [2] = {title = "ma",           ch = "马"},
    [3] = {title = "maigang",          ch = "买杠"},
    [4] = {title = "suanhua",             ch = "鸡胡算花"},
    [5] = {title = "fanma",          ch = "抢杠胡翻马"},
}

_gameHelpContentText = [[  您需要邀请3个好友，创建房间，好友按照房间号加入房间，就可以在一起打麻将了！就等于手机上有了棋牌室！建个好友麻将群，组局更迅速！

一、麻将用具
“来来开封麻将”由条、饼、万、东南西北中發白、春夏秋冬、梅兰菊竹组成，合计144张牌。

二、基本打法
1.以推倒胡为规则。
2.轮庄。起始东风玩家为庄，之后如果庄家胡牌或黄庄，上局庄家继续坐庄，如果闲家胡牌，下局则庄家的下家当庄。
3.有癞子（会），打色子确定癞子（翻起的牌加1为癞子，如果翻起的牌为花牌，则该张牌为癞子）（例：翻起的牌为4万，则5万为癞子；如果翻起的牌为红中，则红中为癞子）。
4.花牌不能被打出。
5.癞子牌可以被打出，对打出者没有影响。其他玩家不能吃碰这张牌。
6.翻出确定癞子的那张牌不能被抓走。
7.4会可碰、不可吃；7会不可吃，不可碰，不可明杠。
8.中、發、白、为花牌，抓到可直接选择杠（补花），打到什么风圈时什么是花。（例：东风圈时东风为花，西风圈时西风为花。）（起始为东风圈，每个人都当过庄后，坐东风玩家第二次上庄时为下一风圈，风圈顺序为东、南、西、北。）
9.剩下20张牌黄庄，有一个杠加2张（花牌不算）。剩下黄庄牌数时不能在杠（补花）。
10.4会只能自摸胡牌，7会自摸和放炮可胡。
]];

_gameChatTxtCfg = {};

GAME_NAME = "来来惠州麻将";
-- 选择城市界面屏蔽不显示的名字
_gameHideSelectCitys = {
    --["宿州"] = true,
};


-- 胡牌番型后缀
GC_PolicyWord = "番 "
_isOpenWeiXin = true



-- 获取分享信息
function getWxShareInfo(roomInfo, playerInfo, selectSetInfo)
    -- Log.i("getWxShareInfo....", roomInfo, playerInfo, selectSetInfo)
    local paramData = {}
    paramData[1] = playerInfo.pa .. ""
    local title = ""
    if selectSetInfo.clI and selectSetInfo.clI > 0 then
        title = Util.replaceFindInfo(roomInfo.shareTitle, '房间号', {'亲友圈房间号'})
        title = Util.replaceFindInfo(title, 'd', paramData)
    else
        title = Util.replaceFindInfo(roomInfo.shareTitle, 'd', paramData)
    end

    local itemList=Util.analyzeString_2(selectSetInfo.wa);
    if(#itemList>0) then
        local str=""
        for i=1,#itemList do
            local st = string.format("%s,",kFriendRoomInfo:getPlayingInfoByTitle(itemList[i]).ch)
            Log.i("st", st)
            str = str .. st
        end
        paramData[1] = str
    else
        paramData[1] = ""
    end
    --
    local playernum = (selectSetInfo.plS and selectSetInfo.plS > 1 and selectSetInfo.plS <= 4 and selectSetInfo.plS or 4 ) .. "人房,"
    paramData[2] = playernum

    paramData[2]= paramData[2] .. selectSetInfo.roS;
    -- Log.i("------roomInfo.shareDesc",roomInfo.shareDesc);
    local wanjiaStr = "";
    for k, v in pairs(playerInfo.pl) do
       local retName = ToolKit.subUtfStrByCn(v.niN, 0,  5, "");
       wanjiaStr = wanjiaStr .. retName .. ","
    end
    paramData[1] = paramData[1] .. wanjiaStr
    local charge = ""
    if selectSetInfo.clI and selectSetInfo.clI > 0 then
        charge = "亲友圈付费"
    else
        local texts = {"房主付费", "大赢家付费", "AA付费"}
        charge = (selectSetInfo.RoJST and selectSetInfo.RoJST >= 1 and selectSetInfo.RoJST <= 3) and texts[selectSetInfo.RoJST] or texts[1]
    end
    paramData[2] = paramData[2] .. "局," .. charge

    local s = Util.replaceFindInfo(roomInfo.shareDesc, '局', {[1]=""})

    local desc = Util.replaceFindInfo(s, 'd', paramData)

    return title, desc
end

--------------------------
-- 规则获取放在这儿, 方便不同游戏修改规则文本
-- @return table: {ch = "xx"}
function getPlayingInfoByTitle(title)
    for k, v in pairs(_gamePalyingName) do
        if (v.title == title) then
            return v
        end
    end
    return nil
end

-- ----------------------
-- --@ pram  :
-- --@ itemlist
-- --@ 存放规则字段   如 {maigang,6,6}  倒数第一个数字表示底数   倒数第二个表示马数
-- ----------------------
-- function getRules(itemlist)
--     if #itemlist < 2 then
--         return
--     end

--     local ruleStr = ""
--     ruleStr = ruleStr .. tostring (itemlist[#itemlist - 1]) .."马  " .. tostring (itemlist[#itemlist ]) .. "分"
--     return ruleStr
-- end

-- ----------------------
-- --@ pram  :
-- --@ itemlist
-- --@ 存放规则字段   如 {maigang,6,6}  倒数第一个数字表示底数   倒数第二个表示马数
-- ----------------------
-- function getShareRules(itemlist)
--     if #itemlist < 2 then
--         return
--     end

--     local ruleStr = ""
--     ruleStr = ruleStr .. tostring (itemlist[#itemlist - 1]) .."马," .. tostring (itemlist[#itemlist ]) .. "分,"
--     return ruleStr
-- end


-- function getGamePalyingText()
--     -- print(debug.traceback(" how can i come here"))
--     local palyingInfo = kFriendRoomInfo:getSelectRoomInfo()

--     local itemList= Util.analyzeString_2(palyingInfo.wa)
--     Log.i("getGamePalyingText itemList.....",itemList)
--     local ruleStr = ""
--     ruleStr = getRules(itemList)

--     return {ruleStr}
-- end

function getMaCount()
    local palyingInfo = kFriendRoomInfo:getSelectRoomInfo()

    local itemList= Util.analyzeString_2(palyingInfo.wa)
    Log.i("palyingInfo ", palyingInfo)
    Log.i("itemList ", itemList)
    local maCount = 0
    for k,v in pairs(itemList) do
        local idx = string.find(v, "_ma")
        Log.i("idx", idx)
        Log.i("v", v)
        if idx then
            maCount = tonumber(string.sub(v, 1, idx-1))
        end
    end

    return maCount
end
