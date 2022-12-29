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
