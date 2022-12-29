main(){}
#include <a_samp>
#undef MAX_PLAYERS
#define MAX_PLAYERS   (200)
#define MAX_ZONE      (10)
#define MAX_PARKING	  (38)
#define MAX_EGGS	  (20)
#define max_posts	  (2)
#include <file>
#include <string>
#include <a_actor>
#include <a_mysql>
#include <Pawn.CMD>
#include <mxINI>
#include <sscanf2>
#include <streamer>
#include <fixobject>
#include <TOTP>
#include <mail>
#include <progress>
#include <a_http>
#include <crashdetect>
#include <nex-ac>
#include <foreach>
#include <easy_screen_fade_by_otacon>
#include <geolocation>
new mysql;
#define void%0(%1) forward %0(%1); public%0(%1)
#define publics%0(%1) forward%0(%1); public%0(%1)
#define nfor(%0,%1)			for(new %0; %0 != %1; %0++)
new Foreach_IDs[MAX_PLAYERS], Player_Num_IDs, PlayerNum[MAX_PLAYERS];
#define B_BUD       (11) // 5eter
#define MAX_FAMILYS	2000
#define volid(%0,%1)   		for(new %0; %0 < %1; %0++)
#define KEY_HANDBRAKE (128)
//
new format_string[228];
#define SendMes(%0,%1,%2,%3) \
        format(format_string, sizeof(format_string),%2,%3) && SendClientMessage(%0, %1, format_string)
//
new BlackMarket,BlackSellAccs,BlackSellCar,BlackMarketMoney;

new TradeDone[MAX_PLAYERS];
new Text:debugglobal[2];
new PlayerText:saas_PTD[MAX_PLAYERS][1];
new skorostb[MAX_PLAYERS];
new Text:others[7];
new objectshar[MAX_PLAYERS];
new AksDel[MAX_PLAYERS][8];
new AdminTester[MAX_PLAYERS];
new pEngine[MAX_PLAYERS char];
new PlayerText:kletka[MAX_PLAYERS][2];
new
	Text:launch[9],
	launchdone[MAX_PLAYERS],
	launchtimer[MAX_PLAYERS],
	LauncherSize2[MAX_PLAYERS],
	launchtimerback[MAX_PLAYERS],
	Float:LauncherSize[MAX_PLAYERS],
	PlayerText:launchsize[MAX_PLAYERS][1];
new
	zapomni[MAX_PLAYERS][10],
	zapomnicena[MAX_PLAYERS][10],
	zapomniname[MAX_PLAYERS][10][MAX_PLAYER_NAME];
#define not1                1108.3807,-1433.7589,15.7969
#define not2                1108.4063,-1438.3242,15.7969
#define not3                1108.3394,-1442.7822,15.7969
#define not4                1108.4362,-1449.2780,15.7969
#define not5 				1108.1364,-1456.3624,15.7969
#define not6 				1108.3264,-1460.7449,15.7969
#define not7     			1108.2501,-1465.2937,15.7969
#define not8 				1104.8319,-1477.2693,15.7969
#define not9 				1107.2106,-1507.9063,15.7969
#define not10 				1117.8083,-1516.1581,15.7969
#define not11 				1121.8660,-1517.6212,15.7969
#define not12 				1134.3781,-1517.2764,15.7969
#define not13 				1138.2891,-1515.9064,15.7969
#define not14     			1137.4443,-1513.4227,15.7969
#define not15 				1148.7446,-1509.0000,15.7969
#define not16 				1149.9197,-1478.8477,15.7969
#define not17 				1150.7633,-1473.1973,15.7969
#define not18 				1148.7556,-1465.4398,15.7969
#define not19 				1149.1162,-1460.8634,15.7969
#define not20 				1148.7557,-1456.2515,15.7969
#define not21 				1148.8909,-1442.9900,15.7969
#define not22 				1148.9330,-1438.4600,15.7969
#define not23 				1148.7556,-1433.9813,15.7969
#define not24 				1130.0153,-1438.1522,15.7969
#define not25 				1130.0154,-1442.7555,15.7969
#define not26 				1130.0154,-1447.2247,15.7969
#define not27 				1129.7723,-1451.7391,15.7969
#define not28 				1129.8629,-1456.3010,15.7969
#define not29 				1129.7153,-1460.8668,15.7969
#define not30 				1127.7471,-1461.0232,15.7969
#define not31 				1127.8771,-1456.3027,15.7969
#define not32 				1127.7465,-1451.9019,15.7969
#define not33 				1128.0288,-1447.2938,15.7969
#define not34 				1128.0038,-1442.9703,15.7969
#define not35 				1128.0370,-1438.4806,15.7969
#define not36 				1119.1992,-1475.5682,15.7969
#define not37 				1119.1707,-1484.5419,15.7969
#define not38 				1119.1234,-1489.0891,15.7969
#define not39 				1119.1305,-1493.5952,15.8003
#define not40 				1118.9938,-1502.6208,15.8003
enum BumBooxx
{
	bbBox
}
enum OB_DATA
{
    obModel,
    Float:obX,
    Float:obY,
    Float:obZ,
    Float:obXR,
    Float:obYR,
    Float:obZR,
    obID
}
new gObjects[MAX_OBJECTS][OB_DATA];
enum MYSQL_SETTINGS
{
	DOOME_HOST,
	DOOME_USERNAME,
	DOOME_PASSWORD,
	DOOME_DATABASE
}
new MySQLSettings[MYSQL_SETTINGS][30];
enum pInfo
{
	pID,
	pNone,
	pNameFamily,
	pNameFamily2[15],
	pPlayedTime,
	pKey,
	pPodtverTrade,
	pQiwi[16],
	pVivod,
	pDep,
	pAvtorization,
	pCMDplveh,
	pFamily,
	pRefID,
	pDepTime,
	pDepTime2,
	pFamilyMute,
	pFamilyChat,
	//Text3D: pFamText[128],
	pVxod,
	Float:pStoika,
	pFamilyMember,
	pDopInv[72],
	Float:pSuperComp,
	pLavkaCost[10],
	Float:pServer,
	Float:pKvant,
	Float:pData,
	Float:pStoikaCost,
	Float:pSuperCompCost,
	Float:pServerCost,
	Float:pKvantCost,
	Float:pDataCost,
	pFamColor,
	pCraftDrug,
	Float:pVKCOIN,
	Float:pClick,
	Float:pClickCost,
	Float:pKarta,
	Float:pKartaCost,
	pFamName[16],
	pInventoryS[72],
	pInventorySK[72],
	pFamType[16],
	pDiscord[31],
	pRaidCall[31],
	pObyava[61],
	pFamSlog[41],
	pSod[61],
	pTalons,
	pDiceLox,
	pDiceWin,
	pColorInv,
	pKeyCheck,
	pInventori2,
	pOldRepl,
	pDontShkaf,
	pCreateFam,
	pIDTime,
	pRemoved,
	pGolda,
	pSilverW,
	pKamenb,
	pSostoyanie,
	pMoreHouses,
	pDonatMoney,
	pRefs,
	pPromoUsed,
	pPromo,
	pPlanshet,
	pInventoryKolvoDop,
	pCraftClose,
	pAllRepl,
	pMusorPos,
	pMailCheck,
	pCraftX,
	pCraftC,
	pCraftV,
	pCraftB,
	pCraftN,
	pLanguage,
	pYaPolniyDolboeb,
	pLevel,
	pXyina,
	pInventori,
	pCarSkill,
	pTimeInv3,
	pMoney,
	pCheepsTimer,
	pSupreme,
	pBeg[5],
	pExp,
	pEventStart,
	pInvColors,
	pCoins300,
	pCoins500,
	pDolboeb,
	pDopKletki,
	pMoney1000000,
	pProstoTak2,
	pProstoTak,
	pSkate,
	pInvOpen,
	pTrailers,
	pGovnoSuper,
	pTrailerStop,
	pTrailerSpawn,
	pYadolboeb,
	pCraft,
	pCraft2,
	pCraft3,
	pCraft4,
	pCraft5,
	pCraft6,
	pCraft7,
	pCraft8,
	pCraft9,
	pCraft10,
	pCraftA,
	pCraftS,
	pCraftD,
	pCraftF,
	pSecretMoney,
	pSecretMoney2,
	pSecretMoney3,
	pTrash,
	pTrashOpen,
	pCraftG,
	pCraftH,
	pCraftJ,
	pCraftK,
	pCraftL,
	pCraftZ,
	pCraftA1,
	pCraftS2,
	pCraftD3,
	pCraftF4,
	pCraftG5,
	pCraftH6,
	pCraftJ7,
	pCraftK8,
	pCraftL9,
	pCraftZ10,
	pClicked,
	pSuperGOVNO,
	pSuperGOVNO2,
	pSuperCraft2,
	pSuperCraft,
	pTrailerTime,
	pInventoryKolvo[72],
	pInvs[72],
	pCoins200,
	pEnterTrailer,
	pInventory[72],
	pTrailerShtraf,
	pFirstCase,
	pMoney2000000,
	pMoney5000000,
	pExp2,
	pExp4,
	pBuyTrailer,
	//pInventory,
	pExp8,
	pInvStandart,
	pGovnishePolnoe,
	pSecondpage,
	pWanted,
	pVIP,
	pLeader,
	pMember,
	pAdmin,
	pCodes,
	pHelper,
	pWeapon[3],
	pAmmo[3],
	pGunLic,
	pBoatLic,
	pFishLic,
	pFlyLic,
	pCarLic,
	pBikeLic,
	pPodtver,
Float:pPos_X,
Float:pPos_Y,
Float:pPos_Z,
Float:pPos_A,
Float:pOld_X,
Float:pOld_Y,
Float:pOld_Z,
Float:pCPos_X,
Float:pCPos_Y,
Float:pCPos_Z,
	pVirMoney,
	pWarns,
	pHouseKey,
	pSnow,
	pBizKey,
	pFWarns,
	pView,
	pRank,
	pContractTime,
	pCars,
	pSex,
	pSigs,
	pLighter,
	pRace,
	pBank,
	pSkin,
	pOldSkin,
	pTelNum,
	pPhone,
	pMats,
	pValue,
	pPackets,
	pD_Packets,
	pDrugs,
	pScrew,
	pPlayHours,
	pJob,
	pMuteTime,
	pFMuteTime,
	pHeal,
	pHealTime,
	pJailTime,
	pJail,
	pBailPrice,
	pKungfu,
	pKneehead,
	pElbow,
	pBoxing,
	pSpawned,
	pSpining,
	pWorms,
	pRadio,
	pLotto,
	pMask,
	pMaskON,
	pRoliki,
	pFuel,
 	pPasatizhi,
	pDCTime,
	pPhoneBook,
	pPistol_Skill,
	pSDPistol_Skill,
	pEagle_Skill,
	pShotGun_Skill,
	pUZI_Skill,
	pMP5_Skill,
	pAK47_Skill,
	pM4_Skill,
	pSniper_Skill,
	pInvGun,
	pInvAmmo,
	pGlasses,
	pBandans,
	pGold,
	pHats,
	pFrom,
	pOOC,
	pBL,
	pZKP,
Float:pHealth,
Float:pArmour,
Float:pShield,
	pArmours,
	pPoison,
	pPack,
	pSprunk,
	pCheeps,
	pBeer,
	pRepPack,
	pSprunks,
	pCheepses,
	pBeers,
	pFeFinder,
	pGetBonus,
	pClip,
	pCredit,
	pBlackout,
	pSyringe,
	pRope,
	pBomb,
	pRepBan,
	pAskBan,
	pRPTest,
	pStatsStyle,
	pPayDay,
	pAge,
	pEnterKey,
	pWalentin,
	pBuyWalent,
	pF_Skill,
	pZ_Skill,
	pP_Skill,
	pZa_Skill,
	pIn_Skill,
	pMy_Skill,
	pBy_Skill,
	pEnergy,
	pAmmos[13],
	pGuns[13],
	pShowName,
	plveh,
	pMerrit[25],
	pSendName[25],
	pCalling,
	pONPhoneTalk,
	pbydilnik,
	pKazpay,
	pKlogin,
Float:Admin_X,
Float:Admin_Y,
Float:Admin_Z,
	pFtime1,
	pLastGun,
	pLastAmmo,
	pTimeToLastWarn,
	oInTir,
	preOrg,
	preOrgg,
	pObjikt,
Float:pLeftPosx,
Float:pLeftPosy,
Float:pRightPosx,
Float:pRightPosy,
	pHSpectr,
	pScutes,
	pMScutes,
	pVID,
	pType,
	pSlotItem[8],
	pType2,
	pNeedMessage,
	pRedio,
	pHospital,
	pSecond,
	pHavePassword,
	pMore,
	pLastLogin[120],
	pLastIP[60],
	pShowIper,
	pShowCase,
	pVipTime,
	pBuildType,
	pZall,pWhore, pAmountSex, pDisease,pMesh,
	pName,
	pReputation,
	pLoadTextures,
	pPredlog,
	pCotton,
	pTeleport,
	pBronzeRoulette,
	pSilverRoulette,
	pGoldRoulette,
	pChestTime,
	pSeat,
	pEventTime,
	pInvLang,
	pAWarns,
	pDataReg[12],
	pAPass[65],
	pPodtverApanel,
	pLastIPAdm[60],
	pVirtualWorld,
	pInterior,
	pTypeSpeed,
	Float:pInvPos_X,
	Float:pInvPos_Y,
	Float:pInvSize_X,
	Float:pInvSize_Y,
	pAdminPrefix[64],
	pGoogleCode[64],
	pGoogleStatus
}
new PlayerInfo[MAX_PLAYERS][pInfo];
new besttime[MAX_PLAYERS];
//
enum Post
{
    Float:post_x,
    Float:post_y,
    Float:post_z,
    namepost[24],

    area,
    Text3D:post3D,
    pID,
}
new Float:post_info[max_posts][Post] =
{
    {107.4416,1900.1370,33.4979,"Вышка №1"}, //
    {98.8171,1924.0579,18.2171,"КПП №1"} // ниже добавляйте свои
};
//
enum ContInfo
{
	pID,
	pOwned[256],
	pCash,
	pTime,
	pTimeClose,
	pPrize1[256],
	pPrize1Col,
	pPrize2[256],
	pPrize2Col,
	pPrize3[256],
	pPrize3Col,
	pPrize4[256],
	pPrize4Col,
	pPrize5[256],
	pPrize5Col
}
new gPremiumContDor[8];
new gConteiner[10][ContInfo];
new conteiner[10];
//
new Taxt__text[MAX_VEHICLES];
new PlayerText:LoadTextures[MAX_PLAYERS][9];
//
new Text:Logotype[3];
enum ARs
{
	arCentralRinok
}
new gAreas[ARs];
//new famid[MAX_FAMILYS];
enum pFamilyInfo
{
    famName[16],
	famColor,
};
#define MAX_FAMILY (1000)
enum e_FAMILY_INFO
{
	famID,
	famName[15],
	famSlogan[40],
	famOnline,
	famMembersCount,
	famCreator[MAX_PLAYER_NAME],
	famZam[MAX_PLAYER_NAME],
	famZam2[MAX_PLAYER_NAME],
	famChatColor,
	famGalka,
	fMoney,
	fReps,
	fExp,
	fLevel,
	famDiscord[40],
	famRaidCall[10],
	fObyava[60],
	fType
}
new FamilyInfo[MAX_FAMILY][e_FAMILY_INFO];
new OBJECT_SLEGAN[MAX_PLAYERS]; // Проверка на то что имеется у игрока инструмент или нет.

static const MinePoroda[5][8] =
{
	{"камня"},
	{"металла"},
	{"бронзы"},
	{"серебра"},
	{"золота"}
};
const MAX_MINE_OBJECT = 35;
enum mineInfo
{
    bool:mineStatus,
    Float:minePosX,
    Float:minePosY,
    Float:minePosZ,
    mineObject,
    Text3D:mineLabel,
    mineTimer,
    minePoroda
}
new MineInfo[MAX_MINE_OBJECT][mineInfo] =
{
    {true, 619.2419, 941.3776, -37.2434},
    {true, 661.9933, 936.9175, -37.8092},
    {true, 629.8119, 947.0472, -35.2863},
    {true, 632.1992, 953.4025, -34.3900},
    {true, 644.1904, 955.9868, -34.1643},
    {true, 646.9728, 941.4316, -35.6497},
    {true, 584.6645, 949.8398, -30.6175},
    {true, 563.0754, 944.5233, -29.5798},
    {true, 497.0916, 917.7969, -29.9888},
    {true, 508.1040, 924.3862, -28.4721},
    {true, 508.4806, 938.4163, -27.7112},
    {true, 518.5377, 944.4051, -25.3424},
    {true, 528.7015, 958.9933, -22.2651},
    {true, 532.1467, 969.0619, -21.7194},
    {true, 518.7510, 969.2048, -23.7236},
    {true, 488.4578, 896.8007, -30.5957},
    {true, 470.8828, 871.3386, -28.9356},
    {true, 496.9825, 850.9363, -29.4746},
    {true, 510.7053, 835.5143, -26.7997},
    {true, 514.9717, 822.7236, -24.7397},
    {true, 518.4806, 809.1451, -23.2232},
    {true, 506.6518, 805.2540, -21.9453},
    {true, 500.1867, 792.5642, -21.6318},
    {true, 517.2272, 790.6378, -21.3920},
    {true, 565.3442, 770.0980, -16.5111},
    {true, 582.7704, 791.1359, -29.9858},
    {true, 692.9124, 799.8726, -30.2292},
    {true, 716.2703, 816.9769, -30.2541},
    {true, 713.0031, 833.7784, -30.2268},
    {true, 719.2053, 847.8356, -29.9590},
    {true, 686.4009, 788.7589, -29.9033},
    {true, 561.9888, 800.1697, -28.0481},
    {true, 615.9201, 777.2510, -31.8031},
    {true, 648.7132, 777.1953, -29.9342},
    {true, 663.9606, 788.6589, -29.9526}
};
new KladObject[19];
#define MAX_KLAD_STATE 19
enum Zagadka
{
    Float:kladX,
    Float:kladY,
    Float:kladZ,
	kladStory[512],
	kladStatus,
	kladOtvet[512],
	kladPrizeStatus
}
new KladInfo[MAX_KLAD_STATE][Zagadka] =
{
	{-296.1214,-1790.9861,9.0723,"В каком году открыт сервер Ser?",1,"2020",1},
	{1475.7133,-1400.2588,45.7422,"Количество работ в центре занятости?",1,"10",1},
	{499.8699,-473.5437,39.5155,"Кто однорукий всегда стоит в казино?",1,"Бандит",1},
	{623.8306,-625.1243,15.8000,"Минимальная сумма пожертвования в благотворительность?",1,"10000",1},
	{756.5990,-1574.5834,12.7808,"Старый, мудрый, 05 дежурный?",1,"Николай",1},
	{767.9126,-1663.0708,3.4177,"Каждый проходит через это в начале игры?",1,"Регистрация",1},
	{790.7722,-1792.5516,12.1119,"Самая популярная игра в казино?",1,"Кости",1},
	{1933.9038,-1636.2385,12.5469,"Как называется  YouTube канал лучшего сливщика?",1,"PositivTV",1},
	{1961.7205,-1616.4329,14.9688,"Когда добавили депозит?",1,"2019",1},
	{1779.7913,1075.3888,5.8215,"Какой аксессуар может сидеть на плече?",1,"Попугай",1},
	{2398.7834,1203.4448,9.8203,"В каком году был открыт сервер Arizona?",1,"2019",1},
	{-456.4667,1965.1682,81.1729,"Какой ник у Максима?",1,"Maxim_Nazarov",1},
	{-811.5665,1498.6641,19.4062,"Он бывает 7 раз в неделю, 24 раза в сутки?!",1,"PayDay",1},
	{-2315.3760,101.5533,34.3809,"В честь кого установлен памятник недалеко от моста ЛС-СФ?",1,"Коли",1},
	{-2287.0715,-1610.9303,480.8772,"Что такое BigHost?",1,"Хостинг",1},
	{-2075.9104,-2509.6924,29.4219,"Когда вышло обновление с кладами(месяц,год через запятую)?",1,"Октябрь,2019",1},
	{-2072.5271,-2494.3911,29.6301,"Любит репорт отвечать,игрокам всем помогать",1,"Хелпер",1},
	{1516.4194,187.0096,22.1569,"Кто закопал эти клады?",1,"Коля",1},
	{1538.3234,198.0489,21.6153,"Какой NPC ждёт на аэропорте ЛС?",1,"Джереми",1}
};
#define MAX_AUTO_BAZAR  49
enum autoBazar
{
    Float:autoBazarPosX,
    Float:autoBazarPosY,
    Float:autoBazarPosZ,
    Float:autoBazarZAngle,
    Float:autoBazar2PosX,
    Float:autoBazar2PosY,
    Float:autoBazar2PosZ,
    Text3D:autoBazarLabel,
    Text3D:autoBazarLabel2,
	autoBazarObject,
	autoBazarArea,
	autoBazarCost,
	autoBazarCarID,
	autoBazarplayerid,
	autoBazarTimer
}
new autoBazarInfo[MAX_AUTO_BAZAR][autoBazar] =
{
    {-2133.7847,-757.5536,32.0234,88.8255},
    {-2133.2046,-760.4934,32.0234,88.8255},
    {-2133.4939,-763.5651,32.0234,88.8255},
    {-2133.6294,-766.5255,32.0234,88.8255},
    {-2133.7976,-769.6598,32.0234,88.8255},
    {-2133.4438,-772.4928,32.0234,88.8255},
    {-2133.3384,-775.6821,32.0234,88.8255},
    {-2133.0896,-778.6199,32.0234,88.8255},
    {-2133.5383,-781.6777,32.0234,88.8255},
    {-2133.5181,-784.6282,32.0234,88.8255},
    {-2133.0618,-787.7657,32.0234,88.8255},
    {-2133.6675,-790.4675,32.0234,88.8255},
    {-2134.1685,-793.5968,32.0234,88.8255},
    {-2134.0239,-796.6945,32.0234,88.8255},
    {-2133.9241,-799.5476,32.0234,88.8255},
    {-2133.3132,-802.7231,32.0234,88.8255},
    {-2149.8672,-757.6962,32.0234,269.5971},
    {-2149.7026,-760.7056,32.0234,269.5971},
    {-2150.0671,-763.4629,32.0234,269.5971},
    {-2150.1787,-766.7797,32.0234,269.5971},
    {-2149.8430,-769.5658,32.0234,269.5971},
    {-2149.7102,-772.5457,32.0234,269.5971},
    {-2150.1123,-775.5920,32.0234,269.5971},
    {-2150.0867,-778.6870,32.0234,269.5971},
    {-2149.9207,-781.6351,32.0234,269.5971},
    {-2150.4460,-784.5776,32.0234,269.5971},
    {-2150.0620,-787.5490,32.0234,269.5971},
    {-2149.3301,-790.8079,32.0234,269.5971},
    {-2149.0452,-793.5135,32.0234,269.5971},
    {-2149.4521,-796.5894,32.0234,269.5971},
    {-2149.1191,-799.6165,32.0234,269.5971},
    {-2148.6055,-802.5846,32.0234,269.5971},
    {-2148.5591,-805.8231,32.0234,269.5971},
    {-2148.9773,-808.6389,32.0234,269.5971},
    {-2148.9690,-811.6345,32.0234,269.5971},
    {-2148.9536,-814.8036,32.0234,269.5971},
    {-2149.1687,-818.1646,32.0234,269.5971},
    {-2148.6953,-821.4638,32.0234,269.5971},
    {-2148.1729,-824.8022,32.0234,269.5971},
    {-2148.3762,-828.0490,32.0234,269.5971},
    {-2148.8687,-831.1489,32.0234,269.5971},
    {-2148.8994,-834.4568,32.0234,269.5971},
    {-2148.9795,-837.8000,32.0234,269.5971},
    {-2149.3828,-841.1108,32.0234,269.5971},
    {-2148.8235,-844.0851,32.0234,269.5971},
    {-2148.8108,-847.5101,32.0234,269.5971},
    {-2148.9412,-850.5940,32.0234,269.5971},
    {-2149.1848,-853.8034,32.0234,269.5971},
    {-2148.9441,-856.9216,32.0234,269.5971}
};
static const FamilyChatColor[31][7] =
{
	{"FF5E5E"},
	{"FFFFFF"},
	{"E65075"},
	{"EFA4B7"},
	{"905B69"},
	{"D052CE"},
	{"FF00FC"},
	{"5D395D"},
	{"8E38EA"},
	{"6B21BB"},
	{"2F00FF"},
	{"7456F8"},
	{"5287F1"},
	{"1DBAF2"},
	{"308EB0"},
	{"30B061"},
	{"20F271"},
	{"107135"},
	{"47EB2A"},
	{"9EE991"},
	{"C2D95E"},
	{"D1FF00"},
	{"7B9022"},
	{"FFC900"},
	{"E8CA60"},
	{"6B5B1F"},
	{"FF8400"},
	{"C04312"},
	{"5C4C45"},
	{"373534"},
	{"351204"}
};

new report[MAX_PLAYERS], ReReport[MAX_PLAYERS];
//new FamilyInfo[MAX_PLAYERS][pFamilyInfo];
#define MAX_SALON_OWNABLECARS (3000)
#define MAX_SEAT    (252)
#define MAX_REPORTS (200)
#define dReport 5567
//
#define pl1                 1110.6871,-1433.6788,15.7969
#define pl2                 1110.7755,-1438.1166,15.7969
#define pl3                 1110.7479,-1442.7822,15.7969
#define pl4                 1110.7581,-1449.5863,15.7969
#define pl5 				1110.7659,-1456.2471,15.7969
#define pl6 				1111.1409,-1460.3457,15.7969
#define pl7 				1111.0654,-1464.6130,15.7969
#define pl8 				1109.2700,-1473.4427,15.7969
#define pl9 				1107.6213,-1477.7317,15.7969
#define pl10 				1109.0746,-1506.3014,15.7969
#define pl11 				1118.7814,-1513.4781,15.7969
#define pl12 				1123.0959,-1514.7286,15.7969
#define pl13 				1132.9354,-1515.1434,15.7969
#define pl14 				1137.4443,-1513.4227,15.7969
#define pl15 				1146.9904,-1507.4929,15.7969
#define pl16 				1149.9197,-1478.8477,15.7969
#define pl17 				1147.9353,-1474.2538,15.7969
#define pl18 				1146.2300,-1466.0222,15.7969
#define pl19 				1146.2316,-1461.2733,15.7969
#define pl20 				1146.2882,-1456.7292,15.7969
#define pl21 				1146.4071,-1443.0867,15.7969
#define pl22 				1146.4598,-1438.6909,15.7969
#define pl23 				1146.3535,-1433.9849,15.7969
#define pl24 				1132.5663,-1438.1964,15.7969
#define pl25 				1132.4624,-1442.9615,15.7969
#define pl26 				1132.4055,-1447.3654,15.7969
#define pl27 				1132.4354,-1451.8623,15.7969
#define pl28 				1132.5240,-1456.2272,15.7969
#define pl29 				1132.3529,-1461.0205,15.7969
#define pl30 				1125.2633,-1461.0713,15.7969
#define pl31 				1125.3037,-1456.3646,15.7969
#define pl32 				1125.3778,-1451.9352,15.7969
#define pl33 				1125.1851,-1447.3588,15.7969
#define pl34 				1125.5183,-1442.7278,15.7969
#define pl35 				1125.2375,-1438.4025,15.7969
#define pl36 				1116.1820,-1475.5432,15.7969
#define pl37 				1116.2982,-1484.6189,15.7969
#define pl38 				1116.5433,-1489.2039,15.7969
#define pl39 				1116.5088,-1493.6077,15.8003
#define pl40 				1116.2222,-1503.0126,15.8003

#define lang rus
#define PRESS_Y (65536)
#define PRESS_C (2)
#define PRESS_N (131072)
#define PRESS_F (16)
#define PRESS_TAB (1)
#define PRESS_H (262144)
#define PRESS_CAPSLOCK (128)
#define PRESS_SHIFT (32)
#define PRESS_CTRL (4)
#define PRESS_ALT (1024)
#define PRESS_QSPACE(256)
#define PRESS_E (64)
#define PRESS_Q (256)
#define PRESS_E (64)

#define COLOR_PROJECT 			0x5F63F0AA
#define COLOR_TRAILER       0xFF9966FF
#define AC_TABLE_SETTINGS               "anticheat_settings"
#define AC_TABLE_FIELD_CODE             "ac_code"
#define AC_TABLE_FIELD_TRIGGER          "ac_code_trigger_type"
#define AC_MAX_CODES                    53
#define AC_MAX_CODE_LENGTH                 (4 + 1)
#define AC_MAX_CODE_NAME_LENGTH            (33 + 1)
#define AC_MAX_TRIGGER_TYPES            3
#define AC_MAX_TRIGGER_TYPE_NAME_LENGTH    (16 + 1)
#define AC_GLOBAL_TRIGGER_TYPE_PLAYER    0
#define AC_GLOBAL_TRIGGER_TYPE_IP        1
#define AC_CODE_TRIGGER_TYPE_DISABLED    0
#define AC_CODE_TRIGGER_TYPE_WARNING    1
#define AC_CODE_TRIGGER_TYPE_KICK        2
#define AC_TRIGGER_ANTIFLOOD_TIME        5
#define AC_MAX_CODES_ON_PAGE            15
#define AC_DIALOG_NEXT_PAGE_TEXT        ">>> Следующая страница"
#define AC_DIALOG_PREVIOUS_PAGE_TEXT    "<<< Предыдущая страница"
#define DIALOG_ANTICHEAT_SETTINGS 8824
#define DIALOG_ANTICHEAT_EDIT_CODE 8826
#define W "{FFFFFF}"
#define GOLD "{FFD700}"
#define GetName(%0)						PlayerInfo[%0][pName]
#define MAX_AFK_TIME 	(300)
native IsValidVehicle(vehicleid);
#define GUN_ROT 90.0, 0.0, 90.0
#define FIRE_GUN_ROT 90.0, 0.0, 5.0
#define MAX_ACTORSS 	(300)
#define MAX_DMATS 		(300)
#define MAX_DGUNS 		(300)
#define MAX_NARKO		(45)
#define MAX_BOMBS   	(20)
#define WIN_MULTIPLIER_GLOBAL 1.0
#define MIN_Bet 10
#define MAX_Bet 500
#define Bet_STEP 5
#define G_STATE_NOT_GAMBLING    0
#define G_STATE_READY           1
#define G_STATE_GAMBLING        2
#define G_STATE_DISPLAY         3
#define G_STATE_PLAY_AGAIN      4
#define DISPLAY_TIME 750
#define GAMBLE_TIMER 100
#define dRandom 9321
new demorgan[2], Text:no_park_TD[4], Text:noparkzone[3],parkzone,FarmCotton, aksiomaa[2], Float: TeleportFloat[3], TeleportInfoq[2], Teleport, VehID[MAX_PLAYERS], Train[4], Actor11[2],
Float:Pickups[1300][3], Text3D:info_house, Text:IntroLogo[4],
BuildGetMoney, TextReport[MAX_REPORTS][250], OtvetReport[MAX_REPORTS][430], TextReportAdmin[MAX_REPORTS][350], PlayerReport[MAX_REPORTS] = {-1,...},
ReportID[MAX_PLAYERS] = {-1,...}, ReportSlot[MAX_REPORTS] = {-1,...},
bool:OnPlayerLoading[MAX_PLAYERS], prost[2], Text:klick[9], Text:klickd[3],
TutState[MAX_PLAYERS], Text:reconmenu[32], healthpd[3], PlayerText:MenuSkin[MAX_PLAYERS],
UseDrugsTime[MAX_PLAYERS],
actor[MAX_ACTORSS],actors[1],portpick[5],MatsDel_CP = -1,Text:kbox[2],Text:HungerFon[2],
PlayerText:HungerProgres[MAX_PLAYERS],Float:CenaRaboti[MAX_PLAYERS],shot[MAX_PLAYERS],CanSend[MAX_PLAYERS],
BotStep[MAX_PLAYERS],CanUse[MAX_PLAYERS],oldGUN[MAX_PLAYERS],NeSdal[MAX_PLAYERS],dBiz[MAX_PLAYERS],pMusicOn[MAX_PLAYERS],
Estimate_admin[MAX_PLAYERS],bool:WeaponInfo[MAX_PLAYERS][47], AmmoInfo[MAX_PLAYERS][47], AmmoSlot[MAX_PLAYERS][13],
ZallFunction[3]=0, bool:ShowMap[MAX_PLAYERS], bool: NeedDell[MAX_PLAYERS], Text:Map[4], Text:PlayerDraw[MAX_PLAYERS], Text:StatsDraw[MAX_PLAYERS],
Mysor_obj[MAX_PLAYERS][4];
new static str_beg_info[] = " \n \n{FFFFFF}Вы начали попрошайничать деньги. Каждые 40 секунд вы будете получать по 10$.\
    \nА если вы будете под руководством мафии, то сможете получать до 15$ в 40 секунд!\
    \nДля того чтобы подключится к бизнесу мафии, достаточно найти одного их представителя\
    \n \n{e8793e}Попрошайничать вы можете даже в афк, это даст вам возможность заработать деньги,\
    \nпока вы занимаетесь делами в реальной жизни. Попрошайничать можно до 24 часов афк!\n ";
enum actor_info
{
Text3D:ActorsText,
	aTimer
}
new Colors_BIG[100] = { 0x000000,0xFFFFFF,0x20B2AA,0xDC143C,0x6495ED,0xf0e68c,0x778899,0xFF1493,0xF4A460,0xEE82EE,0xFFD720, 0x8b4513,0x4949A0,0x148b8b,0x14ff7f,0x556b2f,0x0FD9FA,0x10DC29,0x534081,0x0495CD,0xEF6CE8,0xBD34DA,
0x247C1B,0x0C8E5D,0x635B03,0xCB7ED3,0x65ADEB,0x5C1ACC,0xF2F853,0x11F891,0x7B39AA,0x53EB10,0x54137D, 0x275222,0xF09F5B,0x3D0A4F,0x22F767,0xD63034,0x9A6980,0xDFB935,0x3793FA,0x90239D,0xE9AB2F,0xAF2FF3,
0x057F94,0xB98519,0x388EEA,0x028151,0xA55043,0x0DE018,0x93AB1C,0x95BAF0,0x369976,0x18F71F,0x4B8987, 0x491B9E,0x829DC7,0xBCE635,0xCEA6DF,0x20D4AD,0x2D74FD,0x3C1C0D,0x12D6D4,0x48C000,0x2A51E2,0xE3AC12,
0xFC42A8,0x2FC827,0x1A30BF,0xB740C2,0x42ACF5,0x2FD9DE,0xFAFB71,0x05D1CD,0xC471BD,0x94436E,0xC1F7EC, 0xCE79EE,0xBD1EF2,0x93B7E4,0x3214AA,0x184D3B,0xAE4B99,0x7E49D7,0x4C436E,0xFA24CC,0xCE76BE,0xA04E0A,
0x9F945C,0xDCDE3D,0x10C9C5,0x70524D,0x0BE472,0x8A2CD7,0x6152C2,0xCF72A9,0xE59338,0xEEDC2D,0xD8C762, 0x3FE65C };

new Colors_LOW[][12] = { "000000","FFFFFF","20B2AA","DC143C","6495ED","f0e68c","778899","FF1493","F4A460","EE82EE","FFD720", "8b4513","4949A0","148b8b","14ff7f","556b2f","0FD9FA","10DC29","534081","0495CD","EF6CE8","BD34DA",
"247C1B","0C8E5D","635B03","CB7ED3","65ADEB","5C1ACC","F2F853","11F891","7B39AA","53EB10","54137D", "275222","F09F5B","3D0A4F","22F767","D63034","9A6980","DFB935","3793FA","90239D","E9AB2F","AF2FF3",
"057F94","B98519","388EEA","028151","A55043","0DE018","93AB1C","95BAF0","369976","18F71F","4B8987", "491B9E","829DC7","BCE635","CEA6DF","20D4AD","2D74FD","3C1C0D","12D6D4","48C000","2A51E2","E3AC12",
"FC42A8","2FC827","1A30BF","B740C2","42ACF5","2FD9DE","FAFB71","05D1CD","C471BD","94436E","C1F7EC", "CE79EE","BD1EF2","93B7E4","3214AA","184D3B","AE4B99","7E49D7","4C436E","FA24CC","CE76BE","A04E0A",
"9F945C","DCDE3D","10C9C5","70524D","0BE472","8A2CD7","6152C2","CF72A9","E59338","EEDC2D","D8C762","3FE65C" };
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
new PlayerText:Textdrawa, PlayerText:Textdrawb, PlayerText:Textdrawc,
	PlayerText:Textdrawd, PlayerText:Textdrawe, PlayerText:Textdrawf;//5
new AdminZone[4];
new door[14];
new litter[30];
new EventLeave;

new OBJECT_RAKE[MAX_PLAYERS];
const MAX_COTTON_OBJECT = 11;
//билборды
new PlayerText:Xiaomi[MAX_PLAYERS][58], PlayerText:XiaomiVK[MAX_PLAYERS][26];
#define MAX_BILLBORDS 50
//
//new carrega;

//-=-=-=-=-=-=-=-=-=-=-=-=[ПЕРЕМЕННЫЕ СОЗДАНЫЕ ДЛЯ ЗАМЕНЫ ПВАРОВ]-=-=-=-=-=-=-=-
new lavkacolor[MAX_PLAYERS];
new Text:welcomelogo[11];
new SelectMenu[MAX_PLAYERS];
new vremya[MAX_PLAYERS];
new palatki[41];
new timeaks[MAX_PLAYERS];
new buygunid[MAX_PLAYERS];
new deer[7];
new Text3D:deerlabel[7];
new Text3D:labeltext[MAX_PLAYERS];
new Text3D:pame_text[MAX_PLAYERS] = {Text3D:-1, ...};
new Text3D:Conteinertext[7];
new Text3D:WinForLotery;
new Text3D:PrizeCont[7];
new bool:donateopen[MAX_PLAYERS char];
new RouletteOpen;
new daunstime[MAX_PLAYERS];
new questman[MAX_PLAYERS];
new Text:selectmenu[28];
new PlayerText:shop_textdraw[MAX_PLAYERS][111];
new PlayerText:buy_magaz_icon[MAX_PLAYERS][9];
new PlayerText:KolvoShopItemSlot[MAX_PLAYERS][36];
new PlayerText:pokazmenu[MAX_PLAYERS][9];
new deercp[7];
new objBT[7] = 2;
new EnterDeer[MAX_PLAYERS];
new PlayerText:donatetd[MAX_PLAYERS][90];
new PlayerText:donatetexttd[MAX_PLAYERS][38];
new PickInventTrade[MAX_PLAYERS][72];
new PlayerText:pokaz[MAX_PLAYERS][13];
new selectdonate[MAX_PLAYERS];
new PlayerText:donate_player[MAX_PLAYERS][38];
new PlayerText:donate_player2[MAX_PLAYERS][38];
new donate_plus[MAX_PLAYERS];
new crselect[MAX_PLAYERS];
new crselect2[MAX_PLAYERS];
new donate_plus2[MAX_PLAYERS];
new donate_plus3[MAX_PLAYERS];
new PlayerText:donatetd2[MAX_PLAYERS][90];
new PlayerText:donatetd22[MAX_PLAYERS][90];
new timeskin[MAX_PLAYERS];
new PlayerText:debug2[MAX_PLAYERS][1];
new donttake[7];
new zakrito[MAX_PLAYERS];
#define COLOR_FAMILY        0xB9C1B8FF
new addboard[MAX_PLAYERS];
new VkCoinOpen[MAX_PLAYERS];
new skatetimer0[MAX_PLAYERS];
new dolbansyka[MAX_PLAYERS];
new Mashina[MAX_PLAYERS];
new skatetimer1[MAX_PLAYERS];
new bool:FPlayerText[MAX_PLAYERS];
new skatetimer2[MAX_PLAYERS];
new skatetimer3[MAX_PLAYERS];
new skatetimer4[MAX_PLAYERS];
new skatetimer5[MAX_PLAYERS];
new Vibor[MAX_PLAYERS];
new skateobject[MAX_PLAYERS];
new Board[MAX_PLAYERS];
new PlayerText:dolbik6[MAX_PLAYERS][52];
new ViborAks[MAX_PLAYERS];
new KillList[MAX_PLAYERS];
new Skate[MAX_PLAYERS];
new addskate[MAX_PLAYERS];
new PlayerText:XiaomiVvod[MAX_PLAYERS][33];
new AksVid[MAX_PLAYERS];
new cc_code[5];
new
	bool: captch_opened[MAX_PLAYERS],
	captch_code[MAX_PLAYERS][7],

	PlayerText: captch_PTD[MAX_PLAYERS][2],
	PlayerText: captch_code_PTD[MAX_PLAYERS][5][7];

#define dialog_test_captcha 5051
#define dialog_test_captcha2 5052
#define dialog_test_captcha3 5053
new MailCode[MAX_PLAYERS];
new MailCodeTrade[MAX_PLAYERS];
new AksVid2[MAX_PLAYERS];
new PlayerText:samsung[MAX_PLAYERS][72];
new PlayerText:samsungvvod[MAX_PLAYERS][35];
new OpenDaun[MAX_PLAYERS];
new bool:AcceptFam[MAX_PLAYERS char];
new Text3D:PlayerFamily[MAX_PLAYERS];
new Musorsa;
//new SetZam[MAX_PLAYERS];
new BuyKirka[MAX_PLAYERS];
new TradeItem[MAX_PLAYERS][10];
new TradeItemKolvo[MAX_PLAYERS][10];
new PlayerText:tradeitemtd[MAX_PLAYERS][20];
//new SetZam[MAX_PLAYERS];
new PlayerText:tradeitemkolvotd[MAX_PLAYERS][20];
new TimerShaxta[MAX_PLAYERS];
new timetrade[MAX_PLAYERS];
new PlayerText:trade[MAX_PLAYERS][38];
new ShkafOpen[MAX_PLAYERS];
new BagazhnikOpen[MAX_PLAYERS];
new TradeDoneID[MAX_PLAYERS];
new TradeMoney[MAX_PLAYERS];
new Float:TradeMoneyVK[MAX_PLAYERS];
new TelephoneOpen[MAX_PLAYERS];
new MoneyCasino[MAX_PLAYERS];
new piss[MAX_PLAYERS];
new TradeDone2[MAX_PLAYERS];
new PlayerText:GooglePixel[MAX_PLAYERS][57];
new PlayerText:GooglePixelVK[MAX_PLAYERS][3];
new PlayerText:GooglePixelVvod[MAX_PLAYERS][34];
new PlayerText:TrashSlot[MAX_PLAYERS][30];
new PlayerText:TrashSlotKol[MAX_PLAYERS][30];
new PickInventTrash[MAX_PLAYERS];
new PlayerText:ShkafSlot[MAX_PLAYERS][30];
new PlayerText:ShkafSlotKol[MAX_PLAYERS][30];
new PlayerText:Shkaf[MAX_PLAYERS][27];
new PlayerText:BagazhnikSlot[MAX_PLAYERS][30];
new PlayerText:BagazhnikSlotKol[MAX_PLAYERS][30];
new PlayerText:Bagazhnik[MAX_PLAYERS][27];
new PickInventShkaf[MAX_PLAYERS];
new PickInventBagazhnik[MAX_PLAYERS];
new Float: buytime[MAX_PLAYERS];
new buytime2[MAX_PLAYERS];
new musorka[MAX_PLAYERS];
new AksSlot[MAX_PLAYERS][8];
new BoxBum[BumBooxx];
new Float: GHealth[MAX_PLAYERS];
new TimetoReturn[MAX_PLAYERS];
new Vnedren[MAX_PLAYERS];
new setcheck[MAX_PLAYERS];
new Getemer[MAX_PLAYERS];
new Ingatre[MAX_PLAYERS];
new skinmenu[MAX_PLAYERS];
new kasmenu[MAX_PLAYERS];
new mehan[MAX_PLAYERS];
new dilo[MAX_PLAYERS];
new TimeBus[MAX_PLAYERS];
new deal[MAX_PLAYERS];
new gpss[MAX_PLAYERS];
new lomanim[MAX_PLAYERS];
new medlomka[MAX_PLAYERS];
new startlomka[MAX_PLAYERS];
new cuffer[MAX_PLAYERS];
new EngineStalled[MAX_PLAYERS];
new rabden[MAX_PLAYERS];
new notneedm[MAX_PLAYERS];
new animan[MAX_PLAYERS];
new caoffer[MAX_PLAYERS];
new cartrade[MAX_PLAYERS];
new spaned[MAX_PLAYERS];
new cardop[MAX_PLAYERS];
new ferman[MAX_PLAYERS];
new FirstFire[MAX_PLAYERS];
new SecondFire[MAX_PLAYERS];
new selfrac[MAX_PLAYERS];
new asker[MAX_PLAYERS];
new gskin[MAX_PLAYERS];
new ViborSERIU[MAX_PLAYERS];
new BusTime[MAX_PLAYERS];
new BusMoney[MAX_PLAYERS];
new mycasino[MAX_PLAYERS];
new jlock[MAX_PLAYERS];
new InJobs[MAX_PLAYERS];
new kostiKos[MAX_PLAYERS];
new engines[MAX_PLAYERS];
new Predlog[MAX_PLAYERS];
new avir[MAX_PLAYERS];
new aint[MAX_PLAYERS];
new onkey[MAX_PLAYERS];
new ReconMenus[MAX_PLAYERS];
new PutInfo[MAX_PLAYERS];
new Lastspec[MAX_PLAYERS];
new Healttime[MAX_PLAYERS];
new Float:InvPosTime[MAX_PLAYERS];
new JobHack[MAX_PLAYERS];
new TimeMessage[MAX_PLAYERS];
new sellcarto[MAX_PLAYERS];
new idaofcar[MAX_PLAYERS];
new nedded[MAX_PLAYERS];
new PlayerAFK[MAX_PLAYERS];
new PlayerAFKTime[MAX_PLAYERS][2];
new Keychange[MAX_PLAYERS];
new bumboxx[MAX_PLAYERS];
new Text3D:bumboxtext[MAX_PLAYERS];
new Float:BumBoxPos[MAX_PLAYERS][3];
new psleep[MAX_PLAYERS];
new psleeping[MAX_PLAYERS] = 0;
new RadioID[MAX_PLAYERS];
new Check1[MAX_PLAYERS];
enum ParkShtraf
{
    Float:shtraf_X,
	Float:shtraf_Y,
	Float:shtraf_Z,
	Float:shtraf_A
}
new ShtrafPark[391][ParkShtraf] =
{
	{-1871.6202, -753.9549, 31.6340, 89.0427},
	{-1871.9474, -757.0220, 31.6343, 89.2582},
	{-1871.6311, -760.0211, 31.6340, 89.8982},
	{-1872.1663, -762.9946, 31.6344, 90.0468},
	{-1872.1367, -765.9468, 31.6341, 89.4313},
	{-1872.0852, -768.9422, 31.6339, 90.4691},
	{-1871.3602, -772.0715, 31.6339, 90.6048},
	{-1871.9237, -775.0435, 31.6340, 90.2190},
	{-1872.0220, -777.9892, 31.6343, 89.2233},
	{-1872.0299, -780.9689, 31.6346, 89.5120},
	{-1871.9841, -783.9876, 31.6344, 90.7812},
	{-1871.8494, -787.0410, 31.6343, 90.4071},
	{-1871.5658, -790.0233, 31.6340, 89.6425},
	{-1871.7587, -793.0941, 31.6344, 89.7132},
	{-1871.8359, -796.0454, 31.6340, 90.2430},
	{-1872.0118, -798.9916, 31.6342, 91.0487},  
	{-1872.0118, -801.9916, 31.6342, 91.0487},
	{-1872.0118, -804.9916, 31.6342, 91.0487},
	{-1872.0118, -807.9916, 31.6342, 91.0487},
	{-1872.0118, -810.9916, 31.6342, 91.0487},
	{-1872.0118, -813.9916, 31.6342, 91.0487},
	{-1872.0118, -816.9916, 31.6342, 91.0487},
	{-1872.0118, -819.9916, 31.6342, 91.0487},
	{-1872.0118, -822.9916, 31.6342, 91.0487},
	{-1872.0118, -825.9916, 31.6342, 91.0487},
	{-1872.0118, -828.9916, 31.6342, 91.0487},
	{-1872.0118, -831.9916, 31.6342, 91.0487},
	{-1872.0118, -834.9916, 31.6342, 91.0487},
	{-1872.0118, -837.9916, 31.6342, 91.0487},
	{-1872.0118, -840.9916, 31.6342, 91.0487},
	{-1872.0118, -843.9916, 31.6342, 91.0487},
	{-1872.0118, -846.9916, 31.6342, 91.0487},
	{-1872.0118, -849.9916, 31.6342, 91.0487},
	{-1872.0118, -852.9916, 31.6342, 91.0487},
	{-1872.0118, -855.9916, 31.6342, 91.0487},
	{-1872.0118, -858.9916, 31.6342, 91.0487},
	{-1872.0118, -861.9916, 31.6342, 91.0487},
	{-1872.0118, -864.9916, 31.6342, 91.0487},
	{-1872.0118, -866.9916, 31.6342, 91.0487},
	{-1872.0118, -869.9916, 31.6342, 91.0487},
	{-1872.0118, -872.9916, 31.6342, 91.0487},
	{-1872.0118, -875.9916, 31.6342, 91.0487},
	{-1872.0118, -878.9916, 31.6342, 91.0487},
	{-1872.0118, -881.9916, 31.6342, 91.0487},
	{-1872.0118, -884.9916, 31.6342, 91.0487},
	{-1872.0118, -887.9916, 31.6342, 91.0487},
	{-1872.0118, -890.9916, 31.6342, 91.0487},
	{-1872.0118, -893.9916, 31.6342, 91.0487},
	{-1872.0118, -896.9916, 31.6342, 91.0487},
	{-1872.0118, -899.9916, 31.6342, 91.0487},
	{-1872.0118, -902.9916, 31.6342, 91.0487},
	{-1872.0118, -905.9916, 31.6342, 91.0487},
	{-1872.0118, -908.9916, 31.6342, 91.0487},
	{-1872.0118, -911.9916, 31.6342, 91.0487},
	{-1872.0118, -914.9916, 31.6342, 91.0487},
	{-1872.0118, -917.9916, 31.6342, 91.0487},
	{-1872.0118, -920.9916, 31.6342, 91.0487},
	{-1872.0118, -923.9916, 31.6342, 91.0487},
	{-1872.0118, -926.9916, 31.6342, 91.0487},
	{-1872.0118, -929.9916, 31.6342, 91.0487},
	{-1872.0118, -932.9916, 31.6342, 91.0487},
	{-1872.0118, -935.9916, 31.6342, 91.0487},
	{-1872.0118, -938.9916, 31.6342, 91.0487},
	{-1872.0118, -941.9916, 31.6342, 91.0487},
	{-1872.0118, -944.9916, 31.6342, 91.0487},
	{-1872.0118, -947.9916, 31.6342, 91.0487},
	{-1872.0118, -950.9916, 31.6342, 91.0487},
	{-1872.0118, -953.9916, 31.6342, 91.0487},
	{-1872.0118, -956.9916, 31.6342, 91.0487},
	{-1872.0118, -959.9916, 31.6342, 91.0487},
	{-1872.0845, -963.5865, 31.6340, 90.0455},  
	{-1886.9064, -963.7236, 31.6344, 269.2615},
	{-1887.1301, -960.5974, 31.6343, 268.6360},
	{-1887.3192, -957.5673, 31.6344, 270.0260},
	{-1887.3192, -954.5673, 31.6344, 270.0260},
	{-1887.3192, -951.5673, 31.6344, 270.0260},
	{-1887.3192, -948.5673, 31.6344, 270.0260},
	{-1887.3192, -945.5673, 31.6344, 270.0260},
	{-1887.3192, -942.5673, 31.6344, 270.0260},
	{-1887.3192, -939.5673, 31.6344, 270.0260},
	{-1887.3192, -936.5673, 31.6344, 270.0260},
	{-1887.3192, -933.5673, 31.6344, 270.0260},
	{-1887.3192, -930.5673, 31.6344, 270.0260},
	{-1887.3192, -927.5673, 31.6344, 270.0260},
	{-1887.3192, -924.5673, 31.6344, 270.0260},
	{-1887.3192, -921.5673, 31.6344, 270.0260},
	{-1887.3192, -918.5673, 31.6344, 270.0260},
	{-1887.8038, -915.7139, 31.6343, 268.7760},  
	{-1887.6500, -903.4103, 31.6343, 268.8207},
	{-1887.2260, -900.1493, 31.6341, 268.8922},
	{-1887.5204, -896.9490, 31.6343, 270.0451},
	{-1887.5204, -893.9490, 31.6343, 270.0451},
	{-1887.5204, -890.9490, 31.6343, 270.0451},
	{-1887.5204, -887.9490, 31.6343, 270.0451},
	{-1887.5204, -884.9490, 31.6343, 270.0451},
	{-1887.5204, -881.9490, 31.6343, 270.0451},
	{-1887.5204, -878.9490, 31.6343, 270.0451},
	{-1887.5204, -875.9490, 31.6343, 270.0451},
	{-1887.5204, -872.9490, 31.6343, 270.0451},
	{-1887.5204, -869.9490, 31.6343, 270.0451},
	{-1886.9302, -864.5999, 31.6343, 268.7473},  
	{-1886.9866, -853.1797, 31.6344, 269.6419},
	{-1886.9866, -850.1797, 31.6344, 269.6419},
	{-1886.9866, -847.1797, 31.6344, 269.6419},
	{-1886.9866, -844.1797, 31.6344, 269.6419},
	{-1886.9866, -841.1797, 31.6344, 269.6419},
	{-1886.9866, -838.1797, 31.6344, 269.6419},
	{-1886.9866, -835.1797, 31.6344, 269.6419},
	{-1886.9866, -832.1797, 31.6344, 269.6419},
	{-1886.9866, -829.1797, 31.6344, 269.6419},
	{-1886.9866, -824.1797, 31.6344, 269.6419},
	{-1886.9866, -821.1797, 31.6344, 269.6419},
	{-1886.9866, -818.1797, 31.6344, 269.6419},
	{-1886.8785, -814.3453, 31.6343, 269.7630},  
	{-1887.3572, -802.0540, 31.6343, 269.0090},
	{-1887.3572, -799.0540, 31.6343, 269.0090},
	{-1887.3572, -796.0540, 31.6343, 269.0090},
	{-1887.3572, -793.0540, 31.6343, 269.0090},
	{-1887.3572, -790.0540, 31.6343, 269.0090},
	{-1887.3572, -787.0540, 31.6343, 269.0090},
	{-1887.3572, -784.0540, 31.6343, 269.0090},
	{-1887.3572, -781.0540, 31.6343, 269.0090},
	{-1887.3572, -778.0540, 31.6343, 269.0090},
	{-1887.3572, -775.0540, 31.6343, 269.0090},
	{-1887.3572, -772.0540, 31.6343, 269.0090},
	{-1887.3572, -769.0540, 31.6343, 269.0090},
	{-1887.3572, -766.0540, 31.6343, 269.0090},
	{-1887.3572, -763.0540, 31.6343, 269.0090},
	{-1887.3572, -760.0540, 31.6343, 269.0090},
	{-1887.3572, -757.0540, 31.6343, 269.0090},
	{-1887.0830, -753.9937, 31.6342, 269.2267},  
	{-1897.4717, -754.0249, 31.6344, 90.0577},
	{-1897.4717, -757.0249, 31.6344, 90.0577},
	{-1897.4717, -760.0249, 31.6344, 90.0577},
	{-1897.4717, -763.0249, 31.6344, 90.0577},
	{-1897.4717, -766.0249, 31.6344, 90.0577},
	{-1897.4717, -769.0249, 31.6344, 90.0577},
	{-1897.4717, -772.0249, 31.6344, 90.0577},
	{-1897.4717, -775.0249, 31.6344, 90.0577},
	{-1897.4717, -778.0249, 31.6344, 90.0577},
	{-1897.4717, -781.0249, 31.6344, 90.0577},
	{-1897.4717, -784.0249, 31.6344, 90.0577},
	{-1897.4717, -787.0249, 31.6344, 90.0577},
	{-1897.4717, -790.0249, 31.6344, 90.0577},
	{-1897.4717, -793.0249, 31.6344, 90.0577},
	{-1897.4717, -796.0249, 31.6344, 90.0577},
	{-1897.4717, -799.0249, 31.6344, 90.0577},
	{-1897.6514, -801.9987, 31.6344, 88.8193},  
	{-1897.5822, -814.1745, 31.6340, 89.2212},
	{-1897.5822, -817.1745, 31.6340, 89.2212},
	{-1897.5822, -820.1745, 31.6340, 89.2212},
	{-1897.5822, -823.1745, 31.6340, 89.2212},
	{-1897.5822, -826.1745, 31.6340, 89.2212},
	{-1897.5822, -829.1745, 31.6340, 89.2212},
	{-1897.5822, -832.1745, 31.6340, 89.2212},
	{-1897.5822, -835.1745, 31.6340, 89.2212},
	{-1897.5822, -838.1745, 31.6340, 89.2212},
	{-1897.5822, -841.1745, 31.6340, 89.2212},
	{-1897.5822, -844.1745, 31.6340, 89.2212},
	{-1897.5822, -847.1745, 31.6340, 89.2212},
	{-1897.5822, -850.1745, 31.6340, 89.2212},
	{-1897.4645, -853.0779, 31.6342, 90.3830},  
	{-1897.6432, -864.5861, 31.6342, 91.4497},
	{-1897.6432, -867.5861, 31.6342, 91.4497},
	{-1897.6432, -870.5861, 31.6342, 91.4497},
	{-1897.6432, -873.5861, 31.6342, 91.4497},
	{-1897.6432, -876.5861, 31.6342, 91.4497},
	{-1897.6432, -879.5861, 31.6342, 91.4497},
	{-1897.6432, -882.5861, 31.6342, 91.4497},
	{-1897.6432, -885.5861, 31.6342, 91.4497},
	{-1897.6432, -888.5861, 31.6342, 91.4497},
	{-1897.6432, -891.5861, 31.6342, 91.4497},
	{-1897.6432, -894.5861, 31.6342, 91.4497},
	{-1897.6432, -897.5861, 31.6342, 91.4497},
	{-1897.6432, -900.5861, 31.6342, 91.4497},
	{-1897.3824, -903.4614, 31.6340, 88.1722},  
	{-1897.6892, -915.7218, 31.6340, 88.9445},
	{-1897.6892, -918.7218, 31.6340, 88.9445},
	{-1897.6892, -921.7218, 31.6340, 88.9445},
	{-1897.6892, -924.7218, 31.6340, 88.9445},
	{-1897.6892, -927.7218, 31.6340, 88.9445},
	{-1897.6892, -930.7218, 31.6340, 88.9445},
	{-1897.6892, -933.7218, 31.6340, 88.9445},
	{-1897.6892, -936.7218, 31.6340, 88.9445},
	{-1897.6892, -939.7218, 31.6340, 88.9445},
	{-1897.6892, -942.7218, 31.6340, 88.9445},
	{-1897.6892, -945.7218, 31.6340, 88.9445},
	{-1897.6892, -948.7218, 31.6340, 88.9445},
	{-1897.6892, -951.7218, 31.6340, 88.9445},
	{-1897.6892, -955.7218, 31.6340, 88.9445},
	{-1897.6892, -958.7218, 31.6340, 88.9445},
	{-1897.6892, -961.7218, 31.6340, 88.9445},
	{-1897.8511, -963.6726, 31.6343, 90.3608},
	{1558.4680, -1012.4069, 23.5168, 181.9901},
	{1562.8892, -1012.2247, 23.5166, 180.4049},
	{1567.3582, -1011.8825, 23.5202, 180.6724},
	{1571.9059, -1012.0411, 23.5166, 181.7434},
	{1576.3126, -1012.1378, 23.5165, 182.2266},
	{1581.4943, -1011.8914, 23.5173, 186.3029},
	{1585.8787, -1010.7643, 23.5168, 185.6483},
	{1590.4026, -1010.5210, 23.5170, 186.4816},
	{1594.7281, -1010.0948, 23.5165, 185.9081},
	{1599.2446, -1009.2011, 23.5168, 185.9490},
	{1604.3210, -1008.8847, 23.5166, 176.8446},
	{1608.9269, -1009.1859, 23.5170, 177.5059},
	{1613.2728, -1009.0444, 23.5168, 180.2016},
	{1617.7999, -1009.8328, 23.5110, 179.8297},
	{1623.3464, -1010.7888, 23.5088, 162.1745},
	{1627.7533, -1011.9344, 23.5087, 162.5268},
	{1632.2615, -1013.2950, 23.5092, 163.1210},
	{1636.3907, -1014.4413, 23.5091, 162.5507},
	{1640.6299, -1016.0787, 23.5087, 161.4913},
	{1645.2540, -1017.0021, 23.5094, 160.7001},
	{1651.7897, -1017.7875, 23.5094, 189.9938},
	{1656.1506, -1016.8237, 23.5093, 189.7430},
	{1660.5764, -1016.3417, 23.5087, 191.1470},
	{1664.8175, -1015.1065, 23.5092, 191.0829},
	{1674.4000, -1013.1021, 23.5095, 200.0218},
	{1678.6801, -1011.6260, 23.5091, 198.4138},
	{1682.7860, -1009.9215, 23.5089, 199.0804},
	{1686.8544, -1008.4095, 23.5165, 197.5920},
	{1691.2926, -1007.2444, 23.5165, 198.6693},
	{1695.7494, -1006.4331, 23.5165, 197.4052},
	{1703.7869, -1005.0826, 23.5190, 170.5832},
	{1708.1157, -1005.7994, 23.5231, 171.3285},
	{1712.6115, -1006.1609, 23.5250, 171.8795},
	{1717.0189, -1006.8057, 23.5246, 171.4042},
	{1721.6476, -1007.1997, 23.5240, 171.4922},
	{1726.6277, -1007.6859, 23.5379, 166.5302},
	{1730.7971, -1008.8813, 23.5512, 166.4220},
	{1735.3641, -1009.9448, 23.5666, 168.3793},
	{1739.9144, -1011.0194, 23.5717, 166.8184},
	{1744.2775, -1012.2689, 23.5715, 167.7883},
	{1748.7714, -1012.7493, 23.5717, 166.9149},
	{1752.8365, -1014.3951, 23.5716, 168.8181},
	{1757.3102, -1015.0510, 23.5718, 166.1820},
	{1761.7666, -1015.7945, 23.5715, 170.3444},
	{1767.5665, -1017.9461, 23.5716, 152.3228},
	{1771.6459, -1020.1177, 23.5717, 152.0864},
	{1775.6600, -1022.0659, 23.5719, 153.4988},
	{1779.8026, -1023.7059, 23.5714, 154.3663},
	{1783.8260, -1025.7316, 23.5716, 150.3163},
	{1793.5167, -1061.1029, 23.5752, 0.4574},
	{1788.9436, -1060.8019, 23.5719, 358.9199},
	{1784.2389, -1060.8807, 23.5721, 0.0023},
	{1780.1812, -1061.0358, 23.5713, 359.0605},
	{1775.3362, -1061.3716, 23.5717, 358.6985},
	{1771.1055, -1060.9952, 23.5720, 358.8543},
	{1766.4647, -1060.8171, 23.5718, 359.4640},
	{1762.0133, -1061.7875, 23.5713, 359.0246},
	{1761.9238, -1070.1180, 23.5712, 180.2054},
	{1766.4242, -1070.4081, 23.5714, 177.5186},
	{1771.1721, -1069.9393, 23.5714, 177.4281},
	{1775.4537, -1070.2118, 23.5712, 178.2182},
	{1779.8951, -1069.5941, 23.5713, 179.3939},
	{1784.2726, -1070.0413, 23.5712, 180.4913},
	{1788.9608, -1070.4805, 23.5717, 179.1534},
	{1793.3495, -1070.2399, 23.5716, 182.3082},
	{1803.2043, -1085.2394, 23.5720, 358.0617},
	{1798.8994, -1084.6654, 23.5719, 358.1654},
	{1794.1704, -1084.9940, 23.5796, 357.9424},
	{1789.6384, -1085.1123, 23.5794, 359.0909},
	{1785.3490, -1085.1626, 23.5795, 0.4020},
	{1780.5991, -1085.2754, 23.5718, 359.5494},
	{1776.1948, -1084.8647, 23.5715, 0.5800},
	{1771.6897, -1084.2368, 23.5717, 0.3023},
	{1767.1836, -1085.7990, 23.5712, 0.2183},
	{1762.5854, -1084.4930, 23.5717, 358.7430},
	{1758.0923, -1085.2037, 23.5719, 1.2575},
	{1753.6434, -1085.0924, 23.5715, 0.1049},
	{1748.9657, -1084.8939, 23.5719, 0.6234},
	{1744.6156, -1085.3342, 23.5713, 0.7709},
	{1739.9070, -1085.4197, 23.5711, 0.3403},
	{1735.3269, -1085.3162, 23.5711, 1.2077},
	{1731.2482, -1085.5979, 23.5559, 359.6583},
	{1726.2017, -1084.9943, 23.5337, 359.2104},
	{1743.9335, -1037.4263, 23.5716, 0.1580},
	{1748.3455, -1036.7844, 23.5714, 359.5643},
	{1752.8572, -1036.9032, 23.5720, 359.0736},
	{1757.5089, -1037.1031, 23.5718, 0.4561},
	{1761.9230, -1037.3584, 23.5714, 356.7782},
	{1761.8252, -1046.3853, 23.5715, 177.8386},
	{1757.4915, -1046.1006, 23.5713, 179.1035},
	{1753.0697, -1046.1973, 23.5719, 179.6179},
	{1748.4551, -1046.7034, 23.5718, 180.0661},
	{1743.9131, -1046.4293, 23.5715, 179.7599},
	{1722.7699, -1060.6680, 23.5338, 358.9793},
	{1718.2196, -1060.0126, 23.5207, 358.6655},
	{1713.7673, -1060.7281, 23.5167, 359.4945},
	{1709.4412, -1060.6038, 23.5165, 359.4044},
	{1704.7166, -1059.9884, 23.5172, 358.1128},
	{1700.3153, -1060.7413, 23.5166, 358.7368},
	{1695.8868, -1060.2627, 23.5227, 358.8898},
	{1691.2753, -1060.5869, 23.5243, 357.4435},
	{1691.1912, -1069.8153, 23.5171, 180.6926},
	{1695.8701, -1069.3495, 23.5168, 178.6040},
	{1700.2670, -1069.3667, 23.5168, 179.0710},
	{1704.7157, -1069.7094, 23.5171, 178.8946},
	{1709.2683, -1069.4926, 23.5169, 178.0049},
	{1713.7153, -1069.4919, 23.5165, 179.2534},
	{1718.3026, -1068.9731, 23.5173, 180.8427},
	{1722.6871, -1069.1141, 23.5334, 179.7421},
	{1722.6025, -1060.4854, 23.5336, 359.4358},
	{1718.2721, -1060.4814, 23.5207, 0.6014},
	{1713.9677, -1060.7882, 23.5168, 0.1287},
	{1709.3805, -1060.5582, 23.5169, 359.0342},
	{1704.7964, -1060.1798, 23.5168, 357.7699},
	{1700.3353, -1059.8936, 23.5172, 357.8647},
	{1695.7241, -1060.3492, 23.5232, 359.5998},
	{1691.3960, -1060.7487, 23.5248, 359.2441},
	{1705.9163, -1085.5106, 23.5169, 358.3792},
	{1701.4266, -1085.1654, 23.5171, 357.9610},
	{1697.0255, -1084.9978, 23.5165, 359.8781},
	{1692.5027, -1085.4437, 23.5169, 359.4893},
	{1688.2380, -1085.4274, 23.5165, 357.8648},
	{1675.8231, -1097.8225, 23.5168, 88.0123},
	{1675.8021, -1102.3594, 23.5165, 89.7332},
	{1675.9368, -1106.9783, 23.5166, 87.8055},
	{1675.7943, -1111.4727, 23.5172, 89.7565},
	{1675.7751, -1115.9670, 23.5172, 90.4918},
	{1675.8225, -1120.3788, 23.5172, 88.7881},
	{1675.5469, -1124.8788, 23.5171, 89.2826},
	{1675.5693, -1129.3719, 23.5171, 88.5380},
	{1666.4688, -1135.2738, 23.5171, 0.1341},
	{1661.7244, -1136.0667, 23.5172, 358.6440},
	{1657.2987, -1135.6372, 23.5172, 359.8706},
	{1652.9393, -1135.6422, 23.5165, 358.0985},
	{1648.4742, -1135.5204, 23.5172, 1.2977},
	{1617.0967, -1137.1364, 23.5172, 272.5109},
	{1617.1405, -1132.5933, 23.5171, 266.8187},
	{1616.2843, -1128.2009, 23.5166, 267.9693},
	{1616.8486, -1123.8628, 23.5170, 269.7912},
	{1617.0011, -1119.1412, 23.5172, 267.3853},
	{1592.1229, -1057.8048, 23.5165, 308.7149},
	{1589.3940, -1054.6306, 23.5172, 308.6678},
	{1586.8616, -1050.7434, 23.5173, 305.9297},
	{1584.3718, -1047.3011, 23.5167, 309.4448},
	{1581.6361, -1043.6340, 23.5166, 309.3819},
	{1577.7589, -1039.2748, 23.5174, 321.4056},
	{1573.6016, -1037.0328, 23.5209, 320.5859},
	{1570.1982, -1034.2122, 23.5249, 320.7296},
	{1563.9054, -1030.9979, 23.5186, 342.1199},
	{1559.7295, -1029.5508, 23.5165, 343.3477},
	{1555.3745, -1028.2522, 23.5167, 341.3905},
	{1551.0745, -1026.7731, 23.5170, 342.4940},
	{1546.8508, -1025.5540, 23.5171, 342.1929},
	{1542.6683, -1024.1702, 23.5171, 340.9424},
	{1658.9448, -1037.8763, 23.5088, 359.8871},
	{1654.3845, -1037.5585, 23.5094, 358.4614},
	{1649.9601, -1037.5441, 23.5093, 358.1330},
	{1645.3553, -1037.4141, 23.5094, 359.9295},
	{1640.7861, -1037.6759, 23.5091, 359.4187},
	{1636.3569, -1037.7754, 23.5088, 359.5124},
	{1631.8942, -1037.8721, 23.5089, 0.0841},
	{1627.3131, -1037.5183, 23.5093, 358.6852},
	{1627.1763, -1046.4005, 23.5087, 180.3113},
	{1631.8175, -1046.4231, 23.5091, 178.3477},
	{1636.1625, -1046.2880, 23.5094, 178.9926},
	{1640.7754, -1046.6510, 23.5090, 179.1166},
	{1645.2764, -1046.8058, 23.5094, 177.1074},
	{1649.7460, -1046.4567, 23.5090, 178.3391},
	{1654.4225, -1046.3765, 23.5090, 178.9497},
	{1658.6324, -1046.3380, 23.5086, 178.2492},
	{1658.0083, -1080.0065, 23.5127, 268.5453},
	{1657.9198, -1084.5458, 23.5164, 269.3615},
	{1658.3243, -1089.0385, 23.5166, 269.3302},
	{1658.2106, -1093.5894, 23.5170, 270.4691},
	{1658.3051, -1097.9753, 23.5171, 269.3956},
	{1658.3674, -1102.7065, 23.5172, 269.9523},
	{1657.9114, -1107.1176, 23.5166, 269.9855},
	{1658.4811, -1111.5708, 23.5169, 269.8734},
	{1648.9885, -1111.4705, 23.5248, 89.5551},
	{1648.9166, -1107.0082, 23.5172, 89.4219},
	{1649.6259, -1102.5834, 23.5165, 90.5175},
	{1649.1847, -1098.0969, 23.5168, 90.6903},
	{1649.4255, -1093.6208, 23.5168, 90.3299},
	{1649.0256, -1089.0177, 23.5172, 88.5190},
	{1649.7467, -1084.6544, 23.5167, 90.4367},
	{1649.0420, -1080.0314, 23.5134, 90.7553},
	{1629.5481, -1107.4907, 23.5172, 268.6024},
	{1629.8374, -1103.0299, 23.5166, 267.2411},
	{1629.7446, -1098.4086, 23.5165, 268.7328},
	{1629.4772, -1093.9991, 23.5204, 268.5530},
	{1630.1189, -1089.5664, 23.5168, 268.1686},
	{1629.4015, -1085.0798, 23.5167, 268.1021},
	{1621.1122, -1084.9014, 23.5165, 89.2882},
	{1621.1877, -1089.5990, 23.5172, 88.3801},
	{1620.8409, -1094.0743, 23.5206, 90.3619},
	{1621.1720, -1098.5520, 23.5171, 89.8521},
	{1620.6381, -1103.0771, 23.5171, 89.8721},
	{1621.2124, -1107.3531, 23.5169, 90.2835}  
};

new IDOFMusic=-1;
enum smusicinfo
{
	mNowTime,
	mTime,
	mAdress[244]
}
new MusicInfo[26][smusicinfo]=
{
	{0,204,"http://music.Yankee.su/Heavy%20Young%20Heathens%20%96%20Lucifer%20Main.mp3"},//
	{0,229,"http://music.Yankee.su/The%20Black%20Keys%20%96%20Howlin'%20For%20You.mp3"},//
	{0,142,"http://music.Yankee.su/Green%20Day%20%96%20Baby%20Eyes.mp3"},//
	{0,242,"http://music.Yankee.su/Awolnation%20%96%20Not%20Your%20Fault.mp3"},//
	{0,292,"http://music.Yankee.su/AWOLNATION%20%96%20Some%20Kind%20of%20Joke%20(OST%20%c6%e5%eb%e5%e7%ed%fb%e9%20%f7%e5%eb%ee%e2%e5%ea%203).mp3"},
	{0,200,"http://music.Yankee.su/Arctic%20Monkeys%20%96%20R%20U%20Mine-.mp3"},//6
	{0,274,"http://music.Yankee.su/AWOLNATION%20%96%20I%20Am.mp3"},
	{0,216,"http://music.Yankee.su/AWOLNATION%20%96%20All%20I%20Need.mp3"},
	{0,266,"http://music.Yankee.su/AWOLNATION%20(original)%20%96%20Sail.mp3"},
	{0,208,"http://music.Yankee.su/Kansas%20%96%20Carry%20On%20My%20Wayward%20Son%20(OST%20Supernatural).mp3"},
	{0,294,"http://music.Yankee.su/4%20Non%20Blondes%20%96%20What's%20Up%20(Whats%20Going%20On).mp3"},
	{0,239,"http://music.Yankee.su/3%20Doors%20Down%20%96%20Kryptonite%20(Superman)%20(%20by%20http---vk.com-2x2_is_4%20).mp3"},
	{0,239,"http://music.Yankee.su/ACDC%20%96%20Hightway%20To%20Hell.mp3"},
	{0,232,"http://music.Yankee.su/Green%20Day%20%96%20Holiday.mp3"},
	{0,274,"http://music.Yankee.su/Green%20Day%20%96%20East%20Jesus%20Nowhere.mp3"},
	{0,174,"http://music.Yankee.su/Green%20Day%20%96%20American%20idiots.mp3"},
	{0,547,"http://music.Yankee.su/Green%20Day%20%96%20Jesus%20of%20Suburbia.mp3"},
	{0,258,"http://music.Yankee.su/Imagine%20Dragons%20%96%20Dream.mp3"},
	{0,230,"http://music.Yankee.su/Imagine%20Dragons%20%96%20I'm%20So%20Sorry.mp3"},
	{0,229,"http://music.Yankee.su/Kari%20Kimmel%20%96%20Black%20(OST%20The%20Walking%20Dead%20Season%203%20Trailer).mp3"},
	{0,269,"http://music.Yankee.su/Red%20Hot%20Chili%20Peppers%20%96%20Can't%20Stop.mp3"},
	{0,178,"http://music.Yankee.su/Awolnation%20%96%20Kill%20Your%20Heroes.mp3"},
	{0,248,"http://music.Yankee.su/Awolnation%20%96%20Jump%20On%20My%20Shoulders.mp3"},
	{0,182,"http://music.Yankee.su/Awolnation%20%96%20Wake%20Up.mp3"},
	{0,188,"http://music.Yankee.su/Yankee%20RP%20%96%20track%20%232.mp3"},
	{0,236,"http://music.Yankee.su/Roxette%20%96%20The%20Look.mp3"}
};
#define LOGO1       "A"
#define LOGO2       "rizona"
#define LOGO3       "Ser"
#define NAMECONNECT "Arizona RolePlay!"
#define NAMELOGIN   "Arizona Role Play"
#define NAME        "Arizona RP"
#define NAMEICRP    "Arizona"
#define FORUMSERV   "vk.com/arzser"
#define SITE        "vk.com/arzser"
#define DONATESITE  "vk.com/arzser"
#define GROUPVK     "vk.com/arzser"
#define FREEZE_TIME		 (30)
new FullDostup1[MAX_PLAYER_NAME];
new FullDostup2[MAX_PLAYER_NAME];
new FullDostup3[MAX_PLAYER_NAME];
new FullDostup4[MAX_PLAYER_NAME];
new FullDostup5[MAX_PLAYER_NAME];
new FullDostup6[MAX_PLAYER_NAME];
new FullDostup7[MAX_PLAYER_NAME];
new FullDostup8[MAX_PLAYER_NAME];
new FullDostup9[MAX_PLAYER_NAME];
new FullDostup10[MAX_PLAYER_NAME];
new FullDostup11[MAX_PLAYER_NAME];
new FullDostup12[MAX_PLAYER_NAME];

//static const
//	FamColor[][] = { "FFFFFF", "76AEB7", "8B4ED0", "DC60A6", "D4B663", "81CD42", "58BB9D", "31D3CD", "636363", "444444", "00f424", "f40000", "fffa00", "e100ff"},
//	FamColors[] = { 0xFFFFFFFF, 0x76AEB7FF, 0x8B4ED0FF, 0xDC60A6FF, 0xD4B663FF, 0x81CD42FF, 0x58BB9DFF, 0x31D3CDFF, 0x636363FF, 0x444444FF, 0x00f424FF, 0xf40000FF, 0xfffa00FF, 0xe100ffFF},
static const FamTypes[][] = { "", "Family", "Crew", "Squad", "Corporation", "Dynasty", "Empire", "Brotherhood" } ;

enum langinfo
{
	rus[500],
	eng[500]
}
new Language[55][langinfo]=
{
	{"{FFFFFF}Добро пожаловать на {eba225}Arizona Role Play{FF0000}\n\n","{FFFFFF}Welcome to {EBA225}Arizona Role Play{FF0000}\n\n"},//0
	{"Введите свой пароль\n","Please enter your password\n"},//1
	{"{FFFFFF}Попыток для ввода пароля: {28910B}%d","{FFFFFF}You have {28910B}%d{FFFFFF} attempts"},//2
	{"{bfbbba}Авторизация","Authorization"},//3
	{"Ваш ник не соответствует правилам сервера. Смените его.","Your nickname do not mach with server rules"},//4
	{"{FFFFFF}Ваш ник не соответствует правилам сервера.\nВведите новый ник в окошко и нажмите {9ACD32}Далее.\n\n{FFFFFF}Пример: {9ACD32}Carl_Johnson","{FFFFFF}Your nickname do not match server rules.\nEnter new nickname in dialog {9ACD32}Next.\n\n{FFFFFF}Например: {9ACD32}Carl_Johnson"},//5
	{"Принять","Next"},//6 для далле
	{"Выход","Exit"},//7 для выходов
	{"{FFFFFF}Вы собрались покинуть сервер.\nЕсли хотете сделать это нажмите 'Покинуть'.\nВ ином случае нажмите 'Отмена'","{FFFFFF}You leaving the server.\nTo leave server click 'Next'.\nTo stay click 'Exit'"},//8
	{"{FF0000}Неверный пароль!\n","{FF0000}Invalid password!\n"},//9
	{"{FFFFFF}Введите ваш код безопасности","{FFFFFF}Enter your safety code"},//10
	{"{FFFFFF}Введите {0AD6FF}новый{FFFFFF} код безопасности","{FFFFFF}Enter {0AD6FF}new{FFFFFF} safety code"},//11
	{"{FFFFFF}Введите {0AD6FF}новый{FFFFFF} код безопасности\n{FF0000}Ошибка: Длина кода безопасности должна быть не менее 4-х символов","{FFFFFF}Enter {0AD6FF}new{FFFFFF} safety code.\n{FF0000}Error: the length of the safety code need to be more than 4 symbols and less than 10 symbols."},//12
	{"{FFFFFF}Введите {0AD6FF}новый{FFFFFF} код безопасности\n\n{FF0000}Ошибка: Код безопасности может состоять только из цифр","{FFFFFF}Enter {0AD6FF}new{FFFFFF} safety code\n\n{FF0000}Error: safety code can contain only numbers."},//13
	{"Ваш новый код безопасности: {0AD6FF}%d","Your new safety code: {0AD6FF}%d"},//14
	{"Неверный код безопасности, вы были кикнуты!","Invalid safety code, you were kicked."},//15
	{"Вы успешно удалили код безопасности","You successfully removed safety code"},//16
	{"Для работы с данными параметрами необходимо привязать IP","To operate this parameter you need to attach ip."},//17
	{"Удалить код безопасности\nСменить код безопасности\nЗапрашивать: %s","Delete safety code\nChange safety code\nRequest: %s"},//18
	{"{10F441}Если не совпадает IP","{10F441}If ip do not match"},//19
	{"{0AD6FF}Всегда","{0AD6FF}Always"},//20
	{"{AFAFAF}Никогда","{AFAFAF}Never"},//21
	{"Arizona RP |  {DC4747}Настройки","Settings"},//22
	{"Добро пожаловать на "NAMECONNECT"","Welcome to Arizona Project!"},//23
	{"{ffffff}Добро пожаловать,{1a4b84} %s{FFFFFF}\n\n","{FFFFFF}Welcome, {205CA2}%s{FFFFFF}\n\n"},//24
	{"Этот аккаунт {ff6347}не зарегистрирован {FFFFFF}на нашем серере.\n","This account {9EF2FF}is not registed {FFFFFF}on our server.\n"},//25"
	{"Для регистрации введите пароль.\n","For registration enter password.\n"},//26
	{"Он будет использоваться для авторизации на нашем сервере.\n\n","It will be used for authorization.\n\n"},//27
	{"{BF2F2F}\tПримечания:\n","{BF2F2F}\tNotes:\n"},//28
	{"\t- Длина пароля от 6 до 30 символов\n","\t- Length of the password must be from 6 to 30 symbols\n"},//29
	{"\t- Пароль должен состоять из букв и цифр\n","\t- Password must consist of letters and numbers\n"},//30
	{"\t- Пароль чувствителен к регистру\n","\t- Password is sensitive to register\n"},//31
	{"{E88813}(1/4) Пароль","{E88813}(1/4) Password"},//32
	{"{E88813}[2/5] Выберите ваш пол","{E88813}[2/5] Select your gender"},//33
	{"Мужчина\nЖенщина","Male\nFemale"},//34
	{"{E88813}[3/5] Выберите цвет кожи","{E88813}[3/5] Select your skin color"},//35
	{"{FFCC99}Светлый\n{FFCC99}Тёмный","{FFCC99}White\n{FFCC99}Black"},//36
	{"[3/4] Откуда вы о нас узнали?","[3/4] How did you find us?"},//37
	{"Вкладка 'Hosted'\nОт друзей\nНа порталах/форумах\nВ поисковике\nДругое","'Hosted'\nFrom friends\nOn portals/forums\nGoogle\nOther"},//38
	{"{E88813}[5/5] Введите ник пригласившего?","{E88813}[5/5] Enter nickname of the person who invited you?"},//39
	{"{FFFFFF}Введите ник игрока пригласившего вас.\nПример: {E88813}Carl_Johnson\n","{FFFFFF}Enter nickname of the person who invited you.\nSample: {E88813}Carl_Johnson\n"},//40
	{"Вкладка 'Hosted'","Hosted"},//41
	{"От друзей","From friends"},///42
	{"На порталах","On the portals"},//43
	{"В поисковике","Google"},//44
	{"Другое","Other"},//45
	{"[Информация] {FFFFFF}Благодарим вас за регистрацию на нашем сервере","[Help] {FFFFFF}Thank you for registration on Arizona Project"},//46
	{"[Информация] {FFFFFF}Сейчас вам желательно добраться до мэрии и получить паспорт","[Help] {FFFFFF}Right now you need to reach City Hall and get passport"},//47
	{"Приветствуем нового игрока нашего сервера: {FF9900}%s {FFFFFF}(ID: %i)","Congratulations to our new player"},//48

	{"Только что игрок {FF9900}%s{FFFFFF} указал ваш ник при регистрации, при достижении 3 уровня вы получите 150000$!","Right now player {FF9900}%s{FFFFFF} matched your nickcname during registration, when he will recieve 3 lvl you will get 50000$!"},//49
	{"Посмотреть весь список указавших ваш ник игроков вы можете введя /referals","Check all accounts registed on your name you can using /referals"},//50

	{"_________________Ошибка_____________________","_________________Error_____________________"},//51
	{"Возможные причины:","Possible reasons:"},//52
	{"    - Вы указали свой ник","    - You entered your nickname"},//53
	{"    - Такого аккаунта не существует","    - This account does not exists"}
};
enum tInfo
{
	tGun[10],
	tAmmo[10],
	tMoney,
	tDrugs,
	tMats,
	tArmours,
	tPackets,
	tOpen,
	tKanistra,
	tDee,
	tBagazhnikSlot[30],
	tBagazhnikSlotKol[30]
};
new TrunkInfo[MAX_VEHICLES][tInfo];
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//Анти ДМ зоны
#define MAX_ADZONE  (43)
enum antidminfo
{
    zName[130],
	zStatus,
	Float:zX,
	Float:zY,
	Float:zZ
};
new AntiDm[MAX_ADZONE][antidminfo] =
{
    {"Банк", 1, -2680.96, 796.41, 1501.03},
	{"Улица банка", 1, 1480.04, -1685.79, 13.32},
	{"Мэрия", 1, -2064.96, 2676.71, 1500.97},
	{"Улица мэрии", 1, 1502.73, -1282.03, 14.53},
	{"Завод", 1, 2562.60, -1293.65, 1044.13},
	{"Больница", 1, -1772.41, -2011.23, 1500.79},
	{"Спавн LS", 1, 1613.4302, -2288.5354, 13.5269},
	{"ЖД СФ", 1, -1991.26, 147.55, 27.54},
	{"ЖД ЛВ", 1, 2825.78, 1287.74, 10.77},
	{"Улица больницы ЛВ", 1, 1608.94, 1831.35, 10.82},
	{"Ферма", 1, -91.33, 74.06, 3.11},
	{"Улица больницы ЛС", 1, 1228.62, -1334.71, 14.04},
	{"Автошкола", 1, -2053.88, -151.57, 35.34},
	{"Автобазар", 1, -2135.50, -846.25, 32.02},
	{"Амуниция", 1, 291.59, -34.85, 1001.52},
	{"Магазин акссесуаров", 1, -397.30, 2227.77, 1801.09},
	{"Магазин 24/7", 1, -78.0437, -86.8117, 1003.5469},
	{"Центральный рынок", 1, 1129.34, -1447.06, 15.80},
	{"Военкомат ЛС", 1, 320.51, -54.67, 1.58},
	{"Военкомат ЛВ", 1, 1167.32, 1373.45, 10.67},
	{"Автосалон ЛВ", 1, 964.14, 2133.95, 10.84},
	{"Автосалон СФ", 1, -2658.68, -23.13, 4.33},
	{"Авиарынок", 1, 1341.49, 1337.60, 10.82},
	{"Казино", 1, 36.26, 2242.85, 1501.65},
	{"Улица казино", 1, 2030.35, 1008.28, 10.82},
	{"Радиостанция", 1, -192.61, 1334.55, 1500.98},
	{"Военкомат СФ", 1, -1829.11, 154.80, 15.13},
	{"Автошкола интерьер", 1, -2578.77, -1376.59, 1500.76},
	{"Полиция ЛС", 1, -953.16, -2359.56, 1701.09},
	{"Полиция ЛВ/СФ/РК", 1, 2330.56, 92.02, 1502.00},
	{"FBI", 1, -591.27, -672.48, 1001.09},
	{"Улица LV News", 1, 2637.84, 1172.29, 10.82},
	{"Улица SF News", 1, -1970.52, 481.69, 35.17},
	{"Церковь", 1, 1256.93, -1564.77, 3276.88},
	{"Пирс", 1, 372.78, -2040.39, 7.67},
	{"Механики", 1, 206.05, -245.31, 1.57},
	{"Банк ЛВ интерьер", 1, 493.17, 1308.91, 774.48},
	{"Нелег. авторынок", 1, -2466.33, 2250.03, 4.80},
	{"АЗС", 1, 668.5989,-571.3823,1700.7394},
	{"Шахта", 1, 518.5122,969.1405,-23.7126},
	{"Спавн Fort-Carson", 1, -74.8435,1222.0703,19.7293},
	{"Деморган", 1, -809.0515,2830.6538,1501.9896},
	{"Контейнеры", 1,-1732.9348,135.9442,3.5692}
};
#define MAX_SLOTS (72)
enum SLOTS
{
    sName[2300],
};
new InvSlots[MAX_SLOTS][SLOTS] =
{
    {"[1]"},
	{"[2]"},
	{"[3]"},
	{"[4]"},
	{"[5]"},
	{"[6]"},
	{"[7]"},
	{"[8]"},
	{"[9]"},
	{"[10]"},
	{"[11]"},
	{"[12]"},
	{"[13]"},
	{"[14]"},
	{"[15]"},
	{"[16]"},
	{"[17]"},
	{"[18]"},
	{"[19]"},
	{"[20]"},
	{"[21]"},
	{"[22]"},
	{"[23]"},
	{"[24]"},
	{"[25]"},
	{"[26]"},
	{"[27]"},
	{"[28]"},
	{"[29]"},
	{"[30]"},
	{"[31]"},
	{"[32]"},
	{"[33]"},
	{"[34]"},
	{"[35]"},
	{"[36]"},
	{"[37]"},
	{"[38]"},
	{"[39]"},
	{"[40]"},
	{"[41]"},
	{"[42]"},
	{"[43]"},
	{"[44]"},
	{"[45]"},
	{"[46]"},
	{"[47]"},
	{"[48]"},
	{"[49]"},
	{"[50]"},
	{"[51]"},
	{"[52]"},
	{"[53]"},
	{"[54]"},
	{"[55]"},
	{"[56]"},
	{"[57]"},
	{"[58]"},
	{"[59]"},
	{"[60]"},
	{"[61]"},
	{"[62]"},
	{"[63]"},
	{"[64]"},
	{"[65]"},
	{"[66]"},
	{"[67]"},
	{"[68]"},
	{"[69]"},
	{"[70]"},
	{"[71]"},
	{"[72]"}
};
new Float:BoomPos[50][3] = {
{1524.80004883,-1055.50000000,33.59999847},
{1519.59997559,-1055.50000000,33.20000076},
{1513.69995117,-1055.50000000,33.29999924},
{1505.19995117,-1055.50000000,33.09999847},
{1492.40002441,-1057.30004883,35.09999847},
{1492.00000000,-1068.19995117,32.40000153},
{1492.00000000,-1079.69995117,34.40000153},
{1492.00000000,-1086.19995117,34.50000000},
{1492.00000000,-1095.80004883,32.50000000},
{1495.40002441,-1077.59997559,24.10000038},
{1494.59997559,-1058.19995117,24.10000038},
{1495.50000000,-1102.69995117,24.10000038},
{1492.00000000,-1097.19995117,37.90000153},
{1496.19995117,-1104.30004883,24.10000038},
{1496.50000000,-1106.80004883,40.09999847},
{1492.00000000,-1100.09997559,37.70000076},
{1515.00000000,-1104.40002441,24.10000038},
{1526.00000000,-1106.80004883,34.59999847},
{1529.00000000,-1106.80004883,34.20000076},
{1529.50000000,-1104.80004883,24.10000038},
{1541.40002441,-1104.19995117,24.10000038},
{1532.69995117,-1106.80004883,38.59999847},
{1548.00000000,-1106.80004883,38.40000153},
{1551.30004883,-1105.40002441,35.29999924},
{1552.00000000,-1098.09997559,41.09999847},
{1552.00000000,-1102.09997559,50.29999924},
{1550.30004883,-1091.09997559,24.10000038},
{1547.90002441,-1074.09997559,23.50000000},
{1552.00000000,-1092.80004883,42.40000153},
{1533.90002441,-1067.40002441,24.10000038},
{1541.59997559,-1069.40002441,38.50000000},
{1543.50000000,-1078.40002441,42.00000000},
{1546.80004883,-1080.50000000,33.09999847},
{1537.40002441,-1069.00000000,46.29999924},
{1529.00000000,-1062.19995117,39.09999847},
{1521.19995117,-1057.30004883,24.10000038},
{1529.00000000,-1059.00000000,45.70000076},
{1530.40002441,-1063.00000000,24.10000038},
{1526.30004883,-1069.90002441,24.10000038},
{1544.80004883,-1081.30004883,24.10000038},
{1507.00000000,-1058.19995117,24.10000038},
{1518.69995117,-1057.80004883,24.10000038},
{1526.50000000,-1059.50000000,24.10000038},
{1506.00000000,-1055.50000000,37.29999924},
{1499.30004883,-1055.50000000,44.40000153},
{1523.69995117,-1055.50000000,43.79999924},
{1516.59997559,-1055.50000000,40.20000076},
{1499.90002441,-1057.50000000,24.10000038},
{1492.00000000,-1084.30004883,37.70000076},
{1492.19995117,-1057.80004883,44.79999924}
};
new Float:phonepos[133][3]=
{
	{1540.81, -1720.28, 13.79},
	{1163.00, -1704.39, 14.27},
	{1212.94, -1307.07, 13.78},
	{1363.9105,-1257.7277,13.5469},
	{1517.54, -1314.19, 15.23},
	{926.32, -1313.96, 13.81},
	{1066.10, -1029.03, 32.35},
	{460.74, -1607.63, 25.92},
	{333.68, -1775.89, 5.34},
	{539.27, -1266.13, 16.83},
	{1190.87, -930.76, 43.22},
	{1558.57, -1056.97, 24.02},
	{1674.82, -1168.34, 24.19},
	{1838.52, -1374.49, 13.86},
	{1795.61, -1620.13, 13.83},
	{1345.00, -1567.78, 13.89},
	{1947.05, -1794.71, 13.85},
	{2093.51, -1790.08, 13.79},
	{1950.80, -1978.01, 13.84},
	{1466.70, -2228.48, 13.80},
	{2088.65, -2101.52, 13.84},
	{2245.30, -2199.81, 13.87},
	{2205.43, -1994.22, 13.80},
	{2170.02, -1745.22, 13.82},
	{2243.34, -1724.31, 13.82},
	{2178.41, -1629.57, 15.08},
	{2422.05, -1890.09, 13.83},
	{2503.14, -1940.56, 13.81},
	{2730.45, -1987.05, 13.84},
	{2833.71, -1645.51, 11.21},
	{2484.72, -1495.39, 24.22},
	{2307.92, -1492.46, 23.81},
	{2277.04, -1338.40, 24.26},
	{2026.62, -1267.34, 24.30},
	{2195.91, -1132.80, 25.77},
	{1876.21, -1039.23, 24.08},
	{1990.07, -1472.45, 13.83},
	{2651.60, -1415.61, 30.63},
	{2831.02, -1129.65, 25.22},
	{2251.45, -1308.21, 24.28},
	{1750.36, -1453.00, 13.81},
	{1706.17, -1319.16, 13.84},
	{1429.55, -1536.88, 13.85},
	{1290.85, -1558.72, 13.87},
	{1827.07, 824.71, 10.75},
	{2026.67, 1080.83, 11.05},
	{2085.41, 1386.88, 11.08},
	{2091.63, 1713.69, 11.08},
	{2214.46, 1780.42, 11.13},
	{2101.19, 2031.25, 11.09},
	{2271.61, 2028.42, 11.06},
	{2118.22, 2234.50, 11.07},
	{2333.44, 2421.31, 11.11},
	{2436.25, 2353.93, 11.08},
	{2174.13, 2461.80, 11.09},
	{2019.56, 2460.77, 11.11},
	{1918.68, 2310.74, 11.08},
	{1720.38, 2242.66, 11.06},
	{1486.36, 2046.84, 11.09},
	{1641.04, 1848.49, 11.09},
	{1313.80, 2059.51, 11.06},
	{1119.09, 2059.85, 11.09},
	{1060.15, 1945.67, 11.08},
	{1050.40, 1381.40, 11.10},
	{1405.17, 1199.50, 11.11},
	{1574.73, 736.68, 11.15},
	{1636.78, 939.82, 11.08},
	{1689.39, 1266.98, 11.15},
	{1715.12, 1374.58, 10.93},
	{2443.80, 2061.84, 11.09},
	{2514.01, 1910.17, 11.13},
	{2616.46, 1973.91, 11.08},
	{2811.74, 2119.81, 10.97},
	{2884.44, 2301.22, 11.09},
	{2635.13, 2307.56, 11.09},
	{2520.01, 2302.06, 11.02},
	{2333.71, 1644.22, 11.10},
	{2434.64, 1506.88, 11.12},
	{2445.94, 1366.45, 11.10},
	{2591.83, 1185.00, 11.08},
	{2798.67, 1322.22, 11.20},
	{2560.91, 1367.11, 11.13},
	{2208.06, 1366.71, 11.08},
	{1853.97, 2061.76, 11.14},
	{1936.07, 2165.18, 11.13},
	{1934.44, 2048.72, 11.06},
	{-1807.46, -128.81, 5.97},
	{-2019.60, -61.78, 35.64},
	{-1996.47, 132.13, 27.94},
	{-2114.38, 327.02, 35.45},
	{-2258.88, 135.45, 35.62},
	{-2268.38, -174.33, 35.57},
	{-2363.64, -146.05, 35.61},
	{-2180.08, 313.92, 35.53},
	{-2018.43, 471.62, 35.47},
	{-2266.92, -36.03, 35.58},
	{-2427.97, -52.55, 35.58},
	{-2410.60, 310.71, 35.44},
	{-2237.71, 552.46, 35.44},
	{-2077.99, 557.22, 35.58},
	{-1824.78, 615.24, 35.48},
	{-1928.06, 720.37, 45.65},
	{-1986.18, 831.29, 45.68},
	{-1752.72, 829.49, 25.22},
	{-1723.04, 655.50, 25.18},
	{-1705.30, 825.06, 25.09},
	{-1805.25, 893.59, 25.08},
	{-1910.16, 867.79, 35.36},
	{-1993.13, 893.16, 45.72},
	{-2154.95, 763.83, 69.90},
	{-1982.00, 1088.07, 56.05},
	{-2643.99, 576.62, 14.94},
	{-2446.00, 716.49, 35.43},
	{-2246.69, 674.83, 49.70},
	{-2133.04, 896.79, 80.27},
	{-1631.27, 740.87, 14.90},
	{-1570.14, 508.45, 7.49},
	{-1673.62, 391.68, 7.44},
	{-1813.99, 71.72, 15.33},
	{-2245.78, -150.15, 35.57},
	{-2427.68, -135.93, 35.56},
	{-2508.02, -116.00, 25.91},
	{-2507.95, 17.15, 26.10},
	{-2363.44, -2.61, 35.51},
	{-2672.04, -63.73, 4.56},
	{-2664.74, -218.79, 4.61},
	{-2692.48, 280.11, 4.64},
	{-2732.06, 421.79, 4.60},
	{-1999.5015,96.6074,27.6875},
	{1721.2460,-1720.8604,13.5433},
	{1381.9146,-1802.9962,13.5469},
	{1394.5167,-1765.7505,13.5469},
	{547.3615,-1499.2080,14.5036}
};

enum BuildInfo
{
	blID,
	blTitle[128],//название
	blInfo[512],//описание
	blSumFinal, //Количество денег для постройки
	blSumAll, //бщая сума доната
	blSumNow, //сколько денег сейчас на строительство и выплаты
	blToBuilt, //сколько раз надо построить здание строителю
	blProgress,//сколько уже сбегали строители
	Float:blPosENJob[3], //устройство на работу и раздевалка
	blBuildMapIcon,
	Float:blPosMater[3], //взять материалы для строителя
	blGetCP, //чекпоинт где взять материалы записать
	blPickUpId,//пикап записываем где устройство
	Text3D:blBuildText, //3д текст для отображения информации, используется у основного пикапа
	Float:blWork1[4], //место для стройки
	Float:blWork2[4], //место для стройки
	Float:blWork3[4], //место для стройки
	Float:blWork4[4], //место для стройки
	Float:blWork5[4], //место для стройки
	blCP[5], //иды чекпоинтов записать
	Float:blPosEnter[4], //когда готово, это вход в здание
	Float:blPosExit[4], //когда готово, это выход из здания
	blENDPickUP[2], //пикапы входа
	Text3D:blENDBuildText[2],
	////для концертного зала
	blClosed,
	blArenderID[30],
	blTime,
	blCanEnter
 ////////////////////

}
#define MAX_BUILDS 2
new BuildsInfo[MAX_BUILDS][BuildInfo];
new Building_Zone[88];
new Float:bandos[30][3]=
{
	{43.1621,2271.6753,1501.6503},
	{44.0261,2271.6763,1501.6503},
	{44.8576,2271.6763,1501.6503},
	{45.7474,2271.6763,1501.6503},
	{46.5864,2271.6763,1501.6503},
	{46.5570,2274.3018,1501.6503},
	{45.7277,2274.3018,1501.6503},
	{44.8369,2274.3013,1501.6503},
	{43.9972,2274.3013,1501.6503},
	{43.1689,2274.3013,1501.6503},
	{43.1528,2277.6770,1501.6503},
	{44.0127,2277.6770,1501.6503},
	{44.8449,2277.6768,1501.6503},
	{45.7148,2277.6768,1501.6503},
	{46.5590,2277.6770,1501.6503},
	{46.6047,2280.3076,1501.6503},
	{45.7323,2280.3035,1501.6503},
	{44.8837,2280.3035,1501.6503},
	{44.0259,2280.3035,1501.6503},
	{43.1655,2280.3022,1501.6503},
	{37.7194,2232.9553,1505.9384},
	{36.8786,2232.9558,1505.9384},
	{35.9995,2232.9556,1505.9384},
	{35.1630,2232.9553,1505.9384},
	{34.3161,2232.9553,1505.9384},
	{33.0705,2232.9556,1505.9384},
	{32.2459,2232.9556,1505.9384},
	{31.4055,2232.9556,1505.9384},
	{30.5634,2232.9556,1505.9384},
	{29.6932,2232.9556,1505.9384}
};
new HotelEat[1];
new Pstroka[MAX_PLAYERS][8];

new Phonestat[MAX_PLAYERS];
new clickerstat[MAX_PLAYERS];
new speactactive[MAX_PLAYERS];
new pclicklen[MAX_PLAYERS][10];
new Text:Pnumber[15];
new Text:Sphone[9];
new Text:SphoneKey[9];
new Text:Calling[4];
new Text:EventSob[7];
new Text:TeleportEvent[14];

new PlayerText: Ppnumber[MAX_PLAYERS];
new PlayerText:callname[MAX_PLAYERS];
new PlayerText:calltime[MAX_PLAYERS];
new PlayerText:bydilnik[MAX_PLAYERS];
new Text:kryg;
new PlayerText: pKlicked[MAX_PLAYERS];
new PlayerText:EventTimeTD[MAX_PLAYERS][1];
enum gtInfo
{
	gtID,
	gtGoID,
Float:gtX,
Float:gtY,
Float:gtZ,
Float:gtTPX,
Float:gtTPY,
Float:gtTPZ,
	gtState,
	gtStayed
}

new GotoInfo[MAX_PLAYERS][gtInfo];
new Text:Bandito[10];
new Text:BetText[MAX_PLAYERS];
new Text:BalanceText[MAX_PLAYERS];
new Text:Box;
new Text:Digit1[6];
new Text:Digit2[6];
new Text:Digit3[6];
new Slots[MAX_PLAYERS][3];
new SlotCounter[MAX_PLAYERS];
new Gambling[MAX_PLAYERS];
new SlotTimer[MAX_PLAYERS];

new Bet[MAX_PLAYERS];
new Balance[MAX_PLAYERS];
new BronzeRoulette[MAX_PLAYERS];
new SilverRoulette[MAX_PLAYERS];
new GoldRoulette[MAX_PLAYERS];
Text:CreateSprite(Float:X,Float:Y,Name[25],Float:Width,Float:Height)
{
	new Text:RetSprite;
	RetSprite = TextDrawCreate(X, Y, Name); // Text is txdfile:texture
	TextDrawFont(RetSprite, 4); // Font ID 4 is the sprite draw font
	TextDrawColor(RetSprite,0xFFFFFFFF);
	TextDrawTextSize(RetSprite,Width,Height); // Text size is the Width:Height
	return RetSprite;
}
enum bbInfo
{
bool:bbCreated,
Float:bbPos[3],
	bbTime,
Text3D:bbText,
	bbObject,
bool:bbBreak
}

new BombInfo[MAX_BOMBS][bbInfo];
Text:CreateBox(Float:X,Float:Y,Float:Width,Float:Height,color)
{
	new Text[500];
	for(new i=floatround(Y); i < floatround(Y+Height);i++) strcat(Text,"~n~_");
	new Text:RetSprite;
	RetSprite = TextDrawCreate(X, Y, Text); // Text is txdfile:texture
	TextDrawFont(RetSprite, 0); // Font ID 4 is the sprite draw font
	TextDrawColor(RetSprite,0xFFFFFFFF);
	TextDrawTextSize(RetSprite,Width+X,Height+Y); // Text size is the Width:Height
	TextDrawUseBox(RetSprite,1);
	TextDrawBoxColor(RetSprite,color);
	TextDrawLetterSize(RetSprite,0.0001,0.1158);
	return RetSprite;
}
new Text:StopAnimation;
new TimerP;
//new PTick[MAX_PLAYERS];
new Process[MAX_PLAYERS][MAX_VEHICLES];
new MProcess[MAX_PLAYERS][MAX_VEHICLES];
new boomob[16];
new dym[40];
new zdanie;
new Fullness[MAX_PLAYERS];
new FirstHotel[MAX_PLAYERS] = {-1, ...};
new LightsObject[MAX_VEHICLES][2];
new pSportZal[MAX_PLAYERS];
new shotTime[MAX_PLAYERS];
new SellGzone[MAX_PLAYERS];
new SellPGzone[MAX_PLAYERS];
new Text3D:cretits;
new Text:alcodraw[5];
new Text:alcodraw2[5];
new Text:alcodraw1[7];
static const Pb[27] =
{
	0x10331113, 0x11311131, 0x11331313, 0x80133301,0x1381F110, 0x10311103, 0x10001F10, 0x11113311,0x13113311, 0x31101100, 0x30001301, 0x11031311,
	0x11111331, 0x10013111, 0x01131100, 0x11111110,0x11100031, 0x11130221, 0x33113311, 0x11111101,0x33101133, 0x101001F0, 0x03133111, 0xFF11113F,
	0x13330111, 0xFF131111, 0x0000FF3F
};
static VehicleID[MAX_PLAYERS];
new actortime[MAX_ACTORSS];
new CreteBomb[MAX_PLAYERS];
new GLS[76];
new TimerPremmm;
new fprem[23];
static const AC_CODE[AC_MAX_CODES][AC_MAX_CODE_LENGTH] =
{
    "1000",
    "1001",
    "1002",
    "1003",
    "1004",
    "1005",
    "1006",
    "1007",
    "1008",
    "1009",
    "1010",
    "1011",
    "1012",
    "1013",
    "1014",
    "1015",
    "1016",
    "1017",
    "1018",
    "1019",
    "1020",
    "1021",
    "1022",
    "1023",
    "1024",
    "1025",
    "1026",
    "1027",
    "1028",
    "1029",
    "1030",
    "1031",
    "1032",
    "1033",
    "1034",
    "1035",
    "1036",
    "1037",
    "1038",
    "1039",
    "1040",
    "1041",
    "1042",
    "1043",
    "1044",
    "1045",
    "1046",
    "1047",
    "1048",
    "1049",
    "1050",
    "1051",
    "1052"
};
static const AC_CODE_NAME[AC_MAX_CODES][AC_MAX_CODE_NAME_LENGTH] =
{
    {"Невалидное перемещение - Пешком"},
    {"Невалидное перемещение - В машине"},
    {"Телепорт - Пешком"},
    {"Телепорт - В машине"},
    {"Телепорт - По сиденьям в машине"},
    {"Телепорт - Машину к игроку"},
    {"Телепорт - Пикапы"},
    {"Флай - Пешком"},
    {"Флай - В машине"},
    {"СпидХак - Пешком"},
    {"СпидХак - В машине"},
    {"Чит на хп - В машине"},
    {"Чит на хп - Пешком"},
    {"Чит на броню"},
    {"Чит на деньги"},
    {"Чит на оружие"},
    {"Чит на патроны - Добавлять"},
    {"Чит на патроны - Бесконечные"},
    {"Чит на джетпак"},
    {"ГМ на патроны - Пешком"},
    {"ГМ на патроны - В машине"},
    {"Чит на невидимку"},
    {"Lagcomp-spoof"},
    {"Чит на тюнинг"},
    {"Чит на паркур"},
    {"Быстрый разворот"},
    {"Рапид"},
    {"Невалидный вызов спавна"},
    {"Невалидный Килл"},
    {"Про Аим"},
    {"Бег CJ"},
    {"Каршот"},
    {"CarJack"},
    {"Розморозка"},
    {"АФК Привидение"},
    {"Аим"},
    {"Невалидный НПС"},
    {"Реконнект"},
    {"Высокий пинг"},
    {"Подмена диалога"},
    {"Песочница"},
    {"Невалидная версия"},
    {"Взлом Ркон"},
    {"Невалидный тюнинг"},
    {"Флуд смены мест"},
    {"Диалог крашер"},
    {"Невалидные приаттаченные объекты"},
    {"Крашер оружием"},
    {"Флуд коннектами в один слот"},
    {"Флуд автовызываемыми функциями"},
    {"Невалидное место в авто"},
    {"Ддос"},
    {"NOP's"}
};


static const AC_TRIGGER_TYPE_NAME[AC_MAX_TRIGGER_TYPES][AC_MAX_TRIGGER_TYPE_NAME_LENGTH] = {
    "{BC7677}Отключен",
    "{CAB491}Сообщать",
    "{D89B7D}Кикнуть"
};
new
    AC_CODE_TRIGGER_TYPE[AC_MAX_CODES],
    AC_CODE_TRIGGERED_COUNT[AC_MAX_CODES] = {0, ...};

new
    pAntiCheatLastCodeTriggerTime[MAX_PLAYERS][AC_MAX_CODES],
    pAntiCheatSettingsPage[MAX_PLAYERS char],
    pAntiCheatSettingsMenuListData[MAX_PLAYERS][AC_MAX_CODES_ON_PAGE],
    pAntiCheatSettingsEditCodeId[MAX_PLAYERS];
/////////////
new AnimNames[49][30] =
{
	"1. Ложиться[1]",
	"2. Читать RAP[1]",
	"3. Читать RAP[2]",
	"4. Сесть[1]",
	"5. Сесть[2]",
	"6. Поднять руки",
	"7. Навести пушку",
	"8. Ударить по попе",
	"9. Положить цветы",
	"10. Fuck Bich",
	"11. Кунг-Фу[1]",
	"12. Поцеловать по мужски",
	"13. Поцеловать по женски",
	"14. Танец[2]",
	"15. Танец[3]",
	"16. Танец[4]",
	"17. Кунг-Фу[2]",
	"18. Остановить такси",
	"19. Сесть[3]",
	"20. Сесть[4]",
	"21. Ложиться[2]",
	"22. Ложиться[3]",
	"23. Ложиться[4]",
	"24. Стойка АK-47",
	"25. Стойка Deagle",
	"26. Махать рукой",
	"27. Устроить бунт",
	"28. Позвать к себе",
	"29. Упасть",
	"30. Подняться",
	"31. Поздароваться[1]",
	"32. Поздароваться[2]",
	"33. Поздароваться[3]",
	"34. Пить",
	"35. Ударить с ноги",
	"36. Задуматься",
	"37. Сдаться",
	"38. Толкнуть",
	"39. Почесать яйца",
	"40. Рисовать[Gravity]",
	"41. Медик",
	"42. Умирать",
	"43. Прыгнуть",
	"44. Перекатиться",
	"45. Бокс",
	"46. Читать RAP[3]",
	"47. You Nigga[5]",
	"48. Полежать",
	"49. Танцевать на одной ноге"
};
new AddMessages[MAX_PLAYERS][128];
new AddTimeMessages[MAX_PLAYERS];
new AddId[MAX_PLAYERS];
new time_grandtimer,time_grandtimer_max;
new time_newkeys,time_pickup;
new time_update_max;
///////////АНТИЧИТ//////////
new time_podoz,time_zcar;
new time_vcar,time_lspawn,time_pick;
new addchet[MAX_PLAYERS];
///////////АНТИЧИТ//////////
new Weather;
new Text:GrandKapt[10];
new Text:Grand2Kapt[10];
//
new RegTimeNumber[MAX_PLAYERS];
new RegCarNumber[MAX_PLAYERS];
new RegCarID[MAX_PLAYERS];
new RegNumbers[MAX_PLAYERS][128];
new HealSG[103];
//new Parashute[3];
new
Text:BoxShopEat1,
Text:BoxShopEat2,
Text:BoxShopEat3,
Text:BoxShopEat4,
Text:BoxShopEat5,
Text:BoxShopEat6,
Text:EatShopEat1,
Text:EatShopEat2,
Text:IconShopsEat2,
Text:CenaShopEat1,
PlayerText:CenaShopEat2[MAX_PLAYERS],
Text:SelectShopEat1,
Text:IconShopEat1,
Text:IconShopEat2;

//new bonus[2];
new EnterSklad[11];
new bool:PlayerPlayed[MAX_PLAYERS];
new bool:PlayerGlass[MAX_PLAYERS];
new amybank;
new nalogoffise[2];
new shopeat[38];
new onlineplayers[MAX_PLAYERS];
//==========speed===========
new Text:speedbox[4];
new PlayerText:speeddraw[MAX_PLAYERS][7];
new PlayerText:speed_prodvin[MAX_PLAYERS][42];
//==========speed===========
enum _spectator
{
	sID
}
new SERIU[MAX_PLAYERS][_spectator];
new TempBGObject[MAX_PLAYERS] = {-1, ...};
new Float:LightsPos[212][6] =
{
	{ 0.8766, 2.0272, -0.1000, 0.8766, -2.2272, -0.1000 },
	{ 0.9566, 2.4500, 0.0000, 0.9566, -2.3500, 0.0000 },
	{ 0.8033, 2.5363, 0.0000, 0.9033, -2.6363, 0.0000 },
	{ 1.1500, 4.1909, -0.2000, 0.3499, -4.1909, -0.7000 },
	{ 0.7333, 2.2409, 0.2000, 0.8333, -2.6409, 0.0000 },
	{ 0.9833, 2.2272, -0.1000, 0.8833, -2.7272, -0.1000 },
	{ 1.0566, 5.2681, 0.0000, 2.2566, -5.1681, 0.4000 },
	{ 0.8499, 4.0727, 0.1000, 1.0499, -3.4727, 0.2000 },
	{ 0.9399, 4.8590, -0.4000, 0.8399, -4.0590, -0.5000 },
	{ 0.8899, 3.6181, 0.0000, 0.8899, -3.9181, 0.0000 },
	{ 0.8533, 2.1772, 0.0000, 0.8533, -2.1772, 0.0000 },
	{ 0.9966, 2.6272, -0.2000, 0.8966, -2.4272, 0.0000 },
	{ 0.9166, 2.6227, -0.1000, 0.8166, -3.6227, -0.2000 },
	{ 0.9600, 2.6727, -0.1000, 0.9600, -2.6727, 0.0000 },
	{ 0.7399, 2.8136, -0.1000, 1.0399, -3.2136, 0.0000 },
	{ 0.8733, 2.5045, -0.3000, 0.7733, -2.5045, 0.0000 },
	{ 0.9099, 2.9409, 0.0000, 1.1100, -3.7409, -0.5000 },
	{ 1.8166, 10.5772, 0.0000, 1.8166, -10.5772, 0.0000 },
	{ 0.9566, 2.4772, -0.2000, 1.0566, -2.5772, -0.2000 },
	{ 0.8000, 2.7272, -0.4000, 0.8000, -2.9272, -0.2000 },
	{ 0.9033, 2.3863, 0.0000, 0.9033, -2.6863, 0.0000 },
	{ 0.8500, 2.6045, -0.2000, 0.8500, -2.9045, -0.2000 },
	{ 0.7566, 2.2454, -0.3000, 0.8566, -2.4454, -0.3000 },
	{ 0.7733, 2.2999, 0.0000, 0.8733, -2.2000, 0.0000 },
	{ 0.7199, 1.5545, 0.2000, 0.6199, -1.6545, 0.3000 },
	{ 1.7199, 8.4681, 0.0000, 1.7199, -8.4681, 0.0000 },
	{ 1.0033, 2.3863, 0.0000, 0.9033, -2.6863, 0.0000 },
	{ 0.8800, 3.3272, -0.1000, 0.9800, -3.7272, 0.3000 },
	{ 0.9100, 2.5545, 0.2000, 0.9100, -2.9545, 0.2000 },
	{ 0.7366, 2.2545, -0.3000, 0.8366, -2.4545, 0.0000 },
	{ 1.5900, 7.6818, 0.0000, 1.5900, -7.6818, 0.0000 },
	{ 1.0033, 5.9499, 0.4000, 1.0033, -5.8499, 0.0000 },
	{ 1.4333, 4.1681, 0.0000, 1.4333, -4.1681, 0.0000 },
	{ 1.2333, 3.7454, -0.1000, 1.3333, -4.7454, -0.1000 },
	{ 0.5633, 1.9772, -0.1000, 0.4633, -1.9772, -0.1000 },
	{ 1.0533, 6.1499, 0.0000, 1.0533, -3.9500, -1.1000 },
	{ 0.8600, 2.3045, 0.0000, 0.8600, -2.5045, 0.0000 },
	{ 1.2133, 5.5454, -0.2000, 1.1133, -5.2454, 0.4000 },
	{ 0.9033, 2.6454, 0.0000, 0.9033, -2.7454, -0.1000 },
	{ 0.8400, 2.4045, -0.5000, 0.8400, -2.7045, -0.1000 },
	{ 0.9700, 2.6272, -0.3000, 0.8700, -2.6272, 0.1000 },
	{ 0.2899, 0.6409, 0.0000, 0.2899, -0.6409, 0.0000 },
	{ 0.9699, 2.8363, -0.2000, 1.0699, -3.0363, 0.0000 },
	{ 1.0866, 5.8136, -1.0000, 1.2866, -7.1136, -0.9000 },
	{ 1.1200, 2.7363, 0.7000, 1.1200, -3.0363, 0.7000 },
	{ 0.9666, 2.3636, 0.0000, 0.9666, -2.7636, -0.2000 },
	{ 1.5900, 7.7363, 0.0000, 1.5900, -7.7363, 0.0000 },
	{ 0.8066, 6.7272, 0.0000, 0.8066, -6.7272, 0.0000 },
	{ 0.2366, 0.9954, 0.0000, 0.2366, -0.9954, 0.0000 },
	{ 1.0099, 4.1045, 0.0000, 1.0099, -4.1045, 0.0000 },
	{ 1.0233, 6.1409, 0.0000, 1.0233, -3.9409, -1.2000 },
	{ 0.7733, 2.0863, -0.2000, 0.8733, -2.4863, -0.2000 },
	{ 1.2033, 6.6227, 0.0000, 1.2033, -6.6227, 0.0000 },
	{ 1.7133, 6.2590, 0.0000, 1.7133, -6.2590, 0.0000 },
	{ 2.2066, 8.6590, 0.0000, 2.2066, -8.6590, 0.0000 },
	{ 1.2066, 3.7090, -0.1000, 1.3066, -4.7090, -0.1000 },
	{ 0.8766, 3.3272, -0.1000, 0.8766, -4.6272, -0.5000 },
	{ 0.4099, 1.1863, 0.0000, 0.5099, -1.2863, 0.0000 },
	{ 0.9033, 2.4909, -0.2000, 0.9033, -2.7909, 0.0000 },
	{ 0.9666, 2.5999, -0.1000, 0.8666, -2.5999, 0.1000 },
	{ 3.6166, 6.1590, 0.0000, 3.6166, -6.1590, 0.0000 },
	{ 0.2333, 0.8181, 0.5000, 0.2333, -1.1181, 0.3000 },
	{ 0.2366, 0.9954, 0.0000, 0.2366, -0.9954, 0.0000 },
	{ 0.2333, 1.1000, 0.0000, 0.2333, -1.1000, 0.0000 },
	{ 0.5266, 0.5045, 0.0000, 0.5266, -0.7045, 0.0000 },
	{ 0.2899, 0.6409, 0.0000, 0.2899, -0.6409, 0.0000 },
	{ 0.9433, 2.6045, 0.1000, 1.0433, -2.8045, 0.0000 },
	{ 0.6433, 2.8909, -0.1000, 0.9433, -3.0909, 0.0000 },
	{ 0.2366, 1.0136, 0.0000, 0.2366, -1.0136, 0.0000 },
	{ 0.8066, 6.7272, 0.0000, 0.8066, -6.7272, 0.0000 },
	{ 1.0866, 2.0909, 0.2000, 1.0866, -2.6909, -0.2000 },
	{ 0.4733, 0.9090, 0.0000, 0.4733, -0.9090, 0.0000 },
	{ 0.8900, 4.2454, 0.0000, 0.8900, -4.2454, 0.0000 },
	{ 0.9666, 2.4545, 0.0000, 0.9666, -2.4545, 0.0000 },
	{ 0.9100, 2.7409, 0.0000, 1.0099, -2.7409, -0.1000 },
	{ 0.9166, 2.5272, -0.3000, 0.8166, -2.8272, -0.3000 },
	{ 3.6766, 5.1318, 0.0000, 3.6766, -5.1318, 0.0000 },
	{ 0.7900, 2.6954, -0.2000, 1.0900, -2.5954, 0.1000 },
	{ 0.9166, 2.2318, 0.0000, 1.0166, -2.5318, -0.3000 },
	{ 0.9500, 2.4954, 0.0000, 0.9500, -2.7954, 0.0000 },
	{ 0.8566, 1.7909, 0.0000, 0.8566, -2.2909, -0.2000 },
	{ 0.2366, 0.8545, 0.0000, 0.2366, -0.8545, 0.0000 },
	{ 0.8799, 2.3909, -0.4000, 0.8799, -2.5909, 0.0000 },
	{ 0.7833, 2.6136, 0.0000, 0.6833, -2.8136, -0.3000 },
	{ 1.7833, 11.9090, 0.0000, 1.7833, -11.9090, 0.0000 },
	{ 0.6566, 1.7500, 0.0000, 0.6566, -1.3499, 0.0000 },
	{ 0.8466, 1.5636, 1.0000, 0.5466, -3.2636, 1.1000 },
	{ 0.7766, 6.8363, 0.0000, 0.7766, -6.8363, 0.0000 },
	{ 0.7766, 5.7318, 0.0000, 0.7766, -5.7318, 0.0000 },
	{ 1.0466, 2.5909, 0.0000, 1.1466, -2.6909, 0.2000 },
	{ 0.9733, 3.1499, 0.0000, 1.1733, -3.1499, 0.1000 },
	{ 0.8700, 2.5772, -0.1000, 0.8700, -2.8772, 0.0000 },
	{ 0.7833, 2.6090, 0.0000, 0.7833, -2.8090, 0.0000 },
	{ 1.5900, 8.1045, 0.0000, 1.5900, -8.1045, 0.0000 },
	{ 0.8500, 2.3500, -0.2000, 0.8500, -2.8499, 0.1000 },
	{ 1.1266, 2.3772, 0.0000, 1.1266, -2.0772, 0.0000 },
	{ 0.9600, 2.2590, 0.0000, 0.9600, -2.0590, 0.0000 },
	{ 0.7766, 6.8363, 0.0000, 0.7766, -6.8363, 0.0000 },
	{ 0.8666, 3.0999, 0.2000, 0.9666, -3.0999, 0.3000 },
	{ 0.7799, 2.5727, -0.2000, 1.0800, -3.4727, 0.1000 },
	{ 0.4633, 2.0772, -0.2000, 0.7633, -1.9772, 0.0000 },
	{ 0.2899, 0.6409, 0.0000, 0.2899, -0.6409, 0.0000 },
	{ 0.8833, 2.6136, -0.2000, 0.7833, -2.7136, 0.0000 },
	{ 0.8366, 2.3909, 0.0000, 0.8366, -2.8909, 0.0000 },
	{ 0.9433, 2.6454, 0.1000, 1.0433, -2.8454, 0.0000 },
	{ 1.0466, 2.5909, 0.0000, 1.1466, -2.6909, 0.1000 },
	{ 0.7500, 2.2727, -0.3000, 0.8500, -2.3727, 0.0000 },
	{ 1.0566, 2.5954, -0.1000, 1.1566, -2.8954, -0.1000 },
	{ 0.6866, 2.9590, -0.7000, 0.9866, -3.7590, 0.0000 },
	{ 0.2366, 0.8636, 0.0000, 0.2366, -0.8636, 0.0000 },
	{ 0.2400, 0.7909, 0.0000, 0.2400, -0.7909, 0.0000 },
	{ 7.0733, 9.6318, 0.0000, 7.0733, -9.6318, 0.0000 },
	{ 3.7200, 2.7999, 0.0000, 3.7200, -2.7999, 0.0000 },
	{ 2.8999, 4.0909, 0.0000, 2.8999, -4.0909, 0.0000 },
	{ 1.2633, 4.2772, 0.1000, 0.3633, -5.0772, -0.4000 },
	{ 1.2833, 4.4227, -0.5000, 0.3833, -4.6227, -1.3000 },
	{ 0.9666, 2.7363, 0.0000, 0.9666, -2.8363, 0.0000 },
	{ 0.9433, 2.7772, 0.0000, 0.9433, -2.7772, -0.1000 },
	{ 0.8100, 2.7272, 0.0000, 1.0099, -2.8272, -0.2000 },
	{ 6.7699, 8.7681, 0.0000, 6.7699, -8.7681, 0.0000 },
	{ 2.9166, 6.5090, 0.0000, 2.9166, -6.5090, 0.0000 },
	{ 0.2333, 1.1181, 0.0000, 0.2333, -1.1181, 0.0000 },
	{ 0.2333, 1.1181, 0.0000, 0.2333, -1.1181, 0.0000 },
	{ 0.2333, 1.1227, 0.0000, 0.2333, -1.1227, 0.0000 },
	{ 0.8966, 3.7181, 0.0000, 1.1966, -3.9181, -1.1000 },
	{ 0.8166, 3.0409, 0.1000, 0.9166, -3.1409, -0.1000 },
	{ 0.9333, 2.3545, -0.2000, 0.8333, -2.3545, 0.0000 },
	{ 0.9099, 2.5000, 0.0000, 0.9099, -2.3000, 0.0000 },
	{ 0.8499, 2.5227, -0.2000, 0.8499, -2.6227, -0.3000 },
	{ 0.9933, 2.5590, 0.0000, 0.9933, -2.5590, 0.1000 },
	{ 0.5266, -0.6772, 1.3000, 0.5266, -1.9227, 0.8000 },
	{ 0.2533, 1.5818, -0.2000, 0.2533, -1.1818, -0.1000 },
	{ 0.4733, 4.0772, 1.3000, 0.3733, -1.0772, 0.0000 },
	{ 0.9933, 2.4636, 0.0000, 0.8933, -2.5636, 0.0000 },
	{ 1.0266, 2.9499, -0.2000, 0.7266, -2.8499, -0.1000 },
	{ 0.8899, 2.4909, -0.1000, 0.8900, -2.5909, -0.1000 },
	{ 0.8199, 2.4181, -0.2000, 0.8199, -3.1181, -0.2000 },
	{ 0.7766, 2.3272, 0.0000, 1.1100, -7.9772, 0.0000 },
	{ 1.0900, 7.6409, 0.0000, 1.0900, -7.5409, 0.0000 },
	{ 0.8333, 2.0590, 0.0000, 0.8333, -1.7590, 0.0000 },
	{ 0.9633, 2.6590, -0.1000, 1.0633, -2.7590, -0.1000 },
	{ 0.6566, 2.2499, -0.2000, 0.7566, -2.2499, 0.1000 },
	{ 0.9266, 2.6090, -0.1000, 0.7266, -3.0090, -0.1000 },
	{ 0.7933, 2.3045, 0.1000, 0.9933, -2.7045, 0.0000 },
	{ 0.7366, 3.6454, -0.2000, 0.9366, -4.2454, -0.8000 },
	{ 0.5299, 1.7863, 0.0000, 0.8300, -2.0863, -0.4000 },
	{ 0.9566, 2.5636, 0.0000, 1.0566, -2.6636, 0.0000 },
	{ 0.9299, 2.5545, 0.0000, 0.9299, -2.6545, 0.1000 },
	{ 1.3933, 11.0999, 0.0000, 1.3933, -11.0999, 0.0000 },
	{ 0.9000, 2.5136, 0.0000, 0.9000, -2.5136, 0.0000 },
	{ 0.9466, 2.5772, -0.2000, 0.9466, -2.6772, -0.2000 },
	{ 0.9866, 2.5545, -0.1000, 0.9866, -3.0545, 0.0000 },
	{ 0.9833, 3.0545, 0.3000, 1.1833, -2.8545, 0.3000 },
	{ 9.5799, 10.6772, 0.0000, 9.5799, -10.6772, 0.0000 },
	{ 1.0933, 2.5045, 0.1000, 1.0933, -2.9045, 0.1000 },
	{ 0.7666, 2.2318, 0.0000, 0.6666, -2.4318, -0.2000 },
	{ 1.0199, 2.5954, 0.5000, 1.1200, -2.8954, 0.6000 },
	{ 1.1200, 2.4454, 0.7000, 1.1200, -2.7454, 0.7000 },
	{ 0.9433, 2.0863, 0.0000, 0.9433, -2.3863, 0.2000 },
	{ 0.7599, 2.3909, 0.0000, 0.8600, -2.2909, 0.2000 },
	{ 0.9733, 2.3545, -0.0000, 0.8733, -2.1545, 0.1000 },
	{ 0.8333, 2.6363, -0.1000, 0.9333, -2.6363, 0.0000 },
	{ 0.8533, 2.4136, 0.0000, 0.8533, -2.3136, 0.1000 },
	{ 1.1299, 8.4636, 0.0000, 1.1299, -8.4636, 0.0000 },
	{ 0.2899, 0.6409, 0.0000, 0.2899, -0.6409, 0.0000 },
	{ 0.7766, 2.0909, 0.0000, 0.8766, -1.8909, 0.0000 },
	{ 0.9366, 2.7363, 0.0000, 0.9366, -2.9363, 0.0000 },
	{ 1.0033, 2.9136, -0.2000, 1.0033, -3.0136, -0.2000 },
	{ 0.4033, 2.1954, 0.0000, 0.2033, -1.4954, 0.0000 },
	{ 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000 },
	{ 0.7766, 2.3272, 0.0000, 1.1566, -9.5772, 0.0000 },
	{ 0.5233, 1.0590, 0.0000, 0.5233, -1.0590, 0.0000 },
	{ 0.3533, 0.8681, -0.1000, 0.3533, -1.0681, -0.1000 },
	{ 0.8766, 3.1545, -0.4000, 0.8766, -3.3545, -0.4000 },
	{ 0.5400, 1.7499, -0.2000, 0.5400, -1.2499, -0.2000 },
	{ 0.9300, 2.3500, 0.1000, 0.8299, -2.7499, 0.0000 },
	{ 1.0066, 2.3909, -0.2000, 1.0066, -3.1909, 0.0000 },
	{ 20.8299, 27.9272, 0.0000, 0.0000, 0.0000, 0.0000 },
	{ 1.1500, 4.3590, -0.2000, 1.1500, -5.4590, -0.5000 },
	{ 0.9233, 2.3227, 0.0000, 1.0233, -2.8227, 0.1000 },
	{ 0.7866, 2.6227, -0.2000, 1.0866, -2.8227, 0.0000 },
	{ 0.2333, 1.1181, 0.0000, 0.2333, -1.1181, 0.0000 },
	{ 0.9133, 2.5818, -0.1000, 0.9133, -3.3818, 0.1000 },
	{ 0.6566, 1.4636, 0.3000, 0.5566, -1.6636, 0.4000 },
	{ 1.1833, 7.2318, 0.0000, 1.1833, -7.2318, 0.0000 },
	{ 1.0133, 2.8681, 0.1000, 0.9133, -3.0681, 0.2000 },
	{ 0.2333, 1.2727, 0.0000, 0.2333, -1.2727, 0.0000 },
	{ 0.9699, 2.1181, -0.3000, 1.0699, -2.5181, 0.1000 },
	{ 1.0266, 3.4181, 0.4000, 1.0266, -4.0181, -0.3000 },
	{ 0.7533, 2.4136, 0.1000, 0.8533, -2.3136, 0.4000 },
	{ 1.1466, 8.3636, 0.0000, 1.1466, -8.3636, 0.0000 },
	{ 1.0600, 6.1954, 0.0000, 1.0600, -6.1954, 0.0000 },
	{ 14.8166, 26.1681, 0.0000, 14.8166, -26.1681, 0.0000 },
	{ 4.1966, 6.1590, 0.0000, 4.1966, -6.1590, 0.0000 },
	{ 0.1666, 0.4181, 0.0000, 0.1666, -0.4181, 0.0000 },
	{ 0.9499, 6.1227, 0.0000, 0.9499, -6.1227, 0.0000 },
	{ 1.0033, 2.2863, 0.0000, 0.9033, -2.6863, 0.0000 },
	{ 1.0033, 2.2863, 0.0000, 0.9033, -2.6863, 0.0000 },
	{ 1.0033, 2.3318, 0.0000, 0.9033, -2.7318, 0.0000 },
	{ 1.0733, 2.6000, 0.0000, 1.1733, -2.6000, 0.1000 },
	{ 0.8000, 2.7545, -0.1000, 1.0000, -2.7545, 0.1000 },
	{ 0.8266, 3.1636, 0.5000, 1.0266, -3.0636, 0.9000 },
	{ 0.8733, 2.1181, 0.0000, 0.8733, -2.6181, -0.3000 },
	{ 0.8800, 2.5590, -0.2000, 0.8800, -2.6590, -0.1000 },
	{ 0.8433, 2.6045, 0.1000, 1.0433, -2.8045, 0.0000 },
	{ 0.7933, 2.3045, 0.0000, 0.9933, -2.7045, 0.0000 },
	{ 0.9766, 1.5363, 0.0000, 0.9766, -1.5363, 0.0000 },
	{ 1.0066, 1.4818, 0.0000, 1.0066, -1.4818, 0.0000 },
	{ 0.4833, 2.1136, 0.0000, 0.4833, -2.1136, 0.0000 },
	{ 0.8666, 3.0999, 0.2000, 0.9666, -3.0999, 0.3000 },
	{ 0.8266, 0.6499, 0.0000, 0.8266, -0.6499, 0.0000 },
	{ 0.7100, 1.4363, 0.0000, 0.7100, -1.4363, 0.0000 }
};
new Float:GunPos[47][3] =
{
	{0.00000, 0.00000, 0.00000},
	{295.20001221, -39.40999924, 1001.59997559},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{295.20001221, -39.35999924, 1001.59997559},
	{295.00001221, -39.35999924, 1001.59997559},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{294.90001221, -39.35999924, 1001.59997559},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{295.20001221, -39.33999924, 1001.59997559},
	{295.20001221, -39.33999924, 1001.59997559},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{295.10001221, -39.25999924, 1001.59997559},
	{295.10001221, -39.25999924, 1001.59997559},
	{295.00001221, -39.25999924, 1001.59997559},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{295.10001221, -39.20999924, 1001.59997559},
	{295.00001221, -39.25999924, 1001.59997559},
	{295.00001221, -39.25999924, 1001.59997559},
	{0.00000, 0.00000, 0.00000},
	{295.00001221, -39.25999924, 1001.59997559},
	{295.00001221, -39.25999924, 1001.59997559},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{0.00000, 0.00000, 0.00000},
	{295.20001221, -39.40999924, 1001.59997559}
};
#define GUN_POS GunPos[gunid][0], GunPos[gunid][1], GunPos[gunid][2]
#define GUN_ROT 90.0, 0.0, 90.0
//----------Tir defines----------
#define MAX_TIRS   8
#define TARGET_MODEL 	1586
#define TIR_DIALOG  	238
#define COUNT_TARGETS   5
#define ZAVOD_SKIN_1 259
#define ZAVOD_SKIN_2 260
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define MAX_STRIPS          50
#define UN_SPEED 	0.95
#define MAX_SPEED   0.50
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_VALIK 		0x73B461FF
#define COLOR_SYSTEM 		0xEFEFF7AA
#define COLOR_HPBAR 		0xB42225FF
#define COLOR_HPBAR_BG 		0x000000FF
#define COLOR_HPBAR_BG2 	0x551111FF
#define COLOR_SHBAR 		0x6053F3FF
#define COLOR_SHBAR_BG 		0x000000FF
#define COLOR_SHBAR_BG2 	0xB8CEF6FF
#define NO_LICENSE         	(0)
#define YES_LICENSE         (1)
#define COLOR_AMBAR 		0xFFFFFFFF
#define COLOR_AMBAR_BG 		0x000000FF
#define COLOR_AMBAR_BG2 	0xAFAFAFFF
#define COLOR_ARZCOPY       0xFF6347FF
#define COLOR_RED 			0xFF6347FF
#define COLOR_ANTICHEAT		0xD2B88FFF
#define COLOR_DIALOG        0xBFBBBAFF
//СТАРЫЙ ЦВЕТ КРАСНОГО
#define COLOR_OLDRED 			0xBE2D2DFF
#define COLOR_MEDO 			0x4ED978FF
#define COLOR_OTKAZ 		0x9E9E9EFF
#define COLOR_GATE          0xFCFF54FF
#define COLOR_REPORTTWO     0xF04A4AFF
#define COLOR_TOR           0x613DFFFF
#define COLOR_ORANGE		0xFAAC58FF
#define COLOR_BROWN 		0xA52A2AFF
#define COLOR_GREEN			0x42B02CFF
#define COLOR_GOLD          0xFFD700FF
#define COLOR_LIGHTRED 		0xFF6347FF
#define COLOR_LIGHTBLUE 	0x6495EDFF
#define COLOR_LIGHTGREEN 	0x9ACD32FF
#define COLOR_YELLOW 		0xFFFF00FF
#define COLOR_WHITE 		0xFFFFFFFF
#define COLOR_BLACK 		0x000000FF
#define COLOR_BLUENEW 		0xB8CEF6FF
#define COLOR_BLUE 			0x94B0C1FF
#define COLOR_GRAD 			0xBFC0C2FF
#define COLOR_PURPLE 		0xC2A2DAFF
#define COLOR_LIME 			0x10F441FF
#define COLOR_TOMATO 		0x9EF2FFFF
#define COLOR_GREY 			0xAFAFAFFF
#define COLOR_INDIGO        0x400080FF
#define COLOR_CHAT			0xcececeFF
#define COLOR_SCHAT			0xF0E68CFF
#define COLOR_DOCHAT		0x4682B4FF
#define COLOR_RACIO			0x2DB043FF
#define COLOR_DEPAR			0x3399ffFF
#define COLOR_ACHAT   		0x99CC00FF
#define COLOR_HCHAT			0x6F94AFFF
#define COLOR_SMHAT			0x008080FF
#define COLOR_ME            0xFF99FFFF
#define COLOR_GOV            0x045FB4FF
#define MAX_AFK_RUN_TIME 1200
#define MAX_MUSORS 332
#define MAX_SHAXTA 19
#define SetPlayerTimer(%0,%1,%2,%3) SetTimerEx(%1, %2, %3, "i", %0)
#define RENAME_DIALOG 	(170)
#define VEHICLE_STATE_CAR   0
#define VEHICLE_STATE_BIKE  1
#define VEHICLE_STATE_VELIK 2
#define VEHICLE_STATE_PLANE 3
#define VEHICLE_STATE_BOAT  4
#define VEHICLE_STATE_MOPED 5
#define VEHICLE_STATE_TRAIN 6
#define JOB_NONE        (0)
#define JOB_GUNDEALER 	(1)
#define JOB_DETECTIVE 	(2)
#define JOB_CARJACKER 	(3)
#define JOB_MECHANIC 	(4)
#define JOB_TAXI 		(5)
#define JOB_ADVOKAT 	(6)
#define JOB_MINER 		(7)
#define JOB_GUIDE 		(8)
#define JOB_COLLECTOR 	(9)
#define JOB_DRUGDEALER  (10)
#define JOB_TRUCKER  	(11)
#define JOB_PIZZA  		(12)
#define JOB_SCRAPER  	(13)
#define JOB_MUSOR  		(14)
#define JOB_PORTER 		(15)
#define JOB_NALOG 		(16)
#define JOB_FARMER1 	(17)

#define SPECIAL_ACTION_PISS (68)
#define INVALID_DIALOG_ID   (1234)

#define ADM_NONE 		(0)
#define ADM_MODER 		(1)
#define ADM_SUPER_MODER (2)
#define ADM_ADMIN       (3)
#define ADM_SUPER_ADMIN (4)
#define ADM_GRAND_ADMIN (5)
#define ADM_GRAND		(6)
#define ADM_OSNOV		(7)
#define ADM_OSNOV1      (8)
#define STATUS_NONE     (0)
#define STATUS_VIP      (1)
#define STATUS_GOLD     (2)
#define STATUS_PLATIN   (3)
#define STATUS_TITAN    (4)
#define TEAM_FIRST_RANK (1)
#define PUT_STATE_MONEY (0)
#define PUT_STATE_DRUGS (1)
#define PUT_STATE_MATS 	(2)
#define PUT_STATE_CHEEPS (0)
#define PUT_STATE_SPRUNK (1)
#define SDPistolMats 	(2)
#define MP5Mats      	(2)
#define AK47Mats 	 	(2)
#define UziMats 	 	(2)
#define M4Mats 		 	(2)
#define EagleMats    	(2)
#define ShotGunMats  	(3)
#define RifleMats    	(10)
#define SniperMats   	(50)
#define KoktelMats 	 	(500)
#define MAX_OGRAD 		(1000)
#define MAX_ORGS 		(29)
//#define GasMax 			(100)
#define MAX_OWNABLECARS (3000)
#define MAX_OWNABLEHOTELS  (700)
#define MAX_OWNABLECASINO  (5)
#define MAX_PING        (1500)
#define MAX_HOUSES 		(1200)
#define MAX_BIZ         (350)
#define NO_DUTY_TEXT    "[A] Вы не авторизованы. Используйте {33CCFF}/apanel"
#define DONAT_ID_MONEY 900
#define INVALID_BIZ     (-1)
#define BIZ_GS_LS       (0)
#define BIZ_GS_SF       (1)
#define BIZ_GS_LV       (2)
#define BIZ_ELECTRO_LS 	(15)
#define BIZ_ELECTRO_SF 	(16)
#define BIZ_ELECTRO_LV 	(17)
#define BIZ_CU      	(18)
#define BIZ_GAS_LS_1 	(19)
#define BIZ_GAS_LS_2 	(20)
#define BIZ_GAS_SF_1 	(21)
#define BIZ_GAS_SF_2 	(22)
#define BIZ_GAS_SF_3 	(23)
#define BIZ_GAS_SF_4 	(24)
#define BIZ_GAS_SF_5 	(25)
#define BIZ_GAS_SF_6 	(26)
#define BIZ_GAS_LV_1 	(27)
#define BIZ_GAS_LV_2 	(28)
#define BIZ_GAS_LV_3 	(29)
#define BIZ_GAS_LV_4 	(30)
#define BIZ_GAS_LV_5 	(31)
#define BIZ_GAS_LV_6 	(182)
#define BIZ_RENT_LS     (39)
#define BIZ_RENT_SF     (40)
#define BIZ_RENT_LV     (41) //getto
#define BIZ_AERO_LS     (42)
#define BIZ_RENTLV1 (52)
#define BIZ_RENTLV2 (53)
#define BIZ_RENTLV3 (54)
#define BIZ_RENTLV4 (55)
#define BIZ_RENTLV5 (56)
#define BIZ_RENTLV6 (57)
#define BIZ_RENTLV7 (58)

#define BIZ_SFRENT1 (122)
#define BIZ_SFRENT2 (123)
#define BIZ_SFRENT3 (124)
#define BIZ_SFRENT4 (125)

#define BIZ_SFNRG   (127)
#define BIZ_BYDKI   (128)
#define BIZ_GS_LV7  (129)


#define BIZ_AZS1 (59)
#define BIZ_AZS2 (60)
#define BIZ_AZS3 (61)
#define BIZ_AZS4 (62)
#define BIZ_AZS5 (63)
#define BIZ_AZS6 (64)
#define LV_AMYN1 (65)
#define LV_AMYN2 (66)
#define LV_AMYN3 (67)
#define LV_AMYN4 (68)
#define SPAWN_NONE  	(0)
#define SPAWN_HOUSE 	(1)
#define MAX_EATCP 3
#define MAX_TELEPORTS   (84)
#define MAX_BANS        (50)
#define NONE_3D_TEXT (Text3D:-1)
#define D_BUY_VIP       (0)
#define D_BUY_GOLD 		(1)
#define D_BUY_MONEY 	(2)
#define D_BUY_PHONE 	(3)
#define D_BUY_WARN 		(4)
#define D_BUY_SKILL 	(5)
//#define D_BUY_SKATE 	(6)
#define D_BUY_NAME 		(6)
#define D_BUY_EXP 		(7)
#define D_BUY_UNBL 		(8)
#define D_BUY_ZKP 		(9)
#define D_BUY_PLATIN 	(10)
#define D_BUY_NARKO 	(11)
#define MOBILE_CORDS    0.0, 0.0, 0.0, 0.0, 0.0, 0.0

#define TEAM_NONE       (0)
#define TEAM_LSPD 		(1)
#define TEAM_LVPD 		(2)
#define TEAM_FBI 		(3)
#define TEAM_SFPD		(4)
#define TEAM_M4C 		(5)
#define TEAM_MERIALS 	(6)
#define TEAM_ARMYLV 	(7)
#define TEAM_MERIALV 	(8)
#define TEAM_LICENSERS 	(9)
#define TEAM_RADIO 		(10)
#define TEAM_GROOVE 	(11)
#define TEAM_VAGOS 		(12)
#define TEAM_BALLAS 	(13)
#define TEAM_CORONOS 	(14)
#define TEAM_RIFA 		(15)
#define TEAM_RM 		(16)
#define TEAM_YAKUZA 	(17)
#define TEAM_LCN 		(18)
#define TEAM_BIKERS 	(19)
#define TEAM_ARMY		(20)
#define TEAM_BANK		(21)
#define TEAM_MEDICLV	(22)
#define TEAM_PDLV 		(23)
#define TEAM_RADIOLV 	(24)
#define TEAM_WOLFS 		(25)
#define TEAM_RADIOSF 	(26)
#define TEAM_ARMYSF 	(27)
#define TEAM_TSR 		(28)

#define RES_CAR_TIME    (600)
#define BUY_MENU_PRODUCTS 	"Предмет\tСтоимость\t\nЧипсы\t{52A32A}$400{FFFFFF}\nСпранк\t{52A32A}$100{FFFFFF}\nПиво\t{52A32A}$300{FFFFFF}"
#define BUY_MENU_CHANCERY 	"Предмет\tСтоимость\t\nТелефонная книга\t{52A32A}$650{FFFFFF}\nСкрепки\t{52A32A}$90{FFFFFF}"
#define BUY_MENU_ACCSESSORY	"Предмет\tСтоимость\t\nМаска\t{52A32A}$600{FFFFFF}"
#define BUY_MENU_TEXNIKA    "Предмет\tСтоимость\t\nМобильный телефон\t{52A32A}$700{FFFFFF}\nРадио\t{52A32A}$400{FFFFFF}\nФотоаппарат\t{52A32A}$100{FFFFFF}\nСим-карта\t{52A32A}$400{FFFFFF}"
#define BUY_MENU_SMOKE      "Предмет\tСтоимость\t\nСигареты\nЗажигалки"
#define BUY_MENU_FISHED     "Предмет\tСтоимость\t\nУдочка\t{52A32A}$500{FFFFFF}\nЧерви\t{52A32A}$20{FFFFFF}"
#define BUY_MENU_MEHAN      "Предмет\tСтоимость\t\nЛопата\t{52A32A}$700{FFFFFF}\nНабор для починки\t{52A32A}$1500{FFFFFF}\nКанистра\t{52A32A}$1500{FFFFFF}\nБалончик с краской\t{52A32A}$1500{FFFFFF}\nБензопила\t{52A32A}$2000{FFFFFF}"
#define BUY_MENU_SMOKES2    "Предмет\tСтоимость\t\nLM\t{52A32A}$100{FFFFFF}\nBOND\t{52A32A}$100{FFFFFF}\nРусский Стиль\t{52A32A}$100{FFFFFF}\nKent\t{52A32A}$100{FFFFFF}\nОптима\t{52A32A}$100{FFFFFF}\nChesterfield\t{52A32A}$200{FFFFFF}\nMarllboro\t{52A32A}$200{FFFFFF}\nParlament\t{52A32A}$200{FFFFFF}\nСигары\t{52A32A}$500{FFFFFF}\nПрима без фильтра\t{52A32A}$100{FFFFFF}\nБеломор канал\t{52A32A}$100"
#define BUY_MENU_LIGHTS2    "Предмет\tСтоимость\t\nАвтогеновая\t{52A32A}$200{FFFFFF}\nZippo\t{52A32A}$300{FFFFFF}\nCricket\t{52A32A}$100{FFFFFF}"
#define GRAND_BUY_MENU_TEXT "{52A32A}-{FFFFFF} Продукты\n{52A32A}-{FFFFFF} Канцелярия\n{52A32A}-{FFFFFF} Аксессуары\n{52A32A}-{FFFFFF} Техника\n{52A32A}-{FFFFFF} Сигареты & Зажигалки\n{52A32A}-{FFFFFF} Рыбалка\n{52A32A}-{FFFFFF} Разное"
#define KEY_HORN 				(2)
#define KEY_ACCELERATE 			(8)
#define KEY_ACTION_WALK 		(9)
#define KEY_FIRE_ACCELERATE 	(12)
#define KEY_EXIT_VEHICLE 		(16)
#define KEY_BRAKE 				(32)
#define KEY_FIRE_BRAKE 			(36)
#define KEY_SPRINT_JUMP 		(40)
#define KEY_SPRINT_LEFT        (-120)
#define KEY_SPRINT_RIGHT        (136)
#define KEY_AIM                 (128)
#define KEY_AIM_FIRE 			(132)
#define KEY_AIM_BRAKE 			(136)
#define KEY_LOOK_BEHIND_V 		(320)
#define KEY_LOOK_BEHIND_AIM 	(640)
#define KEY_WALK_AIM 			(1152)
#define KEY_FIRE_ANALOG_LEFT 	(8196)
#define KEY_AIM_ANALOG_LEFT 	(8320)
#define KEY_NUM4				(8192)
#define KEY_WALK_ANALOG_LEFT 	(9216)
#define KEY_NUM6 				(16384)
#define KEY_FIRE_ANALOG_RIGHT 	(16388)
#define KEY_AIM_ANALOG_RIGHT 	(16512)
#define KEY_WALK_ANALOG_RIGHT 	(17408)
#define CLICK_STATE_NONE 	 (-1)
#define CLICK_STATE_PAY      (0)
#define CLICK_STATE_MATS   	 (1)
#define CLICK_STATE_DRUGS  	 (2)
#define CLICK_STATE_SIGS  	 (3)
#define CLICK_STATE_CHEEPS 	 (4)
#define CLICK_STATE_SPRUNK 	 (5)
#define CLICK_STATE_BEER 	 (6)
#define CLICK_STATE_GOLD 	 (7)
#define CLICK_STATE_SYRINGE  (8)
#define CLICK_STATE_POISON 	 (9)
#define CLICK_STATE_CLIP     (10)
#define CLICK_STATE_WORMS    (11)
#define CLICK_STATE_WHISPER  (12)
#define CLICK_STATE_AUDIOMSG (13)
#define CLICK_STATE_BRON (14)
#define CLICK_STATE_NARKOZ (15)
#define ArendCars 197
#define AREND_DIALOG 230
#define B_AMO 	(0)
#define B_BAR 		(1)
#define B_BUY 		(2)
#define B_BINKO 	(3)
#define B_ELECTRO 	(4)
#define B_CARUPGR 	(5)
#define B_GAS 		(6)
#define B_CL_BELL 	(7)
#define B_RENTCAR 	(8)
#define B_AB        (10)
#define SEK_MC 	1000
#define MIN_SEC 60
#define MAX_BARSs 8
#define SCRAP_POS_X   	2224.5222
#define SCRAP_POS_Y   	-2461.0154
#define SCRAP_POS_Z   	13.4466
#define MAX_AFK_TIME 	(300)
#define BARRIER_SPEED 	0.015
#define D_STATE_NORMAL  	(0)
#define D_STATE_CUFFED  	(1)
#define D_STATE_TEMPCUFF	(2)
#define D_STATE_KNOCKOUT    (3)
#define D_STATE_TIED        (4)
#define MAX_PHOTOS 6
#define MAX_CPS 21
#define MAX_RADIOS 10
#define INC_CPs 22
#define Pizza_CPs 13
#define MAX_GUNS (sizeof(BuyGunInfo)-1)

new object[MAX_OGRAD] ={-1,...};
new dmats[MAX_DMATS] ={-1,...};
new dguns[MAX_DGUNS] ={-1,...};
new dpatrons[MAX_DGUNS]={-1,...};
new dgunn[MAX_DGUNS]={-1,...};

new ddTimer[MAX_NARKO]={-1,...};
new ddrugs[MAX_NARKO] ={-1,...};
new Text3D:ddText[MAX_NARKO];
new ddrugtime[MAX_NARKO];

new Timerak[MAX_PLAYERS];
new dguntime[MAX_DGUNS];
new Text3D:tActor[MAX_ACTORSS];
forward SpawnCar(playerid);
forward Raskraska(playerid);
forward CloseGate(gate);
forward checkGM(playerid);
forward reofff(playerid);
forward PlKick(playerid);
forward MoveTarget(playerid);
forward DestroyTarget(playerid, tirid, succes);
forward GateClose(gate);
forward BarrierClose(barrier);
forward MailResponse(index, response_code, data[]);//mailsend
forward PlayerSpawn(playerid);
forward PlayerPos(playerid,Float:X,Float:Y,Float:Z);
forward OnPlayerRegister(playerid,password[]);
forward SaveAccount2(playerid);
forward OnPlayerLogin(playerid);
forward J_SetPlayerArmour(playerid,Float:armour);
forward GrandTimer();
forward Fillup(playerid,carid,Float:gas);
forward CheckTazer(playerid, target);
forward EngineVehicle(playerid,vehicleid);
forward PlayerRemovePhone(playerid, code);
forward ModCar(carid);
forward PlayerFishing(playerid);
forward OnDeathEffectStarted(playerid, drawstate);
forward OnDeathEffectFinished(playerid, drawstate);
forward SetBuyGunCamera(playerid);
forward CreateGate(gateid);
forward CreatedMats(playerid);
forward ChangeInterior(playerid);
forward ChangeInteriorGarage(playerid);
forward ChangeInteriorPodval(playerid);
forward DeathPlayer(playerid);
forward ExitIntroTaxi(playerid);
forward PlayerDeathed(playerid, code);
forward TalkWithTaxist(playerid, status);
forward IntroTaxi(playerid);
forward HidePlayerHelpDraw(playerid);
forward ReloadAllAnims(playerid);
forward UpdateSleep(playerid);
forward Float:PointToPoint(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2);
forward TestFunction();
forward J_ApplyAnimation(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync);
forward DestroyTempStrip(strip, carid);
forward PlayerUnStrip(playerid);
forward ClearAnims(playerid);
forward PlayFerumSound(playerid);
//forward SellPlayerGun(playerid,forplayerid);
forward BuyTeamCar(playerid);
forward PlayerDrink(playerid);
forward ExitPhotoPlace(playerid);
forward OnPlayerSnapShot(playerid);
forward RemovingObject(musor, carid, playerid);
forward StopMusor(objectid);
forward SetDamage(playerid, issuerid, Float:damage);
forward ResCar();
forward Obnova();
forward VkCoins();
//
enum musorInfo
{
	IDSAX,
	Float:mPos_X,
	Float:mPos_Y,
	Float:mPos_Z,
	Float:mPos_A,
	InventoryTrash[30],
	InventoryTrashKolvo[30]
};
new mInfo[MAX_MUSORS][musorInfo];
new VehicleName[212][25] = {
	"Landstalker",
	"Bravura",
	"Buffalo",
	"Linerunner",
	"Perenniel",
	"Sentinel",
	"Dumper",
	"Firetruck",
	"Trashmaster",
	"Stretch",
	"Manana",
	"Infernus",
	"Voodoo",
	"Pony",
	"Mule",
	"Cheetah",
	"Ambulance",
	"Leviathan",
	"Moonbeam",
	"Esperanto",
	"Taxi",
	"Washington",
	"Bobcat",
	"Mr Whoopee",
	"BF Injection",
	"Hunter",
	"Premier",
	"Enforcer",
	"Securicar",
	"Banshee",
	"Predator",
	"Bus",
	"Rhino",
	"Barracks",
	"Hotknife",
	"Article Trailer",
	"Previon",
	"Coach",
	"Cabbie",
	"Stallion",
	"Rumpo",
	"RC Bandit",
	"Romero",
	"Packer",
	"Monster",
	"Admiral",
	"Squallo",
	"Seasparrow",
	"Pizzaboy",
	"Tram",
	"Article Trailer 2",
	"Turismo",
	"Speeder",
	"Reefer",
	"Tropic",
	"Flatbed",
	"Name",
	"Caddy",
	"Solair",
	"Berkley's RC Van",
	"Skimmer",
	"PCJ-600",
	"Faggio",
	"Freeway",
	"RC Baron",
	"RC Raider",
	"Glendale",
	"Oceanic",
	"Sanchez",
	"Sparrow",
	"Patriot",
	"Quad",
	"Coastguard",
	"Dinghy",
	"Hermes",
	"Sabre",
	"Rustler",
	"ZR-350",
	"Walton",
	"Regina",
	"Comet",
	"BMX",
	"Burrito",
	"Camper",
	"Marquis",
	"Baggage",
	"Dozer",
	"Maverick",
	"SAN News Maverick",
	"Rancher",
	"FBI Rancher",
	"Virgo",
	"Greenwood",
	"Jetmax",
	"Hotring Racer",
	"Sandking",
	"Blista Compact",
	"Police Maverick",
	"Boxville",
	"Benson",
	"Mesa",
	"RC Goblin",
	"Hotring Racer",
	"Hotring Racer",
	"Bloodring Banger",
	"Rancher",
	"Super GT",
	"Elegant",
	"Journey",
	"Bike",
	"Mountain Bike",
	"Beagle",
	"Cropduster",
	"Stuntplane",
	"Tanker",
	"Roadtrain",
	"Nebula",
	"Majestic",
	"Buccaneer",
	"Shamal",
	"Hydra",
	"FCR-900",
	"NRG-500",
	"HPV1000",
	"Cement Truck",
	"Towtruck",
	"Fortune",
	"Cadrona",
	"FBI Truck",
	"Willard",
	"Forklift",
	"Tractor",
	"Combine Harvester",
	"Feltzer",
	"Remington",
	"Slamvan",
	"Blade",
	"Freight",
	"Brownstreak",
	"Vortex",
	"Vincent",
	"Bullet",
	"Clover",
	"Sadler",
	"Firetruck LA",
	"Hustler",
	"Intruder",
	"Primo",
	"Cargobob",
	"Tampa",
	"Sunrise",
	"Merit",
	"Utility Van",
	"Nevada",
	"Yosemite",
	"Windsor",
	"Monster A",
	"Monster B",
	"Uranus",
	"Jester",
	"Sultan",
	"Stratum",
	"Elegy",
	"Raindance",
	"RC Tiger",
	"Flash",
	"Tahoma",
	"Savanna",
	"Bandito",
	"Freight Flat Trailer",
	"Streak Trailer",
	"Kart",
	"Mower",
	"Dune",
	"Sweeper",
	"Broadway",
	"Tornado",
	"AT400",
	"DFT-30",
	"Huntley",
	"Stafford",
	"BF-400",
	"Newsvan",
	"Tug",
	"Petrol Trailer",
	"Emperor",
	"Wayfarer",
	"Euros",
	"Hotdog",
	"Club",
	"Freight Box Trailer",
	"Article Trailer 3",
	"Andromada",
	"Dodo",
	"RC Cam",
	"Launch",
	"Police Car (LSPD)",
	"Police Car (SFPD)",
	"Police Car (LVPD)",
	"Police Ranger",
	"Picador",
	"Police SF.",
	"Alpha",
	"Phoenix",
	"Glendale Shit",
	"Sadler Shit",
	"Baggage Trailer A",
	"Baggage Trailer B",
	"Tug Stairs Trailer",
	"Boxville",
	"Farm Trailer",
	"Utility Trailer"
};
new PlayerText:CraftSuper[MAX_PLAYERS][54];
new PlayerText:Craftgovnishe[MAX_PLAYERS][28];
new besttimer[MAX_PLAYERS];
new govnotimer4[MAX_PLAYERS];
new govnotimer[MAX_PLAYERS];
new PlayerText:TDinv2[MAX_PLAYERS][2];
new ObjectRemoved[MAX_PLAYERS];
new PlayerText:TDinv[MAX_PLAYERS][7];
new PlayerText:pizdecpolniy[MAX_PLAYERS][27];
new PlayerText:TDinvTrash[MAX_PLAYERS][4];
new CheckAHK[MAX_PLAYERS];
new xyitime[MAX_PLAYERS];
new QuestDone[MAX_PLAYERS];
new carquest1[MAX_PLAYERS];
new carquest2[MAX_PLAYERS];
new carquest3[MAX_PLAYERS];
new carquest4[MAX_PLAYERS];
new carrazgruzka[MAX_PLAYERS];
//
new Text:HInfoEnterDraw;
new Text:HInfoBuyDraw;
new Text:HInfoBG;
new PlayerText:NewRoulette[MAX_PLAYERS][43];
new PlayerText:NewRouletteKletki[MAX_PLAYERS][32];
new PickInvent[MAX_PLAYERS];
new PlayerText:InvTextDraws[MAX_PLAYERS][63];
new PlayerText:Govnishe[MAX_PLAYERS][72];
new PlayerText:GovnisheKletki[MAX_PLAYERS][72];
new PlayerText:fstd_p[MAX_PLAYERS][7];
new PlayerText:InfoItems[MAX_PLAYERS][6];
new PlayerText:dropmenu[MAX_PLAYERS][8];
enum ItemInfo2
{
    ItemModel,
};
enum SalonInfo
{
	Float:SalonPosX,
	Float:SalonPosY,
	Float:SalonPosZ,
	NameSalon[19],
	CostSalon[11],
};
new SalonsInfo[3][SalonInfo] = {
	{-2666.6094, 12.2091, 4.3339, "Автосалон люкс", "5000000000"},//sf
	{972.9423,2089.5410,10.8429, "Автосалон средний", "4000000000"},//lv
	{-479.4627,-542.7598,25.5634, "Автосалон эконом", "3000000000"}//ls
};
enum ItemInfo
{
    ItemModel,//модель
    bool:itemused,//можно ли использовать
    ItemQuantity,//макс значение в стеке
    ItemPhoneColor[25],//для одинаковых моделей
	ItemUse[8],
	ItemUseRus[16],
	ItemAksColor,
    ItemColor,//цвет модели
    NameItemLavka[50],//для центр рынка
    ItemName2[50],//отдельное имя предмета
    ItemName[70],//имя предмета
	ItemInfos[500],//инфо о предмете
    Float:POSTDx,
    Float:POSTDy,
    Float:POSTDz,
    Float:POSTDc
};
#define MAX_ITEMS 614
new ItemsInfo[MAX_ITEMS][ItemInfo] = {
    {1649, false, 0, "", "N", "N", 0x333333FF, 0x333333FF, "Kletka", "Пусто", "Пусто", "", 0.000000, 0.000000, 90.000000, 2.000000},//клетка
    {1, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: The Truth (ID:1)", "{FDCF28}Скин: The Truth (ID:1)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{2, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Maccer (ID:2)", "{FDCF28}Скин: Maccer (ID:2)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{3, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Andre (ID:3)", "{FDCF28}Скин: Andre (ID:3)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{4, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Barry ''Big Bear'' Thorne [Thin] (ID:4)", "{FDCF28}Скин: Barry ''Big Bear'' Thorne [Thin] (ID:4)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{5, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Barry ''Big Bear'' Thorne [Big] (ID:5)", "{FDCF28}Скин: Barry ''Big Bear'' Thorne [Big] (ID:5)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{6, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Emmet (ID:6)", "{FDCF28}Скин: Emmet (ID:6)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{7, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Taxi Driver/Train Driver (ID:7)", "{FDCF28}Скин: Taxi Driver/Train Driver (ID:7)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{8, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Janitor (ID:8)", "{FDCF28}Скин: Janitor (ID:8)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{9, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:9)", "{FDCF28}Скин: Normal Ped (ID:9)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{10, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Old Woman (ID:10)", "{FDCF28}Скин: Old Woman (ID:10)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{11, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Casino croupier (ID:11)", "{FDCF28}Скин: Casino croupier (ID:11)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{12, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Rich Woman (ID:12)", "{FDCF28}Скин: Rich Woman (ID:12)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{13, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Street Girl (ID:13)", "{FDCF28}Скин: Street Girl (ID:13)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{14, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:14)", "{FDCF28}Скин: Normal Ped (ID:14)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{15, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Mr.Whittaker (RS Haul Owner) (ID:15)", "{FDCF28}Скин: Mr.Whittaker (RS Haul Owner) (ID:15)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{16, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Airport Ground Worker (ID:16)", "{FDCF28}Скин: Airport Ground Worker (ID:16)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{17, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Businessman (ID:17)", "{FDCF28}Скин: Businessman (ID:17)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{18, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Beach Visitor (ID:18)", "{FDCF28}Скин: Beach Visitor (ID:18)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{19, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: DJ (ID:19)", "{FDCF28}Скин: DJ (ID:19)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{20, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Rich Guy (Madd Dogg's Manager) (ID:20)", "{FDCF28}Скин: Rich Guy (Madd Dogg's Manager) (ID:20)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{21, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:21)", "{FDCF28}Скин: Normal Ped (ID:21)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{22, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:22)", "{FDCF28}Скин: Normal Ped (ID:22)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{23, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: BMXer (ID:23)", "{FDCF28}Скин: BMXer (ID:23)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{24, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin",  "Скин Madd Dogg Bodyguard: (ID:24)", "{FDCF28}Скин: Madd Dogg Bodyguard (ID:24)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{25, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Madd Dogg Bodyguard (ID:25)", "{FDCF28}Скин: Madd Dogg Bodyguard (ID:25)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{26, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Backpacker (ID:26)", "{FDCF28}Скин: Backpacker (ID:26)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{27, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Скин: Construction Worker (ID:27)", "{FDCF28}Скин: Construction Worker (ID:27)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{28, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Drug Dealer (ID:28)", "{FDCF28}Скин: Drug Dealer (ID:28)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{29, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Drug Dealer (ID:29)", "{FDCF28}Скин: Drug Dealer (ID:29)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{30, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Drug Dealer (ID:30)", "{FDCF28}Скин: Drug Dealer (ID:30)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{31, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Farm-Town inhabitant (ID:31)", "{FDCF28}Скин: Farm-Town inhabitant (ID:31)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{32, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Farm-Town inhabitant (ID:32)", "{FDCF28}Скин: Farm-Town inhabitant (ID:32)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{33, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Farm-Town inhabitant (ID:33)", "{FDCF28}Скин: Farm-Town inhabitant (ID:33)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{34, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Farm-Town inhabitant (ID:34)", "{FDCF28}Скин: Farm-Town inhabitant (ID:34)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{35, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Gardener (ID:35)", "{FDCF28}Скин: Gardener (ID:35)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{36, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Golfer (ID:36)", "{FDCF28}Скин: Golfer (ID:36)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{37, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Golfer (ID:37)", "{FDCF28}Скин: Golfer (ID:37)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{38, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:38)", "{FDCF28}Скин: Normal Ped (ID:38)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{39, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:39)", "{FDCF28}Скин: Normal Ped (ID:39)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{40, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:40)", "{FDCF28}Скин: Normal Ped (ID:40)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{41, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:41)", "{FDCF28}Скин: Normal Ped (ID:41)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{42, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Jethro (ID:42)", "{FDCF28}Скин: Jethro (ID:42)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{43, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:43)", "{FDCF28}Скин: Normal Ped (ID:43)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{44, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:44)", "{FDCF28}Скин: Normal Ped (ID:44)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{45, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Beach Visitor (ID:45)", "{FDCF28}Скин: Beach Visitor (ID:45)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{46, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:46)", "{FDCF28}Скин: Normal Ped (ID:46)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{47, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:47)", "{FDCF28}Скин: Normal Ped (ID:47)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{48, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:48)", "{FDCF28}Скин: Normal Ped (ID:48)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{49, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Snakehead (Da Nang) (ID:49)", "{FDCF28}Скин: Snakehead (Da Nang) (ID:49)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{50, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Mechanic (ID:50)", "{FDCF28}Скин: Mechanic (ID:50)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{51, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Mountain Biker (ID:51)", "{FDCF28}Скин: Mountain Biker (ID:51)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{52, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Mountain Biker (ID:52)", "{FDCF28}Скин: Mountain Biker (ID:52)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{53, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Unknown (ID:53)", "{FDCF28}Скин: Unknown (ID:53)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{54, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:54)", "{FDCF28}Скин: Normal Ped (ID:54)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{55, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:55)", "{FDCF28}Скин: Normal Ped (ID:55)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{56, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:56)", "{FDCF28}Скин: Normal Ped (ID:56)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{57, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Oriental Ped (ID:57)", "{FDCF28}Скин: Oriental Ped (ID:57)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{58, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Oriental Ped (ID:58)", "{FDCF28}Скин: Oriental Ped (ID:58)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{59, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:59)", "{FDCF28}Скин: Normal Ped (ID:59)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{60, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:60)", "{FDCF28}Скин: Normal Ped (ID:60)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{61, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Pilot (ID:61)", "{FDCF28}Скин: Pilot (ID:61)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{62, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Colonel Fuhrberger (ID:62)", "{FDCF28}Скин: Colonel Fuhrberger (ID:62)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{63, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Prostitute (ID:63)", "{FDCF28}Скин: Prostitute (ID:63)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{64, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Prostitute (ID:64)", "{FDCF28}Скин: Prostitute (ID:64)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{65, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Kendl Johnson (ID:65)", "{FDCF28}Скин: Kendl Johnson (ID:65)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{66, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Pool Player (ID:66)", "{FDCF28}Скин: Pool Player (ID:66)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{67, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Pool Player (ID:67)", "{FDCF28}Скин: Pool Player (ID:67)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{68, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Priest/Preacher (ID:68)", "{FDCF28}Скин: Priest/Preacher (ID:68)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{69, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:69)", "{FDCF28}Скин: Normal Ped (ID:69)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{70, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Scientist (ID:70)", "{FDCF28}Скин: Scientist (ID:70)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{71, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Security Guard (ID:71)", "{FDCF28}Скин: Security Guard (ID:71)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{72, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Hippy (ID:72)", "{FDCF28}Скин: Hippy (ID:72)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{73, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Hippy (ID:73)", "{FDCF28}Скин: Hippy (ID:73)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{74, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Unknown (ID:74)", "{FDCF28}Скин: Unknown (ID:74)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{75, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Prostitute (ID:75)", "{FDCF28}Скин: Prostitute (ID:75)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{76, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:76)", "{FDCF28}Скин: Normal Ped (ID:76)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{77, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Homeless (ID:77)", "{FDCF28}Скин: Homeless (ID:77)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{78, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Homeless  (ID:78)", "{FDCF28}Скин: Homeless (ID:78)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{79, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Homeless (ID:79)", "{FDCF28}Скин: Homeless (ID:79)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{80, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Boxer (ID:80)", "{FDCF28}Скин: Boxer (ID:80)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{81, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Boxer (ID:81)", "{FDCF28}Скин: Boxer (ID:81)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{82, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Black Elvis (ID:82)", "{FDCF28}Скин: Black Elvis (ID:82)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{83, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: White Elvis (ID:83)", "{FDCF28}Скин: White Elvis (ID:83)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{84, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Blue Elvis (ID:84)", "{FDCF28}Скин: Blue Elvis (ID:84)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{85, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Prostitute (ID:85)", "{FDCF28}Скин: Prostitute (ID:85)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{86, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Ryder with robbery mask (ID:86)", "{FDCF28}Скин: Ryder with robbery mask (ID:86)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{87, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Stripper (ID:87)", "{FDCF28}Скин: Stripper (ID:87)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{88, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:88)", "{FDCF28}Скин: Normal Ped (ID:88)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{89, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:89)", "{FDCF28}Скин: Normal Ped (ID:89)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{90, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Jogger (ID:90)", "{FDCF28}Скин: Jogger (ID:90)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{91, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Rich Woman (ID:91)", "{FDCF28}Скин: Rich Woman (ID:91)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{92, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Rollerskater (ID:92)", "{FDCF28}Скин: Rollerskater (ID:92)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{93, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:93)", "{FDCF28}Скин: Normal Ped (ID:93)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{94, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:94)", "{FDCF28}Скин: Normal Ped (ID:94)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{95, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:95)", "{FDCF28}Скин: Normal Ped (ID:95)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{96, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Jogger (ID:96)", "{FDCF28}Скин: Jogger (ID:95)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{97, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Lifeguard (ID:97)", "{FDCF28}Скин: Lifeguard (ID:97)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{98, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Normal Ped (ID:98)", "{FDCF28}Скин: Normal Ped (ID:98)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{99, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Rollerskater (ID:99)", "{FDCF28}Скин: Rollerskater (ID:99)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{100, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Biker (ID:100)", "{FDCF28}Скин: Biker (ID:100)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{101, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:101)", "{FDCF28}Скин:  (ID:101)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{102, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:102)", "{FDCF28}Скин:  (ID:102)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{103, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:103)", "{FDCF28}Скин:  (ID:103)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{104, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:104)", "{FDCF28}Скин:  (ID:104)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{105, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:105)", "{FDCF28}Скин:  (ID:105)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{106, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:106)", "{FDCF28}Скин:  (ID:106)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{107, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:107)", "{FDCF28}Скин:  (ID:107)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{108, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:108)", "{FDCF28}Скин:  (ID:108)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{109, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:109)", "{FDCF28}Скин:  (ID:109)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{110, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:110)", "{FDCF28}Скин:  (ID:110)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{111, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:111)", "{FDCF28}Скин:  (ID:111)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{112, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:112)", "{FDCF28}Скин:  (ID:112)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{113, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:113)", "{FDCF28}Скин:  (ID:113)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{114, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:114)", "{FDCF28}Скин:  (ID:114)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{115, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:115)", "{FDCF28}Скин:  (ID:115)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{116, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:116)", "{FDCF28}Скин:  (ID:116)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{117, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:117)", "{FDCF28}Скин:  (ID:117)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{118, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:118)", "{FDCF28}Скин:  (ID:118)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{119, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:119)", "{FDCF28}Скин:  (ID:119)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{120, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:120)", "{FDCF28}Скин:  (ID:120)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{121, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:121)", "{FDCF28}Скин:  (ID:121)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{122, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:122)", "{FDCF28}Скин:  (ID:122)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{123, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:123)", "{FDCF28}Скин:  (ID:123)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{124, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:124)", "{FDCF28}Скин:  (ID:124)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{125, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:125)", "{FDCF28}Скин:  (ID:125)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{126, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:126)", "{FDCF28}Скин:  (ID:126)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{127, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:127)", "{FDCF28}Скин:  (ID:127)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{128, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:128)", "{FDCF28}Скин:  (ID:128)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{129, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:129)", "{FDCF28}Скин:  (ID:129)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{130, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:130)", "{FDCF28}Скин:  (ID:130)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{131, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:131)", "{FDCF28}Скин:  (ID:131)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{132, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:132)", "{FDCF28}Скин:  (ID:132)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{133, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:133)", "{FDCF28}Скин:  (ID:133)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{134, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:134)", "{FDCF28}Скин:  (ID:134)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{135, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:135)", "{FDCF28}Скин:  (ID:135)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{136, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:136)", "{FDCF28}Скин:  (ID:136)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{137, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:137)", "{FDCF28}Скин:  (ID:137)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{138, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:138)", "{FDCF28}Скин:  (ID:138)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{139, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:139)", "{FDCF28}Скин:  (ID:139)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{140, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:140)", "{FDCF28}Скин:  (ID:140)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{141, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:141)", "{FDCF28}Скин:  (ID:141)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{142, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:142)", "{FDCF28}Скин:  (ID:142)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{143, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:143)", "{FDCF28}Скин:  (ID:143)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{144, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:144)", "{FDCF28}Скин:  (ID:144)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{145, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:145)", "{FDCF28}Скин:  (ID:145)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{146, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:146)", "{FDCF28}Скин:  (ID:146)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{147, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:147)", "{FDCF28}Скин:  (ID:147)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{148, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:148)", "{FDCF28}Скин:  (ID:148)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{149, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:149)", "{FDCF28}Скин:  (ID:149)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{150, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:150)", "{FDCF28}Скин:  (ID:150)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{151, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:151)", "{FDCF28}Скин:  (ID:151)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{152, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:152)", "{FDCF28}Скин:  (ID:152)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{153, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:153)", "{FDCF28}Скин:  (ID:153)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{154, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:154)", "{FDCF28}Скин:  (ID:154)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{155, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:155)", "{FDCF28}Скин:  (ID:155)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{156, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:156)", "{FDCF28}Скин:  (ID:156)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{157, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:157)", "{FDCF28}Скин:  (ID:157)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{158, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:158)", "{FDCF28}Скин:  (ID:158)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{159, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:159)", "{FDCF28}Скин:  (ID:159)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{160, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:160)", "{FDCF28}Скин:  (ID:160)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{161, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:161)", "{FDCF28}Скин:  (ID:161)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{162, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:162)", "{FDCF28}Скин:  (ID:162)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{163, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:163)", "{FDCF28}Скин:  (ID:163)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{164, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:164)", "{FDCF28}Скин:  (ID:164)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{165, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:165)", "{FDCF28}Скин:  (ID:165)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{166, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:166)", "{FDCF28}Скин:  (ID:166)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{167, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:167)", "{FDCF28}Скин:  (ID:167)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{168, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:168)", "{FDCF28}Скин:  (ID:168)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{169, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:169)", "{FDCF28}Скин:  (ID:169)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{170, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:170)", "{FDCF28}Скин:  (ID:170)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{171, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:171)", "{FDCF28}Скин:  (ID:171)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{172, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:172)", "{FDCF28}Скин:  (ID:172)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{173, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:173)", "{FDCF28}Скин:  (ID:173)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{174, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:174)", "{FDCF28}Скин:  (ID:174)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{175, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:175)", "{FDCF28}Скин:  (ID:175)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{176, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:176)", "{FDCF28}Скин:  (ID:176)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{177, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:177)", "{FDCF28}Скин:  (ID:177)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{178, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:178)", "{FDCF28}Скин:  (ID:178)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{179, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:179)", "{FDCF28}Скин:  (ID:179)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{180, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:180)", "{FDCF28}Скин:  (ID:180)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{181, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:181)", "{FDCF28}Скин:  (ID:181)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{182, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:182)", "{FDCF28}Скин:  (ID:182)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{183, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:183)", "{FDCF28}Скин:  (ID:183)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{184, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:184)", "{FDCF28}Скин:  (ID:184)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{185, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:185)", "{FDCF28}Скин:  (ID:185)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{186, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:186)", "{FDCF28}Скин:  (ID:186)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{187, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:187)", "{FDCF28}Скин:  (ID:187)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{188, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:188)", "{FDCF28}Скин:  (ID:188)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{189, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:189)", "{FDCF28}Скин:  (ID:189)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{190, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:190)", "{FDCF28}Скин:  (ID:190)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{191, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:191)", "{FDCF28}Скин:  (ID:191)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{192, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:192)", "{FDCF28}Скин:  (ID:192)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{193, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:193)", "{FDCF28}Скин:  (ID:193)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{194, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:194)", "{FDCF28}Скин:  (ID:194)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{195, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:195)", "{FDCF28}Скин:  (ID:195)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{196, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:196)", "{FDCF28}Скин:  (ID:196)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{197, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:197)", "{FDCF28}Скин:  (ID:197)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{198, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:198)", "{FDCF28}Скин:  (ID:198)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{199, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:199)", "{FDCF28}Скин:  (ID:199)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{200, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:200)", "{FDCF28}Скин:  (ID:200)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{201, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:201)", "{FDCF28}Скин:  (ID:201)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{202, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:202)", "{FDCF28}Скин:  (ID:202)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{203, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:203)", "{FDCF28}Скин:  (ID:203)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{204, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:204)", "{FDCF28}Скин:  (ID:204)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{205, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:205)", "{FDCF28}Скин:  (ID:205)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{206, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:206)", "{FDCF28}Скин:  (ID:206)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{207, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:207)", "{FDCF28}Скин:  (ID:207)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{208, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:208)", "{FDCF28}Скин:  (ID:208)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{209, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:209)", "{FDCF28}Скин:  (ID:209)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{210, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:210)", "{FDCF28}Скин:  (ID:210)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{211, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:211)", "{FDCF28}Скин:  (ID:211)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{212, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:212)", "{FDCF28}Скин:  (ID:212)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{213, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:213)", "{FDCF28}Скин:  (ID:213)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{214, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:214)", "{FDCF28}Скин:  (ID:214)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{215, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:215)", "{FDCF28}Скин:  (ID:215)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{216, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:216)", "{FDCF28}Скин:  (ID:216)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{217, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:217)", "{FDCF28}Скин:  (ID:217)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{218, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:218)", "{FDCF28}Скин:  (ID:218)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{219, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:219)", "{FDCF28}Скин:  (ID:219)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{220, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:220)", "{FDCF28}Скин:  (ID:220)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{221, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:221)", "{FDCF28}Скин:  (ID:221)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{222, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:222)", "{FDCF28}Скин:  (ID:222)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{223, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:223)", "{FDCF28}Скин:  (ID:223)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{224, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:224)", "{FDCF28}Скин:  (ID:224)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{225, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:225)", "{FDCF28}Скин:  (ID:225)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{226, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:226)", "{FDCF28}Скин:  (ID:226)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{227, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:227)", "{FDCF28}Скин:  (ID:227)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{228, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:228)", "{FDCF28}Скин:  (ID:228)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{229, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:229)", "{FDCF28}Скин:  (ID:229)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{230, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: Homeless (ID:230)", "{FDCF28}Скин: Homeless (ID:230)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{231, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:231)", "{FDCF28}Скин:  (ID:231)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{232, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:232)", "{FDCF28}Скин:  (ID:232)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{233, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:233)", "{FDCF28}Скин:  (ID:233)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{234, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:234)", "{FDCF28}Скин:  (ID:234)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{235, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:235)", "{FDCF28}Скин:  (ID:235)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{236, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:236)", "{FDCF28}Скин:  (ID:236)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{237, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:237)", "{FDCF28}Скин:  (ID:237)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{238, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:238)", "{FDCF28}Скин:  (ID:238)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{239, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:239)", "{FDCF28}Скин:  (ID:239)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{240, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:240)", "{FDCF28}Скин:  (ID:240)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{241, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:241)", "{FDCF28}Скин:  (ID:241)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{242, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:242)", "{FDCF28}Скин:  (ID:242)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{243, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:243)", "{FDCF28}Скин:  (ID:243)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{244, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:244)", "{FDCF28}Скин:  (ID:244)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{245, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:245)", "{FDCF28}Скин:  (ID:245)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{246, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:246)", "{FDCF28}Скин:  (ID:246)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{247, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:247)", "{FDCF28}Скин:  (ID:247)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{248, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:248)", "{FDCF28}Скин:  (ID:248)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{249, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:249)", "{FDCF28}Скин:  (ID:249)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{250, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:250)", "{FDCF28}Скин:  (ID:250)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{251, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:251)", "{FDCF28}Скин:  (ID:251)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{252, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:252)", "{FDCF28}Скин:  (ID:252)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{253, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:253)", "{FDCF28}Скин:  (ID:253)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{254, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:254)", "{FDCF28}Скин:  (ID:254)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{255, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:255)", "{FDCF28}Скин:  (ID:255)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{256, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:256)", "{FDCF28}Скин:  (ID:256)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{257, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:257)", "{FDCF28}Скин:  (ID:257)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{258, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:258)", "{FDCF28}Скин:  (ID:258)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{259, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:259)", "{FDCF28}Скин:  (ID:259)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{260, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:260)", "{FDCF28}Скин:  (ID:260)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{261, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:261)", "{FDCF28}Скин:  (ID:261)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{262, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:262)", "{FDCF28}Скин:  (ID:262)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{263, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:263)", "{FDCF28}Скин:  (ID:263)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{264, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:264)", "{FDCF28}Скин:  (ID:264)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{265, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:265)", "{FDCF28}Скин:  (ID:265)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{266, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:266)", "{FDCF28}Скин:  (ID:266)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{267, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:267)", "{FDCF28}Скин:  (ID:267)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{268, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:268)", "{FDCF28}Скин:  (ID:268)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{269, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:269)", "{FDCF28}Скин:  (ID:269)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{270, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:270)", "{FDCF28}Скин:  (ID:270)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{271, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:271)", "{FDCF28}Скин:  (ID:271)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{272, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:272)", "{FDCF28}Скин:  (ID:272)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{273, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:273)", "{FDCF28}Скин:  (ID:273)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{274, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:274)", "{FDCF28}Скин:  (ID:274)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{275, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:275)", "{FDCF28}Скин:  (ID:275)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{276, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:276)", "{FDCF28}Скин:  (ID:276)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{277, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:277)", "{FDCF28}Скин:  (ID:277)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{278, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:278)", "{FDCF28}Скин:  (ID:278)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{279, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:279)", "{FDCF28}Скин:  (ID:279)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{280, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:280)", "{FDCF28}Скин:  (ID:280)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{281, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:281)", "{FDCF28}Скин:  (ID:281)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{282, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:282)", "{FDCF28}Скин:  (ID:282)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{283, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:283)", "{FDCF28}Скин:  (ID:283)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{284, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:284)", "{FDCF28}Скин:  (ID:284)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{285, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:285)", "{FDCF28}Скин:  (ID:285)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{286, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:286)", "{FDCF28}Скин:  (ID:286)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{287, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:287)", "{FDCF28}Скин:  (ID:287)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{288, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:288)", "{FDCF28}Скин:  (ID:288)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{289, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:289)", "{FDCF28}Скин:  (ID:289)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{290, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:290)", "{FDCF28}Скин:  (ID:290)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{291, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:291)", "{FDCF28}Скин:  (ID:291)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{292, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:292)", "{FDCF28}Скин:  (ID:292)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{293, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:293)", "{FDCF28}Скин:  (ID:293)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{294, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:294)", "{FDCF28}Скин:  (ID:294)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{295, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:295)", "{FDCF28}Скин:  (ID:295)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{296, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:296)", "{FDCF28}Скин:  (ID:296)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{297, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:297)", "{FDCF28}Скин:  (ID:297)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{298, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:298)", "{FDCF28}Скин:  (ID:298)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{299, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:299)", "{FDCF28}Скин:  (ID:299)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{300, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:300)", "{FDCF28}Скин:  (ID:300)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{301, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:301)", "{FDCF28}Скин:  (ID:301)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{302, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:302)", "{FDCF28}Скин:  (ID:302)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{303, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:303)", "{FDCF28}Скин:  (ID:303)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{304, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:304)", "{FDCF28}Скин:  (ID:304)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{305, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:305)", "{FDCF28}Скин:  (ID:305)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{306, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:306)", "{FDCF28}Скин:  (ID:306)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{307, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:307)", "{FDCF28}Скин:  (ID:307)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{308, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:308)", "{FDCF28}Скин:  (ID:308)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{309, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:309)", "{FDCF28}Скин:  (ID:309)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{310, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:310)", "{FDCF28}Скин:  (ID:310)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{311, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Skin", "Скин: (ID:311)", "{FDCF28}Скин:  (ID:311)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{18888, false, 0, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Skin", "Скин: ID(:)",  "Скин: (ID:20)", "{FFFFFF}Можно приобрести в магазине одежды,\nцентральном рынке, или с {FFD700}gold {FFFFFF}рулетки\nИспользуется для изменения внешнего\nвида персонажа. Можно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{19918, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Roulette Chest", "Сундук рулетки", "Предмет: {FDCF28}Сундук рулетки", "{FFFFFF}Выдается при регистрации на сервере. Нельзя продать, выкинуть, {FDCF28}обменять{ffffff}.\nМожно открывать каждые 10 минут игры в онлайне. При открытии вы можете получить\nзолотую или серебряную или бронзовую рулетки, которые можно крутить прямо в игре.", 161.000000, 174.000000, 126.000000, 1.225234},//сундук
    {11738, true,1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Aptechka", "Аптечка", "Предмет: {FDCF28}Аптечка", "{FFFFFF}Можно приобрести в магазине {FDCF28}24/7{FFFFFF},\nили на центральном рынке.\nПополняет здоровье на 100%\nМожно использовать.\nБыстрый доступ: {FDCF28}/usemed.", 0.000000, 351.000000, 180.000000, 1.100103},//аптечка
    {2663, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Cheeps", "Чипсы", "Предмет: {FDCF28}Чипсы", "{FFFFFF}Можно приобрести в магазине {FDCF28}24/7{FFFFFF},\nили на центральном рынке.\nВосстанавливает голод.\nМожно использовать.\nБыстрый доступ: {FDCF28}/eat.", 0.000000, 5.000000, 333.000000, 1.256517},//чипсы
    {1924, false, 10000000, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Fishki", "Фишки для казино", "Предмет: {FDCF28}Фишки для казино", "{FFFFFF}Можно получить в казино {FDCF28}4 Dragons{FFFFFF}\nЧтобы начать играть с игроком: {FDCF28}/dice.", 58.000000, 0.000000, 0.000000, 1.000000},//фишки
    {1951, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Poison", "Яд", "Предмет: {FDCF28}Яд", "{FFFFFF}Можно приобрести в магазине {FDCF28}24/7{FFFFFF},\nили на центральном рынке.\nМожно использовать только тогда, когда у вас мало здоровья.\nБыстрый доступ: {FDCF28}/killme.", 0.000000, 360.000000, 216.000000, 1.032325},//яд
    {19627, true, 5, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Rep Pack", "Набор для починки", "Предмет: {FDCF28}Набор для починки", "{FFFFFF}Можно приобрести в любом магазине {FDCF28}АЗС{FFFFFF},\nили на центральном рынке.\nПолностью ремонтирует вашу машину.\nНеобходимо находиться в машине.\nМожно использовать.\nБыстрый доступ: {FDCF28}/repcar.", 87.000000, 0.000000, -42.000000, 1.000000},//набор для починки
    {19163, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Mask", "Маска", "Предмет: {FDCF28}Маска", "{FFFFFF}Можно приобрести в магазине {FDCF28}24/7{FFFFFF},\nили на центральном рынке.\nСкрывает вас на мини-карте на 10 минут.\nМожно использовать.\nБыстрый доступ: {FDCF28}/mask.", 10.000000, 0.000000, -256.000000, 1.000000},//маска
    {19998, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Lighter", "Зажигалка", "Предмет: {FDCF28}Зажигалка", "{FFFFFF}Можно приобрести в магазине {FDCF28}24/7{FFFFFF},\nили на центральном рынке.\nВосстанавливает немного здоровья после использования.\nМожно использовать.\nБыстрый доступ: {FDCF28}/smoke.", 0.000000, 0.000000, 0.000000, 1.000000},//зажигалка
    {19625,  true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Cigarettes", "Сигарета", "Предмет: {FDCF28}Сигарета", "{FFFFFF}Можно приобрести в магазине {FDCF28}24/7{FFFFFF},\nили на центральном рынке.\nВосстанавливает немного здоровья после использования.\nМожно использовать.\nБыстрый доступ: {FDCF28}/smoke.", -90.000000, 0.000000, 35.000000, 1.000000},//сигареты
    {13646,  true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Gold Rulet", "Золотая рулетка", "Предмет: {FDCF28}Золотая рулетка", "{FFFFFF}Можно получить при ежедневных входах в игру,\nили купить на центральном рынке.\nИспользуется для получения{FFD700} рандомного {FFFFFF}товара\nиз списка доступного в этой рулетке.", 90.000000, 179.000000, 90.000000, 1.887382},//голда
    {1895,  true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Silver Rulet", "Серебряная рулетка", "Предмет: {FDCF28}Серебряная рулетка", "{FFFFFF}Можно получить при ежедневных входах в игру,\nили купить на центральном рынке.\nИспользуется для получения{FFD700} рандомного {FFFFFF}товара\nиз списка доступного в этой рулетке.", 0.000000, 0.000000, 0.000000, 1.934306},//серебро
    {1979,  true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Bronze Rulet", "Бронзовая рулетка", "Предмет: {FDCF28}Бронзовая рулетка", "{FFFFFF}Можно получить при ежедневных входах в игру,\nили купить на центральном рынке.\nИспользуется для получения{FFD700} рандомного {FFFFFF}товара\nиз списка доступного в этой рулетке.", 264.000000, 178.000000, 189.000000, 1.845672},//брноза
    {1486,  true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Beer", "Пиво", "Предмет: {FDCF28}Пиво", "{FFFFFF}Можно приобрести в магазине {FDCF28}24/7{FFFFFF},\nили на центральном рынке.\nВосстанавливает немного здоровья после использования.\nМожно использовать.\nБыстрый доступ: {FDCF28}/beer.", 333.000000, 12.000000, 286.000000, 0.928049},//пиво
    {2601, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Sprunk", "Спранк", "Предмет: {FDCF28}Спранк", "{FFFFFF}Можно приобрести в любом магазине {FDCF28}АЗС{FFFFFF},\nили на центральном рынке.\nВосстанавливает здоровье.\nБыстрый доступ: {FDCF28}/sprunk.", 333.000000, 12.000000, 286.000000, 0.928049},//спранк
    {2894, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Phone Book", "Телефонная книга", "Предмет: {FDCF28}Телефонная книга", "{FFFFFF}Можно приобрести в любом магазине {FDCF28}АЗС{FFFFFF},\nили на центральном рынке.\nНаходит номера телефона по ID.\nНеобходимо находиться в машине.\nБыстрый доступ: {FDCF28}/number [ID].", 90.000000, 0.000000, 180.000000, 1.000000},//телефонная книга
    {11748,true, 5, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "break", "Скрепка", "Предмет: {FDCF28}Скрепка", "{FFFFFF}Можно приобрести в магазине {FDCF28}24/7{FFFFFF},\nили на центральном рынке.\nВзламывает транспорт.\nМожно использовать.\nБыстрый доступ: {FDCF28}/break.", 267.000000, 345.000000, 20.000000, 1.032325},//скрепка
    {18874, true, 1, "ксиаоми", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0xFFFFFFFF, "Xiaomi Mi 8 (White)", "Телефон Xiaomi Mi 8 (Белый)", "Предмет: {FDCF28}Телефон Xiaomi Mi 8 (Белый)", "{FFFFFF}Можно купить в любом салоне ''{FDCF28}Сотовая связь{FFFFFF}'',\nили на центральном рынке.\nИмеет набор стандартных функций телефона.\nБыстрый доступ {FDCF28}/phone", 90.000000, 180.000000, 0.000000, 1.000000},//телефон
    {1242, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Armour", "Бронежилет", "Предмет: {FDCF28}Бронежилет", "{FFFFFF}Можно приобрести в магазине {FDCF28}24/7{FFFFFF},\nили на центральном рынке.\nПополняет броню на 100%.\nМожно использовать.\nБыстрый доступ: {FDCF28}/armour.", 360.000000, 360.000000, 8.000000, 0.980186},//броник
    {365,  true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Ballonchik", "Баллончик с краской", "Предмет: {FDCF28}Баллончик с краской", "{FFFFFF}Информация об этом предмете не указана", 360.000000, 360.000000, 8.000000, 0.980186},//балончик с краской
    {1650, true, 5, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Fuel", "Канистра", "Предмет: {FDCF28}Канистра", "{FFFFFF}Можно приобрести в любом магазине {FDCF28}АЗС{FFFFFF},\nили на центральном рынке.\nЗаправляет вашу машину на 15%.\nНеобходимо находиться в машине.\nМожно использовать.\nБыстрый доступ: {FDCF28}/fillcar.", 360.000000, 360.000000, 11.000000, 1.100103},//канистра
    {1288,  true, 5, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Supreme", "Наклейка Supreme", "Предмет: {FDCF28}Наклейка Supreme", "{FFFFFF}Можно купить за талоны у {FDCF28}Нейтона{FFFFFF},\nили на центральном рынке.\nДелает вашу машину красивой.\nБыстрый доступ {FDCF28}/supreme.", 178.000000, 90.000000, 360.000000, 1.584983},//суприм
    {2102, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Kolonka", "Колонка", "Аксессуар: {FDCF28}Колонка", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 193.000000, 0.872784},//колонка
    {2710,  false, 200, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Podarok", "Подарок", "Предмет: {FDCF28}Подарок", "{FFFFFF}Можно найти в любом месте {FDCF28}города{FFFFFF},\nили на центральном рынке.\nМожно обменять на шкатулку у {FFD700}Эдварда.{FFFFFF}\nМожно использовать.", 149.000000, 187.000000, 134.000000, 1.006255},
	{2690, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Extinguisher", "Огнетушитель", "Аксессуар: {FDCF28}Огнетушитель", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 171.000000, 1.060479},
	{2045, true, 1, "1", "PUT", "HAѓET’", 0xf44242FF, 0x333333FF,  "Bat with nails", "Бита с гвоздями", "Аксессуар: {FDCF28}Бита с гвоздями", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 119.000000, 0.000000, 0.929092},
	{19590, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Sword", "Меч", "Аксессуар: {FDCF28}Меч", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 119.000000, 0.000000, 1.451511},
	{19631, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hammer", "Молот", "Аксессуар: {FDCF28}Молот", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 270.000000, 90.000000, 0.000000, 0.929092},
	{18963, true, 1, "1", "PUT", "HAѓET’", 0xf44242FF, 0x333333FF, "Maska CJ", "Маска CJ", "Аксессуар: {FDCF28}Маска CJ", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 114.000000, 0.725755},
	{19921, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Red Suitcase", "Красный чемодан", "Аксессуар: {FDCF28}Красный чемодан", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 270.000000, 0.000000, 0.000000, 1.304483},
	{19200, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Helmet", "Шлем", "Аксессуар: {FDCF28}Шлем", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 193.000000, 0.872784},
	{19036, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Maska", "Белая маска", "Аксессуар: {FDCF28}Белая маска", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 90.000000, 0.721063},
	{19037, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Maska", "Красная маска", "Аксессуар: {FDCF28}Красная маска", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 90.000000, 0.721063},
	{19038, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Maska", "Зеленая маска", "Аксессуар: {FDCF28}Зеленая маска", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 90.000000, 0.721063},
	{854, false, 200, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Trash", "Мусор", "Предмет: {FDCF28}Мусор", "{FFFFFF}Информация об этом предмете не указана.", 298.000000, 0.000000, 0.000000, 1.000000},
	{826, false, 200, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Resource: cotton", "Хлопок", "Предмет: {FDCF28}Хлопок", "{FFFFFF}Можно собрать на {FDCF28}ферме{FFFFFF}\nИспользуется для создания вещей в {FDCF28}подвале.", 161.000000, 174.000000, 126.000000, 1.225234},
	{2226, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Boombox", "Бумбокс", "Аксессуар: {FDCF28}Бумбокс", "{FFFFFF}Можно купить в меню {FDCF28}доната{FFFFFF},\nили купить на центральном рынке.\nМожно надеть. Можно использовать", 161.000000, 174.000000, 126.000000, 1.225234},
	{19090, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Blue hat", "Синяя шапка", "Аксессуар: {FDCF28}Синяя шапка", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 185.000000, 310.000000, 323.000000, 0.802919},
	{19091, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Red hat", "Красная шапка", "Аксессуар: {FDCF28}Красная шапка", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 185.000000, 310.000000, 323.000000, 0.802919},
	{19092, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Green hat", "Зеленая шапка", "Аксессуар: {FDCF28}Зеленая шапка", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 185.000000, 310.000000, 323.000000, 0.802919},
	{19904, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Vest", "Жилет", "Аксессуар: {FDCF28}Жилет", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 180.000000, 0.904066},
	{19469, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Neck Bandage", "Повязка на шею", "Аксессуар: {FDCF28}Повязка на шею", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 270.000000, 0.000000, 0.757038},
 	{333, true, 1, "1", "PUT", "HAѓET’", 0xf4dc41FF, 0x333333FF, "Klushka", "Клюшка", "Аксессуар: {FDCF28}Клюшка", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 123.000000, 19.000000, 0.000000, 1.001042},
 	{336, true, 1, "БитаАкс", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bat", "Бита", "Аксессуар: {FDCF28}Бита", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 131.000000, 26.000000, 85.000000, 1.001042},
 	{337, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Shovel", "Лопата", "Аксессуар: {FDCF28}Лопата", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 142.000000, 29.000000, 123.000000, 1.465067},
 	{338, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "cue", "Кий", "Аксессуар: {FDCF28}Кий", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 142.000000, 29.000000, 123.000000, 1.465067},
 	{339, true, 1, "КатанаАкс", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Katana", "Катана", "Аксессуар: {FDCF28}Катана", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 142.000000, 29.000000, 123.000000, 1.465067},
 	{326, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "cane", "Трость", "Аксессуар: {FDCF28}Трость", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 142.000000, 29.000000, 123.000000, 1.465067},
 	{18636, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Police Cap", "Полицейская кепка", "Аксессуар: {FDCF28}Полицейская кепка", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 142.000000, 29.000000, 123.000000, 1.465067},
 	{18637, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Shield", "Щит", "Аксессуар: {FDCF28}Щит", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 142.000000, 29.000000, 123.000000, 1.465067},
 	{3929, false, 200, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Resource: stone", "Камень", "Ресурс: {FDCF28}Камень", "{FFFFFF}Можно выкопать на {FDCF28}шахте{FFFFFF},\nили купить на центральном рынке.\nИспользуется для создания предмета в подвале.", 236.000000, 0.000000, 0.000000, 1.558915},
 	{19941, false, 200, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Resource: gold", "Золото", "Ресурс: {FDCF28}Золото", "{FFFFFF}Можно выкопать на {FDCF28}шахте{FFFFFF},\nили купить на центральном рынке.\nИспользуется для создания предмета в подвале.", 29.000000, 18.000000, 220.000000, 1.256517},
 	{17027, false, 200, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Resource: silver", "Серебро", "Ресурс: {FDCF28}Серебро", "{FFFFFF}Можно выкопать на {FDCF28}шахте{FFFFFF},\nили купить на центральном рынке.\nИспользуется для создания предмета в подвале.", 251.000000, 0.000000, 0.000000, 1.392075},
 	{1314, false, 200, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Family Talon", "Семейный талон", "Предмет: {FDCF28}Семейный талон", "{FFFFFF}Получается за выполнение {FDCF28}заданий{FFFFFF}.\nИспользуется для\nобмена на ценные товары у ЖК Аксиома({FDCF28}/GPS{FFFFFF})\nМожно приобрести на центральном рынке.", 182.000000, 169.000000, 190.000000, 1.287799},
 	{19874, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Adrenaline Tablet", "Таблетка адреналина", "Предмет: {FDCF28}Таблетка адреналина", "{FFFFFF}Можно создать в {FDCF28}подвале{FFFFFF},\nили купить на центральном рынке.\nВосстанавливает здоровье на 50%.\nУскоряет ваш шаг на некоторое время.\nМожно использовать.", 76.000000, 219.000000, 0.000000, 0.835245},
 	{321, false, 1, "1", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0xf44242FF, "Penis", "Хуй", "Аксессуар: {FDCF28}Хуй", "{FFFFFF}Информация об этом предмете не указана", 236.000000, 0.000000, 0.000000, 1.558915},
 	{411, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "certificate: infernus", "Infernus", "Сертификат: {FDCF28}Infernus", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{19591, true, 1, "1", "PUT", "HAѓET’", 0xf4dc41FF, 0x333333FF, "Veer made in china", "Веер", "Аксессуар: {FDCF28}Веер", "{FFFFFF}Информация об этом предмете не указана", 236.000000, 0.000000, 0.000000, 1.558915},
 	{411, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0xefaf40FF,0x333333FF, "certificate: Infernus", "Infernus", "Сертификат: {FDCF28}Infernus", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{415, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0xefaf40FF,0x333333FF, "certificate: Cheetah", "Cheetah", "Сертификат: {FDCF28}Cheetah", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{442, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF,0x333333FF, "certificate: Romero", "Romero", "Сертификат: {FDCF28}Romero", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{451, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF,0x333333FF, "certificate: Turismo", "Turismo", "Сертификат: {FDCF28}Turismo", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{495, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF,0x333333FF, "certificate: Sandking", "Sandking", "Сертификат: {FDCF28}Sandking", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{494, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF,0x333333FF, "certificate: Hotring Racer", "Hotring Racer", "Сертификат: {FDCF28}Hotring Racer", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{503, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF,0x333333FF, "certificate: Hotring Racer", "Hotring Racer", "Сертификат: {FDCF28}Hotring Racer", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{502, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF,0x333333FF, "certificate: Hotring Racer", "Hotring Racer", "Сертификат: {FDCF28}Hotring Racer", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{541, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF, 0x333333FF, "certificate: Bullet", "Bullet", "Сертификат: {FDCF28}Bullet", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{560, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF, 0x333333FF, "certificate: Sultan", "Sultan", "Сертификат: {FDCF28}Sultan", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{562, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF, 0x333333FF, "certificate: Elegy", "Elegy", "Сертификат: {FDCF28}Elegy", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{579, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF, 0x333333FF, "certificate: Huntley", "Huntley", "Сертификат: {FDCF28}Huntley", "{FFFFFF}Информация об этом предмете не указана", 160.000000, 174.000000, 195.000000, 1.000000},
 	{18874, true, 1, "белый", "USE", "…CЊO‡’€OBAT’",0x333333FF, 0x778899FF, "Google Pixel 3 (White)", "Телефон Google Pixel 3 (Белый)", "Предмет: {FDCF28}Телефон Google Pixel 3 (Белый)", "{FFFFFF}Можно купить в любом салоне ''{FDCF28}Сотовая связь{FFFFFF}'',\nили на центральном рынке.\nИмеет набор стандартных функций телефона.\nБыстрый доступ {FDCF28}/phone", 90.000000, 180.000000, 0.000000, 1.000000},//телефон
 	{18874, true, 1, "голубой", "USE", "…CЊO‡’€OBAT’",0x333333FF, 0x4286f4FF, "Google Pixel 3 (Blue)", "Телефон Google Pixel 3 (Голубой)", "Предмет: {FDCF28}Телефон Google Pixel 3 (Голубой)", "{FFFFFF}Можно купить в любом салоне ''{FDCF28}Сотовая связь{FFFFFF}'',\nили на центральном рынке.\nИмеет набор стандартных функций телефона.\nБыстрый доступ {FDCF28}/phone", 90.000000, 180.000000, 0.000000, 1.000000},
 	{18874, true, 1, "зеленый", "USE", "…CЊO‡’€OBAT’",0x333333FF, 0x1c9118FF, "Google Pixel 3 (Green)", "Телефон Google Pixel 3 (Зеленый)", "Предмет: {FDCF28}Телефон Google Pixel 3 (Зеленый)", "{FFFFFF}Можно купить в любом салоне ''{FDCF28}Сотовая связь{FFFFFF}'',\nили на центральном рынке.\nИмеет набор стандартных функций телефона.\nБыстрый доступ {FDCF28}/phone", 90.000000, 180.000000, 0.000000, 1.000000},//телефон
 	{18874, true, 1, "оранжевый", "USE", "…CЊO‡’€OBAT’",0x333333FF, 0xed9822FF, "Google Pixel 3 (Orange)", "Телефон Google Pixel 3 (Оранжевый)", "Предмет: {FDCF28}Телефон Google Pixel 3 (Оранжевый)", "{FFFFFF}Можно купить в любом салоне ''{FDCF28}Сотовая связь{FFFFFF}'',\nили на центральном рынке.\nИмеет набор стандартных функций телефона.\nБыстрый доступ {FDCF28}/phone", 90.000000, 180.000000, 0.000000, 1.000000},
 	{18874, true, 1, "золотой", "USE", "…CЊO‡’€OBAT’",0x333333FF, 0xedc423FF,  "Google Pixel 3 (Gold)", "Телефон Google Pixel 3 (Золотой)", "Предмет: {FDCF28}Телефон Google Pixel 3 (Золотой)", "{FFFFFF}Можно купить в любом салоне ''{FDCF28}Сотовая связь{FFFFFF}'',\nили на центральном рынке.\nИмеет набор стандартных функций телефона.\nБыстрый доступ {FDCF28}/phone", 90.000000, 180.000000, 0.000000, 1.000000},//телефон
 	{18874, true, 1, "розовый", "USE", "…CЊO‡’€OBAT’",0x333333FF, 0xE86868FF,  "Google Pixel 3 (Pink)", "Телефон Google Pixel 3 (Розовый)", "Предмет: {FDCF28}Телефон Google Pixel 3 (Розовый)", "{FFFFFF}Можно купить в любом салоне ''{FDCF28}Сотовая связь{FFFFFF}'',\nили на центральном рынке.\nИмеет набор стандартных функций телефона.\nБыстрый доступ {FDCF28}/phone", 90.000000, 180.000000, 0.000000, 1.000000},
 	{18874, true, 1, "черный", "USE", "…CЊO‡’€OBAT’",0x333333FF, 0x000000FF,  "Google Pixel 3 (Black)", "Телефон Google Pixel 3 (Черный)", "Предмет: {FDCF28}Телефон Google Pixel 3 (Черный)", "{FFFFFF}Можно купить в любом салоне ''{FDCF28}Сотовая связь{FFFFFF}'',\nили на центральном рынке.\nИмеет набор стандартных функций телефона.\nБыстрый доступ {FDCF28}/phone", 90.000000, 180.000000, 0.000000, 1.000000},//телефон
 	{18874, true, 1, "желтый", "USE", "…CЊO‡’€OBAT’",0x333333FF, 0xffee00FF,  "Google Pixel 3 (Yellow)", "Телефон Google Pixel 3 (Желтый)", "Предмет: {FDCF28}Телефон Google Pixel 3 (Желтый)", "{FFFFFF}Можно купить в любом салоне ''{FDCF28}Сотовая связь{FFFFFF}'',\nили на центральном рынке.\nИмеет набор стандартных функций телефона.\nБыстрый доступ {FDCF28}/phone", 90.000000, 180.000000, 0.000000, 1.000000},
 	{19487, true, 1, "1", "PUT", "HAѓET’", 0x1c9118FF, 0x333333FF, "Bell", "Колпак", "Аксессуар: {FDCF28}Колпак", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
 	{19352, true, 1, "1", "PUT", "HAѓET’", 0x1c9118FF, 0x333333FF, "Bell", "Колпак", "Аксессуар: {FDCF28}Колпак", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 25.000000, 0.000000, 1.00000},
 	{19350, true, 1, "1", "PUT", "HAѓET’", 0x1c9118FF, 0x333333FF, "mustache", "Усы", "Аксессуар: {FDCF28}Усы", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 90.000000, 90.000000, 1.00000},
 	{19318, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "White Guitar", "Белая гитара", "Аксессуар: {FDCF28}Белая гитара", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 189.000000, 138.000000, 0.000000, 0.959332},
 	{19319, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Black Guitar", "Черная гитара", "Аксессуар: {FDCF28}Черная гитара", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 189.000000, 138.000000, 0.000000, 0.959332},
 	{19317, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Red Guitar", "Красная гитара", "Аксессуар: {FDCF28}Красная гитара", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 189.000000, 138.000000, 0.000000, 0.959332},
 	{19472, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Respirator", "Респиратор", "Аксессуар: {FDCF28}Респиратор", "{FFFFFF}Можно получить за деньги у {FDCF28}банка ЛС{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{1276, true, 1, "1", "PUT", "HAѓET’", 0xf44242FF, 0x333333FF, "Amulet", "Амулет", "Аксессуар: {FDCF28}Амулет", "{FFFFFF}Информация об этом предмете не указана", 236.000000, 0.000000, 0.000000, 1.558915},
 	{19064, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "New Year Hat", "Новогодняя шапка", "Аксессуар: {FDCF28}Новогодняя шапка", "{FFFFFF}Можно получить за выполнение {FDCF28}квестов{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19065, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "New Year Hat", "Новогодняя шапка", "Аксессуар: {FDCF28}Новогодняя шапка", "{FFFFFF}Можно получить за выполнение {FDCF28}квестов{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19066, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "New Year Hat", "Новогодняя шапка", "Аксессуар: {FDCF28}Новогодняя шапка", "{FFFFFF}Можно получить за выполнение {FDCF28}квестов{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19054, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Accesories: Present", "Подарок (Аксессуар)", "Аксессуар: {FDCF28}Подарок", "{FFFFFF}Можно получить за выполнение {FDCF28}квестов{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19055, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Accesories: Present", "Подарок (Аксессуар)", "Аксессуар: {FDCF28}Подарок", "{FFFFFF}Можно получить за выполнение {FDCF28}квестов{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19056, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Accesories: Present", "Подарок (Аксессуар)", "Аксессуар: {FDCF28}Подарок", "{FFFFFF}Можно получить за выполнение {FDCF28}квестов{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19057, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Accesories: Present", "Подарок (Аксессуар)", "Аксессуар: {FDCF28}Подарок", "{FFFFFF}Можно получить за выполнение {FDCF28}квестов{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19058, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Accesories: Present", "Подарок (Аксессуар)", "Аксессуар: {FDCF28}Подарок", "{FFFFFF}Можно получить за выполнение {FDCF28}квестов{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19085, true, 1, "1", "PUT", "HAѓET’", 0xf44242FF, 0x333333FF, "eye patch", "Повязка на глаз", "Аксессуар: {FDCF28}Повязка на глаз", "{FFFFFF}Можно получить за выполнение {FDCF28}квестов{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19315, false, 200, "1", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Resource: Corse Deer", "Тушка оленя", "Ресурс: {FDCF28}Тушка оленя", "{FFFFFF}Можно получить на охоте за оленями,\nили купить на центральном рынке.", 0.000000, 0.000000, 174.000000, 0.727320},
 	{11704, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Maska", "Маска демона", "Аксессуар: {FDCF28}Маска демона", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19137, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Maska", "Маска петуха", "Аксессуар: {FDCF28}Маска петуха", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
	{19346, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hot Dog", "Хотдог", "Аксессуар: {FDCF28}Хотдог", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{6865, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Maska", "Маска кентавра", "Аксессуар: {FDCF28}Маска кентавра", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{18952, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Helmet", "Боксерский шлем", "Аксессуар: {FDCF28}Боксерский шлем", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19847, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Meat", "Мясо на спину", "Аксессуар: {FDCF28}Мясо на спину", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19136, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Dreads", "Дреды", "Аксессуар: {FDCF28}Дреды", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
	{11745, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bag for notebook", "Сумка для ноутбука", "Аксессуар: {FDCF28}Сумка для ноутбука", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.0000, 0.0000, 90.0000, 1.0000},
	{19094, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Burger on head", "Бургер на голову", "Аксессуар: {FDCF28}Бургер на голову", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19141, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Helmet SWAT", "Шлем SWAT", "Аксессуар: {FDCF28}Шлем SWAT", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19314, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Horns on head", "Рога на голову", "Аксессуар: {FDCF28}Рога на голову", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{2908, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Maska Zombie", "Маска зомби", "Аксессуар: {FDCF28}Маска зомби", "{FFFFFF}Можно получить в меню покупки {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
    {2803, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Meat bag", "Мешок с мясом", "Аксессуар: {FDCF28}Мешок с мясом", "{FFFFFF}Можно получить в меню {FDCF28}доната{FFFFFF},\nили купить на центральном рынке.\nМожно надеть. Можно использовать каждые 15 минут игры\nПополняет сытость на 100%", 182.000000, 190.000000, 259.000000, 1.001042},
    {19878, true, 1, "1", "PUT", "HAѓET’", 0xab9154FF, 0x333333FF, "Skate", "Скейт", "Аксессуар: {FDCF28}Скейт", "{FFFFFF}Можно приобрести в магазине аксессуаров,\nна центральном рынке, на праздничных евентах,\nили при использовании {FDCF28}gold рулетки.\nИспользуется для изменения внешнего вида персонажа. Можно надеть.\n{FDCF28}Использовать: Пробел", 220.000000, 146.000000, 156.000000, 1.001042},
    {18874, true, 1, "серебряный", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0xffee00FF, "Samsung Galaxy S10 (Silver)", "Телефон Samsung Galaxy S10 (Серебряный)", "Предмет: {FDCF28}Телефон Samsung Galaxy S10 (Серебряный)", "{FFFFFF}Можно купить в любом салоне ''{FDCF28}Сотовая связь{FFFFFF}'',\nили на центральном рынке.\nИмеет набор стандартных функций телефона.\nБыстрый доступ {FDCF28}/phone", 90.000000, 180.000000, 0.000000, 1.000000},
    {2406, true, 1, "", "PUT", "HAѓET’", 0xab9154FF, 0x333333FF, "Surf Skate", "Доска для серфинга", "Аксессуар: {FDCF28}Доска для серфинга", "{FFFFFF}Можно приобрести в магазине аксессуаров,\nна центральном рынке, на праздничных евентах,\nили при использовании {FDCF28}gold рулетки.\nИспользуется для изменения внешнего вида персонажа. Можно надеть.\n{FDCF28}Использовать: Пробел", 220.000000, 146.000000, 156.000000, 1.001042},
    {19636, true, 1, "1еу", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Kiosk", "Переносной ларек", "Аксессуар: {FDCF28}Переносной ларек", "{FFFFFF}Можно приобрести в {FDCF28}игровом магазине {FFFFFF}или\nна {FDCF28}центральном рынке{FFFFFF}. Дает возможность\nустановить ларек и продавать в нем, в\n{FDCF28}любом месте\n", 248.000000, 331.000000, 0.000000, 1.162147},
	{19421, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Headphones", "Наушники", "Аксессуар: {FDCF28}Наушники", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 120.000000, 0.000000, 0.000000, 1.000000},
 	{19422, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Headphones", "Наушники", "Аксессуар: {FDCF28}Наушники", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 120.000000, 0.000000, 0.000000, 1.000000},
 	{19423, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Headphones", "Наушники", "Аксессуар: {FDCF28}Наушники", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 120.000000, 0.000000, 0.000000, 1.000000},
 	{19424, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Headphones", "Наушники", "Аксессуар: {FDCF28}Наушники", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 120.000000, 0.000000, 0.000000, 1.000000},
 	{19069, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шапка", "Аксессуар: {FDCF28}Шапка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
 	{19068, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шапка", "Аксессуар: {FDCF28}Шапка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
 	{19067, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шапка", "Аксессуар: {FDCF28}Шапка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
 	{19554, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шапка", "Аксессуар: {FDCF28}Шапка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
 	{18953, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шапка", "Аксессуар: {FDCF28}Шапка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
 	{18954, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шапка", "Аксессуар: {FDCF28}Шапка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
 	{18968, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Panamka", "Панамка", "Аксессуар: {FDCF28}Панамка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 35.000000, 1.00000},
 	{18967, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Panamka", "Панамка", "Аксессуар: {FDCF28}Панамка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 35.000000, 1.00000},
 	{18969, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Panamka", "Панамка", "Аксессуар: {FDCF28}Панамка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 35.000000, 1.00000},
 	{18955, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{18956, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{18957, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{18959, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{18926, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{18927, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{18928, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{18929, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{18930, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{18931, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{18932, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{18933, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Cap", "Кепка", "Аксессуар: {FDCF28}Кепка", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, -180.000000, 1.00000},
 	{19104, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Helmet", "Каска", "Аксессуар: {FDCF28}Каска", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 0.000000, 90.000000, 1.00000},
 	{19105, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Helmet", "Каска", "Аксессуар: {FDCF28}Каска", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 0.000000, 90.000000, 1.00000},
 	{19106, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Helmet", "Каска", "Аксессуар: {FDCF28}Каска", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 0.000000, 90.000000, 1.00000},
 	{19107, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Helmet", "Каска", "Аксессуар: {FDCF28}Каска", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 0.000000, 90.000000, 1.00000},
 	{19108, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Helmet", "Каска", "Аксессуар: {FDCF28}Каска", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 0.000000, 90.000000, 1.00000},
 	{19109, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Helmet", "Каска", "Аксессуар: {FDCF28}Каска", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 0.000000, 90.000000, 1.00000},
 	{18925, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Beret", "Берет", "Аксессуар: {FDCF28}Берет", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 0.000000, 90.000000, 1.00000},
 	{18922, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Beret", "Берет", "Аксессуар: {FDCF28}Берет", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 0.000000, 90.000000, 1.00000},
 	{18923, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Beret", "Берет", "Аксессуар: {FDCF28}Берет", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 0.000000, 90.000000, 1.00000},
 	{18924, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Beret", "Берет", "Аксессуар: {FDCF28}Берет", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 0.000000, 90.000000, 1.00000},
    {18921, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Beret", "Берет", "Аксессуар: {FDCF28}Берет", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 0.000000, 90.000000, 1.00000},
 	{19519, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Wig", "Парик", "Аксессуар: {FDCF28}Парик", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19274, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Wig", "Парик", "Аксессуар: {FDCF28}Парик", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 182.000000, 190.000000, 259.000000, 1.001042},
 	{19011, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19012, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19013, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19014, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19015, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19016, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19017, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19018, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19019, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19024, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19027, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19028, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19029, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
    {19022, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19035, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19031, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19032, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{19033, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Glasses", "Очки", "Аксессуар: {FDCF28}Очки", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -20.000000, 0.000000, 90.000000, 1.000000},
 	{18911, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana", "Бандана", "Аксессуар: {FDCF28}Бандана", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
 	{18912, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana", "Бандана", "Аксессуар: {FDCF28}Бандана", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
 	{18913, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana", "Бандана", "Аксессуар: {FDCF28}Бандана", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
 	{18914, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana", "Бандана", "Аксессуар: {FDCF28}Бандана", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
 	{18915, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana", "Бандана", "Аксессуар: {FDCF28}Бандана", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
 	{18916, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana", "Бандана", "Аксессуар: {FDCF28}Бандана", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
 	{18917, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana", "Бандана", "Аксессуар: {FDCF28}Бандана", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
 	{18918, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana", "Бандана", "Аксессуар: {FDCF28}Бандана", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
 	{18919, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana", "Бандана", "Аксессуар: {FDCF28}Бандана", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
 	{18920, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana", "Бандана", "Аксессуар: {FDCF28}Бандана", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
    {18947, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шляпа", "Аксессуар: {FDCF28}Шляпа", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -15.000000, 0.000000, 0.000000, 1.00000},
    {18948, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шляпа", "Аксессуар: {FDCF28}Шляпа", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -15.000000, 0.000000, 0.000000, 1.00000},
    {18949, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шляпа", "Аксессуар: {FDCF28}Шляпа", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -15.000000, 0.000000, 0.000000, 1.00000},
    {18950, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шляпа", "Аксессуар: {FDCF28}Шляпа", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -15.000000, 0.000000, 0.000000, 1.00000},
    {18951, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шляпа", "Аксессуар: {FDCF28}Шляпа", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -15.000000, 0.000000, 0.000000, 1.00000},
    {19042, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19041, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19040, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19039, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19043, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19044, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19045, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19046, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19048, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19049, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19050, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19051, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19053, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Clock", "Часы", "Аксессуар: {FDCF28}Часы", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {3026, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Briefcase", "Портфель", "Аксессуар: {FDCF28}Портфель", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 15.000000, 0.000000, 1.00000},
    {371, true, 1, "ПортфельАкс", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Briefcase", "Портфель", "Аксессуар: {FDCF28}Портфель", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 12.000000, 0.000000, 1.00000},
    {19559, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Briefcase", "Портфель", "Аксессуар: {FDCF28}Портфель", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {18970, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шляпа", "Аксессуар: {FDCF28}Шляпа", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -15.000000, 0.000000, 0.000000, 1.00000},
    {18973, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шляпа", "Аксессуар: {FDCF28}Шляпа", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -15.000000, 0.000000, 0.000000, 1.00000},
    {18972, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шляпа", "Аксессуар: {FDCF28}Шляпа", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -15.000000, 0.000000, 0.000000, 1.00000},
    {18971, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Hat", "Шляпа", "Аксессуар: {FDCF28}Шляпа", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -15.000000, 0.000000, 0.000000, 1.00000},
    {18910, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana on head", "Бандана на голову", "Аксессуар: {FDCF28}Бандана на голову", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
    {18909, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana on head", "Бандана на голову", "Аксессуар: {FDCF28}Бандана на голову", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
    {18908, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana on head", "Бандана на голову", "Аксессуар: {FDCF28}Бандана на голову", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
    {18907, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana on head", "Бандана на голову", "Аксессуар: {FDCF28}Бандана на голову", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
    {18906, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bandana on head", "Бандана на голову", "Аксессуар: {FDCF28}Бандана на голову", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
	{18875, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Radio", "Радио", "Предмет: {FDCF28}Радио", "{FFFFFF}Можно купить в магазине{FDCF28}24/7{FFFFFF},\nили купить на центральном рынке.\nМожно использовать.", 303.000000, 360.000000, 195.000000, 0.948905},
    {18632, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Fishing rod", "Удочка", "Предмет: {FDCF28}Удочка", "{FFFFFF}Можно купить в магазине{FDCF28}24/7{FFFFFF},\nили купить на центральном рынке.\nМожно использовать.", 0.000000, 350.000000, 0.000000, 1.220020},
    {1554, false, 200, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Worms", "Черви", "Предмет: {FDCF28}Черви", "{FFFFFF}Можно купить в магазине{FDCF28}24/7{FFFFFF},\nили купить на центральном рынке.\nПредназначен для наживки при ловле рыбы.", 0.000000, 350.000000, 182.000000, 1.204379},
    {2709, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Tablets", "Таблетки от наркозависимости", "Предмет: {FDCF28}Таблетки от наркозависимости", "{FFFFFF}Можно купить в магазине{FDCF28}24/7{FFFFFF},\nили купить на центральном рынке.\nМожно использовать.", 0.000000, 0.000000, 0.000000, 1.000000},
    {1575, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Drugs", "Наркотики", "Предмет: {FDCF28}Наркотики", "{FFFFFF}Информация об этом предмете не указана.\nМожно использовать.", 0.000000, 0.000000, 0.000000, 1.000000},
	{331, true, 1000, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Brass Knuckles", "Кастет", "Предмет: {FDCF28}Кастет", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{335, true, 1000, "Бита", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Baseball bat (Weapon)", "Бита", "Предмет: {FDCF28}Бита", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{339, true, 1000, "Катана", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Katana (Weapon)", "Катана", "Предмет: {FDCF28}Катана", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{371, true, 1000, "Парашют", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Parachute", "Парашют", "Предмет: {FDCF28}Парашют", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{343, true, 1000, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Teargas", "Дымовая Шашка", "Предмет: {FDCF28}Дымовая Шашка", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{348, true, 1000, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Desert Eagle", "Desert Eagle", "Предмет: {FDCF28}Desert Eagle", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{349, true, 1000, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Shotgun", "Shotgun", "Предмет: {FDCF28}Shotgun", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{353, true, 1000, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "MP5", "MP5", "Предмет: {FDCF28}MP5", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{355, true, 1000, "Калаш", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "AK-47", "AK-47", "Предмет: {FDCF28}AK-47", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{356, true, 1000, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "M4", "M4", "Предмет: {FDCF28}M4", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{357, true, 1000,  "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Country Rifle", "Country Rifle", "Предмет: {FDCF28}Country Rifle", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{368, true, 1, "", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Night Vision Googles", "Очки ночного видения", "Аксессуар: {FDCF28}Очки ночного видения", "{FFFFFF}Можно обменять у Джозефа за тушки оленя в {FDCF28}лесу{FFFFFF}\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.000000},
	{1274, true, 10000, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "AZ Coins", "Талон AZ Coins", "Предмет: {FDCF28}Талон AZ Coins", "{FFFFFF}Можно получить за {FDCF28}квесты{FFFFFF}\nМожно использовать.", 0.000000, 0.000000, 0.000000, 1.000000},
	{16134, false, 200, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Resource: bronze", "Бронза", "Ресурс: {FDCF28}Бронза", "{FFFFFF}Можно выкопать на {FDCF28}шахте{FFFFFF},\nили купить на центральном рынке.\nИспользуется для создания предмета в подвале.", 236.000000, 0.000000, 0.000000, 1.558915},
	{2936, false, 200, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Resource: metal", "Метал", "Ресурс: {FDCF28}Метал", "{FFFFFF}Можно выкопать на {FDCF28}шахте{FFFFFF},\nили купить на центральном рынке.\nИспользуется для создания предмета в подвале.", 236.000000, 0.000000, 0.000000, 1.558915},
	{19079, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Parrot on", "Попугай на плечо", "Аксессуар: {FDCF28}Попугай на плечо", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
	{8492, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Wings", "Крылья на спину", "Аксессуар: {FDCF28}Крылья на спину", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
	{2511, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Air", "Самолетик", "Аксессуар: {FDCF28}Самолетик", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
	{11712, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Krest", "Крест", "Аксессуар: {FDCF28}Крест", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", -0.0000, 10.0000, 140.0000, 1.0000},
	{19521, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Policeman cap", "Фуражка полицейского", "Аксессуар: {FDCF28}Фуражка полицейского", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 90.000000, 90.000000, 0.000000, 1.000000},
	{11723, false, 100, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Summer coin", "Летняя монета", "Предмет: {FDCF28}Летняя монета", "{FFFFFF}Можно получать каждый PayDay.\n{FFD700}Бессмысленный предмет", 90.000000, 0.000000, 90.000000, 0.811783},
	{355, false, 1, "КалашАкс", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "AK47", "Автомат Калашникова", "Предмет: {FDCF28}Автомат Калашникова", "{FFFFFF}Можно купить в магазине {FDCF28}оружия{FFFFFF}\nМожно использовать.", 0.000000, 27.000000, 134.000000, 1.978623},
	{2694, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Launch Stick", "Наклейка Launch", "Предмет: {FDCF28}Наклейка Launch", "{FFFFFF}Можно получить в донате.\n{FFD700}Можно использовать. Делает вашу машину красивой", 90.000000, 0.000000, 90.000000, 0.811783},
	{19882, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Cook Fish", "Жареная рыба", "Предмет: {FDCF28}Жареная рыба", "{FFFFFF}Можно получить при приготовлении сырой рыбы\nна костре, или на центральном рынке.\nМожно использовать. Восстанавливает {FDCF28}20{FFFFFF} процентов голода.\nБыстрый доступ: {FDCF28}/jfish", 172.000000, 169.000000, 190.000000, 0.740354},
	{573, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Dune", "Сертификат Dune", "Сертификат: {FDCF28}Dune", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{451, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Turismo", "Сертификат Turismo", "Сертификат: {FDCF28}Turismo", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{541, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Bullet", "Сертификат Bullet", "Сертификат: {FDCF28}Bullet", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{411, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Infernus", "Сертификат Infernus", "Сертификат: {FDCF28}Infernus", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{560, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Sultan", "Сертификат Sultan", "Сертификат: {FDCF28}Sultan", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{495, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Sandking", "Сертификат Sandking", "Сертификат: {FDCF28}Sandking", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{415, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Cheetah", "Сертификат Cheetah", "Сертификат: {FDCF28}Cheetah", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{442, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Romero", "Сертификат Romero", "Сертификат: {FDCF28}Romero", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{428, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Securicar", "Сертификат Securicar", "Сертификат: {FDCF28}Securicar", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{494, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Hotring Racer", "Сертификат Hotring Racer", "Сертификат: {FDCF28}Hotring Racer", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{506, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Super GT", "Сертификат Super GT", "Сертификат: {FDCF28}Super GT", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{562, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Elegy", "Сертификат Elegy", "Сертификат: {FDCF28}Elegy", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{568, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Bandito", "Сертификат Bandito", "Сертификат: {FDCF28}Bandito", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{579, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Huntley", "Сертификат Huntley", "Сертификат: {FDCF28}Huntley", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{444, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Monster", "Сертификат Monster", "Сертификат: {FDCF28}Monster", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{522, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate NRG-500", "Сертификат NRG-500", "Сертификат: {FDCF28}NRG-500", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{528, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate FBI Truck", "Сертификат FBI Truck", "Сертификат: {FDCF28}FBI Truck", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{559, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Jester", "Сертификат Jester", "Сертификат: {FDCF28}Jester", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{571, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Kart", "Сертификат Kart", "Сертификат: {FDCF28}Kart", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{539, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Vortex", "Сертификат Vortex", "Сертификат: {FDCF28}Vortex", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{530, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Forklift", "Сертификат Forklift", "Сертификат: {FDCF28}Forklift", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{531, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Tractor", "Сертификат Tractor", "Сертификат: {FDCF28}Tractor", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{535, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Slamvan", "Сертификат Slamvan", "Сертификат: {FDCF28}Slamvan", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{561, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Stratum", "Сертификат Stratum", "Сертификат: {FDCF28}Stratum", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{599, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Police Ranger", "Сертификат Police Ranger", "Сертификат: {FDCF28}Police Ranger", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{1550, true, 5, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Money 5 000 000$", "Купон на 5 000 000$", "Данный портфель с суммой в {FDCF28}5 000 000$", "{FFFFFF}Можно открыть и получить деньги.", 160.000000, 174.000000, 195.000000, 1.000000},
	{2919, true, 10, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Money 2 000 000$", "Купон на 2 000 000$", "Данный портфель с суммой в {FDCF28}2 000 000$", "{FFFFFF}Можно открыть и получить деньги.", 160.000000, 174.000000, 195.000000, 1.000000},
	{1212, true, 15, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Money 1 000 000$", "Купон на 1 000 000$", "Данный портфель с суммой в {FDCF28}1 000 000$", "{FFFFFF}Можно открыть и получить деньги.", 160.000000, 174.000000, 195.000000, 1.000000},
	{18631, true, 100, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Ticket Exp", "Талон Exp", "Талон с опытом", "{FFFFFF}Можно открыть и получить опыт.", 160.000000, 174.000000, 195.000000, 1.000000},
	{19917, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Twin-Turbo", "Twin-Turbo: Тюнинг", "{FFFFFF}Можно установить на свой транспорт","Набор ускорит ваше транспортное средство!", 160.000000, 174.000000, 195.000000, 1.000000},
	{487, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Сertificate Maverick", "Сертификат Maverick", "Сертификат: {FDCF28}Maverick", "{FFFFFF}Можно расспоковать на Автобазаре.", 160.000000, 174.000000, 195.000000, 1.000000},
	{1829, false, 10000, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x4286f4FF, "EURO", "Евро", "Валюта: {FDCF28}ЕВРО", "{FFFFFF}\nМожно приобрести в банке или\nна центральном рынке. Необходим для хранения\nденежных средств в валюте.", 180.0000, 0.0000, 340.0000, 1.0000},
	{501, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF,0x333333FF, "controller: Rc maverick", "Rc maverick", "Контроллер: {FDCF28}Rc maverick", "{FFFFFF}Вертолетик на радио управлении", 160.000000, 174.000000, 195.000000, 1.000000},
 	{441, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "controller: Rc bandit", "Rc Bandit", "Контроллер: {FDCF28}Rc Bandit", "{FFFFFF}Машинка на радио управлении", 160.000000, 174.000000, 195.000000, 1.000000},
 	{464, true, 1, "",  "USE", "…CЊO‡’€OBAT’", 0xefaf40FF, 0x333333FF, "controller: Airoplane", "Airoplane", "Контроллер: {FDCF28}Airoplane", "{FFFFFF}Чтобы выйти введите /rc", 160.000000, 174.000000, 195.000000, 1.000000},
 	{3105, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Bell", "Костюм попугая", "Аксессуар: {FDCF28}Костюм попугая", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19823, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Alco", "Виски", "Предмет: {FDCF28}Виски", "{FFFFFF}Можно приобрести в любом магазине {FDCF28}АЗС{FFFFFF},\nили на центральном рынке.\nВосстанавливает здоровье.", 337.000000, 0.000000, 0.000000, 1.000000},//виски
    {19824, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Alco", "Коньяк", "Предмет: {FDCF28}Коньяк", "{FFFFFF}Можно приобрести в любом магазине {FDCF28}АЗС{FFFFFF},\nили на центральном рынке.\nВосстанавливает здоровье.", 337.000000, 0.000000, 0.000000, 1.000000},//коньяк
    {2814, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Pizza", "Пицца", "Предмет: {FDCF28}Пицца", "{FFFFFF}Можно приобрести в любом магазине {FDCF28}АЗС{FFFFFF},\nили на центральном рынке.\nВосстанавливает здоровье.", -30.000000, 0.000000, 0.000000, 1.000000},//пицца
    {2768, true, 200, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Burger", "Бургер", "Предмет: {FDCF28}Бургер", "{FFFFFF}Можно приобрести в любом магазине {FDCF28}АЗС{FFFFFF},\nили на центральном рынке.\nВосстанавливает здоровье.", 0.000000, 0.000000, 110.000000, 1.000000},//бургер
	{2684, false, 1, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "License Auto", "Лицензия на авто", "Предмет: {FDCF28}Лицензия на авто", "{FFFFFF}Можно получить в автошколе города SF или\nв игровом магазине. Необходима для управления\n автомобилем. Имеет срок годности. Нельзя выкинуть\nили передать другому игроку.", 0.000000, 0.000000, 0.000000, 1.000000},
	{2684, false, 1, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "License Bike", "Лицензия на мото", "Предмет: {FDCF28}Лицензия на мото", "{FFFFFF}Можно получить в автошколе города SF или\nв игровом магазине. Необходима для управления\n автомобилем. Имеет срок годности. Нельзя выкинуть\nили передать другому игроку.", 0.000000, 0.000000, 0.000000, 1.000000},
	{2684, false, 1, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "License Boat", "Лицензия на лодочный транспорт", "Предмет: {FDCF28}Лицензия на лодочный транспорт", "{FFFFFF}Можно получить в автошколе города SF или\nв игровом магазине. Необходима для управления\n автомобилем. Имеет срок годности. Нельзя выкинуть\nили передать другому игроку.", 0.000000, 0.000000, 0.000000, 1.000000},
	{2684, false, 1, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "License Fly", "Лицензия на полеты", "Предмет: {FDCF28}Лицензия на полеты", "{FFFFFF}Можно получить в автошколе города SF или\nв игровом магазине. Необходима для управления\n автомобилем. Имеет срок годности. Нельзя выкинуть\nили передать другому игроку.", 0.000000, 0.000000, 0.000000, 1.000000},
	{2684, false, 1, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "License Gun", "Лицензия на оружие", "Предмет: {FDCF28}Лицензия на оружие", "{FFFFFF}Можно получить в автошколе города SF или\nв игровом магазине. Необходима для управления\n автомобилем. Имеет срок годности. Нельзя выкинуть\nили передать другому игроку.", 0.000000, 0.000000, 0.000000, 1.000000},
    {19332, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Воздушный шар #1", "Воздушный шар #1", "Воздушный шар #1", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно летать.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19333, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Воздушный шар #2", "Воздушный шар #2", "Воздушный шар #2", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно летать.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19334, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Воздушный шар #3", "Воздушный шар #3", "Воздушный шар #3", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно летать.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19335, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Воздушный шар #4", "Воздушный шар #4", "Воздушный шар #4", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно летать.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19336, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Воздушный шар #5", "Воздушный шар #5", "Воздушный шар #5" , "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно летать.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19337, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Воздушный шар #6", "Воздушный шар #6", "Воздушный шар #6", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно летать.", 0.000000, 0.000000, 0.000000, 1.00000},
    {19338, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Воздушный шар #7", "Воздушный шар #7", "Воздушный шар #7"  , "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно летать.", 0.000000, 0.000000, 0.000000, 1.00000},
    {1609, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Turtle on", "Черепаха на спину", "Аксессуар: {FDCF28}Черепаха на спину", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 160.000000, 174.000000, 195.000000, 1.000000},
	{16776, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Chicken on", "Курица на плечо", "Аксессуар: {FDCF28}Курица на плечо", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить в донате.\nМожно надеть.", 160.000000, 174.000000, 195.000000, 1.000000},
	{19064, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Новогодняя шапка", "Новогодняя шапка", "Аксессуар: {FDCF28}Новогодняя шапка", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
	{19065, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Новогодняя шапка с надписью Merry Xmas", "Новогодняя шапка с надписью Merry Xmas", "Аксессуар: {FDCF28}Новогодняя шапка с надписью Merry Xmas", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
	{19066, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Новогодняя шапка с надписью Happy Xmas", "Новогодняя шапка с надписью Happy Xmas", "Аксессуар: {FDCF28}Новогодняя шапка с надписью Happy Xmas", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
	{1212, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Деньги на спину", "Деньги на спину", "Аксессуар: {FDCF28}Деньги на спину", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
	{1254, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Череп на грудь", "Череп на грудь", "Аксессуар: {FDCF28}Череп на грудь", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
	{341, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Бензопила", "Бензопила", "Аксессуар: {FDCF28}Бензопила", "{FFFFFF}Можно получить в магазине {FDCF28}аксессуаров{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 112.000000, 2.368091},
	{3056, true, 1, "1", "PUT", "HAѓET’", 0x333333FF, 0x333333FF, "Магнит на спину", "Магнит на спину", "Аксессуар: {FDCF28}Магнит на спину", "{FFFFFF}Можно получить в {FDCF28}донате{FFFFFF},\nили купить на центральном рынке.\nМожно надеть.", 0.000000, 0.000000, 0.000000, 1.00000},
	{18846, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Hallowen Nabor", "Hallowen тюнинг", "Предмет: {FDCF28}Hallowen тюнинг", "{FFFFFF}Можно получить в донате.\n{FFD700}Можно использовать на модели: {FFFF00}Infernus, Chetah, Huntley, Maverick, Turismo, Clover\nАктивация: Use в инвентаре", 90.000000, 0.000000, 90.000000, 0.811783},
	{1097, true, 1, "", "USE", "…CЊO‡’€OBAT’", 0x333333FF, 0x333333FF, "Newyear Nabor", "Новогодний тюнинг", "Предмет: {FDCF28}Новогодний комплект тюнинга", "{FFFFFF}Можно получить в донате.\n{FFD700}Можно использовать на модели: {FFFF00}Infernus\nАктивация: Use в инвентаре", 90.000000, 0.000000, 90.000000, 0.811783},
	{11722, false, 100, "", "DROP", "B‘ЂPOC…T’", 0x333333FF, 0x333333FF, "Citizen Ticket", "Гражданский талон", "Предмет: {FDCF28}Гражданский талон", "{FFFFFF}Получается каждый PAYDAY если вы используете\nлаунчер{FDCF28} SER LAUNCH{FFFFFF}. Скачать можно на\nсайте проекта: {FDCF28}vk.com/arzser{FFFFFF}\nИспользуется для обмена на ценные товары у\nторговца ЭДВАРДА у площади Центрального банка.", 90.000000, 0.000000, 90.000000, 0.811783}

};
new Transfender[66] =
{
	400, 401, 402, 404, 405, 409, 410, 411, 415, 418, 419, 420, 421, 422, 424, 426,
	429, 436, 438, 439, 442, 445, 451, 458, 466, 467, 474, 475, 477, 478, 479, 480,
	489, 491, 492, 496, 500, 505, 506, 507, 516, 517, 518, 526, 527, 529, 533, 540,
	541, 542, 545, 546, 547, 549, 550, 551, 555, 575, 579, 580, 585, 587, 589, 600,
	602, 603
};
new WheelArchAngels[6] =
{
	558, 559, 560, 561, 562, 565
};
new LocoLowCo[7] =
{
	412, 534, 535, 536, 566, 567, 576
};
new NoneTun[133] =
{
	403, 406, 407, 408, 413, 414, 416, 417, 423, 425, 427, 428, 430, 431, 432, 433,
	434, 435, 437, 440, 441, 443, 444, 446, 447, 448, 449, 450, 452, 453, 454, 455,
	456, 457, 459, 460, 461, 462, 463, 464, 465, 468, 469, 470, 471, 472, 473, 476,
	481, 482, 483, 484, 485, 486, 487, 488, 490, 493, 494, 495, 497, 498, 499, 501,
	502, 503, 504, 508, 509, 510, 511, 512, 513, 514, 515, 519, 520, 521, 522, 523,
	524, 525, 528, 530, 531, 532, 537, 538, 539, 543, 544, 548, 552, 553, 554, 556,
	557, 563, 564, 568, 569, 570, 571, 572, 573, 574, 577, 578, 581, 582, 583, 584,
	586, 588, 690, 591, 592, 593, 594, 595, 596, 597, 598, 599, 601, 604, 605, 606,
	607, 608, 609, 610, 611
};


GetVehicleTuningState( model )
{
	new size[4] = { sizeof(NoneTun), sizeof(Transfender), sizeof(LocoLowCo), sizeof(WheelArchAngels) };

	for(new i; i < size[0]; i ++)
	{
		if(i < size[0] && model == NoneTun[i]) return 0;
		else if(i < size[1] && model == Transfender[i]) return 1;
		else if(i < size[2] && model == LocoLowCo[i]) return 2;
		else if(i < size[3] && model == WheelArchAngels[i]) return 3;
	}
	return -1;
}
enum csInfo
{
	csName[30],
	csCategory[30],
	csMods[30]
}
new CarsInfo[212][csInfo] =
{
	{ "Landstalker", "Off Road", "Transfender" }, // 400
	{ "Bravura", "Saloons", "Transfender" }, // 401
	{ "Buffalo", "Sport Vehicles", "Transfender" }, // 402
	{ "Linerunner", "Industrial", "None" }, // 403
	{ "Perenniel", "Station Wagons", "Transfender" }, // 404
	{ "Sentinel", "Saloons", "Transfender" }, // 405
	{ "Dumper", "Unique Vehicles", "None" }, // 406
	{ "Firetruck", "Public Service", "None" }, // 407
	{ "Trashmaster", "Industrial", "None" }, // 408
	{ "Stretch", "Unique Vehicles", "Transfender" }, // 409
	{ "Manana", "Saloons", "Transfender" }, // 410
	{ "Infernus", "Sport Vehicles", "Transfender" }, // 411
	{ "Voodoo", "Lowriders", "Loco Low Co" }, // 412
	{ "Pony", "Industrial", "None" }, // 413
	{ "Mule", "Industrial", "None" }, // 414
	{ "Cheetah", "Sport Vehicles", "Transfender" }, // 415
	{ "Ambulance", "Public Service", "None" }, // 416
	{ "Leviathan", "Helicopters", "None" }, // 417
	{ "Moonbeam", "Station Wagons", "Transfender" }, // 418
	{ "Esperanto", "Saloons", "Transfender" }, // 419
	{ "Taxi", "Public Service", "Transfender" }, // 420
	{ "Washington", "Saloons", "Transfender" }, // 421
	{ "Bobcat", "Industrial", "Transfender" }, // 422
	{ "Mr Whoopee", "Unique Vehicles", "None" }, // 423
	{ "BF Injection", "Off Road", "Transfender" }, // 424
	{ "Hunter", "Helicopters", "None" }, // 425
	{ "Premier", "Saloons", "Transfender" }, // 426
	{ "Enforcer", "Public Service", "None" }, // 427
	{ "Securicar", "Unique Vehicles", "None" }, // 428
	{ "Banshee", "Sport Vehicles", "Transfender" }, // 429
	{ "Predator", "Boats", "None" }, // 430
	{ "Bus", "Public Service", "None" }, // 431
	{ "Rhino", "Public Service", "None" }, // 432
	{ "Barracks", "Public Service", "None" }, // 433
	{ "Hotknife", "Unique Vehicles", "None" }, // 434
	{ "Article Trailer", "Trailers", "None" }, // 435
	{ "Previon", "Saloons", "Transfender" }, // 436
	{ "Coach", "Public Service", "None" }, // 437
	{ "Cabbie", "Public Service", "Transfender" }, // 438
	{ "Stallion", "Convertibles", "Transfender" }, // 439
	{ "Rumpo", "Industrial", "None" }, // 440
	{ "RC Bandit", "RC Vehicles", "None" }, // 441
	{ "Romero", "Unique Vehicles", "Transfender" }, // 442
	{ "Packer", "Industrial", "None" }, // 443
	{ "Monster", "Off Road", "None" }, // 444
	{ "Admiral", "Saloons", "Transfender" }, // 445
	{ "Squallo", "Boats", "None" }, // 446
	{ "Seasparrow", "Helicopters", "None" }, // 447
	{ "Pizzaboy", "Bikes", "None" }, // 448
	{ "Tram", "Unique Vehicles", "None" }, // 449
	{ "Article Trailer 2", "Trailers", "None" }, // 450
	{ "Turismo", "Sport Vehicles", "Transfender" }, // 451
	{ "Speeder", "Boats", "None" }, // 452
	{ "Reefer", "Boats", "None" }, // 453
	{ "Tropic", "Boats", "None" }, // 454
	{ "Flatbed", "Industrial", "None" }, // 455
	{ "Name", "Industrial", "None" }, // 456
	{ "Caddy", "Unique Vehicles", "None" }, // 457
	{ "Solair", "Station Wagons", "Transfender" }, // 458
	{ "Berkley's RC Van", "Industrial", "None" }, // 459
	{ "Skimmer", "Airplane", "None" }, // 460
	{ "PCJ-600", "Bikes", "None" }, // 461
	{ "Faggio", "Bikes", "None" }, // 462
	{ "Freeway", "Bikes", "None" }, // 463
	{ "RC Baron", "RC Vehicles", "None" }, // 464
	{ "RC Raider", "RC Vehicles", "None" }, // 465
	{ "Glendale", "Saloons", "Transfender" }, // 466
	{ "Oceanic", "Saloons", "Transfender" }, // 467
	{ "Sanchez", "Bikes", "None" }, // 468
	{ "Sparrow", "Helicopters", "None" }, // 469
	{ "Patriot", "Off Road", "None" }, // 470
	{ "Quad", "Bikes", "None" }, // 471
	{ "Coastguard", "Boats", "None" }, // 472
	{ "Dinghy", "Boats", "None" }, // 473
	{ "Hermes", "Saloons", "Transfender" }, // 474
	{ "Sabre", "Sport Vehicles", "Transfender" }, // 475
	{ "Rustler", "Airplane", "None" }, // 476
	{ "ZR-350", "Sport Vehicles", "Transfender" }, // 477
	{ "Walton", "Industrial", "Transfender" }, // 478
	{ "Regina", "Station Wagons", "Transfender" }, // 479
	{ "Comet", "Convertibles", "Transfender" }, // 480
	{ "BMX", "Bikes", "None" }, // 481
	{ "Burrito", "Industrial", "None" }, // 482
	{ "Camper", "Unique Vehicles", "None" }, // 483
	{ "Marquis", "Boats", "None" }, // 484
	{ "Baggage", "Unique Vehicles", "None" }, // 485
	{ "Dozer", "Unique Vehicles", "None" }, // 486
	{ "Maverick", "Helicopters", "None" }, // 487
	{ "SAN News Maverick", "Helicopters", "None" }, // 488
	{ "Rancher", "Off Road", "Transfender" }, // 489
	{ "FBI Rancher", "Public Service", "None" }, // 490
	{ "Virgo", "Saloons", "Transfender" }, // 491
	{ "Greenwood", "Saloons", "Transfender" }, // 492
	{ "Jetmax", "Boats", "None" }, // 493
	{ "Hotring Racer", "Sport Vehicles", "None" }, // 494
	{ "Sandking", "Off Road", "None" }, // 495
	{ "Blista Compact", "Sport Vehicles", "Transfender" }, // 496
	{ "Police Maverick", "Helicopters", "None" }, // 497
	{ "Boxville", "Industrial", "None" }, // 498
	{ "Benson", "Industrial", "None" }, // 499
	{ "Mesa", "Off Road", "Transfender" }, // 500
	{ "RC Goblin", "RC Vehicles", "None" }, // 501
	{ "Hotring Racer", "Sport Vehicles", "None" }, // 502
	{ "Hotring Racer", "Sport Vehicles", "None" }, // 503
	{ "Bloodring Banger", "Saloons", "None" }, // 504
	{ "Rancher", "Off Road", "Transfender" }, // 505
	{ "Super GT", "Sport Vehicles", "Transfender" }, // 506
	{ "Elegant", "Saloons", "Transfender" }, // 507
	{ "Journey", "Unique Vehicles", "None" }, // 508
	{ "Bike", "Bikes", "None" }, // 509
	{ "Mountain Bike", "Bikes", "None" }, // 510
	{ "Beagle", "Airplane", "None" }, // 511
	{ "Cropduster", "Airplane", "None" }, // 512
	{ "Stuntplane", "Airplane", "None" }, // 513
	{ "Tanker", "Industrial", "None" }, // 514
	{ "Roadtrain", "Industrial", "None" }, // 515
	{ "Nebula", "Saloons", "Transfender" }, // 516
	{ "Majestic", "Saloons", "Transfender" }, // 517
	{ "Buccaneer", "Saloons", "Transfender" }, // 518
	{ "Shamal", "Airplane", "None" }, // 519
	{ "Hydra", "Airplane", "None" }, // 520
	{ "FCR-900", "Bikes", "None" }, // 521
	{ "NRG-500", "Bikes", "None" }, // 522
	{ "HPV1000", "Public Service", "None" }, // 523
	{ "Cement Truck", "Industrial", "None" }, // 524
	{ "Towtruck", "Unique Vehicles", "None" }, // 525
	{ "Fortune", "Saloons", "Transfender" }, // 526
	{ "Cadrona", "Saloons", "Transfender" }, // 527
	{ "FBI Truck", "Public Service", "None" }, // 528
	{ "Willard", "Saloons", "Transfender" }, // 529
	{ "Forklift", "Unique Vehicles", "None" }, // 530
	{ "Tractor", "Industrial", "None" }, // 531
	{ "Combine Harvester", "Unique Vehicles", "None" }, // 532
	{ "Feltzer", "Convertibles", "Transfender" }, // 533
	{ "Remington", "Lowriders", "Loco Low Co" }, // 534
	{ "Slamvan", "Lowriders", "Loco Low Co" }, // 535
	{ "Blade", "Lowriders", "Loco Low Co" }, // 536
	{ "Freight (Train)", "Unique Vehicles", "None" }, // 537
	{ "Brownstreak (Train)", "Unique Vehicles", "None" }, // 538
	{ "Vortex", "Unique Vehicles", "None" }, // 539
	{ "Vincent", "Saloons", "Transfender" }, // 540
	{ "Bullet", "Sport Vehicles", "Transfender" }, // 541
	{ "Clover", "Saloons", "Transfender" }, // 542
	{ "Sadler", "Industrial", "None" }, // 543
	{ "Firetruck LA", "Public Service", "None" }, // 544
	{ "Hustler", "Unique Vehicles", "Transfender" }, // 545
	{ "Intruder", "Saloons", "Transfender" }, // 546
	{ "Primo", "Saloons", "Transfender" }, // 547
	{ "Cargobob", "Helicopters", "None" }, // 548
	{ "Tampa", "Saloons", "Transfender" }, // 549
	{ "Sunrise", "Saloons", "Transfender" }, // 550
	{ "Merit", "Saloons", "Transfender" }, // 551
	{ "Utility Van", "Industrial", "None" }, // 552
	{ "Nevada", "Airplane", "None" }, // 553
	{ "Yosemite", "Industrial", "None" }, // 554
	{ "Windsor", "Convertibles", "Transfender" }, // 555
	{ "Monster \"A\"", "Off Road", "None" }, // 556
	{ "Monster \"B\"", "Off Road", "None" }, // 557
	{ "Uranus", "Sport Vehicles", "Wheel Arch Angels" }, // 558
	{ "Jester", "Sport Vehicles", "Wheel Arch Angels" }, // 559
	{ "Sultan", "Saloons", "Wheel Arch Angels" }, // 560
	{ "Stratum", "Station Wagons", "Wheel Arch Angels" }, // 561
	{ "Elegy", "Saloons", "Wheel Arch Angels" }, // 562
	{ "Raindance", "Helicopters", "None" }, // 563
	{ "RC Tiger", "RC Vehicles", "None" }, // 564
	{ "Flash", "Sport Vehicles", "Wheel Arch Angels" }, // 565
	{ "Tahoma", "Lowriders", "Loco Low Co" }, // 566
	{ "Savanna", "Lowriders", "Loco Low Co" }, // 567
	{ "Bandito", "Off Road", "None" }, // 568
	{ "Freight Flat Trailer (Train)", "Trailers", "None" }, // 569
	{ "Streak Trailer (Train)", "Trailers", "None" }, // 570
	{ "Kart", "Unique Vehicles", "None" }, // 571
	{ "Mower", "Unique Vehicles", "None" }, // 572
	{ "Dune", "Off Road", "None" }, // 573
	{ "Sweeper", "Unique Vehicles", "None" }, // 574
	{ "Broadway", "Lowriders", "Transfender" }, // 575
	{ "Tornado", "Lowriders", "Loco Low Co" }, // 576
	{ "AT400", "Airplane", "None" }, // 577
	{ "DFT-30", "Industrial", "None" }, // 578
	{ "Huntley", "Off Road", "Transfender" }, // 579
	{ "Stafford", "Saloons", "Transfender" }, // 580
	{ "BF-400", "Bikes", "None" }, // 581
	{ "Newsvan", "Industrial", "None" }, // 582
	{ "Tug", "Unique Vehicles", "None" }, // 583
	{ "Petrol Trailer", "Trailers", "None" }, // 584
	{ "Emperor", "Saloons", "Transfender" }, // 585
	{ "Wayfarer", "Bikes", "None" }, // 586
	{ "Euros", "Sport Vehicles", "Transfender" }, // 587
	{ "Hotdog", "Unique Vehicles", "None" }, // 588
	{ "Club", "Sport Vehicles", "Transfender" }, // 589
	{ "Freight Box Trailer (Train)", "Trailers", "None" }, // 590
	{ "Article Trailer 3", "Trailers", "None" }, // 591
	{ "Andromada", "Airplane", "None" }, // 592
	{ "Dodo", "Airplane", "None" }, // 593
	{ "RC Cam", "RC Vehicles", "None" }, // 594
	{ "Launch", "Boats", "None" }, // 595
	{ "Police Car (LSPD)", "Public Service", "None" }, // 596
	{ "Police Car (SFPD)", "Public Service", "None" }, // 597
	{ "Police Car (LVPD)", "Public Service", "None" }, // 598
	{ "Police Ranger", "Public Service", "None" }, // 599
	{ "Picador", "Industrial", "Transfender" }, // 600
	{ "S.W.A.T.", "Public Service", "None" }, // 601
	{ "Alpha", "Sport Vehicles", "Transfender" }, // 602
	{ "Phoenix", "Sport Vehicles", "Transfender" }, // 603
	{ "Glendale Shit", "Saloons", "None" }, // 604
	{ "Sadler Shit", "Industrial", "None" }, // 605
	{ "Baggage Trailer \"A\"", "Trailers", "None" }, // 606
	{ "Baggage Trailer \"B\"", "Trailers", "None" }, // 607
	{ "Tug Stairs Trailer", "Trailers", "None" }, // 608
	{ "Boxville", "Industrial", "None" }, // 609
	{ "Farm Trailer", "Trailers", "None" }, // 610
	{ "Utility Trailer", "Trailers", "None" } // 611
};
new ItemsLavka[41][10];
new ItemsLavkaKolvo[41][10];
new LavkaName[41][24];
new PickLavka[MAX_PLAYERS];
new CostLavkaItem[41][10];
new LavkaID[41];
new LavkaBuys[41];
enum _temp_
{
bool:jBus,
	pArendaCar,
	pcarid,
	pTimer,
Float:pPos[3],
	pPost[3],
	pAntiAir,
bool:SPECTPLAYER,
	BreakKey,
	PT_AntiFlood,
	BreakCount,
	BreakTime,
	pWW[MAX_PLAYERS],
	pLavka,
	pmyLavka,
	pItemLavka,
	pSellCar,
	pDeathCar,
	pKladProgress,
	pKladKey,
	pKladID,
	pKladOtevet[256],
	pKladVopID
}
new pTemp[MAX_PLAYERS][_temp_];
#define Name(%0) PlayerName[%0]
//
new NumberLot[200][256], WinnerLot[6][256], TimeLot, CheckBilet[MAX_PLAYERS], PlayersJoin, BankMoney, StatusLotery;
//
new AcceptGoogle[MAX_PLAYERS];
new GoogleCodeTemp[64][MAX_PLAYERS];
new AndruxaTop[MAX_PLAYERS];
new ZapretDice[MAX_PLAYERS];
new KostiName[MAX_PLAYERS];
new KostiMoney[MAX_PLAYERS];
new LoadLicCar[2000];
new LoadLicMoto[2000];
new LoadLicFly[2000];
new LoadLicBoat[2000];
new LoadLicGun[2000];
new StatusMoneta[256][MAX_PLAYERS];
new ZapretOrel[MAX_PLAYERS];
new OrelName[MAX_PLAYERS];
new OrelMoney[MAX_PLAYERS];
//-------------------------------------
new Text:Boxmenu0;
new Text:Boxmenu1;
new Text:Boxmenu2;
new Text:PTarget[4];
new PlayerText:Target4[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:Target6[MAX_PLAYERS] = {PlayerText:-1, ...};
new Text:BoxTaxi1;
new Text:BoxTaxi2;
new Text:Taximonitor;
new Text:TaxiDol;
new Text:TaxiServ;
//-------------------------
new Text:IconsMenu[12];
new TheftKey[MAX_PLAYERS];
new TheftCount[MAX_PLAYERS];
new TheftTime[MAX_PLAYERS];
new Float:JobsPos[3][3] =
{
	{1970.6949,-1964.2100,13.5742},
	{-27.3830,163.9576,2.4367},
	{-86.3118,-304.8957,1.4219}
};
enum JobsPosInfo
{
Float:Position[2],
	JobsId
};
//пилюля
new JobsInfo[JobsPosInfo];
//-------------------news--------------
new RobKey[MAX_PLAYERS];
new RobTime[MAX_PLAYERS];
new RobCount[MAX_PLAYERS];
//new UnSpeedZone;
new ArrestID[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
//-------------------------------------
new bool:RP_Names = true;//RP ники
//-------------------------------------
new RegPass[MAX_PLAYERS][30];
new RegSex[MAX_PLAYERS];
new RegRace[MAX_PLAYERS];
new RegReferal[MAX_PLAYERS][24];
//-------------------------------------
new TeamDuty[MAX_PLAYERS];
new PlayerBuyState[MAX_PLAYERS];
new RPTest[MAX_PLAYERS];
new MusorObject[MAX_MUSORS] = {-1, ...};
new MusorCP[MAX_MUSORS] = {-1, ...};
new MusorCOP[MAX_MUSORS];
new MusorCar[MAX_MUSORS] = {-1, ...};
new NowMusor[MAX_VEHICLES] = {-1, ...};
new TempMusorObject[MAX_MUSORS] = {-1, ...};
new Temp2MusorObject[MAX_MUSORS] = {-1, ...};
new TempMusorMusor[20000] = {-1, ...}; //мусор
new MusorovozPlayer[MAX_VEHICLES] = {INVALID_PLAYER_ID, ...};
new CarMusorCount[MAX_VEHICLES];

new CarproductCount[MAX_VEHICLES];
new CarproductType[MAX_VEHICLES];

new MusorCount[MAX_MUSORS] = {100, ...};
new Text3D:MusorText[MAX_MUSORS] = {NONE_3D_TEXT, ...};
new Text3D:MusorCarText[MAX_VEHICLES] = {NONE_3D_TEXT, ...};
new Text3D:AutobCarText[MAX_VEHICLES] = {NONE_3D_TEXT, ...};

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
new BenzinCount[MAX_VEHICLES];
new Float:BenzinCena[MAX_VEHICLES];
new Contracter[MAX_VEHICLES];
new Text3D:Benzin[MAX_VEHICLES] = {NONE_3D_TEXT, ...};
//==============================================================================
new Text3D:Product[MAX_VEHICLES] = {NONE_3D_TEXT, ...};
new Text3D:TrainText[MAX_VEHICLES] = {NONE_3D_TEXT, ...};
//
new bool:RemoveObject[20000] = {false, ...}; //мусор
new SvalkaCP[3];
new NomerCP;
new TimeOfCuff[MAX_PLAYERS];
new PlayerOfCuff[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
//-------------------------------------
new PlayerText:PlayerCarHPDraw[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:MilageDraw[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:ActionText[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:ActionBand[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:TaxiDraw[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:InfoText[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:PlayerFuelBar[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:FuelCostDraw[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:FuelCountDraw[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:KindFuelDraw[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:AimNameDraw[MAX_PLAYERS] = {PlayerText:-1, ...};
new PlayerText:HInfoDraw[MAX_PLAYERS][6];
new FactoryClothes;
/////////
new Ring[MAX_PLAYERS];
new Merrit[4];
/////////
new Text:FuelDrawBG[2];
new Text:FuelNextKey[2];
new Text:FuelBackKey[2];
new Text:FuelNextBG[2];
new Text:FuelKeyDraw[10];
new Text:FuelKeyBG;
new Text:FuelBarDraw;
new Text:FuelSelectDraw;
new Text:FuelCancelDraw;
new Text:FuelOtherDraw;
new Text:BandDrawBG[2];
new Text:ShieldBG[2];
new Bar_CP[MAX_BARSs] = {-1, ...};
new ScrapCP;
new Yakydzapick;
new Eatery_CP[MAX_EATCP] = {-1, ...};
new FirstReferal[MAX_PLAYERS];
new FirstBL[MAX_PLAYERS];
new TazerPlayer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new ResetGunsUP[MAX_PLAYERS];
new Signal[MAX_VEHICLES];
new Float:SignalAngle[MAX_VEHICLES];
new SignalTick[MAX_VEHICLES][2];
new ShowJobID[MAX_PLAYERS];
new CreditMoney[MAX_PLAYERS];
new CarPound_CP[2] = -1;
new Zek_CP = -1;
new RingCP = -1;
new MeriaGun = -1;
new Text:boxaccept;
new Text:boxcancel;
new Text:Boxmenu3;
new Text:ButtonLeft;
new Text:ButtonRight;
new Text:ButtonUp;
new Text:ButtonDown;
new Text:ButtonCancel;
new Text:ButtonSelect;
//петя
new BuyGun_CP = -1;
new Reklam;
new BuyGunAmmo[MAX_PLAYERS] = {-1, ...};
new BuyGuns[MAX_PLAYERS] = {-1, ...};
new CaptureDef = -1;
new CaptureAtac = -1;
new CaptureDefKill = 0;
new CaptureAtacKill = 0;
new CaptureTime[2];
new CaptureZone = -1;
//////////////мафии
new BizAtack;
new BizDeff;
new BizAtakkill;
new BizDeffkill;
new BizTime[2];
new BizWar = -1;
new ClickBiz[MAX_PLAYERS];
new BizWarState;
new PlaceWar;
new HealExitPickup = -1;
new EnterBankPickup;
new ExitBankPickup;
new zakazbanner;
new RecoveryTime[MAX_ORGS];
new VehicleState[MAX_VEHICLES];
new LoadIntro[MAX_PLAYERS];
new CarScrap[MAX_VEHICLES] = {-1,...};

new SobesStatus[MAX_ORGS];
new SobesTime[MAX_ORGS][16];
new SobesTime1[MAX_ORGS];
new SobesTime2[MAX_ORGS];
new SobesMesto[MAX_ORGS][16];

new avtock[MAX_VEHICLES] = {-1,...};
//----------------COUNT------------------------------
new OWNABLECARS;
//new MAX_OWNABLE;
//new REGISTER_ACCOUNTS;
new MAX_SALONS_OWNABLECARS;
new OWNABLEHOUSES;
new OWNABLEBIZES;
new ADD_VEHICLES;
new ADD_OBJECTS;
new GANGZONES;
new OWNABLEHOTELS;
new OWNABLECASINO;
new TOTALFAMILY;
new ShowBiz[MAX_PLAYERS][MAX_BIZ];
new ShowHouse[MAX_PLAYERS][MAX_HOUSES];
//----------------COUNT------------------------------
new ARENDCARS;
new ArendCar[ArendCars] = INVALID_VEHICLE_ID;
new ArendKey[MAX_PLAYERS] = INVALID_VEHICLE_ID;
new HotelCP[MAX_OWNABLEHOTELS] = {-1, ...};

new CasinoCPEn[MAX_OWNABLECASINO];
new CasinoCPEx[MAX_OWNABLECASINO];

new Text3D:HotelText[MAX_OWNABLEHOTELS] = {NONE_3D_TEXT, ...};
new EnterHotel[MAX_PLAYERS];

new EnterCasino[MAX_PLAYERS];

new PAYDAY = 0;
new engine,lights,alarm,doors,bonnet,boot,objective;
new Binko_CP = -1;
new ResetShield[MAX_PLAYERS];
new SelectPost[MAX_PLAYERS];
new DListitem[MAX_PLAYERS][100];

new DBizitem[MAX_PLAYERS][22];

new HideMapZone;
new ConteinerGate;
//new TempTazerObject[MAX_PLAYERS] = {-1, ...};
new PddState[MAX_PLAYERS];
//new TazerReset[MAX_PLAYERS];
//new TazerFire[MAX_PLAYERS];
new ZavodPutCP[8];
new ZavodClotherCP[6];
new FuelName[4][15] =
{
	"Diesel", "A-92", "A-95", "A-98"
};
enum InfoDutyPos
{
Float: dutyposX,
Float: dutyposY,
Float: dutyposZ,
	dutyposWorld
}
new Float:DutyPos[MAX_ORGS][InfoDutyPos] =
{
	{0.0, 0.0, 0.0,-1}, //No-ne
	{115.9709,1059.8071,-48.9141,-1}, //LSPD
	{992.7068,343.9906,1004.2559,11}, //RCPD
	{1159.5627,375.9140,1002.1450,-1}, //FBI
	{-137.9424,2103.8669,-44.6921,0}, //SFPD
	{-1775.2759,-1993.5759,1500.7853,1}, //M4C
	{-2068.6094,2701.8665,1500.9766,-1}, //Meria
	{229.3034,1327.2250,1518.9469,-1}, //ARMY LV
	{-1775.2759,-1993.5759,1500.7853,3}, //деревенская больница
	{-2584.9182,-1392.8623,1500.7570,-1}, //Licensers
	{2703.4834,-1196.7268,1271.5940,1}, //Radio
	{0.0, 0.0, 0.0,-1},
	{0.0, 0.0, 0.0,-1},
	{0.0, 0.0, 0.0,-1},
	{0.0, 0.0, 0.0,-1},
	{0.0, 0.0, 0.0,-1},
	{0.0, 0.0, 0.0,-1},
	{0.0, 0.0, 0.0,-1},
	{0.0, 0.0, 0.0,-1},
	{0.0, 0.0, 0.0,-1},
	{458.9460,879.7646,1500.9648,-1}, //army
	{-2687.4424,819.7822,1500.9707,-1},
	{-1775.2759,-1993.5759,1500.7853,2},
	{-1469.9508,2602.1035,15.9518,12},//LVPD
	{-210.9723,1297.0559,1507.6692,2}, //Radio lv
	{0.0, 0.0, 0.0,-1},
	{-1759.9695,802.9260,137.4583,0}, //Radio SF
	{-271.7655,799.2141,1500.9608,-1},//armysf
	{1409.4736,2211.6663,1500.9758,-1}//Тюрьма строгого режима
};
new TeamDutyCP[MAX_ORGS];

new Float:BuyPos[1][3] =
{
	{-78.0437,-86.8117,1003.5469}
};
//-------------------------------
new RankName[MAX_ORGS][10][50];
//----------Tir New's----------------
new Tir_CP[MAX_TIRS];
new Text3D:TirText[MAX_TIRS] = {NONE_3D_TEXT, ...};
new PlayerTir[MAX_PLAYERS];
new TirPlayer[MAX_PLAYERS];
new HitCount[MAX_PLAYERS][5];
new TargetCount[MAX_PLAYERS];
new Target_Object[MAX_TIRS];
new TargetTimer[MAX_TIRS] = {-1,...};
new TirGun[MAX_PLAYERS];
new TirAmmo[MAX_PLAYERS];
new bool:TirBusy[MAX_TIRS];
new bool:TargetGo[MAX_TIRS];
new bool:HitPoint[MAX_PLAYERS][5];
new Text:TirDraw[5];
new Text:TirBGDraw;

new Float:TargetMoveSpeed[MAX_PLAYERS];
new TimerTime[MAX_PLAYERS];
new StartCount[MAX_PLAYERS];
new BeforeFill[MAX_VEHICLES];
new PlayerText:DeathDraw[MAX_PLAYERS] = {PlayerText:-1, ...};
new Cheat1,Text:CheatText[15];
new KindFuel[MAX_PLAYERS];
new Float:CountFuel[MAX_PLAYERS];
new bool:ShowFuelKeys[MAX_PLAYERS];
new PlayerFuel[MAX_PLAYERS];
//--------------------------------------
new NumInc_CP[MAX_PLAYERS] = {-1, ...};
//new JobCar[MAX_PLAYERS];
//new IncReset[MAX_PLAYERS];
new Inc_CP[2] = -1;
enum zdInfo
{
	zdObject,
	zdPlayer,
	zdTimer
}



new Text3D:NarkoText[5];

new Text3D:FactoryText[3];
new FactoryFerum;
new FactoryMats;
new FactoryFuel;
new BONUSDONATE;
new BONUSMONEY;
new BONUSLVL;
new MPName[256];
new MPHealth;
new MPArmour;
new MPPlayerLimit;
new MPPlayersLimit;
new MPTime;
new MPTimeStatic;
new MPWeapon;
new MPTeleport;
new MPTeleportPlayer[MAX_PLAYERS];
new InJob[MAX_PLAYERS];
new FireCount[MAX_PLAYERS];
new Fish_CP[50];
//---------------bools------------------
new Taxi_GO[MAX_PLAYERS];
new bool:Cuffed[MAX_PLAYERS];
new bool:IsPlayerSpawned[MAX_PLAYERS];
new bool:Controllable[MAX_PLAYERS];
new bool:Crack[MAX_PLAYERS];
new bool:TaxiON[MAX_PLAYERS];
new bool:MedikON[MAX_PLAYERS];
new bool:MehanON[MAX_PLAYERS];
new bool:PoliseON[MAX_PLAYERS];
new bool:Fishing[MAX_PLAYERS];
new ADuty[MAX_PLAYERS];
new IsPlayerLogged[MAX_PLAYERS];
//--------------------------------------
new TheifTime[MAX_PLAYERS];
new TheifMoney[MAX_PLAYERS];
new TheifCount[MAX_PLAYERS];
new TheifKey[MAX_PLAYERS];
//--------------------------------------
new NoEnterPickup[MAX_PLAYERS];
new ShowIpTime[MAX_PLAYERS];
new DRotTick[MAX_PLAYERS];
new NoStrip[MAX_PLAYERS];
new ReMail[MAX_PLAYERS][50];
new ReMailCode[MAX_PLAYERS];
new SpectatePlayer[MAX_PLAYERS];
new HouseEntered[MAX_PLAYERS];
new GarageEntered[MAX_PLAYERS];
new ParkingEntered[MAX_PLAYERS];
//new GarageEntered[MAX_PLAYERS] = {-1, ...};
new BizEntered[MAX_PLAYERS];
new RegisterState[MAX_PLAYERS];
new Question[MAX_PLAYERS];
new ClickedPlayerID[MAX_PLAYERS];
new FullnessTick[MAX_PLAYERS];
new HouseSkin[MAX_PLAYERS];
new OldFreePlayer[MAX_PLAYERS];
new DamageWarning[MAX_PLAYERS];
new RenameTime[MAX_PLAYERS];
new PlayerDrunkLevel[MAX_PLAYERS];
new PlayerDrunkLevels[MAX_PLAYERS];
new CallTime[MAX_PLAYERS];
new bool:UsingShield[MAX_PLAYERS];
new BuyInt[MAX_PLAYERS] = {-1, ...};
new BuyIntGarage[MAX_PLAYERS] = {-1, ...};
new BuyIntPodval[MAX_PLAYERS] = {-1, ...};
new SetPass[MAX_PLAYERS][30];
new UnbanName[MAX_PLAYERS][24];
new SkinRoulette[MAX_PLAYERS];
new RouletteStarted[MAX_PLAYERS];
new ReportSend[MAX_PLAYERS];
new CraftingStatus[MAX_PLAYERS];
new FarmStatus[MAX_PLAYERS];
new DMStatus[MAX_PLAYERS];
new EventStatus[MAX_PLAYERS];
new TruckReset[MAX_PLAYERS];
new TextReset[MAX_PLAYERS];
new LawyerOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new LiveOfferID[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new LiveOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new TakeOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new HealOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new PlayerJailCP[MAX_PLAYERS];
new PlayerGoPost[MAX_PLAYERS];
new HealPrice[MAX_PLAYERS];
new TicketOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new TicketPrice[MAX_PLAYERS];
new CuffedTime[MAX_PLAYERS];
new Recuffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new HouseOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new HousePrice[MAX_PLAYERS];
new BizOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new RHouseOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new BizPrice[MAX_PLAYERS];
new ShowCar[MAX_PLAYERS][MAX_VEHICLES];
new ShowVeh[MAX_PLAYERS];
new Errors[MAX_PLAYERS];
new DrivingTest[MAX_PLAYERS];
new FlyivingTest[MAX_PLAYERS];
new CreateMats[MAX_PLAYERS];
new CreateMatsCount[MAX_PLAYERS];
new CarTest[MAX_PLAYERS] = {-1, ...};
new FarmJob[MAX_PLAYERS]= {-1, ...};
new Clother[MAX_PLAYERS] = {-1, ...};

new Buyitem[MAX_PLAYERS] = {-1, ...};
new ShowPBiz[MAX_PLAYERS];

new TestASKMassive[MAX_PLAYERS][4];
new TestFASKMassive[MAX_PLAYERS][7];
new Float:vRut[MAX_PLAYERS][2];
new CarPoundTime[MAX_PLAYERS];
new TaxiTarif[MAX_PLAYERS];//Для таксиста
new TaxiPrice[MAX_PLAYERS];//Для пассажира
new TaxiDistance[MAX_PLAYERS];//Для пассажира
new PlayerCar[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
new PlayerSeat[MAX_PLAYERS] = {-1, ...};
new EnterVehicle[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
new Smokes[MAX_PLAYERS];
new Smoke[MAX_PLAYERS];
new SmokeTime[MAX_PLAYERS];
new OldWorld[MAX_PLAYERS];
new TransferPlayer[MAX_PLAYERS];
new GetJob[MAX_PLAYERS];
new TelNumber[MAX_PLAYERS];
new InfoHouse[MAX_PLAYERS];
new PutState[MAX_PLAYERS];
new InfoBiz[MAX_PLAYERS];
new MLeader[MAX_PLAYERS];
new OldMessage[MAX_PLAYERS][150];
new MLPlayer[MAX_PLAYERS];
new GiveItemID[MAX_PLAYERS];
new MLName[MAX_PLAYERS][24];
new SGunMats[MAX_PLAYERS];
new SGunID[MAX_PLAYERS];
new SGunOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new SGunPrice[MAX_PLAYERS];
new SGunAmmo[MAX_PLAYERS];
new OGReset[MAX_PLAYERS];
new HouseCP[MAX_HOUSES] = {-1, ...};
new HouseIcon[MAX_HOUSES] = {-1, ...};
new Text3D:House3DText[MAX_HOUSES] = {NONE_3D_TEXT, ...};
new HouseGaragePickup[MAX_HOUSES] = {-1, ...};
new Text3D:HouseGarage3DText[MAX_HOUSES] =  {NONE_3D_TEXT, ...};
new BizCP[MAX_BIZ] = {-1, ...};
new Text3D:Biz3DText[MAX_BIZ] = {NONE_3D_TEXT, ...};
new BizPick[MAX_BIZ];
new HotelPick[MAX_OWNABLEHOTELS];
new Text3D:Casino3DText[MAX_OWNABLECASINO] = {NONE_3D_TEXT};
new Text3D:CarText[MAX_OWNABLECARS] = {NONE_3D_TEXT, ...};
new CarOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new CarPrice[MAX_PLAYERS];
new DonateBuy[MAX_PLAYERS];
new UnLeaderID[MAX_PLAYERS];
new InviteOffer[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};
new gPlayerLogTries[MAX_PLAYERS];
new PanelPlayerID[MAX_PLAYERS];
new OldDialogID[MAX_PLAYERS];
new aSellCarID[MAX_PLAYERS];
new OwnableCar[MAX_OWNABLECARS];
//new OwnableCar2[MAX_OWNABLECARS];
new PlayerFish[MAX_PLAYERS][5];
new FishMassa[MAX_PLAYERS][5];
new PassRegSex[MAX_PLAYERS];
new ClickedState[MAX_PLAYERS];
//---------------MAX_VEHICLES-------------------------
new AlarmTime[MAX_VEHICLES];
new VehicleSeat[MAX_VEHICLES][50];
new Text3D:TaxiText[MAX_VEHICLES] = {NONE_3D_TEXT, ...};
new UnEngine[MAX_VEHICLES];
new Float:VehicleHealth[MAX_VEHICLES];
//new CarTime[MAX_VEHICLES];
new Float:Fuel[MAX_VEHICLES];
new CarStrips[MAX_VEHICLES];
new gGate[28];
new gBarrier[29];
new SelectTP[MAX_PLAYERS];
new Float:VehicleMilage[MAX_VEHICLES];
//-----------------------------------------------------
////
enum gInfo
{
	gOrg,
	gObID,
Float:gClose_X,
Float:gClose_Y,
Float:gClose_Z,
Float:gClose_A,
Float:gOpen_X,
Float:gOpen_Y,
Float:gOpen_Z,
bool:gOpen,
	gForGateid,
bool:gCreated,
	gWorld
}
enum brInfo
{
	brOrg,
Float:brPos_X,
Float:brPos_Y,
Float:brPos_Z,
Float:brPos_A,
bool:brOpen,
	brForBarrierID
}
enum gsInfo
{
	gsName[20],
Float:gsPosX,
Float:gsPosY,
Float:gsPosZ,
	gsBizzID
}
new GoGunShop[12][gsInfo] =
{
	{"GunShop LS",1359.9208,-1283.6482,13.3461,BIZ_GS_LS},
	{"Palomino Gun",2340.3765,63.1496,26.3359,BIZ_GS_SF},
	{"Blubbery Gun",235.4267,-180.1013,1.4297,BIZ_GS_LV},
	{"LV GunShop",2530.9441,2084.2971,10.6719,LV_AMYN1},
	{"LV Pro Gun",2093.8525,2052.8147,10.8203,LV_AMYN2},
	{"FC Gun",-302.5458,827.9150,13.2947,LV_AMYN3},
	{"EQ Gun",-1510.5068,2603.7961,55.6909,LV_AMYN4},
	{"Ammo",2352.1777,-1463.4926,24.0000,BIZ_GS_LV7},
	{"SF Guns",-2625.7246,209.2422,4.6199,115},
	{"SF Guns",-2163.4663,129.3818,35.3203,116},
	{"SF Guns",-2051.9065,553.7458,35.1719,117},
	{"Angel Guns",-2093.6995,-2464.9138,30.6250,118}

};
enum gfinfo
{
	gfName[20],
Float:gfPos_X,
Float:gfPos_Y,
Float:gfPos_Z,
	gfBizzID
}
new GoFuelCP[21];
new GoGunShopCP[12];
new GoFuel[21][gfinfo] =
{
	{"Gas LS 1",1004.4177,-940.2440,42.1797,BIZ_GAS_LS_1},
	{"Gas LS 2",1944.3726,-1773.2112,13.3906,BIZ_GAS_LS_2},
	{"Gas LS 3",300.1025,-172.2511,1.3289,BIZ_GAS_LV_2},
	{"Gas LS 4",653.9818,-569.3989,16.3359,BIZ_GAS_LV_4},
	{"Gas LS 5",612.1644,-1511.0835,14.9344,BIZ_GAS_LV_5},
	{"Gas LS 6",1378.2557,456.6682,19.8868,BIZ_GAS_LV_6},
	{"Gas LV 1",2202.4253,2473.4390,10.8203,BIZ_AZS1},
	{"Gas LV 2",1598.4116,2199.1228,10.8203,BIZ_AZS2},
	{"Gas LV 3",611.7775,1694.6161,6.9922,BIZ_AZS3},
	{"Gas LV 4",2145.7642,2748.0129,10.8203,BIZ_AZS4},
	{"Gas LV 5",-1328.3707,2677.3887,50.0625,BIZ_AZS5},
	{"Gas LV 6",-1472.3184,1864.2222,32.6328,BIZ_AZS6},
	{"Gas LV 7",2640.2454,1106.1993,10.8203,180},
	{"Gas SF 1",-98.7537,-1166.8053,2.5993,21},//dirka
	{"Gas SF 2",22.4816,-2646.1042,40.4618,27},
	{"Gas SF 3",-1606.3723,-2713.6147,48.5335,22},
	{"Gas SF 4",-2249.9185,-2558.6838,31.8938,25},
	{"Gas SF 5",-1666.6174,408.5915,7.1797,26},
	{"Gas SF 6",-2022.0974,155.9591,28.8359,23},
	{"Gas SF 7",-2261.1799,-2.6144,35.1719,29},
	{"Gas SF 8",-2405.7432,974.6953,45.2969,24}
};
new BarrierInfo[27][brInfo] =
{
	{TEAM_NONE, 		1640.88, -1147.39, 22.91, 0.00, false, -1},
	{TEAM_MERIALS,    	1521.98, -1282.21, 13.45,0.00, false, -1},
	{TEAM_LSPD,    		1544.71, -1630.79, 12.36,-90.00, false, -1},
	{TEAM_ARMYLV, 		1152.94, 1362.98, 9.76,   360.00, false, -1},
	{TEAM_RM, 			997.12, 1752.23, 9.74,   269.34, false, -1},
	{TEAM_RM, 			997.09, 1707.56, 9.74,   269.34, false, -1},
	{TEAM_NONE, 		2478.63, 2516.68, 9.79,    90.07, false, -1},
	{TEAM_NONE, 		2523.94, 2424.26, 9.79,    179.62, false, -1},
	{TEAM_NONE, 		-75.67, -349.27, 0.40,    89.15, false, -1},
	{TEAM_MEDICLV, 		1637.15, 1829.90, 9.63,    269.13, false, -1},
	{TEAM_MEDICLV, 		1577.66, 1829.97, 9.63,    270.69, false, -1},
	{TEAM_PDLV, 		2238.18, 2450.46, 9.80,    -90.00, false, -1},
	{TEAM_RADIOLV, 		2617.45, 1169.65, 9.65,    268.97, false, -1},
	{TEAM_NONE, 		428.671,615.601,17.941,    34.000, false, -1},
	{TEAM_NONE, 		423.585,599.148,17.941,    213.997, false, -1},
	{TEAM_NONE, 		-144.712,482.638,11.078,    165.997, false, -1},
	{TEAM_NONE, 		-128.746,490.219,10.383,    345.992, false, -1},
	//KPP LS-LV
	{TEAM_NONE, 	1792.503540, 811.798828, 9.942500,    0.0, false, -1},
	{TEAM_NONE, 	1808.153442, 811.798828, 9.942500,    0.0, false, -1},
	//KPP LS
	{TEAM_NONE, 	59.734100, -1521.458862, 3.944200,    82.0, false, -1},
	{TEAM_NONE, 	57.626400, -1536.844482, 3.944200,    82.0, false, -1},
	//Автобазар
	{TEAM_NONE, -2154.069580, -745.830383, 31.006355, 90.00, false, -1},
	{TEAM_NONE, -2154.069580, -967.349243, 31.006355, 90.00, false, -1},
	//
	{TEAM_SFPD,			-1701.43, 687.59, 23.88, 90.00, false, -1},
	{TEAM_SFPD,			-1572.20, 658.84, 6.08, 270.00, false, -1},
	{TEAM_ARMYSF,		-1526.3906, 481.3828, 6.1797, 360.0000, false, -1},
	//Контейнеры
	{TEAM_NONE, 		-1751.366333, 140.461945, 2.514430, 90.00, false, -1}
//	{TEAM_NONE,			-2134.23706,-744.81348,31.05060,0.00000, false, -1},
//	{TEAM_NONE,			-2134.23706,-744.81348,31.05060,0.00000, false, -1}
};
new GateInfo[18][gInfo] =
{
	{TEAM_FBI,1495, 595.0252, -1183.7310, 1000.3850,0.0,593.7052, -1183.7310, 1000.3850,false,-1,false,-1},
	{TEAM_NONE,1495, 528.4470,1437.4630,2000.1400,90.0,528.4470,1436.1430,2000.1400 ,false,-1,false,-1},
	{TEAM_NONE,1495, 526.6490,1450.5400,2000.1860,180.0,527.9890,1450.5400,2000.1860 ,false,-1,false,-1},
	{TEAM_BANK,2634,  529.46, 1428.20, 1989.28,   0.11,  531.20, 1428.20, 1989.28 ,false,-1,false,-1},
	{TEAM_FBI,19303, 1559.52, -1655.42, 879.93,270.0,1559.5170, -1656.6776, 879.9300,false,-1,false,-1},
	{TEAM_ARMY,976, 2720.25, -2508.42, 12.09,90.0,2720.25, -2516.92, 12.09,false,-1,false,-1},
	{TEAM_ARMY,976,  2720.10, -2409.59, 12.09,90.0, 2720.10, -2418.17, 12.09,false,-1,false,-1},
	{TEAM_FBI,1495, 1553.48, -1678.59, 882.72,90.0,1553.48, -1679.93, 882.70,false,-1,false,-1},
	{TEAM_FBI,1495, 598.22, -1220.11, 1000.41,00.0,596.89, -1220.11, 1000.41,false,-1,false,-1},
	{TEAM_LSPD,11327, 1589.33, -1638.27, 14.86,270.09, 1596.37, -1638.27, 14.86,false,-1,false,-1},
	{TEAM_ARMYLV,19313,  134.9800, 1941.5500, 21.7700,0.00,121.8900, 1941.5500, 21.7700,false,-1,false,-1},
	{TEAM_ARMYLV,19313,  285.98, 1822.27, 20.10,270.00,285.9800, 1833.4900, 20.1000,false,-1,false,-1},
	{TEAM_ARMYLV,988,  132.112762, 2013.327637, 18.833637,0.00,138.502945, 2013.327637, 18.833637,false,-1,false,-1},
	{TEAM_RADIO,1495,  1705.7180, -1664.3540, 19.2260,0.00,1704.5780, -1664.3540, 19.2260,false,-1,false,1},
	{TEAM_RADIOLV,1495,  1705.7180, -1664.3540, 19.2260,0.00,1704.5780, -1664.3540, 19.2260,false,-1,false,2},
	{TEAM_RADIOSF,1495,  1705.7180, -1664.3540, 19.2260,0.00,1704.5780, -1664.3540, 19.2260,false,-1,false,3},
	{TEAM_SFPD,19313, -1630.27258, 688.22009, 8.80640,   360.00000, -1644.25256, 688.22009, 8.80640,false,-1,false,-1},
	{TEAM_ARMYSF,988,  -1517.697998, 468.413330, 7.221627,270.000000,-1517.697998, 474.623047, 7.221627,false,-1,false,-1}
};

enum chInfo
{
Float:chEnter_X,
Float:chEnter_Y,
Float:chEnter_Z,
Float:chExit_X,
Float:chExit_Y,
Float:chExit_Z,
	chCost,
	chLevel,
	chInt
}
enum bgInfo
{
	bgGunid,
	bgAmmo[5],
	bgGPrice,
	bgPrice
}
new BuyGunInfo[11][bgInfo] =
{
	{526, 	{1, 0, 0, 0, 0}, 			0, 		60},
	{527, 	{1, 0, 0, 0, 0}, 			0, 		120},
	{528, 	{1, 0, 0, 0, 0}, 			0, 		300},
	{529, 	{1, 0, 0, 0, 0}, 			0, 		240},
	{530, 	{1, 2, 3, 4, 5}, 			0, 		50},
	{531, 	{50, 75, 100, 125, 150}, 	900, 	100},
	{532,	{50, 75, 100, 125, 150}, 	1100, 	120},
	{533, 	{100, 150, 200, 250, 300}, 	1300, 	200},
	{534, 	{100, 150, 200, 250, 300}, 	1400, 	250},
	{535, 	{100, 150, 200, 250, 300}, 	1450, 	280},
	{536, 	{50, 100, 150, 200, 250}, 	1510, 	300}
};
new Float:CarPounds[14][4] =
{
	{1611.3163,-1140.9514,1679.1689,-1073.6880},
	{1603.515625,-1089.84375,1806.640625,-1039.0625},
	{1566.40625,-1041.015625,1755.859375,-1007.8125},
	{1751.953125,-1041.015625,1792.96875,-1021.484375},
	{1755.859375,-1021.484375,1783.203125,-1011.71875},
	{1617.1875,-1140.625,1685.546875,-1091.796875},
	{1615.234375,-1095.703125,1685.546875,-1085.9375},
	{1578.125,-1056.640625,1609.375,-1039.0625},
	{1591.796875,-1068.359375,1607.421875,-1056.640625},
	{1599.609375,-1076.171875,1607.421875,-1066.40625},
	{1825.6003,-1147.3049,1547.0156,-1006.9152},
	{2480.0544,2482.7708,2534.8032,2543.1504},
	{2399.3401,2525.1711,2479.9580,2557.8350},
	{2458.6350,2482.7695,2479.3079,2500.5684}
};
enum healinfo
{
Float:hCP[3],
Float:hBed[4],
	hInt,
	hWorld,
	hName[24],
	hID
}
new HealInfo[90][healinfo] =
{
	{	{468.3153,876.4371,1500.9648}, {469.1023,877.8615,1501.7046,183.3767}, 2, 1, "The State", 1 	},
	{	{468.5413,878.9798,1500.9648}, {469.3108,880.2742,1501.7046,182.9674}, 2, 1, "The State", 2 	},
	{	{468.4335,881.4476,1500.9648}, {469.3798,882.7335,1501.7046,180.1475}, 2, 1, "The State", 3 	},
	{	{475.0703,876.4106,1500.9648}, {474.4324,877.7170,1501.7046,0.3157}, 2, 1, "The State", 4 	},
	{	{475.1819,878.9890,1500.9648}, {474.4739,880.3450,1501.7046,0.0024}, 2, 1, "The State", 5 	},
	{	{475.0418,881.4892,1500.9648}, {474.3342,882.7846,1501.7046,358.4357}, 2, 1, "The State", 6 	},
	//
	{	{-1606.0204,-118.1190,1501.0859}, {-1605.2870,-117.6385,1501.8241,271.0}, 2, 1, "The State", 7 	},
	{	{-1606.0226,-113.2084,1501.0859}, {-1605.2939,-113.0380,1501.8241,271.0}, 2, 1, "The State", 8 	},
	{	{-1607.1825,-113.6577,1501.0859}, {-1607.8969,-112.8577,1501.8241,271.0}, 2, 1, "The State", 9 	},
	{	{-1607.1814,-118.2929,1501.0859}, {-1607.9230,-117.3933,1501.8241,271.0}, 2, 1, "The State", 10 	},
	{	{-1610.2584,-118.0049,1501.0859}, {-1610.9863,-117.1412,1501.8241,271.0}, 2, 1, "The State", 11 	},
	{	{-1610.2286,-113.6730,1501.0859}, {-1610.9801,-112.6245,1501.8241,271.0}, 2, 1, "The State", 12 	},
	//Больница ЛС
	{	{-1750.6459,-2010.3352,1500.7853}, {-1751.0338,-2009.4349,1501.4329,7.8523}, 2, 1, "The State", 13 	},
	{	{-1750.6465,-2012.6357,1500.7853}, {-1751.1250,-2011.6644,1501.4329,4.1157}, 2, 1, "The State", 14 	},
	{	{-1750.6460,-2014.7561,1500.7853}, {-1750.8818,-2013.8785,1501.4329,0.6924}, 2, 1, "The State", 15 	},
	{	{-1750.6475,-2016.9489,1500.7853}, {-1750.9003,-2016.0931,1501.4329,1.3425}, 2, 1, "The State", 16 	},
	{	{-1750.6462,-2019.1276,1500.7853}, {-1750.8733,-2018.3225,1501.4329,355.0991}, 2, 1, "The State", 17 	},
	{	{-1756.6937,-2017.0773,1500.7853}, {-1756.3184,-2017.9144,1501.4329,179.9675}, 2, 1, "The State", 18 	},
	{	{-1756.6947,-2014.7922,1500.7853}, {-1756.3540,-2015.6837,1501.4329,181.5576}, 2, 1, "The State", 19 	},
	{	{-1756.4520,-2012.5107,1500.7853}, {-1756.3094,-2013.4594,1501.4329,184.4010}, 2, 1, "The State", 20 	},
	{	{-1794.8030,-2018.0381,1500.7853}, {-1794.5997,-2018.9110,1501.4329,179.7244}, 2, 1, "The State", 21 	},
	{	{-1794.8013,-2015.8160,1500.7853}, {-1794.5933,-2016.6808,1501.4329,177.5545}, 2, 1, "The State", 22 	},
	{	{-1794.8021,-2013.5491,1500.7853}, {-1794.4501,-2014.4653,1501.4329,181.6512}, 2, 1, "The State", 23 	},
	{	{-1794.5616,-2011.4640,1500.7853}, {-1794.3704,-2012.2545,1501.4329,179.7946}, 2, 1, "The State", 24 	},
	{	{-1794.8022,-2009.1794,1500.7853}, {-1794.4989,-2010.0210,1501.4329,179.8180}, 2, 1, "The State", 25 	},
	{	{-1788.2804,-2012.6597,1500.7853}, {-1788.3054,-2013.8508,1501.4329,357.7931}, 2, 1, "The State", 26 	},
	{	{-1787.9835,-2014.7906,1500.7853}, {-1788.4487,-2016.0830,1501.4329,1.5530}, 2, 1, "The State", 27 	},
	{	{-1787.9830,-2016.9314,1500.7853}, {-1788.4493,-2018.3008,1501.4329,2.8297}, 2, 1, "The State", 28 	},
	//Больница ЛВ
	{	{-1750.6459,-2010.3352,1500.7853}, {-1751.0338,-2009.4349,1501.4329,7.8523}, 3, 2, "The State", 29 	},
	{	{-1750.6465,-2012.6357,1500.7853}, {-1751.1250,-2011.6644,1501.4329,4.1157}, 3, 2, "The State", 30 	},
	{	{-1750.6460,-2014.7561,1500.7853}, {-1750.8818,-2013.8785,1501.4329,0.6924}, 3, 2, "The State", 31 	},
	{	{-1750.6475,-2016.9489,1500.7853}, {-1750.9003,-2016.0931,1501.4329,1.3425}, 3, 2, "The State", 32 	},
	{	{-1750.6462,-2019.1276,1500.7853}, {-1750.8733,-2018.3225,1501.4329,355.0991}, 3, 2, "The State", 33 	},
	{	{-1756.6937,-2017.0773,1500.7853}, {-1756.3184,-2017.9144,1501.4329,179.9675}, 3, 2, "The State", 34 	},
	{	{-1756.6947,-2014.7922,1500.7853}, {-1756.3540,-2015.6837,1501.4329,181.5576}, 3, 2, "The State", 35 	},
	{	{-1756.4520,-2012.5107,1500.7853}, {-1756.3094,-2013.4594,1501.4329,184.4010}, 3, 2, "The State", 36 	},
	{	{-1794.8030,-2018.0381,1500.7853}, {-1794.5997,-2018.9110,1501.4329,179.7244}, 3, 2, "The State", 37 	},
	{	{-1794.8013,-2015.8160,1500.7853}, {-1794.5933,-2016.6808,1501.4329,177.5545}, 3, 2, "The State", 38 	},
	{	{-1794.8021,-2013.5491,1500.7853}, {-1794.4501,-2014.4653,1501.4329,181.6512}, 3, 2, "The State", 39 	},
	{	{-1794.5616,-2011.4640,1500.7853}, {-1794.3704,-2012.2545,1501.4329,179.7946}, 3, 2, "The State", 40 	},
	{	{-1794.8022,-2009.1794,1500.7853}, {-1794.4989,-2010.0210,1501.4329,179.8180}, 3, 2, "The State", 41 	},
	{	{-1788.2804,-2012.6597,1500.7853}, {-1788.3054,-2013.8508,1501.4329,357.7931}, 3, 2, "The State", 42 	},
	{	{-1787.9835,-2014.7906,1500.7853}, {-1788.4487,-2016.0830,1501.4329,1.5530}, 3, 2, "The State", 43 	},
	{	{-1787.9830,-2016.9314,1500.7853}, {-1788.4493,-2018.3008,1501.4329,2.8297}, 3, 2, "The State", 44 	},
	//Больница СФ
	{	{-1750.6459,-2010.3352,1500.7853}, {-1751.0338,-2009.4349,1501.4329,7.8523}, 3, 3, "The State", 45 	},
	{	{-1750.6465,-2012.6357,1500.7853}, {-1751.1250,-2011.6644,1501.4329,4.1157}, 3, 3, "The State", 46 	},
	{	{-1750.6460,-2014.7561,1500.7853}, {-1750.8818,-2013.8785,1501.4329,0.6924}, 3, 3, "The State", 47 	},
	{	{-1750.6475,-2016.9489,1500.7853}, {-1750.9003,-2016.0931,1501.4329,1.3425}, 3, 3, "The State", 48 	},
	{	{-1750.6462,-2019.1276,1500.7853}, {-1750.8733,-2018.3225,1501.4329,355.0991}, 3, 3, "The State", 49 	},
	{	{-1756.6937,-2017.0773,1500.7853}, {-1756.3184,-2017.9144,1501.4329,179.9675}, 3, 3, "The State", 50 	},
	{	{-1756.6947,-2014.7922,1500.7853}, {-1756.3540,-2015.6837,1501.4329,181.5576}, 3, 3, "The State", 51 	},
	{	{-1756.4520,-2012.5107,1500.7853}, {-1756.3094,-2013.4594,1501.4329,184.4010}, 3, 3, "The State", 52 	},
	{	{-1794.8030,-2018.0381,1500.7853}, {-1794.5997,-2018.9110,1501.4329,179.7244}, 3, 3, "The State", 53 	},
	{	{-1794.8013,-2015.8160,1500.7853}, {-1794.5933,-2016.6808,1501.4329,177.5545}, 3, 3, "The State", 54 	},
	{	{-1794.8021,-2013.5491,1500.7853}, {-1794.4501,-2014.4653,1501.4329,181.6512}, 3, 3, "The State", 55 	},
	{	{-1794.5616,-2011.4640,1500.7853}, {-1794.3704,-2012.2545,1501.4329,179.7946}, 3, 3, "The State", 56 	},
	{	{-1794.8022,-2009.1794,1500.7853}, {-1794.4989,-2010.0210,1501.4329,179.8180}, 3, 3, "The State", 57 	},
	{	{-1788.2804,-2012.6597,1500.7853}, {-1788.3054,-2013.8508,1501.4329,357.7931}, 3, 3, "The State", 58 	},
	{	{-1787.9835,-2014.7906,1500.7853}, {-1788.4487,-2016.0830,1501.4329,1.5530}, 3, 3, "The State", 59 	},
	{	{-1787.9830,-2016.9314,1500.7853}, {-1788.4493,-2018.3008,1501.4329,2.8297}, 3, 3, "The State", 60 	},
	//Больница ЛС Второй этаж
	{   {-1345.6306,19.6844,1601.0889}, {-1344.2671,19.6056,1601.5659,89.5863}, 2, 1, "The State", 61   },
	{   {-1340.0017,19.8683,1601.0929}, {-1338.4021,19.6316,1601.5659,91.8030}, 2, 1, "The State", 62   },
	{   {-1337.1713,4.4311,1601.0889}, {-1338.5319,4.7082,1601.5659,272.9113}, 2, 1, "The State", 63   },
	{   {-1343.1211,4.1970,1601.0889}, {-1344.5505,4.7785,1601.5659,273.2715}, 2, 1, "The State", 64   },
	{   {-1327.4763,4.7094,1601.0889}, {-1328.8741,4.7578,1601.5659,273.2716}, 2, 1, "The State", 65   },
	{   {-1333.2748,4.7154,1601.0929}, {-1335.0630,4.7192,1601.5659,272.6919}, 2, 1, "The State", 66   },
	{   {-1336.0388,19.5857,1601.0889}, {-1334.5475,19.6590,1601.5659,94.7637}, 2, 1, "The State", 67   },
	{   {-1330.6826,19.8145,1601.0929}, {-1329.2677,19.6336,1601.5659,90.4238}, 2, 1, "The State", 68   },
	//Больница СФ Второй этаж
	{   {-1345.6306,19.6844,1601.0889}, {-1344.2671,19.6056,1601.5659,89.5863}, 3, 3, "The State", 69   },
	{   {-1340.0017,19.8683,1601.0929}, {-1338.4021,19.6316,1601.5659,91.8030}, 3, 3, "The State", 70   },
	{   {-1337.1713,4.4311,1601.0889}, {-1338.5319,4.7082,1601.5659,272.9113}, 3, 3, "The State", 71   },
	{   {-1343.1211,4.1970,1601.0889}, {-1344.5505,4.7785,1601.5659,273.2715}, 3, 3, "The State", 72   },
	{   {-1327.4763,4.7094,1601.0889}, {-1328.8741,4.7578,1601.5659,273.2716}, 3, 3, "The State", 73   },
	{   {-1333.2748,4.7154,1601.0929}, {-1335.0630,4.7192,1601.5659,272.6919}, 3, 3, "The State", 74   },
	{   {-1336.0388,19.5857,1601.0889}, {-1334.5475,19.6590,1601.5659,94.7637}, 3, 3, "The State", 75   },
	{   {-1330.6826,19.8145,1601.0929}, {-1329.2677,19.6336,1601.5659,90.4238}, 3, 3, "The State", 76   },
	//Больница ЛВ Второй этаж
	{   {-1345.6306,19.6844,1601.0889}, {-1344.2671,19.6056,1601.5659,89.5863}, 3, 2, "The State", 77   },
	{   {-1340.0017,19.8683,1601.0929}, {-1338.4021,19.6316,1601.5659,91.8030}, 3, 2, "The State", 78   },
	{   {-1337.1713,4.4311,1601.0889}, {-1338.5319,4.7082,1601.5659,272.9113}, 3, 2, "The State", 79   },
	{   {-1343.1211,4.1970,1601.0889}, {-1344.5505,4.7785,1601.5659,273.2715}, 3, 2, "The State", 80   },
	{   {-1327.4763,4.7094,1601.0889}, {-1328.8741,4.7578,1601.5659,273.2716}, 3, 2, "The State", 81   },
	{   {-1333.2748,4.7154,1601.0929}, {-1335.0630,4.7192,1601.5659,272.6919}, 3, 2, "The State", 82   },
	{   {-1336.0388,19.5857,1601.0889}, {-1334.5475,19.6590,1601.5659,94.7637}, 3, 2, "The State", 83   },
	{   {-1330.6826,19.8145,1601.0929}, {-1329.2677,19.6336,1601.5659,90.4238}, 3, 2, "The State", 84   },
	//Армия Лас-Вентурас
	{   {215.3257,1348.5504,1518.9371}, {215.3598,1347.2943,1519.4230,179.4854}, 3, 2, "The State", 85   },
	{   {215.3264,1345.5536,1518.9371}, {215.3850,1344.3212,1519.4230,182.6913}, 3, 2, "The State", 86   },
	{   {215.3257,1342.5696,1518.9371}, {215.1833,1341.2717,1519.4230,187.0780}, 3, 2, "The State", 87   },
	{   {222.1194,1348.5308,1518.9371}, {221.9705,1347.3296,1519.4230,179.7989}, 3, 2, "The State", 88   },
	{   {222.1196,1345.4709,1518.9371}, {222.0005,1344.2980,1519.4230,178.8589}, 3, 2, "The State", 89   },
	{   {222.1201,1342.5232,1518.9371}, {221.9829,1341.3052,1519.4230,178.5457}, 3, 2, "The State", 90   }

};
enum B_INFO
{
    bObjectID,
	Float:bPos[4],
    bPosText[32],
	bText[144],
	bOwner[MAX_PLAYER_NAME],
	bBackColor,
	bFontFace,
	bAligment,
	bFontSize,
	bDay,
	bHours
};
new BildInfo[MAX_BILLBORDS][B_INFO];
enum R_INFO
{
	rText,
	rOtvet,
	rNick
};
new ReportInfo[MAX_REPORTS][R_INFO];
new Text3D:HealText[252] = {NONE_3D_TEXT, ...};
new PlayerBed[MAX_PLAYERS];
new bool:PlayerLie[MAX_PLAYERS];
enum tirguninfo
{
	tgGunname[30],
	tgGunid,
	tgCost
}
new TGunInfo[8][tirguninfo] =
{
	{"Pistols", 22, 250},
	{"Desert Eagle", 24, 390},
	{"ShotGun", 25, 500},
	{"MP5", 29, 650},
	{"AK47", 30, 650},
	{"M4", 31, 650},
	{"Sniper Rifle", 34, 1000},
	{"SILENCED", 23, 900}
};
new gunmute[MAX_PLAYERS];

//new UpdateIgnote[MAX_PLAYERS];
//////////
publics OnAllAdminsLoaded(showid)
{
    new totalMembers = cache_num_rows();
	if(totalMembers > 0)
	{
		new string[64], bigstring[512];
		new admin, membername[MAX_PLAYER_NAME], accountid, LastLogin[64];
		if(strlen(bigstring) < 1) strcat(bigstring, "{DCDCDC}ID\tУровень адм.\tНик\t\t\t\tПоследний вход\n\n{FFFFFF}");
		for(new i = 0; i < totalMembers; i++)
		{
			//stats = cache_get_field_content_int(i, "Online_status", mysql);
			//if(stats!=1001) stat = "{FF6347}Offline{FFFFFF}"; else stat = "{41BE13}Online{FFFFFF}";
			admin = cache_get_field_content_int(i, "Admin", mysql);
			accountid = cache_get_field_content_int(i, "ID", mysql);
			//LastLogin = cache_get_field_content_int(i, "LastLogin", mysql);
			cache_get_field_content(i, "NickName", membername, mysql);
			cache_get_field_content(i, "LastLogin", LastLogin, mysql);
			format(bigstring, sizeof(bigstring), "%s%d\t%d\t\t%s\t\t\t%s\t%s\n", bigstring, accountid, admin, membername, LastLogin);
		}
		format(string, sizeof(string), "{FF6347}Всего %d администраторов", totalMembers);
		ShowPlayerDialog(showid, 0, DIALOG_STYLE_TABLIST_HEADERS, string, bigstring, "Выбрать", "Закрыть");
		//ShowPlayerDialogEx(showid, 0, DIALOG_STYLE_TABLIST_HEADERS, string, bigstring, "Закрыть", "");
	}
	else
	{
		SendClientMessage(showid, COLOR_GRAD, "Администраторы не найдены.");
	}
}
publics _SetGun(playerid, weaponid, ammo)
{
	new slot = GetWeaponSlot(weaponid);
	if(slot == 0xFFFF) return false;

	gunmute[playerid] = gettime()+3;

	if(PlayerInfo[playerid][pAmmos][slot] < 7)
	{
		PlayerInfo[playerid][pGuns][slot] = 0;
		PlayerInfo[playerid][pAmmos][slot] = 0;
		AmmoSlot[playerid][slot] = 0;
		WeaponInfo[playerid][weaponid] = false;
		AmmoInfo[playerid][weaponid] = 0;
		return 0;
	}
	WeaponInfo[playerid][weaponid] = true;
	AmmoSlot[playerid][slot] = ammo;
	AmmoInfo[playerid][weaponid] = AmmoSlot[playerid][slot];

	PlayerInfo[playerid][pAmmos][slot] = ammo;
	PlayerInfo[playerid][pGuns][slot] = weaponid;

	GivePlayerWeapon(playerid, weaponid, ammo);
	if(PlayerInfo[playerid][pAmmos][slot]==0) PlayerInfo[playerid][pGuns][slot]=0;
	return true;
}
publics _GiveGun(playerid, weaponid, ammo)
{
	new slot = GetWeaponSlot(weaponid);
	if(slot == 0xFFFF) return false;
	gunmute[playerid] = gettime()+3;

	WeaponInfo[playerid][weaponid] = true;
	AmmoSlot[playerid][slot] += ammo;
	AmmoInfo[playerid][weaponid] = AmmoSlot[playerid][slot];

	PlayerInfo[playerid][pAmmos][slot] += ammo;
	PlayerInfo[playerid][pGuns][slot] = weaponid;

	GivePlayerWeapon(playerid, weaponid, ammo);
	if(PlayerInfo[playerid][pAmmos][slot]==0) PlayerInfo[playerid][pGuns][slot]=0;
	return true;
}
publics _ResetGun(playerid)
{
	gunmute[playerid] = gettime()+3;
	ResetPlayerWeapons(playerid);
	for(new x; x < 13; x ++)
	{
		PlayerInfo[playerid][pAmmos][x] = 0;
		PlayerInfo[playerid][pGuns][x] = 0;
		AmmoSlot[playerid][x] = 0;
	}

	for(new i = 0; i < 47; i++)
	{
		WeaponInfo[playerid][i] = false;
		AmmoInfo[playerid][i] = 0;
	}

	PlayerInfo[playerid][pLastGun]=0;
	PlayerInfo[playerid][pLastAmmo]= 0;
	return true;
}

resetgun(playerid) return ResetPlayerWeapons(playerid);

enum tpInfo
{
	tpName[50],
Float:tpEnterPos_X,
Float:tpEnterPos_Y,
Float:tpEnterPos_Z,
	tpEnterWorld,
	tpEnterInt,
Float:tpExitPos_X,
Float:tpExitPos_Y,
Float:tpExitPos_Z,
Float:tpExitPos_A,
	tpExitInt,
	tpExitWorld
}
new TeleportInfo[117][tpInfo] =
{
	{"Мэрия",1495.1898,-1279.9283,14.5749, 0, 0, -2064.9194,2662.0627,1499.4360,359.2093, 2, 2},
	{"Тюрьма строгого режима",1463.9479,-85.8541,26.7904, 0, 0, 1432.6410,2207.7964,1500.9758,4.8883, 2, 2},
	{"Выход на улицу",-2063.2202,2659.3704,1498.7765, 2, 2, 1495.1967,-1283.5261,14.5414,184.2417, 0, 0},
	{"Информационный центр",-1749.3003,868.6635,25.0859, 0, 0, 1399.7065,-23.2500,1000.8779,179.0013, 2, 2},
	{"San-Fierro",1399.8080,-19.7480,1000.8779, 2, 2, -1749.2633,865.4357,25.0859,179.9649, 0, 0},
	{"2 этаж",1391.7749,-28.4946,1000.8779, 2, 2, -1760.4387,892.4403,105.0248,88.9801, 0, 0},
	{"1 этаж",-1757.2827,892.4297,105.0248, 0, 0, 1395.7230,-28.5049,1000.8779,269.1718, 2, 2},
	{"Туалет",1404.4049,-22.9027,1000.8779, 2, 2, 2688.4954,925.8544,1551.0110,89.1749, 2, 2},
	{"Выход",2690.9055,925.9792,1551.0110, 2, 2, 1401.6141,-22.8647,1000.8779,87.9420, 2, 2},
	{"Лотерейная",1411.4943,-1699.6199,13.5395, 0, 0, 834.6682,7.3731,1004.1870,273.9995, 3, 2},
	{"Выход", 834.6682,7.3731,1004.1870, 2, 3, 1412.2062,-1700.5260,13.5395,220.0900, 0, 0},
	{"Полицейский участок",1554.866943, -1675.680297, 16.195312, 0, 0, 101.8260,1070.0448,-48.9141,180.8000, 2, 2}, // Police LS
	{"Выход на улицу",101.9168,1073.6395,-48.9141, 2, 2, 1552.464599,-1675.447143,16.195312, 90.0, 0, 0}, // Police LS
	{"Полицейский участок",627.3923,-571.7623,17.9145, 0, 0, 1019.5093,349.4790,1004.2559,359.8038, 6, 11}, // Police RCPD
	{"Выход на улицу",1019.7515,346.6750,1004.2559, 11, 6, 630.7498,-571.5781,16.3359,268.5526, 0, 0}, // Police SF
	{"FBI",-2456.1494,503.8981,30.0781, 0, 0, 1165.6135,362.4039,1002.1450,359.9318, 2, 12},
	{"Выход на улицу",1165.6759,359.9284,1002.1450, 12, 2, -2453.7112,503.8358,30.0799,272.1426, 0, 0},
	{"Полицейский участок",-1605.5493,710.2738,13.8672, 0, 0, -273.1393,896.4244,-36.8240,88.3631, 10, 0}, //SFPD
	{"Выход на улицу",-270.3014,896.4131,-36.8240, 0, 10 ,-1606.1509,713.7501,13.2903,359.7803, 0, 0}, //СФПД выход на улицу
	{"Полицейский участок",-1594.2084,716.2449,-4.9063, 0, 0, 2365.7627,75.6044,1502.0103,359.5187, 10, 0}, // SFPD вход из гаража
	{"Выход в гараж",2365.5530,71.8606,1502.0103, 0, 10, -1592.1372,715.8721,-5.2422,268.9620, 0, 0},
	{"Выход во двор",1433.0614,2205.1934,1500.9758, -1, -1, 1464.8234,-86.6891,26.7904,226.8288, 0, 0},
	{"Radio студия LS",1653.9441,-1654.7587,22.5156, 0, 0, 2683.3669,-1200.5116,1271.5940,268.0464, 18, 1},//word, int int, word
	{"Los Santos",2680.7175,-1200.6500,1271.5940, 1, 18, 1653.5554,-1658.9841,22.5156,181.2989, 0, 0},//wordint , intword
	{"Автошкола",-2040.4189,-89.0508,35.4024, 0, 0, -2574.6599,-1375.9349,1500.7570,89.9344, 6, 0},
	{"San-Fierro",-2572.0288,-1376.1685,1500.7570, 0, 0, -2043.5845,-86.8165,35.1641,57.6139, 0, 0},
	{"Парковка",-2592.1675,-1373.0593,1500.7570, 0, 0,-2045.8020,-119.7592,35.3924,87.7176, 0, 0},
	{"Автошкола",-2043.5363,-119.6490,35.3924, 0, 0, -2589.6196,-1372.8546,1500.7570,269.7661, 6, 0},
	{"Los Santos",627.302978, -11.985424, 1000.921875, 1, 1, 1084.715942,-1226.635253,15.820312, 270.961944, 0, 0},
	{"San Fierro",964.776794, -53.210323, 1001.117187, 1, 3, -1552.170410,1165.444458,7.187500, 89.121200, 0, 0},
	{"Varrios Los Aztecas",1684.7975,-2098.1548,13.8343, 0, 0, -719.4118,2235.9221,1500.9745,357.0398, 7, 4},
	{"Выход на улицу",-719.3853,2233.5256,1500.9745, 4, 7, 1684.8258,-2101.7524,13.8343,181.6716, 0, 0},
	{"Los Santos Vagos",2261.0464,-1457.2893,24.5232, 0, 0, -404.9064,2415.9263,1500.9688,268.0523, 7, 2},
	{"Выход на улицу",-402.1562,2416.0808,1500.9688, 2, 7, 2260.3962,-1454.0822,23.8281,11.4129, 0, 0},
	{"Grove Street",2495.311035,-1690.930175,14.765625, 0, 0, -561.7040,2414.6204,1500.9688,268.6789, 7, 1},
	{"Выход на улицу",-558.6067,2414.5039,1500.9688, 1, 7, 2495.2034,-1689.1195,14.2319, 0.9635, 0, 0},
	{"The Rifa",2185.7822,-1815.2261,13.5469, 0, 0, -561.0139,2258.3704,1500.9688,1.1131, 7, 5},
	{"Выход на улицу",-561.0692,2261.2266,1500.9688, 5, 7, 2185.8145,-1810.8423, 13.5469, 1.5911, 0, 0},
	{"East Side Ballas",2486.4285,-2021.5525,13.9988, 0, 0, -725.4045,2403.3616,1500.9701,179.4015, 7, 3},
	{"Выход на улицу",-725.4148,2400.7341,1500.9701, 3, 7, 2486.3118,-2018.2318,13.5469,359.0713, 0, 0},
	{"La Cosa Nostra",-1451.6494,925.5505,7.3793, 0, 0, -1508.6989,1969.7877,1353.5089,269.2399, 5, 1},//Куда входит
	{"Las Venturas",-1511.5114,1969.8236,1353.5089, 1, 5, -1456.2087,925.4865,7.3793,89.4290, 0, 0},//Куда выходит
	{"Yakuza",1412.5140,730.5666,10.8203, 0, 0, -1934.9524,891.2448,1402.0776,268.5665, 5, 0}, // 5 Инта, 0 вирт мир
	{"San Fierro",-1938.0568,891.3152,1402.0776, 0, 5, 1416.3644,730.4827,10.8203,268.8818, 0, 0}, //Яки
	{"Русская Мафия",-2017.5355,1119.4456,54.0236, 0, 0, -2006.2168,1118.2379,1018.6735,88.1785, 3, 0},
	{"Las Venturas",-2003.2935,1118.1830,1018.6735, 0, 3, -2012.7753,1119.6454,54.0236,271.8233, 0, 0},
	{"Sport Club LS",2229.631835, -1721.709350, 13.565642, 0, 0, 773.9093,-76.9094,1000.6545,2.5748, 7, 0},
	{"Los Santos",773.8964,-78.8464,1000.6628, 0, 7, 2228.418701,-1722.766357,13.554397, 137.274353, 0, 0},
	{"Los Santos",964.776794, -53.210323, 1001.117187, 2, 3, 2194.1086,1677.1443,12.3672, 42.038417, 0, 0},
	{"Warlock MC", 1122.7064,-2036.9875,69.8943, 0, 0, 799.5667,2517.9297,1502.0000,90.7034, 3, 1},
	{"Выход на улицу", 801.6736,2517.9001,1502.0000, 1, 3, 1127.0251,-2036.9646,69.8837,269.6165, 0, 0},
	{"Больница LS",1172.6415, -1323.3395, 15.4030, 0, 0, -1772.2404,-2016.7126,1500.7853,0.6222, 2, 1},
	{"Наркопритон",2166.124267, -1671.345947, 15.073492, 0, 0, 318.662506,1116.091186,1083.882812, 1.946820, 5, 1},
	{"The Ghetto",318.586029, 1114.793212, 1083.882812, 1, 5, 2167.414550,-1672.636352,15.080650, 223.037063, 0, 0},
	{"Тир Los Santos",548.2713,312.2186,2015.5170, 1, 1, 941.6627,309.8397,1601.0859, 90.0, 1, 1},
	{"Амуниция",941.4504, 307.0878, 1601.0859, 1, 1, 547.0519,314.6493,2015.5149, 200.0, 1, 1},
	{"Завод",-86.3057, -299.6985, 2.7646, 0, 0, 2575.9531,-1289.5161,1044.1250,87.2380, 2, 10},
	{"Лос Сантос",2577.3730,-1289.8970,1044.1250, 10, 2, -86.3985, -301.6363, 2.7646, 170.0, 0, 0},
	{"Церковь", 1720.3025,-1741.1660,13.5469,0,0,1274.6763,-1564.8978,3278.3521,89.3754,0,0},
	{"Unity Station", 1277.6923,-1564.9399,3278.3616,0,0,1720.2825,-1738.9661,13.5469,359.0755,0,0},
	{"San Fierro", -122.5312,-59.7999,1003.6160,0,0,-2168.4531,252.0057,35.3295,272.3488,0,0},
	{"",2723.7825,-2028.5219,13.5472, 0, 0, 2216.1108,-1150.4834,1025.7969, 270.0, 1, 7},
	{"Los Santos",2214.7983,-1150.5040,1025.7969, 7, 1, 2721.1589,-2028.5688,13.5472,90.8957, 0, 0},
	{"",2723.7820,-2011.9711,13.5547, 0, 0, 2216.1108,-1150.4834,1025.7969, 270.0, 1, 8},
	{"Los Santos",2214.7983,-1150.5040,1025.7969, 8, 1, 2720.5266,-2012.1782,13.5547,93.0889, 0, 0},
	{"",2757.7007,-2058.4956,12.6221, 0, 0, 2216.1108,-1150.4834,1025.7969, 270.0, 1, 9},
	{"Los Santos",2214.7983,-1150.5040,1025.7969, 9, 1, 2757.8984,-2055.6145,12.6167,355.9778, 0, 0},
	{"",2723.4365,-2114.9807,11.1390, 0, 0, 2216.1108,-1150.4834,1025.7969, 270.0, 1, 10},
	{"Los Santos",2214.7983,-1150.5040,1025.7969, 10, 1, 2721.0776,-2115.1257,11.1369,88.7254, 0, 0},
	{"Sport Club LV",2092.6499,2493.1968,14.8390, 0, 0, 773.9093,-76.9094,1000.6545,2.5748, 7, 1},
	{"Las Venturas",773.8964,-78.8464,1000.6628, 1, 7, 2095.5288,2493.2524,14.8390,267.9022, 0, 0},
	{"Больница LV",1607.4197,1815.2408,10.8203, 0, 0, -1772.2404,-2016.7126,1500.7853,0.6222, 3, 2},
	{"Больница SF",-2668.8684,640.1640,14.4531, 0, 0, -1772.2404,-2016.7126,1500.7853,0.6222, 3, 3},
	{"",2731.6279,-2417.5535,13.6280, 0, 0, 2575.9531,-1289.5161,1044.1250,87.2380, 2, 11},
	{"",2577.3730,-1289.8970,1044.1250, 11, 2, 2731.6812,-2416.2803,13.6277,0.7204, 0, 0},
	//{"",237.8633,1872.3997,11.4609, 0, 0, 2575.9531,-1289.5161,1044.1250,87.2380, 2, 12},
	//{"",2577.3730,-1289.8970,1044.1250, 12, 2, 233.9474,1872.2189,11.4609,90.4364, 0, 0},
	{"Полицейский участок LV",2287.0254,2432.3618,10.8203, 0, 0, -1465.2637,2607.8323,19.6310,177.7552, 6, 12}, // Police SF
	{"Выход на улицу",-1465.1677,2609.8850,19.6310, 12, 6, 2287.0684,2428.8718,10.8203,179.2759, 0, 0}, // Police SF
	{"Полицейский участок LV",2365.5530,71.8606,1502.0103, 0, 0, -1475.7539,2595.0928,15.9518,0.1731, 6, 12}, // Police SF
	{"Выход на улицу",-1475.7273,2593.0413,15.9518, 12, 6, 2293.9648,2451.4768,10.8203,88.0312, 0, 0}, // Police SF
	{"Вход на крышу",2297.1160,2468.7705,10.8203, 0, 0, 2290.2505,2460.7644,38.6875,284.8691, 0, 0}, // Police SF
	{"Выход в гараж",2287.9663,2458.1406,38.6875, 0, 0, 2294.0698,2468.4187,10.8203,88.4307, 0, 0}, // Police SF
	{"Radio студия LV",2637.8018,1185.2871,10.8203, 0, 0, -192.4965,1342.1322,1500.9788,181.9616, 18, 2},//word, int int, word
	{"Las-Venturas",-192.5206,1345.3345,1500.9788, 2, 18, 2637.8726,1182.4669,10.8203,179.5183, 0, 0},//wordint , intword
	{"Банковское отделение города Las Venturas",2375.5674,2306.3022,8.1406, 0, 0, 487.3989,1307.4255,774.4839,0.6282, 1, 2},//word, int int, word
	{"Las Venturas",487.5179,1304.6077,774.4839,2,1, 2375.3784,2310.3059,8.1406,0.8172, 0, 0},//wordint , intword
	{"АвиаШкола",2427.6948,1662.9143,10.8203, 0, 0, -2027.7902,-105.3816,1035.1719,90.0, 3, 1},
	{"Las Venturas",-2026.8085,-103.6107,1035.1798, 1, 3, 2423.1313,1663.0465,10.8203,89.3561, 0, 0},
	{"Las Venturas",1124.6691,-2590.2566,1221.5060, 11, 0, 2021.7129,1007.9681,10.8203,272.8920, 0, 0},
	{"Las Venturas",1124.6691,-2590.2566,1221.5060, 12, 0, 2021.7129,1007.9681,10.8203,272.8920, 0, 0},
	{"Las Venturas",1124.6691,-2590.2566,1221.5060, 13, 0, 2021.7129,1007.9681,10.8203,272.8920, 0, 0},
	{"Las Venturas",1124.6691,-2590.2566,1221.5060, 14, 0, 2021.7129,1007.9681,10.8203,272.8920, 0, 0},
	{"Las Venturas",1124.6691,-2590.2566,1221.5060, 15, 0, 2021.7129,1007.9681,10.8203,272.8920, 0, 0},
	{"Las Venturas",1124.6691,-2590.2566,1221.5060, 16, 0, 2021.7129,1007.9681,10.8203,272.8920, 0, 0},
	{"",-47.2234,108.2000,3.1852, 0, 0, -64.3512,102.1318,3.1172,140.2303, 0, 0},//ферма
	{"",-63.2242,103.5831,3.1172, 0, 0, -46.4155,110.5303,3.1172,338.2355, 0, 0},
	{"",-71.6448,96.8622,3.4184, 0, 0, -68.8315,96.8338,3.1172,247.6812, 0, 0},
	{"",-70.0108,97.1345,3.1172, 0, 0, -74.9095,97.1277,3.1172,80.6964, 0, 0},
	{"Night Wolfs",2473.1143,-1424.5762,29.0816, 0, 0, -579.2181,127.4654,1501.0900,90.4372, 7, 7},
	{"Выход на улицу",-577.2973,126.9751,1501.0859, 7, 7, 2473.1699,-1422.2638,28.8397,357.6896, 0, 0},
	{"Radio студия SF",-1739.9308,789.8364,24.8921, 0, 0, -1739.1112,789.2741,930.1538,89.7500, 18, 3},//word, int int, word
	{"San Fierro",-1736.5220,789.2260,930.1409, 3, 18, -1736.5701,789.7874,24.8906,269.5818, 0, 0},//wordint , intword
	{"Radio студия SF",-1752.6467,768.0175,24.8906, 0, 0, -1753.1652,759.7621,930.1409,358.5693, 18, 3},
	{"San Fierro",-1753.3395,756.2557,930.1409, 3, 18, -1752.6394,765.4669,24.8906,180.7159, 0, 0},
	{"Вход на крышу",-1765.9493,786.4849,139.4393, 0, 0, -1761.5999,773.9365,167.6563,88.4731, 0, 0},
	{"Вход на 2 этаж",-1757.9132,773.9105,167.6563, 0, 0, -1763.7473,786.6777,139.4086,270.5215, 0, 0},
	{"2 этаж",-1764.7137,779.9871,137.4583, 0, 0, -1756.9584,769.2581,930.1409,270.8349, 18, 3},
	{"1 этаж",-1759.4064,769.3122,930.1409, 3, 18, -1762.0859,780.3135,137.4583,270.2083, 0, 0},
	//{"",-1510.6035,459.8911,7.1875, 0, 0, 2575.9531,-1289.5161,1044.1250,87.2380, 2, 13},
	//{"",2577.3730,-1289.8970,1044.1250, 13, 2, -1510.6216,462.8984,7.1875,357.1089, 0, 0},
	{"Наркопритон",1814.4722,-1995.8588,13.5544, 0, 0, 318.662506,1116.091186,1083.882812, 1.946820, 5, 2},
	{"The Ghetto",318.586029, 1114.793212, 1083.882812, 2, 5, 1811.2611,-1996.1890,13.5513,87.3189, 0, 0},
	{"Наркопритон",2286.6912,-2012.8440,13.5447, 0, 0, 318.662506,1116.091186,1083.882812, 1.946820, 5, 3},
	{"The Ghetto",318.586029, 1114.793212, 1083.882812, 3, 5, 2285.3196,-2015.5061,13.5434,131.0462, 0, 0},
	{"Наркопритон",2333.4478,-1922.6251,12.2991, 0, 0, 318.662506,1116.091186,1083.882812, 1.946820, 5, 4},
	{"The Ghetto",318.586029, 1114.793212, 1083.882812, 4, 5, 2333.2817,-1919.0001,12.9586,359.0316, 0, 0},
	{"Наркопритон",2175.9934,-1503.9364,23.9520, 0, 0, 318.662506,1116.091186,1083.882812, 1.946820, 5, 6},
	{"The Ghetto",318.586029, 1114.793212, 1083.882812, 6, 5, 2176.1218,-1501.6234,23.9621,1.0594, 0, 0},
	{"На улицу",86.3302,1063.0753,-48.9141, 2, 2, 1568.4929,-1692.5367,5.8906,179.4458, 0, 0},
	{"Полицейский участок",1568.5947,-1689.9709,6.2188, 0, 0, 86.2826,1066.0452,-48.9141,0.2716, 2, 2}
};
new TeleportPickup[sizeof(TeleportInfo)] = {-1, ...};
enum tirinfo
{
Float:tirPos[3],
Float:tirTPos[6],
	tirInt,
	tirWorld
}
new TirInfo[8][tirinfo] =
{
	{ 	{289.20,-24.89,1001.0},	{289.10000610,-7.7,1000.5,270.0,0.0,0.0}, 1, 0	},
	{ 	{290.79,-24.89,1001.0},	{290.60000610,-7.7,1000.5,270.0,0.0,0.0}, 1, 0	},
	{ 	{292.20,-24.89,1001.0},	{292.10000610,-7.7,1000.5,270.0,0.0,0.0}, 1, 0	},
	{ 	{293.70,-24.89,1001.0},	{293.60000610,-7.7,1000.5,270.0,0.0,0.0}, 1, 0	},
	{ 	{295.29,-24.89,1001.0},	{295.10000610,-7.7,1000.5,270.0,0.0,0.0}, 1, 0	},
	{ 	{296.79,-24.89,1001.0},	{296.60000610,-7.7,1000.5,270.0,0.0,0.0}, 1, 0	},
	{ 	{298.29,-24.89,1001.0},	{298.10000610,-7.7,1000.5,270.0,0.0,0.0}, 1, 0	},
	{ 	{299.79,-24.89,1001.0},	{299.60000610,-7.7,1000.5,270.0,0.0,0.0}, 1, 0	}
};
new Float:GHSPos[37][3] =
{
	{0.000000, 0.000000, 0.000000},
	{244.182006, 304.898986, 999.148010},
	{267.100006, 305.000000, 999.148010},
	{235.257995, 1187.099975, 1080.260009},
	{300.210998, 312.851013, 999.148010},
	{226.897003, 1114.280029, 1081.000000},
	{744.351989, 1436.760009, 1102.699951},
	{225.671997, 1022.030029, 1084.020019},
	{-42.601600, 1405.920043, 1084.430053},
	{260.757995, 1237.770019, 1084.260009},
	{23.968000, 1340.520019, 1084.380004},
	{0.000000, 0.000000, 0.000000},
	{446.709991, 506.898010, 1001.419982},
	{0.000000, 0.000000, 0.000000},
	{0.000000, 0.000000, 0.000000},
	{386.919006, 1471.699951, 1080.189941},
	{82.98, 1323.15, 1083.13},
	{-68.6603,1351.2046,1080.2109},
	{226.4221,1239.9434,1082.1406},
	{328.0897,1477.6736,1084.4375},
	{446.9292,1397.0680,1084.3047},
	{318.6248,1114.7825,1083.8828},
	{2365.2981,-1135.3936,1050.8750},
	{2308.7720,-1212.9192,1049.0234},
	{2237.4131,-1081.6366,1049.0234},
	{2196.5149,-1204.5540,1049.0234},
	{2270.0549,-1210.6090,1047.5625},
	{-2170.0398,-2135.5757,1501.1005},
	{-675.1259,-2166.6694,1501.0964},
	{-407.4681,-2085.5283,1501.0964},
	{-1499.7539,-1824.7689,1501.0964},
	{-1036.5919,-2204.4429,1501.0859},
	{2195.0483,-738.3933,1502.0032},
	{2180.9097,-568.4407,1502.0050},
	{2206.6799,-403.8394,1502.0081},
	{-1413.6167,-219.1090,1501.0168},
	{-1563.8229,-252.9845,1501.0166}
};

enum nozoneinfo
{
	Float:zEnter_x,
	Float:zEnter_y,
	Float:zEnter_z,
	zDistance,
};
new nzone[MAX_ZONE][nozoneinfo] =
{
	{280.1964,   840.0210,    18.1845, 	  150},
	{1421.4620,  -1735.1715,  13.0778,    100},
	{1172.8483,  -1393.1085,  13.0592,    100},
	{1809.0847,  -1891.0630,  13.1014,    100},
	{-2019.9607, -1002.5316,  31.7185,    100},
	{-1958.8065, 225.4428,    32.1599,    100},
	{-1992.9835, 165.4760,    27.2341,    100},
	{-2094.9800, -67.3422,    34.8602,    150},
	{-2140.2649, -782.1013,   32.0234,	  100},
	{-2142.2278, -948.1774,   32.0234,    100}
};




enum parkinginfo
{
    Float:pEnter_x,
	Float:pEnter_y,
	Float:pEnter_z,
	Float:pEnter_a,
	pVWorld,
    Float:pExit_x,
    Float:pExit_y,
    Float:pExit_z,
    Float:pExit_a,
    Float:pVExit_x,
    Float:pVExit_y,
    Float:pVExit_z,
    Float:pVExit_a,
};
//pEnter_x pEnter_y pEnter_z (Точки с которых заезжает в паркинг, pEnter_a поворот перса/автомобиля)
//pExit_x pExit_y pExit_z ((pExit_a поворот перса/автомобиля)Точки с которых выезжает из паркинга на точки pEnter_x pEnter_y pEnter_z)
//pVWorld (Вирт.Мир авто/игрока)
//pVExit_x, pVExit_y, pVExit_z, pVExit_a тоже самое что и pEnter_x pEnter_y pEnter_z, только на второй этаж
new parking[MAX_PARKING][parkinginfo] =
{
	{1159.0061, -1412.9017, 13.2993, 92.1731, 1, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1814.3567, -1877.0453, 13.5781, 3.1156, 2, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-78.3442,1180.6338,19.4433,178.3271, 3, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{2811.5740,1235.1237,10.4653,88.9500, 5, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{2650.6873,1181.1444,10.8203,91.8699, 6, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1790.0857,418.0161,19.9621,86.8489, 7, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1504.7184,-1325.3362,13.7060,271.2840, 8, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1436.8799,-1578.2943,13.2682,1.1519, 9, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1637.1638,-1684.8743,13.2173,93.0377, 10, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1403.2896,-1652.7843,13.1607,271.2161, 11, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1283.7948,-1349.4983,13.1657,3.1795, 12, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1175.3805,-1308.6919,13.6326,269.0903, 13, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{340.4299,-1618.8706,32.7566,179.5325, 14, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{611.8994,-1348.3763,13.4575,279.0285, 15, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{167.3457,-183.4712,1.3028,269.8813, 16, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-1991.2229,235.8233,28.6959,91.8888, 18, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-2099.6377,-52.8561,35.0399,181.8297, 19, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-2079.7205,-54.8950,34.9738,0.5623, 20, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-2153.8198,277.4999,35.0464,181.6078, 21, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-2443.9368,523.5727,29.9163,181.6118, 22, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-1967.0040,548.9451,34.8768,90.3882, 23, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-2565.8049,556.1598,14.1902,269.6837, 24, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-2627.1423,627.0738,14.1298,181.6917, 25, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-2730.2429,75.1695,4.0616,271.5603, 26, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-1994.6035,-1032.1533,31.8478,359.2426, 27, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1613.7208,1721.5741,10.5646,265.7845, 28, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{2201.0083,2411.4814,10.4901,177.4481, 29, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{2255.9700,-1135.6167,26.4331,246.4052, 30, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{2248.2683,-1726.0171,13.2362,268.7718, 31, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{2773.5608,-1649.4165,11.4144,270.2876, 32, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-2123.9248,-2295.5845,30.3705,142.9485, 33, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-2443.9199,105.2780,34.8502,258.0834, 34, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1446.2391,2816.8208,10.5487,271.3440, 35, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{946.8265,1660.0414,8.3660,268.2236, 36, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{-2456.6633,2292.8625,4.7045,1.0456, 37, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1156.6422,-1627.2762,13.6746,0.0072, 38, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{2758.7075,-2365.7222,13.6328,93.9539, 38, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872},
	{1798.8214,-1442.1119,13.4887,1.6389, 39, 2420.7029, 2355.3875, 1491.5951, 271.0465,2496.8066,2343.3479,1502.3184,87.2872}
};


enum cInform
{
    bool:cStatuse,
    Float:cPosX,
    Float:cPosY,
    Float:cPosZ,
    cObject,
    Text3D:cLabel,
    cScore,
    cSecund,
    cTimer,
    cStatuseTimer
}
new CottonInfo[MAX_COTTON_OBJECT][cInform] =
{
    {true, -264.8821,-1393.6427,11.4850},
    {true, -288.1983,-1396.1859,12.2953},
    {true, -310.4437,-1416.4810,15.0943},
    {true, -290.1641,-1416.4885,13.1366},
    {true, -265.3173,-1415.6331,10.4779},
    {true, -239.7378,-1413.1207,8.4944},
    {true, -214.3640,-1411.2096,6.3158},
    {true, -189.4012,-1408.9705,4.3835},
    {true, -189.3507,-1388.5031,5.8134},
    {true, -213.2893,-1389.5488,7.4410},
    {true, -240.2519,-1391.7345,10.5762}
};



enum EggsInfo
{
    Float:ePos_X,
	Float:ePos_Y,
	Float:ePos_Z,
	eVWorld,
	eCreate,
};
new Eggs[MAX_EGGS][EggsInfo] =
{
	{-2275.7200,87.0314,35.1641, 1, -1},
	{-2295.3132,107.4114,35.3125, 1, -1},
	{-2267.4077,117.4337,35.1718, 1, -1},
	{-2269.8113,47.6080,35.1641, 1, -1},
	{-2286.6294,56.6063,35.3125, 1, -1},
	{-2319.9539,48.5028,35.1641, 1, -1},
	{-2348.1899,76.4638,35.3125, 1, -1},
	{-2393.0188,66.4582,35.2920, 1, -1},
	{-2422.9236,85.2413,35.0234, 1, -1},
	{-2401.7488,121.9103,35.2546, 1, -1},
	{-2404.8376,176.9519,35.2152, 1, -1},
	{-2360.1316,192.3997,35.3125, 1, -1},
	{-2338.8518,237.9753,35.3168, 1, -1},
	{-2310.9033,223.2881,36.7057, 1, -1},
	{-2285.3687,266.9162,35.3203, 1, -1},
	{-2319.6628,249.2534,35.3203, 1, -1},
	{-2304.3103,133.7990,35.3125, 1, -1},
	{-2324.4160,166.4205,35.3125, 1, -1},
	{-2352.1743,198.1319,35.3125, 1, -1},
	{-2329.1748,113.6600,35.3125, 1, -1}
};

enum e_GARAGE_INTERIORS {
	Float:e_GARAGE_INTERIOR_X,
	Float:e_GARAGE_INTERIOR_Y,
	Float:e_GARAGE_INTERIOR_Z,
	Float:e_GARAGE_INTERIOR_A,
	e_GARAGE_INTERIOR_INT
}

static const Float:GaragesInteriors[][e_GARAGE_INTERIORS] = {
	{1386.9093,-20.0706,1000.9219,270.6992, 0},
	{2349.3528,2892.7764,1600.2864,2.0484, 1}, // 1 int
	{2462.3618,2701.5115,1601.0859,91.0358, 1}, // 2 int
	{2569.5083,2867.3750,1604.0771,271.4709, 1}, // 3 int
	{1370.4524,-1.6945,1000.9279,270.8442, 1}, // 4 int
	{2284.4954,2782.6543,1601.0859,1.1084, 1}, // 5 int
	{946.8175,2129.6323,1004.6800,268.6741, 1} // 6 int
};

enum e_GARAGE_INTERIORS_HOUSE {
	Float:e_GARAGE_INTERIOR_HOUSE_X,
	Float:e_GARAGE_INTERIOR_HOUSE_Y,
	Float:e_GARAGE_INTERIOR_HOUSE_Z,
	Float:e_GARAGE_INTERIOR_HOUSE_A,
	e_GARAGE_INTERIOR_HOUSE_INT
}

static const Float:GaragesInteriorsHouse[][e_GARAGE_INTERIORS_HOUSE] = { 
	{1386.9093,-20.0706,1000.9219,270.6992, 0},
	{2349.3528,2892.7764,1600.2864,2.0484, 1}, // 1 int
	{2462.3618,2701.5115,1601.0859,91.0358, 1}, // 2 int
	{2569.5083,2867.3750,1604.0771,271.4709, 1}, // 3 int
	{1370.4524,-1.6945,1000.9279,270.8442, 1}, // 4 int
	{2284.4954,2782.6543,1601.0859,1.1084, 1}, // 5 int
	{946.8175,2129.6323,1004.6800,268.6741, 1} // 6 int
};
enum PODVAL_INTERIORS {
	Float:PODVAL_INTERIORS_X,
	Float:PODVAL_INTERIORS_Y,
	Float:PODVAL_INTERIORS_Z,
	Float:PODVAL_INTERIORS_A,
	PODVAL_INTERIORS_INT
}

static const Float:GaragesInteriorsPodval[][PODVAL_INTERIORS] = { 
	{1386.9093,-20.0706,1000.9219,270.6992, 0},
	{1079.3595,937.4020,1604.8663,269.2763, 1}, // 1 int
	{2628.2300,1182.2301,1041.5614,180.6021, 2}, // 2 int
	{2545.1042,1037.9596,1039.9091,276.1696, 3} // 3 int
};

enum seatinfo
{
	Float:Sx,
	Float:Sy,
	Float:Sz,
	Float:Aa,
};
new seatt[MAX_SEAT][seatinfo] =
{
	//Больница
	{-1789.2051,-2004.9604,1501.0903,59.3800},
	{-1789.6532,-2001.8339,1501.0903,328.6809},
	{-1789.0481,-2007.0455,1500.7853,189.6812},
	{-1794.6908,-2007.1863,1500.7853,130.1708},
	{-1793.1312,-2005.5076,1501.0903,295.2989},
	{-1794.4841,-1999.8409,1501.0903,271.4854},
	{-1792.4552,-2000.4076,1501.0903,81.0003},
	{-1789.6532,-2001.8339,1501.0903,328.6809},
	{-1783.1976,-2003.2117,1500.7853,90.4977},
	{-1783.2350,-2005.0782,1500.7853,90.4977},
	{-1780.5627,-2005.1636,1500.7853,270.0159},
	{-1780.6246,-2003.5687,1500.7853,267.8226},
	{-1781.9171,-2013.8018,1500.7853,180.8368},
	{-1782.9802,-2015.5854,1500.7853,268.2576},
	{-1780.6510,-2015.6543,1500.7853,90.1376},
	{-1784.5140,-2019.5283,1500.7853,358.6434},
	{-1779.4257,-2019.5294,1500.7853,0.5234},
	{-1790.5179,-2009.5117,1500.7853,177.7508},
	{-1773.0221,-2014.9790,1500.7853,9.9473},
	{-1771.7029,-2015.0183,1500.7853,4.5968},
	{-1770.3730,-2012.7523,1500.7853,93.0050},
	{-1765.3116,-2019.5298,1500.7853,358.7142},
	{-1760.4913,-2019.5216,1500.7853,4.3543},
	{-1761.4897,-2015.4326,1500.7853,90.5218},
	{-1762.7877,-2013.8060,1500.7853,179.1725},
	{-1763.9377,-2015.8610,1500.7853,272.2334},
	{-1755.0911,-2009.5117,1500.7853,179.4858},
	{-1761.4093,-2005.5844,1500.7853,270.3297},
	{-1761.4072,-2003.2051,1500.7853,276.2831},
	{-1764.0135,-2003.2496,1500.7853,92.2336},
	{-1764.0454,-2005.1440,1500.7853,86.7383},
	{-1753.4989,-1999.8556,1500.7853,179.6072},
	{-1751.6305,-2001.8350,1500.7853,88.1130},
	{-1751.6906,-2003.0251,1500.7853,89.6796},
	{-1751.6906,-2004.0945,1500.7853,84.6662},
	{-1753.3190,-2006.1958,1500.7853,3.8256},
	{-1755.2855,-2004.1570,1500.7853,268.5712},
	{-1755.2855,-2003.0059,1500.7853,268.2578},
	{-1755.2855,-2001.8750,1500.7853,267.9444},
	{-1770.0690,-1992.5687,1500.7853,265.8688},
	{-1775.7933,-1991.1332,1500.7853,274.9789},
	{-1774.3978,-1990.1520,1500.7853,180.3513},
	{-1318.3417,21.0172,1601.0859,81.6747},
	{-1318.3411,20.0371,1601.0859,82.5585},
	{-1318.3401,19.0038,1601.0859,80.3089},
	{-1318.3430,17.9302,1601.0859,82.1327},
	{-1318.3418,17.0294,1601.0859,80.8232},
	{-1318.3425,15.9728,1601.0859,85.1537},
	{-1318.3409,14.9573,1601.0859,81.0241},
	{-1318.8937,27.0994,1601.0979,84.9892},
	{-1318.8933,25.7675,1601.0979,84.6197},
	{-1320.6290,28.6220,1601.0979,284.9306},
	{-1319.7896,29.6285,1601.0979,169.3891},
	{-1322.0007,30.7811,1601.0979,232.1126},
	{-1318.3413,9.4630,1601.0859,81.2337},
	{-1318.3401,8.3976,1601.0859,81.2577},
	{-1318.3430,7.4056,1601.0859,83.1700},
	{-1318.3417,6.4439,1601.0859,81.8281},
	{-1318.3422,5.4149,1601.0859,79.4662},
	{-1318.3436,4.4566,1601.0859,83.0253},
	{-1318.3448,3.3938,1601.0859,84.5357},
	{-1318.5466,-2.7670,1601.0979,71.5162},
	{-1319.8229,-2.7586,1601.0979,301.8746},
	{-1319.2006,-5.1612,1601.0979,6.4781},
	{-1329.3148,7.6078,1601.0889,90.0884},
	{-1334.8037,7.6043,1601.0889,92.0247},
	{-1334.7456,16.5302,1601.0889,87.0909},
	{-1329.2629,16.5246,1601.0889,91.1971},
	{-1344.3643,16.5272,1601.0889,90.4490},
	{-1338.9866,16.5438,1601.0889,87.0351},
	{-1335.1154,13.0879,1601.0859,354.9133},
	{-1337.6379,13.0383,1601.0859,356.8496},
	{-1337.6271,10.9995,1601.0859,173.1133},
	{-1335.1929,10.9793,1601.0859,174.2542},
	{-1353.4728,10.8000,1601.0859,352.6789},
	{-1354.8430,10.7932,1601.0859,356.0694},
	{-1354.8398,13.0721,1601.0859,175.7798},
	{-1353.4786,13.0730,1601.0859,176.0369},
	{-1353.4795,19.0992,1601.0859,353.8672},
	{-1354.8455,19.1001,1601.0859,355.6911},
	{-1354.8312,21.3819,1601.0859,175.0881},
	{-1353.4843,21.3709,1601.0859,174.0919},
	{-1354.8018,5.1273,1601.0859,175.5315},
	{-1353.4875,5.1291,1601.0859,174.5353},
	{-1353.5409,2.8515,1601.0859,354.3107},
	{-1354.8235,2.8517,1601.0859,353.9411},
	{-1351.0001,26.5556,1601.0919,84.6560},
	{-1355.1270,27.9257,1601.0919,183.8947},
	{-1356.9272,28.0993,1601.0919,262.2616},
	{-1351.0013,30.4578,1601.0919,83.5122},
	{-1355.0883,32.1785,1601.0919,197.2000},
	{-1356.9304,32.3180,1601.0919,262.0934},
	{-1352.4381,-2.4434,1601.0919,172.2303},
	{-1351.3690,-2.4424,1601.0919,172.1741},
	{-1350.3479,-2.4442,1601.0919,174.6246},
	{-1352.2032,-6.2920,1601.0919,91.1324},
	{-1353.4506,-6.2578,1601.0919,294.5439},
	{-1355.1294,-3.7436,1601.0919,182.0556},
	{-1356.9276,-3.5791,1601.0919,266.3759},
	{-1352.7837,-8.6517,1601.0919,4.4741},
	{-1350.6627,0.9639,1601.0859,86.5737},
	{-1350.6624,2.0711,1601.0859,80.9899},
	{-1350.6628,3.0639,1601.0859,84.1794},
	{-1350.6638,4.0969,1601.0859,85.4890},
	{-1350.6625,5.1102,1601.0859,82.4118},
	{-1350.6611,6.0411,1601.0859,82.1547},
	{-1350.6630,7.1190,1601.0859,82.5243},
	{-1350.6635,17.2722,1601.0859,81.5041},
	{-1350.6608,18.3023,1601.0859,84.5812},
	{-1350.6608,19.2633,1601.0859,86.7183},
	{-1350.6591,20.3232,1601.0859,84.1554},
	{-1350.6616,21.2785,1601.0859,84.0992},
	{-1350.6619,22.3041,1601.0859,79.9697},
	{-1350.6638,23.3073,1601.0859,85.5535},
	{-1344.4104,7.6072,1601.0889,87.1966},
	{-1338.6211,7.6074,1601.0889,88.4499},
	{-2057.4275,2662.5461,1498.7651,92.4898},
	{-2072.5027,2662.5964,1498.7651,266.3680},
	{-2052.2087,2664.7334,1500.9767,90.6332},
	{-2052.2410,2668.6936,1500.9767,93.4532},
	{-2052.2087,2673.2471,1500.9767,86.8731},
	{-2052.2573,2676.7971,1500.9767,90.9465},
	{-2059.2041,2682.1130,1501.1035,181.1874},
	{-2071.4055,2682.1711,1501.1086,180.8505},
	{-2077.8584,2677.2463,1500.9767,269.1881},
	{-2077.8367,2673.4421,1500.9767,268.2481},
	{-2077.8584,2668.7153,1500.9767,272.6349},
	{-2077.8186,2664.9199,1500.9767,275.1416},
	{-2066.2188,2674.8052,1500.9670,1.9591},
	{-2063.7134,2674.8237,1500.9670,359.1390},
	{-2068.0747,2670.6509,1500.9670,267.3315},
	{-2063.4387,2687.2922,1501.0114,88.3092},
	{-2063.4326,2689.0349,1501.0171,93.0091},
	{-2063.3186,2697.6870,1500.9766,90.8157},
	{-2063.3420,2701.6309,1500.9767,88.9356},
	{-2066.4656,2707.5627,1500.9767,274.4307},
	{-2066.4402,2709.2356,1500.9767,257.5106},
	{-2071.0881,2702.3376,1500.9766,357.7783},
	{-2069.1980,2707.4236,1500.9805,87.9956},
	{-2072.3289,2707.0867,1500.9805,264.7173},
	{-2071.0693,2703.9197,1500.9766,90.0673},
	{-2058.6841,2707.5212,1500.9766,174.6682},
	{-2058.6897,2703.8418,1500.9766,352.6432},
	{-2060.9380,2701.9387,1500.9766,276.5024},
	{-2060.9441,2703.6448,1500.9766,258.6422},
	{-2055.9844,2705.9670,1500.9766,178.7415},
	{-2054.0500,2705.6143,1500.9766,91.9474},
	{-2060.9136,2697.5815,1500.9766,262.1124},
	{-2060.9399,2695.8162,1500.9766,278.4059},
	{-2058.5352,2695.5154,1500.9805,180.6683},
	{-2058.6736,2692.2698,1500.9805,357.0533},
	{-2057.0635,2693.8503,1500.9805,87.2942},
	{-2054.2791,2692.9548,1500.9766,359.8733},
	{-2052.9912,2692.9585,1500.9766,354.2334},
	{-2052.4202,2690.2549,1500.9766,355.4867},
	{-2050.4709,2693.9380,1500.9766,91.3676},
	{-2052.9272,2695.0029,1500.9766,182.5486},
	{-2054.2939,2695.0896,1500.9766,174.5702},
	{-2068.7693,2690.9534,1501.0243,88.2058},
	{-2068.7805,2696.6553,1500.9766,92.2794},
	{-2070.9875,2695.1572,1500.9805,178.4468},
	{-2072.3467,2695.1475,1500.9805,181.8936},
	{-2073.6907,2695.3020,1500.9766,181.1685},
	{-2075.0608,2693.8206,1500.9766,271.4562},
	{-2073.6404,2692.0481,1500.9766,358.3954},
	{-2072.4119,2692.1292,1500.9766,3.6988},
	{-2070.9919,2692.1670,1500.9766,2.7588},
	//Банк
	{-2693.5850,804.0917,1500.9688,268.8689},
	{-2686.6924,799.1106,1501.0259,179.1095},
	{-2686.6072,793.9982,1501.0259,0.8446},
	{-2674.1150,794.0876,1501.0238,1.1579},
	{-2674.0935,799.1278,1501.0238,177.5662},
	{-2683.9451,809.0971,1500.9688,180.6763},
	{-2676.4595,809.1057,1500.9688,179.3994},
	{-2668.9709,809.2889,1500.9688,181.2794},
	{-2665.0186,805.8173,1500.9688,90.4118},
	{-2665.0776,799.2978,1500.9688,84.7717},
	{-2665.1338,792.5804,1500.9688,86.0251},
	{-2654.2834,800.6328,1500.9728,336.0915},
	{-2654.5762,802.7427,1500.9728,230.2072},
	{-2652.8401,802.5717,1500.9728,52.8589},
	{-2653.9722,792.0073,1500.9738,92.9892},
	{-2654.0149,793.1967,1500.9738,86.0957},
	{-2653.9976,794.4031,1500.9738,90.7958},
	{-2657.6299,794.3018,1500.9738,271.1092},
	{-2657.6992,793.2300,1500.9738,271.1092},
	{-2657.6377,791.9526,1500.9738,272.3626},
	{-2655.8013,805.2926,1500.9728,269.9775},
	{-2654.3057,805.2916,1500.9728,269.0375},
	{-2652.8376,805.2196,1500.9728,269.3509},
	{-2652.7659,807.2693,1500.9728,270.6042},
	{-2655.7664,807.2498,1500.9728,269.9774},
	{-2663.6299,811.6951,1500.9688,183.6650},
	{-2681.1680,818.6574,1500.9707,50.0152},
	{-2683.3774,821.2565,1500.9707,178.0009},
	{-2676.0173,816.8318,1500.9707,50.0385},
	{-2676.2837,819.2120,1500.9707,175.6629},
	{-2670.4272,818.9778,1500.9707,228.0135},
	{-2668.6702,818.8135,1500.9707,56.3053},
	{-2668.7029,816.8666,1500.9707,149.3427},
	{-2666.2612,814.7369,1500.9707,91.2072},
	//СМИ
	{-207.6315,1341.8110,1500.9788,181.3997},
	{-207.5164,1344.8932,1500.9788,358.8930},
	{-199.0293,1334.9362,1500.9788,269.1105},
	{-195.1335,1331.3098,1500.9823,273.9788},
	{-189.5421,1331.1632,1500.9823,104.0055},
	{-185.3515,1334.6813,1500.9788,90.3638},
	{-177.0305,1337.3638,1500.9788,359.9780},
	{-176.9752,1342.3977,1500.9788,181.8581},
	{-176.3520,1321.2124,1500.9888,0.5161},
	{-173.6424,1321.1659,1500.9888,1.1428},
	{-173.5621,1323.2734,1500.9888,0.1793},
	{-176.3484,1323.0828,1500.9888,0.1793},
	{-176.4288,1325.2229,1500.9888,0.3477},
	{-173.5993,1325.2953,1500.9888,359.2393},
	{-177.6250,1315.7168,1500.9888,224.8650},
	{-175.0172,1316.5818,1500.9888,312.5757},
	{-190.9861,1333.4534,1500.9823,204.4415},
	{-191.0896,1336.5474,1500.9823,342.9362},
	{-193.9646,1336.3262,1500.9823,24.2966},
	{-193.8572,1333.4756,1500.9823,161.2011},
	{-195.1984,1338.6049,1500.9823,276.6538},
	{-199.0293,1334.9362,1500.9788,269.1105},
	{-185.3530,1334.6813,1500.9788,90.3638},
	{-209.5785,1315.8187,1500.9888,0.3946},
	{-211.6852,1317.6647,1500.9888,268.5870},
	{-207.6581,1325.1835,1507.6281,272.2438},
	{-207.5859,1318.9081,1507.6270,270.0505},
	{-203.6230,1307.2788,1507.6416,358.4115},
	{-198.3401,1307.4397,1507.6416,283.2108},
	{-194.5429,1307.3259,1507.6416,83.1573},
	{-190.5260,1307.3118,1507.6416,274.4374},
	{-186.8858,1307.3112,1507.6416,87.8573},
	{-181.8569,1307.4370,1507.6416,0.6049},
	{-174.6543,1303.4330,1507.6692,0.4173},
	{-174.0945,1307.1216,1507.6692,93.0395},
	{-174.0721,1308.4802,1507.6692,92.2443},
	{-174.9118,1310.6234,1507.6692,194.5603},
	{-176.0843,1308.4719,1507.6692,268.3394},
	{-176.0110,1307.1038,1507.6692,263.9528},
	{-209.3879,1304.4447,1507.6592,89.2368},
	{-209.5183,1305.8198,1507.6592,90.1768},
	{-210.5679,1308.0991,1507.6592,168.0292},
	{-211.6062,1305.8553,1507.6592,270.0316},
	{-211.6220,1304.4248,1507.6592,270.3214},
	{-210.2797,1297.6603,1507.6692,177.7661},
	{-205.3184,1300.3325,1507.6770,177.4527},
	{-205.3562,1296.8512,1507.6770,179.1877},
	{-200.9476,1300.3524,1507.6770,179.9594},
	{-202.1382,1298.1035,1507.6770,44.4532},
	{-189.6395,1299.4836,1507.6692,49.1532},
	{-181.1057,1297.2567,1507.6770,359.4778}
};

enum iInfo
{
Float:iCam_X,
Float:iCam_Y,
Float:iCam_Z,
Float:iCamAt_X,
Float:iCamAt_Y,
Float:iCamAt_Z,
	iInterior,
	iLevel,
	iCost
}
new Float:IntInfo[34][iInfo] = //34
{
	{	0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0,	0,	0		},
	{	249.6246,	306.6749,	1001.1484,	243.5571,	300.3347,	999.1484,	1,	1,	40000	},
	{	266.9934,	303.4084,	999.1484,	273.9032,	306.8496,	999.1484,	2,	1,	40000	},
	{	237.3471,	1186.9100,	1080.2578,	231.0561,	1204.1001,	1080.2578,	3,	1,	390000	},
	{	311.0790,	311.6574,	1003.3047,	300.4887,	301.3558,	1003.5391,	4,	1,	120000	},
	{	226.4762,	1114.2119,	1080.9939,	241.9857,	1114.0405,	1080.9922,	5,	1,	550000	},
	{	742.7902,	1436.4205,	1102.7031,	762.0859,	1442.8284,	1102.7031,	6,	1,	140000	},
	{	224.1152,	1021.5891,	1084.0173,	243.2221,	1039.6519,	1084.0137,	7,	1,	620000	},
	{	-52.5170,	1412.7664,	1084.4297,	-45.2184,	1403.6163,	1084.4370,	8,	1,	80000	},
	{	259.1778,	1237.3501,	1084.2578,	265.0774,	1250.0245,	1084.2578,	9,	1,	80000	},
	{	18.3519,	1340.2017,	1084.3750,	32.0237,	1345.5005,	1088.8750,	10,	1,	240000	},
	{	443.1728,	506.6413,	1001.4195,	451.4167,	515.1450,	1001.4195,	12,	1,	60000	},
	{	387.1001,	1472.7684,	1080.1875,	383.9466,	1470.7700,	1080.1949,	15,	1,	60000	},
	{	85.73,	1322.62,	1085.04,	85.59,	1323.23,	1085.07,9,1,800000	},
	{	-71.72,	1366.68,	1082.73,	-70.58,	1366.15,	1082.32,6,1,60000	},
	{	217.61,	1238.98,	1084.30,	218.12,	1239.33,	1084.06,2,1,90000	},
	{	330.23,	1477.15,	1085.04,	329.94,	1478.36,	1084.91,15,1,110000	},
	{	445.27,	1397.00,	1086.54,	445.69,	1398.18,	1086.25,2,1,400000	},
	{	316.37,	1116.34,	1085.26,	317.39,	1117.06,	1085.17,5,1,100000	},
	{	2366.97,	-1126.16,	1052.11,	2366.66,	-1126.70,	1052.00,8,1,380000	},
	{	2306.26,	-1206.41,	1051.03,	2306.81,	-1206.70,	1050.84,6,1,190000	},
	{	2236.43,	-1080.86,	1050.34,	2236.60,	-1080.26,	1050.27,2,1,240000	},
	{	2197.01,	-1199.81,	1050.94,	2196.50,	-1200.17,	1050.78,6,1,380000	},
	{	2263.93,	-1206.06,	1051.39,	2263.40,	-1206.37,	1051.25,10,1,380000	},
	//Новые инты дома
	{-2156.278564, -2131.817382, 1503.491455,	-2159.385742, -2128.048583, 1502.422851,20,1,2000000},
	{-647.691406, -2179.545898, 1503.273437,	-652.014892, -2177.248779, 1502.258300,21,1,2100000},
	{-400.834320, -2086.662353, 1503.339233,	-404.808624, -2083.730224, 1502.559936,22,1,4000000},
	{-1520.481933, -1824.294555, 1503.595703,	-1515.651489, -1824.394165, 1502.308349,23,1,2800000},
	{-1040.182006, -2186.511718, 1501.848144,	-1042.362304, -2191.009521, 1501.721923,24,1,3900000},
	{2177.498779, -738.629272, 1503.662231,		2179.054199, -743.321228, 1502.910034,25,1,13000000},
	{2181.027099, -579.880187, 1504.156616,		2185.185791, -577.309814, 1503.108520,26,1,13000000},
	{2202.181396, -402.127716, 1504.494506,		2200.481201, -406.671997, 1503.286621,27,1,13000000},
	{-1400.403930, -235.111724, 1504.193237,	-1402.694335, -230.840240, 1502.964965,28,1,15000000},
	{-1571.176025, -246.951232, 1501.898559,	-1574.714965, -250.457519, 1501.472045,29,1,12000000}
};
enum podInfo
{
Float:podCam_X,
Float:podCam_Y,
Float:podCam_Z,
Float:podCam_X1,
Float:podCam_Y1,
Float:podCam_Z1,
Float:podCamAt_X,
Float:podCamAt_Y,
Float:podCamAt_Z,
Float:podCamAt_X1,
Float:podCamAt_Y1,
Float:podCamAt_Z1,
	podSpeed,
	podInt,
	podCost
}
new Float:PodvalInfo[4][podInfo] = //Камера покупки инты
{
	{	0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,  0,  0,	0	},
	{	1084.838256, 939.965087, 1601.679077, 1083.828002, 946.606384, 1603.037109, 1087.898071, 943.740478, 1600.502685, 1088.096313, 947.871459, 1600.760864,  20000,  1,	300000	},
	{	2619.709716, 1164.828247, 1039.366943, 2625.424316, 1178.150268, 1039.191040 , 2623.118896, 1168.284912, 1038.171630, 2628.873046, 1174.644165, 1038.289794,  20000,  2,	 700000	},
	{	2547.804199, 1037.295532, 1038.472412, 2563.599853, 1043.729858,1038.253540 , 2551.334472,1040.533569,1037.039672, 2560.306396,1047.175048, 1036.742431,  20000,	 3,	 1400000	}
};
enum garInfo
{
Float:garCam_X,
Float:garCam_Y,
Float:garCam_Z,
Float:garCam_X1,
Float:garCam_Y1,
Float:garCam_Z1,
Float:garCamAt_X,
Float:garCamAt_Y,
Float:garCamAt_Z,
Float:garCamAt_X1,
Float:garCamAt_Y1,
Float:garCamAt_Z1,
	garSpeed,
	garInt,
	garCost
}
new Float:GarageInfo[7][garInfo] = //Камера покупки инты
{
	{	0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,		0.0000,  0,  0,	0	},
	{	2340.442626, 2888.738281,1600.952148, 2358.332519,2906.014892,1600.966064, 2344.222412,2891.917480,1600.173095, 2354.569091,2902.797851,1600.268188,  20000,  1,	400000	},
	{	2447.329101,2695.185058,1601.720947, 2467.017089, 2697.145996,1601.758544, 2452.184570, 2696.343994,1601.435913, 2464.730957,2701.542480,1601.092529,  20000,  2,	 700000	},
	{	2581.607177,2848.583496,1605.638305, 2563.421630, 2877.757812, 1604.709350, 2578.379653, 2852.324218, 1604.891113, 2565.578125, 2873.266357, 1604.287963,  20000,	 3,	 1200000	},
	{	1366.951049, 1.753100, 1001.992309, 1399.594848,-10.286399,1001.553405 , 1371.372680, -0.532240, 1001.516479, 1394.967895, -8.459370,1001.050354,  20000,	 4,	 2600000	},
	{	2274.438476,2798.252685, 1602.919677, 2304.161132,2785.443115, 1601.723999, 2278.704833,2795.740722, 1602.221557, 2299.293701, 2786.492919,1601.270263,  20000,	 5,	 3800000	},
	{	959.836608, 2148.204589,1005.324890 , 942.268676, 2113.097656, 1005.399475, 957.975891, 2143.578125, 1004.958007, 946.322204, 2115.971435,1004.842041,  20000,	 6,	 5000000	}
};

new Float:PrisonPos[5][3] =
{
	{610.9518,-586.3849,17.2266},
	{-1590.2208,716.0150,-5.2422},
	{1568.9985,-1694.6547,5.8906},
	{2286.9282,2427.9839,10.8203},
	{-1591.2236,716.0541,-5.2422}
};
new Float:JailPos[4][4] =
{
	{69.5575,1061.1536,-50.9141},
	{61.0064,1059.9847,-50.9141},
	{54.1056,1067.1543,-50.9141},
	{62.2032,1061.4543,-50.9141}
};
new Tfarm_CP[70];
new Kfarm_CP[41];
new Zfarm_CP[25];
new Test_CP[27];
new FTest_CP[32];
enum arInfo
{
	aRentID,
	aID,//ID
Float:aPos_X,//Кордината X
Float:aPos_Y,//Кордината Y
Float:aPos_Z,//Кордината Z
Float:aPos_A,//Угол поворота
	aColor_1,//Цвет 1
	aColor_2,//Цвет 2,
	aBizid,
	aNumber[20]
};
new ArendInfo[175][arInfo] =
{
	{INVALID_PLAYER_ID, 527, 2408.5164, 1667.7656, 10.6493, 0.0467,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 526, 2402.1306, 1667.8734, 10.6502, 359.4935,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 527, 2408.5586, 1658.6415, 10.6491, 179.8898,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 527, 2402.1724, 1658.4430, 10.6493, 179.7292,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 586, 1593.6954, 1832.7589, 10.2700, 180.5820,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 462, 1595.8210, 1832.8043, 10.3100, 180.5820,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 462, 1597.9672, 1832.8949, 10.3100, 180.5820,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 586, 1600.0338, 1832.6292, 10.2700, 180.5820,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 586, 1602.2183, 1832.6133, 10.2700, 180.5820,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 586, 1604.3276, 1832.6333, 10.2700, 180.5820,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 462, 1606.4049, 1832.9114, 10.3100, 180.5820,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 586, 1216.0262, -1426.8013, 12.8806, 0.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 586, 1217.4323, -1426.7660, 12.8806, 0.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 586, 1218.7133, -1426.7719, 12.8806, 0.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 586, 1219.9784, -1426.6898, 12.8806, 0.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 586, 1222.7548, -1426.7323, 12.8806, 0.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 586, 1214.6040, -1426.8230, 12.8806, 0.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 462, 1509.6296, -1280.8462, 14.0600, 137.3464,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 462, 1510.4818, -1281.5426, 14.0600, 137.3464,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 462, 1511.3479, -1282.1930, 14.0600, 137.3464,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 462, 1512.3319, -1282.9500, 14.0600, 137.3464,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 479, 2398.6523, -1807.9036, 13.2337, 358.8433,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 496, 2390.9636, -1808.1459, 13.2337, 358.8433,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 517, 2383.2468, -1808.0560, 13.2337, 358.8433,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 516, 2375.3943, -1808.0653, 13.2337, 358.8433,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 479, 2777.5156, -2105.9504, 11.2718, 40.2467,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 479, 2771.6145, -2111.0305, 11.2718, 40.2467,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 526, 2765.5601, -2116.0679, 11.2718, 40.2467,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 517, 2759.6167, -2120.8315, 11.2718, 40.2467,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 518, 2752.5469, -2111.5220, 12.0515, 269.8227,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 422, 667.6203, -543.1777, 16.2203, 89.3185,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 422, 667.6231, -546.2809, 16.2203, 89.3185,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 422, 667.5521, -549.3002, 16.2203, 89.3185,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 462, 652.4126, -588.9568, 15.8675, 0.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 462, 653.6716, -588.8953, 15.8675, 0.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 462, 655.0917, -588.9109, 15.8675, 0.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 462, 656.5114, -588.8748, 15.8675, 0.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 426, 1280.7815, -1292.0701, 13.1210, 90.0676,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 426, 1280.8137, -1295.7914, 13.1210, 90.0676,-1,-1,INVALID_BIZ,"Аренда LS"},
	{INVALID_PLAYER_ID, 426, 1280.8157, -1299.6920, 13.1210, 90.0676,-1,-1,INVALID_BIZ,"Аренда LS"},
	{INVALID_PLAYER_ID, 526, 1281.2010, -1303.5446, 13.1210, 90.0676,-1,-1,INVALID_BIZ,"Аренда LS"},
	{INVALID_PLAYER_ID, 426, 1280.8484, -1307.4536, 13.1210, 90.0676,-1,-1,INVALID_BIZ,"Аренда LS"},
	{INVALID_PLAYER_ID, 526, 1280.9872, -1310.9534, 13.1210, 90.0676,-1,-1,INVALID_BIZ,"Аренда LS"},
	{INVALID_PLAYER_ID, 547, 1392.1981, 385.5167, 19.4100, 246.3684,-1,-1,BIZ_RENT_SF,"Аренда LS"},//villeage
	{INVALID_PLAYER_ID, 547, 1390.7390, 382.2040, 19.4100, 246.3684,-1,-1,BIZ_RENT_SF,"Аренда LS"},
	{INVALID_PLAYER_ID, 546, 1389.3024, 378.8274, 19.4100, 246.3684,-1,-1,BIZ_RENT_SF,"Аренда LS"},
	{INVALID_PLAYER_ID, 546, 1387.8916, 375.5937, 19.4100, 246.3684,-1,-1,BIZ_RENT_SF,"Аренда LS"},
	{INVALID_PLAYER_ID, 546, 1386.3928, 372.3194, 19.4100, 246.3684,-1,-1,BIZ_RENT_SF,"Аренда LS"},
	{INVALID_PLAYER_ID, 547, 1393.5696, 388.9565, 19.4100, 246.3684,-1,-1,BIZ_RENT_SF,"Аренда LS"},
	{INVALID_PLAYER_ID, 547, 1394.9910, 392.3134, 19.4100, 246.3684,-1,-1,BIZ_RENT_SF,"Аренда LS"},
	{INVALID_PLAYER_ID, 546, 2475.6345, -1526.8542, 23.6052, 359.0000,-1,-1,BIZ_RENT_LV,"Аренда LS"}, //getto
	{INVALID_PLAYER_ID, 546, 2478.8823, -1526.9244, 23.6052, 359.0000,-1,-1,BIZ_RENT_LV,"Аренда LS"},
	{INVALID_PLAYER_ID, 547, 2481.9150, -1526.8684, 23.6052, 359.0000,-1,-1,BIZ_RENT_LV,"Аренда LS"},
	{INVALID_PLAYER_ID, 546, 2484.2478, -1517.7936, 23.6052, 181.9089,-1,-1,BIZ_RENT_LV,"Аренда LS"},
	{INVALID_PLAYER_ID, 547, 2487.3140, -1517.7598, 23.6052, 181.9089,-1,-1,BIZ_RENT_LV,"Аренда LS"},
	{INVALID_PLAYER_ID, 547, 2490.3770, -1517.8289, 23.6052, 181.9089,-1,-1,BIZ_RENT_LV,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,552.2256,-1263.0308,16.8377,215.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,549.2261,-1265.1127,16.8615,215.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,546.2819,-1267.1350,16.8603,216.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,543.2506,-1269.3328,16.8853,212.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,540.3386,-1271.8612,16.9312,218.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,537.4234,-1274.1729,16.8892,218.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,534.7526,-1276.3138,16.8918,219.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,531.9340,-1278.4873,16.8892,218.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,565.7926,-1283.7555,17.0098,103.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,564.8121,-1279.5139,17.0102,103.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,563.9153,-1275.2931,17.0073,102.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,563.3939,-1271.1617,16.9935,103.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 540,562.5081,-1267.2034,16.9659,103.0,-1,-1,BIZ_RENT_LS,"Аренда LS"},
	{INVALID_PLAYER_ID, 487, 1875.0159, -2270.8831, 14.4766, -90.0000, -1,-1,BIZ_AERO_LS,""},
	{INVALID_PLAYER_ID, 487, 1875.0159, -2286.0461, 14.4766, -90.0000, -1,-1,BIZ_AERO_LS,""},
	{INVALID_PLAYER_ID, 487, 1875.0159, -2302.0259, 14.4766, -90.0000, -1,-1,BIZ_AERO_LS,""},
	{INVALID_PLAYER_ID, 487, 1859.6726, -2292.7288, 14.4766, -90.0000, -1,-1,BIZ_AERO_LS,""},
	{INVALID_PLAYER_ID, 487, 1859.6726, -2277.2041, 14.4766, -90.0000, -1,-1,BIZ_AERO_LS,""},
	{INVALID_PLAYER_ID, 469, 1884.0103, -2354.0991, 14.4766, -90.0000, -1,-1,BIZ_AERO_LS,""},
	{INVALID_PLAYER_ID, 469, 1884.0103, -2366.1475, 14.4766, -90.0000, -1,-1,BIZ_AERO_LS,""},
	{INVALID_PLAYER_ID, 469, 1884.0103, -2378.2358, 14.4766, -90.0000, -1,-1,BIZ_AERO_LS,""},
	{INVALID_PLAYER_ID, 469, 1870.8276, -2372.3872, 14.4766, -90.0000, -1,-1,BIZ_AERO_LS,""},
	{INVALID_PLAYER_ID, 469, 1870.8276, -2359.9214, 14.4766, -90.0000, -1,-1,BIZ_AERO_LS,""},
	{INVALID_PLAYER_ID, 454, 132.8696, -1814.7062, 0.5467, 0.0000, -1,-1,BIZ_RENTLV2,""},
	{INVALID_PLAYER_ID, 454, 120.6497, -1814.7834, 0.5467, 0.0000, -1,-1,BIZ_RENTLV2,""},
	{INVALID_PLAYER_ID, 484, 129.2275, -1885.0004, 0.5487, 90.0000, -1,-1,BIZ_RENTLV2,""},
	{INVALID_PLAYER_ID, 484, 129.4274, -1872.4661, 0.5487, 90.0000, -1,-1,BIZ_RENTLV2,""},
	{INVALID_PLAYER_ID, 484, 130.4901, -1836.3348, 0.5487, 90.0000, -1,-1,BIZ_RENTLV2,""},
	{INVALID_PLAYER_ID, 484, 130.5704, -1829.3671, 0.5487, 90.0000, -1,-1,BIZ_RENTLV2,""},
	{INVALID_PLAYER_ID, 558, 2148.7693, 1398.1857, 10.3921, 180.0000, -1,-1,BIZ_RENTLV3,""},
	{INVALID_PLAYER_ID, 558, 2145.5740, 1398.1857, 10.3921, 180.0000, -1,-1,BIZ_RENTLV3,""},
	{INVALID_PLAYER_ID, 558, 2139.1221, 1398.1857, 10.3921, 180.0000, -1,-1,BIZ_RENTLV3,""},
	{INVALID_PLAYER_ID, 558, 2135.9407, 1398.1857, 10.3921, 180.0000, -1,-1,BIZ_RENTLV3,""},
	{INVALID_PLAYER_ID, 541, 2126.3281, 1398.1857, 10.3921, 180.0000, -1,-1,BIZ_RENTLV3,""},
	{INVALID_PLAYER_ID, 541, 2119.9055, 1398.1857, 10.3921, 180.0000, -1,-1,BIZ_RENTLV3,""},
	{INVALID_PLAYER_ID, 541, 2116.7261, 1398.1857, 10.3921, 180.0000, -1,-1,BIZ_RENTLV3,""},
	{INVALID_PLAYER_ID, 542, 2116.8022, 1409.0896, 10.5221, 360.0000, -1,-1,BIZ_RENTLV3,""},
	{INVALID_PLAYER_ID, 542, 2110.3604, 1409.0831, 10.5221, 360.0000, -1,-1,BIZ_RENTLV3,""},
	{INVALID_PLAYER_ID, 542, 2107.2341, 1409.0896, 10.5221, 360.0000,-1,-1,BIZ_RENTLV3,""},
	{INVALID_PLAYER_ID, 560, 2216.1982, 2034.6406, 10.3637, 270.0000, -1,-1,BIZ_RENTLV4,""},
	{INVALID_PLAYER_ID, 560, 2216.1982, 2038.1283, 10.3637, 270.0000, -1,-1,BIZ_RENTLV4,""},
	{INVALID_PLAYER_ID, 560, 2216.1982, 2041.7065, 10.3637, 270.0000, -1,-1,BIZ_RENTLV4,""},
	{INVALID_PLAYER_ID, 560, 2216.1982, 2045.4866, 10.3637, 270.0000, -1,-1,BIZ_RENTLV4,""},
	{INVALID_PLAYER_ID, 496, 2246.2927, 2046.3232, 10.4237, 270.0000, -1,-1,BIZ_RENTLV4,""},
	{INVALID_PLAYER_ID, 496, 2246.2927, 2042.3247, 10.4237, 270.0000, -1,-1,BIZ_RENTLV4,""},
	{INVALID_PLAYER_ID, 496, 2246.2927, 2038.5048, 10.4237, 270.0000, -1,-1,BIZ_RENTLV4,""},
	{INVALID_PLAYER_ID, 426, 2235.0664, 2038.6821, 10.4637, 90.0000, -1,-1,BIZ_RENTLV4,""},
	{INVALID_PLAYER_ID, 426, 2235.0664, 2042.5248, 10.4637, 90.0000, -1,-1,BIZ_RENTLV4,""},
	{INVALID_PLAYER_ID, 426, 2235.0664, 2050.1907, 10.4637, 90.0000, -1,-1,BIZ_RENTLV4,""},
	{INVALID_PLAYER_ID, 410, 1731.6844, 1885.4795, 10.3846, 90.5101, -1,-1,BIZ_RENTLV5,""},
	{INVALID_PLAYER_ID, 410, 1731.6948, 1890.8372, 10.3846, 90.5101, -1,-1,BIZ_RENTLV5,""},
	{INVALID_PLAYER_ID, 410, 1731.6909, 1893.6300, 10.3846, 90.5101, -1,-1,BIZ_RENTLV5,""},
	{INVALID_PLAYER_ID, 404, 1731.2958, 1899.5796, 10.3846, 90.5101, -1,-1,BIZ_RENTLV5,""},
	{INVALID_PLAYER_ID, 404, 1731.2533, 1902.0092, 10.3846, 90.5101, -1,-1,BIZ_RENTLV5,""},
	{INVALID_PLAYER_ID, 404, 1731.2714, 1905.6315, 10.3846, 90.5101, -1,-1,BIZ_RENTLV5,""},
	{INVALID_PLAYER_ID, 400, 1741.6327, 1885.7103, 10.7886, 270.0000, -1,-1,BIZ_RENTLV5,""},
	{INVALID_PLAYER_ID, 400, 1741.6398, 1888.6401, 10.7886, 270.0000, -1,-1,BIZ_RENTLV5,""},
	{INVALID_PLAYER_ID, 400, 1741.6577, 1895.1151, 10.7886, 270.0000, -1,-1,BIZ_RENTLV5,""},
	{INVALID_PLAYER_ID, 401, 1741.7596, 1897.8267, 10.5856, 270.0000, -1,-1,BIZ_RENTLV5,""},
	{INVALID_PLAYER_ID, 400, 2080.5874, 2468.3430, 10.7266, 0.0190, -1,-1,BIZ_RENTLV6,""},
	{INVALID_PLAYER_ID, 400, 2084.7898, 2468.3430, 10.7266, 0.0190, -1,-1,BIZ_RENTLV6,""},
	{INVALID_PLAYER_ID, 400, 2088.9299, 2468.3430, 10.7266, 0.0190, -1,-1,BIZ_RENTLV6,""},
	{INVALID_PLAYER_ID, 401, 2082.2666, 2480.2153, 10.7266, 180.0000, -1,-1,BIZ_RENTLV6,""},
	{INVALID_PLAYER_ID, 401, 2078.1626, 2480.2153, 10.7266, 180.0000, -1,-1,BIZ_RENTLV6,""},
	{INVALID_PLAYER_ID, 401, 2073.9431, 2480.2153, 10.7266, 180.0000, -1,-1,BIZ_RENTLV6,""},
	{INVALID_PLAYER_ID, 401, 2069.8408, 2480.2153, 10.7266, 180.0000, -1,-1,BIZ_RENTLV6,""},
	{INVALID_PLAYER_ID, 404, 2057.1904, 2480.2153, 10.7266, 180.0000, -1,-1,BIZ_RENTLV6,""},
	{INVALID_PLAYER_ID, 404, 2053.1138, 2480.2007, 10.7266, 180.0000, -1,-1,BIZ_RENTLV6,""},
	{INVALID_PLAYER_ID, 422, -30.8412, 1166.7690, 19.3222, 360.0000, -1,-1,BIZ_RENTLV7,""},
	{INVALID_PLAYER_ID, 422, -34.2425, 1166.7690, 19.3222, 360.0000, -1,-1,BIZ_RENTLV7,""},
	{INVALID_PLAYER_ID, 422, -37.8182, 1166.7690, 19.3222, 360.0000, -1,-1,BIZ_RENTLV7,""},
	{INVALID_PLAYER_ID, 527, -44.6972, 1166.7690, 19.3222, 360.0000, -1,-1,BIZ_RENTLV7,""},
	{INVALID_PLAYER_ID, 527, -48.3838, 1166.7690, 19.3222, 360.0000, -1,-1,BIZ_RENTLV7,""},
	{INVALID_PLAYER_ID, 549, 2161.2803, -1192.2465, 23.5259, 90.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 543, 2161.4214, -1187.3746, 23.5259, 90.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 542, 2161.5625, -1182.4960, 23.5259, 90.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 589, 2161.6877, -1177.5209, 23.5259, 90.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 549, 196.5415, -155.3585, 1.2498, 180.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 543, 199.4011, -155.4082, 1.3298, 180.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 542, 218.6169, -173.2578, 1.2898, 90.0000,-1,-1,INVALID_BIZ,"Аренда LS"},//hospital
	{INVALID_PLAYER_ID, 549, 2760.3621, 1432.2369, 10.2147, 270.0000,-1,-1,INVALID_BIZ,"Аренда LV"},//hospital
	{INVALID_PLAYER_ID, 543, 2760.4126, 1429.2205, 10.2147, 270.0000,-1,-1,INVALID_BIZ,"Аренда LV"},//hospital
	{INVALID_PLAYER_ID, 542, 2760.6042, 1426.3209, 10.2147, 270.0000,-1,-1,INVALID_BIZ,"Аренда LV"},
	{INVALID_PLAYER_ID,400, -1989.9163, 275.5569, 35.1662, 267.0000 ,-1,-1,BIZ_SFRENT1,"Аренда SF"},
	{INVALID_PLAYER_ID,400, -1990.0594, 272.2518, 35.1662, 267.0000 ,-1,-1,BIZ_SFRENT1,"Аренда SF"},
	{INVALID_PLAYER_ID,400, -1990.3448, 269.0416, 35.1662, 267.0000 ,-1,-1,BIZ_SFRENT1,"Аренда SF"},
	{INVALID_PLAYER_ID,401, -1990.7004, 263.9048, 34.8462, 267.0000 ,-1,-1,BIZ_SFRENT1,"Аренда SF"},
	{INVALID_PLAYER_ID,401, -1990.9237, 261.2656, 34.8462, 267.0000 ,-1,-1,BIZ_SFRENT1,"Аренда SF"},
	{INVALID_PLAYER_ID,404, -1991.3481, 255.2821, 34.8462, 264.0474 ,-1,-1,BIZ_SFRENT1,"Аренда SF"},
	{INVALID_PLAYER_ID,404, -1991.6816, 252.6617, 34.8462, 264.0474 ,-1,-1,BIZ_SFRENT1,"Аренда SF"},
	{INVALID_PLAYER_ID,410, -1992.7944, 248.2620, 34.8462, 264.0474 ,-1,-1,BIZ_SFRENT1,"Аренда SF"},
	{INVALID_PLAYER_ID,410, -1993.0652, 245.8304, 34.8462, 264.0474 ,-1,-1,BIZ_SFRENT1,"Аренда SF"},
	{INVALID_PLAYER_ID,400, -2585.8699, 335.4568, 4.9638, 90.0000 ,-1,-1,BIZ_SFRENT2,"Аренда SF"},
	{INVALID_PLAYER_ID,400, -2585.8457, 331.9096, 4.9638, 90.0000 ,-1,-1,BIZ_SFRENT2,"Аренда SF"},
	{INVALID_PLAYER_ID,401, -2585.9548, 328.1809, 4.9638, 90.0000 ,-1,-1,BIZ_SFRENT2,"Аренда SF"},
	{INVALID_PLAYER_ID,401, -2585.9983, 324.8647, 4.9638, 90.0000 ,-1,-1,BIZ_SFRENT2,"Аренда SF"},
	{INVALID_PLAYER_ID,404, -2585.9209, 321.3739, 4.9638, 90.0000 ,-1,-1,BIZ_SFRENT2,"Аренда SF"},
	{INVALID_PLAYER_ID,404, -2585.9912, 317.6576, 4.9638, 90.0000 ,-1,-1,BIZ_SFRENT2,"Аренда SF"},
	{INVALID_PLAYER_ID,410, -2586.1077, 314.0794, 4.9638, 90.0000 ,-1,-1,BIZ_SFRENT2,"Аренда SF"},
	{INVALID_PLAYER_ID,410, -2586.0518, 310.8368, 4.9638, 90.0000 ,-1,-1,BIZ_SFRENT2,"Аренда SF"},
	{INVALID_PLAYER_ID,400, -2493.7048, 795.6027, 35.2550, 270.0000 ,-1,-1,BIZ_SFRENT3,"Аренда SF"},
	{INVALID_PLAYER_ID,400, -2493.6475, 792.7779, 35.2550, 270.0000 ,-1,-1,BIZ_SFRENT3,"Аренда SF"},
	{INVALID_PLAYER_ID,401, -2493.6985, 790.0810, 35.1350, 270.0000 ,-1,-1,BIZ_SFRENT3,"Аренда SF"},
	{INVALID_PLAYER_ID,401, -2493.7954, 787.2208, 35.1350, 270.0000 ,-1,-1,BIZ_SFRENT3,"Аренда SF"},
	{INVALID_PLAYER_ID,404, -2493.5164, 784.3647, 34.7750, 270.0000 ,-1,-1,BIZ_SFRENT3,"Аренда SF"},
	{INVALID_PLAYER_ID,404, -2493.6309, 781.4155, 34.7750, 270.0000 ,-1,-1,BIZ_SFRENT3,"Аренда SF"},
	{INVALID_PLAYER_ID,410, -2459.8179, 779.5052, 34.7350, 90.0000 ,-1,-1,BIZ_SFRENT3,"Аренда SF"},
	{INVALID_PLAYER_ID,410, -2459.4915, 786.4857, 34.7350, 90.0000,-1,-1,BIZ_SFRENT3,"Аренда SF"},
	{INVALID_PLAYER_ID,409, -1764.7040, 956.2208, 24.4421, 270.0000 ,-1,-1,BIZ_SFRENT4,"Аренда SF"},
	{INVALID_PLAYER_ID,409, -1752.3950, 956.3077, 24.4421, 270.0000 ,-1,-1,BIZ_SFRENT4,"Аренда SF"},
	{INVALID_PLAYER_ID,409, -1760.8821, 947.5552, 24.4421, 270.0000 ,-1,-1,BIZ_SFRENT4,"Аренда SF"},
	{INVALID_PLAYER_ID,409, -1750.7251, 947.5801, 24.4421, 270.0000 ,-1,-1,BIZ_SFRENT4,"Аренда SF"},
	{INVALID_PLAYER_ID,409, -1740.4351, 955.3890, 24.4421, 258.6977 ,-1,-1,BIZ_SFRENT4,"Аренда SF"},
    {INVALID_PLAYER_ID,578, 1765.3618,379.2322,20.2233,266.5466 ,-1,-1,INVALID_BIZ,""},
	{INVALID_PLAYER_ID,578, 1789.7762,376.6861,19.9031,261.6607 ,-1,-1,INVALID_BIZ,""},
	{INVALID_PLAYER_ID,578, 1806.8800,373.7940,19.7075,258.9347 ,-1,-1,INVALID_BIZ,""},
	{INVALID_PLAYER_ID,578, 1827.7592,367.7990,19.7697,251.5285 ,-1,-1,INVALID_BIZ,""},
	{INVALID_PLAYER_ID,578, 1845.0853,361.7074,20.1778,250.6660 ,-1,-1,INVALID_BIZ,""},
	{INVALID_PLAYER_ID,578, 1865.4243,355.6510,20.6987,254.8752 ,-1,-1,INVALID_BIZ,""}
};
new Float:FishZone[15][3] =
{
	{349.8644,-2052.0598,7.8359},
	{349.9288,-2059.7078,7.8359},
	{349.9258,-2064.8701,7.8359},
	{349.9335,-2067.3757,7.8359},
	{349.9633,-2072.5100,7.8359},
	{354.5819,-2088.6687,7.8359},
	{362.2255,-2088.7966,7.8359},
	{367.2188,-2088.7983,7.8359},
	{369.7726,-2088.7871,7.8359},
	{375.0870,-2088.7959,7.8359},
	{383.4317,-2088.7952,7.8359},
	{391.2613,-2088.7966,7.8359},
	{396.0679,-2088.7976,7.8359},
	{398.6076,-2088.7954,7.8359},
	{403.9636,-2088.7976,7.8359}
};
new FishName[14][22] =
{
	"None",
	"Корешка",
	"Навага",
	"Сельдь",
	"Карп",
	"Окунь",
	"Тунец",
	"Камбала",
	"Кета",
	"Горбуша",
	"Красноперка",
	"Судак",
	"Щука",
	"Лещ"
};
new FishCost[14] =
{
	0, //None
	150, //Корешка
	50, //Навага
	150, //Сельдь
	200, //Карп
	200, //Окунь
	300, //Тунец
	80, //Камбала
	90, //Кета
	80, //Горбуша
	150, //Красноперка
	150, //Судак
	150, //Щука
	90  //Лещ
};
enum psInfo
{
	psSeria,
	psNumber,
	psSex,
	psDate[3],
	psDateBirth[3],
	psCity,
}
new PassInfo[MAX_PLAYERS][psInfo];
enum mcInfo
{
	mcState,
	mcDate[3],
	mcGiver[24]
}
new MedCardInfo[MAX_PLAYERS][mcInfo];
new JailCP[5];
new GetPizza;
new MinerDownCP;
new PorterDownCP;
new HouseNalog[MAX_PLAYERS] = {-1,...};
new HouseNalogState2[MAX_PLAYERS] = {0,...};
new MinerCP[4];
new FerumPickup[6];
new FerumCP[16];
new FerumEndCP;
new BankCP[4];
new IncCP[INC_CPs][2];

new PizzCP[Pizza_CPs][2];

new NumberColors[15][24] =
{
	"{9C5353}",
	"{AA3333}",
	"{9EF2FF}",
	"{FF9900}",
	"{A52A2A}",
	"{9ACD32}",
	"{33CCFF}",
	"{9ACD32}",
	"{FFFF00}",
	"{B8CEF6}",
	"{6053F3}",
	"{BFC0C2}",
	"{C2A2DA}",
	"{10F441}",
	"{400080}"
};

new HouseRooms[37] = { 0, 1, 1, 4, 1, 5, 2, 4, 1, 1, 2, 0, 1, 0, 0, 2, 4 ,2,3,3,5,2,2,1,2,5,3,4,4,4,4,4,4,4,4,4,4};
new TeamColors[30]=
{
	0xFFFFFF80, //None
	0x0049FF80, //LSPD
	0x0049FF80, //LVPD
	0x0049FF80, //FBI
	0x004eff80, //SWAT
	0xFF7E7E80, //Medic
	0xCCFF0080, //Meria LS
	0x99663380, //ARMY LV
	0xFF7E7E80, //Meria LV
	0xFF663380, //Licensers
	0xFF800080, //Radio
	0x00932799, //Groove Street
	0xD1DB1C99, //LS Vagos
	0xcc00cc99, //Ballas
	0x00FFE299, //El Coronos
	0x6666FF99, //SF Rifa
	0x33669980, //Russian Mafia
	0x96020280, //Yakuza Mafia
	0x99336680, //La Cosa Nostra
	0xBA541D80, //Bikers
	0x99663380, //army
	0x298CB780, //bank
	0xFF7E7E80, //hospital lv
	0x0049FF80, //LVPD
	0xFF800080, //cnn lv
	0x7F646480,
	0xFF800080, //cnn SF
	0x99663380, //cnn SF
	0x99663380, //army
	0x99663380 //Тюрьма строгого режима
};
enum specInfo
{
	specInt,
	specWorld,
	specGun[13],
	specAmmo[13],
Float:specHealth,
Float:specArmour,
bool:specSpectating
}
new SpecInfo[MAX_PLAYERS][specInfo];
new WeaponNames[48][40] =
{
	"Unarmed (Fist)", // 0
	{"Brass Knuckles"}, // 1
	{"Golf Club"}, // 2
	{"Night Stick"}, // 3
	{"Knife"}, // 4
	{"Baseball Bat"}, // 5
	{"Shovel"}, // 6
	{"Pool Cue"}, // 7
	{"Katana"}, // 8
	{"Chainsaw"}, // 9
	{"Purple Dildo"}, // 10
	{"Big White Vibrator"}, // 11
	{"Medium White Vibrator"}, // 12
	{"Small White Vibrator"}, // 13
	{"Flowers"}, // 14
	{"Cane"}, // 15
	{"Grenade"}, // 16
	{"Teargas"}, // 17
	{"Molotov"}, // 18
	{" "}, // 19
	{" "}, // 20
	{" "}, // 21
	{"Pistols"}, // 22
	{"Desert Eagle (Silencer)"}, // 23
	{"Desert Eagle"}, // 24
	{"Shotgun"}, // 25
	{"Sawnoff Shotgun"}, // 26
	{"Combat Shotgun"}, // 27
	{"Micro Uzi (Mac 10)"}, // 28
	{"MP5"}, // 29
	{"AK47"}, // 30
	{"M4"}, // 31
	{"Tec9"}, // 32
	{"Country Rifle"}, // 33
	{"Sniper Rifle"}, // 34
	{"Rocket Launcher"}, // 35
	{"Auto Rocket Launcher"}, // 36
	{"Flamethrower"}, // 37
	{"Minigun"}, // 38
	{"Satchel Charge"}, // 39
	{"Detonator"}, // 40
	{"Spray Can"}, // 41
	{"Fire Extinguisher"}, // 42
	{"Camera"}, // 43
	{"Night Vision Goggles"}, // 44
	{"Infrared Vision Goggles"}, // 45
	{"Parachute"}, // 46
	{"Fake Pistol"} // 47
};
enum dInfo
{
	dDialog,
	dQuestion[500],
	dAnswers[300],
	dSuccesQwe
}
new QueInfo[4][dInfo] =
{
	{2,"Максимальная скорость в городе:",		"40 Км/ч\n60 Км/ч\n80 Км/ч\n100 Км/ч",1},
	{2,"Максимальная скорость вне города:		","100 Км/ч\n120 Км/ч\n150 Км/ч\nБез ограничений",1},
	{2,"Разрешена ли парковка на тротуаре?",	"Всегда да\nЕсли админ разрешит\nТолько в экстренных ситуациях\nВсегда нет",2},
	{2,"Что нужно делать при тумане?",		 	"Снизить скорость и включить фары\nЕхать как можно быстрее\nВыйти из авто и идти пешком\nЕхать и материться",0}
};
new QueFInfo[7][dInfo] =
{
	{2,"Можно ли садиться на зданиях?",  "Да\nНет\nВ особых местах\nВ любых местах",2},
	{2,"Разрешено ли буксировать другие транспортные средства?", "Да\nНет\nДа если ваша масса больше его\nБез ограничений",1},
	{2,"Какая дистанция должна быть между двумя летящими вертолётам/самолетами?", "2 метра\n10 метров\nКак можно ближе друг к другу\nНеобходимая для безопасного пролета",3},
	{2,"Полет между зданиями",    "Разрешён\nЗапрещен\nРазрешен при необходимости\nТолько так и надо летать",1},
	{2,"Летать разрешено",    "Везде\nТолько над водоемами\nТолько над сушей\nЗа исключением военных объектов",3},
	{2,"Покидать кабину летательного аппарата разрешено",    "После остановки двигателя\nНа лету\nКогда самолет перевернут\nНеисправен или двигатель остановлен",0},
	{2,"Перед взлетом необходимо проверить", "Стоимость реактивного топлива\nУровень реактивного топлива\nБезопастность взлета\nВсе пассажиры взяли с собой горшки",1}
};
new OrgSalary[29][14] =
{
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //None
	{4500,5000,5500,6000,6500,7000,8000,8500,9000,19000,20500,11000,19000,19000}, //Police LS
	{4050,5000,5500,6000,6050,7000,8000,8500,9000,19000,20500,11000,11050,19000}, //Police LS
	{6500,7000,7500,8000,8500,9000,9500,10000,10500,19000,21500,12000,12050,20000}, //CIA
	{4500,5000,5500,6000,6500,7000,8000,8500,9000,18000,20500,11000,19000,19000}, //S.W.A.T
	{4500,5000,5500,6000,6500,7000,7500,8000,8500,15000,20500,10000,10500,18000}, //Medic
	{6000,7000,8000,8500,9000,9500,10000,10500,11000,16500,22000,12500,13000,18500}, //Meria LS
	{2000,3000,4000,5000,6000,6500,6000,7000,7500,14000,20000,10200,10600,18000}, //Meria SF
	{4500,5000,5500,6000,6500,7000,7500,8000,8500,15000,20500,10000,10500,18000}, //medic sf
	{3800,4000,4200,4300,4500,4700,5000,5300,5600,13900,20100,6400,6700,15000}, //Licensers
	{4900,5100,5500,6100,6500,6900,7300,7600,8000,12400,20800,9200,9600,18000}, //Radio
	{276,276,276,276,276,276,276,276,276,276,276,276,276,2760}, //Groove
	{276,276,276,276,276,276,276,276,276,276,276,276,276,2760}, //Vagos
	{276,276,276,276,276,276,276,276,276,276,276,276,276,2760}, //Ballas
	{276,276,276,276,276,276,276,276,276,276,276,276,276,2760}, //Coronos
	{276,276,276,276,276,276,276,276,276,276,276,276,276,2760}, //Rifa
	{4800,4900,5000,6000,6500,7000,8000,8500,9000,15500,20000,10500,10000,18000}, //Russian Mafia
	{4800,4900,5000,6000,6500,7000,8000,8050,9000,15500,20000,10500,10000,18000}, //Yakuza
	{4800,4900,5000,6000,6500,7000,8000,8500,9000,15500,20000,10500,10000,18000}, //LCN
	{4800,4900,5000,6000,6500,7000,8000,8500,9000,15500,20000,10500,10000,18000}, //Bikers
	{2000,3000,4000,5000,6000,6500,6000,7000,7500,13000,20000,10200,10600,18000}, //army
	{5500,5800,5900,6000,6200,6500,6700,7000,8000,16000,21000,12000,12800,21000}, //bank
	{4500,5000,5500,6000,6500,7000,7500,8000,8500,14000,20500,10000,10500,18000},
	{4500,5000,5500,6000,6500,7000,8000,8500,9000,15000,20500,11000,19000,19000},
	{4900,5100,5500,6100,6500,6900,7300,7600,8000,14400,20800,9200,9600,15000},
	{276,276,276,276,276,276,276,276,276,276,276,276,276,2760},
	{4900,5100,5500,6100,6500,6900,7300,7600,8000,13400,20800,9200,9600,15000}, //RadioSF
	{2000,3000,4000,5000,6000,6500,6000,7000,7500,15000,20000,10200,10600,19000}, //army
	{2000,3000,4000,5000,6000,6500,6000,7000,7500,15000,20000,10200,10600,19000} //Тюрьма строгого режима
};
new DonateText[0][2000] =
{
	""
};
new MOrgSkins[][] =
{
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},//None
	{71,266,284,267,267,265,282,282,311,17,295},//Police LS
	{71,266,284,267,267,265,282,282,288,283,283,0},//Police rcpd
	{286,286,286,286,163,163,163,165,165,165,166,166},//FBI
	{71,266,284,267,267,265,282,282,311,17,295,0},//Police SF
	{274,274,276,276,276,275,275,275,275, 70,70,0},//M4C
	{164,164, 164,163, 163,187,187,57,57,147,147,0},//Meria LS
	{287,287,287,179,179,253,253,61,61,255,255,0},//Army лв
	{274,274,274,274,274,275,275,275,275, 70,70,0},//M
	{59,59,59,59, 59, 59, 59, 59,59,240,240,0},//Licensers
	{188,188,188,188,250,250,250,250,250,261,261,0}, //Radio
	{105,105,105,105,106,106,106,107,269,271,270,270,270,270},//Groove Street
	{108,108,108,108,108,108,109,109,109,110,110,110,110,110},//LS Vagos
	{103,103,103,103,103,103,102,102,102,104,104,104,104,104},//Ballas
	{114,114,114,114,116,116,116,116,115,292,292,115,115},//El'Coronos
	{175,175,175,175,174,174,174,174,173,173,273,273,173,173},//SF Rifa
	{112,112,112,112,111,111,111,46,46,125,125,125, 125, 126},//Русская Мафия
	{122,122,122,208,208,123,123,123,186,186,118,118,228,228},//Yakuza
	{124,124,124,98,98,127,127,223,223,113,113,113,113,113},//LCN Male
	{181,242,241,181,181,248,248,248,248,247,247,110,110,100},//Bikers
	{287,287,287,179,179,253,253,61,61,255,255,0},//Army
	{164,171, 164,163, 171,166,153,118,153,227,227,0},//BANK
	{274,274,274,274,274,275,275,275,275, 70,70,0},//MEDIC LV
	{71,266,284,267,267,265,282,282,311,17,295,0},//Police LV
	{188,188,188,188,250,250,250,250,250,261,261,0}, //Radio lv
	{21,21,21,21,28,28,28,293,293,297,297,0}, //Wolfs
	{188,188,188,188,250,250,250,250,250,261,261,0}, //Radio
	{287,287,287,179,179,253,253,61,61,255,255,0},//Army sf
	{287,287,287,179,179,253,253,61,61,255,255,0}//Тюрьма строгого режима
};
new GOrgSkins[][] =
{
	{  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0},//None
	{76,306,306,306,307,307,307,309,309,76,76,76,76,76},//Police LS
	{76,306,306,306,307,307,307,309,309,76,76,76,76,76},//Police LV
	{141,141,141,141,141,141,141,141,141,141,141,141,141,141},//F.B.I
	{76,306,306,306,307,307,307,309,309,76,76,76,76,76},//Police SF
	{219,308,308,308,308,308,150,150,150,150,150,219,219,219},//M4C
	{150,150,150,150,150,150,150,150,150,150,150,150,150,150},//Meria LS
	{191,191,191,191,191,191,191,191,191,191,191,191,191,191},//Army
	{219,308,308,308,308,308,219,219,219,219,219,219,219,219},//M4C SF
	{150,11,11,11,11,11,172,172,172,172,172,150,150,150},//Licensers
	{211,211,211,211,211,211,211,211,211,211,211,211,211,211}, //Radio
	{65,65,65,65,65,65,207,207,207,207,207,207,298,298},//Groove Street
	{190,190,190,190,190,190,190,190,190,190,190,190,190,190},//LS Vagos
	{195,195,195,195,195,195,195,195,195,195,195,195,195,195},//Ballas
	{41,193,193,193,193,193,193,193,193,193,193,41,41,41},//El'Coronos
	{226,226,226,226,226,226,226,226,226,226,226,226,226,226},//SF Rifa
	{214,233,233,233,233,233,214,214,214,214,214,214,214,214},//Русская Мафия Female
	{169,169,169,169,169,169, 169, 169, 169,169,169,169,169,169},//Yakuza
	{91,91,91,91,91,91,91,91,91,91,91,91,91,91},//LCN Female
	{233,233,233,233,233,233,233,233,233,233,233,233,233,233},//Bikers
	{191,191,191,191,191,191,191,191,191,191,191,191,191,191},//Army
	{141,141,141,141,141,141,141,141,141,141,141,141,141,141},//BANK
	{219,308,308,308,308,308,219,219,219,219,219,219,219,219},//M4C LV
	{76,306,306,306,307,307,307,309,309,76,76,76,76,76},    //Police LV
	{211,211,211,211,211,211,211,211,211,211,211,211,211,211}, //Radio lv
	{56,56,56,56,56,56,56,56,56,56,56,56,56,56}, //wolfs
	{211,211,211,211,211,211,211,211,211,211,211,211,211,211}, //Radio lv
	{191,191,191,191,191,191,191,191,191,191,191,191,191,191},//Army sf
	{191,191,191,191,191,191,191,191,191,191,191,191,191,191}//Тюрьма строгого режима
};



new ItemsId[][] =
{
	{ 19421,19422,19423,19424,1}, //Наушники
	{ 19069,19068,19067,19554,18953,18954,1},//Шапки
	{ 18968,18967,18969,1},//Панамки
	{ 18955,18956,18957,18959,18926,18927,18928,18929,18930,18931,18932,18933,1},//Кепки
	{ 19104,19105,19106,19107,19108,19109,1},//Каски
	{ 18925,18922,18923,18924,18921,1},//Береты
	{ 19519,19274,1},//Парики
	{ 19011,19012,19013,19014,19015,19016,19017,19018,19019,19024,19027,19028,19029,19022,19035,19031,19032,19033,1},//Очки
	{ 18911,18912,18913,18914,18915,18916,18917,18918,18919,18920,1 }, //Банданы
	{ 18947,18948,18949,18950,18951,1 }, //Шляпы
	{ 19042,19041,19040,19039,19043,19044,19045,19046,19048,19049,19050,19051,19053,1 }, //Часы
	{ 3026,371,19559,1 },//портфели
	{ 18970, 18973, 18972, 18971,1 },//Шляпы
	{ 18910, 18909, 18908, 18907, 18906,1 }// Банданы на голову
};
new ItemsIdInv[][] =
{
	{ 424,425,426,427,1}, //Наушники
	{ 428,429,430,431,432,433,1},//Шапки
	{ 434,435,436,1},//Панамки
	{ 437,438,439, 440,441,442,443,444,445,446,447,448,1},//Кепки
	{ 449,450,451,452,453,454,1},//Каски
	{ 455,456,457,458,459,1},//Береты
	{ 460,461,1},//Парики
	{ 462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,1},//Очки
	{ 480,481,482,483,484,485,486,487,488,489,1 }, //Банданы
	{ 490,491,492,493,494,1 }, //Шляпы
	{ 495,496,497,498,499,500,501,502,503,504,505,506,507,1 }, //Часы
	{ 508,509,510,1 },//портфели
	{ 511, 512, 513, 514,1 },//Шляпы
	{ 515, 516, 517, 518, 519,1 }// Банданы на голову
};
new ItemsCost[][] =
{
	{ 3000,3000,3000,3000,1}, //Наушники
	{ 2500,2500,4000,6000,3000,3000,1},//Шапки
	{ 1500,1500,1500,1},//Панамки
	{ 1000,1000,1000,2000,2000,1500,4000,4000,3000,2500,2500,4000,1},//Кепки
	{ 2500,2500,3000,3000,3000,3000,1},//Каски
	{ 2000,2200,2200,2500,3000,1},//Береты
	{ 3000,3000,1},//Парики
	{ 500,2000,500,700,1200,1800,2800,2800,2800,3000,3000,3000,3000,3000,2000,2100,2100,4000,1},//Очки
	{ 2000,1000,1000,1700,1700,1700,1300,1000,1000,1700,1 }, //Банданы
	{ 2100,2100,2100,2100,2100,1 }, //Шляпы
	{ 40000,30000,45000,50000,60000,4000,4000,4000,5000,5500,5000,5200,5400,1 }, //Часы
	{1000,800,1200,1},//портфели
	{3400,3200,3500,3300,1},//шляпы
	{2000,2000,2000,2000,2000,1}//Банданы
};

new MSkins[][] =
{
	{ 1,   78,135,137,2,3,50,29,  37,  44,58, 68,  72,167,  73,  96,  97, 101, 119,153, 184, 206, 235, 236,20,242, 252, 258,98, 289, 290, 291, 294,299},
	{14, 79,134, 136,15,4,5,  19,21,22,143,67,  24,  25,  28,  36,	83,  84, 128, 156,182,144,183, 220, 221, 222, 241,18,262,180,293, 292, 297,296}
};
new GSkins[][] =
{
	{91,90, 93,150,138, 216, 226,56,55,225,233},
	{9, 11, 12, 40, 76, 190,215, 192,298,211,214}
};
new MSkinCost[] =
{
	2000,2000,2000,2000,2000,4000,2000,4000,4000,4000,
	4000,6000,6000,7000,7000,7000,10000,
	13000,14000,20000,20000,20000,20000,21000,
	50000,75000,76000,77000,150000,250000,100000,
	100000,450000,500000,

	2000,2000,2000,2000,2000,4000,4000,4000,4000,4000,6000,6000,6000,
	6000,7000,7000,25000,25000,15000,15000,
	15000,25000,25000,20000,50000,60000,61000,80000,
	20000,25000,150000,150000,200000,450000
};
new GSkinCost[] =
{
	2000,2000,5000,7000,10000,10000,
	10000,10000,20000,100000,200000,
	2000,2000,2000,5000,7000,
	25000,50000,70000,100000,350000,500000
};
new MBomzSkins[][] =
{
	{78, 135, 137, 200, 213, 230},
	{79, 136, 134, 35, 4 , 5}
};
new GBomzSkins[][] =
{
	{41, 77, 226},
	{13, 245, 214}
};
enum fillinfo
{
Float:fPos_X,
Float:fPos_Y,
Float:fPos_Z,
	fBizzID
}
new Text3D:FuelText[23] = { NONE_3D_TEXT, ... }; //Изменить при увеличивании заправок!!!
new FuelInfo[31][fillinfo] =
{
	{1007.7967,-939.0165,42.1797,BIZ_GAS_LS_1},
	{1000.0021,-939.7214,42.1797,BIZ_GAS_LS_1},
	{1943.9103,-1778.4739,13.3906,BIZ_GAS_LS_2},
	{1944.1837,-1774.2662,13.3906,BIZ_GAS_LS_2},
	{1944.1002,-1771.2139,13.3900,BIZ_GAS_LS_2},
	{1944.1849,-1767.2201,13.3828,BIZ_GAS_LS_2},
	{296.1086,-171.5746,1.5781,BIZ_GAS_LV_2},
	{296.0072,-181.3552,1.5781,BIZ_GAS_LV_2},
	{300.9220,-181.4067,1.5781,BIZ_GAS_LV_2},
	{300.3612,-171.8585,1.5781,BIZ_GAS_LV_2},
	{653.0966,-559.7371,16.3359,BIZ_GAS_LV_4},
	{653.5595,-570.3958,16.3359,BIZ_GAS_LV_4},
	{612.1537,-1510.7721,14.9320,BIZ_GAS_LV_5},
	{1379.0016,459.1470,19.9564,BIZ_GAS_LV_6},
	{1383.4531,456.9103,19.9467,BIZ_GAS_LV_6},
	{1385.5155,461.5921,20.1510,BIZ_GAS_LV_6},
	{1380.5353,463.0790,20.1233,BIZ_GAS_LV_6},
	{2205.3462,2476.8647,10.4015,BIZ_AZS1},
	{1594.2661,2202.1384,10.4015,BIZ_AZS2},
	{609.9623,1700.6389,6.5774,BIZ_AZS3},
	{2147.2593,2750.6055,10.4014,BIZ_AZS4},
	{-1329.8168,2672.0408,49.6437,BIZ_AZS5},
	{-1470.7079,1863.8987,32.6328,BIZ_AZS6},
	{-98.7537,-1166.8053,2.5993,21},
	{22.4816,-2646.1042,40.4618,27},
	{-1606.3723,-2713.6147,48.5335,22},
	{-2249.9185,-2558.6838,31.8938,25},
	{-1666.6174,408.5915,7.1797,26},
	{-2022.0974,155.9591,28.8359,23},
	{-2261.1799,-2.6144,35.1719,29},
	{-2405.7432,974.6953,45.2969,24}

};
enum oInfo
{
	oID,
	oName[32],
	oLeader[24],
	oBank,
	oDrugs,
	oMats,
	oArmour,
	oHealth,
	Max_Rang,
	oOb4ak,
	oBenz,
	oRemont,
	oMask
}
new OrgInfo[MAX_ORGS][oInfo];
new Dorm_CP[MAX_ORGS] = {-1, ...};
new Text3D:DormText[MAX_ORGS] = {NONE_3D_TEXT, ...};
new Float:DormPos[28][3] =
{
	{0.0,0.0,0.0}, //None
	{0.0,0.0,0.0}, //LSPD
	{0.0,0.0,0.0}, //LVPD
	{0.0,0.0,0.0}, //CIA
	{0.0,0.0,0.0}, //SWAT
	{0.0,0.0,0.0}, //Medik
	{0.0,0.0,0.0}, //MeriaLS
	{0.0,0.0,0.0}, //MeriaSF
	{0.0,0.0,0.0}, //MeriaLV
	{0.0,0.0,0.0}, //Licensers
	{0.0,0.0,0.0}, //Radio
	{-590.6627,2405.5029,1504.7708}, //Groove St.
	{-436.2081,2416.2742,1500.9688}, //LS Vagos
	{-740.2837,2418.7090,1500.9701}, //Ballas
	{-708.2415,2246.5249,1500.9745}, //Coronos
	{-566.5764,2247.3467,1500.9688}, //Rifa
	{-1998.0773,1106.9282,1018.6735}, //RM общак 3д надпись
	{-1926.8988,902.4935,1402.0776}, //Yakuza общак 3д надпись
	{-1501.9073,1988.5773,1357.0447}, //LCN Общак
	{779.2252,2512.1433,1502.0000}, //байкеры Общак
	{0.0,0.0,0.0}, //army
	{0.0,0.0,0.0}, //BANK
	{0.0,0.0,0.0}, //BANK
	{0.0,0.0,0.0}, //BANK
	{0.0,0.0,0.0}, //BANK
	{-600.9774,112.7499,1504.5430}, //wolfs
	{0.0,0.0,0.0}, //sf
	{0.0,0.0,0.0} //Тюрьма строгого режима
};
enum gzInfo
{
	gzFracID,
Float:gzMin_X,
Float:gzMin_Y,
Float:gzMax_X,
Float:gzMax_Y
};
new GZInfo[101][gzInfo];
new GangZone[101];
enum pHacksOFF
{
	SPEED_HACK,
	MONEY_HACK,
	VEH_ROOT_HACK,
	HEALTH_HACK,
	ARMOUR_HACK,
	CAR_HEALTH_HACK
}
new AntiCheatOFF[MAX_PLAYERS][pHacksOFF];
new Float:Bankomats[51][4] =
{
	{1491.64, -1279.95, 14.27,90.00},
	{ 1641.49, -1172.26, 23.59, 270.00},
	{2250.82, -1667.82, 15.13,255.48},
	{461.87, -1512.79, 30.63,1.38},
	{2820.09, -1468.37, 15.97, 90.00},
	{-107.03, -305.86, 1.13, 180.00},
	{-1823.97, 1284.36, 16.03,110.70},
	{1918.69, -1766.31, 13.25,-90.00},
	{1364.10, -1751.19, 13.25, 0.00},
	{1225.59, -1811.40, 16.25,90.00},
	{1147.24, -1773.07, 16.25,-90.00},
	{1232.28, -1415.86, 13.11,-90.00},
	{1367.62, -1290.17, 13.11,0.00},
	{753.93, -1384.86, 13.37,89.32},
	{1650.38, -1655.55, 22.19,90.50},
	{1949.18, -1986.50, 13.43,180.73},
	{2423.85, -1906.82, 13.22,359.22},
	{2253.93, -1758.64, 13.30,269.85},
	{2338.07, -1758.84, -13.30,269.85},//
	{669.08, -577.52, 16.18,89.33},
	{ 2733.04, -2458.37, 13.41,179.86},
	{ -68.99, 1209.25, 19.61,90.00},
	{ 652.04, 1705.81, 6.99,41.29},
	{ 1154.41, 1363.19, 10.63,270.00},
	{ 1626.66, 1814.01, 10.53,270.00},
	{ 2018.83, 1005.11, 10.53,180.00},
	{ 2239.50, 1282.36, 10.63,360.00},
	{ 2197.74, 1395.31, 11.02,90.00},
	{ 2093.95, 1450.54, 10.48, 134.65},
	{ 2185.11, 1660.57, 10.76,285.21},
	{ 2257.25, 1804.71, 10.63,359.10},
	{ 2332.84, 2171.95, 10.60,180.00},
	{ 2619.40, 2345.90, 10.52,111.19},
	{ 2889.23, 2459.36, 10.89,134.97},
	{ 2597.39, 1086.47, 10.65,180.00},
	{ 2283.26, 2432.83, 10.62,90.00},
	{ 2479.92, 2520.86, 10.61,180.00},
	{ 2098.86, 2484.50, 10.90,89.78},
	{1177.1570, -610.8480, 1104.8850},
	{-2674.95, 635.06, 14.30,90.0},
	{-2276.68, 535.11, 34.98,180.0},
	{-2186.82, 330.27, 35.09,90.0},
	{-2241.62, 83.38, 35.26,360.0},
	{-2034.73, -60.15, 35.11,90.0},
	{-2020.87, 128.47, 28.31,180.0},
	{-2017.89, 450.44, 35.05,180.0},
	{-1624.12, 716.50, 14.5,270.0},
	{-1712.51, 1349.73, 6.88,47.0},
	{-2765.62, 372.16, 6.00,180.0},
	{-2629.31, 1407.91, 6.85,159.0},
	{1131.687622, -1473.322998, 15.690900, 270.0}
};

new Float:FerumCPPos[16][4] =
{
	{2558.4739,-1295.8499,1044.1250,0.0},
	{2556.1707,-1295.8499,1044.1250,0.0},
	{2553.7725,-1295.8497,1044.1250,0.0},
	{2544.3621,-1295.8524,1044.1250,0.0},
	{2542.0627,-1295.8502,1044.1250,0.0},
	{2542.0247,-1291.0040,1044.1250,180.0},
	{2544.2896,-1291.0055,1044.1250,180.0},
	{2553.8286,-1291.0051,1044.1250,180.0},
	{2556.1653,-1291.0057,1044.1250,180.0},
	{2558.4722,-1291.0055,1044.1250,180.0},
	{2560.0459,-1284.6926,1044.1250,90.0},
	{2560.0452,-1282.7565,1044.1250,90.0},
	{2552.0383,-1282.8169,1044.1250,90.0},
	{2552.0391,-1284.8226,1044.1250,90.0},
	{2544.0613,-1282.7789,1044.1250,90.0},
	{2544.0613,-1284.7793,1044.1250,90.0}
};
new Float:FerumPickupPos[6][3] =
{
	{2559.1011,-1299.8197,1044.1250},
	{2551.1067,-1299.7057,1044.1250},
	{2543.0305,-1299.8914,1044.1250},
	{2543.1702,-1287.7507,1044.1250},
	{2551.1094,-1287.7623,1044.1250},
	{2559.1382,-1287.6731,1044.1250}
};
enum lInfo
{
	lTime
}
new onlineinfo[MAX_PLAYERS][lInfo];
enum cInfo
{
	cID,
	cModel,
Float:cSell_X,
Float:cSell_Y,
Float:cSell_Z,
Float:cSell_A,
Float:cPos_X,
Float:cPos_Y,
Float:cPos_Z,
Float:cPos_A,
	cInterior,
	cVirtualWorld,
	cColor_1,
	cColor_2,
	cOwner[24],
	cShtrafer,
	cLaunch,
	cNumber[30],
	cKeyer[24],
	cLock,
	cCost,
	cNeon,
	cShtraf,
	cAlarmON,
	cKeyIN,
Float:cMilage,
Float:cHealth,
	cOnNumber[10],
	cRegister[24],
	cOnRegister[24],
	cNumberColor,
	cParkedInGarage,
	cStatus,
	cTwinTurbo,
	Supreme,
	Launch,
	AddCar,
	Halloween,
	Newyear
};
enum bcInfo
{
	bcID,
	bcModel,
	bcBuyCars,
	bcSpawnCar,
	Float:bcPos_X[20],
	Float:bcPos_Y[20],
	Float:bcPos_Z[20],
	Float:bcPos_A[20],
	bcName[24]
}
new SalonCars[MAX_SALON_OWNABLECARS][bcInfo];
enum chetinfo
{
	cheatid1
}
new Float:ChetInfo[15][chetinfo];


enum griba
{
Float:gribPos[3],
	gribCreat
}
new Float:GribInfo[91][griba] =
{
	{{702.8815,-705.6253,18.1862},-1},
	{{629.6369,-626.4828,16.8087},-1},
	{{552.2899,-710.6613,15.6666},-1},
	{{549.5466,-726.0712,16.4740},-1},
	{{498.2195,-679.3785,19.3385 },-1},
	{{435.9091,-699.4714,24.1253 },-1},
	{{410.0149,-693.8445,25.3369 },-1},
	{{423.6373,-632.5778,31.2596 },-1},
	{{383.9173,-598.8234,38.6380 },-1},
	{{365.3120,-605.5251,37.1760 },-1},
	{{389.1755,-564.6368,42.2504 },-1},
	{{396.1581,-548.8250,41.7694 },-1},
	{{411.8608,-449.7965,29.2956 },-1},
	{{424.7657,-430.9502,28.3068 },-1},
	{{441.9207,-381.7615,31.4900 },-1},
	{{439.1675,-350.8515,32.7176 },-1},
	{{271.2307,-263.2632,1.5781 },-1},
	{{108.2987,-136.0934,1.5781 },-1},
	{{175.8603,49.5331,2.3979 },-1},
	{{493.5621,97.1763,27.7191 },-1},
	{{547.1754,173.4039,27.1073 },-1},
	{{708.5907,307.0195,20.2344 },-1},
	{{743.8032,331.7983,20.3124 },-1},
	{{942.9208,409.0231,20.2344 },-1},
	{{1233.2169,536.8552,20.2344 },-1},
	{{1330.6167,494.6686,20.2184 },-1},
	{{1491.0624,324.2256,18.8417 },-1},
	{{1485.3533,273.8969,18.9174 },-1},
	{{1429.8097,164.6635,21.9831 },-1},
	{{1265.4169,-133.5778,39.7847 },-1},
	{{-372.7117,-89.7796,46.0523 },-1},
	{{-462.4359,-204.0353,77.9991 },-1},
	{{-554.9720,-221.0948,76.3361 },-1},
	{{921.3636,-479.7340,44.0374 },-1},
	{{890.4687,-494.8910,36.9549 },-1},
	{{878.1802,-483.0581,35.4741 },-1},
	{{1983.4618,89.3856,29.4775 },-1},
	{{2210.0349,146.4971,26.1758 },-1},
	{{-332.3008,-1987.6200,26.1051 },-1},
	{{-375.2895,-2004.4412,28.4262 },-1},
	{{-420.7345,-1962.1367,20.7989 },-1},
	{{-370.9467,-2049.1355,28.5462 },-1},
	{{-448.5980,-2072.9041,80.6654 },-1},
	{{-490.3048,-2121.0930,89.5054 },-1},
	{{-515.2039,-2223.6245,42.7538 },-1},
	{{-556.2787,-2223.5444,34.8664},-1},
	{{-653.4810,-2185.8540,14.6571 },-1},
	{{-697.4235,-2144.5728,24.7645 },-1},
	{{-913.5545,-2281.5803,45.6804 },-1},
	{{-924.2963,-2392.5601,63.9710 },-1},
	{{-921.2469,-2419.2676,73.1529 },-1},
	{{-928.6000,-2452.7974,90.8816 },-1},
	{{-1092.1782,-2576.2622,77.2730 },-1},
	{{-1114.4218,-2326.8787,44.7146 },-1},
	{{-1095.8896,-2317.7642,51.1427 },-1},
	{{-1036.0745,-2331.6079,60.0633 },-1},
	{{-1823.0471,-2169.1082,77.6051 },-1},
	{{-1745.4077,-2018.1677,74.5071 },-1},
	{{-1943.8130,-2144.5457,76.9309 },-1},
	{{-1955.9766,-2162.8020,75.9688 },-1},
	{{-1685.1254,-2385.9275,99.3290 },-1},
	{{-1643.7135,-2411.9897,95.7691 },-1},
	{{-1551.1573,-2505.1743,90.8708 },-1},
	{{-1465.4910,-2556.2893,63.7663 },-1},
	{{-1435.4855,-2544.3879,60.4281 },-1},
	{{-1401.0656,-2548.1582,55.9067 },-1},
	{{-1347.5752,-2507.9780,37.0068 },-1},
