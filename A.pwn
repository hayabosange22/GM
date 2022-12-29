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
