local DDZSocketCmd = require("package_src.games.paodekuai.pdkcommon.data.PokerCommonSocketCmd")

DDZSocketCmd.CODE_REC_GAMESTART = 32012;  --开始
DDZSocketCmd.CODE_REC_CALLLORD = 32011;
DDZSocketCmd.CODE_SEND_CALLLORD = 32011; ---叫地主
DDZSocketCmd.CODE_REC_DOUBLE = 32013;   --加倍
DDZSocketCmd.CODE_SEND_DOUBLE = 32013;	
DDZSocketCmd.CODE_REC_ROBLORD = 32014;   ---抢地主
DDZSocketCmd.CODE_SEND_ROBLORD = 32014;
DDZSocketCmd.CODE_REC_MINGPAI = 32015;	--明牌
DDZSocketCmd.CODE_SEND_MINGPAI = 32015;
DDZSocketCmd.CODE_REC_STARTPLAY = 32003;
DDZSocketCmd.CODE_REC_OUTCARD = 32010; --出牌
DDZSocketCmd.CODE_SEND_OUTCARD = 32010;
DDZSocketCmd.CODE_REC_GAMEOVER = 32020; ---单局结束
DDZSocketCmd.CODE_REC_RECONNECT = 32016; --重连恢复对局
DDZSocketCmd.CODE_UPDATE_CASH = 30002;

--注册委托监听消息
--队列消息
DDZSocketCmd.queuecmd = {
	DDZSocketCmd.CODE_REC_GAMESTART,
	DDZSocketCmd.CODE_REC_CALLLORD,
	DDZSocketCmd.CODE_REC_ROBLORD,
	DDZSocketCmd.CODE_REC_DOUBLE,
	DDZSocketCmd.CODE_REC_STARTPLAY,
	DDZSocketCmd.CODE_REC_OUTCARD,
	DDZSocketCmd.CODE_REC_GAMEOVER,
	DDZSocketCmd.CODE_REC_RECONNECT,
	--DDZSocketCmd.CODE_REC_TOTAL_GAME_OVER,---全局结束 22009
}

--即时消息
DDZSocketCmd.instantcmd = {
	DDZSocketCmd.CODE_REC_ExitRoom,
	DDZSocketCmd.CODE_REC_RESUMEGAME, --TODO 这条消息不知道是否存在
	DDZSocketCmd.CODE_USERDATA_POINT,
	DDZSocketCmd.CODE_UPDATE_CASH,
	DDZSocketCmd.CODE_TUOGUAN,
	DDZSocketCmd.CODE_DEFAULT_CHAT,
	DDZSocketCmd.CODE_USER_CHAT,
	DDZSocketCmd.CODE_REC_PAOMADENG,
	DDZSocketCmd.CODE_REC_GETORDER,
	DDZSocketCmd.CODE_REC_CHARGERESULT,
	DDZSocketCmd.CODE_REC_POKERDIALOG,
	DDZSocketCmd.CODE_FRIEND_ROOM_LEAVE,
	DDZSocketCmd.CODE_RECV_FRIEND_ROOM_END, ---22010; --邀请房结束
	DDZSocketCmd.CODE_REC_SAY_CHAT,
	DDZSocketCmd.CODE_REC_ENTERROOM,
	DDZSocketCmd.CODE_REC_CONTINUE,
	DDZSocketCmd.CODE_REC_BROCAST, --通知
	DDZSocketCmd.CODE_RECV_FRIEND_ROOM_INFO,  --22006邀请房信息
	DDZSocketCmd.CODE_REC_TOTAL_GAME_OVER,---全局结束 22009
	DDZSocketCmd.CODE_REC_LOCATION,
	DDZSocketCmd.CODE_REC_ACITVITY_JIESUAN,     --结算时收到的消息
	DDZSocketCmd.CODE_PLAYER_ROOM_STATE,	-- 房间中用于接收房间被解散,退出到大厅的消息

}



return DDZSocketCmd
