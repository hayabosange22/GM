/*															AAAAAAAAAAAAA   RRRRRRRRRRRRR   I
															A           A   R           R   I
															A           A   R           R   I
															A           A   R           R   I
															AAAAAAAAAAAAA   RRRRRRRRRRRRR   I
															A           A   R    R          I
															A           A   R      R        I
															A           A   R        R      I
															A           A   R           R   I

												W               W   I   W               W   I   NNNNNNNNN       N
												W               W   I   W               W   I   N       N       N
												W               W   I   W               W   I   N       N       N
												W               W   I   W               W   I   N       N       N
												W               W   I   W               W   I   N       N       N
												W       W       W   I   W       W       W   I   N       N       N
												W       W       W   I   W       W       W   I   N       N       N
												W       W       W   I   W       W       W   I   N       N       N
												WWWWWWWWWWWWWWWWW   I   WWWWWWWWWWWWWWWWW   I   N       NNNNNNNNN

																	#####      	#       #
																		#       #       #
																	 	#       #       #
																	 	#       #########
																	 	#               #
																	 	#               #
																	#########           #
																	
											"CODING ITU BISA DI COPYPASTE TETAPI IDE TIDAK AKAN BISA." - Christian "Tianmetal" Malik.
Gamemode Author   	: Dhenxdy

Terimakasih kepada	:
					- Allah SWT (My God)
					- Families and Friends
					- AND YOU (FOR REQUEST IG AND SUGGESTION)
*/
#include <a_samp>
//#include <nex-ac>
#include <a_zones>
#include <sscanf2>
#include <streamer>
#include <YSI\y_ini>
#include <YSI\y_timers>
#include <audio>
#include <Ari_Pradana>//ACBS
#include <blood>
#include <BUD>
#include <BustAim>
#include <Dini>
#include <djson>
#include <foreach>//foreach
#include <geolocation>
#include <mSelection>
#include <shoot>
#include <OPA>
#include <OPSP>
#include <progress>
#include <zcmd>//zcmd
#include <yom_buttons>
#pragma dynamic 100000
//#define PATH "users/%s.ini"
#define                 SYNTAX_MESSAGE                          "Syntax: {FFFFFF}"
#define SERVER_GM_MAP "LS/FC/RC"
#define SERVER_GM_LANGUAGE "Bahasa Indonesia / English"
#define SERVER_GM_TEXT "JL:RP v7.1 [0.3.DL]"
#define SERVER_NAME "Just Life Roleplay"
#define DIALOG_INVENTORY (3123)
#define BAN_DIALOG (3124)
#define RATE_INC (500) // The sensitivity per message, no need to modify.
#define RATE_MAX (500) // When the flood rate reaches this value the action below will be taken
enum LIST_ANTIFLOOD
{
	lastCheck,
	floodRate
}
new AntiFlood_Data[MAX_PLAYERS][LIST_ANTIFLOOD];
//GUN HOLDING
#define DIALOG_EDIT_BONE 1520

enum weaponInfo
{
	Float:Position[6],
	Bone,
	Hidden
}

new WeaponInfo[MAX_PLAYERS][39][weaponInfo], WeaponCheckTimer[MAX_PLAYERS], EditingWeapon[MAX_PLAYERS];
//Ammo define
#define 				AMMO_MELEE 								99999
#define 				AMMO_MINIGUN 							650 //Without F means for faction
#define 				AMMO_SHOTGUN 							250
#define 				AMMO_M4AK 								1000
#define 				AMMO_SNIPER 							25
#define 				AMMO_GRANADE 							3
#define 				AMMO_RPG 								1
#define 				AMMO_FT 								900
#define 				AMMO_GG 								900
#define 				AMMO_TRUCK 								3 //Truck for trucker bonuses
#define 				AMMO_TRUCK2 							15
#define 				AMMO_SGMINIGUN 							150 //SG to bottom for SellGun
#define 				AMMO_SGSHOTGUN 							35
#define 				AMMO_SGM4AK 							250
#define 				AMMO_SGSNIPER 							20
#define 				AMMO_SGGRANADE 							1
#define 				AMMO_DEAGLE 							200
#define 				AMMO_9MM 								750
#define					DIALOG_MAKEAMMO	                        (86)
#define					DIALOG_REFUEL                       	(87)
#define 				DIALOG_MODIF                            (119)
#define                 DIALOG_INSTALLNEON                      (1401)
#define                 DIALOG_FIXCAR                           (76)
#define                 DIALOG_VEHMENU                          (77)
#define 				DIALOG_CREATEGUN 						(85)
#define 				DIALOG_PLANTSEED						(88)
new szPlayerName[MAX_PLAYER_NAME];
//Desc Text - AriWiwin14
new Text:DescriptionText[MAX_PLAYERS];
new DescriptionTimer[MAX_PLAYERS];
//Fixed
new CurGMX;
// strcpy - Simon / Y_LESS
#define strcpy(%0,%1,%2) \
    strcat((%0[0] = '\0', %0), %1, %2)

#define MAX_BUSINESSES 25
#define MAX_ATM 50
#define MAX_COBJECTS 10000
#define MAX_RENT 20
#define MAX_WORKSHOP 10
#define MAX_GYMOBJECT 100
#define MAX_WEAPON_HACK_WARNINGS (1)
#define MAX_FARM 10
#define MAX_BUYPOINT 100
#define MAX_MOD 5
#define SPECIAL_ACTION_PISSING 68
#define MAX_OBJECTS_PER_PLAYER 10
//ANIMATION Coded by AriWiwin14
#define MAX_ANIMS (1812)
#define IANIM_DEFAULT_TIME (5000)
#define IANIM_DEFAULT_SPEED (2.0)
#define IANIM_DEFAULT_LOOP (0)
#define IANIM_DEFAULT_LOCKX (1)
#define IANIM_DEFAULT_LOCKY (1)
#define IANIM_DEFAULT_FREEZE (0)
#define IANIM_DEFAULT_FORCESYNC (1)
//HARGA
new HargaBensin, FishPrice, HargaAnggur, HargaBlueberry, HargaStrawberry, HargaGandum, HargaTomat; //PlantPrice;
//REWRITTEN BunnyHopping and Bus Label by AriWiwin14
new PlayerPressedJump[MAX_PLAYERS];
new togbh[MAX_PLAYERS];
//BIZ INTERIOR Coded by AriWiwin14
#define BUSINESSES_INT 5000
//ATM Coded by AriWiwin14
new Text3D:atm[MAX_ATM];
new SpawnedATM;
#define BIZ_HEX             "{FFFF00}"
//DROP GUN
#define MAX_DROP_ITEMS 1000
#define COLOR_ACTION 0xFFC0CBFF
//NO ADMIN CHAT
new noadmin = 0;
//DOOR INTERIOR PICKUP
new ExitPickup[MAX_PLAYERS];
new advtimer;

//Object
new oEdit[MAX_PLAYERS];
new oEditID[MAX_PLAYERS]; // Object's ID
new Float:oPos[MAX_PLAYERS][3];
new Float:oRot[MAX_PLAYERS][3];
// Kick Fix
forward                 antiCheat();
new kick_gTimer[MAX_PLAYERS];

stock FixedKick(playerid) {
    KillTimer(kick_gTimer[playerid]);
    kick_gTimer[playerid] = SetTimerEx("DelayedKick", 500, false, "i", playerid);
    return 1;
}

forward KickPublic(playerid);
public KickPublic(playerid) { Kick(playerid); }

forward DelayedKick(playerid);
public DelayedKick(playerid) {
    if (!IsPlayerConnected(playerid)) return 1;
    Kick(playerid);
    return 1;
}
//Text
new Text:Rp;
new Text:sen;
new Text:koma2;
//HBE
new Bar:phealth[MAX_PLAYERS] = {INVALID_BAR_ID, ...};
new Bar:parmor[MAX_PLAYERS] = {INVALID_BAR_ID, ...};
new PlayerText:HBEO[MAX_PLAYERS];
new PlayerText:HBEName[MAX_PLAYERS];
//NPC Bus
new NPCBedjo;
new NPCSanusi;
new BusID[MAX_PLAYERS];
new PlayerSitting[MAX_PLAYERS];
new Float:Playerx[MAX_PLAYERS], Float:Playery[MAX_PLAYERS], Float:Playerz[MAX_PLAYERS], Float:Playera[MAX_PLAYERS], PlayerSkin[MAX_PLAYERS];
forward IsAtBlueBusStop(playerid);
forward IsAtBlackBusStop(playerid);
forward ResetView(playerid);
forward CPOff(playerid);
new Text:Time, Text:Date;
forward settime(playerid);
//prison interior
new door[5];
new cell[36];
new fence[36];
new stair[3];
//Skin Selection
new skinlist = mS_INVALID_LISTID;
new FACTIONSKIN = mS_INVALID_LISTID;
//Toys Selection
new toy1000list = mS_INVALID_LISTID;
new toy1500list = mS_INVALID_LISTID;
new toy2000list = mS_INVALID_LISTID;
new toy3000list = mS_INVALID_LISTID;
new toy4000list = mS_INVALID_LISTID;
new toy5000list = mS_INVALID_LISTID;
new toylist = mS_INVALID_LISTID;
new vtoylist = mS_INVALID_LISTID;
// Serverlock ARWIN14
new bool:ServerLocked = false;
new bool:DialogHauling[10];
new bool:DialogSweeper[3];
new bool:DialogBus[3];
new bool:DialogSaya[MAX_PLAYERS][10];
new TrailerHauling[MAX_PLAYERS];
//hunger bladder energy
new PBHTimer[MAX_PLAYERS];
new PBETimer[MAX_PLAYERS];
new PBBTimer[MAX_PLAYERS];
new PBCTimer[MAX_PLAYERS];
//Textdraw
new Text:BSText[8];
//Bar
new Bar:hungry[MAX_PLAYERS] = {INVALID_BAR_ID, ...};
new Bar:tired[MAX_PLAYERS] = {INVALID_BAR_ID, ...};
new Bar:clean[MAX_PLAYERS] = {INVALID_BAR_ID, ...};
new FirstSpawn[MAX_PLAYERS];
//new Text:bilal;
new Text:Kotak;
new Text:forum;

new PayWarn[MAX_PLAYERS][MAX_PLAYERS];

//Animation
new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new gPlayerAnimLibsPreloaded[MAX_PLAYERS];
new animation[MAX_PLAYERS];
new Text:txtAnimHelper;
//Checkpoint
new CheckDoorPoint[MAX_PLAYERS];
new CheckBizPoint[MAX_PLAYERS];
//Countdown
#define Count_Start 1000
#define Count_End 700
#define FillTime 300

//paytoll
new paytoll1;
new paytoll2;
//Flashing Neon
new togneon[MAX_PLAYERS];
new neontog[MAX_PLAYERS];
forward togneonoff(playerid);
forward togneonon(playerid);

new Text3D:business1[MAX_BUSINESSES];
new Text3D:business2[MAX_BUSINESSES];
new SpawnedBusinesses;
new SpawnedWS;
new Text3D:MaskLabel[MAX_PLAYERS];
new Neon1[MAX_PLAYERS];
new Neon2[MAX_PLAYERS];
new SedangMancing[MAX_PLAYERS];
new SedangTrucking[MAX_PLAYERS];
new SedangHauling[MAX_PLAYERS];
new TakeTrucking[MAX_PLAYERS];
new CarTrucking[MAX_PLAYERS];
new Text3D:pickupML, Text3D:pickupML2, Text3D:pickupComp, Text3D:pickupPlant, Text3D:pickupPot, Text3D:equipment1, Text3D:equipment2, Text3D:equipment3;
new FishHolding[MAX_PLAYERS];
new CompHolding[MAX_PLAYERS];
//DMVCar
new DMVPlate1;
new DMVPlate2;
new DMVPlate3;
new DMVPlate4;
new DMVPlate5;
new DMVCar[6];
//new DMVPCar[4];
new LicenseTest[MAX_PLAYERS];
//new LicenseTestP[MAX_PLAYERS];
new CPD[MAX_PLAYERS];
//Rental Kendaraan
new Text3D:rent[MAX_RENT];
new RentVeh;

enum rInfo
{
	Float:rPosX,
	Float:rPosY,
	Float:rPosZ,
	rPickupID,
	rVehicle1,
	rVehicle2,
	rCost1,
	rCost2,
	rCost3,
	rCost4,
	rCost5,
	rCost6,
	Float:rSpawnX,
	Float:rSpawnY,
	Float:rSpawnZ,
	Float:rAngle,
};
new RentInfo[MAX_RENT][rInfo];
//ANIMATION
enum IANIM_DATA
{
	Float:iAnim_Speed,
	iAnim_Loop,
	iAnim_Lockx,
	iAnim_Locky,
	iAnim_Freeze,
	iAnim_Time,
	iAnim_ForceSync
}
new iAnim_AnimData[ MAX_ANIMS ][ IANIM_DATA ];

new bool:iAnim_PlayerUsingAnim[ MAX_PLAYERS char ];
//MONEYBAGS
#define MAX_MONEYBAGS  (150)
enum mbInfo
{
	mCreated,
    Float:mbX,
    Float:mbY,
    Float:mbZ,
    mPickup,
    mAmount,
    mMoneybag
};
new MoneyInfo[MAX_MONEYBAGS][mbInfo];
//FlyMode
// Players Move Speed
#define MOVE_SPEED              100.0
#define ACCEL_RATE              0.03

// Players Mode
#define CAMERA_MODE_NONE    	0
#define CAMERA_MODE_FLY     	1

// Key state definitions
#define MOVE_FORWARD    		1
#define MOVE_BACK       		2
#define MOVE_LEFT       		3
#define MOVE_RIGHT      		4
#define MOVE_FORWARD_LEFT       5
#define MOVE_FORWARD_RIGHT      6
#define MOVE_BACK_LEFT          7
#define MOVE_BACK_RIGHT         8

// Enumeration for storing data about the player
enum noclipenum
{
	cameramode,
	flyobject,
	mode,
	lrold,
	udold,
	lastmove,
	Float:accelmul
}
new noclipdata[MAX_PLAYERS][noclipenum];

//--------------------------------------------------

//Speedo
#define GREEN 			0x21DD00FF
#define RED 			0xE60000FF
#define YELLOW 			0xFFFF00FF
#define ORANGE 			0xF97804FF
#define LIGHTRED 		0xFF8080FF
#define LIGHTBLUE 		0x00C2ECFF
#define PURPLE 			0xB360FDFF
#define BLUE 			0x1229FAFF
#define LIGHTGREEN 		0x38FF06FF
#define DARKPINK 		0xE100E1FF
#define DARKGREEN 		0x008040FF
#define ANNOUNCEMENT 	0x6AF7E1FF
#define GREY 			0xCECECEFF
#define PINK 			0xD52DFFFF
#define DARKGREY    	0x626262FF
#define AQUAGREEN   	0x03D687FF
#define WHITE 			0xFFFFFFFF

#define PLAYERS 200

#define L_VEHICLE 200


//******************************************************************************
// SpeedoMeter Configurations
//******************************************************************************

//::::::::::::::::::::::::::::::::::::
// -> Functions Config <-
//::::::::::::::::::::::::::::::::::::
#define VehicleMaxSpeed  500                //Define the Speed Limit! (KPH)
#define UpdateConfig     500               //Update Speedo functions in ... (Miliseconds)


//::::::::::::::::::::::::::::::::::::
// -> Speedo TextDraw Config <-
//::::::::::::::::::::::::::::::::::::
//Enable = true || Disable = false


//::::::::::::::::::::::::::::::::::::
// -> Speedo Colors Config <-
//::::::::::::::::::::::::::::::::::::
#define BoxColor         0xffffffff     //Color of Speedo Box
#define SideLinesColor   0xffffffff     //Color of Speedo Side Lines
#define TopLinesColor    0xffffffff     //Color of Speedo Top lines
#define CategoriesColor  "~b~"          //Color of (Vehicle,Health,Altitude,Gps)
#define MPH_KPH_Color    "~g~"          //Color of (MPH,KPH)

//******************************************************************************


//-----------------------------------------> Change

#define MAX_ZONE_NAME 28

new Text:LBox[MAX_PLAYERS];
new Text:LLine1[MAX_PLAYERS];
new Text:LLine2[MAX_PLAYERS];
new Text:LLine3[MAX_PLAYERS];
new Text:LCredits[MAX_PLAYERS];
new LuX_SpeedoMeter[MAX_PLAYERS];

new lString[256];

enum ReadPositions{Float:ReadX,Float:ReadY,Float:ReadZ}
new Float:VehPosX[MAX_VEHICLES], Float:VehPosY[MAX_VEHICLES], Float:VehPosZ[MAX_VEHICLES];

forward LAutoUnlock(vehicleid);

new LVehiclesName[][] =
{
   "Landstalker",
   "Bravura",
   "Buffalo",
   "Linerunner",
   "Pereniel",
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
   "Trailer",
   "Previon",
   "Coach",
   "Cabbie",
   "Stallion",
   "Rumpo",
   "RC Bandit",
   "Romero",
   "Packer",
   "Monster Truck",
   "Admiral",
   "Squalo",
   "Seasparrow",
   "Pizzaboy",
   "Tram",
   "Trailer",
   "Turismo",
   "Speeder",
   "Reefer",
   "Tropic",
   "Flatbed",
   "Yankee",
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
   "News Chopper",
   "Rancher",
   "FBI Rancher",
   "Virgo",
   "Greenwood",
   "Jetmax",
   "Hotring",
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
   "Cropdust",
   "Stunt",
   "Tanker",
   "RoadTrain",
   "Nebula",
   "Majestic",
   "Buccaneer",
   "Shamal",
   "Hydra",
   "FCR-900",
   "NRG-500",
   "HPV1000",
   "Cement Truck",
   "Tow Truck",
   "Fortune",
   "Cadrona",
   "FBI Truck",
   "Willard",
   "Forklift",
   "Tractor",
   "Combine",
   "Feltzer",
   "Remington",
   "Slamvan",
   "Blade",
   "Freight",
   "Streak",
   "Vortex",
   "Vincent",
   "Bullet",
   "Clover",
   "Sadler",
   "Firetruck",
   "Hustler",
   "Intruder",
   "Primo",
   "Cargobob",
   "Tampa",
   "Sunrise",
   "Merit",
   "Utility",
   "Nevada",
   "Yosemite",
   "Windsor",
   "Monster Truck",
   "Monster Truck",
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
   "Freight",
   "Trailer",
   "Kart",
   "Mower",
   "Duneride",
   "Sweeper",
   "Broadway",
   "Tornado",
   "AT-400",
   "DFT-30",
   "Huntley",
   "Stafford",
   "BF-400",
   "Newsvan",
   "Tug",
   "Trailer",
   "Emperor",
   "Wayfarer",
   "Euros",
   "Hotdog",
   "Club",
   "Trailer",
   "Trailer",
   "Andromada",
   "Dodo",
   "RC Cam",
   "Launch",
   "Police Car (LS)",
   "Police Car (SF)",
   "Police Car (LV)",
   "Police Ranger",
   "Picador",
   "S.W.A.T. Van",
   "Alpha",
   "Phoenix",
   "Glendale",
   "Sadler",
   "Luggage Trailer",
   "Luggage Trailer",
   "Stair Trailer",
   "Boxville",
   "Farm Plow",
   "Utility Trailer"
};


forward LuX_SpeedoMeterUp();

//

#define TEXT_DRAW_FONT      	(2)
#define TEXT_DRAW_X_FACTOR  	(0.4)
#define TEXT_DRAW_Y_FACTOR  	(0.8)

#define PLAYERS 200

//--------------------
#define DTUT    15769
#define DTUT1   15770
#undef INVALID_TEXT_DRAW
#define INVALID_TEXT_DRAW (Text:0xFFFF)
#define LOAD_ON_START


static gTeam[MAX_PLAYERS];
static pvehicleid[MAX_PLAYERS]; // array containing players vehicle id (loaded when player enters as driver)
static pmodelid[MAX_PLAYERS]; // array containing players vehicle MODEL id (loaded when player enters as driver)

#define MAX_PING 800
#define RADIO2 0x2641FEAA

#define	TYPE_TPMATRUNTIMER 1
#define	TYPE_TPDRUGRUNTIMER 2
#define	TYPE_ARMSTIMER 3
#define	TYPE_GIVEWEAPONTIMER 4
#define	TYPE_HOSPITALTIMER 5
#define	TYPE_SEXTIMER 6
#define	TYPE_FLOODPROTECTION 7
#define	TYPE_HEALTIMER 8
#define TYPE_GUARDTIMER 9
#define TYPE_SELLMATSTIMER 12

#define	MAX_BARRICADES	10
#define MAX_MODS 15
#define MAX_DEALERSHIPVEHICLES 10
#define MAX_CARDEALERSHIPS 8
#define DIALOG_CDCHANGETYPE 1339
#define DIALOG_CDEDIT 1329
#define DIALOG_CDUPGRADE 1328
#define DIALOG_CDTILL 1327
#define DIALOG_CDEDITCARS 1326
#define DIALOG_CDEDITONE 1325
#define DIALOG_CDEDITMODEL 1324
#define DIALOG_CDEDITCOST 1323
#define DIALOG_CDEDITPARK 1322
#define DIALOG_CDDELVEH 1321
#define DIALOG_CDNEWVEH 1320
#define DIALOG_CDRADIUS 1319
#define DIALOG_CDNAME 1318
#define DIALOG_CDPRICE 1317
#define DIALOG_CDBUY 1316
#define DIALOG_CDWITHDRAW 1315
#define DIALOG_CDDEPOSIT 1314
#define DIALOG_CDSELL 1313
#define RED_FLAG_OBJ 1580
#define BLUE_FLAG_OBJ 1579
#define HILL_OBJ 1578
#define INVALID_WEED_ID 	-1
#define VEHICLE_RESPAWN 7200
#define SPEEDGUN 43
#define MAX_NOP_WARNINGS 4

#define GetVehicleName(%0) VehicleName[GetVehicleModel(%0)-400]
#define GetPlayerCash(%0) GetPVarInt(%0, "Cash")
#define IsNull(%1) \
((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))

#define SetPVarInt(%0,%1,0); DeletePVar(%0,%1);

#define SpeedCheck(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1) ) *%3*1.6)
stock const gWeather[] = {
	14, 1, 7, 3, 5, 12, 9, 8, 15
};
new MaleSkin[] = { 1,2,4,5,6,7,14,15,20,21,22,23,24,25,26,29,30,38,44,46,47,48,58,59,60,66,67,72,73,98,101,134,135,136,149,170,183,184,185,186,187,212,213,217,221,222,223,235,236,240,241,242,250,261,262,290,291,299 };
new FemaleSkin[] = { 9,10,12,13,39,40,41,54,55,56,69,76,88,89,93,148,150,151,169,190,191,192,193,195,211,214,215,216,218,219,224,225,226,231,232,233,298 };

// Script Commodities (Points, Houses, Etc)
#define NEW_VULNERABLE 24
#define TIME_TO_CLAIM 1
#define TIME_TO_TAKEOVER 10
#define MAX_FAMILY 14
#define MAX_POINTS 9
#define MAX_DMAPICONS 400
#define MAX_DDOORS 800
#define MAX_HOUSES 1400
#define MAX_SPEED_HACK_WARNINGS 4
#define MAX_GATES 1400
#define INVALID_HOUSE_ID -1

// Main Menu
#define MAINMENU 4070
#define MAINMENU2 4071

#define DOORLOCK 5001

// NMute & AdMute
#define NMUTE 4100
#define ADMUTE 4101

// Shop Orders
#define DIALOG_HELP 5305
#define ACCOUNT 5306
#define CHAT 5307
#define GENERAL 5308
#define VEHICLE 5309
#define LSPDHELP 5310
#define FBIHELP 5311
#define SFPDHELP 5312
#define SAMDHELP 5313
#define GOVHELP 5314
#define SASDHELP 5315
#define SANHELP 5316
#define TAXIHELP 5317
#define AHELP1 5318
#define FAMHELP 5319
#define CHELP 5320
#define BIZHELP 5322
#define HOUSEHELP 5323
#define RENTHELP 5324
#define FAILED 5325
#define FAILED2 5326
#define VEH_MENU    11025

// Player Vehicle Defines
#define MAX_PLAYERVEHICLES 5
#define MAX_PLAYERTOYS 10
#define MAX_MODS 15
#define MAX_GANG_VEHICLES 10
#define INVALID_PLAYER_VEHICLE_ID 0

// Admin Defines
#define MAX_REPORTS  1000
#define INVALID_REPORT_ID -1
#define WEAPON_HACKER_WARNINGS  4
#define NOOB_SKIN 299

// FBI
#define FDUTYMENU 111
#define FDUTYMENU2 222
#define FDUTYMENU3 333
#define FDUTYMENU4 444
#define FDUTYMENU5 6666

#define DUTYMENU 555
#define DUTY_OPTIONS 10041
#define DUTYMENU2 666
#define DUTYMENU3 777
#define DUTYMENU4 888
#define DUTYMENU5 11111
#define STOREMENU 999
#define PETROLMENU 19301
#define GYMMENU 19302
#define LOTTOMENU 987
#define ELEVATOR 18456
#define ELEVATOR2 18455
#define ELEVATOR3 18457
#define VIPNUMMENU 18726
#define VIPNUMMENU2 18765
#define VIPNUMMENU3 17658
#define TRACKCAR 19101
#define GOTOPLAYERCAR 19103
#define DELETECAR 19104
#define House275CAR 19200
#define PAYTICKET 19300

//Rental
#define RENTMENU 17654
#define RENTVEH 17655
#define RENTVEH21 17656
#define RENTVEH22 17657
//#define RENTMENUFAGGIO 18458

// Number Plate Registration
#define FIGHTMENU 22222
#define REPORTSMENU 10031

#define LSMDDIVDUTYMENU 1312
#define LSMDDIVDUTYMENU2 1313
#define LSMDDIVDUTYMENU3 1314
#define LSMDDIVDUTYMENU4 1315
#define LSMDDIVDUTYMENU5 1316

// SFPD
#define	DIALOG_SFPD	5502
#define DIALOG_SFPD_WEAPONS 5503
#define DIALOG_SFPD_CLOTHING 5504
#define DIALOG_SFPD_CLOTHING_TWO 5505

// SASD
#define DIALOG_SASD 5506
#define DIALOG_SASD_WEAPONS 5507
#define DIALOG_SASD_CLOTHING 5508
#define	DIALOG_SASD_CLOTHING_TWO 5509

// SANews
#define DIALOG_SANEWS 5510

// VIP
#define VIPWEPSMENU 3489

// Water Patrol
#define WPDUTYMENU 6549
#define WPDUTYMENU2 2645
#define WPDUTYMENU3 9874
#define WPDUTYMENU4 3649

// LSMD
#define LSMDMENU 7777
#define LSMDSKINS 9999

#define SAGSMENU 4374
#define SESKINS 4375

#define GIVEKEYS 4394
#define REMOVEKEYS 4395
#define MPSFRELEASE 4396
#define HQENTRANCE 4397
#define HQEXIT 4398
#define HQCUSTOMINT 4399
#define HQDELETE 4400

#define FAQMENU 4377
#define COLOREDDOTSFAQ 4378
#define LOCKSFAQ 4379
#define SKINSFAQ 4380
#define ATMFAQ 4381
#define FACTIONSFAQ 4382
#define GANGSFAQ 4383
#define HITMENFAQ 4384
#define WEBSITEFAQ 4385
#define FURTHERHELPFAQ 4386
#define UNMODCARMENU 4388

stock IsAPlane(carid2)
{
        new carid = GetVehicleModel(carid2);
        if(carid == 592 || carid == 577 || carid == 511 || carid == 512 || carid == 593 || carid == 520 || carid == 553 || carid == 476 || carid == 519 || carid == 460 || carid == 513) return 1;
        return 0;
}

stock IsABoat(carid)
{
        new modelid = GetVehicleModel(carid);
        if(modelid == 430 || modelid == 446 || modelid == 452 || modelid == 453 || modelid == 454 || modelid == 472 || modelid == 473 || modelid == 484 || modelid == 493 || modelid == 595)
        {
                return 1;
        }
        return 0;
}
IsVIPModel(carid)
{
	new Cars[] = { 451, 541, 411, 429, 522, 444, 556, 557 };
	for(new i = 0; i < sizeof(Cars); i++)
	{
		if(GetVehicleModel(carid) == Cars[i]) return 1;
	}
	return 0;
}

// JOB HELP DIALOGS
#define JOBHELPMENU 10000
#define VIPHELPMENU 10001
#define DRUGDEALERJOB 10010
#define DRUGDEALERJOB2 10011
#define DRUGDEALERJOB3 10012
#define MECHANICJOB 10013
#define MECHANICJOB2 10014
#define MECHANICJOB3 10015
#define BODYGUARDJOB 10016
#define BODYGUARDJOB2 10017
#define BODYGUARDJOB3 10018
#define ARMSDEALERJOB 10019
#define ARMSDEALERJOB2 10020
#define ARMSDEALERJOB3 10021
#define TAXIJOB 10025
#define TAXIJOB2 10026
#define TAXIJOB3 10027
#define SMUGGLEJOB 10028
#define SMUGGLEJOB2 10029
#define SMUGGLEJOB3 10030
#define TRUCKERJOB 10033
#define FARMERJOB 10035

//MDC
#define MDC_START_ID    10098
#define MDC_MAIN        10099
#define MDC_FIND 		10100
#define MDC_MEMBERS     10101
#define MDC_BLANK	    10102
#define MDC_WARRANTS    10103
#define MDC_CHECK       10104
#define MDC_LICENSES    10105
#define MDC_LSPD        10106
#define MDC_SFPD        10107
#define MDC_FBI         10108
#define MDC_LSMD       10109
#define MDC_MESSAGE     10110
#define MDC_SMS         10111
#define MDC_BOLOLIST    10112
#define MDC_ISSUE       10113
#define MDC_DELETE      10114
#define MDC_DEL_WARRANT 10115
#define MDC_DEL_BOLO    10116
#define MDC_LOGOUT      10117
#define MDC_CREATE      10118
#define MDC_CIVILIANS   10119
#define MDC_ISSUE_SLOT  10120
#define MDC_MESSAGE_2   10121
#define MDC_SMS_2       10122
#define MDC_BOLO        10123
#define MDC_BOLO_SLOT   10124
#define MDC_END_ID    	10125

#define AUDIO_URL 		10126
#define TIPDIALOG      	10129

#define LAELEVATOR      10130

//Vehicle Toy
#define BUYVTOYS        12345
#define BUYVTOYS2       12346
#define DIALOG_VTOYS    12347
#define DELETEVTOYS     12348
#define VTOYEDIT        12350
#define EDITVTOYS       12351
#define VTOYCOL         12352
#define VTOYCOL2        12353
#define VTOYCOL3        12354
#define VTOYCOL4        12355
#define VTOYTEXT        12349
#define VTOYTEXTCOL     12356
#define VTOYTEXT1       12357
#define VTOYTEXTCOL1    12358
#define VTOYTEXTSIZE    12359
#define VTOYTEXTSIZE1   12360
#define BUYVTOYS3       12361
#define BUYVTOYS4       12363
#define VTOYTEXTFONT    12364
#define VTOYTEXTFONT1   12365

//Fix bugged Player
#define BUGGED          12362
//
#define TOYS        	10131
#define DELETETOY       10132
#define WEARTOY         10133
#define BUYTOYS         10134
#define BUYTOYS2        10135
#define BUYTOYS3        10136
#define BUYTOYSGOLD     10137
#define BUYTOYSGOLD2    10138
#define BUYTOYSGOLD3    10139
#define EDITTOYS        10140
#define EDITTOYS2       10141
#define EDITTOYSBONE    10142
#define EDITTOYSPX      10143
#define EDITTOYSPY      10144
#define EDITTOYSPZ      10145
#define EDITTOYSRX      10146
#define EDITTOYSRY      10147
#define EDITTOYSRZ      10148

#define LAELEVATORPASS  10149

#define BUYTOYSCOP      10153
#define BUYTOYSCOP2     10154
#define BUYTOYSCOP3     10155

// LICENSES
#define DIALOG_LICENSE_BUY 10040

//LSMD MDC
#define FMDC 10156

// Colors/Misc.
#define MAX_STRING 255
#define CHECKPOINT_NONE 0
#define CHECKPOINT_HOME 12
#define CHECKPOINT_RETURNTRUCK 97652
#define COLOR_DARKRED 0xAA3333FF
#define COLOR_GOLD 	0xF6C861FF
#define COLOR_NICERED 0xFF0000FF
#define COLOR_TWWHITE 0xFFFFFFFF
#define COLOR_TWBROWN 0x654321FF
#define COLOR_TWRED 0xFF0000FF
#define COLOR_TWPINK 0xE75480FF
#define COLOR_TWGRAY 0x808080FF
#define COLOR_TWOLIVE 0x808000FF
#define COLOR_TWPURPLE 0x800080FF
#define COLOR_TWTAN 0xD2B48CFF
#define COLOR_TWAQUA 0x00FFFF00
#define COLOR_TWORANGE 0xFF8C00FF
#define COLOR_TWAZURE 0x007FFFFF
#define COLOR_NICEGREEN 0x00FF00FF
#define COLOR_LIGHTNEUTRALBLUE 0xabcdefFF
#define COLOR_TWGREEN 0x008000FF
#define COLOR_TWBLUE 0x0000FFFF
#define COLOR_TWBLACK 0x000000FF
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREY 0xAFAFAFFF
#define COLOR_GREEN 0x33AA33FF
#define COLOR_RED 0xFF0000FF
#define COLOR_REALRED 0xFF0606FF
#define COLOR_LIGHTGREEN 0x9ACD3200
#define COLOR_YELLOW 0xFFFF00FF
#define COLOR_BLUE 0x1229FAFF
#define COLOR_VIP 0xC93CCE00
#define COLOR_ARWIN 0xC6E2FFFF
#define COLOR_ORANGE 0xFFA500FF
#define COLOR_LIGHTBLUE 0xADD8E6FF
#define COLOR_YELLOW2 0xE6FF00FF
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_PURPLE 0xC2A2DAFF
#define COLOR_PINK 0xFF66FFAA
#define COLOR_DBLUE 0x2641FEAA
#define COLOR_ALLDEPT 0xFF8282AA
#define COLOR_BLACK 0x000000AA
#define TEAM_SFPD   0x6699FF00
#define TEAM_SASD   0xCC993300
#define COLOR_NEWS 0xFFA50000
#define COLOR_OOC 0xE0FFFFAA
#define COLOR_NG 0x9ACD3200
#define COLOR_TR 0x56B9B900
#define COLOR_TR2 0x11DCDC00
#define COLOR_FBI 0x8D8DFFFF
#define COL_FORUM 0x808000C8
#define PUBLICRADIO_COLOR 0x6DFB6DFF
#define TEAM_CYAN 1
#define TEAM_BLUE 2
#define TEAM_GREEN 3
#define FIND_COLOR 0xB90000FF
// #define COLOR_PMC 0xC8B56000
#define COLOR_PMC 0x930A16FF
#define TEAM_GREEN_COLOR 0xFFFFFFAA
#define TEAM_LSSD_COLOR 0x33AA3300
#define TEAM_JOB_COLOR 0xFFB6C1AA
#define TEAM_HIT_COLOR 0xFFFFFF00
#define TEAM_BLUE_COLOR 0x2641FE00
#define TEAM_FBI_COLOR 0x8D8DFF00
#define TEAM_NEWS_COLOR 0x049C7100
#define TEAM_LSMD_COLOR 0xFF828200
#define TEAM_TAXI_COLOR 0xF2FF0000
#define COP_GREEN_COLOR 0x33AA33AA
#define COLOR_ADD 0x63FF60AA
#define TEAM_GROVE_COLOR 0x00D900C8
#define TEAM_VAGOS_COLOR 0xFFC801C8
#define TEAM_BALLAS_COLOR 0xD900D3C8
#define TEAM_AZTECAS_COLOR 0x01FCFFC8
#define TEAM_CYAN_COLOR 0xFF8282AA
#define TEAM_MED_COLOR 0xFF828200
#define TEAM_ORANGE_COLOR 0xFF800000
#define TEAM_COR_COLOR 0x39393900
#define TEAM_BAR_COLOR 0x00D90000
#define TEAM_TAT_COLOR 0xBDCB9200
#define TEAM_CUN_COLOR 0xD900D300
#define TEAM_STR_COLOR 0x01FCFF00
#define TEAM_ADMIN_COLOR 0x00808000
#define COLOR_INVIS 0xAFAFAF00
#define COLOR_SPEC 0xBFC0C200
#define DEPTRADIO 0xFFD7004A
#define RADIO 0x8D8DFFFF
#define FRADIO 0xAA3333AA
#define COLOR_NEWBIE 0x7DAEFFFF
#define COLOR_COMBINEDCHAT 0x6CEFF0FF
#define COLOR_REPORT 0xFFFF91FF
#define COLOR_SHOP 0xE7E784FF
#define ResetMoneyBar AC_BS_ResetPlayerMoney
#define UpdateMoneyBar AC_BS_GivePlayerMoney
//GPS
#define GPSFile ("Positions.db") //The file where everything should be saved!
#define MAX_LOCATIONS 50 //How many locations you want to have!
#define UseTd //Comment This if you dont want to use the TextDraw! (To comment put // at the begining of this line)
//ACTOR SYSTEM -ARIWIWIN14
#define SEM(%0,%1) SendClientMessage(%0,0xBFC0C200,%1) 					// SEM = Send Error Message by 	Myself
#define Loop(%0,%1) for(new %0 = 0; %0 < %1; %0++)                      // Loop                     by 	Myself
#define IsNull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))    // IsNull macro 			by 	Y_Less
#define strToLower(%0) \
    for(new i; %0[i] != EOS; ++i) \
        %0[i] = ('A' <= %0[i] <= 'Z') ? (%0[i] += 'a' - 'A') : (%0[i])  // strToLower 				by 	RyDeR`
#define RGBAToInt(%0,%1,%2,%3) \
	((16777216 * (%0)) + (65536 * (%1)) + (256 * (%2)) + (%3))          // RGBAToInt 				by 	RyDeR`
	#define MAX_EDITING_ACTOR    (100)

new Iterator:DynamicActors<MAX_EDITING_ACTOR>;
new DynamicActor[MAX_EDITING_ACTOR];
new Text3D:DynamicActorLabel[MAX_EDITING_ACTOR];
//ANTI AIMBOT -ARIWIWIN14
new AimbotWarnings[MAX_PLAYERS];
//Cammode -ARIWIWIN14
new Cammode[MAX_PLAYERS];
//STROBE -ARIWIWIN14
new Strobe[MAX_VEHICLES];
new StrobeObject[MAX_VEHICLES];
//SideJob Sweeper - ARIWIWIN14
new KerjaSweeper[MAX_PLAYERS];
new SweeperSteps[MAX_PLAYERS][4];
//Sidejob Bus - ARIWIWIN14
new KerjaBus[MAX_PLAYERS];
new BusSteps[MAX_PLAYERS][4];
//KULI BANGUNAN - ARIWIWIN14
new SedangKuli[MAX_PLAYERS];
//=============speedometer by Rifky ==============================
new Float:VehicleFuel[MAX_VEHICLES];
//Lumberjack by AriWiwin14 - Special 2Years Anniversary
new kgcutt[MAX_PLAYERS];
new cuttrands;
new timecutt[MAX_PLAYERS];
new Text3D:Wood3DText;
forward TimeDrov(playerid);
new randomcutt[][1] =
{
    {25},{27},{29},{28},{33},{30},{35},{32},{37},{41},{36},
	{42},{47},{52},{39},{40},{53},{54},{43},{44},{45}
};
//KNIFE
forward Damagee(playerid);
new infect[MAX_PLAYERS];
new damagee[MAX_PLAYERS];
new timerr;
//FARMER -ARIWIWIN14
#define MAX_PLANT 1000
#define LIBRARY "BOMBER"
#define ANIMATION "BOM_Plant_Crouch_In"
#define HAULING 5555
#define MPSPAYTICKETS 5556
#define TAKEVEH 5557
#define SWEEPERJOB 5558
#define BUSJOB 5559
#define CLAIMINSURANCE 5560
#define WORKSHOP 5561
#define TRAININGSKILL 5600
#define BUSINESESS 5700
//ENUM GYM
enum GYMObjectInfo
{
	Float:GYMOBJPos[6],
	Text3D:GYMOBJText,
	GYMOBJType,
	GYMOBJObject,
	GYMOBJUsed,
	GYMOBJCondition
};
new GYMInfo[MAX_GYMOBJECT][GYMObjectInfo];
new gymEdit[MAX_PLAYERS]; //1=object posisi
new gymEditID[MAX_PLAYERS];
new Float:gymObjectPos[MAX_PLAYERS][3];
new Float:gymObjectRot[MAX_PLAYERS][3];
//ENUM PLANT
enum plantInfo
{
	plantTime,
	plantType,
	Float:plantPos[3],
	plantObject
}

new PlantInfo[MAX_PLANT][plantInfo];

forward stonedtimer(playerid);
public stonedtimer(playerid)
{
	SetPlayerWeather(playerid,0);
	return 1;
}

//FLASH LIGHT LIKE ELM - Coded by AriWiwin14
#define flashtime 115 //milliseconds for the flash, larger number = slower flash
new Flash[MAX_VEHICLES];
new FlashTime[MAX_VEHICLES];

//=================================//
//  	VIP DEFINE				  //
//================================//
//Vtoys
#define VSPA 12004
// System Neon
#pragma tabsize 0
#define neondialog 8131

// strcpy - Simon / Y_LESS
#define SendFormattedMessage(%0,%1,%2) do{new _str[128]; format(_str,128,%2); SendClientMessageEx(%0,%1,_str);}while(FALSE)

/* Forwards (TODO: Convert to Naked or Move right above function.) */
forward SetupPlayerForClassSelection(playerid);
forward ModCar(playerid);
forward SetCamBack(playerid);
forward simpenmaxlimit();
forward Float:GetDistanceBetweenPlayers(p1,p2);
forward SetAllPlayerCheckpoint(Float:allx, Float:ally, Float:allz, Float:radi, num);
forward SetAllCopCheckpoint(Float:allx, Float:ally, Float:allz, Float:radi);
forward SetPlayerCriminal(playerid,declare,reason[]);
forward SetPlayerFree(playerid,declare,reason[]);
forward SetPlayerWeapons(playerid);
forward SetPlayerWeaponsEx(playerid);
forward splits(const strsrc[], strdest[][], delimiter);
forward OnPlayerLogin(playerid, password[]);
forward DoGMX();
forward DisplayActionMessage(playerid);
forward SafeLogin(playerid);
forward SafeLoadObjects(playerid);
forward OnPlayerStatsUpdate(playerid);
forward OnPlayerRegister(playerid, password[]);
forward OnPlayerOfflineLogin(playername[]);
forward OnPlayerOfflineSave(playername[]);
forward BroadCast(color,String[]);
forward OOCOff(color,String[]);
forward OOCNews(color,String[]);
forward SendJobMessage(job, color, String[]);
forward SendFamilyMessage(family, color, String[]);
forward SendNewFamilyMessage(family, color, String[]);
forward RadioBroadCast(playerid, color, String[]);
forward SendDepartmentMessage(member, color, String[]);
forward SendRadioMessage(team, color, String[]);
forward SendRadioOOCMessage(member, color, String[]);
forward SendAdminMessage(color, String[]);
forward AddCar(carcoords);
forward ClearHouse(houseid);
forward ClearWS(wsid);
forward ClearFarm(farmid);
forward ClearGas(gasid);
forward ClearFamily(family);
forward ClearMarriage(playerid);
forward ClearPaper(paper);
forward ClearCrime(playerid);
forward ClearReports();
forward CarInit();
forward CarTow(carid);
forward CarRespawn(carid);
forward SyncTime();
forward SyncMinTime();
forward SyncPlayerTime(playerid);
forward Checkprop();
forward PayDay();
forward ini_GetKey( line[] );
forward ini_GetValue( line[] );
forward PlayerPlayMusic(playerid);
forward StopMusic();
forward PlayerFixRadio(playerid);
forward PlayerFixRadio2();
//forward SetCamBack(playerid);
forward FixHour(hour);
forward GetColorCode(clr[]);
forward DoorOpen(playerid);
forward DoorClose(playerid);
forward ShowPlayerBeaconForCops(playerid);
forward HidePlayerBeaconForCops(playerid);
forward ShowPlayerBeaconForMedics(playerid);
forward HidePlayerBeaconForMedics(playerid);
forward AddReportToken(playerid);
forward SeeReportToken(playerid,name[],day,month,year);
forward SendEMSQueue(playerid,type);
forward KillEMSQueue(playerid);
forward MoveEMS(playerid);
forward OAddFlag(name[],adminid,reason[]);
forward ORemoveFlag(name[]);
forward AddFlag(playerid,adminid,reason[]);
forward RemoveFlag(playerid);
forward OAddWarrant(name[],judgeid,crime[]);
forward ORemoveWarrant(name[]);
forward AddWarrant(playerid,judgeid,crime[]);
forward RemoveWarrant(playerid);
forward firstaid5(playerid);
forward firstaidexpire(playerid);
forward rccam(playerid);
forward cameraexpire(playerid);
forward CloseCourtGate1();
forward CloseCourtGate2();
forward CloseWestLobby();
forward CloseEastLobby();
forward CloseBlastDoor();
forward CloseBlastDoor2();
forward CloseBlastDoor3();
forward CloseCage();
forward CloseEntranceDoor();
forward CloseLocker();
forward CloseCCTV();
forward CloseChief();
forward CloseChiefFbi();
forward CloseSASD1();
forward CloseSASD2();
forward CloseSASD3();
forward CloseSASD4();
forward CloseSASD5();
forward CloseSANewsStudio();
forward CloseSANewsPrivate();
forward CloseSANewsOffice();
forward CloseElevatorDoors(floor);
//------------------------------------------------------------------------------------------------------

//---------------------------------------[Random Messages System]-----------------------//
new Text3D:PlayerADO[MAX_PLAYERS];//ADO
//tambahan
#define SCM SendClientMessage
#define HOUSES_INT 6000
new Siren[MAX_VEHICLES];
new SirenObject[MAX_VEHICLES];
new togglepm[MAX_PLAYERS];
new togaccent[MAX_PLAYERS];
new advertise[MAX_PLAYERS][128];
//AIMWARNINGS
static ids[MAX_PLAYERS];
//VIP Advertisement
new adTick[MAX_PLAYERS];
//ASK TIMER
new askTick[MAX_PLAYERS];
// Textdraw Global Variables
new Text:GPS[MAX_PLAYERS];

new vehicleMods[212][MAX_MODS][4];

new textdrawscount;

new InsideShamal[MAX_PLAYERS];
new InsideMainMenu[MAX_PLAYERS];
new InsideTut[MAX_PLAYERS];

new courtgates[2];
new VehicleStatus[MAX_VEHICLES char] = 0; // 0 == none, 1 == vehicle dead about to respawn
new RefuelingVehicle[MAX_PLAYERS];
new RefuelingVehiclePrice[MAX_PLAYERS];
new RefuelingVehicleTimer[MAX_PLAYERS];
new CounterRefuel[MAX_PLAYERS] = 0;
new LimitFuel[MAX_PLAYERS] = 0;
new Bar:FuelBar[MAX_PLAYERS] = INVALID_BAR_ID;

new audiohandle[MAX_PLAYERS][100];
new audiohandleglobal = 0;

new TextSpamTimes[MAX_PLAYERS];
new TextSpamUnmute[MAX_PLAYERS];
new CommandSpamTimes[MAX_PLAYERS];
new CommandSpamUnmute[MAX_PLAYERS];

new IsPlayerSteppingInVehicle[MAX_PLAYERS] = -1;
new scoreMusic[MAX_PLAYERS];
new stationidp[MAX_PLAYERS];
new stationidv[MAX_VEHICLES];
new courtjail[MAX_PLAYERS];

new TotalLogin, TotalConnect, TotalAutoBan, TotalRegister,PlayersConnected,MaxPlayersConnected,MPDay,MPMonth,MPYear,MPHour,MPMinute,PlayerCars,TotalUptime;
new Float:StopaniFloats[MAX_PLAYERS][3];
new HHcheckUsed = 0;
new Float:HHcheckFloats[MAX_PLAYERS][6];
new HHcheckInt[MAX_PLAYERS];
new HHcheckVW[MAX_PLAYERS];
new Float:EventFloats[MAX_PLAYERS][6];
new EventLastInt[MAX_PLAYERS]; new EventLastVW[MAX_PLAYERS];
new Float:BroadcastFloats[MAX_PLAYERS][6];
new BroadcastLastVW[MAX_PLAYERS];
new BroadcastLastInt[MAX_PLAYERS];
new GiftAllowed;
new SpecTimer;
new gTime;
new OrderAssignedTo[MAX_PLAYERS];
new eastin, eastout, lockerin, lockerout, cctvin, cctvout, elevator, roofkey, garagekey, chiefout, chiefin, westin, westout, fbichiefin, fbichiefout, fbichief1, fbichief2;
new eastlobby1, eastlobby2, westlobby1, westlobby2, cctv1, cctv2, locker1, locker2, chief1, chief2, sasd1A, sasd2A, sasd3A, sasd4A, sasd5A, sasd1B, sasd2B, sasd3B, sasd4B, sasd5B;
new SANewsStudio, SANewsStudioA, SANewsStudioB;
new SANewsLock = 1;
new SANewsPrivate, SANewsPrivateOPP, SANewsPrivateA, SANewsPrivateB;
new SANewsOffice, SANewsOfficeA, SANewsOfficeB;
new LAElevatorDoorLeft[20];
new LAElevatorDoorRight[20];
new LAElevatorDoorStatus;
new LAElevator;
new LAElevatorFloor;
new LAElevatorButton[20];
new LAElevatorFloorPick;
new LAElevatorMoving;
new LAElevatorFloorName[20][24];
new LAElevatorFloorPass[20][24];
new Text3D:SANews3DText;
new gBug[MAX_PLAYERS];
//new Frozen[MAX_PLAYERS];
new gRadio[MAX_PLAYERS];
new pcRadio[MAX_PLAYERS];
new OnKTP[MAX_PLAYERS];
new pTerluka[MAX_PLAYERS];
new NOPTrigger[MAX_PLAYERS];
new gBugSIU[MAX_PLAYERS];
new pTazer[MAX_PLAYERS];
new pTazerReplace[MAX_PLAYERS];
new TazerTimeout[MAX_PLAYERS];
new pCurrentWeapon[MAX_PLAYERS];
//new Float: explodehealth; new explodeveh;
new ReleasingMenu[MAX_PLAYERS];
new ListItemReleaseId[MAX_PLAYERS][50];
new Barricade[MAX_BARRICADES];
new GiveKeysTo[MAX_PLAYERS];
new ListItemTrackId[MAX_PLAYERS][50];
new nextteam;
new SANGate;
new SANGateStatus;
new LSPDGate;
new LSPDGate1;
new LSPDGate2;
new LSPDGateStatus;
new LSPDGate2Status;
new MatsHolding[MAX_PLAYERS];
new MatDeliver[MAX_PLAYERS];
new MatDeliver2[MAX_PLAYERS];
new NewbieTimer[MAX_PLAYERS];
new HelperTimer[MAX_PLAYERS];
new HlKickTimer[MAX_PLAYERS];
new VIPTimer[MAX_PLAYERS];
new JustReported[MAX_PLAYERS];
new UsedWeed[MAX_PLAYERS];
new UsedCrack[MAX_PLAYERS];
new Backup[MAX_PLAYERS];
new Security = 0;
new CreatedCars[100];
new StockIkan = 500, EquipmentStock = 1000, stockcomp = 5000, stockplant = 500, StockDPU = 100, stockpot = 100, stockcrack = 100, IDPlate = 0, cutt = 500;
new Tax = 0;
new TaxValue = 0;
new Jackpot = 0;
new Float:Positions[14][3];
new Medics = 0;
new MedicCall = 999;
new MedicCallTime[MAX_PLAYERS];
new MedicAccepted[MAX_PLAYERS];
new Mechanics = 0;
new shutdown = 0;
new MechanicCall = 999;
new MechanicCallTime[MAX_PLAYERS];
new EMSCallTime[MAX_PLAYERS];
new EMSAccepted[MAX_PLAYERS];
new Text3D:Camera3D[MAX_PLAYERS];
new JobDuty[MAX_PLAYERS];
new playerConnectedS[MAX_PLAYERS];
new playerSeconds[MAX_PLAYERS];
new playerTabbed[MAX_PLAYERS];
new playerTabbedTime[MAX_PLAYERS];
new playerLastTyped[MAX_PLAYERS];
new SchoolSpawn[MAX_PLAYERS];
new TakingLesson[MAX_PLAYERS];
new UsedFind[MAX_PLAYERS];
new Spectating[MAX_PLAYERS];
new DivorceOffer[MAX_PLAYERS];
new MarriageCeremoney[MAX_PLAYERS];
new ProposeOffer[MAX_PLAYERS];
new ProposedTo[MAX_PLAYERS];
new GotProposedBy[MAX_PLAYERS];
new MarryWitness[MAX_PLAYERS];
new MarryWitnessOffer[MAX_PLAYERS];
new TicketOffer[MAX_PLAYERS];
new TicketMoney[MAX_PLAYERS];
new PlayerStoned[MAX_PLAYERS];
new SpawnChange[MAX_PLAYERS];
new PlayerDrunk[MAX_PLAYERS];
new PlayerDrunkTime[MAX_PLAYERS];
new PlayerTazeTime[MAX_PLAYERS];
new FindTimePoints[MAX_PLAYERS];
new FindingPlayer[MAX_PLAYERS];
new FindTime[MAX_PLAYERS];
new CalledCops[MAX_PLAYERS];
new CopsCallTime[MAX_PLAYERS];
new CalledMedics[MAX_PLAYERS];
new MedicsCallTime[MAX_PLAYERS];
new OrderReady[MAX_PLAYERS];
new ConnectedToPC[MAX_PLAYERS];
new MedicTime[MAX_PLAYERS];
new NeedMedicTime[MAX_PLAYERS];
new PlayerTied[MAX_PLAYERS];
new PlayerCuffed[MAX_PLAYERS];
new PlayerCuffedTime[MAX_PLAYERS];
new LiveOffer[MAX_PLAYERS];
new TalkingLive[MAX_PLAYERS];
new PlacedNews[MAX_PLAYERS];
new broadcasting = 0;
new cameraangle = 0;
new Text3D:camera;
new viewers = 0;
new WatchingTV[MAX_PLAYERS];
new ChosenSkin[MAX_PLAYERS];
new GettingJob[MAX_PLAYERS];
new GettingJob2[MAX_PLAYERS];
new GettingIllegalJob[MAX_PLAYERS];
new CurrentMoney[MAX_PLAYERS];
new CP[MAX_PLAYERS];
new MoneyMessage[MAX_PLAYERS];
new Condom[MAX_PLAYERS];
new STDPlayer[MAX_PLAYERS];
new SprayOffer[MAX_PLAYERS];
new SprayPrice[MAX_PLAYERS];
new SprayPaint[MAX_PLAYERS];
new NeonOffer[MAX_PLAYERS];
new NeonID[MAX_PLAYERS];
new GunOffer[MAX_PLAYERS];
new GunId[MAX_PLAYERS];
new GunMats[MAX_PLAYERS];
new GunAmmoAmount[MAX_PLAYERS];
new GunPrice[MAX_PLAYERS];
new hInviteOffer[MAX_PLAYERS];
new hInviteHouse[MAX_PLAYERS];
new hInviteSlot[MAX_PLAYERS];
new InviteOffer[MAX_PLAYERS];
new InviteFaction[MAX_PLAYERS];
new InviteMech[MAX_PLAYERS];
new InviteFarm[MAX_PLAYERS];
new InviteFamily[MAX_PLAYERS];
new MatsOffer[MAX_PLAYERS];
new MatsPrice[MAX_PLAYERS];
new MatsAmount[MAX_PLAYERS];
new PotOffer[MAX_PLAYERS];
new PotPrice[MAX_PLAYERS];
new PotGram[MAX_PLAYERS];
new CrackOffer[MAX_PLAYERS];
new CrackPrice[MAX_PLAYERS];
new CrackGram[MAX_PLAYERS];
new DrinkOffer[MAX_PLAYERS];
new VehicleOffer[MAX_PLAYERS];
new VehicleId[MAX_PLAYERS];
new VehiclePrice[MAX_PLAYERS];
new HouseOffer[MAX_PLAYERS];
new WsOffer[MAX_PLAYERS];
new GSOffer[MAX_PLAYERS];
new FarmOffer[MAX_PLAYERS];
new FriskOffer[MAX_PLAYERS];
new InspectOffer[MAX_PLAYERS];
new House[MAX_PLAYERS];
new HousePrice[MAX_PLAYERS];
new WsPrice[MAX_PLAYERS];
new farmPrice[MAX_PLAYERS];
new gsPrice[MAX_PLAYERS];
new JailPrice[MAX_PLAYERS];
new WantedPoints[MAX_PLAYERS];
new OnDuty[MAX_PLAYERS];
new gPlayerCheckpointStatus[MAX_PLAYERS];
new gPlayerLogged[MAX_PLAYERS char];
new gPlayerLogTries[MAX_PLAYERS];
new gPlayerSpawned[MAX_PLAYERS];
new gActivePlayers[MAX_PLAYERS];
new gLastCar[MAX_PLAYERS];
new gOoc[MAX_PLAYERS];
/* Spray system*/
new warna2[MAX_PLAYERS], warna1[MAX_PLAYERS];

new idveh[MAX_PLAYERS]; //Var for vehicle for mechanic service
new idveh2[MAX_PLAYERS];
/*new Stretcher[MAX_PLAYERS] = 0;
new UsingStretcher[MAX_PLAYERS] = 0;*/
new gNews[MAX_PLAYERS];
new gNewbie[MAX_PLAYERS];
new gHelp[MAX_PLAYERS];
new gFam[MAX_PLAYERS];
new BigEar[MAX_PLAYERS];
new Spectate[MAX_PLAYERS];
new GettingSpectated[MAX_PLAYERS];
new CellTime[MAX_PLAYERS];
new StartTime[MAX_PLAYERS];
new HireCar[MAX_PLAYERS];
new SafeTime[MAX_PLAYERS];
new HidePM[MAX_PLAYERS];
new PhoneOnline[MAX_PLAYERS];
new advisorchat[MAX_PLAYERS];
new JetPack[MAX_PLAYERS];
new Fixr[MAX_PLAYERS];
new MatsWarn[MAX_PLAYERS][MAX_PLAYERS];
//new TaxiWarn[MAX_PLAYERS][MAX_PLAYERS];
new CrackWarn[MAX_PLAYERS][MAX_PLAYERS];
new PotWarn[MAX_PLAYERS][MAX_PLAYERS];
new slotselection[MAX_PLAYERS];
new vslotselection[MAX_PLAYERS];
new SFPDVehicles[53];
//new Rentbike[5];
new SASDVehicles[95];
//
new SanNewsVehicles[15];
//
new EPVehicles[4];
new WPVehicles[11];
//GOVVEH
new GovVehicles[35], Crane[15], Delta[5], SecUnit[5], Guard[5], Cleaner [3], Towtruck[15];

new Locator[MAX_PLAYERS];
new Mobile[MAX_PLAYERS];
new RingTone[MAX_PLAYERS];
new CallCost[MAX_PLAYERS];
new gPlayerAccount[MAX_PLAYERS];
new gLastDriver[MAX_VEHICLES];
new LockStatus[MAX_VEHICLES];
new arr_Engine[MAX_VEHICLES char];
new arr_Towing[MAX_PLAYERS];

new noooc = 1;
new norefund = 1;
new objstore[128];
new cbjstore[128];
new GlobalMOTD[128];
new AdminMOTD[128];
new CAMOTD[128];
new ghour = 0;
new gminute = 0;
new gsecond = 0;
new numplayers = 0;
new realtime = 1;
new wtime = 15;
new deathcost = 1000;
new callcost[MAX_PLAYERS];
//new timeshift = -1;
new shifthour;
new bool:swimming[MAX_PLAYERS];
new MPSVehicles[ 15 ];
new BUS[3], BusPlate[3];
new SWEEPER[3], SWEEPERPlate[3];
//SAMD
new LSMDVehicles[ 39 ];
//SAPD
new LSPDVehicles[ 69 ];
new Cruiser[10], Lincoln[10], Kopassus[10], LincolnUngu [6], LincolnMerah [6], ZeusUnit [3], TEU [7], Chief [3];
//
new blastdoor[4];
new cage;
new entrancedoor;
new levelexp = 3;

new cchargetime = 1;
new CIV[] = {7,19,20,23,73,101,122};
new Float:TelePos[MAX_PLAYERS][6];
new lspddoor1;
new lspddoor2;
new Seatbelt[MAX_PLAYERS];
new bool:AdminReadPm[MAX_PLAYERS];

new OneSeatVehicles[38] =
{
    425, 430, 432, 441, 446, 448, 452, 453,
	454, 464, 465, 472, 473, 476, 481, 484,
	485, 486, 493, 501, 509, 510, 519, 520,
	530, 531, 532, 539, 553, 564, 568, 571,
	572, 574, 583, 592, 594, 595
};

stock PreloadAnims(playerid) {
	ApplyAnimation(playerid, "AIRPORT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "Attractors", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BAR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BASEBALL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BD_FIRE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BEACH", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "benchpress", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BF_injection", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKED", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKEH", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKELEAP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKES", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKEV", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKE_DBZ", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BMX", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BOMBER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BOX", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BSKTBALL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BUDDY", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BUS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CAMERA", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CAR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CARRY", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CAR_CHAT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CASINO", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CHAINSAW", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CHOPPA", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CLOTHES", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COACH", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COLT45", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COP_AMBIENT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COP_DVBYZ", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CRACK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CRIB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DAM_JUMP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DANCING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DEALER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DILDO", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DODGE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DOZER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DRIVEBYS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FAT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_B", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_C", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_D", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_E", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FINALE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FINALE2", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FLAME", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "Flowers", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FOOD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "Freeweights", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GANGS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GHANDS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GHETTO_DB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "goggles", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GRAFFITI", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GRAVEYARD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GRENADE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GYMNASIUM", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "HAIRCUTS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "HEIST9", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "INT_HOUSE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "INT_OFFICE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "INT_SHOP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "JST_BUISNESS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "KART", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "KISSING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "KNIFE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LAPDAN1", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LAPDAN2", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LAPDAN3", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LOWRIDER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MD_CHASE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MD_END", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MEDIC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MISC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MTB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MUSCULAR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "NEVADA", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "ON_LOOKERS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "OTB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PARACHUTE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PARK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PAULNMAC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "ped", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PLAYER_DVBYS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PLAYIDLES", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "POLICE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "POOL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "POOR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PYTHON", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "QUAD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "QUAD_DBZ", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RAPPING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RIFLE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RIOT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "ROB_BANK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RUSTLER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RYDER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SCRATCHING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SHAMAL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SHOP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SHOTGUN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SILENCED", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SKATE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SMOKING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SNIPER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SPRAYCAN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "STRIP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SUNBATHE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWAT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWEET", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWIM", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWORD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TANK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TATTOOS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TEC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TRAIN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TRUCK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "UZI", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "VAN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "VENDING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "VORTEX", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "WAYFARER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "WEAPONS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "WUZI", "null", 0.0, 0, 0, 0, 0, 0);
	return 1;
}

stock RemoveUnderScore(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,sizeof(name));
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
    {
        if(name[i] == '_') name[i] = ' ';
    }
    return name;
}

stock UpdateSANewsBroadcast()
{
    new String[42];
	if(broadcasting == 0)
	{
	    format(String, sizeof(String), "Currently: Not Broadcasting\nViewers: %d", viewers);
	}
	else
	{
	    format(String, sizeof(String), "Currently: LIVE\nViewers: %d", viewers);
	}
	UpdateDynamic3DTextLabelText(SANews3DText, COLOR_LIGHTBLUE, String);
}

stock SetPlayerHigh(playerid, toggle) // 0 = Not high, 1 = High
{
	SetPVarInt(playerid, "IsHigh", toggle);
	if(toggle)
	{
		SetPlayerWeather(playerid, -66);
		SetPlayerTime(playerid, 12, 0);
		SetPlayerDrunkLevel(playerid, 50000);
	}
	else
	{
	    new index = random(sizeof(gWeather));
	    SetPlayerWeather(playerid, gWeather[index]);
		SetPlayerTime(playerid, gTime, 0);

		SetPlayerDrunkLevel(playerid, 0);
	}
	return 1;
}
stock FindFreeAttachedObjectSlot(playerid)
{
	new index;
 	while (index < MAX_PLAYER_ATTACHED_OBJECTS && IsPlayerAttachedObjectSlotUsed(playerid, index))
	{
		index++;
	}
	if (index == MAX_PLAYER_ATTACHED_OBJECTS) return -1;
	return index;
}

enum Spikes
{
	Float:sX,
	Float:sY,
	Float:sZ,
	sObjectID,
	sDeployedBy[MAX_PLAYER_NAME],
	sDeployedAt[MAX_ZONE_NAME]
}

new SpikeStrips[10][Spikes];

enum reportinfo
{
	HasBeenUsed,
	Report[128],
	ReportFrom,
	CheckingReport,
 	TimeToExpire,
	BeingUsed,
	ReportExpireTimer,
	ReplyTimerr
}

new Reports[MAX_REPORTS][reportinfo];
new ListItemReportId[MAX_PLAYERS][40];
new CancelReport[MAX_PLAYERS];

Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

new Music[MAX_PLAYERS];
new Float:LSPDJail[3][3] = {
{1827.80004883,-1729.60,5202.79980469},
{1831.00000000,-1729.60,5202.79980469},
{1834.19995117,-1729.60,5202.79980469}
};

new Float:OOCPrisonSpawns[4][4] = {
{-27.5685,2321.0818,24.3034},
{-18.2713,2322.5923,24.3034},
{-10.9105,2328.4629,24.3034},
{-9.7925,2337.4878,24.3034}
};

enum EventKernelEnum
{
    EventType,
	EventStatus,
	EventInfo[128],
	Float: EventHealth,
	Float: EventArmor,
	Float: EventPositionX,
	Float: EventPositionY,
	Float: EventPositionZ,
	EventInterior,
	EventWorld,
	EventWeapons[ 5 ],
	EventTeamColor[2],
    EventTeamSkin[2],
    EventLimit,
    EventPlayers,
    EventRequest,
    EventStartRequest,
    EventCreator,
    VipOnly,
    Float: EventTeamPosX1,
    Float: EventTeamPosY1,
    Float: EventTeamPosZ1,
    Float: EventTeamPosX2,
    Float: EventTeamPosY2,
    Float: EventTeamPosZ2
}

new EventKernel[ EventKernelEnum ];

enum MainZone
{
	Zone_Name[28],
	Float:Zone_Area[6]
};

static const SanAndreasZones[][MainZone] = {

	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial",         {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"Four Dragons Casino",         {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	// Citys Zones
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

enum dData
{
    DropGunAmmount[2],
    Float:DropGunPosX,
    Float:DropGunPosY,
    Float:DropGunPosZ,
    DropGunVWorld,
    DropGunInterior,
};
new DropInfo[MAX_DROP_ITEMS][dData];
new DropObject[MAX_DROP_ITEMS];
new GunObjectIDs[200] ={

   1575,  331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324, 325, 326, 342, 343, 344, -1,  -1 , -1 ,
   346, 347, 348, 349, 350, 351, 352, 353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367,
   368, 369, 1575
};

enum fInfo
{
	FamilyTaken,
	FamilyName[42],
	FamilyMOTD[65],
	FamilyColor,
	FamilyTurfTokens,
	FamilyLeader[MAX_PLAYER_NAME],
	FamilyMembers,
	Float:FamilySpawn[4],
	FamilyInterior,
	FamilyCash,
	FamilyBank,
	FamilyMats,
	FamilyPot,
	FamilyCrack,
	Float:FamilySafe[3],
	FamilyUSafe,
	FamilyRank1[20],
	FamilyRank2[20],
	FamilyRank3[20],
	FamilyRank4[20],
	FamilyRank5[20],
	FamilyRank6[20],
	FamilyPickup,
	FamilyMaxSkins,
	FamilySkins[8],
	Float: FamilyEntrance[4],
	Float: FamilyExit[4],
	FamilyEntrancePickup,
	FamilyExitPickup,
	Text3D:FamilyEntranceText,
	Text3D:FamilyExitText,
	FamilyCustomMap,
	FamilyVirtualWorld,
	FamilyResetSpawns,
	FamilyGuns[10],
	FamilyGunsAmmo[10],
};
new FamilyInfo[MAX_FAMILY][fInfo];

enum fvInfo
{
    fvId,
	fvModelId,
	Float: fvSpawnx,
	Float: fvSpawny,
	Float: fvSpawnz,
	Float: fvSpawna,
	Float: fvSpawnxtmp,
	Float: fvSpawnytmp,
	Float: fvSpawnztmp,
	Float: fvSpawnatmp,
	fvLock,
	fvLocked,
	fvPaintJob,
	fvColor1,
	fvColor2,
	fvMods[MAX_MODS],
	fvPrice,
	fvImpounded,
	Float: fvFuel,
};

new FamilyVehicleInfo[MAX_FAMILY][MAX_GANG_VEHICLES][fvInfo];

enum pSpec
{
	Float:Coords[3],
	Float:sPx,
	Float:sPy,
	Float:sPz,
	sVW,
	sPint,
	sLocal,
	sCam,
};

new Unspec[MAX_PLAYERS][pSpec];

enum eCars
{
	model_id,
	Float:pos_x,
	Float:pos_y,
	Float:pos_z,
	Float:z_angle,
};

enum hNews
{
	hTaken1,
	hTaken2,
	hTaken3,
	hTaken4,
	hTaken5,
	hTaken6,
	hTaken7,
	hTaken8,
	hTaken9,
	hTaken10,
	hTaken11,
	hTaken12,
	hTaken13,
	hTaken14,
	hTaken15,
	hTaken16,
	hTaken17,
	hTaken18,
	hTaken19,
	hTaken20,
	hTaken21,
	hAdd1[128],
	hAdd2[128],
	hAdd3[128],
	hAdd4[128],
	hAdd5[128],
	hAdd6[128],
	hAdd7[128],
	hAdd8[128],
	hAdd9[128],
	hAdd10[128],
	hAdd11[128],
	hAdd12[128],
	hAdd13[128],
	hAdd14[128],
	hAdd15[128],
	hAdd16[128],
	hAdd17[128],
	hAdd18[128],
	hAdd19[128],
	hAdd20[128],
	hAdd21[128],
	hContact1[128],
	hContact2[128],
	hContact3[128],
	hContact4[128],
	hContact5[128],
	hContact6[128],
	hContact7[128],
	hContact8[128],
	hContact9[128],
	hContact10[128],
	hContact11[128],
	hContact12[128],
	hContact13[128],
	hContact14[128],
	hContact15[128],
	hContact16[128],
	hContact17[128],
	hContact18[128],
	hContact19[128],
	hContact20[128],
	hContact21[128],
};
new News[hNews];

enum mInfo
{
	Float:mPosX,
	Float:mPosY,
	Float:mPosZ,
	Text3D:mText,
	mPickup
};
new Mod[MAX_MOD][mInfo];

enum bbInfo
{
	Float:bbPos[3],
	Text3D:bbText,
	bbPickup
};
new BuyPoint[MAX_BUYPOINT][bbInfo];

/////////////////////////FARM OWNERSHIP Coded by AriWiwin14////////////////////////////
enum farmInfo
{
	Text3D:FarmFixText,
	Text3D:FarmFixRep,
	FarmSafeMoney,
	Text3D:FarmRepText,
	FarmRepPickup,
	FarmName[32],
	FarmPapanMT,
	Float:FarmPosX,
	Float:FarmPosY,
	Float:FarmPosZ,
	FarmStatus,
	FarmOwner[32],
	FarmPrice,
	FarmPlant,
	Text3D:FarmText,
	Float:FarmRepX,
	Float:FarmRepY,
	Float:FarmRepZ,
	FarmPickup
};
new FarmInfo[MAX_FARM][farmInfo];

enum wsInfo
{
	wsPapan,
	wsPapanMT,
	Float:wsPapanX,
	Float:wsPapanY,
	Float:wsPapanZ,
	Float:wsPapanRotX,
	Float:wsPapanRotY,
	Float:wsPapanRotZ,
	wsPapanText[255],
	wsGateID,
	wsGate,
	Float:wsGateOX,
	Float:wsGateOY,
	Float:wsGateOZ,
	Float:wsGateCX,
	Float:wsGateCY,
	Float:wsGateCZ,
	Float:wsGateORX,
	Float:wsGateORY,
	Float:wsGateORZ,
	Float:wsGateCRX,
	Float:wsGateCRY,
	Float:wsGateCRZ,
	wsGateID2,
	wsGate2,
	Float:wsGateOX2,
	Float:wsGateOY2,
	Float:wsGateOZ2,
	Float:wsGateCX2,
	Float:wsGateCY2,
	Float:wsGateCZ2,
	Float:wsGateORX2,
	Float:wsGateORY2,
	Float:wsGateORZ2,
	Float:wsGateCRX2,
	Float:wsGateCRY2,
	Float:wsGateCRZ2,
	wsComponent,
	wsSafeMoney,
	wsName[255],
	Float:wsPosX,
	Float:wsPosY,
	Float:wsPosZ,
	wsStatus,
	wsOwner[255],
	wsPrice,
	Text3D:wsText,
	wsOwned,
	wsPickup
};
new WsInfo[MAX_WORKSHOP][wsInfo];
new wsEdit[MAX_PLAYERS]; //1=postext,2-3=gate,4-5=gate2
new wsEditID[MAX_PLAYERS];
new Float:wsPos[MAX_PLAYERS][3];
new Float:wsRot[MAX_PLAYERS][3];
new Float:wsGatePos[MAX_PLAYERS][3];
new Float:wsGateRot[MAX_PLAYERS][3];
new Float:wsGatePos2[MAX_PLAYERS][3];
new Float:wsGateRot2[MAX_PLAYERS][3];
//

enum bInfo
{
	bSegel,
	bSegelReason[255],
    bOwned,
	bOwner[255],
	bMessage[255],
	bPickupID,
	bVirWorld,
	Float:bEntranceX,
	Float:bEntranceY,
	Float:bEntranceZ,
	Float:bExitX,
	Float:bExitY,
	Float:bExitZ,
	bLevelNeeded,
	bBuyPrice,
 	bTill,
	bLocked,
	bInteriorID,
	bExteriorID,
	bInterior,
	bProducts,
	bType,
	BusinessPrice,
	BusinessPickup,
	Text3D:BusinessLabel,
	bProductPrice[12],
	bProductName1[255],
	bProductName2[255],
	bProductName3[255],
	bProductName4[255],
	bProductName5[255],
	bProductName6[255],
	bProductName7[255],
	bProductName8[255],
	bProductName9[255],
	bProductName10[255],
	bProductName11[255],
	bAlamat[255],
	Float:bPetrolX,
	Float:bPetrolY,
	Float:bPetrolZ,
	bFuelStock,
};


new BizzInfo[MAX_BUSINESSES][bInfo];

 new rotY=0;

 new wheel;//MAINWHEEL
 new gondel1,gondel2,gondel3,gondel4,gondel5,gondel6,gondel7,gondel8;//gondels

enum pInfo
{
	pTanamanAnggur,
	pTanamanBlueberry,
	pTanamanStrawberry,
	pTanamanGandum,
	pTanamanTomat,
	pBibitAnggur,
	pBibitBlueberry,
	pBibitStrawberry,
	pBibitGandum,
	pBibitTomat,
	pKartuPerdana,
	pGate,
	pPainkiller,
	pUsePainkiller,
	pSQLID,
	pAccent[80],
	pAdminOnDutyTime,
	pWS,
	pWSid,
	pFarm,
	pFarmid,
	pTruckerLic,
	pMissionsTime,
	pKTP,
	pKTime,
	pLumberLic,
	pPBiskey,
	pInBizz,
	pMask,
	pMaskID,
	pMaskUse,
	pPBiskey2,
	pPDTime,
	pHunger,
	pBladder,
	pEnergi,
	pCondition,
	pLumber,
    pCacing,
	pPancingan,
	pJerigen,
	pBensin,
	pAdminDuty,
	pKey[129],
	pSweeperT,
	pAdminban[MAX_PLAYER_NAME],
	pNormalName[MAX_PLAYER_NAME],
	pAdminName[MAX_PLAYER_NAME],
	pVIPName[MAX_PLAYER_NAME],
	pDate[7],
	pWSBos,
	pFarmBos,
	pDutyTime,
	pBanReason[128],
	pBanExpired[128],//waktu
	pBanExpired2[128],//tanggal
	pLevel,
	pAdmin,
	pDonateRank,
	pBandage,
	pConnectTime,
	pReg,
	pSex,
	pAge[128],
	pParacetamol,
	pCash,
	pHospital,
	pMuted,
	pPrisonReason[128],
	pJailedBy[MAX_PLAYER_NAME],
	pRMuted,
	pRMutedTotal,
	pRMutedTime,
	pGYMTime,
	pExp,
	pAccount,
	pCrimes,
	pPaintTeam,
	pKills,
	pDeaths,
	pArrested,
	pFitnessTimer,
	pFitnessType,
	pToggedVIPChat,
	pJob,
	pWSJob,
	pFarmJob,
	//kuli bangunan
	pUseSorry,
	pKuli,
	pAutoTextReply[64],
	pPhonePrivacy,
	pJob2,
	pIllegalJob,
	pSnack,
	pMineralWater,
	pADMute,
	pADMuteTotal,
	pHelpMute,
	pPayCheck,
	pJailed,
	pJailTime,
	pWRestricted,
	pMats,
	pPulsa2,
	pPackages,
	pLeader,
	pMember,
	pDivision,
	pFMember,
	pSpeakerPhone,
	pRank,
	pChar,
	pAmoxicilin,
	pMechSkill,
 	pWantedLevel,
	pSMats,
	pPot,
	pCrack,
	pMeth,
	pSDrugs,
	pBadgeNumber,
	pRoadblock,
	pUltrafluenza,
	pTruckingSkill,
	pArmsSkill,
	pSmugSkill,
	Float:pHealth,
	Float:pArmor,
	Float:pSArmor,
	Float:pSHealth,
	Float:pBodyCondition[6],
	pInt,
	pLocal,
	pTeam,
	pModel,
	pPnumber,
	pPhone,
	pFMax,
	pJTime,
	pLumberTime,
	pFTime,
	pHaulingTime,
	pBusTime,
	pBeratIkan,
 	pPhousekey,
	pPhousekey2,
	Float:pPos_x,
	Float:pPos_y,
	Float:pPos_z,
	Float:pPos_r,
	pCarLic,
	pCTime,
	pCarLicID,
	pFlyLic,
	pBoatLic,
	pGunLic,
	pHackWarnTime,
	pHackWarnings,
	pGuns[13],
	pGunsAmmo[13],
	pSilincedSkill,
	pDesertEagleSkill,
	pRifleSkill,
	pShotgunSkill,
	pSpassSkill,
	pMP5Skill,
	pAK47Skill,
	pM4Skill,
	pSniperSkill,
	pTrainingTime,
	pAGuns[13],
	pAGunsAmmo[13],
	pPayDay,
	pCDPlayer,
	pWins,
	pLoses,
	pTut,
	pTutorial,
	pWarns,
	pWarn1[64],
	pWarn2[64],
	pWarn3[64],
	pWarn4[64],
	pWarn5[64],
	pWarn6[64],
	pWarn7[64],
	pWarn8[64],
	pWarn9[64],
	pWarn10[64],
	pWarn11[64],
	pWarn12[64],
	pWarn13[64],
	pWarn14[64],
	pWarn15[64],
	pWarn16[64],
	pWarn17[64],
	pWarn18[64],
	pWarn19[64],
	pWarn20[64],
	pAdjustable,
	pMarried,
	pMarriedTo[128],
	pLock,
	pLockCar,
	pSprunk,
	pCigar,
	pPole,
	pSpraycan,
	pRope,
	pDice,
	pCangkul,
	pDuty,
	pFightStyle,
	pIP[32],
	pBanned,
	pPermaBanned,
	pDisabled,
	pCrates,
	pVW,
	pHouseInvite,
	pRenting,
	pTempVIP,
	pBuddyInvited,
	pVIPInviteDay,
	pVIPLeft,
	pTokens,
	pPaintTokens,
	pDrugsTime,
	pGangWarn,
	pFactionBanned,
	pCSFBanned,
	pMechTime,
	pGiftTime,
	pDutyTimeTotal,
	pTogReports,
	pRadio,
	pRadioFreq,
	pDutyHours,
	pAcceptedHelp,
	pAcceptReport,
	pTrashReport,
	pInsurance,
	pTriageTime,
	pVehicleKeys,
	pVehicleKeysFrom,
	pTicketTime,
	pScrewdriver,
	pTire,
	pFirstaid,
	pRccam,
	pReceiver,
	pGPS,
	pSweep,
	pSweepLeft,
	pBugged,
	pCheckCash,
	pChecks,
	pWarrant[128],
	pJudgeJailTime,
	pJudgeJailType,
	pBeingSentenced,
	pProbationTime,
	pCallsAccepted,
	pPatientsDelivered,
	pLiveBanned,
	pFreezeBank,
	pServiceTime,
 	BeingDraggedBy,
	pVIPJoinDate,
	pVIPExpDate[32],
	pVIPExpTime[32],
	pComponent,
	pBoomBox,
};
new PlayerInfo[MAX_PLAYERS+1][pInfo];
new gh[MAX_PLAYERS];
new musicinternet[MAX_PLAYERS];
new Float:flyPos[MAX_PLAYERS][3];
new pMancing[MAX_PLAYERS];
//new pass[MAX_PLAYERS];
new TakeBox[MAX_PLAYERS];
//new useinternet[MAX_PLAYERS]=0;

//Stock
forward usepainkillerT();
public usepainkillerT()
{
	foreach(Player, i)
	{
	    if(PlayerInfo[i][pUsePainkiller] == 1)
	    {
			PlayerInfo[i][pUsePainkiller] = 0;
			SendClientMessage(i, COLOR_ARWIN, "PAINKILLER: {FFFF00}Painkiller timer was done, you can use Painkiller again with '/usepainkiller'");
		}
	}
	return 1;

}
CarmodDialog(playerid)
{
	ShowPlayerDialog(playerid,1111,DIALOG_STYLE_LIST,"Select things to put in your car","Car Components","Select","Cancel");
	return 1;
}
Lowrider(playerid)
{
    ShowPlayerDialog(playerid,1001,DIALOG_STYLE_LIST,"Choose one","Paintjob\nChrome\nSlamin\n{FF0000}Back","Select","Cancel");
    return 1;
}
RegularCarDialog(playerid)
{
    new closestcar = GetClosestCar(playerid);
    new vehmd = GetVehicleModel(closestcar);
 	new String[1024];
	if(vehmd == 401 || vehmd == 496 || vehmd == 518 || vehmd == 540 || vehmd == 546 || vehmd == 589)
	{String = "Spoiler\nHood\nRoof\nVents\nSideskirt\nLights\n{FF0000}Back";}
	else if(vehmd == 549)
	{String = "Spoiler\nHood\nVents\nSideskirt\nLights\n{FF0000}Back";}
	else if(vehmd == 550)
	{String = "Spoiler\nHood\nRoof\nVents\nLights\n{FF0000}Back";}
	else if(vehmd == 585 || vehmd == 603)
	{String = "Spoiler\nRoof\nVents\nSideskirt\nLights\n{FF0000}Back";}
	else if(vehmd == 410 || vehmd == 436)
	{String = "Spoiler\nRoof\nSideskirt\nLights\n{FF0000}Back";}
	else if(vehmd == 439 || vehmd == 458)
	{String = "Spoiler\nVents\nSideskirt\nLights\n{FF0000}Back";}
	else if(vehmd == 551 || vehmd == 492 || vehmd == 529)
	{String = "Spoiler\nHood\nRoof\nSideskirt\n{FF0000}Back";}
	else if(vehmd == 489 || vehmd == 505)
	{String = "Spoiler\nHood\nRoof\nLights\n{FF0000}Back";}
	else if(vehmd == 516)
	{String = "Spoiler\nHood\nSideskirt\n{FF0000}Back";}
	else if(vehmd == 491 || vehmd == 517)
	{String = "Spoiler\nVents\nSideskirt\n{FF0000}Back";}
	else if(vehmd == 418 || vehmd == 527 || vehmd == 580)
	{String = "Spoiler\nRoof\nSideskirt\n{FF0000}Back";}
	else if(vehmd == 420 || vehmd == 587)
	{String = "Spoiler\nHood\n{FF0000}Back";}
	else if(vehmd == 547)
	{String = "Spoiler\nVents\n{FF0000}Back";}
	else if(vehmd == 415)
	{String = "Spoiler\nSideskirt\n{FF0000}Back";}

    ShowPlayerDialog(playerid,1004,DIALOG_STYLE_LIST,"Choose one",String,"Select","Cancel");
    return 1;
}
Mod0(playerid)//Alien
{
    ShowPlayerDialog(playerid,1511,DIALOG_STYLE_LIST,"Choose one","Right Sideskirt\nLeft Sideskirt\nExhaust\nRoof\nSpoiler\nFront Bumper\nRear Bumper\n{FF0000}Back","Select","Cancle");
    return 1;
}
Mod1(playerid)//X-Flow
{
	ShowPlayerDialog(playerid,1512,DIALOG_STYLE_LIST,"Choose one","Right Sideskirt\nLeft Sideskirt\nExhaust\nRoof\nSpoiler\nFront Bumper\nRear Bumper\n{FF0000}Back","Select","Cancle");
	return 1;
}
Mod2(playerid)//Chrome
{
    new closestcar = GetClosestCar(playerid);
    new vehmd = GetVehicleModel(closestcar);
    new String[1024];
	if(vehmd == 576 || vehmd == 575)
	{String = "Right Sideskirt\nLeft Sideskirt\nExhaust\nFront Bumper\nRear Bumper\n{FF0000}Back";}
	else if(vehmd == 535)
	{String = "Front Bullbars\nRear Bullbars\nExhaust\nFront Bumper\nRight Sideskirt\nLeft Sideskirt\n{FF0000}Back";}
	else if(vehmd == 567 || vehmd == 536)
	{String = "Exhaust\nRight Sideskirt\nLeft Sideskirt\nRear Bumper\nFront Bumper\n{FF0000}Back";}
	else if(vehmd == 534)
	{String = "Grill\nBars\nLights\nExhaust\nFront Bumper\nRear Bumper\n{FF0000}Back";}

    ShowPlayerDialog(playerid,1513,DIALOG_STYLE_LIST,"Choose one",String,"Select","Cancle");
	return 1;
}
Mod3(playerid)//Slamin
{
    new closestcar = GetClosestCar(playerid);
    new vehmd = GetVehicleModel(closestcar);
    new String[1024];
    if(vehmd == 575 || vehmd == 576)
	{String = "Exhaust\nFront Bumper\nRear Bumper\n{FF0000}Back";}
	else if(vehmd == 535)
	{String = "Rear Bullbars\nFront Bullbars\nExhaust\nRight Sideskirt\nLeft Sidedkirt\n{FF0000}Back";}
	else if(vehmd == 567 || vehmd == 536 || vehmd == 534)
	{String = "Front Bumper\nRear Bumper\nExhaust\n{FF0000}Back";}
    ShowPlayerDialog(playerid,1514,DIALOG_STYLE_LIST,"Choose one",String,"Select","Cancle");
    return 1;
}
stock FormatMoney(Float:amount, delimiter[2]=".", comma[2]=",")
{
	#define MAX_MONEY_String 16
	new txt[MAX_MONEY_String];
	format(txt, MAX_MONEY_String, "%d", floatround(amount));
	new l = strlen(txt);
	if (amount < 0) // -
	{
		if (l > 2) strins(txt,delimiter,l-2);
		if (l > 5) strins(txt,comma,l-5);
		if (l > 8) strins(txt,comma,l-8);
	}
	else
	{//1000000
		if (l > 2) strins(txt,delimiter,l-2);
		if (l > 5) strins(txt,comma,l-5);
		if (l > 9) strins(txt,comma,l-8);
	}
//	if (l <= 2) format(txt,sizeof( szStr ),"00,%s",txt);
	return txt;
}
stock IsPlayerInRangeOfVehicle(playerid, Float: radius) {

	new
		Float:Floats[3];

	for( new i = 0; i < MAX_VEHICLES; i++ ) {
	    GetVehiclePos(i, Floats[0], Floats[1], Floats[2]);
	    if( IsPlayerInRangeOfPoint(playerid, radius, Floats[0], Floats[1], Floats[2]) ) {
		    return i;
		}
	}

	return false;
}
static GetElapsedTime(time, &hours, &minutes, &seconds)
{
    hours = 0;
    minutes = 0;
    seconds = 0;

    if (time >= 3600) //jika lebih dari 1 jam (3600 = 1 jam)
    {
        hours = (time / 3600); //pembagian waktu per jam di bagi time/3600
        time -= (hours * 3600); //pengurangan di time , ex 2 jam terpakai maka di kalikan 2 * 3600 = time-7200
    }
    while (time >= 60) //hitungan menit.
    {
        minutes++; //hitungan menit bertambah selama time masih bervalue 60.
        time -= 60; // waktu berkurang per menit hitungan 60 sec dari time.
    }
    return (seconds = time);
}
FormatText(text[])
{
	new len = strlen(text);
	if(len > 1)
	{
		for(new i = 0; i < len; i++)
		{
			if(text[i] == 92)
			{
				// New line
			    if(text[i+1] == 'n')
			    {
					text[i] = '\n';
					for(new j = i+1; j < len; j++) text[j] = text[j+1], text[j+1] = 0;
					continue;
			    }

				// Tab
			    if(text[i+1] == 't')
			    {
					text[i] = '\t';
					for(new j = i+1; j < len-1; j++) text[j] = text[j+1], text[j+1] = 0;
					continue;
			    }

				// Literal
			    if(text[i+1] == 92)
			    {
					text[i] = 92;
					for(new j = i+1; j < len-1; j++) text[j] = text[j+1], text[j+1] = 0;
			    }
			}
		}
	}
	return 1;
}
ColouredText(text[])
{
	//Credits to RyDeR`
	new
	    pos = -1,
	    string[(128 + 16)]
	;
	strmid(string, text, 0, 128, (sizeof(string) - 16));

	while((pos = strfind(string, "#", true, (pos + 1))) != -1)
	{
	    new
	        i = (pos + 1),
	        hexCount
		;
		for( ; ((string[i] != 0) && (hexCount < 6)); ++i, ++hexCount)
		{
		    if (!(('a' <= string[i] <= 'f') || ('A' <= string[i] <= 'F') || ('0' <= string[i] <= '9')))
		    {
		        break;
		    }
		}
		if ((hexCount == 6) && !(hexCount < 6))
		{
			string[pos] = '{';
			strins(string, "}", i);
		}
	}
	return string;
}
stock Float:frandom(Float:max, Float:m2 = 0.0, dp = 3)
{
    new Float:mn = m2;
    if(m2 > max) {
        mn = max,
        max = m2;
    }
    m2 = floatpower(10.0, dp);

    return floatadd(floatdiv(float(random(floatround(floatmul(floatsub(max, mn), m2)))), m2), mn);
}
stock IsPlayerInRangeOfPlayer(playerid, playerid2, Float: radius)
{

	new
		Float:Floats[3];

	GetPlayerPos(playerid2, Floats[0], Floats[1], Floats[2]);
	return IsPlayerInRangeOfPoint(playerid, radius, Floats[0], Floats[1], Floats[2]);
}
stock doesVehicleExist(vehicleid) {

    if(GetVehicleModel(vehicleid) >= 400) {
		return 1;
	}
	return 0;
}
stock GetDistancePlayerVeh(playerid, veh) {

	new
	    Float:Floats[7];

	GetPlayerPos(playerid, Floats[0], Floats[1], Floats[2]);
	GetVehiclePos(veh, Floats[3], Floats[4], Floats[5]);
	Floats[6] = floatsqroot((Floats[3]-Floats[0])*(Floats[3]-Floats[0])+(Floats[4]-Floats[1])*(Floats[4]-Floats[1])+(Floats[5]-Floats[2])*(Floats[5]-Floats[2]));

	return floatround(Floats[6]);
}
stock GetClosestVehicle(playerid, exception = INVALID_VEHICLE_ID) {
    new
		Float:Distance,
		target = -1;

    for(new v; v < MAX_VEHICLES; v++) if(doesVehicleExist(v)) {
        if(v != GetPlayerVehicleID(playerid) && v != exception && (target < 0 || Distance > GetDistancePlayerVeh(playerid, v))) {
            target = v;
            Distance = GetDistancePlayerVeh(playerid, v);
        }
    }
    return target;
}
stock isMelee(weapon){
    switch(weapon){
        case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 41, 42, 43, 44, 45, 46: {
			return 1;
	    }
	}
	return 0;
}
stock givePlayerWeapons(playerid) {
	ResetPlayerWeapons(playerid);
	for(new x; x < 13; x++){
		if (PlayerInfo[playerid][pGunsAmmo][x] <= 1 && !isMelee(PlayerInfo[playerid][pGuns][x])) { //Ammo
			//PlayerInfo[playerid][pGuns][x] = 0;
			PlayerInfo[playerid][pGunsAmmo][x] = 0;
		}
		else if(isMelee(PlayerInfo[playerid][pGuns][x]) && PlayerInfo[playerid][pGunsAmmo][x] < 1){
            givePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][x], AMMO_MELEE);
		}
		else
		{
			givePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][x], PlayerInfo[playerid][pGunsAmmo][x]);
		}
	}

	return 1;
}
stock GetNameWithUnderscore(playerid)
{
    new name[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, name, sizeof(name));
	}
	else
	{
	    name = "Disconnected/Nothing";
	}

	return name;
}
stock GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
 	GetPlayerName(playerid,name,sizeof(name));
	return name;
}
stock Text3D:CreateStreamed3DTextLabel(const String[], color, Float:posx, Float:posy, Float:posz, Float:draw_distance, virtualworld, testlos = 0)
{
	return CreateDynamic3DTextLabel(String, color, posx, posy, posz, draw_distance, INVALID_PLAYER_ID, INVALID_PLAYER_ID, testlos, virtualworld, -1, -1, 100.0);
}

//MONEYBAGS
stock CreateMoney(Float:x,Float:y,Float:z, amount) // Money
{
    for(new i = 0; i < sizeof(MoneyInfo); i++)
  	{
  	    if(MoneyInfo[i][mCreated] == 0)
  	    {
            MoneyInfo[i][mCreated]=1;
            MoneyInfo[i][mbX]=x;
            MoneyInfo[i][mbY]=y;
            MoneyInfo[i][mbZ]=z;
            MoneyInfo[i][mPickup] = CreateDynamicPickup(1550, 23, x, y, z);
			MoneyInfo[i][mAmount] = amount;
			MoneyInfo[i][mMoneybag] = 1;
			return 1;
  	    }
  	}
  	return 0;
}

stock DeleteClosestBag(playerid)
{
    for(new i = 0; i < sizeof(MoneyInfo); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 4.0, MoneyInfo[i][mbX], MoneyInfo[i][mbY], MoneyInfo[i][mbZ]))
        {
  	        if(MoneyInfo[i][mCreated] == 1)
            {
                new sendername[MAX_PLAYER_NAME];
                new String[10000];
                new location[MAX_ZONE_NAME];
                GetPlayerName(playerid, sendername, sizeof(sendername));
				GetPlayer2DZone(playerid, location, MAX_ZONE_NAME);
                format(String, sizeof(String), "WARNING: %s has destroyed a money bag in %s.", sendername, location);
                SendAdminMessage(COLOR_RED, String);
                MoneyInfo[i][mCreated]=0;
            	MoneyInfo[i][mbX]=0.0;
            	MoneyInfo[i][mbY]=0.0;
            	MoneyInfo[i][mbZ]=0.0;
            	MoneyInfo[i][mAmount] = 0;
            	MoneyInfo[i][mMoneybag] = 0;
            	DestroyDynamicPickup(MoneyInfo[i][mPickup]);
                return 1;
  	        }
  	    }
  	}
    return 0;
}

stock DeleteAllBags()
{
    for(new i = 0; i < sizeof(MoneyInfo); i++)
  	{
  	    if(MoneyInfo[i][mCreated] == 1)
  	    {
  	        MoneyInfo[i][mCreated]=0;
            MoneyInfo[i][mbX]=0.0;
            MoneyInfo[i][mbY]=0.0;
            MoneyInfo[i][mbZ]=0.0;
            MoneyInfo[i][mAmount] = 0;
            MoneyInfo[i][mMoneybag] = 0;
            DestroyDynamicPickup(MoneyInfo[i][mPickup]);
  	    }
	}
    return 0;
}
//ATM Enum Coded by AriWiwin14
enum dInfo
{
    ATMFee,
    ATMObjectID,
	Float:ATMY,
	Float:ATMX,
	Float:ATMZ,
	Float:ATMAngle,
};
new ATMInfo[MAX_ATM][dInfo];
//

enum objInfo
{
	oMT,
	objText[256],
	objCol1,
	objCol2,
	objMSize,
	objFSize,
	objBold,
	objAlig,
	obj,
	Text3D:oText,
	oModel,
	Float:oX,
	Float:oY,
	Float:oZ,
	Float:oRX,
	Float:oRY,
	Float:oRZ,
}
new ObjectInfo[MAX_COBJECTS][objInfo];

stock LoadObjects()
{
	new dinfo[11][128];
	new String[256];
	new File:file = fopen("cobjects.cfg", io_read);
	if(file)
	{
	    new idx = 1;
		while(idx < MAX_COBJECTS)
		{
		    fread(file, String);
		    split(String, dinfo, '|');
			format(ObjectInfo[idx][objText], 256, "%s", dinfo[0]);
			ObjectInfo[idx][oModel] = strval(dinfo[1]);
			ObjectInfo[idx][oMT] = strval(dinfo[2]);
			ObjectInfo[idx][oX] = floatstr(dinfo[3]);
			ObjectInfo[idx][oY] = floatstr(dinfo[4]);
			ObjectInfo[idx][oZ] = floatstr(dinfo[5]);
			ObjectInfo[idx][oRX] = floatstr(dinfo[6]);
			ObjectInfo[idx][oRY] = floatstr(dinfo[7]);
			ObjectInfo[idx][oRZ] = floatstr(dinfo[8]);
			ObjectInfo[idx][objFSize] = strval(dinfo[9]);
			ObjectInfo[idx][objMSize] = strval(dinfo[10]);
			if(ObjectInfo[idx][oModel]) // If gate exists
			{
			    if(ObjectInfo[idx][oMT] == 0)
			    {
					ObjectInfo[idx][obj] = CreateDynamicObject(ObjectInfo[idx][oModel], ObjectInfo[idx][oX], ObjectInfo[idx][oY], ObjectInfo[idx][oZ], ObjectInfo[idx][oRX], ObjectInfo[idx][oRY], ObjectInfo[idx][oRZ]);
					//O-bjectInfo[idx][oText] = CreateDynamic3DTextLabel(String, COLOR_WHITE, ObjectInfo[idx][oX], ObjectInfo[idx][oY], ObjectInfo[idx][oZ], 10);
				}
				else if(ObjectInfo[idx][oMT] == 1)
				{
					ObjectInfo[idx][obj] = CreateDynamicObject(ObjectInfo[idx][oModel], ObjectInfo[idx][oX], ObjectInfo[idx][oY], ObjectInfo[idx][oZ], ObjectInfo[idx][oRX], ObjectInfo[idx][oRY], ObjectInfo[idx][oRZ]);
					format(String, 128, "%s", ObjectInfo[idx][objText]);
					SetDynamicObjectMaterialText(ObjectInfo[idx][obj], 0, ObjectInfo[idx][objText], ObjectInfo[idx][objMSize], "Arial", ObjectInfo[idx][objFSize], 1, 0xFFFFFFFF, -16777216, 1);
					//O-bjectInfo[idx][oText] = CreateDynamic3DTextLabel(String, COLOR_WHITE, ObjectInfo[idx][oX], ObjectInfo[idx][oY], ObjectInfo[idx][oZ], 10);
				}
			}
			idx++;
	    }
	}
	print("Objects loaded successfully.");
	return 1;
}

stock SaveObj()
{
	new idx = 1, File:file;
	new String[256];
	while(idx < MAX_COBJECTS)
	{
	    format(String, sizeof(String), "%s|%d|%d|%f|%f|%f|%f|%f|%f|%i|%i\r\n",
        ObjectInfo[idx][objText],
        ObjectInfo[idx][oModel],
        ObjectInfo[idx][oMT],
        ObjectInfo[idx][oX],
        ObjectInfo[idx][oY],
        ObjectInfo[idx][oZ],
        ObjectInfo[idx][oRX],
        ObjectInfo[idx][oRY],
        ObjectInfo[idx][oRZ],
        ObjectInfo[idx][objFSize],
        ObjectInfo[idx][objMSize]);
        if(idx == 1)
	    {
	        file = fopen("cobjects.cfg", io_write);
	    }
	    else
	    {
	    	file = fopen("cobjects.cfg", io_append);
	    }
		fwrite(file, String);
		fclose(file);
		idx++;
	}
	print("Objects saved successfully.");
	return 1;
}
main()
{
}
stock CheckFiles()
{
	if(!dini_Exists("dealerships.cfg")) dini_Create("dealerships.cfg");
	if(!dini_Exists("cobjects.cfg")) dini_Create("cobjects.cfg");
	if(!dini_Exists("gates.cfg")) dini_Create("gates.cfg");
	if(!dini_Exists("rent.cfg")) dini_Create("rent.cfg");
	if(!dini_Exists("modshop.cfg")) dini_Create("modshop.cfg");
	if(!dini_Exists("ban.cfg")) dini_Create("ban.cfg");
	if(!dini_Exists("plants.cfg")) dini_Create("plants.cfg");
	if(!dini_Exists("machine.cfg")) dini_Create("machine.cfg");
	if(!dini_Exists("buypoint.cfg")) dini_Create("buypoint.cfg");
	return 1;
}

enum prInfo
{
 	prTax,
	prRentTime,
	prVehicleRent,
	prId,
	prModelId,
	prLock,
	prLocked,
	prColor1,
	prColor2,
	Float:prPosX,
	Float:prPosY,
	Float:prPosZ,
	Float:prPosAngle,
	prPark,
	prTicket,
	prFuel,
	Float: prHealth,
	prStatus[4]
};
new PlayerRentInfo[MAX_PLAYERS+1][prInfo];

new pRent[MAX_PLAYERS];
new RentFaggio[MAX_PLAYERS];
new prSpawn[MAX_PLAYERS];
new prSpawnID[MAX_PLAYERS];

enum pvInfo
{
	pvNeon,
	pvNeonObj,
	pvNeonObj2,
	pvNeonObj3,
	pvNeonObj4,
	pvToy[MAX_OBJECTS_PER_PLAYER],
	pvToyID[MAX_OBJECTS_PER_PLAYER],
	Float:pvToyPosX[MAX_OBJECTS_PER_PLAYER],
	Float:pvToyPosY[MAX_OBJECTS_PER_PLAYER],
	Float:pvToyPosZ[MAX_OBJECTS_PER_PLAYER],
	Float:pvToyRotX[MAX_OBJECTS_PER_PLAYER],
	Float:pvToyRotY[MAX_OBJECTS_PER_PLAYER],
	Float:pvToyRotZ[MAX_OBJECTS_PER_PLAYER],
	pvToyColor[MAX_OBJECTS_PER_PLAYER],
	pvToyIndex[MAX_OBJECTS_PER_PLAYER],
	pvToyTexture1[MAX_OBJECTS_PER_PLAYER],
	pvToyTexture2[MAX_OBJECTS_PER_PLAYER],
	pvToyTextureID[MAX_OBJECTS_PER_PLAYER],
	pvToyTextID1,
	pvToyTextID2,
	pvToyTextID3,
	pvToyTextID4,
	pvToyTextID5,
	pvToyTextID6,
	pvToyTextID7,
	pvToyTextID8,
	pvToyTextID9,
	pvToyTextID10,
	pvToyText1[128],
	pvToyText2[128],
	pvToyText3[128],
	pvToyText4[128],
	pvToyText5[128],
	pvToyText6[128],
	pvToyText7[128],
	pvToyText8[128],
	pvToyText9[128],
	pvToyText10[128],
	pvToyTextCol1,
	pvToyTextCol2,
	pvToyTextCol3,
	pvToyTextCol4,
	pvToyTextCol5,
	pvToyTextCol6,
	pvToyTextCol7,
	pvToyTextCol8,
	pvToyTextCol9,
	pvToyTextCol10,
	pvToyTextSize1,
	pvToyTextSize2,
	pvToyTextSize3,
	pvToyTextSize4,
	pvToyTextSize5,
	pvToyTextSize6,
	pvToyTextSize7,
	pvToyTextSize8,
	pvToyTextSize9,
	pvToyTextSize10,
    Float:pvPosX,
	Float:pvPosY,
	Float:pvPosZ,
 	Float:pvPosAngle,
	pvId,
	pvModelId,
	pvLock,
	pvLocked,
	pvPaintJob,
	pvColor1,
	pvColor2,
	pvMods[MAX_MODS],
	pvAllowPlayer[MAX_PLAYER_NAME],
	pvAllowedPlayerId,
	pvPark,
	pvNumberPlate[32], // sz //Plate
	pvPrice,
	pvTicket,
	pvWeapons[3],
	pvWeaponsAmmo[3],
	pvWepUpgrade,
	pvImpounded,
	pvStored,
	pvDestroyed,
	Float: pvFuel,
	Float: pvHealth,
	pvStatus[4],
	pvLicense,
	pvLicenseTime,
	pvLicenseExpired[32],
	pvMesinUpgrade,
	pvBodyUpgrade,
	pvInsurances
};
new PlayerVehicleInfo[MAX_PLAYERS+1][MAX_PLAYERVEHICLES][pvInfo];

new pvEdit[MAX_PLAYERS];
new pvEditID[MAX_PLAYERS];
new pvehEditID[MAX_PLAYERS];
new Float:pvPos[MAX_PLAYERS][3];
new Float:pvRot[MAX_PLAYERS][3];

enum ObjMat
{
	textureid,
	texturename1[32],
	texturename2[32]
};

new ObjMats[11][ObjMat] = {
{1171, "Jester", "wall6"},
{18955, "matclothes", "bandanazigzag"},
{18955, "matclothes", "bandanacloth1"},
{18955, "matclothes", "bandanacloth2"},
{18955, "matclothes", "bandanacloth3"},
{18955, "matclothes", "bandanacloth4"},
{19056, "xmasboxes", "wrappingpaper1"},
{19056, "xmasboxes", "wrappingpaper16"},
{19056, "xmasboxes", "wrappingpaper20"},
{18955, "matclothes", "bandanaredish"},
{18955, "matclothes", "mp_bobbie_pompom2"}
};

enum VehText
{
	textname[32]
};

new VehicleText[153][VehText] = {
{"Gabriola"},
{"Algerian"},
{"Arial"},
{"Arial Black"},
{"Arial Narrow"},
{"Arial Rounded MT Bold"},
{"Arial Unicode MS"},
{"Baskerville Old Face"},
{"Batang"},
{"BatangChe"},
{"Bauhaus 93"},
{"Bell MT"},
{"Berlin Sans FB"},
{"Berlin Sans FB Demi"},
{"Bernard MT Condensed"},
{"Blackadder ITC"},
{"Bodoni MT"},
{"Bodoni MT Black"},
{"Bodoni MT Condensed"},
{"Bodoni MT Poster Compressed"},
{"Book Antiqua"},
{"Bookman Old Style"},
{"Britannic Bold"},
{"Broadway"},
{"Brush Script MT"},
{"Calibri"},
{"Californian FB"},
{"Calisto MT"},
{"Cambria"},
{"Candara"},
{"Castellar"},
{"Centaur"},
{"Century"},
{"Century Gothic"},
{"Century Schoolbook"},
{"Chiller"},
{"Comic Sans MS"},
{"Consolas"},
{"Constantia"},
{"Cooper Black"},
{"Copperplate Gothic Bold"},
{"Copperplate Gothic Light"},
{"Corbel"},
{"Courier"},
{"Courier New"},
{"Curlz MT"},
{"DigifaceWide"},
{"Dotum"},
{"DotumChe"},
{"Edwardian Script ITC"},
{"Elephant"},
{"Engravers MT"},
{"Eras Bold ITC"},
{"Eras Demi ITC"},
{"Eras Light ITC"},
{"Eras Medium ITC"},
{"Estrangelo Edessa"},
{"Felix Titling"},
{"Fixedsys"},
{"Footlight MT Light"},
{"Forte"},
{"Franklin Gothic Book"},
{"Franklin Gothic Demi"},
{"Franklin Gothic Demi Cond"},
{"Franklin Gothic Heavy"},
{"Franklin Gothic Medium"},
{"Franklin Gothic Medium Cond"},
{"Freestyle Script"},
{"French Script MT"},
{"Agency FB"},
{"Garamond"},
{"Georgia"},
{"Gigi"},
{"Gill Sans MT"},
{"Gill Sans MT Condensed"},
{"Gill Sans Ultra Bold"},
{"Gill Sans Ultra Bold Condensed"},
{"Goudy Old Style"},
{"Gulim"},
{"GulimChe"},
{"Gungsuh"},
{"GungsuhChe"},
{"Haettenschweiler"},
{"Harlow Solid Italic"},
{"Harrington"},
{"High Tower Text"},
{"Impact"},
{"Imprint MT Shadow"},
{"Informal Roman"},
{"Jokerman"},
{"Kristen ITC"},
{"Kunstler Script"},
{"Lucida Bright"},
{"Lucida Calligraphy"},
{"Lucida Console"},
{"Lucida Fax"},
{"Lucida Handwriting"},
{"Lucida Sans"},
{"Lucida Sans Typewriter"},
{"Lucida Sans Unicode"},
{"Magneto"},
{"Maiandra GD"},
{"Matura MT Script Capitals"},
{"Meiryo"},
{"Microsoft Sans Serif"},
{"MingLiU"},
{"Mistral"},
{"Modern No. 20"},
{"Monotype Corsiva"},
{"MS Gothic"},
{"MS Mincho"},
{"MS PGothic"},
{"MS PMincho"},
{"MS Reference Sans Serif"},
{"MS Sans Serif"},
{"MS Serif"},
{"MS UI Gothic"},
{"MV Boli"},
{"Niagara Engraved"},
{"Niagara Solid"},
{"NSimSun"},
{"OCR A Extended"},
{"Old English Text MT"},
{"Onyx"},
{"Palace Script MT"},
{"Palatino Linotype"},
{"Papyrus"},
{"Perpetua"},
{"Perpetua Titling MT"},
{"PMingLiU"},
{"Poor Richard"},
{"Pristina"},
{"Ravie"},
{"Rockwell"},
{"Rockwell Condensed"},
{"Rockwell Extra Bold"},
{"Script MT Bold"},
{"Segoe UI"},
{"Showcard Gothic"},
{"Snap ITC"},
{"Stencil"},
{"Sylfaen"},
{"System"},
{"Tahoma"},
{"Tempus Sans ITC"},
{"Times New Roman"},
{"Trebuchet MS"},
{"Tw Cen MT Condensed Extra Bold"},
{"Verdana"},
{"Viner Hand ITC"},
{"Vivaldi"},
{"Vladimir Script"},
{"Wide Latin"}
};

new VehicleColors[256] = {
// The existing colours from San Andreas
0xFF000000, 0xFFF5F5F5, 0xFF2A77A1, 0xFF840410, 0xFF263739, 0xFF86446E, 0xFFD78E10, 0xFF4C75B7, 0xFFBDBEC6, 0xFF5E7072,
0xFF46597A, 0xFF656A79, 0xFF5D7E8D, 0xFF58595A, 0xFFD6DAD6, 0xFF9CA1A3, 0xFF335F3F, 0xFF730E1A, 0xFF7B0A2A, 0xFF9F9D94,
0xFF3B4E78, 0xFF732E3E, 0xFF691E3B, 0xFF96918C, 0xFF515459, 0xFF3F3E45, 0xFFA5A9A7, 0xFF635C5A, 0xFF3D4A68, 0xFF979592,
0xFF421F21, 0xFF5F272B, 0xFF8494AB, 0xFF767B7C, 0xFF646464, 0xFF5A5752, 0xFF252527, 0xFF2D3A35, 0xFF93A396, 0xFF6D7A88,
0xFF221918, 0xFF6F675F, 0xFF7C1C2A, 0xFF5F0A15, 0xFF193826, 0xFF5D1B20, 0xFF9D9872, 0xFF7A7560, 0xFF989586, 0xFFADB0B0,
0xFF848988, 0xFF304F45, 0xFF4D6268, 0xFF162248, 0xFF272F4B, 0xFF7D6256, 0xFF9EA4AB, 0xFF9C8D71, 0xFF6D1822, 0xFF4E6881,
0xFF9C9C98, 0xFF917347, 0xFF661C26, 0xFF949D9F, 0xFFA4A7A5, 0xFF8E8C46, 0xFF341A1E, 0xFF6A7A8C, 0xFFAAAD8E, 0xFFAB988F,
0xFF851F2E, 0xFF6F8297, 0xFF585853, 0xFF9AA790, 0xFF601A23, 0xFF20202C, 0xFFA4A096, 0xFFAA9D84, 0xFF78222B, 0xFF0E316D,
0xFF722A3F, 0xFF7B715E, 0xFF741D28, 0xFF1E2E32, 0xFF4D322F, 0xFF7C1B44, 0xFF2E5B20, 0xFF395A83, 0xFF6D2837, 0xFFA7A28F,
0xFFAFB1B1, 0xFF364155, 0xFF6D6C6E, 0xFF0F6A89, 0xFF204B6B, 0xFF2B3E57, 0xFF9B9F9D, 0xFF6C8495, 0xFF4D8495, 0xFFAE9B7F,
0xFF406C8F, 0xFF1F253B, 0xFFAB9276, 0xFF134573, 0xFF96816C, 0xFF64686A, 0xFF105082, 0xFFA19983, 0xFF385694, 0xFF525661,
0xFF7F6956, 0xFF8C929A, 0xFF596E87, 0xFF473532, 0xFF44624F, 0xFF730A27, 0xFF223457, 0xFF640D1B, 0xFFA3ADC6, 0xFF695853,
0xFF9B8B80, 0xFF620B1C, 0xFF5B5D5E, 0xFF624428, 0xFF731827, 0xFF1B376D, 0xFFEC6AAE, 0xFF000000,
// SA-MP extended colours (0.3x)
0xFF177517, 0xFF210606, 0xFF125478, 0xFF452A0D, 0xFF571E1E, 0xFF010701, 0xFF25225A, 0xFF2C89AA, 0xFF8A4DBD, 0xFF35963A,
0xFFB7B7B7, 0xFF464C8D, 0xFF84888C, 0xFF817867, 0xFF817A26, 0xFF6A506F, 0xFF583E6F, 0xFF8CB972, 0xFF824F78, 0xFF6D276A,
0xFF1E1D13, 0xFF1E1306, 0xFF1F2518, 0xFF2C4531, 0xFF1E4C99, 0xFF2E5F43, 0xFF1E9948, 0xFF1E9999, 0xFF999976, 0xFF7C8499,
0xFF992E1E, 0xFF2C1E08, 0xFF142407, 0xFF993E4D, 0xFF1E4C99, 0xFF198181, 0xFF1A292A, 0xFF16616F, 0xFF1B6687, 0xFF6C3F99,
0xFF481A0E, 0xFF7A7399, 0xFF746D99, 0xFF53387E, 0xFF222407, 0xFF3E190C, 0xFF46210E, 0xFF991E1E, 0xFF8D4C8D, 0xFF805B80,
0xFF7B3E7E, 0xFF3C1737, 0xFF733517, 0xFF781818, 0xFF83341A, 0xFF8E2F1C, 0xFF7E3E53, 0xFF7C6D7C, 0xFF020C02, 0xFF072407,
0xFF163012, 0xFF16301B, 0xFF642B4F, 0xFF368452, 0xFF999590, 0xFF818D96, 0xFF99991E, 0xFF7F994C, 0xFF839292, 0xFF788222,
0xFF2B3C99, 0xFF3A3A0B, 0xFF8A794E, 0xFF0E1F49, 0xFF15371C, 0xFF15273A, 0xFF375775, 0xFF060820, 0xFF071326, 0xFF20394B,
0xFF2C5089, 0xFF15426C, 0xFF103250, 0xFF241663, 0xFF692015, 0xFF8C8D94, 0xFF516013, 0xFF090F02, 0xFF8C573A, 0xFF52888E,
0xFF995C52, 0xFF99581E, 0xFF993A63, 0xFF998F4E, 0xFF99311E, 0xFF0D1842, 0xFF521E1E, 0xFF42420D, 0xFF4C991E, 0xFF082A1D,
0xFF96821D, 0xFF197F19, 0xFF3B141F, 0xFF745217, 0xFF893F8D, 0xFF7E1A6C, 0xFF0B370B, 0xFF27450D, 0xFF071F24, 0xFF784573,
0xFF8A653A, 0xFF732617, 0xFF319490, 0xFF56941D, 0xFF59163D, 0xFF1B8A2F, 0xFF38160B, 0xFF041804, 0xFF355D8E, 0xFF2E3F5B,
0xFF561A28, 0xFF4E0E27, 0xFF706C67, 0xFF3B3E42, 0xFF2E2D33, 0xFF7B7E7D, 0xFF4A4442, 0xFF28344E
};

enum ptInfo
{
    ptModelID,
	ptBone,
    Float:ptPosX,
	Float:ptPosY,
	Float:ptPosZ,
	Float:ptRotX,
	Float:ptRotY,
	Float:ptRotZ,
	Float:ptScaX,
	Float:ptScaY,
	Float:ptScaZ,
};
new PlayerToyInfo[MAX_PLAYERS+1][MAX_PLAYERTOYS][ptInfo];
/*enum cdInfo
{
	cdOwned,
	cdOwner[MAX_PLAYER_NAME],
	Float: cdEntranceX,
	Float: cdEntranceY,
	Float: cdEntranceZ,
	Float: cdExitX,
	Float: cdExitY,
	Float: cdExitZ,
	cdMessage[128],
	cdTill,
	cdInterior,
	Float: cdRadius,
	cdPrice,
	cdPickupID,
	Text3D:cdTextLabel,
	Text3D:cdVehicleLabel[MAX_DEALERSHIPVEHICLES],
	cdVehicleModel[MAX_DEALERSHIPVEHICLES],
	cdVehicleCost[MAX_DEALERSHIPVEHICLES],
	cdVehicleId[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnX[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnY[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnZ[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnAngle[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawn[4],
};
new CarDealershipInfo[MAX_CARDEALERSHIPS][cdInfo];*/
//DEALER
enum cdInfo
{
	cdOwned,
	cdOwner[MAX_PLAYER_NAME],
	Float: cdEntranceX,
	Float: cdEntranceY,
	Float: cdEntranceZ,
	Float: cdExitX,
	Float: cdExitY,
	Float: cdExitZ,
	cdMessage[128],
	cdTill,
	cdInterior,
	Float: cdRadius,
	cdPrice,
	cdType,
	cdPickupID,
	Text3D:cdTextLabel,
	Text3D:cdVehicleLabel[MAX_DEALERSHIPVEHICLES],
	cdVehicleModel[MAX_DEALERSHIPVEHICLES],
	cdVehicleCost[MAX_DEALERSHIPVEHICLES],
	cdVehicleId[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnX[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnY[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnZ[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawnAngle[MAX_DEALERSHIPVEHICLES],
	Float: cdVehicleSpawn[4],
};
new CarDealershipInfo[MAX_CARDEALERSHIPS][cdInfo];
enum hInfo
{
	hOwned,
	hLevel,
	hHInteriorWorld,
	hCustomInterior,
	hDescription[128],
	hOwner[ MAX_PLAYER_NAME ],
	Float: hExteriorX,
	Float: hExteriorY,
	Float: hExteriorZ,
	Float: hExteriorR,
	Float: hExteriorA,
	Float: hInteriorX,
	Float: hInteriorY,
	Float: hInteriorZ,
	Float: hInteriorR,
	Float: hInteriorA,
	Float: hGaragePos[3],
	hLock,
	hValue,
	hSafeMoney,
	hPot,
	hCrack,
	hMaterials,
	hWeapons[ 5 ],
	hWeaponsAmmo[ 5 ],
	hGLUpgrade,
	hPickupID,
	Text3D: hTextID,
	hCustomExterior,
	hAlamat[128]
};
new HouseInfo[MAX_HOUSES][hInfo];

enum dmpInfo
{
	dmpMapIconID,
	Float: dmpPosX,
	Float: dmpPosY,
	Float: dmpPosZ,
	dmpMarkerType,
	dmpColor,
	dmpVW,
	dmpInt,
}
new DMPInfo[MAX_DMAPICONS][dmpInfo];

enum ddInfo
{
	ddDescription[128],
	ddPickupID,
	Text3D: ddTextID,
	ddCustomInterior,
	ddExteriorVW,
	ddExteriorInt,
	ddInteriorVW,
	ddInteriorInt,
	Float: ddExteriorX,
	Float: ddExteriorY,
	Float: ddExteriorZ,
	Float: ddExteriorA,
	Float: ddInteriorX,
	Float: ddInteriorY,
	Float: ddInteriorZ,
	Float: ddInteriorA,
	ddCustomExterior,
	ddVIP,
	ddFamily,
	ddFaction,
	ddAdmin,
	ddWanted,
	ddVehicleAble,
	ddColor,
	ddPickupModel,
	dPass[24],
	dLocked,
	dCP,
};
new DDoorsInfo[MAX_DDOORS][ddInfo];

new gEdit[MAX_PLAYERS]; // 1 = closed | 2 = opened
new gEditID[MAX_PLAYERS]; // Object's ID
new Float:gPos[MAX_PLAYERS][3];
new Float:gRot[MAX_PLAYERS][3];
enum gateInfo
{
    gMT,
	gText[256],
	gCol1,
	gCol2,
	gMSize,
	gFSize,
	gBold,
	gAlig,
	gGate,
	gModel,
	Float:gCX,
	Float:gCY,
	Float:gCZ,
	Float:gCRX,
	Float:gCRY,
	Float:gCRZ,
	Float:gOX,
	Float:gOY,
	Float:gOZ,
	Float:gORX,
	Float:gORY,
	Float:gORZ,
	gPassword[256],
	Float:gSpeed,
	Float:gRange,
	gFaction,
	gWorkshop,
	gHID,
	gVW,
	gInt,
	gStatus,
	gOwner
}
new GateInfo[MAX_GATES][gateInfo];

enum pCrime
{
	pBplayer[32],
	pAccusing[32],
	pAccusedof[32],
	pVictim[32],
};
new PlayerCrime[MAX_PLAYERS][pCrime];

static const VehicleName[212][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Perennial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch",
	"Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi",
	"Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee","Predator",
	"Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo","RC Bandit", "Romero",
	"Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder","Reefer","Tropic","Flatbed",
	"Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler",
	"ZR-350","Walton","Regina","Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper",
	"Rancher","FBI Rancher","Virgo","Greenwood","Jetmax","Hotring Racer","Sandking","Blista Compact","Police Maverick",
	"Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B","Bloodring Banger","Rancher","Super GT",
	"Elegant","Journey","Bike","Mountain Bike","Beagle","Cropduster","Stuntplane","Tanker","Road Train","Nebula","Majestic",
	"Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV-1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent",
	"Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility",
	"Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger",
	"Flash","Tahoma","Savanna","Bandito","Freight","Trailer","Kart","Mower","Duneride","Sweeper","Broadway",
	"Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer","Emperor","Wayfarer",
	"Euros","Hotdog","Club","Trailer","Trailer","Andromada","Dodo","RCCam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A",
	"Luggage Trailer B","Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};

new Peds[217][1] = {
{299},
{288},//TEAM_ADMIN
{286},{287},{228},{113},{120},{147},{294},{227},{61},{171},
{247},//CIVILIANS DOWN HERE
{248},{100},{256},{263},{262},{261},{260},{259},{258},{257},{256},{255},
{253},{252},{251},{249},{246},{245},{244},{243},{242},{241},{240},{239},
{238},{237},{236},{235},{234},{233},{232},{231},{230},{229},
{226},{225},{173},{174},{175},{224},{223},{222},{221},{220},{219},{218},
{217},{216},{215},{214},{213},{212},{211},{210},{209},
{207},{206},{205},{204},{203},{202},{201},{200},{199},{198},{197},{196},
{195},{194},{193},{192},{191},{190},{189},{185},{184},{183},
{182},{181},{180},{179},{178},{176},{172},{170},{168},{167},{162},
{161},{160},{159},{158},{157},{156},{155},{154},{153},{152},{151},
{146},{145},{144},{143},{142},{141},{140},{139},{138},{137},{136},{135},
{134},{133},{132},{131},{130},{129},{128},{254},{99},{97},{96},{95},{94},
{92},{90},{89},{88},{87},{85},{84},{83},{82},{81},{80},{79},{78},{77},{76},
{75},{73},{72},{69},{68},{67},{66},{64},{63},{62},{58},{57},{56},{55},
{54},{53},{52},{51},{50},{49},{45},{44},{43},{41},{39},{38},{37},{36},{35},
{34},{33},{32},{31},{30},{29},{28},{27},{26},{25},{24},{23},{22},{21},{20},
{19},{18},{17},{16},{15},{14},{13},{12},{11},{10},{1},{2},
{290},//ROSE
{291},//PAUL
{292},//CESAR
{293},//OGLOC
{187},
{296},//JIZZY
{297},//MADDOGG
{298},//CAT
{299}//ZERO
};

enum HoldingVToysEnumAll
{
	holdingmodelid,
	holdingprice,
	holdingmodelname[45]
}

new HoldingVToysAll[128][HoldingVToysEnumAll] = {
{19314,50000,"BullHorns"},
{1100,50000,"Tengkorak"},
{1013,50000,"Lamp Round"},
{1024,50000,"Lamp Square"},
{1028,50000,"Exhaust Alien-1"},
{1032,50000,"Vent Alien-1"},
{1033,50000,"Vent X-Flow-1"},
{1034,50000,"Exhaust Alien-2"},
{1035,50000,"Vent Alien-2"},
{1038,50000,"Vent X-Flow-2"},
{1099,50000,"BullBars-1 Left"},
{1042,50000,"BullBars-1 Right"},
{1046,50000,"Exhaust Alien-2"},
{1053,50000,"Vent Alien-3"},
{1054,50000,"Vent X-Flow-3"},
{1055,50000,"Vent Alien-4"},
{1061,50000,"Vent X-Flow-4"},
{1067,50000,"Vent Alien-5"},
{1068,50000,"Vent X-Flow-5"},
{1088,50000,"Vent Alien-6"},
{1091,50000,"Vent X-Flow-6"},
{1101,50000,"BullBars Fire 1 Left"},
{1106,50000,"BullBars Stripes 1 Left"},
{1109,50000,"BullBars Lamp"},
{1110,50000,"BullBars Lamp Small"},
{1111,50000,"Accessories Metal 1"},
{1112,50000,"Accessories Metal 2"},
{1121,50000,"Accessories 3"},
{1122,50000,"BullBars Fire 2 Left"},
{1123,50000,"Accessories 4"},
{1124,50000,"BullBars Stripes 2 Left"},
{1125,50000,"BullBars Lamp 2"},
{1128,50000,"Hard Top"},
{1130,50000,"Medium Top"},
{1131,50000,"Soft Top"},
{18659,100000,"Vehicle Text"},
{1025,7500,"Wheels Offroad"},
{1066,7500,"Exhaust X-Flow"},
{1065,7500,"Exhaust Alien"},
{1142,7500,"Vets Left Oval"},
{1143,7500,"Vents Right Oval"},
{1144,7500,"Vents Left Square"},
{1145,7500,"Vents Right Square"},
{1171,15000,"Alien Front Bumper-1"},
{1149,15000,"Alien Rear Bumper-1"},
{1023,10000,"Spoiler Fury"},
{1172,15000,"X-Flow Front Bumper-1"},
{1148,15000,"X-Flow Rear Bumper-1"},
{1000,12500,"Pro Spoiler"},
{1001,12500,"Win Spoiler"},
{1002,12500,"Drag Spoiler"},
{1003,12500,"Alpha Spoiler"},
{1004,10000,"Champ Scoop Hood"},
{1005,10000,"Fury Scoop Hood"},
{1006,10000,"Roof Scoop"},
{1007,15000,"R-Sideskirt-TF"},
{1011,10000,"Race Scoop Hood"},
{1012,10000,"Worx Scoop Hood"},
{1014,12500,"Champ Spoiler"},
{1015,12500,"Race Spoiler"},
{1016,12500,"Worx Spoiler"},
{1017,15000,"L-Sideskirt-TF"},
{1030,15000,"L-Sideskirt-WAA-1"},
{1031,15000,"R-Sideskirt-WAA-1"},
{1036,15000,"R-Sideskirt-WAA-2"},
{1039,15000,"L-Sideskirt-WAA-3"},
{1040,15000,"L-Sideskirt-WAA-2"},
{1041,15000,"R-Sideskirt-WAA-3"},
{1047,15000,"R-Sideskirt-WAA-4"},
{1048,15000,"R-Sideskirt-WAA-5"},
{1049,13000,"Alien Spoiler-1"},
{1050,13000,"X-Flow Spoiler-1"},
{1051,15000,"L-Sideskirt-WAA-4"},
{1052,15000,"L-Sideskirt-WAA-5"},
{1056,15000,"R-Sideskirt-WAA-6"},
{1057,15000,"R-Sideskirt-WAA-7"},
{1058,13000,"Alien Spoiler-2"},
{1060,13000,"X-Flow Spoiler-2"},
{1062,15000,"L-Sideskirt-WAA-6"},
{1063,15000,"L-Sideskirt-WAA-7"},
{1116,17500,"F-Bullbars Slamin-1"},
{1115,17500,"F-Bullbars Chrome-1"},
{1138,13000,"Alien Spoiler-3"},
{1139,13000,"X-Flow Spoiler-3"},
{1140,15000,"X-Flow Rear Bumper-2"},
{1141,15000,"Alien Rear Bumper-2"},
{1146,13000,"X-Flow Spoiler-4"},
{1147,13000,"Alien Spoiler-4"},
{1148,15000,"X-Flow Rear Bumper-3"},
{1149,15000,"Alien Rear Bumper-3"},
{1150,15000,"Alien Rear Bumper-4"},
{1151,15000,"X-Flow Rear Bumper-4"},
{1152,15000,"X-Flow Front Bumper-4"},
{1153,15000,"Alien Front Bumper-4"},
{1154,15000,"Alien Rear Bumper-5"},
{1155,15000,"Alien Front Bumper-5"},
{1156,15000,"X-Flow Rear Bumper-5"},
{1157,15000,"X-Flow Front Bumper-5"},
{1158,13000,"X-Flow Spoiler-5"},
{1159,15000,"Alien Rear Bumper-6"},
{1160,15000,"Alien Front Bumper-6"},
{1161,15000,"X-Flow Rear Bumper-6"},
{1162,13000,"Alien Spoiler-5"},
{1163,13000,"X-Flow Spoiler-6"},
{1164,13000,"Alien Spoiler-6"},
{1165,15000,"X-Flow Front Bumper-7"},
{1166,15000,"Alien Front Bumper-7"},
{1167,15000,"X-Flow Rear Bumper-7"},
{1168,15000,"Alien Rear Bumper-7"},
{1169,15000,"Alien Front Bumper-2"},
{1170,15000,"X-Flow Front Bumper-2"},
{1171,15000,"Alien Front Bumper-3"},
{1172,15000,"X-Flow Front Bumper-3"},
{1173,15000,"X-Flow Front Bumper-6"},
{1174,17500,"Chrome Front Bumper-1"},
{1175,17500,"Slamin Front Bumper-1"},
{1176,17500,"Chrome Rear Bumper-1"},
{1177,17500,"Slamin Rear Bumper-1"},
{1178,17500,"Slamin Rear Bumper-2"},
{1179,17500,"Chrome Front Bumper-2"},
{1185,17500,"Slamin Front Bumper-3"},
{1188,17500,"Slamin Front Bumper-4"},
{18648,15000,"Blue Neon"},
{18647,15000,"Red Neon"},
{18649,15000,"Green Neon"},
{18652,15000,"White Neon"},
{18651,15000,"Pink Neon"},
{18650,15000,"Yellow Neon"}
};

enum HoldingEnumAll
{
	holdingmodelid,
	holdingprice,
	holdingmodelname[24]
}
new HoldingObjectsCop[13][HoldingEnumAll] = {
{18642,1000,"Taser1"},
{19141,2500,"SWATHelmet1"},
{19142,2500,"SWATArmour1"},
{18636,1000,"PoliceCap1"},
{19099,1000,"PoliceCap2"},
{19100,1000,"PoliceCap3"},
{18637,1000,"PoliceShield1"},
{19161,1000,"PoliceHat1"},
{19162,1000,"PoliceHat2"},
{19200,1000,"PoliceHelmet1"},
{19138,1000,"PoliceGlasses1"},
{19139,1000,"PoliceGlasses2"},
{19140,1000,"PoliceGlasses3"}
};

new HoldingObjectsAll[226][HoldingEnumAll] = {
{18642,1000,"Taser1"},
{18643,10000,"LaserPointer1"},
{19080,10000,"LaserPointer2"},
{19081,10000,"LaserPointer3"},
{19082,10000,"LaserPointer4"},
{19083,10000,"LaserPointer5"},
{19084,10000,"LaserPointer6"},
{19086,5000,"ChainsawDildo1"},
{18675,10000,"SmokePuff"},
{19701,10000,"SmallFlame"},
{18693,10000,"LargeFlame"},
{18698,10000,"Insects"},
{18708,10000,"Bubbles"},
{19141,2500,"SWATHelmet1"},
{19142,2500,"SWATArmour1"},
{18636,1000,"PoliceCap1"},
{19099,1000,"PoliceCap2"},
{19100,1000,"PoliceCap3"},
{18637,1000,"PoliceShield1"},
{19161,1000,"PoliceHat1"},
{19162,1000,"PoliceHat2"},
{19200,1000,"PoliceHelmet1"},
{19138,1000,"PoliceGlasses1"},
{19139,1000,"PoliceGlasses2"},
{19140,1000,"PoliceGlasses3"},
{18632,1000,"FishingRod"},
{18633,1500,"Wrench"},
{18634,1000,"Crowbar"},
{18635,1000,"Hammer"},
{18638,500,"HardHat"},
{19093,500,"HardHat2"},
{19160,500,"HardHat3"},
{18639,500,"BlackHat"},
{18640,700,"Hair"},
{18975,700,"Hair2"},
{19136,700,"Hair3"},
{19274,700,"Hair4"},
{18641,1000,"Flashlight"},
{18644,5000,"Screwdriver"},
{18865,500,"MobilePhone1"},
{18866,500,"MobilePhone2"},
{18867,500,"MobilePhone3"},
{18868,500,"MobilePhone4"},
{18869,500,"MobilePhone5"},
{18870,1000,"MobilePhone6"},
{18871,1000,"MobilePhone7"},
{18872,1000,"MobilePhone8"},
{18873,1000,"MobilePhone9"},
{18874,1000,"MobilePhone10"},
{18875,750,"Pager"},
{18890,500,"Rake"},
{18891,500,"Bandana1"},
{18892,500,"Bandana2"},
{18893,500,"Bandana3"},
{18894,500,"Bandana4"},
{18895,500,"Bandana5"},
{18896,500,"Bandana6"},
{18897,500,"Bandana7"},
{18898,500,"Bandana8"},
{18899,500,"Bandana9"},
{18900,500,"Bandana10"},
{18901,750,"Bandana11"},
{18902,750,"Bandana12"},
{18903,750,"Bandana13"},
{18904,750,"Bandana14"},
{18905,750,"Bandana15"},
{18906,750,"Bandana16"},
{18907,750,"Bandana17"},
{18908,750,"Bandana18"},
{18909,750,"Bandana19"},
{18910,750,"Bandana20"},
{18911,1000,"Mask1"},
{18912,1000,"Mask2"},
{18913,1000,"Mask3"},
{18914,1000,"Mask4"},
{18915,1000,"Mask5"},
{18916,1000,"Mask6"},
{18917,1000,"Mask7"},
{18918,1000,"Mask8"},
{18919,1000,"Mask9"},
{18920,1000,"Mask10"},
{18921,500,"Beret1"},
{18922,500,"Beret2"},
{18923,750,"Beret3"},
{18924,1000,"Beret4"},
{18925,1000,"Beret5"},
{18926,500,"Hat1"},
{18927,500,"Hat2"},
{18928,500,"Hat3"},
{18929,500,"Hat4"},
{18930,500,"Hat5"},
{18931,1000,"Hat6"},
{18932,1000,"Hat7"},
{18933,1000,"Hat8"},
{18934,1000,"Hat9"},
{18935,1000,"Hat10"},
{18936,500,"Helmet1"},
{18937,750,"Helmet2"},
{18938,1000,"Helmet3"},
{18939,750,"CapBack1"},
{18940,750,"CapBack2"},
{18941,750,"CapBack3"},
{18942,1000,"CapBack4"},
{18943,1000,"CapBack5"},
{18944,1000,"HatBoater1"},
{18945,1250,"HatBoater2"},
{18946,1500,"HatBoater3"},
{18947,1000,"HatBowler1"},
{18948,1000,"HatBowler2"},
{18949,1000,"HatBowler3"},
{18950,1000,"HatBowler4"},
{18951,1000,"HatBowler5"},
{18952,1500,"BoxingHelmet"},
{18953,500,"CapKnit1"},
{18954,750,"CapKnit2"},
{18955,750,"CapOverEye1"},
{18956,750,"CapOverEye2"},
{18957,750,"CapOverEye3"},
{18958,750,"CapOverEye4"},
{18959,750,"CapOverEye5"},
{18960,1000,"CapRimUp1"},
{18961,750,"CapTrucker1"},
{18962,750,"CowboyHat2"},
{18964,1000,"SkullyCap1"},
{18965,1250,"SkullyCap2"},
{18966,1500,"SkullyCap3"},
{18967,1000,"HatMan1"},
{18968,1000,"HatMan2"},
{18969,1000,"HatMan3"},
{18970,2000,"HatTiger"},
{18971,1000,"HatCool1"},
{18972,1250,"HatCool2"},
{18973,1500,"HatCool3"},
{18974,10000,"MaskZorro1"},
{18645,1500,"MotorcycleHelmet"},
{18976,1000,"MotorcycleHelmet2"},
{18977,1000,"MotorcycleHelmet3"},
{18978,1250,"MotorcycleHelmet4"},
{18979,1500,"MotorcycleHelmet5"},
{19006,500,"GlassesType1"},
{19007,500,"GlassesType2"},
{19008,500,"GlassesType3"},
{19009,500,"GlassesType4"},
{19010,500,"GlassesType5"},
{19011,500,"GlassesType6"},
{19012,500,"GlassesType7"},
{19013,500,"GlassesType8"},
{19014,500,"GlassesType9"},
{19015,500,"GlassesType10"},
{19016,1000,"GlassesType11"},
{19017,1000,"GlassesType12"},
{19018,1000,"GlassesType13"},
{19019,1000,"GlassesType14"},
{19020,1000,"GlassesType15"},
{19021,1000,"GlassesType16"},
{19022,1000,"GlassesType17"},
{19023,1000,"GlassesType18"},
{19024,1000,"GlassesType19"},
{19025,1000,"GlassesType20"},
{19026,1500,"GlassesType21"},
{19027,1500,"GlassesType22"},
{19028,1500,"GlassesType23"},
{19029,1500,"GlassesType24"},
{19030,1500,"GlassesType25"},
{19031,1500,"GlassesType26"},
{19032,1500,"GlassesType27"},
{19033,1500,"GlassesType28"},
{19034,1500,"GlassesType29"},
{19035,1500,"GlassesType30"},
{19036,2000,"HockeyMask1"},
{19037,2000,"HockeyMask2"},
{19038,2000,"HockeyMask3"},
{19039,500,"WatchType1"},
{19040,500,"WatchType2"},
{19041,500,"WatchType3"},
{19042,500,"WatchType4"},
{19043,500,"WatchType5"},
{19044,500,"WatchType6"},
{19045,500,"WatchType7"},
{19046,1000,"WatchType8"},
{19047,1000,"WatchType9"},
{19048,1000,"WatchType10"},
{19049,1000,"WatchType11"},
{19050,1000,"WatchType12"},
{19051,1000,"WatchType13"},
{19052,1000,"WatchType14"},
{19053,1000,"WatchType15"},
{19064,10000, "SantaHat1"},
{19065,20000, "SantaHat2"},
{19066,30000, "SantaHat3"},
{19067,1000, "HoodyHat1"},
{19068,1000, "HoodyHat2"},
{19069,1000, "HoodyHat3"},
{19078,7500, "TheParrot1"},
{19079,7500, "TheParrot2"},
{19085,5000, "EyePatch"},
{19090,1500, "PomPomBlue"},
{19091,1500, "PomPomRed"},
{19092,1500, "PomPomGreen"},
{19094,2000, "BurgerShotHat"},
{19095,500, "CowboyHat1"},
{19096,500, "CowboyHat3"},
{19097,1000, "CowboyHat4"},
{19098,1000, "CowboyHat5"},
{19101,2000, "ArmyHelmet1"},
{19102,2000, "ArmyHelmet2"},
{19103,2000, "ArmyHelmet3"},
{19104,2000, "ArmyHelmet4"},
{19105,2000, "ArmyHelmet5"},
{19106,2000, "ArmyHelmet6"},
{19107,4000, "ArmyHelmet7"},
{19108,4000, "ArmyHelmet8"},
{19109,4000, "ArmyHelmet9"},
{19110,4000, "ArmyHelmet10"},
{19111,4000, "ArmyHelmet11"},
{19112,4000, "ArmyHelmet12"},
{19113,1000, "SillyHelmet1"},
{19114,2000, "SillyHelmet2"},
{19115,3000, "SillyHelmet3"},
{19116,500, "PlainHelmet1"},
{19117,500, "PlainHelmet2"},
{19118,750, "PlainHelmet3"},
{19119,1000, "PlainHelmet4"},
{19120,1000, "PlainHelmet5"},
{19137,5000, "CluckinBellHat"},
{19163,1000, "GimpMask"}
};

enum HoldingEnum
{
	holdingmodelid,
	holdingprice,
	holdingmodelname[24]
}

new HoldingObjects[201][HoldingEnum] = {
{18632,1000,"FishingRod"},
{18633,1500,"Wrench"},
{18634,1000,"Crowbar"},
{18635,1000,"Hammer"},
{18638,1500,"HardHat"},
{19093,1500,"HardHat2"},
{19160,1500,"HardHat3"},
{18639,1500,"BlackHat"},
{18640,1000,"Hair"},
{18975,1000,"Hair2"},
{19136,1000,"Hair3"},
{19274,1000,"Hair4"},
{18641,1500,"Flashlight"},
{18644,2000,"Screwdriver"},
{18865,3000,"MobilePhone1"},
{18866,3000,"MobilePhone2"},
{18867,3000,"MobilePhone3"},
{18868,3000,"MobilePhone4"},
{18869,3000,"MobilePhone5"},
{18870,5000,"MobilePhone6"},
{18871,5000,"MobilePhone7"},
{18872,5000,"MobilePhone8"},
{18873,5000,"MobilePhone9"},
{18874,5000,"MobilePhone10"},
{18875,1500,"Pager"},
{18890,1000,"Rake"},
{18891,1000,"Bandana1"},
{18892,1000,"Bandana2"},
{18893,1000,"Bandana3"},
{18894,1000,"Bandana4"},
{18895,1000,"Bandana5"},
{18896,1000,"Bandana6"},
{18897,1000,"Bandana7"},
{18898,1000,"Bandana8"},
{18899,1000,"Bandana9"},
{18900,1000,"Bandana10"},
{18901,2000,"Bandana11"},
{18902,2000,"Bandana12"},
{18903,2000,"Bandana13"},
{18904,2000,"Bandana14"},
{18905,2000,"Bandana15"},
{18906,2000,"Bandana16"},
{18907,2000,"Bandana17"},
{18908,2000,"Bandana18"},
{18909,2000,"Bandana19"},
{18910,2000,"Bandana20"},
{18911,1000,"Mask1"},
{18912,1000,"Mask2"},
{18913,1000,"Mask3"},
{18914,1000,"Mask4"},
{18915,1000,"Mask5"},
{18916,1000,"Mask6"},
{18917,1000,"Mask7"},
{18918,1000,"Mask8"},
{18919,1000,"Mask9"},
{18920,1000,"Mask10"},
{18921,1000,"Beret1"},
{18922,1000,"Beret2"},
{18923,2000,"Beret3"},
{18924,2000,"Beret4"},
{18925,2000,"Beret5"},
{18926,1000,"Hat1"},
{18927,1000,"Hat2"},
{18928,1000,"Hat3"},
{18929,1000,"Hat4"},
{18930,1000,"Hat5"},
{18931,2000,"Hat6"},
{18932,2000,"Hat7"},
{18933,2000,"Hat8"},
{18934,2000,"Hat9"},
{18935,2000,"Hat10"},
{18936,3000,"Helmet1"},
{18937,4000,"Helmet2"},
{18938,4000,"Helmet3"},
{18939,1500,"CapBack1"},
{18940,1500,"CapBack2"},
{18941,1500,"CapBack3"},
{18942,2000,"CapBack4"},
{18943,2000,"CapBack5"},
{18944,3000,"HatBoater1"},
{18945,3000,"HatBoater2"},
{18946,3000,"HatBoater3"},
{18947,1000,"HatBowler1"},
{18948,1000,"HatBowler2"},
{18949,1000,"HatBowler3"},
{18950,1000,"HatBowler4"},
{18951,1000,"HatBowler5"},
{18952,1500,"BoxingHelmet"},
{18953,1000,"CapKnit1"},
{18954,1500,"CapKnit2"},
{18955,1500,"CapOverEye1"},
{18956,1500,"CapOverEye2"},
{18957,1500,"CapOverEye3"},
{18958,1500,"CapOverEye4"},
{18959,1500,"CapOverEye5"},
{18960,1500,"CapRimUp1"},
{18961,1500,"CapTrucker1"},
{18962,1500,"CowboyHat2"},
{18964,2000,"SkullyCap1"},
{18965,3000,"SkullyCap2"},
{18966,3000,"SkullyCap3"},
{18967,2000,"HatMan1"},
{18968,2000,"HatMan2"},
{18969,2000,"HatMan3"},
{18970,4000,"HatTiger"},
{18971,2000,"HatCool1"},
{18972,3000,"HatCool2"},
{18973,3000,"HatCool3"},
{18974,5000,"MaskZorro1"},
{18645,3000,"MotorcycleHelmet"},
{18976,4000,"MotorcycleHelmet2"},
{18977,4000,"MotorcycleHelmet3"},
{18978,5000,"MotorcycleHelmet4"},
{18979,5000,"MotorcycleHelmet5"},
{19006,1000,"GlassesType1"},
{19007,1000,"GlassesType2"},
{19008,1000,"GlassesType3"},
{19009,1000,"GlassesType4"},
{19010,1000,"GlassesType5"},
{19011,1000,"GlassesType6"},
{19012,1000,"GlassesType7"},
{19013,1000,"GlassesType8"},
{19014,1000,"GlassesType9"},
{19015,1000,"GlassesType10"},
{19016,2000,"GlassesType11"},
{19017,2000,"GlassesType12"},
{19018,2000,"GlassesType13"},
{19019,2000,"GlassesType14"},
{19020,2000,"GlassesType15"},
{19021,2000,"GlassesType16"},
{19022,2000,"GlassesType17"},
{19023,2000,"GlassesType18"},
{19024,2000,"GlassesType19"},
{19025,2000,"GlassesType20"},
{19026,2000,"GlassesType21"},
{19027,2000,"GlassesType22"},
{19028,2000,"GlassesType23"},
{19029,2000,"GlassesType24"},
{19030,2000,"GlassesType25"},
{19031,2000,"GlassesType26"},
{19032,2000,"GlassesType27"},
{19033,2000,"GlassesType28"},
{19034,2000,"GlassesType29"},
{19035,2000,"GlassesType30"},
{19036,4000,"HockeyMask1"},
{19037,4000,"HockeyMask2"},
{19038,4000,"HockeyMask3"},
{19039,1000,"WatchType1"},
{19040,100,"WatchType2"},
{19041,1000,"WatchType3"},
{19042,1000,"WatchType4"},
{19043,1000,"WatchType5"},
{19044,1000,"WatchType6"},
{19045,1000,"WatchType7"},
{19046,2000,"WatchType8"},
{19047,2000,"WatchType9"},
{19048,2000,"WatchType10"},
{19049,2000,"WatchType11"},
{19050,2000,"WatchType12"},
{19051,2000,"WatchType13"},
{19052,2000,"WatchType14"},
{19053,2000,"WatchType15"},
{19064,5000, "SantaHat1"},
{19065,5000, "SantaHat2"},
{19066,5000, "SantaHat3"},
{19067,2000, "HoodyHat1"},
{19068,2000, "HoodyHat2"},
{19069,2000, "HoodyHat3"},
{19078,5000, "TheParrot1"},
{19079,5000, "TheParrot2"},
{19085,5000, "EyePatch"},
{19090,1500, "PomPomBlue"},
{19091,1500, "PomPomRed"},
{19092,1500, "PomPomGreen"},
{19094,2000, "BurgerShotHat"},
{19095,1500, "CowboyHat1"},
{19096,1500, "CowboyHat3"},
{19097,3000, "CowboyHat4"},
{19098,3000, "CowboyHat5"},
{19101,2000, "ArmyHelmet1"},
{19102,2000, "ArmyHelmet2"},
{19103,2000, "ArmyHelmet3"},
{19104,2000, "ArmyHelmet4"},
{19105,2000, "ArmyHelmet5"},
{19106,2000, "ArmyHelmet6"},
{19107,4000, "ArmyHelmet7"},
{19108,4000, "ArmyHelmet8"},
{19109,4000, "ArmyHelmet9"},
{19110,4000, "ArmyHelmet10"},
{19111,4000, "ArmyHelmet11"},
{19112,4000, "ArmyHelmet12"},
{19113,1000, "SillyHelmet1"},
{19114,2000, "SillyHelmet2"},
{19115,3000, "SillyHelmet3"},
{19116,1500, "PlainHelmet1"},
{19117,1500, "PlainHelmet2"},
{19118,1500, "PlainHelmet3"},
{19119,1000, "PlainHelmet4"},
{19120,1000, "PlainHelmet5"},
{19137,5000, "CluckinBellHat"},
{19163,1000, "GimpMask"}
};


new HoldingBones[][] = {
	"None",
	"Spine",
	"Head",
	"Left upper arm",
	"Right upper arm",
	"Left hand",
	"Right hand",
	"Left thigh",
	"Right thigh",
	"Left foot",
	"Right foot",
	"Right calf",
	"Left calf",
	"Left forearm",
	"Right forearm",
	"Left clavicle",
	"Right clavicle",
	"Neck",
	"Jaw"
};

stock GiftPlayer(playerid, giveplayerid) // playerid = Gifter.  giveplayerid = gift receiver
{
	new String[10000];
	if(PlayerInfo[playerid][pAdmin] >= 2 || playerid == MAX_PLAYERS)
	{
		new randgift = Random(1, 100);
		if(randgift >= 1 && randgift <= 83)
		{
		    new gift = Random(1, 8);
		    if(gift == 1)
		    {
		        if(PlayerInfo[giveplayerid][pConnectTime] < 1 /*|| PlayerInfo[giveplayerid][pWRestricted] > 0*/) return GiftPlayer(playerid, giveplayerid);
		        givePlayerValidWeapon(giveplayerid, 25, AMMO_SHOTGUN);
		        givePlayerValidWeapon(giveplayerid, 25, AMMO_DEAGLE);
		        givePlayerValidWeapon(giveplayerid, 25, AMMO_MINIGUN);
		        givePlayerValidWeapon(giveplayerid, 25, AMMO_SNIPER);
		        givePlayerValidWeapon(giveplayerid, 25, AMMO_MINIGUN);
		        SendClientMessageEx(giveplayerid, COLOR_GRAD2, " Congratulations - you have won a full weapon set!");
		    }
		    else if(gift == 2)
		    {
		        PlayerInfo[giveplayerid][pFirstaid]++;
		        SendClientMessageEx(giveplayerid, COLOR_GRAD2, " Congratulations - you have won a first aid kit!");
		    }
		    else if(gift == 3)
		    {
		        PlayerInfo[giveplayerid][pMats] += 2000;
		        SendClientMessageEx(giveplayerid, COLOR_GRAD2, " Congratulations - you have won 2,000 materials!");
		    }
		    else if(gift == 4)
		    {
		        if(PlayerInfo[giveplayerid][pWarns] != 0)
		        {
		        	PlayerInfo[giveplayerid][pWarns]--;
		        	SendClientMessageEx(giveplayerid, COLOR_GRAD2, " Congratulations - you have won a single warning removal!");
				}
				else
				{
        			SendClientMessageEx(playerid, COLOR_GRAD2, "Random gift ended up in a removal of one warning - let's try again!");
        			GiftPlayer(playerid, giveplayerid);
				    return 1;
				}
		    }
		    else if(gift == 5)
		    {
				PlayerInfo[giveplayerid][pPot] += 50;
				SendClientMessageEx(giveplayerid, COLOR_GRAD2, " Congratulations - you have won 50 grams of pot!");
		    }
		    else if(gift == 6)
		    {
		        PlayerInfo[giveplayerid][pCrack] += 25;
				SendClientMessageEx(giveplayerid, COLOR_GRAD2, " Congratulations - you have won 25 grams of crack!");
		    }
		    else if(gift == 7)
		    {
		        GivePlayerCash(giveplayerid, 20000);
				SendClientMessageEx(giveplayerid, COLOR_GRAD2, " Congratulations - you have won $200.00!");
		    }
			else if(gift == 8)
			{
				new year,month,day,log[128];
				getdate(year, month, day);
				SendClientMessageEx(giveplayerid, COLOR_GRAD2, " Congratulations - you have won a free car!");
				SendClientMessageEx(giveplayerid, COLOR_GRAD2, " Note: ScreenShot sebagai bukti reward, lalu hubungi Admin, Reward akan hangus dalam 1x24 jam.");
                format(String, sizeof(String), "Free Car (Gift), (%d/%d/%d)", day, month, year);
				SendClientMessageEx(giveplayerid, COLOR_GRAD2, String);
				format(String, sizeof(String), "{FF6347}AdmCmd: %s has just gifted %s and he won a free car.", PlayerInfo[playerid][pAdminName], GetName(giveplayerid));
				ABroadCast(COLOR_YELLOW, String, 1);
				format(log, sizeof(log), "{FF6347}AdmCmd: %s has just gifted %s and he won a free car(%d-%d-%d)", PlayerInfo[playerid][pAdminName], GetName(giveplayerid), day, month, year);
				Log("logs/gifts.log", log);
			}
		}
		PlayerInfo[giveplayerid][pGiftTime] = 300;
	}
	return 1;
}

Float:GetDistance( Float: x1, Float: y1, Float: z1, Float: x2, Float: y2, Float: z2 )
{
	new Float:d;
	d += floatpower(x1-x2, 2.0 );
	d += floatpower(y1-y2, 2.0 );
	d += floatpower(z1-z2, 2.0 );
	d = floatsqroot(d);
	return d;
}
SurfingCheck(vehicleid)
{
	foreach(Player, p)
	{
		if(GetPlayerSurfingVehicleID(p) == vehicleid)
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(p, x, y, z);
		    SetPVarFloat(p, "tempPosX", x);
			SetPVarFloat(p, "tempPosY", x);
			SetPVarFloat(p, "tempPosZ", x);

			SetTimerEx("SurfingFix", 2000, 0, "i", p);
		}
	}
}
forward PressJump(playerid);
public PressJump(playerid)
{
    PlayerPressedJump[playerid] = 0;
    ClearAnimations(playerid);
    return 1;
}
forward PressJumpReset(playerid);
public PressJumpReset(playerid)
{
    PlayerPressedJump[playerid] = 0;
    return 1;
}
public ModCar(playerid) { // changed to switch method to reduce processor load on server
//	new modelid = GetVehicleModel(GetPlayerVehicleID(playerid)); // this executes a fair amt of stuff, so running it once to populate variable (modelid),THEN checking variable, makes more sense
	switch(pmodelid[playerid]) {
        case 562,565,559,561,560,575,534,567,536,535,576,411,579,602,496,518,527,589,597,419,
		533,526,474,545,517,410,600,436,580,439,549,491,445,604,507,585,587,466,492,546,551,516,
		426, 547, 405, 409, 550, 566, 540, 421,	529,431,438,437,420,525,552,416,433,427,490,528,
		407,544,470,598,596,599,601,428,499,609,524,578,486,406,573,455,588,403,514,423,
		414,443,515,456,422,482,530,418,572,413,440,543,583,478,554,402,542,603,475,568,504,457,
        483,508,429,541,415,480,434,506,451,555,477,400,404,489,479,442,458,467,558,444: {
		    TogglePlayerControllable(playerid,1);
 			return SendClientMessage(playerid, COLOR_WHITE, "[INFO] Select an item and push the SPACEBAR to approve.");
		}
		default: return SendClientMessage(playerid,COLOR_RED,"[WARNING] You are not allowed to modify/tune this vehicle");
	}
	return 1;
}
public settime(playerid)
{
	new String[256],mtext[20],year,month,day,hours,minutes,seconds;
	getdate(year, month, day), gettime(hours, minutes, seconds);
	if(month == 1) { mtext = "Januari"; }
    else if(month == 2) { mtext = "Februari"; }
    else if(month == 3) { mtext = "Maret"; }
    else if(month == 4) { mtext = "April"; }
    else if(month == 5) { mtext = "Mei"; }
    else if(month == 6) { mtext = "Juni"; }
    else if(month == 7) { mtext = "Juli"; }
    else if(month == 8) { mtext = "Agustus"; }
    else if(month == 9) { mtext = "September"; }
    else if(month == 10) { mtext = "Oktober"; }
    else if(month == 11) { mtext = "November"; }
    else if(month == 12) { mtext = "Desember"; }
	format(String, sizeof String, "%s%d %s %s%d", ((day < 10) ? ("0") : ("")), day, mtext, (year < 10) ? ("0") : (""), year);
	TextDrawSetString(Date, String);
	format(String, sizeof String, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
	TextDrawSetString(Time, String);
}

forward MessageToAdmins(color,const String[]);
public MessageToAdmins(color,const String[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    if(IsPlayerConnected(i))
    if(PlayerInfo[i][pAdmin] >= 1) // replace the variable and the value by your variable by default
    SendClientMessage(i, color, String);
    }
    return 1;
}

forward SurfingFix(playerid);
public SurfingFix(playerid)
{
	AC_BS_SetPlayerPos(playerid, GetPVarFloat(playerid, "tmpPosX"), GetPVarFloat(playerid, "tmpPosY"), GetPVarFloat(playerid, "tmpPosZ"));
	DeletePVar(playerid, "tmpPosX");
	DeletePVar(playerid, "tmpPosY");
	DeletePVar(playerid, "tmpPosZ");

	return 1;
}
InvalidModCheck(model, partid) {
    switch(model) {
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595, 573, 556, 557, 539, 471, 432, 406, 444,
		448, 461, 462, 463, 468, 481, 509, 510, 521, 522, 581, 586, 417, 425, 447, 460, 469, 476, 487,
		488, 511, 512, 513, 519, 520, 548, 553, 563, 577, 592, 593: return 0;
		default: switch(GetVehicleComponentType(partid)) {
			case 5: switch(partid) {
				case 1008, 1009, 1010: return 1;
				default: return 0;
			}
			case 7: switch(partid) {
				case 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1096, 1097, 1098, 1025: return 1;
				default: return 0;
			}
			case 8: switch(partid) {
				case 1086: return 1;
				default: return 0;
			}
			case 9: switch(partid) {
				case 1087: return 1;
				default: return 0;
			}
			default: for(new i; i < 4; i++) if(partid == vehicleMods[model - 400][GetVehicleComponentType(partid)][i]) {
				return 1;
			}
		}
	}
	return 0;
}
IsAtPohon(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid,10.0,-1119.7800000,-1196.2800000,128.1300000))
		{
			return 1;
		}
        else if(IsPlayerInRangeOfPoint(playerid,10.0,-1124.1900000,-1207.5900000,128.0300000))
		{
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,10.0,-1107.9000000,-1196.0600000,128.2300000))
		{
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,10.0,-1100.8500000,-1208.7000000,127.9200000))
		{
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,10.0,-1111.8400000,-1213.1600000,128.0200000))
		{
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,1.0,-983.6861,-1080.9033,129.2188))
		{
			return 1;
        }
	}
	return 0;
}

//=======================Pom Bensin =============================
stock StopRefueling(playerid)
{
 	for(new idx = 1; idx < sizeof(BizzInfo); idx++)
	{
		CounterRefuel[playerid]=0;
		LimitFuel[playerid]=0;
		RefuelingVehicle[playerid] = 0; RefuelingVehiclePrice[playerid] = 0; KillTimer(RefuelingVehicleTimer[playerid]);
		return 1;
	}
	return 1;
}
forward ReFill(playerid);
public ReFill(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid) || VehicleFuel[GetPlayerVehicleID(playerid)] >= 100.0 || GetPlayerCash(playerid) < 1 || CounterRefuel[playerid] >= LimitFuel[playerid] )
	{
		StopRefueling(playerid);
	}
	else
	{
	    new engine,lights,alarm,doors,bonnet,boot,objective;
    	GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine,lights,alarm,doors,bonnet,boot,objective);
		if(engine == VEHICLE_PARAMS_ON) return StopRefueling(playerid);
		VehicleFuel[GetPlayerVehicleID(playerid)] += 1.0;
		if(VehicleFuel[GetPlayerVehicleID(playerid)] >= 100.0){
			VehicleFuel[GetPlayerVehicleID(playerid)] = 100.0;
		}
		CounterRefuel[playerid]++;
	}
	return 1;
}


public Audio_OnClientConnect(playerid)
{
	new String[10000];
	format(String,sizeof(String),"(Audio Plugin) %s(%d) has connected to the audio server.",PlayerInfo[playerid][pNormalName],playerid);
	SendClientMessageEx(playerid, 0xA9C4E4FF, String);
	SendClientMessageEx(playerid, 0xA9C4E4FF, "(Audio Plugin) Checking and downloading audio files, Please wait...");
	Audio_TransferPack(playerid);
	return 1;
}

public Audio_OnPlay(playerid, handleid)
{
	new String[10000];
	format(String, sizeof(String), "(Audio Plugin) Debug: Audio playback started for handle ID %d.", handleid);
	SendClientMessage(playerid, 0xA9C4E4FF, String);
}

public Audio_OnStop(playerid, handleid)
{
	new String[10000];
	format(String, sizeof(String), "(Audio Plugin) Debug: Audio playback stopped for handle ID %d.", handleid);
	SendClientMessage(playerid, 0xA9C4E4FF, String);
}

public Audio_OnTransferFile(playerid, file[], current, total, result)
{
	if (current == total)
	{
		SendClientMessageEx(playerid, 0xA9C4E4FF, "(Audio Plugin) All audio files have been downloaded and processed, Thank you!");
		SendAudioToPlayer(playerid, 1183, 100, 0);
	}
	return 1;
}


public Audio_OnClientDisconnect(playerid)
{
	new String[10000];
	format(String,sizeof(String),"(Audio Plugin) %s(%d) has disconnected from the audio server.",PlayerInfo[playerid][pNormalName],playerid);
	SendClientMessageEx(playerid, 0xA9C4E4FF, String);
	return 1;
}

public Audio_OnTrackChange(playerid, handleid, track[])
{
	new String[10000];
	format(String, sizeof(String), "(Audio Plugin) Debug: Now playing \"%s\" for handle ID %d.", track, handleid);
	SendClientMessage(playerid, 0xA9C4E4FF, String);
	format(String, sizeof(String), "* Now Playing: %s.",track);
	SendClientMessageEx(playerid, COLOR_PURPLE, String);
 	return 1;
}

SendBlankAudioTick(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(Audio_IsClientConnected(playerid))
	    {
			new handleid = Audio_Play(playerid, 1, false, false, false);
			Audio_SetVolume(playerid, handleid, 0);
	    }
	    else
	    {
			return 0;
	    }
	}
	return 1;
}

forward SendAudioToPlayer(playerid, audioid, volume, seek);
public SendAudioToPlayer(playerid, audioid, volume, seek)
{
	if(IsPlayerConnected(playerid))
	{
		if(Audio_IsClientConnected(playerid))
		{
			new localhandle = Audio_Play(playerid,audioid,false,false,false);
			Audio_SetVolume(playerid, localhandle, volume);
			Audio_SetPosition(playerid, localhandle, seek);
		}
		else
		{
		    return 0;
		}
	}
	return 1;
}

SendAudioToRange(audioid, volume, seek, Float:x, Float:y, Float:z, Float:range)
{
	if(audiohandleglobal >= 99)
	{
	    audiohandleglobal = 0;
	}
	else
	{
	    audiohandleglobal++;
	}

	foreach(Player, i)
	{
	    if(IsPlayerConnected(i))
	    {
			if(Audio_IsClientConnected(i))
			{
                if(IsPlayerInRangeOfPoint(i,range,x,y,z))
                {
                    new localhandle = Audio_Play(i,audioid,false,false,false);
					Audio_Set3DPosition(i, localhandle, x, y, z, range);
					Audio_SetVolume(i, localhandle, volume);
					Audio_SetPosition(i, localhandle, seek);
     				audiohandle[i][audiohandleglobal] = localhandle;
                }
			}
	    }
	}
	return audiohandleglobal;
}

stock nearByMessage(playerid, color, String[], Float: Distance = 12.0) {

	new
	    Float: nbCoords[3];

	GetPlayerPos(playerid, nbCoords[0], nbCoords[1], nbCoords[2]);

	foreach(Player, i) {
	    if(IsPlayerConnected(i)){
	        if(IsPlayerInRangeOfPoint(i, Distance, nbCoords[0], nbCoords[1], nbCoords[2]) && (GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))) {
				SendClientMessage(i, color, String);
			}
	    }
	}

	return 1;
}

stock SendAudioURLToRange(url[], volume, seek, Float:x, Float:y, Float:z, Float:range)
{
    if(audiohandleglobal >= 99)
	{
	    audiohandleglobal = 0;
	}
	else
	{
	    audiohandleglobal++;
	}
	foreach(Player, i)
	{
	    if(IsPlayerConnected(i))
	    {
			if(Audio_IsClientConnected(i))
			{
                if(IsPlayerInRangeOfPoint(i,range,x,y,z))
                {
                    new localhandle = Audio_PlayStreamed(i,url,false,false,false);
					Audio_Set3DPosition(i, localhandle, x, y, z, range);
					Audio_SetVolume(i, localhandle, volume);
					Audio_SetPosition(i, localhandle, seek);
     				audiohandle[i][audiohandleglobal] = localhandle;
                }
			}
	    }
	}
	return audiohandleglobal;
}
AntiDeAMX()
{
    new a[][] = {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}
forward SetVehicleEngine(vehicleid, playerid);
public SetVehicleEngine(vehicleid, playerid)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(engine == VEHICLE_PARAMS_ON)
	{
		SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_OFF,0,alarm,doors,bonnet,boot,objective);
		SendClientMessageEx(playerid, COLOR_WHITE, "ENGINE: Mesin telah berhasil mati.");
		DeletePVar(playerid, "fuelonoff");
		DestroyProgressBar(FuelBar[playerid]);
		textdrawscount--;
		FuelBar[playerid] = INVALID_BAR_ID;
		arr_Engine{vehicleid} = 0;
		for(new d = 0 ; d < MAX_PLAYERVEHICLES; d++)
		{
			if(GetPVarInt(playerid, "togneon") == 1)
			{
				DestroyDynamicObject(PlayerVehicleInfo[playerid][d][pvNeonObj]);
				DestroyDynamicObject(PlayerVehicleInfo[playerid][d][pvNeonObj2]);
				DestroyDynamicObject(PlayerVehicleInfo[playerid][d][pvNeonObj3]);
				DestroyDynamicObject(PlayerVehicleInfo[playerid][d][pvNeonObj4]);
				SetPVarInt(playerid, "togneon", 0);
				return 1;
			}
		}
	}
    else if(engine == VEHICLE_PARAMS_OFF || engine == VEHICLE_PARAMS_UNSET)
	{
		new
			Float: f_vHealth;

		GetVehicleHealth(vehicleid, f_vHealth);
		if(f_vHealth < 350.0) return SendClientMessageEx(playerid, COLOR_RED, "ENGINE: Mesin tidak dapat menyala karena mengalami kerusakan.");
	    if(VehicleFuel[vehicleid] <= 0.0) return SendClientMessageEx(playerid, COLOR_RED, "ENGINE: Mesin tidak dapat menyala karena tangki kosong.");
		SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
		arr_Engine{vehicleid} = 1;
		SendClientMessageEx(playerid, COLOR_ARWIN, "ENGINE: Anda telah menghidupkan mesin kendaraan.");
		SetPVarInt(playerid, "fuelonoff", 1);
	}
	return 1;
}

SetVehicleLights(vehicleid, playerid)
{
 	new engine,lights,alarm,doors,bonnet,boot,objective;
    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(lights == VEHICLE_PARAMS_OFF)
	{
		SetVehicleParamsEx(vehicleid,engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
		SendClientMessageEx(playerid, COLOR_WHITE, "VEHICLEINFO: Lights {00D900}ON.");
	}
    else
	{
		SetVehicleParamsEx(vehicleid,engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
		SendClientMessageEx(playerid, COLOR_WHITE, "VEHICLEINFO: Lights {FF0000}OFF.");
	}
	return 1;
}

SetVehicleHood(vehicleid, playerid)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(bonnet == VEHICLE_PARAMS_ON)
	{
		SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,VEHICLE_PARAMS_OFF,boot,objective);
		SendClientMessageEx(playerid, COLOR_WHITE, "VEHICLEINFO: Hood {FF0000}CLOSED.");
	}
    else if(bonnet == VEHICLE_PARAMS_OFF || bonnet == VEHICLE_PARAMS_UNSET)
	{
		SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,VEHICLE_PARAMS_ON,boot,objective);
		SendClientMessageEx(playerid, COLOR_WHITE, "VEHICLEINFO: Hood {00D900}OPENED.");
	}
	return 1;
}

SetVehicleTrunk(vehicleid, playerid)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(boot == VEHICLE_PARAMS_ON)
	{
		SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_OFF,objective);
		SendClientMessageEx(playerid, COLOR_WHITE, "VEHICLEINFO: Trunk {FF0000}CLOSED.");
	}
    else if(boot == VEHICLE_PARAMS_OFF || boot == VEHICLE_PARAMS_UNSET)
	{
		SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_ON,objective);
		SendClientMessageEx(playerid, COLOR_WHITE, "VEHICLEINFO: Trunk {00D900}OPENED.");
	}
	return 1;
}
stock SendBugMessage(member, color, String[])
{
	foreach(Player, i)
	{
 		if(PlayerInfo[i][pMember] == member && gBug[i] == 1)
		{
			SendClientMessageEx(i, color, String);
		}
	}
}
stock SendSIUBugMessage(member, color, String[])
{
	foreach(Player, i)
	{
 		if(PlayerInfo[i][pMember] == member && PlayerInfo[i][pDivision] == 4 && gBugSIU[i] == 1)
   		{
			SendClientMessageEx(i, color, String);
		}
	}
}

CheckVPH(newph)
{
        new PHList[256];
        new number;
        new String[512];
        new File: file = fopen("PHList.cfg", io_read);
        if (file)
		{
            while(fread(file, String))
			{
            	strmid(PHList, String, 0, strlen(String)-2, 255);
                number = strval(PHList);
                if (number == newph)
				{
                	fclose(file);
                    return 1;
    			}
			}
            fclose(file);
            return 0;
        }
        return 1;
}

CheckPH(playerid)
{
        if(PlayerInfo[playerid][pPnumber] == 0) {return 0;}
        new PHList[256];
        new number;
        new String[512];
        if(!fexist("PHList.cfg")) fcreate("PHList.cfg");
        new File: file = fopen("PHList.cfg", io_read);
        if (file)
		{
            while(fread(file, String))
			{
            	strmid(PHList, String, 0, strlen(String)-2, 255);
                number = strval(PHList);
                if (number == PlayerInfo[playerid][pPnumber])
				{
                	fclose(file);
                    return 1;
    			}
			}
            fclose(file);
            new File: file2 = fopen("PHList.cfg", io_append);
            format(String, sizeof(String), "%d\r\n", PlayerInfo[playerid][pPnumber]);
            fwrite(file2, String);
            fclose(file2);
            printf("New number added to PHList.cfg, ph:%d player:%s", PlayerInfo[playerid][pPnumber], PlayerInfo[playerid][pNormalName]);
            return 0;
        }
        return 1;
}

ReplacePH(oldph, newph)
{
    new File: file2 = fopen("tmpPHList.cfg", io_write);
    new number;
    new String[512];
    new PHList[256];
    format(String, sizeof(String), "%d\r\n", newph);
    fwrite(file2, String);
    fclose(file2);
    file2 = fopen("tmpPHList.cfg", io_append);
    new File: file = fopen("PHList.cfg", io_read);
    while(fread(file, String))
	{
        strmid(PHList, String, 0, strlen(String)-1, 255);
        number = strval(PHList);
    	if (number != oldph)
		{
            format(String, sizeof(String), "%d\r\n", number);
        	fwrite(file2, String);
    	}
    }
    fclose(file);
    fclose(file2);
    file2 = fopen("PHList.cfg", io_write);
    file = fopen("tmpPHList.cfg", io_read);
	while(fread(file, String))
	{
        strmid(PHList, String, 0, strlen(String)-1, 255);
        number = strval(PHList);
        if (number != oldph)
		{
            format(String, sizeof(String), "%d\r\n", number);
        	fwrite(file2, String);
    	}
    }
    fclose(file);
    fclose(file2);
	fremove("tmpPHList.cfg");
	printf("ph %d replaced with ph %d in PHList.cfg", oldph, newph);
	return 1;
}


stock givePlayerValidWeapon(playerid, weapon, ammo) { //Ammo
	new senjata, peluru, i;
	if((PlayerInfo[playerid][pConnectTime] < 1) && weapon != 46 && weapon != 43) return 1;
	switch(weapon) {
		case 0, 1: {
			if (ammo == 88998899) ammo = AMMO_MELEE;
	        PlayerInfo[playerid][pGuns][0] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
	    }
	    case 2, 3, 4, 5, 6, 7, 8, 9: {
			if (ammo == 88998899) ammo = AMMO_MELEE;
	        PlayerInfo[playerid][pGuns][1] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
	    }
	    case 22, 23, 24: {
			if (ammo == 88998899) {
				if (weapon == 24) ammo = AMMO_DEAGLE;
				else ammo = AMMO_9MM;
			}
	        PlayerInfo[playerid][pGuns][2] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
			i = 2;
			GetPlayerWeaponData(playerid, i, senjata, peluru);
			if (senjata == weapon) PlayerInfo[playerid][pGuns][i] = senjata;
			else PlayerInfo[playerid][pGunsAmmo][i] = ammo;
	    }
	    case 25, 26, 27: {
			if (ammo == 88998899) ammo = AMMO_SHOTGUN;
	        PlayerInfo[playerid][pGuns][3] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
			i = 3;
			GetPlayerWeaponData(playerid, i, senjata, peluru);
			if (senjata == weapon) PlayerInfo[playerid][pGuns][i] = senjata;
			else PlayerInfo[playerid][pGunsAmmo][i] = ammo;
	    }
	    case 28, 29, 32: {
			if (ammo == 88998899) ammo = AMMO_MINIGUN;
	        PlayerInfo[playerid][pGuns][4] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
			i = 4;
			GetPlayerWeaponData(playerid, i, senjata, peluru);
			if (senjata == weapon) PlayerInfo[playerid][pGuns][i] = senjata;
			else PlayerInfo[playerid][pGunsAmmo][i] = ammo;
	    }
	    case 30, 31: {
			if (ammo == 88998899) ammo = AMMO_M4AK;
	        PlayerInfo[playerid][pGuns][5] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
			i = 5;
			GetPlayerWeaponData(playerid, i, senjata, peluru);
			if (senjata == weapon) PlayerInfo[playerid][pGuns][i] = senjata;
			else PlayerInfo[playerid][pGunsAmmo][i] = ammo;
	    }
	    case 33, 34: {
			if (ammo == 88998899) ammo = AMMO_SNIPER;
	        PlayerInfo[playerid][pGuns][6] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
			i = 6;
			GetPlayerWeaponData(playerid, i, senjata, peluru);
			if (senjata == weapon) PlayerInfo[playerid][pGuns][i] = senjata;
			else PlayerInfo[playerid][pGunsAmmo][i] = ammo;
	    }
	    case 35, 36, 37, 38: {
			if (ammo == 88998899) {
				if (weapon == 37) ammo = AMMO_FT;
				else if (weapon == 38) ammo = AMMO_GG;
				else ammo = AMMO_RPG;
			}
	        PlayerInfo[playerid][pGuns][7] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
			i = 7;
			GetPlayerWeaponData(playerid, i, senjata, peluru);
			if (senjata == weapon) PlayerInfo[playerid][pGuns][i] = senjata;
			else PlayerInfo[playerid][pGunsAmmo][i] = ammo;
	    }
	    case 16, 17, 18, 39, 40: {
			if (ammo == 88998899) ammo = AMMO_GRANADE;
	        PlayerInfo[playerid][pGuns][8] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
			i = 8;
			GetPlayerWeaponData(playerid, i, senjata, peluru);
			if (senjata == weapon) PlayerInfo[playerid][pGuns][i] = senjata;
			else PlayerInfo[playerid][pGunsAmmo][i] = ammo;
	    }
	    case 41, 42, 43: {
			if (ammo == 88998899) ammo = AMMO_MELEE;
	        PlayerInfo[playerid][pGuns][9] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
	    }
	    case 10, 11, 12, 13, 14, 15: {
			if (ammo == 88998899) ammo = AMMO_MELEE;
	        PlayerInfo[playerid][pGuns][10] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
	    }
	    case 44, 45, 46: {
			if (ammo == 88998899) ammo = AMMO_MELEE;
	        PlayerInfo[playerid][pGuns][11] = weapon;
	        GivePlayerWeapon(playerid, weapon, ammo);
	    }
	}
	return 1;
}

GetWeaponSlot(weaponid)
{
	switch( weaponid )
	{
		case 0, 1:
		{
			return 0;
		}
		case 2, 3, 4, 5, 6, 7, 8, 9:
		{
			return 1;
		}
		case 22, 23, 24:
		{
			return 2;
		}
		case 25, 26, 27:
		{
			return 3;
		}
		case 28, 29, 32:
		{
			return 4;
		}
		case 30, 31:
		{
			return 5;
		}
		case 33, 34:
		{
			return 6;
		}
		case 35, 36, 37, 38:
		{
			return 7;
		}
		case 16, 17, 18, 39, 40:
		{
			return 8;
		}
		case 41, 42, 43:
		{
			return 9;
		}
		case 10, 11, 12, 13, 14, 15:
		{
			return 10;
		}
		case 44, 45, 46:
		{
			return 11;
		}
	}
	return -1;
}
//GUN HOLDING
GetWeaponObjectSlot(weaponid)
{
	new objectslot;

	switch (weaponid)
	{
    	case 22..24: objectslot = 0;
    	case 25..27: objectslot = 1;
		case 28, 29, 32: objectslot = 2;
		case 30, 31: objectslot = 3;
		case 33, 34: objectslot = 4;
		case 35..38: objectslot = 5;
	}
	return objectslot;
}

GetWeaponModel(weaponid)
{
    new const WeaponModels[] =
	{
		0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
		325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
		353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
		367, 368, 368, 371
	};
  	return WeaponModels[weaponid];
}

PlayerHasWeapon(playerid, weaponid)
{
	new weapon, ammo;

	for (new i; i < 13; i++)
	{
		GetPlayerWeaponData(playerid, i, weapon, ammo);
		if (weapon == weaponid && ammo) return 1;
	}
	return 0;
}

IsWeaponWearable(weaponid)
{
	switch (weaponid) {
		case 22..38: return 1;
	}
	return 0;
}

IsWeaponHideable(weaponid)
{
	switch (weaponid) {
		case 22..24, 28, 32: return 1;
	}
	return 0;
}

WeaponInfoFile(playerid)
{
	new name[MAX_PLAYER_NAME], file[40];

	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), "Weapons/%s.ini", name);

	return file;
}

ResetWeaponInfo(playerid)
{
	for (new i = 22; i <= 38; i++)
	{
		WeaponInfo[playerid][i][Position][0] = -0.115999;
		WeaponInfo[playerid][i][Position][1] = 0.189000;
		WeaponInfo[playerid][i][Position][2] = 0.087999;
		WeaponInfo[playerid][i][Position][3] = 0.000000;
		WeaponInfo[playerid][i][Position][4] = 44.500007;
		WeaponInfo[playerid][i][Position][5] = 0.000000;
		WeaponInfo[playerid][i][Bone] = 1;
		WeaponInfo[playerid][i][Hidden] = false;
	}
}

FormatWeaponInfo(playerid, weaponid)
{
	new string[68];

	format(string, sizeof(string), "%.5f | %.5f | %.5f | %.5f | %.5f | %.5f | %d | %d", WeaponInfo[playerid][weaponid][Position][0], WeaponInfo[playerid][weaponid][Position][1], WeaponInfo[playerid][weaponid][Position][2], WeaponInfo[playerid][weaponid][Position][3], WeaponInfo[playerid][weaponid][Position][4],  WeaponInfo[playerid][weaponid][Position][5], WeaponInfo[playerid][weaponid][Bone], WeaponInfo[playerid][weaponid][Hidden]);
	return string;
}

SaveWeaponInfo(playerid)
{
	new INI:File = INI_Open(WeaponInfoFile(playerid)), weapon[2];

	for (new i = 22; i <= 38; i++)
	{
		valstr(weapon, i);
		INI_WriteString(File, weapon, FormatWeaponInfo(playerid, i));
	}
	INI_Close(File);
	return 1;
}

forward LoadWeaponInfo_data(playerid, name[], value[]);
public LoadWeaponInfo_data(playerid, name[], value[])
{
	new string[68], weapon[2];

	for (new i = 22; i <= 38; i++)
	{
		valstr(weapon, i);
		INI_String(weapon, string, sizeof(string));
		sscanf(string, "ffffffdd", WeaponInfo[playerid][i][Position][0], WeaponInfo[playerid][i][Position][1], WeaponInfo[playerid][i][Position][2], WeaponInfo[playerid][i][Position][3], WeaponInfo[playerid][i][Position][4], WeaponInfo[playerid][i][Position][5], WeaponInfo[playerid][i][Bone], WeaponInfo[playerid][i][Hidden]);
	}
	return 1;
}

forward WeaponCheck(playerid);
public WeaponCheck(playerid)
{
	new weapon[13], ammo[13], objectslot, weaponcount;

	for (new i; i <= 12; i++)
	{
	    GetPlayerWeaponData(playerid, i, weapon[i], ammo[i]);

		if (weapon[i] && ammo[i] && !WeaponInfo[playerid][weapon[i]][Hidden] && IsWeaponWearable(weapon[i]) && EditingWeapon[playerid] != weapon[i])
		{
			objectslot = GetWeaponObjectSlot(weapon[i]);

		    if (GetPlayerWeapon(playerid) != weapon[i]) SetPlayerAttachedObject(playerid, objectslot, GetWeaponModel(weapon[i]), WeaponInfo[playerid][weapon[i]][Bone], WeaponInfo[playerid][weapon[i]][Position][0], WeaponInfo[playerid][weapon[i]][Position][1], WeaponInfo[playerid][weapon[i]][Position][2], WeaponInfo[playerid][weapon[i]][Position][3], WeaponInfo[playerid][weapon[i]][Position][4], WeaponInfo[playerid][weapon[i]][Position][5], 1.000000, 1.000000, 1.000000);
		    else if (IsPlayerAttachedObjectSlotUsed(playerid, objectslot)) RemovePlayerAttachedObject(playerid, objectslot);
		}
	}
	for (new i; i <= 5; i++) if (IsPlayerAttachedObjectSlotUsed(playerid, i))
	{
		weaponcount = 0;

		for (new j = 22; j <= 38; j++)
			if (PlayerHasWeapon(playerid, j) && GetWeaponObjectSlot(j) == i) weaponcount++;

		if (!weaponcount) RemovePlayerAttachedObject(playerid, i);
	}
	return 1;
}

stock ExecuterHackerAction(playerid) {
    PlayerInfo[playerid][pHackWarnings]++;
    PlayerInfo[playerid][pHackWarnTime] = 1;
    if(PlayerInfo[playerid][pHackWarnings] >= 1) {
		new
			wep = GetPlayerWeapon(playerid),
	        reason[94],
			wname[32];

		GetPlayerName(playerid, szPlayerName, MAX_PLAYER_NAME);
		GetWeaponName(wep, wname, sizeof(wname));
		printf("Hack Warning! %s[id:%d] Weapon %s[id:%d]", szPlayerName, playerid, wname, GetPlayerWeapon(playerid));
		format(reason, sizeof(reason), "Warning: {FFFFFF}%s may possibly be weapon [%s] hacking.", szPlayerName, wname);
		ABroadCast(0xFFFFFFAA, reason, 1);

	    if(PlayerInfo[playerid][pHackWarnings] >= MAX_WEAPON_HACK_WARNINGS) {
	        format(reason, sizeof(reason), "Weapon [%s] Hacking.", wname);
	        scriptBan(playerid, reason);
	    }
    }
	return 1;
}
stock scriptBan(playerid, reason[])
{
	new aString[240];
	GetPlayerName(playerid, szPlayerName, MAX_PLAYER_NAME);
	new year, month,day;
	getdate(year, month, day);
	new hour,minuite,second;
	gettime(hour,minuite,second);
	hour = shifthour;
	PlayerInfo[playerid][pBanned] = 1;
	strcpy(PlayerInfo[playerid][pAdminban], "BOT", MAX_PLAYER_NAME);
	format(PlayerInfo[playerid][pBanReason], 128, "%s",reason);
	format(PlayerInfo[playerid][pBanExpired],150, "%d:%d:%d",hour,minuite,second);
	format(PlayerInfo[playerid][pBanExpired2],150, "%d-%d-%d",day,month,year);
	new ip[32];
	GetPlayerIp(playerid,ip,sizeof(ip));
	AddBan(ip);
	new String2[500];
	format(String2, sizeof(String2), "Akun atau IP anda telah di banned!\n\n{FFFFFF}Account: {FF0000}%s\n{FFFFFF}IP: {FF0000}%s\n{FFFFFF}Di banned oleh: {FF0000}BOT \n{FFFFFF}Alasan: {FF0000}%s \n{FFFFFF}Pada Waktu: {FF0000}%s | {FFFFFF}Tanggal: {FF0000}%s\n\n{FFFFFF}Sihlakan Post forum bagian unban request",PlayerInfo[playerid][pNormalName],PlayerInfo[playerid][pIP],PlayerInfo[playerid][pBanReason],PlayerInfo[playerid][pBanExpired],PlayerInfo[playerid][pBanExpired2]);
	ShowPlayerDialog(playerid,BAN_DIALOG,DIALOG_STYLE_MSGBOX,"BANNED",String2,":(","");
	FixedKick(playerid);
   	format(aString, sizeof(aString), "BotCmd: %s telah di ban oleh Bot", szPlayerName);
   	SendClientMessageToAll(COLOR_LIGHTRED, aString);
   	format(aString, sizeof(aString), "BotCmd: Reason: %s", reason);
   	SendClientMessageToAll(COLOR_LIGHTRED, aString);
	return 1;
}
stock ConvertTime(cts, &ctm=-1,&cth=-1,&ctd=-1,&ctw=-1,&ctmo=-1,&cty=-1){
    //Defines to drastically reduce the code..

    #define PLUR(%0,%1,%2) (%0),((%0) == 1)?((#%1)):((#%2))

    #define CTM_cty 31536000
    #define CTM_ctmo 2628000
    #define CTM_ctw 604800
    #define CTM_ctd 86400
    #define CTM_cth 3600
    #define CTM_ctm 60

    #define CT(%0) %0 = cts / CTM_%0; cts %= CTM_%0


    new strii[128];

    if(cty != -1)
    {
        CT(cty); CT(ctmo); CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s, %d %s, %d %s, and %d %s",PLUR(cty,"year","years"),PLUR(ctmo,"month","months"),PLUR(ctw,"week","weeks"),PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctmo != -1)
    {
        CT(ctmo); CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s, %d %s, and %d %s",PLUR(ctmo,"month","months"),PLUR(ctw,"week","weeks"),PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctw != -1)
    {
        CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s, and %d %s",PLUR(ctw,"week","weeks"),PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctd != -1)
    {
        CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, and %d %s",PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(cth != -1)
    {
        CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, and %d %s",PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctm != -1)
    {
        CT(ctm);
        format(strii, sizeof(strii), "%d %s, and %d %s",PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    format(strii, sizeof(strii), "%d %s", PLUR(cts,"second","seconds"));
    return strii;
}
stock AddDay(d1,m1,y1,d2)
{
	new td, tm, ty, fix=0, sdate[32];
	td = d1+d2; tm=m1; ty=y1;
	while (fix != 1) {
		switch(tm) {
			case 1, 3, 5, 7, 8, 10:{
				if (td > 31) {
					td = td-31;
					tm = tm+1;
				}
				else fix = 1;
			}
			case 2: {
				if(ty%4==0 && ty%100!=0 || ty%400==0) {
					if (td > 29) {
						td = td-29;
						tm = tm+1;
					}
					else fix = 1;
				}
				else {
					if (td > 28) {
						td = td-28;
						tm = tm+1;
					}
					else fix = 1;
				}
			}
			case 4, 6, 9, 11: {
				if (td > 30) {
					td = td-30;
					tm = tm+1;
				}
				else fix = 1;
			}
			case 12: {
				if (td > 31) {
					td = td-31;
					tm = 1;
					ty = ty+1;
				}
				else fix = 1;
			}
		}
	}//End while
	format(sdate, sizeof(sdate), "%02d-%02d-%d", td, tm, ty);
	return sdate;
}

stock dateFromTimestamp( timestamp, _form=0 )
{
    /*
        ~ convert a Timestamp to a Date.
        ~ 10.07.2009

        date( 1247182451 )  will print >> 09.07.2009-23:34:11
        date( 1247182451, 1) will print >> 09/07/2009, 23:34:11
        date( 1247182451, 2) will print >> July 09, 2009, 23:34:11
        date( 1247182451, 3) will print >> 9 Jul 2009, 23:34
    */
    new year=1970, day=0, month=0, hour=0, mins=0, sec=0;

    new days_of_month[12] = { 31,28,31,30,31,30,31,31,30,31,30,31 };
    new names_of_month[12][10] = {"January","February","March","April","May","June","July","August","September","October","November","December"};
    new returnString[32];

    while(timestamp>31622400){
        timestamp -= 31536000;
        if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) timestamp -= 86400;
        year++;
    }

    if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )
        days_of_month[1] = 29;
    else
        days_of_month[1] = 28;


    while(timestamp>86400){
        timestamp -= 86400, day++;
        if(day==days_of_month[month]) day=0, month++;
    }

    while(timestamp>60){
        timestamp -= 60, mins++;
        if( mins == 60) mins=0, hour++;
    }

    sec=timestamp;

    switch( _form ){
        case 1: format(returnString, 31, "%02d/%02d/%d %02d:%02d:%02d", day+1, month+1, year, hour, mins, sec);
        case 2: format(returnString, 31, "%s %02d, %d, %02d:%02d:%02d", names_of_month[month],day+1,year, hour, mins, sec);
        case 3: format(returnString, 31, "%d %c%c%c %d, %02d:%02d", day+1,names_of_month[month][0],names_of_month[month][1],names_of_month[month][2], year,hour,mins);

        default: format(returnString, 31, "%02d.%02d.%d-%02d:%02d:%02d", day+1, month+1, year, hour, mins, sec);
    }

    return returnString;
}

stock unixTimeConvert(timestamp, compare = -1) {
    if(compare == -1)
		compare = gettime();

    new
        n,
        Float:d = (timestamp > compare) ? timestamp - compare : compare - timestamp,
        returnstr[32];

    if (d < 60) {
        format(returnstr, sizeof(returnstr), "< 1 minute");
        return returnstr;
    } else if (d < 3600) { // 3600 = 1 hour
        n = floatround(floatdiv(d, 60.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "minute");
    } else if (d < 86400) { // 86400 = 1 day
        n = floatround(floatdiv(d, 3600.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "hour");
    } else if (d < 2592000) { // 2592000 = 1 month
        n = floatround(floatdiv(d, 86400.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "day");
    } else if (d < 31536000) { // 31536000 = 1 year
        n = floatround(floatdiv(d, 2592000.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "month");
    } else {
        n = floatround(floatdiv(d, 31536000.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "year");
    }

    if (n == 1) {
        format(returnstr, sizeof(returnstr), "1 %s", returnstr);
    } else {
        format(returnstr, sizeof(returnstr), "%d %ss", n, returnstr);
    }
    return returnstr;
}

IsValidIP(ip[])
{
    new a;
	for (new i = 0; i < strlen(ip); i++)
	{
		if (ip[i] == '.')
		{
		    a++;
		}
	}
	if (a != 3)
	{
	    return 1;
	}
	return 0;
}

CheckBan(ip[])
{
	new String[20];
    new File: file = fopen("ban.cfg", io_read);
	while(fread(file, String))
	{
	    if (strcmp(ip, String, true, strlen(ip)) == 0)
	    {
	        fclose(file);
	        return 1;
	    }
	}
	fclose(file);
	return 0;
}

AddBan(ip[])
{
	if (CheckBan(ip) == 0)
	{
		new File: file = fopen("ban.cfg", io_append);
		new String[20];
		format(String, sizeof(String), "%s\r\n", ip);
	 	fwrite(file, String);
	 	fclose(file);
	 	foreach(Player, playerid)
		{
		    new playerIP[16];
			GetPlayerIp(playerid, playerIP, sizeof(playerIP));
			if (strcmp(playerIP, ip) == 0)
			{
			    new String2[500];
    			format(String2, sizeof(String2), "Akun atau IP anda telah di banned!\n\n{FFFFFF}Account: {FF0000}%s\n{FFFFFF}IP: {FF0000}%s\n{FFFFFF}Di banned oleh: {FF0000}%s\n{FFFFFF}Alasan: %s\n{FFFFFF}Pada Waktu: {FF0000}%s | {FFFFFF}Tanggal: {FF0000}%s\n\n{FFFFFF}Sihlakan Post forum bagian unban request",PlayerInfo[playerid][pNormalName],PlayerInfo[playerid][pIP],PlayerInfo[playerid][pAdminban],PlayerInfo[playerid][pBanReason],PlayerInfo[playerid][pBanExpired],PlayerInfo[playerid][pBanExpired2]);
				ShowPlayerDialog(playerid,BAN_DIALOG,DIALOG_STYLE_MSGBOX,"BANNED",String2,":(","");
	            SendClientMessage(playerid, COLOR_WHITE, "SERVER: You are banned from this server.");
				//Kick(playerid);
			}
		}
		return 1;
	}
	return 0;
}

RemoveBan(ip[])
{
    if (CheckBan(ip) == 1)
	{
	    new String[20];
		new File: file = fopen("ban.cfg", io_read);
		fcreate("tempBan.cfg");
		new File: file2 = fopen("tempBan.cfg", io_append);
		while(fread(file, String))
		{
			if (strcmp(ip, String, true, strlen(ip)) != 0 && strcmp("\n", String) != 0)
		    {
				fwrite(file2, String);
			}
		}
		fclose(file);
		fclose(file2);
		file = fopen("ban.cfg", io_write);
		file2 = fopen("tempBan.cfg", io_read);
		while(fread(file2, String))
		{
			fwrite(file, String);
		}
		fclose(file);
		fclose(file2);
		fremove("tempBan.cfg");
		return 1;
    }
	return 0;
}

stock GetPlayersName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}
stock IsValidSkin(skinid)
{
	if (skinid < 0 || skinid > 311)
	    return 0;

	switch (skinid)
	{
	    case
		0, 105, 106, 107, 102, 103, 69, 123,
		104, 114, 115, 116, 174, 175, 100, 247, 173,
		248, 117, 118, 147, 163, 21, 24, 143, 71,
		156, 176, 177, 108, 109, 110, 165, 166,
		265, 266, 267, 269, 270, 271, 274, 276,
		277, 278, 279, 280, 281, 282, 283, 284,
		285, 286, 287, 288, 294, 296, 297: return 0;
	}

	return 1;
}

stock GetVehicleSpeed(vehicleid, get3d)
{
	new Float:x, Float:y, Float:z;
	GetVehicleVelocity(vehicleid, x, y, z);
	return SpeedCheck(x, y, z, 100.0, get3d);
}

stock strfindcount(subString[], String[], bool:ignorecase = false, startpos = 0)
{
	new ncount, start = strfind(String, subString, ignorecase, startpos);
	while(start >- 1)
	{
		start = strfind(String, subString, ignorecase, start + strlen(subString));
		ncount++;
	}
	return ncount;
}

stock IsValidVehicleID(vehicleid)
{
   if(GetVehicleModel(vehicleid)) return 1;
   return 0;
}

public CloseCourtGate1()
{
	MoveDynamicObject(courtgates[0],2138.00000000,1316.72106934,7698.23632812,4);
	return 1;
}
public CloseCourtGate2()
{
	MoveDynamicObject(courtgates[1],2138.00292969,1290.96386719,7698.24169922,4);
	return 1;
}
public CloseWestLobby()
{
	MoveDynamicObject(westlobby1,239.71582031,116.09179688,1002.21502686,4);
	MoveDynamicObject(westlobby2,239.67968750,119.09960938,1002.21502686,4);
	return 1;
}
public CloseEastLobby()
{
	MoveDynamicObject(eastlobby1,253.14941406,110.59960938,1002.21502686,4);
	MoveDynamicObject(eastlobby2,253.18457031,107.59960938,1002.21502686,4);
	return 1;
}
public CloseBlastDoor()
{
	MoveDynamicObject(blastdoor[0],-764.11816406,2568.81445312,10021.5,2);
	return 1;
}
public CloseBlastDoor2()
{
    MoveDynamicObject(blastdoor[1],-746.02636719,2535.19433594,10021.5,2);
	return 1;
}
public CloseBlastDoor3()
{
	MoveDynamicObject(blastdoor[2],-765.26171875,2552.31347656,10021.5,2);
	return 1;
}
public CloseCage()
{
   	MoveDynamicObject(cage,-773.52050781,2545.62109375,10022.29492188,2);
	return 1;
}
public CloseLocker()
{
	MoveDynamicObject(locker1,267.29980469,112.56640625,1003.61718750,4);
	MoveDynamicObject(locker2,264.29980469,112.52929688,1003.61718750,4);
	return 1;
}
public CloseEntranceDoor()
{
    MoveDynamicObject(entrancedoor,-766.27539062,2536.58691406,10019.5,2);
	return 1;
}
public CloseCCTV()
{
	MoveDynamicObject(cctv1,264.44921875,115.79980469,1003.61718750,4);
	MoveDynamicObject(cctv2,267.46875000,115.83691406,1003.61718750,4);
	return 1;
}
public CloseChief()
{
	MoveDynamicObject(chief1,229.59960938,119.50000000,1009.21875000,4);
	MoveDynamicObject(chief2,232.59960938,119.53515625,1009.21875000,4);
	return 1;
}
public CloseChiefFbi()
{
	MoveDynamicObject(fbichief1,232.9210, 107.6005, 1009.2137,4);
	MoveDynamicObject(fbichief2,232.8668, 110.5419, 1009.2137,4);
	return 1;
}
public CloseSASD1()
{
	MoveDynamicObject(sasd1A,2511.65332031,-1697.00976562,561.79223633,4);
	MoveDynamicObject(sasd1B,2514.67211914,-1696.97485352,561.79223633,4);
	return 1;
}
public CloseSASD2()
{
	MoveDynamicObject(sasd2A,2516.87548828,-1697.01525879,561.79223633,4);
	MoveDynamicObject(sasd2B,2519.89257812,-1696.97509766,561.79223633,4);
	return 1;
}
public CloseSASD3()
{
	MoveDynamicObject(sasd3A,2522.15600586,-1697.01550293,561.79223633,4);
	MoveDynamicObject(sasd3B,2525.15893555,-1696.98010254,561.79223633,4);
	return 1;
}
public CloseSASD4()
{
	MoveDynamicObject(sasd4A,2511.84130859,-1660.08081055,561.79528809,4);
	MoveDynamicObject(sasd4B,2514.81982422,-1660.04650879,561.80004883,4);
	return 1;
}
public CloseSASD5()
{
	MoveDynamicObject(sasd5A,2522.86059570,-1660.07177734,561.80206299,4);
	MoveDynamicObject(sasd5B,2519.84228516,-1660.10888672,561.80004883,4);
	return 1;
}
public CloseSANewsStudio()
{
	MoveDynamicObject(SANewsStudioA,625.60937500,-10.80000019,1106.96081543,4);
	MoveDynamicObject(SANewsStudioB,625.64941406,-13.77000046,1106.96081543,4);
	return 1;
}
public CloseSANewsPrivate()
{
	MoveDynamicObject(SANewsPrivateA,625.61999512,-0.55000001,1106.96081543,4);
	MoveDynamicObject(SANewsPrivateB,625.65002441,-3.54999995,1106.96081543,4);
	return 1;
}
public CloseSANewsOffice()
{
	MoveDynamicObject(SANewsOfficeA,614.66998291,17.82812500,1106.98425293,4);
	MoveDynamicObject(SANewsOfficeB,617.69000244,17.86899948,1106.98425293,4);
	return 1;
}

ExecuteNOPAction(playerid)
{
	new String[10000];
	new newcar = GetPlayerVehicleID(playerid);
	if(NOPTrigger[playerid] >= MAX_NOP_WARNINGS) { return 1; }
	NOPTrigger[playerid]++;
	RemovePlayerFromVehicle(playerid);
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	AC_BS_SetPlayerPos(playerid, X, Y, Z+2);
	NOPCheck(playerid);
	if(NOPTrigger[playerid] > 1)
	{
		new sec = (NOPTrigger[playerid] * 5000)/1000-1;
		format(String, sizeof(String), "{FF6347}AdmCmd: %s (ID %d) may be NOP hacking - restricted vehicle (model %d) for %d seconds.", PlayerInfo[playerid][pNormalName], playerid, GetVehicleModel(newcar),sec);
		ABroadCast(COLOR_YELLOW, String, 1);
	}
	return 1;
}

Random(min, max)
{
    new a = random(max - min) + min;
    return a;
}

stock SendReportToQue(reportfrom, report[])
{
    new bool:breakingloop = false, newid = INVALID_REPORT_ID;

	for(new i=0;i<MAX_REPORTS;i++)
	{
		if(!breakingloop)
		{
			if(Reports[i][HasBeenUsed] == 0)
			{
				breakingloop = true;
				newid = i;
			}
		}
    }
    if(newid != INVALID_REPORT_ID)
    {
        strmid(Reports[newid][Report], report, 0, strlen(report), 128);
        Reports[newid][ReportFrom] = reportfrom;
        Reports[newid][TimeToExpire] = 5;
        Reports[newid][HasBeenUsed] = 1;
        Reports[newid][BeingUsed] = 1;
        Reports[newid][ReportExpireTimer] = SetTimerEx("ReportTimer", 60000, 0, "d", newid);
        new String[10000];
        format(String, sizeof(String), "{F7FF00}[REPORT:%d]{00CCFF}%s[id:%d]\n.", newid, GetPlayerNameEx(reportfrom), reportfrom);
        ABroadCast(COLOR_WHITE,String,1);
        format(String, sizeof(String), "{00FF00}[Reason Report]:%s", (report));
        ABroadCast(COLOR_WHITE,String,1);
    }
    else
    {
        ClearReports();
        SendReportToQue(reportfrom, report);
    }
}

public ClearReports()
{
	for(new i=0;i<MAX_REPORTS;i++)
	{
		strmid(Reports[i][Report], "None", 0, 4, 4);
		Reports[i][CheckingReport] = 999;
        Reports[i][ReportFrom] = 999;
        Reports[i][TimeToExpire] = 5;
        Reports[i][HasBeenUsed] = 0;
        Reports[i][BeingUsed] = 0;
	}
	return 1;
}

stock GetDistanceToCar(playerid, veh, Float: posX = 0.0, Float: posY = 0.0, Float: posZ = 0.0) {

	new
	    Float: Floats[2][3];

	if(posX == 0.0 && posY == 0.0 && posZ == 0.0) {
		if(!IsPlayerInAnyVehicle(playerid)) GetPlayerPos(playerid, Floats[0][0], Floats[0][1], Floats[0][2]);
		else GetVehiclePos(GetPlayerVehicleID(playerid), Floats[0][0], Floats[0][1], Floats[0][2]);
	}
	else {
		Floats[0][0] = posX;
		Floats[0][1] = posY;
		Floats[0][2] = posZ;
	}
	GetVehiclePos(veh, Floats[1][0], Floats[1][1], Floats[1][2]);
	return floatround(floatsqroot((Floats[1][0] - Floats[0][0]) * (Floats[1][0] - Floats[0][0]) + (Floats[1][1] - Floats[0][1]) * (Floats[1][1] - Floats[0][1]) + (Floats[1][2] - Floats[0][2]) * (Floats[1][2] - Floats[0][2])));
}

stock GetClosestCar(playerid, exception = INVALID_VEHICLE_ID) {

    new
		Float: Distance,
		target = -1,
		Float: vPos[3];

	if(!IsPlayerInAnyVehicle(playerid)) GetPlayerPos(playerid, vPos[0], vPos[1], vPos[2]);
	else GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);

    for(new v; v < MAX_VEHICLES; v++) if(GetVehicleModel(v) >= 400) {
        if(v != exception && (target < 0 || Distance > GetDistanceToCar(playerid, v, vPos[0], vPos[1], vPos[2]))) {
            target = v;
            Distance = GetDistanceToCar(playerid, v, vPos[0], vPos[1], vPos[2]); // Before the rewrite, we'd be running GetPlayerPos 2000 times...
        }
    }
    return target;
}

forward Three();
public Three()
{
 	SendClientMessageToAllEx(COLOR_LIGHTBLUE, "3");
	return 1;
}

forward Two();
public Two()
{
	SendClientMessageToAllEx(COLOR_LIGHTBLUE, "2");
	return 1;
}

forward One();
public One()
{
	SendClientMessageToAllEx(COLOR_LIGHTBLUE, "1");
 	return 1;
}

forward BackupClear(playerid, calledbytimer);
public BackupClear(playerid, calledbytimer)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLeader] == 3 || PlayerInfo[playerid][pLeader] == 12 || gTeam[playerid] == 2 || IsACop(playerid) || PlayerInfo[playerid][pMember] == 4 && PlayerInfo[playerid][pDivision] == 2 || PlayerInfo[playerid][pMember] == 4 && PlayerInfo[playerid][pRank] >= 5)
		{
			if (Backup[playerid] == 1)
			{
			    foreach(Player, i)
				{
					if(gTeam[i] == 2 || IsACop(i))
					{
						SetPlayerMarkerForPlayer(i, playerid, TEAM_HIT_COLOR);
					}
				}
				SetPlayerToTeamColor(playerid);
				if (calledbytimer != 1)
				{
					SendClientMessageEx(playerid, COLOR_GRAD2, "Your backup request has been cleared.");
				}
				else
				{
					SendClientMessageEx(playerid, COLOR_GRAD2, "Your backup request has been cleared automatically.");
				}
				Backup[playerid] = 0;
			}
			else
			{
				if (calledbytimer != 1)
				{
					SendClientMessageEx(playerid, COLOR_GRAD2, "You don't have an active backup request!");
				}
			}
		}
		else
		{
			if (calledbytimer != 1)
			{
				SendClientMessageEx(playerid, COLOR_GREY, "   You are not a Cop / FBI!");
			}
		}
	}
	return 1;
}

forward ClearDrugs(playerid);
public ClearDrugs(playerid)
{
	UsedWeed[playerid] = 0;
	UsedCrack[playerid] = 0;
	return 1;
}

stock PlayerFacePlayer( playerid, targetplayerid )
{
	new Float: Angle;
	GetPlayerFacingAngle( playerid, Angle );
	SetPlayerFacingAngle( targetplayerid, Angle+180 );
	return true;
}

stock GivePlayerEventWeapons( playerid )
{
	if( GetPVarInt( playerid, "EventToken" ) == 1 )
	{
		GivePlayerWeapon( playerid, EventKernel[ EventWeapons ][ 0 ], 60000 );
		GivePlayerWeapon( playerid, EventKernel[ EventWeapons ][ 1 ], 60000 );
		GivePlayerWeapon( playerid, EventKernel[ EventWeapons ][ 2 ], 60000 );
		GivePlayerWeapon( playerid, EventKernel[ EventWeapons ][ 3 ], 60000 );
		GivePlayerWeapon( playerid, EventKernel[ EventWeapons ][ 4 ], 60000 );
	}

	return 1;
}

DollahScoreUpdate()
{
	new LevScore;
	foreach(Player, i)
	{
   		LevScore = PlayerInfo[i][pLevel];
		SetPlayerScore(i, LevScore);
	}
	return 1;
}

stock GetMonth(month)
{
	new monthname[24];
	switch(month)
	{
	    case 1: monthname = "Januari";
	    case 2: monthname = "Februari";
	    case 3: monthname = "Maret";
	    case 4: monthname = "April";
	    case 5: monthname = "May";
	    case 6: monthname = "Juni";
	    case 7: monthname = "Juli";
	    case 8: monthname = "Agustus";
	    case 9: monthname = "September";
	    case 10: monthname = "Oktober";
	    case 11: monthname = "November";
	    case 12: monthname = "Desember";
		default: monthname = "Unknown";
	}
	return monthname;
}

stock crc32(String[])
{
	new crc_table[256] = {
			0x00000000, 0x77073096, 0xEE0E612C, 0x990951BA, 0x076DC419, 0x706AF48F, 0xE963A535,
			0x9E6495A3, 0x0EDB8832, 0x79DCB8A4, 0xE0D5E91E, 0x97D2D988, 0x09B64C2B, 0x7EB17CBD,
			0xE7B82D07, 0x90BF1D91, 0x1DB71064, 0x6AB020F2, 0xF3B97148, 0x84BE41DE, 0x1ADAD47D,
			0x6DDDE4EB, 0xF4D4B551, 0x83D385C7, 0x136C9856, 0x646BA8C0, 0xFD62F97A, 0x8A65C9EC,
			0x14015C4F, 0x63066CD9, 0xFA0F3D63, 0x8D080DF5, 0x3B6E20C8, 0x4C69105E, 0xD56041E4,
			0xA2677172, 0x3C03E4D1, 0x4B04D447, 0xD20D85FD, 0xA50AB56B, 0x35B5A8FA, 0x42B2986C,
			0xDBBBC9D6, 0xACBCF940, 0x32D86CE3, 0x45DF5C75, 0xDCD60DCF, 0xABD13D59, 0x26D930AC,
			0x51DE003A, 0xC8D75180, 0xBFD06116, 0x21B4F4B5, 0x56B3C423, 0xCFBA9599, 0xB8BDA50F,
			0x2802B89E, 0x5F058808, 0xC60CD9B2, 0xB10BE924, 0x2F6F7C87, 0x58684C11, 0xC1611DAB,
			0xB6662D3D, 0x76DC4190, 0x01DB7106, 0x98D220BC, 0xEFD5102A, 0x71B18589, 0x06B6B51F,
			0x9FBFE4A5, 0xE8B8D433, 0x7807C9A2, 0x0F00F934, 0x9609A88E, 0xE10E9818, 0x7F6A0DBB,
			0x086D3D2D, 0x91646C97, 0xE6635C01, 0x6B6B51F4, 0x1C6C6162, 0x856530D8, 0xF262004E,
			0x6C0695ED, 0x1B01A57B, 0x8208F4C1, 0xF50FC457, 0x65B0D9C6, 0x12B7E950, 0x8BBEB8EA,
			0xFCB9887C, 0x62DD1DDF, 0x15DA2D49, 0x8CD37CF3, 0xFBD44C65, 0x4DB26158, 0x3AB551CE,
			0xA3BC0074, 0xD4BB30E2, 0x4ADFA541, 0x3DD895D7, 0xA4D1C46D, 0xD3D6F4FB, 0x4369E96A,
			0x346ED9FC, 0xAD678846, 0xDA60B8D0, 0x44042D73, 0x33031DE5, 0xAA0A4C5F, 0xDD0D7CC9,
			0x5005713C, 0x270241AA, 0xBE0B1010, 0xC90C2086, 0x5768B525, 0x206F85B3, 0xB966D409,
			0xCE61E49F, 0x5EDEF90E, 0x29D9C998, 0xB0D09822, 0xC7D7A8B4, 0x59B33D17, 0x2EB40D81,
			0xB7BD5C3B, 0xC0BA6CAD, 0xEDB88320, 0x9ABFB3B6, 0x03B6E20C, 0x74B1D29A, 0xEAD54739,
			0x9DD277AF, 0x04DB2615, 0x73DC1683, 0xE3630B12, 0x94643B84, 0x0D6D6A3E, 0x7A6A5AA8,
			0xE40ECF0B, 0x9309FF9D, 0x0A00AE27, 0x7D079EB1, 0xF00F9344, 0x8708A3D2, 0x1E01F268,
			0x6906C2FE, 0xF762575D, 0x806567CB, 0x196C3671, 0x6E6B06E7, 0xFED41B76, 0x89D32BE0,
			0x10DA7A5A, 0x67DD4ACC, 0xF9B9DF6F, 0x8EBEEFF9, 0x17B7BE43, 0x60B08ED5, 0xD6D6A3E8,
			0xA1D1937E, 0x38D8C2C4, 0x4FDFF252, 0xD1BB67F1, 0xA6BC5767, 0x3FB506DD, 0x48B2364B,
			0xD80D2BDA, 0xAF0A1B4C, 0x36034AF6, 0x41047A60, 0xDF60EFC3, 0xA867DF55, 0x316E8EEF,
			0x4669BE79, 0xCB61B38C, 0xBC66831A, 0x256FD2A0, 0x5268E236, 0xCC0C7795, 0xBB0B4703,
			0x220216B9, 0x5505262F, 0xC5BA3BBE, 0xB2BD0B28, 0x2BB45A92, 0x5CB36A04, 0xC2D7FFA7,
			0xB5D0CF31, 0x2CD99E8B, 0x5BDEAE1D, 0x9B64C2B0, 0xEC63F226, 0x756AA39C, 0x026D930A,
			0x9C0906A9, 0xEB0E363F, 0x72076785, 0x05005713, 0x95BF4A82, 0xE2B87A14, 0x7BB12BAE,
			0x0CB61B38, 0x92D28E9B, 0xE5D5BE0D, 0x7CDCEFB7, 0x0BDBDF21, 0x86D3D2D4, 0xF1D4E242,
			0x68DDB3F8, 0x1FDA836E, 0x81BE16CD, 0xF6B9265B, 0x6FB077E1, 0x18B74777, 0x88085AE6,
			0xFF0F6A70, 0x66063BCA, 0x11010B5C, 0x8F659EFF, 0xF862AE69, 0x616BFFD3, 0x166CCF45,
			0xA00AE278, 0xD70DD2EE, 0x4E048354, 0x3903B3C2, 0xA7672661, 0xD06016F7, 0x4969474D,
			0x3E6E77DB, 0xAED16A4A, 0xD9D65ADC, 0x40DF0B66, 0x37D83BF0, 0xA9BCAE53, 0xDEBB9EC5,
			0x47B2CF7F, 0x30B5FFE9, 0xBDBDF21C, 0xCABAC28A, 0x53B39330, 0x24B4A3A6, 0xBAD03605,
			0xCDD70693, 0x54DE5729, 0x23D967BF, 0xB3667A2E, 0xC4614AB8, 0x5D681B02, 0x2A6F2B94,
			0xB40BBE37, 0xC30C8EA1, 0x5A05DF1B, 0x2D02EF8D
	};
	new crc = -1;
	for(new i = 0; i < strlen(String); i++)
	{
 		crc = ( crc >>> 8 ) ^ crc_table[(crc ^ String[i]) & 0xFF];
  	}
  	return crc ^ -1;
}
stock right(source[], len)
{
	new retval[MAX_STRING], srclen;
	srclen = strlen(source);
	strmid(retval, source, srclen - len, srclen, MAX_STRING);
	return retval;
}
GetPlayerNameEx(playerid) {

	new
		sz_playerName[MAX_PLAYER_NAME],
		i_pos;

	GetPlayerName(playerid, sz_playerName, MAX_PLAYER_NAME);
	while ((i_pos = strfind(sz_playerName, "_", false, i_pos)) != -1) sz_playerName[i_pos] = ' ';
	return sz_playerName;
}
stock fcopy(oldname[],newname[])
{
	new File:ohnd,File:nhnd;
	if (!fexist(oldname))
	{
		return 0;
	}
	ohnd=fopen(oldname,io_read);
	nhnd=fopen(newname,io_write);
	new buf2[1];
	for (new i=flength(ohnd);i>0;i--)
	{
		fputchar(nhnd, fgetchar(ohnd, buf2[0],false),false);
	}
	fclose(ohnd);
	fclose(nhnd);
	return 1;
}
stock StripNewLine(String[])
{
  new len = strlen(String);
  if (String[0]==0) return ;
  if ((String[len - 1] == '\n') || (String[len - 1] == '\r'))
    {
      String[len - 1] = 0;
      if (String[0]==0) return ;
      if ((String[len - 2] == '\n') || (String[len - 2] == '\r')) String[len - 2] = 0;
    }
}
stock frename(oldname[],newname[])
{
	if(!fexist(oldname)) return false;
	new String[255], File:old, File:neww;
	old = fopen(oldname, io_read);
	neww = fopen(newname, io_write);
	while(fread(old, String)){
		StripNewLine(String);
		format(String,sizeof(String),"%s\r\n",String);
		fwrite(neww, String);
	}
	fclose(old);
	fclose(neww);
	fremove(oldname);
	return true;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
 	Seatbelt[playerid] = 0;
	IsPlayerSteppingInVehicle[playerid] = vehicleid;
	if(PlayerCuffed[playerid] != 0) SetPVarInt( playerid, "ToBeEjected", 1 );
	if(GetPVarInt(playerid, "Injured") == 1) SetPVarInt(playerid, "ToBeEjected", 1);
	SetPVarInt(playerid, "LastWeapon", GetPlayerWeapon(playerid));
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	if(engine == VEHICLE_PARAMS_UNSET) switch(GetVehicleModel(vehicleid)) {
		case 509, 481, 510: VehicleFuel[vehicleid] = 100, arr_Engine{vehicleid} = 1, SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
		default: SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_OFF,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective), arr_Engine{vehicleid} = 0;
	}
    if(GetVehicleModel(vehicleid) == 519 && ispassenger == 1)
    {
    	PutPlayerInVehicle(playerid, vehicleid, 1);
    	TogglePlayerControllable(playerid, 1);
    	InsideShamal[playerid] = vehicleid;
    }
	else if(!IsPlayerInRangeOfVehicle(playerid, 7.5) || LockStatus[vehicleid] >= 1) { // G-ging fix
		ClearAnimations(playerid);
	}
	return 1;
}

IsACop(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new leader = PlayerInfo[playerid][pLeader];
		new member = PlayerInfo[playerid][pMember];
		if(member==1 || member==2 || member== 3 || member==5 || member==3 || member==6 || member==7 || member==11 || member==13)
		{
			return 1;
		}
		else if(leader==1 || leader==2 || leader == 3 || leader==5 || leader==3 || leader==6 || leader==7 || leader==11 || leader==13)
		{
			return 1;
		}
 	}
	return 0;
}

stock IsMDCPermitted(playerid)
{
	if(	PlayerInfo[playerid][pMember] == 3|| PlayerInfo[playerid][pLeader] == 3 ||
		PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLeader] == 1||
		PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pLeader] == 2 ||
		PlayerInfo[playerid][pLeader] == 5 || PlayerInfo[playerid][pLeader] == 6 ||
		PlayerInfo[playerid][pMember] == 6 || PlayerInfo[playerid][pLeader] == 7 ||
		PlayerInfo[playerid][pMember] == 7 || PlayerInfo[playerid][pMember] == 11 ||
		PlayerInfo[playerid][pLeader] == 11 || PlayerInfo[playerid][pMember] == 13 ||
		PlayerInfo[playerid][pLeader] == 13)
	{
		return 1;
	}
	return 0;
}

stock GetFactionNameEx(amount)
{
	new String[56];
	if(amount == 1)
	{
	    String = "San Andreas Police Department";
	}
	if(amount == 2)
	{
	    String = "FBI";
	}
	if(amount == 3)
	{
	    String = "SFPD";
	}
	if(amount == 4)
	{
	    String = "San Andreas Medic Department";
	}
	if(amount == 5)
	{
	    String = "";
	}
	if(amount == 6)
	{
	    String = "San Andreas Goverment Service";
	}
	if(amount == 7)
	{
	    String = "SASD";
	}
	if(amount == 9)
	{
	    String = "San Andreas Network";
	}
	if(amount == 10)
	{
	    String = "Transport Company";
	}
	return String;
}

stock GetPlayerFactionInfo(targetid, rank[64], division[64], employer[64])
{
	switch (PlayerInfo[targetid][pMember]) // employer/rank/division data is pulled from here
	{
	    case 1:
		{
            employer = "San Andreas Police Department";
			switch(PlayerInfo[targetid][pRank])
			{
			    case 1: rank = "PD Officer I";
			    case 2: rank = "PD Officer II";
			    case 3: rank = "PD Officer III";
			    case 4: rank = "Sergeant I";
			    case 5: rank = "Sergeant II";
			    case 6: rank = "Lieutenant";
			    case 7: rank = "Captain";
			    case 8: rank = "Commander";
			    case 9: rank = "Deputy Of Chief";
			    case 10: rank = "Chief Of Police";
			    default: rank = "Cadet";
			}
			switch(PlayerInfo[targetid][pDivision])
			{
			    case 1: division = "General Duties";
			    case 2: division = "II";
			    case 3: division = "FTO";
			    case 4: division = "IA";
			    case 5: division = "SWAT";
			    default: division = "General Duties";
			}
		}
  		case 2:
		{
            employer = "FBI";
			switch(PlayerInfo[targetid][pRank])
			{
			    case 1: rank = "Staff";
			    case 2: rank = "Agent";
			    case 3: rank = "Senior Agent";
			    case 4: rank = "Special Agent";
			    case 5: rank = "Assistant Director";
			    case 6: rank = "Director";
			    default: rank = "Intern";
			}
			switch(PlayerInfo[targetid][pDivision])
			{
			    case 1: division = "General Duties";
			    case 2: division = "GU";
			    case 3: division = "FAN";
			    case 4: division = "CID";
			    case 5: division = "IA";
				case 6: division = "NSB";
			    default: division = "General Duties";
			}
		}
  		case 3:
		{
            employer = "SFPD";
			switch(PlayerInfo[targetid][pRank])
			{
				case 1: rank = "Officer";
				case 2: rank = "Corporal";
				case 3: rank = "Sergeant";
				case 4: rank = "Lieutenant";
				case 5: rank = "Captain";
				case 6: rank = "Chief";
				default: rank = "Cadet";
			}
			switch(PlayerInfo[targetid][pDivision])
			{
			    case 1: division = "HR";
				case 2: division = "ERT";
			    case 3: division = "IA";
			    case 4: division = "SO";
			    default: division = "General Duties";
			}
		}
  		case 4:
		{
            employer = "San Andreas Medical Department";
			switch(PlayerInfo[targetid][pRank])
			{
				case 1: rank = "EMT Paramedic I";
				case 2: rank = "EMT Paramedic II";
				case 3: rank = "Senior Paramedic";
				case 4: rank = "Doctor Medic I";
				case 5: rank = "Doctor Medic II";
				case 6: rank = "Head Of Paramedic";
				case 7: rank = "Supervisor I";
				case 8: rank = "Supervisor II";
				case 9: rank = "Deputy of Chief";
				case 10: rank = "Chief of Medic";
				default: rank = "Volunteer";
			}
			switch(PlayerInfo[targetid][pDivision])
			{
			    case 1: division = "FD";
			    case 2: division = "Life Flight";
			    case 3: division = "T&R";
			    default: division = "General Duties";
			}
		}
		case 5:
		{
	        employer = "";
			switch(PlayerInfo[targetid][pRank])
			{
				case 1: rank = "Clerk of Court";
				case 2: rank = "District Attorney";
				case 3: rank = "District Judge";
				case 4: rank = "Appellate Judge";
				case 5: rank = "Associate Justice of the Supreme Court";
				case 6: rank = "Chief Justice of the Supreme Court";
				default: rank = "Clerk of Court";
			}
			division = "None";
		}
  		case 6:
		{
            employer = "San Andreas Goverment Service";
			switch(PlayerInfo[targetid][pRank])
			{
				case 1: rank = "Officer";
				case 2: rank = "Officer I";
                case 3: rank = "Officer II";
                case 4: rank = "Sergeant";
                case 5: rank = "Sergeant I";
				case 6: rank = "Sergeant II";
				case 7: rank = "Captain";
				case 8: rank = "Major";
				case 9: rank = "Deputy Warden";
				case 10: rank = "Warden";
				default: rank = "Intern";
			}
			division = "None";
		}
  		case 7:
		{
	        employer = "SASD";
			switch(PlayerInfo[targetid][pRank])
			{
				case 1: rank = "Deputy Sheriff Generalist I";
				case 2: rank = "Deputy Sheriff";
				case 3: rank = "Senior Of Deputy Sheriff";
				case 4: rank = "Corporal Of Sheriff";
				case 5: rank = "Lieutenant Sheriff";
				case 6: rank = "Commander Of Sheriff I";
				case 7: rank = "Commander Of Sheriff II";
				case 8: rank = "Assistant Chief Of Sheriff";
				case 9: rank = "Senior Of Assistant Sheriff";
				case 10: rank = "Chief Of Sheriff";
				default: rank = "Deputy";
			}
			switch(PlayerInfo[targetid][pDivision])
			{
			    case 2: division = "TET";
			    case 3: division = "SCU";
			    case 4: division = "SORT";
			    case 5: division = "FTO";
			    default: division = "General Duties";
			}
		}
		case 9:
		{
			employer = "San Andreas Network";
			switch(PlayerInfo[targetid][pRank])
			{
				case 1: rank = "Reporter";
				case 2: rank = "Reporter I";
				case 3: rank = "Reporter II";
				case 4: rank = "Editor";
				case 5: rank = "Editor I";
				case 6: rank = "Editor II";
				case 7: rank = "Supervisor";
				case 8: rank = "HRD";
                case 9: rank = "Manager";
                case 10: rank = "CEO";
                default: rank = "Intern";
			}
			switch(PlayerInfo[targetid][pDivision])
			{
			    case 1: division = "Security";
			    case 2: division = "IA";
			    case 3: division = "Tech Support";
			    case 4: division = "TnR";
			    default: division = "General";
			}
		}
   		case 10:
		{
            employer = "Transport Company";
			switch(PlayerInfo[targetid][pRank])
			{
				case 1: rank = "Trainee";
				case 2: rank = "Driver";
				case 3: rank = "Dispatcher";
				case 4: rank = "Pilot";
				case 5: rank = "Assistant Director";
				case 6: rank = "Director";
				default: rank = "Trainee";
			}
			division = "None";
		}
	    default: { employer = "None"; division = "None"; rank = "N/A"; }
	}
	return 1;
}

IsInLSMD(playerid)
{
 	if(IsPlayerConnected(playerid))
	{
		new leader = PlayerInfo[playerid][pLeader];
		new member = PlayerInfo[playerid][pMember];
		if(member==4)
		{
			return 1;
		}
		else if(leader==4)
		{
			return 1;
		}
 	}
	return 0;
}

stock fcreate(filename[])
{
	if (fexist(filename)) return false;
	new File:fhnd;
	fhnd=fopen(filename,io_write);
	if (fhnd) {
		fclose(fhnd);
		return true;
	}
	return false;
}

IsAtArrestPoint(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0,-1606.307861, 673.740539, -5.242187) || IsPlayerInRangeOfPoint(playerid, 3.0,1528.3882,-1677.7719,5.8906) ||IsPlayerInRangeOfPoint(playerid, 3.0,295.6430,-1540.8610,24.5938) || IsPlayerInRangeOfPoint(playerid, 3.0,611.96, -587.25, 17.22) || IsPlayerInRangeOfPoint(playerid, 8.0,1379.0077,-274.9919,1.9850) || IsPlayerInRangeOfPoint(playerid, 8.0,-228.4971,985.1687,19.6088)
		|| IsPlayerInRangeOfPoint(playerid, 8.0,598.5661,-607.9127,-14.9744) || IsPlayerInRangeOfPoint(playerid, 4.0, 680.2208,-1546.9856,14.8516) || IsPlayerInRangeOfPoint(playerid, 3.0, 612.6097, -624.7800, -4.1500) || IsPlayerInRangeOfPoint(playerid, 3.0, 1772.0134,-1548.0470,9.90700))
		{//Tierra Robada + SFPD + LSPD
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 4.0,-1394.333007, 2625.446533, 55.913421) || IsPlayerInRangeOfPoint(playerid, 4.0, 1566.4901,-1653.9076,28.3956) || IsPlayerInRangeOfPoint(playerid, 3.0,2182.20, 530.32, 1.19) || IsPlayerInRangeOfPoint(playerid, 3.0,292.7859,-1530.6685,76.5391) || IsPlayerInRangeOfPoint(playerid, 3.0,2334.65, 566.84, 7.78) || PlayerInfo[playerid][pVW] == 133337 || PlayerInfo[playerid][pVW] == 4 || PlayerInfo[playerid][pVW] == 1324123)
		{//LSPD int and FBI
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 4.0, 2226.8472,2458.2598,-7.4531))
		{
		    //SASD LV
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 4.0, -800.397094, -1877.925903, 11.668975))
		{
		    //PMC
		    return 1;
		}
 }
	return 0;
}
IsAtDeliverPatientPoint(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0,1142.4733,-1326.3633,13.6259) || IsPlayerInRangeOfPoint(playerid, 5.0, 1165.1564,-1368.8240,26.6502) || IsPlayerInRangeOfPoint(playerid, 3.0,2027.0599,-1410.6870,16.9922) || IsPlayerInRangeOfPoint(playerid, 5.0, 2024.5742,-1382.7844,48.3359))
		{//ALLSAINTS, ALL SAINTS ROOF, COUNTY GENERAL, COUNTY ROOF
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 4.0, 1227.2339,306.4730,19.7028) || IsPlayerInRangeOfPoint(playerid, 5.0, 1233.3384,316.4022,24.7578) || IsPlayerInRangeOfPoint(playerid, 3.0,-339.2989,1055.8138,19.7392) || IsPlayerInRangeOfPoint(playerid, 5.0, -334.1560,1051.4434,26.0125))
		{//RED COUNTY, RED COUNTY ROOF, FORT CARSON, Fortcarson ROOF
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, -2695.5725,639.4147,14.4531) || IsPlayerInRangeOfPoint(playerid, 5.0, -2656.0339,615.2567,66.0938))
		{//SF, SF ROOF
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, -1528.814331, 2540.706054, 55.835937))
		{//Tierra Robada
			return 1;
		}
 }
	return 0;
}

IsARC(carid) // RC Vehicles
{
	new RCs[] = { 441, 464, 465, 501, 564 };
	for(new i = 0; i < sizeof(RCs); i++)
	{
	    if(GetVehicleModel(carid) == RCs[i]) return 1;
	}
	return 0;
}

IsABike(fahrzeug)
{
    new Motorads[] = { 462, 448, 581, 522, 461, 521, 523, 463, 586, 468, 471 };
    for(new i = 0; i < sizeof(Motorads); i++) {
        if(GetVehicleModel(fahrzeug) == Motorads[i]) return 1;
    }
    return 0;
}

IsAnSFPDCar(carid)
{
	for(new v = 0; v < sizeof(SFPDVehicles); v++)
	{
	    if(carid == SFPDVehicles[v]) return 1;
	}
	return 0;
}

IsAnSanNewsCar(carid)
{
	for(new v = 0; v < sizeof(SanNewsVehicles); v++)
	{
	    if(carid == SanNewsVehicles[v]) return 1;
	}
	return 0;
}
IsDMVCar(carid)
{
	for(new v = 0; v < sizeof(DMVCar); v++)
	{
		if(carid == DMVCar[v]) return 1;
	}
	return 0;
}
IsBUSCAR(carid)
{
	for(new v = 0; v < sizeof(BUS); v++)
	{
		if(carid == BUS[v]) return 1;
	}
	return 0;
}
IsSWEEPERCar(carid)
{
	for(new v = 0; v < sizeof(SWEEPER); v++)
	{
		if(carid == SWEEPER[v]) return 1;
	}
	return 0;
}
IsAnSASDCar(carid)
{
	for(new v = 0; v < sizeof(SASDVehicles); v++)
	{
	    if(carid == SASDVehicles[v]) return 1;
	}
	return 0;
}

IsAnEPCar(carid)
{
	for(new v = 0; v < sizeof(EPVehicles); v++)
	{
	    if(carid == EPVehicles[v]) return 1;
	}
	return 0;
}

IsAnWPCar(carid)
{
	for(new v = 0; v < sizeof(WPVehicles); v++)
	{
	    if(carid == WPVehicles[v]) return 1;
	}
	return 0;
}

IsAGovCar(carid)
{
	for(new v = 0; v < sizeof(GovVehicles); v++)
	{
	    if(carid == GovVehicles[v]) return 1;
	}
	for(new v = 0; v < sizeof(Crane); v++)
	{
	    if(carid == Crane[v]) return 1;
	}
	for(new v = 0; v < sizeof(Delta); v++)
	{
	    if(carid == Delta[v]) return 1;
	}
	for(new v = 0; v < sizeof(SecUnit); v++)
	{
	    if(carid == SecUnit[v]) return 1;
	}
    for(new v = 0; v < sizeof(Guard); v++)
	{
	    if(carid == Guard[v]) return 1;
	}
	for(new v = 0; v < sizeof(Cleaner); v++)
	{
	    if(carid == Cleaner[v]) return 1;
	}
	for(new v = 0; v < sizeof(Towtruck); v++)
	{
	    if(carid == Towtruck[v]) return 1;
	}
	return 0;
}

IsACopCar(carid)
{
	for(new v = 0; v < sizeof(LSPDVehicles); v++)
	{
	    if(carid == LSPDVehicles[v]) return 1;
	}
	for(new v = 0; v < sizeof(TEU); v++)
	{
	    if(carid == TEU[v]) return 1;
	}
	for(new v = 0; v < sizeof(ZeusUnit); v++)
	{
	    if(carid == ZeusUnit[v]) return 1;
	}
	for(new v = 0; v < sizeof(LincolnMerah); v++)
	{
	    if(carid == LincolnMerah[v]) return 1;
	}
	for(new v = 0; v < sizeof(LincolnUngu); v++)
 	{
	    if(carid == LincolnUngu[v]) return 1;
	}
	for(new v = 0; v < sizeof(Kopassus); v++)
	{
	    if(carid == Kopassus[v]) return 1;
	}
	for(new v = 0; v < sizeof(Lincoln); v++)
	{
	    if(carid == Lincoln[v]) return 1;
	}
	for(new v = 0; v < sizeof(Cruiser); v++)
	{
	    if(carid == Cruiser[v]) return 1;
	}
	for(new v = 0; v < sizeof(Chief); v++)
	{
	    if(carid == Chief[v]) return 1;
	}
	return 0;
}


IsATowTruck(carid)
{
	if(GetVehicleModel(carid) == 485 || GetVehicleModel(carid) == 525 || GetVehicleModel(carid) == 583 || GetVehicleModel(carid) == 574)
	{
		return 1;
	}
	return 0;
}

IsAHelicopter(carid)
{
	if(GetVehicleModel(carid) == 548 || GetVehicleModel(carid) == 425 || GetVehicleModel(carid) == 417 || GetVehicleModel(carid) == 487 || GetVehicleModel(carid) == 488 || GetVehicleModel(carid) == 497 || GetVehicleModel(carid) == 563 || GetVehicleModel(carid) == 447 || GetVehicleModel(carid) == 469 || GetVehicleModel(carid) == 593)
	{
		return 1;
	}
	return 0;
}

IsANewsCar(carid)
{
	if(GetVehicleModel(carid)== 582 || GetVehicleModel(carid)== 488)
	{
		return 1;
	}
	return 0;
}

IsAnMPSCar(carid)
{
	for(new i = 0; i < sizeof(MPSVehicles); i++)
	{
		if(MPSVehicles[ i ] == carid) return 1;
	}
	return 0;
}

IsAnAmbulance(carid)
{
	for(new v = 0; v < sizeof(LSMDVehicles); v++)
	{
	    if(carid == LSMDVehicles[v]) return 1;
	}
	return 0;
}

partType(type)
{
	new name[256];
	switch(type)
	{
	    case 0: { name = "Spoiler"; }
        case 1: { name = "Hood"; }
        case 2: { name = "Roof"; }
        case 3: { name = "Sideskirt"; }
        case 4: { name = "Lamps"; }
        case 5:	{ name = "Nitro"; }
        case 6: { name = "Exhaust"; }
        case 7: { name = "Wheels"; }
        case 8: { name = "Stereo"; }
        case 9: { name = "Hydraulics"; }
        case 10: { name = "Front Bumper"; }
        case 11: { name = "Rear Bumper"; }
        case 12: { name = "Left Vent"; }
        case 13: { name = "Right Vent"; }
        default: { name = "Unknown"; }
	}
	return name;
}

partName(part)
{
	new name[256];
	switch(part - 1000)
	{
		case 0: { name = "Pro"; }
		case 1: { name = "Win"; }
		case 2: { name = "Drag"; }
		case 3: { name = "Alpha"; }
		case 4: { name = "Champ Scoop"; }
		case 5: { name = "Fury Scoop"; }
		case 6: { name = "Roof Scoop"; }
		case 7: { name = "Sideskirt"; }
        case 8: { name = "2x"; }
        case 9: { name = "5x"; }
        case 10: { name = "10x"; }
		case 11: { name = "Race Scoop"; }
		case 12: { name = "Worx Scoop"; }
		case 13: { name = "Round Fog"; }
		case 14: { name = "Champ"; }
		case 15: { name = "Race"; }
     	case 16: { name = "Worx"; }
		case 17: { name = "Sideskirt"; }
		case 18: { name = "Upswept"; }
		case 19: { name = "Twin"; }
		case 20: { name = "Large"; }
		case 21: { name = "Medium"; }
		case 22: { name = "Small"; }
		case 23: { name = "Fury"; }
		case 24: { name = "Square Fog"; }
		case 26: { name = "Alien"; }
		case 27: { name = "Alien"; }
		case 28: { name = "Alien"; }
		case 29: { name = "X-Flow"; }
		case 30: { name = "X-Flow"; }
		case 31: { name = "X-Flow"; }
		case 32: { name = "Alien Roof Vent"; }
		case 33: { name = "X-Flow Roof Vent"; }
		case 34: { name = "Alien"; }
		case 35: { name = "X-Flow Roof Vent"; }
    	case 36: { name = "Alien"; }
		case 37: { name = "X-Flow"; }
		case 38: { name = "Alien Roof Vent"; }
		case 39: { name = "X-Flow"; }
		case 40: { name = "Alien"; }
		case 41: { name = "X-Flow"; }
		case 42: { name = "Chrome"; }
		case 43: { name = "Slamin"; }
		case 44: { name = "Chrome"; }
		case 45: { name = "X-Flow"; }
		case 46: { name = "Alien"; }
		case 47: { name = "Alien"; }
		case 48: { name = "X-Flow"; }
		case 49: { name = "Alien"; }
		case 50: { name = "X-Flow"; }
		case 51: { name = "Alien"; }
		case 52: { name = "X-Flow"; }
		case 53: { name = "X-Flow"; }
		case 54: { name = "Alien"; }
		case 55: { name = "Alien"; }
		case 56: { name = "Alien"; }
		case 57: { name = "X-Flow"; }
		case 58: { name = "Alien"; }
		case 59: { name = "X-Flow"; }
		case 60: { name = "X-Flow"; }
		case 61: { name = "X-Flow"; }
		case 62: { name = "Alien"; }
		case 63: { name = "X-Flow"; }
		case 64: { name = "Alien"; }
		case 65: { name = "Alien"; }
		case 66: { name = "X-Flow"; }
		case 67: { name = "Alien"; }
		case 68: { name = "X-Flow"; }
		case 69: { name = "Alien"; }
		case 70: { name = "X-Flow"; }
		case 71: { name = "Alien"; }
		case 72: { name = "X-Flow"; }
		case 88: { name = "Alien"; }
		case 89: { name = "X-Flow"; }
		case 90: { name = "Alien"; }
		case 91: { name = "X-Flow"; }
		case 92: { name = "Alien"; }
		case 93: { name = "X-Flow"; }
		case 94: { name = "Alien"; }
		case 95: { name = "X-Flow"; }
		case 99: { name = "Chrome"; }
		case 100: { name = "Chrome Grill"; }
        case 101: { name = "Chrome Flames"; }
		case 102: { name = "Chrome Strip"; }
		case 103: { name = "Covertible"; }
		case 104: { name = "Chrome"; }
		case 105: { name = "Slamin"; }
		case 106: { name = "Chrome Arches"; }
		case 107: { name = "Chrome Strip"; }
		case 108: { name = "Chrome Strip"; }
		case 109: { name = "Chrome"; }
		case 110: { name = "Slamin"; }
		case 113: { name = "Chrome"; }
		case 114: { name = "Slamin"; }
		case 115: { name = "Chrome"; }
		case 116: { name = "Slamin"; }
		case 117: { name = "Chrome"; }
		case 118: { name = "Chrome Trim"; }
		case 119: { name = "Wheelcovers"; }
		case 120: { name = "Chrome Trim"; }
		case 121: { name = "Wheelcovers"; }
		case 122: { name = "Chrome Flames"; }
		case 123: { name = "Bullbar Chrome Bars"; }
		case 124: { name = "Chrome Arches"; }
		case 125: { name = "Bullbar Chrome Lights"; }
		case 126: { name = "Chrome"; }
		case 127: { name = "Slamin"; }
		case 128: { name = "Vinyl Hardtop"; }
		case 129: { name = "Chrome"; }
		case 130: { name = "Hardtop"; }
		case 131: { name = "Softtop"; }
		case 132: { name = "Slamin"; }
		case 133: { name = "Chrome Strip"; }
		case 134: { name = "Chrome Strip"; }
		case 135: { name = "Slamin"; }
		case 136: { name = "Chrome"; }
		case 137: { name = "Chrome Strip"; }
		case 138: { name = "Alien"; }
		case 139: { name = "X-Flow"; }
		case 140: { name = "X-Flow"; }
		case 141: { name = "Alien"; }
		case 142: { name = "Left Oval Vents"; }
		case 143: { name = "Right Oval Vents"; }
		case 144: { name = "Left Square Vents"; }
		case 145: { name = "Right Square Vents"; }
		case 146: { name = "X-Flow"; }
		case 147: { name = "Alien"; }
		case 148: { name = "X-Flow"; }
		case 149: { name = "Alien"; }
		case 150: { name = "Alien"; }
		case 151: { name = "X-Flow"; }
		case 152: { name = "X-Flow"; }
		case 153: { name = "Alien"; }
		case 154: { name = "Alien"; }
		case 155: { name = "Alien"; }
		case 156: { name = "X-Flow"; }
		case 157: { name = "X-Flow"; }
		case 158: { name = "X-Flow"; }
		case 159: { name = "Alien"; }
		case 160: { name = "Alien"; }
		case 161: { name = "X-Flow"; }
		case 162: { name = "Alien"; }
		case 163: { name = "X-Flow"; }
		case 164: { name = "Alien"; }
		case 165: { name = "X-Flow"; }
		case 166: { name = "Alien"; }
		case 167: { name = "X-Flow"; }
		case 168: { name = "Alien"; }
		case 169: { name = "Alien"; }
		case 170: { name = "X-Flow"; }
		case 171: { name = "Alien"; }
		case 172: { name = "X-Flow"; }
		case 173: { name = "X-Flow"; }
		case 174: { name = "Chrome"; }
		case 175: { name = "Slamin"; }
		case 176: { name = "Chrome"; }
		case 177: { name = "Slamin"; }
		case 178: { name = "Slamin"; }
		case 179: { name = "Chrome"; }
		case 180: { name = "Chrome"; }
		case 181: { name = "Slamin"; }
		case 182: { name = "Chrome"; }
		case 183: { name = "Slamin"; }
		case 184: { name = "Chrome"; }
		case 185: { name = "Slamin"; }
		case 186: { name = "Slamin"; }
		case 187: { name = "Chrome"; }
		case 188: { name = "Slamin"; }
		case 189: { name = "Chrome"; }
		case 190: { name = "Slamin"; }
		case 191: { name = "Chrome"; }
		case 192: { name = "Chrome"; }
		case 193: { name = "Slamin"; }
   	}
	return name;
}

//------------------------------------------------------------------------------------------------------
stock RemoveSempak(playerid)
{
	//Rumput
	RemoveBuildingForPlayer(playerid, 6253, 1305.4688, -1619.7422, 13.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 6046, 1305.4688, -1619.7422, 13.3984, 0.25);
	//Fish Factory
	RemoveBuildingForPlayer(playerid, 17751, 2844.2422, -1531.8828, 20.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 17551, 2844.2422, -1531.8828, 20.1406, 0.25);
	//ASGH
	RemoveBuildingForPlayer(playerid, 5935, 1120.1563, -1303.4531, 18.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 5737, 1120.1563, -1303.4531, 18.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 617, 1178.6016, -1332.0703, 12.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.0078, -1353.5000, 12.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.0078, -1343.2656, 12.5781, 0.25);
 	RemoveBuildingForPlayer(playerid, 618, 1177.7344, -1315.6641, 13.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.8125, -1292.9141, 12.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.8125, -1303.1484, 12.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1374.6094, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1356.5547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1374.6094, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1356.5547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1335.0547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1317.7422, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1335.0547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1317.7422, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1300.9219, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1300.9219, 12.2969, 0.25);
	//MAPPING BASE SANDI
	RemoveBuildingForPlayer(playerid, 1412, 2186.7344, -1503.0859, 24.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2199.2734, -1523.7109, 21.9609, 0.25);
    // Sprunk machines
 	RemoveBuildingForPlayer(playerid, 1302, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1209, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 955, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 956, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1775, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1776, 0.0, 0.0, 0.0, 6000.0);
    RemoveBuildingForPlayer(playerid, 1977, 0.0, 0.0, 0.0, 6000.0);
	//Mechanic Center Remove
	RemoveBuildingForPlayer(playerid, 3707, 2344.1016, -2279.6641, 20.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 3708, 2344.1016, -2279.6641, 20.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2329.0859, -2328.6875, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 2300.0703, -2301.6094, 13.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 2296.3125, -2297.8984, 13.7734, 0.25);
	//Vehicle Dealership Toys
	RemoveBuildingForPlayer(playerid, 1388, 1238.3750, -1258.2813, 57.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 5318, 2267.9609, -1997.8906, 18.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 1266, 2236.5625, -1988.0469, 26.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 5293, 2282.8203, -2033.5000, 20.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 5372, 2282.8203, -2033.5000, 20.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 1635, 2255.8438, -2013.5859, 15.1484, 0.25);
	RemoveBuildingForPlayer(playerid, 1687, 2236.1406, -2010.2344, 18.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 2271.7344, -2013.6172, 11.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 5310, 2267.9609, -1997.8906, 18.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 2227.4688, -1987.5781, 11.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 1260, 2236.5625, -1988.0469, 26.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 1635, 2235.8281, -1982.2031, 17.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1687, 2300.1797, -1997.0547, 25.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 1635, 2296.6719, -1982.2031, 17.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 5266, 2278.0000, -1942.8672, 20.0781, 0.25);

	//Tempat Untuk WorkShop
	RemoveBuildingForPlayer(playerid, 4051, 1371.8203, -1754.8203, 19.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 4226, 1359.2813, -1796.4688, 24.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 1220, 1342.2734, -1806.2031, 12.9297, 0.25);
	RemoveBuildingForPlayer(playerid, 1230, 1342.6328, -1807.0391, 12.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 1221, 1342.5156, -1805.0703, 12.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 1220, 1338.9531, -1796.4297, 12.9297, 0.25);
	RemoveBuildingForPlayer(playerid, 4023, 1359.2813, -1796.4688, 24.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 1230, 1338.9609, -1796.0000, 13.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 1220, 1338.9375, -1795.4609, 12.9297, 0.25);
	RemoveBuildingForPlayer(playerid, 1221, 1338.9688, -1793.7266, 12.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 1372, 1337.6953, -1774.7344, 12.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 1265, 1338.7891, -1775.3203, 12.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1265, 1337.0078, -1773.8672, 13.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 4021, 1371.8203, -1754.8203, 19.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1388.3594, -1745.4453, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 4606, 1825.0000, -1413.9297, 12.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 4594, 1825.0000, -1413.9297, 12.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2346.5156, -1350.7813, 24.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 17964, 2337.3359, -1330.8516, 25.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 17966, 2347.9219, -1364.2891, 27.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 2344.9219, -1379.5234, 26.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2364.0859, -1378.8125, 26.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 17544, 2337.3359, -1330.8516, 25.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 17542, 2347.9219, -1364.2891, 27.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 955, 2352.1797, -1357.1563, 23.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 1307, 2361.7656, -1347.1094, 23.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 2366.3125, -1356.2813, 26.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 1447, -107.0859, -1196.0859, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, -112.1719, -1194.7500, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, -101.2891, -1215.5859, 2.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 1447, -100.1797, -1210.0781, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, -102.1328, -1197.1641, 2.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, -98.9219, -1204.9141, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, -98.8750, -1199.9297, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, -98.9297, -1218.7266, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1447, -88.6172, -1220.3828, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, -93.9453, -1219.5391, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 17066, -86.8750, -1207.2422, 1.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, -83.3984, -1221.2969, 2.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 1447, -78.4297, -1208.9453, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, -79.4922, -1214.1016, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, -80.2969, -1219.0781, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, -73.5703, -1193.9375, 2.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, -77.3516, -1203.7422, 2.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, -75.6719, -1198.8125, 2.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1415, -77.2188, -1188.3672, 0.8359, 0.25);
	//LSPD, Tempat Mekanik 2
	RemoveBuildingForPlayer(playerid, 1266, 1538.5234, -1609.8047, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 4229, 1597.9063, -1699.7500, 30.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 4230, 1597.9063, -1699.7500, 30.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 1260, 1538.5234, -1609.8047, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 2282.0703, -2312.0469, 13.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 2285.8281, -2315.7578, 13.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1341.8516, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1328.0938, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1356.2109, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1374.6094, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1356.5547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1374.6094, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1356.5547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1335.0547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1317.7422, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1335.0547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1317.7422, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1300.9219, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1300.9219, 12.2969, 0.25);
	// Impound Remove
	RemoveBuildingForPlayer(playerid, 714, 2217.0234, -1320.8047, 22.5078, 0.25);
	// SMB Remove
	RemoveBuildingForPlayer(playerid, 1297, 345.3125, -1775.9453, 7.4531, 0.25);
	//Sanews
	//RemoveBuildingForPlayer(playerid, 1689, 745.5859, -1381.1094, 25.8750, 0.25);
	//RemoveBuildingForPlayer(playerid, 1689, 751.3359, -1368.0313, 25.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 6516, 717.6875, -1357.2813, 18.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 1415, 732.8516, -1332.8984, 12.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1439, 732.7266, -1341.7734, 12.6328, 0.25);
}
stock pName(playerid)
{
	new name[64];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}
//Speedo
public LuX_SpeedoMeterUp()
{
    new Float:x,Float:y,Float:z;

	for(new i=0; i<PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER)
		{
 			GetVehicleVelocity(GetPlayerVehicleID(i),x,y,z);
			GetPlayerVehicleID(i);
			new LuxZone[MAX_ZONE_NAME];
			GetPlayer2DZone(i, LuxZone, MAX_ZONE_NAME);
			if(LuX_SpeedoMeter[i] == 0)
			{
				TextDrawShowForPlayer(i, LBox[i]);
			    TextDrawShowForPlayer(i, LLine1[i]);
				TextDrawShowForPlayer(i, LLine2[i]);
				TextDrawShowForPlayer(i, LLine3[i]);
				TextDrawShowForPlayer(i, GPS[i]);
				LuX_SpeedoMeter[i] = 1;
			}
			format(lString,sizeof(lString),"~w~%s",LVehiclesName[GetVehicleModel(GetPlayerVehicleID(i))-400]);
			TextDrawSetString(LLine1[i], lString);
			format(lString,sizeof(lString),"~w~Speed: %d mph",floatround(floatsqroot(((x*x)+(y*y))+(z*z))*156.666667));
			TextDrawSetString(LLine2[i],lString);
			format(lString,sizeof(lString),"~w~Fuel: ~g~%.1f~w~/~b~100.0",VehicleFuel[(GetPlayerVehicleID(i))]);
			TextDrawSetString(LLine3[i],lString);
			TextDrawSetString(GPS[i], LuxZone);
		}
	}
	for(new i=0; i<PLAYERS; i++)
	{
		if(!IsPlayerInAnyVehicle(i))
		{
			TextDrawHideForPlayer(i, LBox[i]);
			TextDrawHideForPlayer(i, LLine1[i]);
			TextDrawHideForPlayer(i, LLine2[i]);
			TextDrawHideForPlayer(i, LLine3[i]);
			TextDrawHideForPlayer(i, GPS[i]);
			LuX_SpeedoMeter[i] = 0;
		}
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	if (fexist(WeaponInfoFile(playerid))) INI_ParseFile(WeaponInfoFile(playerid), "LoadWeaponInfo_%s", .bExtra = true, .extra = playerid);
	else ResetWeaponInfo(playerid);
	SetTimerEx("WeaponCheck", 150, true, "i", playerid);
	SetTimerEx("PayCheck", 15 * 60000, true, "i", playerid);
	GetPlayerName(playerid, PlayerInfo[playerid][pNormalName], MAX_PLAYER_NAME);
    Cammode[playerid] = 0;
    RemoveSempak(playerid);
    infect[playerid] = 0;
    SedangKuli[playerid] = 0;
    KerjaSweeper[playerid] = 0;
    KerjaBus[playerid] = 0;
	PlayerInfo[playerid][pSweeperT] = 0;
	SetPlayerArmedWeapon(playerid, 0);
	PreloadAnims(playerid);
	AntiFlood_InitPlayer( playerid );
	//==========================//
	//Desc Text - AriWiwin14
 	DescriptionText[playerid] = TextDrawCreate(320.0, 380.0, " ");
	TextDrawAlignment(DescriptionText[playerid], 2);
	TextDrawFont(DescriptionText[playerid], 1);
	TextDrawLetterSize(DescriptionText[playerid], 0.320000, 1.700000);
	TextDrawSetOutline(DescriptionText[playerid], 1);
    //========strobe============
	new VID = GetPlayerVehicleID(playerid);
	RemoveVehSS(VID);
	//ANTI CHEAT
	AC_BS_SetPlayerArmour(playerid, 0);
	PlayerInfo[playerid][pArmor] = 0;
	AC_BS_SetPlayerHealth(playerid, 100.0);
	PlayerInfo[playerid][pHealth] = 100.0;
	//flymode
	noclipdata[playerid][cameramode] 	= CAMERA_MODE_NONE;
	noclipdata[playerid][lrold]	   	 	= 0;
	noclipdata[playerid][udold]   		= 0;
	noclipdata[playerid][mode]   		= 0;
	noclipdata[playerid][lastmove]   	= 0;
	noclipdata[playerid][accelmul]   	= 0.0;
	//
  	pvehicleid[playerid] = GetPlayerVehicleID(playerid);
	pvehicleid[playerid] = 0;
    pmodelid[playerid] = 0;
    PlayerPressedJump[playerid] = 0;
    SetPlayerJoinCamera(playerid);
	DeletePVar(playerid, "BoomboxObject"); DeletePVar(playerid, "BoomboxURL");
    DeletePVar(playerid, "bposX"); DeletePVar(playerid, "bposY"); DeletePVar(playerid, "bposZ"); DeletePVar(playerid, "bboxareaid");
    if(IsValidDynamicObject(GetPVarInt(playerid, "BoomboxObject"))) DestroyDynamicObject(GetPVarInt(playerid, "BoomboxObject"));
	SedangTrucking[playerid] = 0;
	SedangHauling[playerid] = 0;
	TakeTrucking[playerid] = 0;
	CarTrucking[playerid] = 0;
	togbh[playerid] = 1;
	AimbotWarnings[playerid] = 0;
	CPD[playerid] = 0;
	togneon[playerid] = 0;
	neontog[playerid] = 0;
	Neon1[playerid] = 0;
	Neon2[playerid] = 0;
	gPlayerUsingLoopingAnim[playerid] = 0;
	gPlayerAnimLibsPreloaded[playerid] = 0;
	CheckDoorPoint[playerid] = 0;
	CheckBizPoint[playerid] = 0;
	SedangMancing[playerid] = 0;
	FishHolding[playerid] = 0;
	CompHolding[playerid] = 0;
	// ----------------------------
	if(IsPlayerNPC(playerid)) return 1;
	new playerIP[16], String[10000];
	GetPlayerIp(playerid, playerIP, sizeof(playerIP));
	format(PlayerInfo[playerid][pIP], 32, "%s", playerIP);
	if (CheckBan(playerIP) == 1)
	{
    	format(String, sizeof(String), "{FFFFFF}Account: {FF0000}%s{FFFFFF}\nIP: {FF0000}%s{FFFFFF}\nDi banned oleh: {FF0000}%s{FFFFFF} \nAlasan: {FF0000}%s{FFFFFF} \nPada: {FF0000}Waktu: %s | Tanggal: %s\n\n{FFFFFF}Silahkan Ambil Screenshoot dengan cara menekan F8/Prt scrn{FFFFFF}\nDan Post di Forum Kami.{FFFFFF}",PlayerInfo[playerid][pNormalName],PlayerInfo[playerid][pIP],PlayerInfo[playerid][pAdminban],PlayerInfo[playerid][pBanReason],PlayerInfo[playerid][pBanExpired],PlayerInfo[playerid][pBanExpired2]);
		ShowPlayerDialog(playerid,BAN_DIALOG,DIALOG_STYLE_MSGBOX,"BANNED",String,"Ok :(","");
		FixedKick(playerid);
		return 1;
	}
	//=====================================Remove Building=======================================================//
	// Crash Fix - GhoulSlayeR
	if(IsPlayerNPC(playerid)) return 1;
	TotalConnect++;
	PlayersConnected++;
	if(PlayersConnected > MaxPlayersConnected)
	{
		MaxPlayersConnected = PlayersConnected;
		gettime(MPHour,MPMinute);
		getdate(MPYear,MPMonth,MPDay);
	}

	if(MaxPlayersConnected > 500) MaxPlayersConnected = 500; // Temp goof fix
	scoreMusic[playerid] = -1;
	SetPVarInt(playerid, "RespawnAllCar", 0);
	SetPVarInt(playerid, "kesehatan", 0);
	SetPVarInt(playerid, "FirstSpawn", 1);
	SetPVarInt(playerid, "IsInArena", -1);
	SetPVarInt(playerid, "ArenaNumber", -1);
	SetPVarInt(playerid, "ArenaEnterPass", -1);
	SetPVarInt(playerid, "ArenaEnterTeam", -1);
	SetPVarInt(playerid, "EditingTurfs", -1);
	SetPVarInt(playerid, "EditingTurfsStage", -1);
	SetPVarInt(playerid, "EditingHillStage", -1);
	SetPVarInt(playerid, "EditingFamC", -1);
	SetPVarInt(playerid, "editingcd", -1);
	SetPVarInt(playerid, "editingcdveh", -1);
	SetPVarInt(playerid, "editingfamhq", 255);
	SetPVarInt(playerid, "UsingSurfAttachedObject", -1);
	SetPVarInt(playerid, "UsingBriefAttachedObject", -1);
	SetPVarInt(playerid, "MovingStretcher", -1);
	for(new i = 0; i < 3; i++)
	{
		SweeperSteps[playerid][i] = 0;
	}
	for(new i = 0; i < 3; i++)
	{
		BusSteps[playerid][i] = 0;
	}
	for(new i = 0; i < 3; i++)
	{
		StopaniFloats[playerid][i] = 0;
	}
	for(new i = 0; i < 6; i++)
	{
	    EventFloats[playerid][i] = 0.0;
	}
	EventLastInt[playerid] = 0; EventLastVW[playerid] = 0;
	for(new i = 0; i < 6; i++)
	{
		HHcheckFloats[playerid][i] = 0;
	}
	FriskOffer[playerid] = 999; InspectOffer[playerid] = 999; OnKTP[playerid] = 0; TakeBox[playerid] = 0;
	HHcheckVW[playerid] = 0; HHcheckInt[playerid] = 0; OrderAssignedTo[playerid] = INVALID_PLAYER_ID;
	RefuelingVehicle[playerid] = 0; FuelBar[playerid] = INVALID_BAR_ID; pRent[playerid] = 0; RentFaggio[playerid] = 0;prSpawnID[playerid] = 0; prSpawn[playerid] = 0; pMancing[playerid] = 0;
	RefuelingVehiclePrice[playerid] = 0; HouseOffer[playerid] = 999; GSOffer[playerid] = 999; WsOffer[playerid] = 999; FarmOffer[playerid] = 999; House[playerid] = 0; HousePrice[playerid] = 0; gsPrice[playerid] = 0; WsPrice[playerid] = 0; farmPrice[playerid] = 0;
	SetPVarInt( playerid, "InHouse", INVALID_HOUSE_ID );
	SetPVarInt(playerid, "shrequest", INVALID_PLAYER_ID); PlayerInfo[playerid][pTogReports] = 0;
 	format(PlayerInfo[playerid][pAutoTextReply], 64, "Nothing"); playerTabbedTime[playerid] = 0; playerTabbed[playerid] = 0;
	gActivePlayers[playerid]++; WantedPoints[playerid] = 0; gBug[playerid] = 1; gBugSIU[playerid] = 1; TazerTimeout[playerid] = 0; gRadio[playerid] = 1; playerLastTyped[playerid] = 0; SetPlayerWantedLevel(playerid, 0); pTazer[playerid] = 0; pTazerReplace[playerid] = 0; pCurrentWeapon[playerid] = 0;
	MedicAccepted[playerid] = 999; PlayerInfo[playerid][pWantedLevel] = 0;
	Spectating[playerid] = 0; GettingSpectated[playerid] = 999; PlayerInfo[playerid][pPhonePrivacy] = 0; pcRadio[playerid] = 0;
	NewbieTimer[playerid] = 0; HlKickTimer[playerid] = 0; HelperTimer[playerid] = 0; VIPTimer[playerid] = 0; PlayerInfo[playerid][pLock] = 0; PlayerInfo[playerid][pLockCar] = INVALID_VEHICLE_ID;
	numplayers++; VehicleOffer[playerid] = 999; pTerluka[playerid] = 0;//Frozen[playerid] = 0;
	VehiclePrice[playerid] = 0; VehicleId[playerid] = -1; NOPTrigger[playerid] = 0;
	JustReported[playerid] = -1; adTick[playerid] = -1; askTick[playerid] = -1; UsedCrack[playerid] = 0; UsedWeed[playerid] = 0; DrinkOffer[playerid] =  INVALID_PLAYER_ID;
	PotOffer[playerid] = 999; CrackOffer[playerid] = 999; GunOffer[playerid] = 999;
	LiveOffer[playerid] = 999; NeonOffer[playerid] = 999; NeonOffer[playerid] = 999;
	SprayOffer[playerid] = 999; SprayPrice[playerid] = 0; SprayPaint[playerid] = 999;
	MatsOffer[playerid] = 999; MatsPrice[playerid] = 0; MatsAmount[playerid] = 0;
	MarryWitnessOffer[playerid] = 999; ProposeOffer[playerid] = 999; DivorceOffer[playerid] = 999;
	HidePM[playerid] = 0; PhoneOnline[playerid] = 0;
    advisorchat[playerid] = 1; PlayerInfo[playerid][pVIPLeft] = -1; PlayerInfo[playerid][pVIPInviteDay] = 0; PlayerInfo[playerid][pTempVIP] = 0; PlayerInfo[playerid][pBuddyInvited] = 0;
	ChosenSkin[playerid] = 0;
	MatsHolding[playerid] = 0; MatDeliver[playerid] = 0; MatDeliver2[playerid] = 0;
	PlayerInfo[playerid][pTokens] = 0;
	GettingJob[playerid] = 0; GettingJob2[playerid] = 0; GettingIllegalJob[playerid] = 0; PlayerInfo[playerid][pCSFBanned] = 0;
 	PlayerInfo[playerid][pFactionBanned] = 0; warna2[playerid] = 999; warna1[playerid] = 999; idveh[playerid] = INVALID_VEHICLE_ID; idveh2[playerid] = INVALID_VEHICLE_ID;
	PlayerInfo[playerid][pGangWarn] = 0; CurrentMoney[playerid] = 0; UsedFind[playerid] = 0; PlayerInfo[playerid][pTriageTime] = 0;
	PlayerInfo[playerid][pCigar] = 0; PlayerInfo[playerid][pSprunk] = 0; PlayerInfo[playerid][pSpraycan] = 0;
	CP[playerid] = 0; SpawnChange[playerid] = 1; PlayerInfo[playerid][pPot] = 0;
	MoneyMessage[playerid] = 0; Condom[playerid] = 0; PlayerInfo[playerid][pCrack] = 0;
	STDPlayer[playerid] = 0; PlayerInfo[playerid][pAdmin] = 0;
	TalkingLive[playerid] = INVALID_PLAYER_ID; LiveOffer[playerid] = 999; TakingLesson[playerid] = 0;
	InsideShamal[playerid] = INVALID_VEHICLE_ID; InsideMainMenu[playerid] = 0; InsideTut[playerid] = 0;
	PlayerInfo[playerid][pToggedVIPChat] = 0; NeonOffer[playerid] = 999; NeonID[playerid] = 999;
	PotOffer[playerid] = 999; CrackOffer[playerid] = 999; PlayerCuffed[playerid] = 0; PlayerCuffedTime[playerid] = 0;
	PotPrice[playerid] = 0; CrackPrice[playerid] = 0; gh[playerid] = 0;
	PotGram[playerid] = 0; CrackGram[playerid] = 0; PlayerInfo[playerid][pBanned] = 0; ConnectedToPC[playerid] = 0; OrderReady[playerid] = 0;
	GunId[playerid] = 0; GunMats[playerid] = 0; GunAmmoAmount[playerid] = 0; GunPrice[playerid] = 0;
	PlayerInfo[playerid][pCrack] = 0; PlayerInfo[playerid][pKills] = 0;
 	InviteOffer[playerid] = 999; InviteFaction[playerid] = 0; InviteMech[playerid] = 0; InviteFarm[playerid] = 0; InviteFamily[playerid] = 255; PlayerInfo[playerid][pSpeakerPhone] = 0;
	hInviteHouse[playerid] = INVALID_HOUSE_ID; hInviteOffer[playerid] = 999; hInviteSlot[playerid] = 0;	PlayerInfo[playerid][pDeaths] = 0;
	JailPrice[playerid] = 0; MedicTime[playerid] = 0; NeedMedicTime[playerid] = 0;
	WantedPoints[playerid] = 0; PlacedNews[playerid] = 0;
	OnDuty[playerid] = 0; CalledCops[playerid] = 0; CopsCallTime[playerid] = 0;
 	SchoolSpawn[playerid] = 0; CalledMedics[playerid] = 0;
	SafeTime[playerid] = 60; PlayerTied[playerid] = 0; MedicsCallTime[playerid] = 0;
	EMSCallTime[playerid] = 0; MedicCallTime[playerid] = 0; MechanicCallTime[playerid] = 0;
	FindTimePoints[playerid] = 0; FindingPlayer[playerid]=-1; FindTime[playerid] = 0; JobDuty[playerid] = 0;
	Mobile[playerid] = INVALID_PLAYER_ID; Music[playerid] = 0;
	Spectate[playerid] = 999; PlayerDrunk[playerid] = 0; PlayerDrunkTime[playerid] = 0; format(PlayerInfo[playerid][pPrisonReason], 128, "None");
	Unspec[playerid][sLocal] = INVALID_PLAYER_ID; format(PlayerInfo[playerid][pJailedBy], 24, "None");
    courtjail[playerid] = 0;
	gLastCar[playerid] = 0; FirstSpawn[playerid] = 0; JetPack[playerid] = 0; PlayerInfo[playerid][pKills] = 0; PlayerInfo[playerid][pPaintTeam] = 0;
	TextSpamTimes[playerid] = 0; BusID[playerid] = 0; PlayerSitting[playerid] = 0;
	TextSpamUnmute[playerid] = 0;
 	CommandSpamTimes[playerid] = 0;
	CommandSpamUnmute[playerid] = 0;
	gOoc[playerid] = 0; musicinternet[playerid] = 0;
	arr_Towing[playerid] = INVALID_VEHICLE_ID;
	gNews[playerid] = 0;
	togglepm[playerid] = 1;//tog pm
	togaccent[playerid] = 0;
	format(advertise[playerid], 128, "None");
	advtimer = 0;
	gNewbie[playerid] = 1;
	gHelp[playerid] = 1;
	gFam[playerid] = 0;
	gPlayerLogged{playerid} = 0;
	gPlayerLogTries[playerid] = 0;
	gPlayerAccount[playerid] = 0;
	gPlayerSpawned[playerid] = 0;


	//=============================//
	PlayerTazeTime[playerid] = 0;
	PlayerStoned[playerid] = 0;
	PlayerInfo[playerid][pPot] = 0;
	StartTime[playerid] = 0;
	TicketOffer[playerid] = 999;
	TicketMoney[playerid] = 0;
	PlayerInfo[playerid][pVehicleKeysFrom] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pPermaBanned] = 0;
	PlayerInfo[playerid][pVehicleKeys] = INVALID_PLAYER_VEHICLE_ID;
	EMSAccepted[playerid] = 999;
	PlayerInfo[playerid][pCrack] = 0;
	HireCar[playerid] = 299;
	Locator[playerid] = 0;
	Spectating[playerid] = 0;
	ReleasingMenu[playerid] = INVALID_PLAYER_ID;
	ProposeOffer[playerid] = 999;
	MarryWitness[playerid] = 999;
	MarryWitnessOffer[playerid] = 999;
	MarriageCeremoney[playerid] = 0;
	ProposedTo[playerid] = 999;
	GotProposedBy[playerid] = 999;
	DivorceOffer[playerid] = 999;
	stationidp[playerid] = 0;
	Fixr[playerid] = 0;
	slotselection[playerid] = 999;
	vslotselection[playerid] = 999;
	pvehEditID[playerid] = 999;
	pvEditID[playerid] = 999;
	format(PlayerInfo[playerid][pAdminban], 128, "None");
	format(PlayerInfo[playerid][pBanReason], 128, "None");
	format(PlayerInfo[playerid][pAccent], 80, "None");
	PlayerInfo[playerid][pWSBos] = -1;
	PlayerInfo[playerid][pDutyTime] = 0;
	PlayerInfo[playerid][pDutyTimeTotal] = 0;
	PlayerInfo[playerid][pFarmBos] = -1;
	format(PlayerInfo[playerid][pBanExpired], 128, "");
	format(PlayerInfo[playerid][pBanExpired2], 128, "");
	PlayerInfo[playerid][pLevel] = 1;
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pAdminDuty] = 0;
 	PlayerInfo[playerid][pBanned] = 0;
 	PlayerInfo[playerid][pDisabled] = 0;
 	PlayerInfo[playerid][pMuted] = 0;
 	PlayerInfo[playerid][pRMuted] = 0;
 	PlayerInfo[playerid][pRMutedTotal] = 0;
 	PlayerInfo[playerid][pRMutedTime] = 0;
 	PlayerInfo[playerid][pSnack] = 0;
 	PlayerInfo[playerid][pMineralWater] = 0;
 	PlayerInfo[playerid][pADMute] = 0;
 	PlayerInfo[playerid][pADMuteTotal] = 0;
 	PlayerInfo[playerid][pHelpMute] = 0;
 	PlayerInfo[playerid][pGYMTime] = 0;
 	PlayerInfo[playerid][pUsePainkiller] = 0;
 	PlayerInfo[playerid][pRadio] = 0;
 	PlayerInfo[playerid][pRadioFreq] = 0;
 	PlayerInfo[playerid][pPermaBanned] = 0;
	PlayerInfo[playerid][pDonateRank] = 0;
	PlayerInfo[playerid][pBandage] = 0;
	PlayerInfo[playerid][pConnectTime] = 1;
	PlayerInfo[playerid][pReg] = 0;
	PlayerInfo[playerid][pSex] = 0;
	PlayerInfo[playerid][pCacing] = 0;
	PlayerInfo[playerid][pLumber] = 0;
	PlayerInfo[playerid][pAdminOnDutyTime] = 0;
	PlayerInfo[playerid][pPBiskey2] = 0;
	PlayerInfo[playerid][pHunger] = 0;
	PlayerInfo[playerid][pBladder] = 0;
	PlayerInfo[playerid][pEnergi] = 0;
	PlayerInfo[playerid][pCondition] = 0;
	PlayerInfo[playerid][pSilincedSkill] = 1;
	PlayerInfo[playerid][pDesertEagleSkill] = 1;
	PlayerInfo[playerid][pRifleSkill] = 1;
	PlayerInfo[playerid][pShotgunSkill] = 1;
	PlayerInfo[playerid][pSpassSkill] = 1;
	PlayerInfo[playerid][pMP5Skill] = 1;
	PlayerInfo[playerid][pAK47Skill] = 1;
	PlayerInfo[playerid][pM4Skill] = 1;
	PlayerInfo[playerid][pSniperSkill] = 1;
	PlayerInfo[playerid][pTrainingTime] = 0;
	PlayerInfo[playerid][pPDTime] = 0;
	PlayerInfo[playerid][pPBiskey] = 0;
	PlayerInfo[playerid][pInBizz] = 0;
	PlayerInfo[playerid][pPancingan] = 0;
	PlayerInfo[playerid][pMask] = 0;
	PlayerInfo[playerid][pMaskUse] = 0;
	PlayerInfo[playerid][pMaskID] = 0;
	PlayerInfo[playerid][pParacetamol] = 0;
	PlayerInfo[playerid][pExp] = 0;
	PlayerInfo[playerid][pAccount] = 0;
	PlayerInfo[playerid][pCrimes] = 0;
	PlayerInfo[playerid][pDeaths] = 0;
	PlayerInfo[playerid][pArrested] = 0;
	PlayerInfo[playerid][pFitnessTimer] = 0;
	PlayerInfo[playerid][pJob] = 0;
	PlayerInfo[playerid][pWSJob] = 0;
	PlayerInfo[playerid][pFarmJob] = 0;
	PlayerInfo[playerid][pJerigen] = 0;
	PlayerInfo[playerid][pBensin] = 0;
	PlayerInfo[playerid][pUseSorry] = 0;
	PlayerInfo[playerid][pKuli] = 0;
	PlayerInfo[playerid][pJob2] = 0;
	PlayerInfo[playerid][pIllegalJob] = 0;
	PlayerInfo[playerid][pPayCheck] = 0;
	PlayerInfo[playerid][pJailed] = 0;
	PlayerInfo[playerid][pJailTime] = 0;
	PlayerInfo[playerid][pWRestricted] = 0;
	PlayerInfo[playerid][pMats] = 0;
	PlayerInfo[playerid][pPulsa2] = 0;
	PlayerInfo[playerid][pLeader] = 0;
	PlayerInfo[playerid][pMember] = 0;
	PlayerInfo[playerid][pDivision] = 0;
	PlayerInfo[playerid][pFMember] = 255;
	PlayerInfo[playerid][pRank] = 0;
	PlayerInfo[playerid][pChar] = 0;
	PlayerInfo[playerid][pRenting] = INVALID_HOUSE_ID;
	PlayerInfo[playerid][pAmoxicilin] = 0;
	PlayerInfo[playerid][pMechSkill] = 0;
	PlayerInfo[playerid][pUltrafluenza] = 0;
	PlayerInfo[playerid][pTruckingSkill] = 0;
	PlayerInfo[playerid][pArmsSkill] = 0;
	PlayerInfo[playerid][pSmugSkill] = 0;
	PlayerInfo[playerid][pSHealth] = 0.0;
	PlayerInfo[playerid][pSArmor] = 0.0;
	PlayerInfo[playerid][pBodyCondition][0] = 100.0;
	PlayerInfo[playerid][pBodyCondition][1] = 100.0;
	PlayerInfo[playerid][pBodyCondition][2] = 100.0;
	PlayerInfo[playerid][pBodyCondition][3] = 100.0;
	PlayerInfo[playerid][pBodyCondition][4] = 100.0;
	PlayerInfo[playerid][pBodyCondition][5] = 100.0;
	PlayerInfo[playerid][pHealth] = 50.0;
	PlayerInfo[playerid][pLocal] = 255;
	PlayerInfo[playerid][pTeam] = 3;
	PlayerInfo[playerid][pCheckCash] = 0;
	PlayerInfo[playerid][pChecks] = 0;
	PlayerInfo[playerid][pTanamanAnggur] = 0;
	PlayerInfo[playerid][pTanamanBlueberry] = 0;
	PlayerInfo[playerid][pTanamanStrawberry] = 0;
	PlayerInfo[playerid][pTanamanGandum] = 0;
	PlayerInfo[playerid][pTanamanTomat] = 0;
	PlayerInfo[playerid][pBibitAnggur] = 0;
	PlayerInfo[playerid][pBibitBlueberry] = 0;
	PlayerInfo[playerid][pBibitStrawberry] = 0;
	PlayerInfo[playerid][pBibitGandum] = 0;
	PlayerInfo[playerid][pBibitTomat] = 0;
	format(PlayerInfo[playerid][pWarrant], 128, "");
	PlayerInfo[playerid][pJudgeJailTime] = 0;
	PlayerInfo[playerid][pJudgeJailType] = 0;
	PlayerInfo[playerid][pBeingSentenced] = 0;
	PlayerInfo[playerid][pProbationTime] = 0;
	PlayerInfo[playerid][pModel] = 299;
	PlayerInfo[playerid][pPnumber] = 0;
	PlayerInfo[playerid][pFMax] = 0;
	PlayerInfo[playerid][pJTime] = 0;
	PlayerInfo[playerid][pFTime] = 0;
	PlayerInfo[playerid][pLumberTime] = 0;
	PlayerInfo[playerid][pHaulingTime] = 0;
	PlayerInfo[playerid][pPhone] = 0;
	PlayerInfo[playerid][pKartuPerdana] = 0;
	PlayerInfo[playerid][pPainkiller] = 0;
	PlayerInfo[playerid][pBusTime] = 0;
	PlayerInfo[playerid][pBeratIkan] = 0;
	PlayerInfo[playerid][pPhousekey] = INVALID_HOUSE_ID;
	PlayerInfo[playerid][pPhousekey2] = INVALID_HOUSE_ID;
	PlayerInfo[playerid][pWSid] = -1;
	PlayerInfo[playerid][pFarmid] = -1;
	PlayerInfo[playerid][pFarmBos] = -1;
	PlayerInfo[playerid][pCarLic] = 0;
	PlayerInfo[playerid][pCTime] = 0;
	PlayerInfo[playerid][pCarLicID] = 0;
	PlayerInfo[playerid][pKTP] = 0;
	PlayerInfo[playerid][pWS] = 0;
	PlayerInfo[playerid][pWSid] = 0;
	PlayerInfo[playerid][pFarm] = 0;
	PlayerInfo[playerid][pFarmid] = 0;
	PlayerInfo[playerid][pTruckerLic] = 0;
	PlayerInfo[playerid][pMissionsTime] = 0;
	PlayerInfo[playerid][pFitnessType] = 0;
	PlayerInfo[playerid][pKTime] = 0;
	PlayerInfo[playerid][pLumberLic] = 0;
	PlayerInfo[playerid][pFlyLic] = 0;
	PlayerInfo[playerid][pBoatLic] = 0;
	PlayerInfo[playerid][pGunLic] = 0;
	PlayerInfo[playerid][pBugged] = 0;
	PlayerInfo[playerid][pCallsAccepted] = 0;
	PlayerInfo[playerid][pPatientsDelivered] = 0;
	PlayerInfo[playerid][pLiveBanned] = 0;
	PlayerInfo[playerid][pFreezeBank] = 0;
	PlayerInfo[playerid][pComponent] = 0;
	PlayerInfo[playerid][pBoomBox] = 0;
	for(new v = 0; v < MAX_PLAYERVEHICLES; v++)
	{
        PlayerVehicleInfo[playerid][v][pvModelId] = 0;
        PlayerVehicleInfo[playerid][v][pvPosX] = 0.0;
        PlayerVehicleInfo[playerid][v][pvPosY] = 0.0;
        PlayerVehicleInfo[playerid][v][pvPosZ] = 0.0;
        PlayerVehicleInfo[playerid][v][pvPosAngle] = 0.0;
        PlayerVehicleInfo[playerid][v][pvLock] = 3;
        PlayerVehicleInfo[playerid][v][pvLocked] = 0;
        PlayerVehicleInfo[playerid][v][pvPaintJob] = -1;
        PlayerVehicleInfo[playerid][v][pvColor1] = 0;
        PlayerVehicleInfo[playerid][v][pvNeon] = 0;
		PlayerVehicleInfo[playerid][v][pvImpounded] = 0;
		PlayerVehicleInfo[playerid][v][pvStored] = 0;
		PlayerVehicleInfo[playerid][v][pvDestroyed] = 0;
        PlayerVehicleInfo[playerid][v][pvColor2] = 0;
        PlayerVehicleInfo[playerid][v][pvPrice] = 0;
        PlayerVehicleInfo[playerid][v][pvTicket] = 0;
        PlayerVehicleInfo[playerid][v][pvWeapons][0] = 0;
        PlayerVehicleInfo[playerid][v][pvWeapons][1] = 0;
        PlayerVehicleInfo[playerid][v][pvWeapons][2] = 0;
        PlayerVehicleInfo[playerid][v][pvWeaponsAmmo][0] = 0;
        PlayerVehicleInfo[playerid][v][pvWeaponsAmmo][1] = 0;
        PlayerVehicleInfo[playerid][v][pvWeaponsAmmo][2] = 0;
		PlayerVehicleInfo[playerid][v][pvWepUpgrade] = 0;
		PlayerVehicleInfo[playerid][v][pvFuel] = 100.0;
		if(PlayerVehicleInfo[playerid][v][pvMesinUpgrade] == 1)
		{
			PlayerVehicleInfo[playerid][v][pvHealth] = 2000.0;
		}
		else
		{
			PlayerVehicleInfo[playerid][v][pvHealth] = 1000.0;
		}
		PlayerVehicleInfo[playerid][v][pvInsurances] = 0;
		PlayerVehicleInfo[playerid][v][pvMesinUpgrade] = 0;
		PlayerVehicleInfo[playerid][v][pvBodyUpgrade] = 0;
		PlayerVehicleInfo[playerid][v][pvStatus][0] = 0;
		PlayerVehicleInfo[playerid][v][pvStatus][1] = 0;
		PlayerVehicleInfo[playerid][v][pvStatus][2] = 0;
		PlayerVehicleInfo[playerid][v][pvStatus][3] = 0;
		PlayerVehicleInfo[playerid][v][pvLicense] = 0;
		PlayerVehicleInfo[playerid][v][pvLicenseTime] = 0;
		format(PlayerVehicleInfo[playerid][v][pvLicenseExpired], 128, "None");
		format(PlayerVehicleInfo[playerid][v][pvToyText1], 128, "None");
		format(PlayerVehicleInfo[playerid][v][pvToyText2], 128, "None");
		format(PlayerVehicleInfo[playerid][v][pvToyText3], 128, "None");
		format(PlayerVehicleInfo[playerid][v][pvToyText4], 128, "None");
		format(PlayerVehicleInfo[playerid][v][pvToyText5], 128, "None");
		format(PlayerVehicleInfo[playerid][v][pvToyText6], 128, "None");
		format(PlayerVehicleInfo[playerid][v][pvToyText7], 128, "None");
		format(PlayerVehicleInfo[playerid][v][pvToyText8], 128, "None");
		format(PlayerVehicleInfo[playerid][v][pvToyText9], 128, "None");
		format(PlayerVehicleInfo[playerid][v][pvToyText10], 128, "None");
		format(PlayerVehicleInfo[playerid][v][pvNumberPlate], 32, "NO_HAVE");
		PlayerVehicleInfo[playerid][v][pvToyTextCol1] = 1;
		PlayerVehicleInfo[playerid][v][pvToyTextCol2] = 1;
		PlayerVehicleInfo[playerid][v][pvToyTextCol3] = 1;
		PlayerVehicleInfo[playerid][v][pvToyTextCol4] = 1;
		PlayerVehicleInfo[playerid][v][pvToyTextCol5] = 1;
		PlayerVehicleInfo[playerid][v][pvToyTextCol6] = 1;
		PlayerVehicleInfo[playerid][v][pvToyTextCol7] = 1;
		PlayerVehicleInfo[playerid][v][pvToyTextCol8] = 1;
		PlayerVehicleInfo[playerid][v][pvToyTextCol9] = 1;
		PlayerVehicleInfo[playerid][v][pvToyTextCol10] = 1;
		PlayerVehicleInfo[playerid][v][pvToyTextID1] = 0;
		PlayerVehicleInfo[playerid][v][pvToyTextID2] = 0;
		PlayerVehicleInfo[playerid][v][pvToyTextID3] = 0;
		PlayerVehicleInfo[playerid][v][pvToyTextID4] = 0;
		PlayerVehicleInfo[playerid][v][pvToyTextID5] = 0;
		PlayerVehicleInfo[playerid][v][pvToyTextID6] = 0;
		PlayerVehicleInfo[playerid][v][pvToyTextID7] = 0;
		PlayerVehicleInfo[playerid][v][pvToyTextID8] = 0;
		PlayerVehicleInfo[playerid][v][pvToyTextID9] = 0;
		PlayerVehicleInfo[playerid][v][pvToyTextID10] = 0;
		PlayerVehicleInfo[playerid][v][pvToyTextSize1] = 20;
		PlayerVehicleInfo[playerid][v][pvToyTextSize2] = 20;
		PlayerVehicleInfo[playerid][v][pvToyTextSize3] = 20;
		PlayerVehicleInfo[playerid][v][pvToyTextSize4] = 20;
		PlayerVehicleInfo[playerid][v][pvToyTextSize5] = 20;
		PlayerVehicleInfo[playerid][v][pvToyTextSize6] = 20;
		PlayerVehicleInfo[playerid][v][pvToyTextSize7] = 20;
		PlayerVehicleInfo[playerid][v][pvToyTextSize8] = 20;
		PlayerVehicleInfo[playerid][v][pvToyTextSize9] = 20;
		PlayerVehicleInfo[playerid][v][pvToyTextSize10] = 20;
		strcpy(PlayerVehicleInfo[playerid][v][pvAllowPlayer], "No-ne", MAX_PLAYER_NAME);
        PlayerVehicleInfo[playerid][v][pvAllowedPlayerId] = INVALID_PLAYER_ID;
        PlayerVehicleInfo[playerid][v][pvPark] = 0;
        ListItemReleaseId[playerid][v] = -1;
		ListItemTrackId[playerid][v] = -1;
       	for(new m = 0; m < MAX_MODS; m++)
	    {
            PlayerVehicleInfo[playerid][v][pvMods][m] = 0;
		}
		for(new vt = 0; vt < MAX_OBJECTS_PER_PLAYER; vt++)
		{
		    PlayerVehicleInfo[playerid][v][pvToyID][vt] = 0;
		    PlayerVehicleInfo[playerid][v][pvToyPosX][vt] = 0.00000;
		    PlayerVehicleInfo[playerid][v][pvToyPosY][vt] = 0.00000;
		    PlayerVehicleInfo[playerid][v][pvToyPosZ][vt] = 0.00000;
		    PlayerVehicleInfo[playerid][v][pvToyRotX][vt] = 0.000000;
		    PlayerVehicleInfo[playerid][v][pvToyRotY][vt] = 0.00000;
		    PlayerVehicleInfo[playerid][v][pvToyRotZ][vt] = 0.00000;
		    PlayerVehicleInfo[playerid][v][pvToyColor][vt] = 1;
		    PlayerVehicleInfo[playerid][v][pvToyIndex][vt] = 0;
		    PlayerVehicleInfo[playerid][v][pvToyTexture1][vt] = 0;
		    PlayerVehicleInfo[playerid][v][pvToyTexture2][vt] = 0;
		    PlayerVehicleInfo[playerid][v][pvToyTextureID][vt] = 0;
		}
	}
	PlayerRentInfo[playerid][prRentTime] = 0;
	PlayerRentInfo[playerid][prTax] = 0;
	PlayerRentInfo[playerid][prVehicleRent] = 0;
	PlayerRentInfo[playerid][prModelId] = 0;
	PlayerRentInfo[playerid][prPosX] = 0.0;
	PlayerRentInfo[playerid][prPosY] = 0.0;
	PlayerRentInfo[playerid][prPosZ] = 0.0;
	PlayerRentInfo[playerid][prPosAngle] = 0.0;
	PlayerRentInfo[playerid][prLock] = 3;
	PlayerRentInfo[playerid][prLocked] = 0;
	PlayerRentInfo[playerid][prColor1] = 0;
	PlayerRentInfo[playerid][prColor2] = 0;
	PlayerRentInfo[playerid][prFuel] = 100;
	PlayerRentInfo[playerid][prHealth] = 100.0;
	PlayerRentInfo[playerid][prStatus][0] = 0;
	PlayerRentInfo[playerid][prStatus][1] = 0;
	PlayerRentInfo[playerid][prStatus][2] = 0;
	PlayerRentInfo[playerid][prStatus][3] = 0;
	PlayerRentInfo[playerid][prPark] = 0;
	PlayerRentInfo[playerid][prTicket] = 0;
	for(new v = 0; v < MAX_PLAYERTOYS; v++)
	{
        PlayerToyInfo[playerid][v][ptModelID] = 0;
        PlayerToyInfo[playerid][v][ptBone] = 0;
        PlayerToyInfo[playerid][v][ptPosX] = 0.0;
        PlayerToyInfo[playerid][v][ptPosY] = 0.0;
        PlayerToyInfo[playerid][v][ptPosZ] = 0.0;
        PlayerToyInfo[playerid][v][ptRotX] = 0.0;
        PlayerToyInfo[playerid][v][ptRotY] = 0.0;
        PlayerToyInfo[playerid][v][ptRotZ] = 0.0;
        PlayerToyInfo[playerid][v][ptScaX] = 0.0;
        PlayerToyInfo[playerid][v][ptScaY] = 0.0;
        PlayerToyInfo[playerid][v][ptScaZ] = 0.0;
	}
	for(new s = 0; s < 12; s++)
	{
		PlayerInfo[playerid][pAGuns][s] = 0;
		PlayerInfo[playerid][pGuns][s] = 0;
		PlayerInfo[playerid][pGunsAmmo][s] = 0;
		PlayerInfo[playerid][pAGunsAmmo][s] = 0;
	}
	for(new s = 0; s < 40; s++)
	{
		ListItemReportId[playerid][s] = -1;
	}
	CancelReport[playerid] = -1;
	GiveKeysTo[playerid] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pPayDay] = 0;
	PlayerInfo[playerid][pCDPlayer] = 0;
	PlayerInfo[playerid][pWins] = 0;
	PlayerInfo[playerid][pLoses] = 0;
	PlayerInfo[playerid][pTut] = 0;
	PlayerInfo[playerid][pTutorial] = 0;
	PlayerInfo[playerid][pWarns] = 0;
	PlayerInfo[playerid][pRope] = 0;
	PlayerInfo[playerid][pDice] = 0;
	PlayerInfo[playerid][pCangkul] = 0;
	PlayerInfo[playerid][pScrewdriver] = 0;
	PlayerInfo[playerid][pAdjustable] = 0;
	PlayerInfo[playerid][pWantedLevel] = 0;
	PlayerInfo[playerid][pInsurance] = 0;
	PlayerInfo[playerid][pDutyHours] = 0;
	PlayerInfo[playerid][pAcceptedHelp] = 0;
	PlayerInfo[playerid][pAcceptReport] = 0;
	PlayerInfo[playerid][pTrashReport] = 0;
	PlayerInfo[playerid][pGiftTime] = 0;
	PlayerInfo[playerid][pTicketTime] = 0;
	PlayerInfo[playerid][pServiceTime] = 0; // lel*/
	strcpy(PlayerInfo[playerid][pAdminName], "None", MAX_PLAYER_NAME);
	strcpy(PlayerInfo[playerid][pNormalName], "None", MAX_PLAYER_NAME);
	strcpy(PlayerInfo[playerid][pVIPName], "None", MAX_PLAYER_NAME);
	format(PlayerInfo[playerid][pAge],32,"None");
	format(PlayerInfo[playerid][pVIPExpDate],32,"null");
	ClearCrime(playerid);
	ClearMarriage(playerid);
	SetPlayerColor(playerid,TEAM_HIT_COLOR);
 	SetTimerEx("SafeLogin", 1000, 0, "d", playerid);
 	SyncPlayerTime(playerid);
 	
	HBEO[playerid] = CreatePlayerTextDraw(playerid, 551.199829, 340.479858, "_");
	PlayerTextDrawLetterSize(playerid, HBEO[playerid], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, HBEO[playerid], 129.600006, 145.599990);
	PlayerTextDrawFont(playerid, HBEO[playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawUseBox(playerid, HBEO[playerid], true);
	PlayerTextDrawBoxColor(playerid, HBEO[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, HBEO[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, HBEO[playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid, HBEO[playerid], 334.000000, 0.000000, -20.000000, 1.000000);

	HBEName[playerid] = CreatePlayerTextDraw(playerid, 546.399841, 331.519897, "E");
	PlayerTextDrawLetterSize(playerid, HBEName[playerid], 0.425998, 1.712000);
	PlayerTextDrawAlignment(playerid, HBEName[playerid], 2);
	PlayerTextDrawColor(playerid, HBEName[playerid], -1);
	PlayerTextDrawUseBox(playerid, HBEName[playerid], true);
	PlayerTextDrawBoxColor(playerid, HBEName[playerid], 0);
	PlayerTextDrawSetShadow(playerid, HBEName[playerid], 0);
	PlayerTextDrawSetOutline(playerid, HBEName[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, HBEName[playerid], 51);
	PlayerTextDrawFont(playerid, HBEName[playerid], 0);
	PlayerTextDrawSetProportional(playerid, HBEName[playerid], 1);

	return 1;
}

//-----------------[Get color code by name]----------------------
public GetColorCode(clr[]) {
	new color = -1;
	if (IsNumeric(clr))
	{
		color = strval(clr);
		return color;
	}
	if(strcmp(clr, "black", true)==0) color=0;
	if(strcmp(clr, "white", true)==0) color=1;
	if(strcmp(clr, "blue", true)==0) color=2;
	if(strcmp(clr, "red", true)==0) color=3;
	if(strcmp(clr, "green", true)==0) color=16;
	if(strcmp(clr, "purple", true)==0) color=5;
	if(strcmp(clr, "yellow", true)==0) color=6;
	if(strcmp(clr, "lightblue", true)==0) color=7;
	if(strcmp(clr, "navy", true)==0) color=94;
	if(strcmp(clr, "beige", true)==0) color=102;
	if(strcmp(clr, "darkgreen", true)==0) color=51;
	if(strcmp(clr, "darkblue", true)==0) color=103;
	if(strcmp(clr, "darkgrey", true)==0) color=13;
	if(strcmp(clr, "gold", true)==0) color=99;
	if(strcmp(clr, "brown", true)==0 || strcmp(clr, "dennell", true)==0) color=55;
	if(strcmp(clr, "darkbrown", true)==0) color=84;
	if(strcmp(clr, "darkred", true)==0) color=74;
	if(strcmp(clr, "maroon", true)==0) color=115;
	if(strcmp(clr, "pink", true)==0) color=126;
	return color;
}

doesAccountExist(account_name[]) {

	new
		sz_accStr[MAX_PLAYER_NAME + 12];

	format(sz_accStr, sizeof(sz_accStr), "users/%s.ini", account_name);
	if(fexist(sz_accStr)) {

		new
			File: f_Handle = fopen(sz_accStr, io_read);

		if(flength(f_Handle) > 0) {
			fclose(f_Handle);
			return 1;
		}
		fclose(f_Handle);
	}
	return 0;
}

SendClientMessageEx(playerid, color, String[])
{
	if(InsideMainMenu[playerid] == 1 || InsideTut[playerid] == 1)
		return 0;

	else SendClientMessage(playerid, color, String);
	return 1;
}

SendClientMessageToAllEx(color, String[])
{
	foreach(Player, i)
	{
		if(InsideMainMenu[i] == 1 || InsideTut[i] == 1) {}
		else SendClientMessage(i, color, String);
	}
	return 1;
}

public SetupPlayerForClassSelection(playerid) //default class selection screen
{
	SetPlayerJoinCamera(playerid);
	return 1;
}

SetPlayerJoinCamera(playerid)
{
	new randcamera = Random(1,8);
	switch(randcamera)
	{
		case 1: // Gym
		{
			AC_BS_SetPlayerVirtualWorld(playerid, 0);
			AC_BS_SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,2229.4968,-1722.0701,13.5625);
			AC_BS_SetPlayerPos(playerid,2211.1460,-1748.3909,-10.0);
			SetPlayerCameraPos(playerid,2211.1460,-1748.3909,29.3744);
			SetPlayerCameraLookAt(playerid,2229.4968,-1722.0701,13.5625);
		}
		case 2: // LSPD
		{
			AC_BS_SetPlayerVirtualWorld(playerid, 0);
			AC_BS_SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,1554.3381,-1675.5692,16.1953);
			AC_BS_SetPlayerPos(playerid,1514.7783,-1700.2913,-10.0);
			SetPlayerCameraPos(playerid,1514.7783,-1700.2913,36.7506);
			SetPlayerCameraLookAt(playerid,1554.3381,-1675.5692,16.1953);
		}
		case 3: // SaC HQ (Gang HQ)
		{
			AC_BS_SetPlayerVirtualWorld(playerid, 0);
			AC_BS_SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,655.5394,-1867.2231,5.4609);
			AC_BS_SetPlayerPos(playerid,655.5394,-1867.2231,-10.0);
			SetPlayerCameraPos(playerid,699.7435,-1936.7568,24.8646);
			SetPlayerCameraLookAt(playerid,655.5394,-1867.2231,5.4609);

		}
		case 4: // Fishing Pier
		{
			AC_BS_SetPlayerVirtualWorld(playerid, 0);
			AC_BS_SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,370.0804,-2087.8767,7.8359);
			AC_BS_SetPlayerPos(playerid,370.0804,-2087.8767,-10.0);
			SetPlayerCameraPos(playerid,423.3802,-2067.7915,29.8605);
			SetPlayerCameraLookAt(playerid,370.0804,-2087.8767,7.8359);
		}
		case 5: // VIP
		{
			AC_BS_SetPlayerVirtualWorld(playerid, 0);
			AC_BS_SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,1797.3397,-1578.3440,14.0798);
			AC_BS_SetPlayerPos(playerid,1797.3397,-1578.3440,-10.0);
			SetPlayerCameraPos(playerid,1832.1698,-1600.1538,32.2877);
			SetPlayerCameraLookAt(playerid,1797.3397,-1578.3440,14.0798);
		}
		case 6: // All Saints
		{
			AC_BS_SetPlayerVirtualWorld(playerid, 0);
			AC_BS_SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,1175.5581,-1324.7922,18.1610);
			AC_BS_SetPlayerPos(playerid, 1188.4574,-1309.2242,-10.0);
			SetPlayerCameraPos(playerid,1188.4574,-1309.2242,13.5625+6.0);
			SetPlayerCameraLookAt(playerid,1175.5581,-1324.7922,18.1610);
		}
		case 7: // Unity
		{
			AC_BS_SetPlayerVirtualWorld(playerid, 0);
			AC_BS_SetPlayerInterior(playerid, 0);
			Streamer_UpdateEx(playerid,1716.1129,-1880.0715,22.0264);
			AC_BS_SetPlayerPos(playerid,1716.1129,-1880.0715,-10.0);
			SetPlayerCameraPos(playerid,1755.0413,-1824.8710,20.2100);
			SetPlayerCameraLookAt(playerid,1716.1129,-1880.0715,22.0264);
		}
	}
	return 1;
}

ShowMainMenuDialog(playerid, frame)
{
	new titleString[10000];
	new String[10000];

	switch(frame)
	{
		case 1:
		{
			format(titleString, sizeof(titleString), "Login ke Just Life Roleplay");
			format(String, sizeof(String), "Selamat datang di Server Roleplay Just Life Roleplay.\n\nAccount:{FF0000}%s\n\n{FFFF00}Tolong masukan password di kotak bawah ini:", PlayerInfo[playerid][pNormalName]);
			ShowPlayerDialog(playerid,MAINMENU,DIALOG_STYLE_PASSWORD,titleString,String,"Login","Exit");
		}
		case 2:
		{
			format(titleString, sizeof(titleString), "Register ke Just Life Roleplay");
			format(String, sizeof(String), "Selamat datang di Server Roleplay Just Life Roleplay.\n\nAccount:{FF0000}%s\n\n{FFFF00}Tolong masukan password di kotak bawah ini:", PlayerInfo[playerid][pNormalName]);
			ShowPlayerDialog(playerid,MAINMENU2,DIALOG_STYLE_PASSWORD,titleString,String,"Register","Exit");
		}
		case 3:
		{
			format(titleString, sizeof(titleString), "Login ke Just Life Roleplay");
			format(String, sizeof(String), "Selamat datang di Server Roleplay Just Life Roleplay.\n\nAccount:{FF0000}%s\n\n{FFFF00}Tolong masukan password di kotak bawah ini:", PlayerInfo[playerid][pNormalName]);
			ShowPlayerDialog(playerid,MAINMENU,DIALOG_STYLE_PASSWORD,titleString,String,"Login","Exit");
		}
	}
}


public SafeLogin(playerid)
{

	// Main Menu Features.
	SetupPlayerForClassSelection(playerid);

	GetPlayerName(playerid, PlayerInfo[playerid][pNormalName], MAX_PLAYER_NAME);

	new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
	if(doesAccountExist(playername))
	{
		gPlayerAccount[playerid] = 1;
		ShowMainMenuDialog(playerid, 1);
		return 1;
	}
	else
	{
		if( strfind( playername, "_", true) == -1 )
		{
			SendClientMessageEx( playerid, COLOR_ARWIN, "ERROR: {FFFFFF}Koneksi ditolak. Masukan nama dengan format yang benar: Namadepan_Namabelakang." );
		}
		else
  		{
			gPlayerAccount[playerid] = 0;
			ShowMainMenuDialog(playerid, 2);
		}
		
		return 1;
	}
}

public SafeLoadObjects(playerid)
{
	Streamer_Update(playerid);
	if(GetPVarType(playerid, "LoadingObjects"))
	{
		DeletePVar(playerid, "LoadingObjects");
		TogglePlayerControllable(playerid, 1);
	}
	if(GetPVarType(playerid, "MedicCall"))
	{
	    ClearAnimations(playerid);
		ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0, 0, 1, 1, 1, 0, 1);
		TogglePlayerControllable(playerid, 0);
	}
}

public ClearMarriage(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new String[MAX_PLAYER_NAME];
		format(String, sizeof(String), "Nothing");
		strmid(PlayerInfo[playerid][pMarriedTo], String, 0, strlen(String), 255);
		PlayerInfo[playerid][pMarried] = 0;
	}
	return 1;
}

public ClearWS(wsid)
{
	format(WsInfo[wsid][wsOwner], 32, "Nothing");
	WsInfo[wsid][wsSafeMoney] = 0;
	WsInfo[wsid][wsPapanMT] = 0;
}
////////////////////////FARM OWNERSHIP Coded by AriWiwin14/////////////////////////
public ClearFarm(farmid)
{
	format(FarmInfo[farmid][FarmOwner], 32, "Tidak Ada");
	FarmInfo[farmid][FarmSafeMoney] = 0;
	FarmInfo[farmid][FarmPapanMT] = 0;
}

public ClearHouse(houseid)
{
	HouseInfo[houseid][hOwned] = 0;
	HouseInfo[houseid][hSafeMoney] = 0;
	HouseInfo[houseid][hPot] = 0;
	HouseInfo[houseid][hCrack] = 0;
	HouseInfo[houseid][hMaterials] = 0;
	HouseInfo[houseid][hWeapons][0] = 0;
	HouseInfo[houseid][hWeapons][1] = 0;
	HouseInfo[houseid][hWeapons][2] = 0;
	HouseInfo[houseid][hWeapons][3] = 0;
	HouseInfo[houseid][hWeapons][4] = 0;
	HouseInfo[houseid][hWeaponsAmmo][0] = 0;
	HouseInfo[houseid][hWeaponsAmmo][1] = 0;
	HouseInfo[houseid][hWeaponsAmmo][2] = 0;
	HouseInfo[houseid][hWeaponsAmmo][3] = 0;
	HouseInfo[houseid][hWeaponsAmmo][4] = 0;
	HouseInfo[houseid][hGLUpgrade] = 1;
}

public ClearFamily(family)
{
	foreach(Player, i)
	{
		if(PlayerInfo[i][pFMember] == family)
		{
			SendClientMessageEx(i, COLOR_LIGHTBLUE, "* The Family you are in has just been deleted by an Admin, you have been kicked out automatically.");
			PlayerInfo[i][pFMember] = 255;
		}
	}
	new String[MAX_PLAYER_NAME];
	format(String, sizeof(String), "None");
	FamilyInfo[family][FamilyTaken] = 0;
	strmid(FamilyInfo[family][FamilyName], String, 0, strlen(String), 255);
	strmid(FamilyInfo[family][FamilyMOTD], String, 0, strlen(String), 255);
	strmid(FamilyInfo[family][FamilyLeader], String, 0, strlen(String), 255);
	format(String, sizeof(String), "Outsider");
	strmid(FamilyInfo[family][FamilyRank1], String, 0, strlen(String), 255);
	format(String, sizeof(String), "Associate");
	strmid(FamilyInfo[family][FamilyRank2], String, 0, strlen(String), 255);
	format(String, sizeof(String), "Soldier");
	strmid(FamilyInfo[family][FamilyRank3], String, 0, strlen(String), 255);
	format(String, sizeof(String), "Capo");
	strmid(FamilyInfo[family][FamilyRank4], String, 0, strlen(String), 255);
	format(String, sizeof(String), "Underboss");
	strmid(FamilyInfo[family][FamilyRank5], String, 0, strlen(String), 255);
	format(String, sizeof(String), "Godfather");
	strmid(FamilyInfo[family][FamilyRank6], String, 0, strlen(String), 255);
	FamilyInfo[family][FamilyColor] = 0;
	FamilyInfo[family][FamilyTurfTokens] = 24;
	FamilyInfo[family][FamilyMembers] = 0;
	FamilyInfo[family][FamilySpawn][0] = 0.0;
	FamilyInfo[family][FamilySpawn][1] = 0.0;
	FamilyInfo[family][FamilySpawn][2] = 0.0;
	FamilyInfo[family][FamilySpawn][3] = 0.0;
	FamilyInfo[family][FamilyGuns][0] = 0;
	FamilyInfo[family][FamilyGuns][1] = 0;
    FamilyInfo[family][FamilyGuns][2] = 0;
    FamilyInfo[family][FamilyGuns][3] = 0;
    FamilyInfo[family][FamilyGuns][4] = 0;
    FamilyInfo[family][FamilyGuns][5] = 0;
    FamilyInfo[family][FamilyGuns][6] = 0;
    FamilyInfo[family][FamilyGuns][7] = 0;
	FamilyInfo[family][FamilyGuns][8] = 0;
	FamilyInfo[family][FamilyGuns][9] = 0;
	FamilyInfo[family][FamilyGunsAmmo][0] = 0;
	FamilyInfo[family][FamilyGunsAmmo][1] = 0;
    FamilyInfo[family][FamilyGunsAmmo][2] = 0;
    FamilyInfo[family][FamilyGunsAmmo][3] = 0;
    FamilyInfo[family][FamilyGunsAmmo][4] = 0;
    FamilyInfo[family][FamilyGunsAmmo][5] = 0;
    FamilyInfo[family][FamilyGunsAmmo][6] = 0;
    FamilyInfo[family][FamilyGunsAmmo][7] = 0;
	FamilyInfo[family][FamilyGunsAmmo][8] = 0;
	FamilyInfo[family][FamilyGunsAmmo][9] = 0;
	FamilyInfo[family][FamilyCash] = 0;
	FamilyInfo[family][FamilyMats] = 0;
	FamilyInfo[family][FamilyPot] = 0;
	FamilyInfo[family][FamilyCrack] = 0;
	FamilyInfo[family][FamilySafe][0] = 0.0;
	FamilyInfo[family][FamilySafe][1] = 0.0;
	FamilyInfo[family][FamilySafe][2] = 0.0;
	FamilyInfo[family][FamilyUSafe] = 0;
	if(IsValidDynamicPickup(FamilyInfo[family][FamilyEntrancePickup])) DestroyDynamicPickup( FamilyInfo[family][FamilyEntrancePickup] );
	if(IsValidDynamicPickup(FamilyInfo[family][FamilyExitPickup])) DestroyDynamicPickup( FamilyInfo[family][FamilyExitPickup] );
	DestroyDynamic3DTextLabel( Text3D:FamilyInfo[family][FamilyEntranceText] );
	DestroyDynamic3DTextLabel( Text3D:FamilyInfo[family][FamilyExitText] );
	DestroyDynamicPickup( FamilyInfo[family][FamilyPickup] );
	SaveFamilies();
	return 1;
}

public ClearCrime(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new String[MAX_PLAYER_NAME];
		format(String, sizeof(String), "Nothing");
		strmid(PlayerCrime[playerid][pBplayer], String, 0, strlen(String), 255);
		strmid(PlayerCrime[playerid][pVictim], String, 0, strlen(String), 255);
		strmid(PlayerCrime[playerid][pAccusing], String, 0, strlen(String), 255);
		strmid(PlayerCrime[playerid][pAccusedof], String, 0, strlen(String), 255);
	}
	return 1;
}
//------------------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid, reason)
{
    if(PlayerInfo[playerid][pAdminDuty] == 1)
    {
        PlayerInfo[playerid][pAdminDuty] = 0;
		AC_BS_SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
		AC_BS_SetPlayerArmour(playerid, PlayerInfo[playerid][pArmor]);
		SetPlayerName(playerid, PlayerInfo[playerid][pNormalName]);
		SetPlayerColor(playerid, 0xFFFFFF00);
		SetPVarInt(playerid, "AdminProtect", 0);
	}
    GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
    TextDrawHideForPlayer(playerid, LBox[playerid]);
	TextDrawHideForPlayer(playerid, LLine1[playerid]);
	TextDrawHideForPlayer(playerid, LLine2[playerid]);
	TextDrawHideForPlayer(playerid, LLine3[playerid]);
	TextDrawHideForPlayer(playerid, LCredits[playerid]);
	HideProgressBarForPlayer(playerid, phealth[playerid]);
	HideProgressBarForPlayer(playerid, parmor[playerid]);
	LuX_SpeedoMeter[playerid] = 0;
 	SaveWeaponInfo(playerid);
	KillTimer(WeaponCheckTimer[playerid]);
	for(new v; v < MAX_PLAYERVEHICLES; ++v)
	{
	    for(new vt = 0; vt < MAX_OBJECTS_PER_PLAYER; vt++)
     	{
	         	new Float:x, Float:y, Float:z, Float:angle, Float:health, Float:fuel;
         	 	DestroyDynamicObject(PlayerVehicleInfo[playerid][v][pvToy][vt]);
	            DestroyDynamicObject(PlayerVehicleInfo[playerid][v][pvNeonObj]);
				DestroyDynamicObject(PlayerVehicleInfo[playerid][v][pvNeonObj2]);
				DestroyDynamicObject(PlayerVehicleInfo[playerid][v][pvNeonObj3]);
				DestroyDynamicObject(PlayerVehicleInfo[playerid][v][pvNeonObj4]);
			 	GetVehicleDamageStatus(PlayerVehicleInfo[playerid][v][pvId], PlayerVehicleInfo[playerid][v][pvStatus][0], PlayerVehicleInfo[playerid][v][pvStatus][1], PlayerVehicleInfo[playerid][v][pvStatus][2], PlayerVehicleInfo[playerid][v][pvStatus][3]);
				GetVehicleHealth(PlayerVehicleInfo[playerid][v][pvId], health);
				if(PlayerInfo[playerid][pLockCar] == GetPlayerVehicleID(playerid)) PlayerInfo[playerid][pLockCar] = INVALID_VEHICLE_ID;
				GetVehiclePos(PlayerVehicleInfo[playerid][v][pvId], x, y, z);
				GetVehicleZAngle(PlayerVehicleInfo[playerid][v][pvId], angle);
				PlayerVehicleInfo[playerid][v][pvPosX] = x;
				PlayerVehicleInfo[playerid][v][pvPosY] = y;
				PlayerVehicleInfo[playerid][v][pvPosZ] = z;
				PlayerVehicleInfo[playerid][v][pvPosAngle] = angle;
				PlayerVehicleInfo[playerid][v][pvFuel] = fuel;
				PlayerVehicleInfo[playerid][v][pvHealth] = health;
		}
	}
	if(GetPVarInt(playerid, "HaveADO") == 1) RemovePlayerADO(playerid);
	new Float:x,Float:y,Float:z,Float:a, Float:health;
 	GetVehicleDamageStatus(PlayerRentInfo[playerid][prId], PlayerRentInfo[playerid][prStatus][0], PlayerRentInfo[playerid][prStatus][1], PlayerRentInfo[playerid][prStatus][2], PlayerRentInfo[playerid][prStatus][3]);
	GetVehicleHealth(PlayerRentInfo[playerid][prId], health);
	GetVehiclePos(PlayerRentInfo[playerid][prId], x, y, z);
	GetVehicleZAngle(PlayerRentInfo[playerid][prId], a);
	PlayerRentInfo[playerid][prPosX] = x;
	PlayerRentInfo[playerid][prPosY] = y;
	PlayerRentInfo[playerid][prPosZ] = z;
	PlayerRentInfo[playerid][prPosAngle] = a;
	PlayerRentInfo[playerid][prHealth] = health;
	new weapons[13][2];
	for(new s = 0; s < 12; s++)
	{
	    GetPlayerWeaponData(playerid, s, weapons[s][0], weapons[s][1]);
	    PlayerInfo[playerid][pGuns][s] = weapons[s][0];
	    PlayerInfo[playerid][pGunsAmmo][s] = weapons[s][1];
	}
	for(new i; i <= 9; i++) // 9 = Total Dialog , Jadi kita mau tau kalau Player Ini Apakah Ambil Dialog dari 3 tersebut apa ga !
	{
		if(DialogSaya[playerid][i] == true) // Cari apakah dia punya salah satu diantara 10 dialog tersebut
		{
		    DialogSaya[playerid][i] = false; // Ubah Jadi Dia ga punya dialog lagi Kalau Udah Disconnect (Bukan dia lagi pemilik)
		    DialogHauling[i] = false; // Jadi ga ada yang punya nih dialog
		    DialogSweeper[i] = false; // Jadi ga ada yang punya nih dialog
		    DialogBus[i] = false; // Jadi ga ada yang punya nih dialog
		    DestroyVehicle(TrailerHauling[playerid]);
		}
	}
	//FlyMode
    PlayerPressedJump[playerid] = 0;
    TextDrawHideForPlayer(playerid, Time), TextDrawHideForPlayer(playerid, Date);
	if(GetPVarType(playerid, "BoomboxObject"))
    {
        DestroyDynamicObject(GetPVarInt(playerid, "BoomboxObject"));
        if(GetPVarType(playerid, "bboxareaid"))
        {
            foreach(Player,i)
            {
                if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "bboxareaid")))
                {
                    StopAudioStreamForPlayer(i);
                     SendClientMessage(i, COLOR_GREY, " The boombox creator has disconnected from the server.");
                }
            }
        }
    }
 	new VID = GetPlayerVehicleID(playerid);
    DestroyDynamicObject(SirenObject[VID]);
 	{
	 	DestroyDynamicObject(GetPVarInt(playerid, "neon")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon1")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon2")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon3"));
	  	DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon4")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon5")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon6")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon7"));
	  	DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon8")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon9")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon10")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon11"));
	  	DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon12")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon13")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon14")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon15"));
	  	DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon16")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon17")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon18")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon19"));
	  	DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon20")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon21")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon22")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon23"));
	  	DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon24")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon25")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon26")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon27"));
	  	DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon28")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon29")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon30")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon31"));
	  	DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon32")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon33")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon34")); DeletePVar(playerid, "Status"); DestroyDynamicObject(GetPVarInt(playerid, "neon35"));
	}
	// Crash Fix - GhoulSlayeR
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	if(!strcmp(name, "InvalidNick", true)) return 1;
	if(!strcmp(name, "BannedPlayer", true)) return 1;

	TextDrawDestroy(DescriptionText[playerid]);
	TextDrawHideForPlayer(playerid, Kotak);
	TextDrawHideForPlayer(playerid, Rp);
	TextDrawHideForPlayer(playerid, forum);
	TextDrawHideForPlayer(playerid, sen);
	TextDrawHideForPlayer(playerid, koma2);

	if(playerid == MAX_PLAYERS) return 1;
	PlayersConnected--;
	if (GetPVarInt(playerid, "HungerBar") == 1)
		{
			DeletePVar(playerid, "HungerBar");
			DeletePVar(playerid, "hTimerOn");
		}
		if (GetPVarInt(playerid, "EnergyBar") == 1)
		{
			DeletePVar(playerid, "EnergyBar");
			DeletePVar(playerid, "eTimerOn");
		}
		if (GetPVarInt(playerid, "BladderBar") == 1)
		{
			DeletePVar(playerid, "BladderBar");
			DeletePVar(playerid, "bTimerOn");
		}
		if (GetPVarInt(playerid, "ConditionBar") == 1)
		{
			DeletePVar(playerid, "ConditionBar");
			DeletePVar(playerid, "cTimerOn");
		}
		FirstSpawn[playerid] = 0;
		KillTimer(PBHTimer[playerid]);
		KillTimer(PBETimer[playerid]);
		KillTimer(PBBTimer[playerid]);
		KillTimer(PBCTimer[playerid]);
	if(pTazer[playerid] == 1) givePlayerValidWeapon(playerid,pTazerReplace[playerid], AMMO_MELEE);
	if(GetPVarInt(playerid, "SpeedRadar") == 1) givePlayerValidWeapon(playerid, GetPVarInt(playerid, "RadarReplacement"), 250);
	if(GetPVarInt(playerid, "MovingStretcher") != -1)
	{
	    KillTimer(GetPVarInt(playerid, "TickEMSMove"));
	    DeletePVar(GetPVarInt(playerid, "MovingStretcher"), "OnStretcher");
	    SetPVarInt(playerid, "MovingStretcher", -1);
	}
	if(PlayerInfo[playerid][pLockCar] != INVALID_VEHICLE_ID)
	{
		vehicle_unlock_doors(PlayerInfo[playerid][pLockCar]);
	}
	if(PlayerInfo[playerid][pVehicleKeysFrom] != INVALID_PLAYER_ID)
	{
        PlayerVehicleInfo[PlayerInfo[playerid][pVehicleKeysFrom]][PlayerInfo[playerid][pVehicleKeys]][pvAllowedPlayerId] = INVALID_PLAYER_ID;
	}
	new String[10000];
	switch (reason)
	{
 	   	case 0:
	   	{
		   	format(String, sizeof(String), "%s telah meninggalkan server (timeout).", PlayerInfo[playerid][pNormalName]);
		   	ProxDetector(30.0, playerid, String, COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	   	}
	   	case 1:
 	  	{
		   	format(String, sizeof(String), "%s telah meninggalkan server (pergi).", PlayerInfo[playerid][pNormalName]);
		   	ProxDetector(30.0, playerid, String, COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		}
		case 2:
	    {
			format(String, sizeof(String), "%s telah meninggalkan server (kicked/banned).", PlayerInfo[playerid][pNormalName]);
			ProxDetector(30.0, playerid, String, COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	   	}
	}
	if(EventKernel[EventCreator] == playerid)
	{
	    EventKernel[EventCreator] = 999;
		ABroadCast( COLOR_YELLOW, "AdmWarning: The player that was creating an event has disconnected/crashed.", 4 );
	}
	else if(GetPVarInt(playerid, "EventToken") == 0)
	{
		new Float: xx, Float: yy, Float: zz;
		PlayerInfo[playerid][pInt] = GetPlayerInterior(playerid);
		PlayerInfo[playerid][pVW] = GetPlayerVirtualWorld(playerid);
		PlayerInfo[playerid][pChar] = PlayerInfo[playerid][pModel];
		GetPlayerPos(playerid, xx, yy, zz);
		GetPlayerFacingAngle(playerid, PlayerInfo[playerid][pPos_r]);
		PlayerInfo[playerid][pPos_x] = xx;
		PlayerInfo[playerid][pPos_y] = yy;
		PlayerInfo[playerid][pPos_z] = zz;
	}
	else if(GetPVarInt(playerid, "EventToken") == 1)
	{
	    PlayerInfo[playerid][pInt] = EventLastInt[playerid];
		PlayerInfo[playerid][pVW] = EventLastVW[playerid];
		PlayerInfo[playerid][pChar] = PlayerInfo[playerid][pModel];
		PlayerInfo[playerid][pPos_r] = EventFloats[playerid][0];
		PlayerInfo[playerid][pPos_x] = EventFloats[playerid][1];
		PlayerInfo[playerid][pPos_y] = EventFloats[playerid][2];
		PlayerInfo[playerid][pPos_z] = EventFloats[playerid][3];
	}
	if(WatchingTV[playerid] == 1)
	{
	    PlayerInfo[playerid][pInt] = BroadcastLastInt[playerid];
		PlayerInfo[playerid][pVW] = BroadcastLastVW[playerid];
		PlayerInfo[playerid][pPos_r] = BroadcastFloats[playerid][0];
		PlayerInfo[playerid][pPos_x] = BroadcastFloats[playerid][1];
		PlayerInfo[playerid][pPos_y] = BroadcastFloats[playerid][2];
		PlayerInfo[playerid][pPos_z] = BroadcastFloats[playerid][3];
		WatchingTV[playerid] = 0;
		viewers--;
		UpdateSANewsBroadcast();
	}
	if(Spectate[playerid] < 553)
	{
        PlayerInfo[playerid][pInt] = GetPVarInt(playerid, "SpecInt");
		PlayerInfo[playerid][pVW] = GetPVarInt(playerid, "SpecVW");
		PlayerInfo[playerid][pChar] = PlayerInfo[playerid][pModel];
		PlayerInfo[playerid][pPos_x] = GetPVarFloat(playerid, "SpecPosX");
		PlayerInfo[playerid][pPos_y] = GetPVarFloat(playerid, "SpecPosY");
		PlayerInfo[playerid][pPos_z] = GetPVarFloat(playerid, "SpecPosZ");
	    GettingSpectated[Spectate[playerid]] = 999;
	    Spectate[playerid] = 999;
	}

	if(GetPVarInt(playerid, "fuelonoff") == 1)
 	{
  		DestroyProgressBar(FuelBar[playerid]);
    	textdrawscount--;
	    FuelBar[playerid] = INVALID_BAR_ID;
	}
	gActivePlayers[playerid]--;
	numplayers--;
	PlayerInfo[playerid][pAdjustable] = 1;
	OnPlayerStatsUpdate(playerid);
	UnloadPlayerVehicles(playerid);
	UnloadPlayerRent(playerid);
	infect[playerid] = 0;

	for(new i = 0; i < MAX_REPORTS; i++)
	{
	    if(Reports[i][ReportFrom] == playerid)
	    {
	        Reports[i][ReportFrom] = 999;
			Reports[i][BeingUsed] = 0;
			Reports[i][TimeToExpire] = 0;
		}
	}
	foreach(Player, i)
	{
		if(EMSAccepted[i] == playerid)
		{
			EMSAccepted[i] = 999;
			GameTextForPlayer(i, "~w~EMS Caller~n~~r~Left the game", 5000, 1);
			EMSCallTime[i] = 0;
			DisablePlayerCheckpoint(i);
		}
		if(MedicAccepted[i] == playerid)
		{
			MedicAccepted[playerid] = 999;
			GameTextForPlayer(i, "~w~Medic Caller~n~~r~Left the game", 5000, 1);
			MedicCallTime[i] = 0;
			DisablePlayerCheckpoint(i);
		}
		if(OrderAssignedTo[i] == playerid)
		{
		   OrderAssignedTo[i] = INVALID_PLAYER_ID;
		}
	}
	if(HireCar[playerid] != 299)
	{
		gLastDriver[HireCar[playerid]] = 300;
		vehicle_unlock_doors(HireCar[playerid]);
	}
	if (gLastCar[playerid] > 0)
	{
		gLastDriver[gLastCar[playerid]] = 300;
		if(PlayerInfo[playerid][pPhousekey] != gLastCar[playerid]-1)
		{
			vehicle_unlock_doors(gLastCar[playerid]);
		}
	}
	if(PlayerInfo[playerid][pMaskUse] == 1)
 	{
  		PlayerInfo[playerid][pMaskUse] = 0;
    	DestroyDynamic3DTextLabel(MaskLabel[playerid]);
    }
    if(PlayerInfo[playerid][pAdminDuty] == 1)
    {
        PlayerInfo[playerid][pAdminDuty] = 0;
        SetPlayerName(playerid, PlayerInfo[playerid][pNormalName]);
	}
	if(PlayerInfo[playerid][pJob] == 7 || PlayerInfo[playerid][pJob2] == 7)
	{
		if(JobDuty[playerid] == 1) { Mechanics -= 1; }
	}
	GetPlayerName(playerid, PlayerInfo[playerid][pNormalName], MAX_PLAYER_NAME);
	return 1;
}

HospitalSpawn(playerid)
{
	if(GetPVarInt(playerid, "MedicBill") == 1 && PlayerInfo[playerid][pJailed] == 0)
	{
		if(GetPVarInt(playerid, "Hospital") == 1)
		{
			AC_BS_SetPlayerArmour(playerid, PlayerInfo[playerid][pSHealth]);
			AC_BS_SetPlayerHealth(playerid, 50.0);
			PlayerInfo[playerid][pHealth] = 50.0;
			if(PlayerInfo[playerid][pHunger] < 50 || PlayerInfo[playerid][pBladder] < 50 || PlayerInfo[playerid][pEnergi] < 50)
			{
			    PlayerInfo[playerid][pHunger] = 50;
			    PlayerInfo[playerid][pBladder] = 50;
			    PlayerInfo[playerid][pEnergi] = 50;
			}
			pTerluka[playerid] = 0;
            DeletePVar(playerid, "Hospital");
			DeletePVar(playerid, "MedicBill");
			if(PlayerInfo[playerid][pInsurance] == 3)
			{
			    //GivePlayerCash(playerid, -1250);
				SendClientMessageEx(playerid, TEAM_CYAN_COLOR, "DOC: Karena anda memiliki Asuransi Kesehatan. Biaya perawatan ditanggung oleh {FF8000}Asuransi {FFFF00}");
			}
			else if(PlayerInfo[playerid][pInsurance] == 1)
			{
			    GivePlayerCash(playerid, -1000);
				SendClientMessageEx(playerid, TEAM_CYAN_COLOR, "DOC: Karena anda memiliki Asuransi Kesehatan. Biaya perawatan dipotong 50%");
			}
			else if(PlayerInfo[playerid][pInsurance] == 0)
			{
				GivePlayerCash(playerid, -2000);
				SendClientMessageEx(playerid, TEAM_CYAN_COLOR, "DOC: Biaya perawatan sebesar $20.00");
			}
		    AC_BS_SetPlayerPos(playerid, -198.3055,-1762.1797,675.7687);
		    SetPlayerFacingAngle(playerid, 67.077407);
			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, 1);
		}
	}
}

SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pChar] > 0)
		{
			SetPlayerSkin(playerid, PlayerInfo[playerid][pChar]);
		}
		else
		{
			SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
		}
		new rand;
  		if(PlayerInfo[playerid][pTut] == 0)
		{
			gOoc[playerid] = 1; gNews[playerid] = 1; gFam[playerid] = 1;
			TogglePlayerControllable(playerid,0);
			SetPlayerColor(playerid,TEAM_HIT_COLOR);
			AC_BS_SetPlayerPos(playerid, 1679.4342, -963.5275, 62.1913);
			SetPlayerCameraPos(playerid, 1682.7605, -832.4698, 95.1256);
			SetPlayerCameraLookAt(playerid, 1682.6489, -833.4603, 95.2104);
			ShowPlayerDialog(playerid,DTUT,DIALOG_STYLE_LIST,"Choose Gender:","Male Character\nFemale Character","Select", "");
			AC_BS_SetPlayerVirtualWorld(playerid, 0);
			return 1;
		}
		if(PlayerInfo[playerid][pJailed] == 1000)
		{
		    PhoneOnline[playerid] = 1;
			AC_BS_SetPlayerInterior(playerid, 0);
		 	rand = random(sizeof(OOCPrisonSpawns));
			SetPlayerFacingAngle(playerid, 0);
			AC_BS_SetPlayerPos(playerid, OOCPrisonSpawns[rand][0], OOCPrisonSpawns[rand][1], OOCPrisonSpawns[rand][2]);
			PlayerInfo[playerid][pVW] = 1;
			AC_BS_SetPlayerVirtualWorld(playerid, 1);
			//ApprovedLawyer[playerid] = 1;
			return 1;
		}
		if(PlayerInfo[playerid][pJailed] == 4)
		{
		    PhoneOnline[playerid] = 1;
		    TogglePlayerControllable(playerid, 1);
			AC_BS_SetPlayerInterior(playerid, 0);
			PlayerInfo[playerid][pInt] = 0;
			rand = random(sizeof(LSPDJail));
			PlayerInfo[playerid][pVW] = 0;
			AC_BS_SetPlayerVirtualWorld(playerid, 0);
			AC_BS_SetPlayerPos(playerid, LSPDJail[rand][0], LSPDJail[rand][1], LSPDJail[rand][2]);
			return 1;
		}
		if( GetPVarInt(playerid, "SpecOff" ) == 1 )
		{
			AC_BS_SetPlayerPos(playerid, GetPVarFloat(playerid, "SpecPosX"), GetPVarFloat(playerid, "SpecPosY"), GetPVarFloat(playerid, "SpecPosZ"));
			AC_BS_SetPlayerInterior(playerid, GetPVarInt(playerid, "SpecInt"));
			AC_BS_SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "SpecVW"));
			SetPVarInt(playerid, "SpecOff", 0 );
			SetPVarInt(playerid, "SpecState", -1 );
			for(new j=0; j<11; j++) GetPlayerWeaponData(playerid, j, PlayerInfo[playerid][pGuns][j], PlayerInfo[playerid][pGunsAmmo][j]);
			return 1;
		}
		if(GetPVarInt(playerid, "EventToken") == 1)
		{
		    DeletePVar(playerid, "EventToken");
		    SetPlayerWeapons(playerid);
		    AC_BS_SetPlayerPos(playerid,EventFloats[playerid][1],EventFloats[playerid][2],EventFloats[playerid][3]);
			//PlayerInfo[playerid][pInterior] = PlayerInfo[playerid][pInt];
			AC_BS_SetPlayerVirtualWorld(playerid, EventLastVW[playerid]);
			SetPlayerFacingAngle(playerid, EventFloats[playerid][0]);
			AC_BS_SetPlayerInterior(playerid,EventLastInt[playerid]);
			SetPlayerHealth(playerid, EventFloats[playerid][4]);
			PlayerInfo[playerid][pHealth] = EventFloats[playerid][4];
			SetPlayerArmour(playerid, EventFloats[playerid][5]);
			PlayerInfo[playerid][pArmor] = EventFloats[playerid][5];
			for(new i = 0; i < 6; i++)
			{
			    EventFloats[playerid][i] = 0.0;
			}
			EventLastVW[playerid] = 0;
			EventLastInt[playerid] = 0;
			return 1;
		}
		if(GetPVarInt(playerid, "Injured") == 1)
		{
		    SendEMSQueue(playerid,1);
		    TogglePlayerControllable(playerid,0);
		    return 1;
		}
		if(GetPVarInt(playerid, "MedicBill") == 1 && PlayerInfo[playerid][pJailed] == 0)
		{
			SendClientMessageEx( playerid, TEAM_CYAN_COLOR, "Hospital: Jika Anda masih ada yang terluka . datang ke kami saja !." );
			TogglePlayerControllable(playerid, 0);
			PlayerInfo[playerid][pDuty] = 0;
			PlayerInfo[playerid][pVW] = 0;
			PlayerInfo[playerid][pInt] = 0;
			AC_BS_SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid,0);
            if(PlayerInfo[playerid][pInsurance] == 0)
            {
				//ResetPlayerWeapons(playerid);
				SendClientMessageEx( playerid, COLOR_WHITE, "Hospital : Sebelum anda pergi, Rumah Sakit Menyita semua senjata anda" );
				TogglePlayerControllable(playerid,0);
			}
			if( GetPVarInt( playerid, "EventToken" ) == 1 )
			{
				SendClientMessageEx( playerid, COLOR_WHITE, "Hospital : Anda membayar dana dana perawatan rumah sakit." );
				TogglePlayerControllable(playerid,0);
			}
			else
			{
				SendClientMessageEx( playerid, COLOR_WHITE, "Hospital : Anda membayar dana dana perawatan rumah sakit." );
				TogglePlayerControllable(playerid,0);
			}

			SetPVarInt(playerid, "MedicBill", 1);
			AC_BS_SetPlayerInterior(playerid, 0);
			TogglePlayerControllable(playerid,0);
			new String[70+MAX_PLAYER_NAME];
			if(PlayerInfo[playerid][pInsurance] == 2)
			{
			    if(PlayerInfo[playerid][pWantedLevel] >= 1)
				{
				    SendClientMessageEx(playerid, COLOR_YELLOW, " Polisi telah memperingatkan bahwa Anda inginkan dan mereka sedang dalam perjalanan mereka.");
				    format(String, sizeof(String), " Semua Rumah Sakit Saints telah dilaporkan %s sebagai orang yang diinginkan.", GetPlayerNameEx(playerid));
				    SendRadioMessage(1, DEPTRADIO, String);
					SendRadioMessage(2, DEPTRADIO, String);
					SendRadioMessage(3, DEPTRADIO, String);
					SendRadioMessage(5, DEPTRADIO, String);
					SendRadioMessage(7, DEPTRADIO, String);
					SendRadioMessage(11, DEPTRADIO, String);
					SendRadioMessage(13, DEPTRADIO, String);
				}
				SetPlayerFacingAngle(playerid, 335.606689);
				ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0, 0, 1, 1, 1, 0, 1);
				SetPlayerCameraPos(playerid, -198.3055,-1762.1797,675.7687);
				SetPlayerCameraLookAt(playerid, -198.3055,-1762.1797,675.7687);
				AC_BS_SetPlayerPos(playerid, -198.3055,-1762.1797,675.7687+1.5);
				TogglePlayerControllable(playerid, 0);
				SetPVarInt(playerid, "Hospital", 1);
			}
   			if(PlayerInfo[playerid][pInsurance] == 0)
			{
    					if(PlayerInfo[playerid][pWantedLevel] >= 1)
						{
				    		SendClientMessageEx(playerid, COLOR_YELLOW, " The police has been warned that you are wanted and they are on their way.");
				    		format(String, sizeof(String), " All Saints Hospital has reported %s as a wanted person.", GetPlayerNameEx(playerid));
				    		SendRadioMessage(1, DEPTRADIO, String);
							SendRadioMessage(2, DEPTRADIO, String);
							SendRadioMessage(3, DEPTRADIO, String);
							SendRadioMessage(5, DEPTRADIO, String);
							SendRadioMessage(7, DEPTRADIO, String);
							SendRadioMessage(11, DEPTRADIO, String);
							SendRadioMessage(13, DEPTRADIO, String);
						}
						SetPlayerFacingAngle(playerid, 335.606689);
						ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0, 0, 1, 1, 1, 0, 1);
						SetPlayerCameraPos(playerid, -198.3055,-1762.1797,675.7687);
						SetPlayerCameraLookAt(playerid, -198.3055,-1762.1797,675.7687);
						AC_BS_SetPlayerPos(playerid, -198.3055,-1762.1797,675.7687+1.5);
						SetPVarInt(playerid, "Hospital", 1);
						TogglePlayerControllable(playerid, 0);
			}
			TogglePlayerControllable(playerid, 0);
			AC_BS_SetPlayerHealth(playerid, 0.5);
			PlayerInfo[playerid][pHealth] = 0.5;
			SetPVarInt(playerid, "HospitalTimer", 25);
			SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_HOSPITALTIMER);
			return 1;
		}
		if(GetPVarInt(playerid, "FirstSpawn") == 1)
		{
			AC_BS_SetPlayerPos(playerid,PlayerInfo[playerid][pPos_x],PlayerInfo[playerid][pPos_y],PlayerInfo[playerid][pPos_z]);
			AC_BS_SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pVW]);
			SetPlayerFacingAngle(playerid, PlayerInfo[playerid][pPos_r]);
			AC_BS_SetPlayerInterior(playerid,PlayerInfo[playerid][pInt]);
			AC_BS_SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
			AC_BS_SetPlayerArmour(playerid, PlayerInfo[playerid][pArmor]);
			SetCameraBehindPlayer(playerid);
			if(PlayerInfo[playerid][pInt] > 0)
			{
			    TogglePlayerControllable(playerid, 1);
			    GameTextForPlayer(playerid, "Objects loading...", 4000, 5);
			    SetPVarInt(playerid, "LoadingObjects", 1);
			    SetTimerEx("SafeLoadObjects", 4000, 0, "d", playerid);
		    }
		}
		else if(GetPVarInt(playerid, "FirstSpawn") == 1 && GetPVarInt(playerid, "Hospital") != 0)
		{
		    PlayerInfo[playerid][pDuty] = 0;
			PlayerInfo[playerid][pVW] = 0;
			PlayerInfo[playerid][pInt] = 0;
			AC_BS_SetPlayerVirtualWorld(playerid, 0);
			if( GetPVarInt( playerid, "EventToken" ) == 1 )
			{
				//SendClientMessageEx( playerid, COLOR_WHITE, "As you've just come from an event, your weapons have been refunded." );
			}
			else
			{
				//ResetPlayerWeapons(playerid);
			}

			SetPVarInt(playerid, "MedicBill", 1);
			new String[70+MAX_PLAYER_NAME];
			if(PlayerInfo[playerid][pInsurance] == 2)
			{
			    if(PlayerInfo[playerid][pWantedLevel] >= 1)
				{
				    SendClientMessageEx(playerid, COLOR_YELLOW, "The police have been informed of your current location and are on their way.");
				    format(String, sizeof(String), " All Saints Hospital has reported %s as a wanted person.", GetPlayerNameEx(playerid));
				    SendRadioMessage(1, DEPTRADIO, String);
					SendRadioMessage(2, DEPTRADIO, String);
					SendRadioMessage(3, DEPTRADIO, String);
					SendRadioMessage(5, DEPTRADIO, String);
					SendRadioMessage(7, DEPTRADIO, String);
					SendRadioMessage(11, DEPTRADIO, String);
					SendRadioMessage(13, DEPTRADIO, String);
				}
				SetPlayerFacingAngle(playerid, 335.606689);
        		ApplyAnimation(playerid, "SWAT","gnstwall_injurd", 4.0, 0, 1, 1, 1, 0, 0);
				SetPlayerCameraPos(playerid, -198.3055,-1762.1797,675.7687);
				SetPlayerCameraLookAt(playerid, -198.3055,-1762.1797,675.7687);
				AC_BS_SetPlayerPos(playerid, -198.3055,-1762.1797,675.7687+1.5);
				SetPVarInt(playerid, "Hospital", 1);
			}
   			if(PlayerInfo[playerid][pInsurance] == 0)
			{
    					if(PlayerInfo[playerid][pWantedLevel] >= 1)
						{
				    		SendClientMessageEx(playerid, COLOR_YELLOW, " The police has been warned that you are wanted and they are on their way.");
				    		format(String, sizeof(String), " All Saints Hospital has reported %s as a wanted person.", GetPlayerNameEx(playerid));
				    		SendRadioMessage(1, DEPTRADIO, String);
							SendRadioMessage(2, DEPTRADIO, String);
							SendRadioMessage(3, DEPTRADIO, String);
							SendRadioMessage(5, DEPTRADIO, String);
							SendRadioMessage(7, DEPTRADIO, String);
							SendRadioMessage(11, DEPTRADIO, String);
							SendRadioMessage(13, DEPTRADIO, String);
						}
						SetPlayerFacingAngle(playerid, 335.606689);
		        		ApplyAnimation(playerid, "SWAT","gnstwall_injurd", 4.0, 0, 1, 1, 1, 0, 0);
						SetPlayerCameraPos(playerid, -198.3055,-1762.1797,675.7687);
						SetPlayerCameraLookAt(playerid, -198.3055,-1762.1797,675.7687);
						AC_BS_SetPlayerPos(playerid, -198.3055,-1762.1797,675.7687+1.5);
						SetPVarInt(playerid, "Hospital", 1);
			}
			TogglePlayerControllable(playerid, 0);
			AC_BS_SetPlayerHealth(playerid, 0.5);
			PlayerInfo[playerid][pHealth] = 0.5;
			SetPVarInt(playerid, "HospitalTimer", 25);
			SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_HOSPITALTIMER);
		}
		new Float: x, Float: y, Float: z;
		GetPlayerPos(playerid, x, y, z);
		if(x == 0.0 && y == 0.0)
		{
  			AC_BS_SetPlayerInterior(playerid,0);
			AC_BS_SetPlayerPos(playerid, 1715.1201,-1903.1711,13.5665);
			SetPlayerFacingAngle(playerid, 359.4621);
			SetCameraBehindPlayer(playerid);
		}
		SetPlayerToTeamColor(playerid);
		return 1;
	}
	return 1;
}//------------------------------------------------------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	new String[10000];
	assert( AntiFlood_Check( playerid ) );
	pTazer[playerid] = 0;
	InsideShamal[playerid] = INVALID_VEHICLE_ID;
	DeletePVar(playerid, "SpeedRadar");
    DeletePVar(playerid, "UsingSprunk");
    KillTimer(GetPVarInt(playerid, "firstaid5"));
  	DeletePVar(playerid, "usingfirstaid");
	if(GetPVarInt(playerid, "MovingStretcher") != -1)
	{
	    KillTimer(GetPVarInt(playerid, "TickEMSMove"));
	    DeletePVar(GetPVarInt(playerid, "MovingStretcher"), "OnStretcher");
	    SetPVarInt(playerid, "MovingStretcher", -1);
	}

	new caller = Mobile[playerid];
	if(IsPlayerConnected(Mobile[playerid]))
	{
		SendClientMessageEx(caller,  COLOR_GRAD2, "The line went dead.");
		CellTime[caller] = 0;
		Mobile[caller] = INVALID_PLAYER_ID;
	}
	Mobile[playerid] = INVALID_PLAYER_ID;
	CellTime[playerid] = 0;
	RingTone[playerid] = 0;

	foreach(Player, i)
	{
		if(PlayerInfo[i][pAdmin] >= 1)
	    {
	    	SendDeathMessageToPlayer(i, killerid, playerid, reason);
	    }
		if(EMSAccepted[i] < 999)
		{
 			if(EMSAccepted[i] == playerid)
   			{
     			EMSAccepted[i] = 999;
       			GameTextForPlayer(i, "~w~EMS Caller~n~~r~Has Died", 5000, 1);
	        	EMSCallTime[i] = 0;
	        	DisablePlayerCheckpoint(i);
			}
		}
	}

	if(PlayerInfo[playerid][pMaskUse] == 1)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		   	ShowPlayerNameTagForPlayer(i, playerid, false);
		}
	}
	if(GetPVarInt(playerid, "Injured") == 1)
	{
     	SendClientMessageEx(playerid, COLOR_WHITE, "You appear to be stuck in limbo, medics are trying to revive you.");
	    KillEMSQueue(playerid);
	    TogglePlayerControllable(playerid,0);
	    return 1;
	}
	new Float:px,Float:py,Float:pz;
	if(GetPVarInt(playerid, "EventToken") == 0)
	{
	    if(GetPVarInt(playerid, "IsInArena") == -1)
		{
			SetPVarInt(playerid, "Injured", 1);
			pTerluka[playerid] += 1;
			new Float:mX, Float:mY, Float:mZ;
			GetPlayerPos(playerid, mX, mY, mZ);

			SetPVarFloat(playerid, "MedicX", mX);
			SetPVarFloat(playerid, "MedicY", mY);
			SetPVarFloat(playerid, "MedicZ", mZ);
			SetPVarInt(playerid, "MedicVW", GetPlayerVirtualWorld(playerid));
			SetPVarInt(playerid, "MedicInt", GetPlayerInterior(playerid));
		}
	}
	gPlayerSpawned[playerid] = 0;
	PlayerInfo[playerid][pLocal] = 255;
	GetPlayerPos(playerid, px, py, pz);

	if(PlayerInfo[killerid][pAdmin] < 1)
	{
	    if(reason == 49)
	    {
	    	format(String, sizeof(String), "AdmCmd: %s[id:%d] has possibly just car-rammed %s[id:%d] to death.", GetName(killerid), killerid, GetName(playerid), playerid);
	    	ABroadCast(COLOR_LIGHTRED, String, 1);
	    	print(String);
	    }
	    if(reason == 50)
	    {
	        if(IsAHelicopter(GetPlayerVehicleID(killerid)))
	        {
	    		format(String, sizeof(String), "AdmCmd: %s[id:%d] has possibly just blade-killed %s[id:%d].", GetName(killerid), killerid, GetName(playerid), playerid);
	    		ABroadCast(COLOR_LIGHTRED, String, 1);
	    		print(String);
	    	}
	    	else
	    	{
	    	    if(GetPlayerWeapon(killerid) != 32 || GetPlayerWeapon(killerid) != 28 || GetPlayerWeapon(killerid) != 29)
	    	    {
	    			format(String, sizeof(String), "AdmCmd: %s[id:%d] has possibly just car-parked %s[id:%d] to death.", GetName(killerid), killerid, GetName(playerid), playerid);
	    			ABroadCast(COLOR_LIGHTRED, String, 1);
	    			print(String);
	    		}
	    		else
	    		{
	    			format(String, sizeof(String), "AdmCmd: %s[id:%d] has possibly just driver-shot %s[id:%d] to death.", GetName(killerid), killerid, GetName(playerid), playerid);
	    			ABroadCast(COLOR_LIGHTRED, String, 1);
	    			print(String);
	    		}
	    	}
	    }
	}
	if (gPlayerCheckpointStatus[playerid] > 4 && gPlayerCheckpointStatus[playerid] < 11)
	{
		DisablePlayerCheckpoint(playerid);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
	}
	killerid = INVALID_PLAYER_ID;
	return 1;
}
AntiFlood_Check( playerid, bool:inc=true )
{
	AntiFlood_Data[playerid][floodRate] += inc ? RATE_INC : 0;
	AntiFlood_Data[playerid][floodRate] = AntiFlood_Data[playerid][floodRate] - ( GetTickCount() - AntiFlood_Data[playerid][lastCheck] );
	AntiFlood_Data[playerid][lastCheck] = GetTickCount();
	AntiFlood_Data[playerid][floodRate] = AntiFlood_Data[playerid][floodRate] < 0 ? 0 : AntiFlood_Data[playerid][floodRate];

	if ( AntiFlood_Data[playerid][floodRate] >= RATE_MAX )
	{
		SendClientMessage( playerid, 0xC00000FF, "Stop flooding." );
		return false;
	}
	return true;
}

AntiFlood_InitPlayer( playerid )
{
	AntiFlood_Data[playerid][lastCheck] = GetTickCount();
	AntiFlood_Data[playerid][floodRate] = 0;
}
public OnVehicleDeath(vehicleid, killerid)
{
    new S3MP4K[10000];
    VehicleStatus{vehicleid} = 1;
	arr_Engine{vehicleid} = 0;
	foreach(Player, i)
	{
		for(new vt = 0; vt < MAX_OBJECTS_PER_PLAYER; vt++)
		{
		    for(new v; v < MAX_PLAYERVEHICLES; v++)
			{
		        if(PlayerVehicleInfo[i][v][pvId] == vehicleid)
		        {
					if(PlayerVehicleInfo[i][v][pvInsurances] > 0)
					{
					    format(S3MP4K, sizeof(S3MP4K), "VEHICLEINFO: Your %s has been destroyed and will be respawned at Insurance Agency with '/claiminsurance'", GetVehicleName(vehicleid));
						SendClientMessageEx(i, COLOR_WHITE, S3MP4K);
					    DestroyDynamicObject(PlayerVehicleInfo[i][v][pvToy][vt]);
			      		DestroyDynamicObject(PlayerVehicleInfo[i][v][pvNeonObj]);
						DestroyDynamicObject(PlayerVehicleInfo[i][v][pvNeonObj2]);
						DestroyDynamicObject(PlayerVehicleInfo[i][v][pvNeonObj3]);
						DestroyDynamicObject(PlayerVehicleInfo[i][v][pvNeonObj4]);
						PlayerVehicleInfo[i][v][pvDestroyed] = 1;
						PlayerVehicleInfo[i][v][pvId] = INVALID_PLAYER_VEHICLE_ID;
						SetVehiclePos(vehicleid, 0, 0, 0); // Attempted desync fix
						LinkVehicleToInterior(vehicleid, 99);
						SetVehicleVirtualWorld(vehicleid, 99);
						DestroyVehicle(vehicleid);
						PlayerCars--;
					}
					else
					{
						SendClientMessageEx(i, COLOR_WHITE,"VEHICLEINFO: Your vehicle has been destroyed and not available to respawn on Insurance Agency");
			 			DestroyPlayerVehicle(i, v);
				  	}
				}
		  	}
		}
	}
	return 1;
}
//ANTI AIMBOT ARWIN14
Float:DistanceCameraTargetToLocation(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ)
{
        new Float:TGTDistance;

        TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

        new Float:tmpX, Float:tmpY, Float:tmpZ;

        tmpX = FrX * TGTDistance + CamX;
        tmpY = FrY * TGTDistance + CamY;
        tmpZ = FrZ * TGTDistance + CamZ;

        return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y)
{

  new Float:DX, Float:DY;
  new Float:angle;

  DX = floatabs(floatsub(x2,X));
  DY = floatabs(floatsub(y2,Y));

  if (DY == 0.0 || DX == 0.0)
  {
    if(DY == 0 && DX > 0) angle = 0.0;
    else if(DY == 0 && DX < 0) angle = 180.0;
    else if(DY > 0 && DX == 0) angle = 90.0;
    else if(DY < 0 && DX == 0) angle = 270.0;
    else if(DY == 0 && DX == 0) angle = 0.0;
  }
  else
  {
    angle = atan(DX/DY);

    if(X > x2 && Y <= y2) angle += 90.0;
    else if(X <= x2 && Y < y2) angle = floatsub(90.0, angle);
    else if(X < x2 && Y >= y2) angle -= 90.0;
    else if(X >= x2 && Y > y2) angle = floatsub(270.0, angle);
  }
  return floatadd(angle, 90.0);
}

GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance)
{
        x += (distance * floatsin(-angle, degrees));
        y += (distance * floatcos(-angle, degrees));
}

IsPlayerAimingAt(playerid, Float:x, Float:y, Float:z, Float:radius)
{
        new Float:camera_x,Float:camera_y,Float:camera_z,Float:vector_x,Float:vector_y,Float:vector_z;
        GetPlayerCameraPos(playerid, camera_x, camera_y, camera_z);
        GetPlayerCameraFrontVector(playerid, vector_x, vector_y, vector_z);

        new Float:vertical, Float:horizontal;

        switch (GetPlayerWeapon(playerid))
        {
                        case 34,35,36: {
                        if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
                        return false;
                        }
                        case 30,31: {vertical = 4.0; horizontal = -1.6;}
                        case 33: {vertical = 2.7; horizontal = -1.0;}
                        default: {vertical = 6.0; horizontal = -2.2;}
        }

        new Float:angle = GetPointAngleToPoint(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
        new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);
        GetXYInFrontOfPoint(resize_x, resize_y, GetPointAngleToPoint(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));

        if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
        return false;
}

bool:IsPlayerAimingAtPlayer(playerid, target)
{
        new Float:x, Float:y, Float:z;
        GetPlayerPos(target, x, y, z);
        if (IsPlayerAimingAt(playerid, x, y, z-0.75, 0.25)) return true;
        if (IsPlayerAimingAt(playerid, x, y, z-0.25, 0.25)) return true;
        if (IsPlayerAimingAt(playerid, x, y, z+0.25, 0.25)) return true;
        if (IsPlayerAimingAt(playerid, x, y, z+0.75, 0.25)) return true;
        return false;
}


public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
        switch(weaponid){ case 0..18, 39..54: return 1;}//invalid weapons

        if(hittype == BULLET_HIT_TYPE_PLAYER && IsPlayerConnected(hitid) && !IsPlayerNPC(hitid))
        {
                new Float:Shot[3], Float:Hit[3];
                GetPlayerLastShotVectors(playerid, Shot[0], Shot[1], Shot[2], Hit[0], Hit[1], Hit[2]);

                new playersurf = GetPlayerSurfingVehicleID(playerid);
                new hitsurf = GetPlayerSurfingVehicleID(hitid);
                new Float:targetpackets = NetStats_PacketLossPercent(hitid);
                new Float:playerpackets = NetStats_PacketLossPercent(playerid);

                if(~(playersurf) && ~(hitsurf) && !IsPlayerInAnyVehicle(playerid) && !IsPlayerInAnyVehicle(hitid))
                {
                        if(!IsPlayerAimingAtPlayer(playerid, hitid) && !IsPlayerInRangeOfPoint(hitid, 5.0, Hit[0], Hit[1], Hit[2]))
                        {
                                new String[10000], issuer[24];
                                GetPlayerName(playerid, issuer, 24);
                                AimbotWarnings[playerid] ++;

                                format(String, sizeof(String), "{FFFFFF}Player %s warning of aimbot or lag [Target PL: %f | Shooter PL:%f]!", issuer, targetpackets, playerpackets);

                                for(new p; p < MAX_PLAYERS;p++)
                                    if(IsPlayerConnected(p) && IsPlayerAdmin(p))
                                         SendClientMessage(p, -1, String);

                                if(AimbotWarnings[playerid] > 10)
                                {
                                        if(targetpackets < 1.2 && playerpackets < 1.2) return Kick(playerid);
                                        else
                                        {
                                                format(String, sizeof(String), "{FFFFFF}Player %s is probably using aimbot [Target PL: %f | Shooter PL:%f]!", issuer, targetpackets, playerpackets);
                                                for(new p; p < MAX_PLAYERS;p++) if(IsPlayerConnected(p) && IsPlayerAdmin(p)) SendClientMessage(p, -1, String);
                                        }
                                }
                                return 0;
                        }
                        else return 1;
                }
                else return 1;
        }
        return 1;
}

public OnPlayerSpawn(playerid)
{
	/*/NPC Bus
	if(IsPlayerNPC(playerid))
    {
    	new npcname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, npcname, sizeof(npcname));
        if(!strcmp(npcname, "Bedjo", true))
        {
            SetPlayerColor(playerid, 0xFFFFFF00);
			PutPlayerInVehicle(playerid, NPCBedjo, 0);
        	SetPlayerSkin(playerid, 253);
        	ResetPlayerWeapons(playerid);
        	BusText = CreateDynamic3DTextLabel("[NPC]Bedjo_Wijoyo", COLOR_WHITE, 0, 0, -20, 25, playerid);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BusText , E_STREAMER_ATTACH_OFFSET_Z, 0.25);
        }
        if(!strcmp(npcname, "Sanusi", true))
        {
            SetPlayerColor(playerid, 0xFFFFFF00);
			PutPlayerInVehicle(playerid, NPCSanusi, 0);
        	SetPlayerSkin(playerid, 7);
        	ResetPlayerWeapons(playerid);
        	BusText1 = CreateDynamic3DTextLabel("[NPC]Sanusi_Wicaksono", COLOR_WHITE, 0, 0, -20, 25, playerid);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BusText1 , E_STREAMER_ATTACH_OFFSET_Z, 0.25);
        }
        return 1;
    }*/
    if(!gPlayerLogged{playerid})
    {
        SendClientMessageEx(playerid, COLOR_WHITE, "ERROR: You are not logged in!");
        Kick(playerid);
        return 1;
	}
	//hunger system
	PlayerTextDrawShow(playerid, HBEName[playerid]);
 	ShowProgressBarForPlayer(playerid, phealth[playerid]);
	ShowProgressBarForPlayer(playerid, parmor[playerid]);
	ShowProgressBarForPlayer(playerid, hungry[playerid]);
	ShowProgressBarForPlayer(playerid, tired[playerid]);
	ShowProgressBarForPlayer(playerid, clean[playerid]);
//	SetProgressBarColor(hungry[playerid], 0x00FF0033);
//	SetProgressBarColor(tired[playerid], 0x00FF0033);
//	SetProgressBarColor(clean[playerid], 0x00FF0033);
	TextDrawShowForPlayer(playerid, BSText[0]);
	TextDrawShowForPlayer(playerid, BSText[1]);
	TextDrawShowForPlayer(playerid, BSText[2]);
	TextDrawShowForPlayer(playerid, BSText[3]);
	TextDrawShowForPlayer(playerid, BSText[4]);
	TextDrawShowForPlayer(playerid, BSText[5]);
	TextDrawShowForPlayer(playerid, BSText[6]);
	TextDrawShowForPlayer(playerid, BSText[7]);
	FirstSpawn[playerid]+=1;
	if(FirstSpawn[playerid] == 1)
	{
		PBHTimer[playerid] = SetTimerEx("ProgressBarHunger", 200000, true, "i", playerid);
		SetPVarInt(playerid, "HungerBar", 1);
		SetPVarInt(playerid, "hTimerOn", 0);

		PBBTimer[playerid] = SetTimerEx("ProgressBarEnergy", 210000, true, "i", playerid);
		SetPVarInt(playerid, "EnergyBar", 1);
		SetPVarInt(playerid, "eTimerOn", 0);

		PBETimer[playerid] = SetTimerEx("ProgressBarBladder", 250000, true, "i", playerid);
		SetPVarInt(playerid, "BladderBar", 1);
		SetPVarInt(playerid, "bTimerOn", 0);

		PBCTimer[playerid] = SetTimerEx("ProgressBarCondition", 200000, true, "i", playerid);
		SetPVarInt(playerid, "ConditionBar", 1);
		SetPVarInt(playerid, "cTimerOn", 0);
	}
//	PlayerTextDrawHide(playerid, HBEO[playerid]);
 	PlayerTextDrawSetPreviewModel(playerid, HBEO[playerid], GetPlayerSkin(playerid));
 	PlayerTextDrawShow(playerid, HBEO[playerid]);
	Streamer_Update(playerid);
	//Lumberjack Job
	if(PlayerInfo[playerid][pLumber] == 5)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid,-1060.3816,-1195.4048,129.5461,5.0);
		SendClientMessage(playerid,COLOR_GREEN,"Antarkan Kayu yang sudah kamu tebang ke checkpoint");
	}
	if(GetPVarInt(playerid, "NGPassenger") == 1)
	{
	    new Float:X, Float:Y, Float:Z;
	    GetVehiclePos(GetPVarInt(playerid, "NGPassengerVeh"), X, Y, Z);
	    AC_BS_SetPlayerPos(playerid, (X-2.557), (Y-3.049), Z);
	    SetPlayerWeaponsEx(playerid);
        givePlayerValidWeapon(playerid, 46, AMMO_MELEE);
        SetPlayerSkin(playerid, GetPVarInt(playerid, "NGPassengerSkin"));
        AC_BS_SetPlayerHealth(playerid, GetPVarFloat(playerid, "NGPassengerHP"));
        PlayerInfo[playerid][pHealth] = GetPVarFloat(playerid, "NGPassengerHP");
        AC_BS_SetPlayerArmour(playerid, GetPVarFloat(playerid, "NGPassengerArmor"));
		PlayerInfo[playerid][pArmor] = GetPVarFloat(playerid, "NGPassengerArmor");
		DeletePVar(playerid, "NGPassenger");
	    DeletePVar(playerid, "NGPassengerVeh");
		DeletePVar(playerid, "NGPassengerArmor");
		DeletePVar(playerid, "NGPassengerHP");
		DeletePVar(playerid, "NGPassengerSkin");
	    return 1;
	}
	if(InsideShamal[playerid] != INVALID_VEHICLE_ID)
	{
		AC_BS_SetPlayerPos(playerid, GetPVarFloat(playerid, "air_Xpos"), GetPVarFloat(playerid, "air_Ypos"), GetPVarFloat(playerid, "air_Zpos"));
		SetPlayerFacingAngle(playerid, GetPVarFloat(playerid, "air_Rpos"));
		AC_BS_SetPlayerHealth(playerid, GetPVarFloat(playerid, "air_HP"));
		PlayerInfo[playerid][pHealth] = GetPVarFloat(playerid, "air_HP");
		AC_BS_SetPlayerArmour(playerid, GetPVarFloat(playerid, "air_Arm"));
		PlayerInfo[playerid][pArmor] = GetPVarFloat(playerid, "air_Arm");
		SetPlayerWeaponsEx(playerid);
		SetPlayerToTeamColor(playerid);
		SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);

		DeletePVar(playerid, "air_Xpos");
		DeletePVar(playerid, "air_Ypos");
		DeletePVar(playerid, "air_Zpos");
		DeletePVar(playerid, "air_Rpos");
		DeletePVar(playerid, "air_HP");
		DeletePVar(playerid, "air_Arm");

		SetCameraBehindPlayer(playerid);
		AC_BS_SetPlayerVirtualWorld(playerid, InsideShamal[playerid]);
		return AC_BS_SetPlayerInterior(playerid, 1);
	}
	SyncPlayerTime(playerid);
	SetPVarInt(playerid, "AdminProtect", 0);
    //if(IsPlayerNPC(playerid)) return 1;
	STDPlayer[playerid] = 0;
	gTeam[playerid] = PlayerInfo[playerid][pTeam];

	if(!gPlayerLogged{playerid}) return Kick(playerid);
	SetPlayerSpawn(playerid);
	SetPlayerWeapons(playerid);
	SetPlayerToTeamColor(playerid);

	CheckPH(playerid);
    TogglePlayerControllable(playerid, 1);
    PlayerTextDrawHide(playerid, HBEO[playerid]);
 	PlayerTextDrawSetPreviewModel(playerid, HBEO[playerid], GetPlayerSkin(playerid));
 	PlayerTextDrawShow(playerid, HBEO[playerid]);
	return 1;
}

stock RegisterVehicleNumberPlate(vehicleid, sz_NumPlate[]) {
	new
	    Float: a_CarPos[4], Float:fuel; // X, Y, Z, Z Angle, Fuel

	GetVehiclePos(vehicleid, a_CarPos[0], a_CarPos[1], a_CarPos[2]);
	GetVehicleZAngle(vehicleid, a_CarPos[3]);
	fuel = VehicleFuel[vehicleid];
	SetVehicleNumberPlate(vehicleid, sz_NumPlate);
	SetVehicleToRespawn(vehicleid);
	SetVehiclePos(vehicleid, a_CarPos[0], a_CarPos[1], a_CarPos[2]);
	SetVehicleZAngle(vehicleid, a_CarPos[3]);
	VehicleFuel[vehicleid] = fuel;
	return 1;
}

//vGPS STOCK
stock Float:PointAngle(playerid, Float:xa, Float:ya, Float:xb, Float:yb)
{
	new Float:carangle;
	new Float:xc, Float:yc;
	new Float:angle;
	xc = floatabs(floatsub(xa,xb));
	yc = floatabs(floatsub(ya,yb));
	if (yc == 0.0 || xc == 0.0)
	{
		if(yc == 0 && xc > 0) angle = 0.0;
		else if(yc == 0 && xc < 0) angle = 180.0;
		else if(yc > 0 && xc == 0) angle = 90.0;
		else if(yc < 0 && xc == 0) angle = 270.0;
		else if(yc == 0 && xc == 0) angle = 0.0;
	}
	else
	{
		angle = atan(xc/yc);
		if(xb > xa && yb <= ya) angle += 90.0;
		else if(xb <= xa && yb < ya) angle = floatsub(90.0, angle);
		else if(xb < xa && yb >= ya) angle -= 90.0;
		else if(xb >= xa && yb > ya) angle = floatsub(270.0, angle);
	}
	GetVehicleZAngle(GetPlayerVehicleID(playerid), carangle);
	return floatadd(angle, -carangle);
}

stock gpsfcreate(filename[])
{
    if (fexist(filename)){return false;}
    new File:fhandle = fopen(filename,io_write);
    fclose(fhandle);
    return true;
}

stock Float:GetDistanceBetweenPoints(Float:X, Float:Y, Float:Z, Float:PointX, Float:PointY, Float:PointZ)
{
	new Float:Distance;Distance = floatabs(floatsub(X, PointX)) + floatabs(floatsub(Y, PointY)) + floatabs(floatsub(Z, PointZ));
	return Distance;
}

stock split(const strsrc[], strdest[][], delimiter)
{
    new i, li;
    new aNum;
    new len;
    while(i <= strlen(strsrc))
    {
        if(strsrc[i] == delimiter || i == strlen(strsrc))
        {
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0;
            li = i+1;
            aNum++;
        }
        i++;
    }
    return 1;
}

//=======End of vGPS Stock======

Log(sz_fileName[], sz_input[]) {

	new
		sz_logEntry[156],
		i_dateTime[2][3],
		File: fileHandle = fopen(sz_fileName, io_append);

	gettime(i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2]);
	getdate(i_dateTime[1][0], i_dateTime[1][1], i_dateTime[1][2]);

	format(sz_logEntry, sizeof(sz_logEntry), "[%i/%i/%i - %i:%i:%i] %s\r\n", i_dateTime[1][0], i_dateTime[1][1], i_dateTime[1][2], i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2], sz_input);
	fwrite(fileHandle, sz_logEntry);
	return fclose(fileHandle);
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
    if(FishHolding[playerid] > 0)
	{
	    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 456 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 455 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 499)
	    {
			if(FishHolding[playerid] == 3) // pusat to OD
			{
				    SedangTrucking[playerid] = 0;
				    PlayerInfo[playerid][pMissionsTime] = 300;
			    	PlayerInfo[playerid][pPayCheck] += 5000;
			        SendClientMessageEx(playerid,COLOR_ARWIN,"TRUCKING: {ffffff}Kamu berhasil mengirimkan ikan ke Ocean Docks.");
			        SendClientMessageEx(playerid,COLOR_ARWIN,"TRUCKING: {ffffff}$50.00 telah dimasukkan kedalam PayCheck-mu.");
			        FishHolding[playerid] = 0;
			        DisablePlayerRaceCheckpoint(playerid);
			        PlayerInfo[playerid][pTruckingSkill] += 1;
			        return 1;
			}
			else if(FishHolding[playerid] == 5) // mats, comp, bait
			{
			        SedangTrucking[playerid] = 0;
				    PlayerInfo[playerid][pMissionsTime] = 300;
			    	PlayerInfo[playerid][pPayCheck] += 5000;
			    	SendClientMessageEx(playerid,COLOR_ARWIN,"TRUCKING: {ffffff}Kamu berhasil mengirimkan component ke Component Storage.");
			        SendClientMessageEx(playerid,COLOR_ARWIN,"TRUCKING: {ffffff}$50.00 telah dimasukkan kedalam PayCheck-mu.");
			        FishHolding[playerid] = 0;
			        DisablePlayerRaceCheckpoint(playerid);
			        PlayerInfo[playerid][pTruckingSkill] += 1;
			        stockcomp += 500;
			        return 1;
			}
			else if(FishHolding[playerid] == 6) // tanaman
			{
			        SedangTrucking[playerid] = 0;
				    PlayerInfo[playerid][pMissionsTime] = 300;
			    	PlayerInfo[playerid][pPayCheck] += 5000;
			    	SendClientMessageEx(playerid,COLOR_ARWIN,"TRUCKING: {ffffff}Kamu berhasil mengirimkan Tanaman ke gudang Ocean Dock.");
			        SendClientMessageEx(playerid,COLOR_ARWIN,"TRUCKING: {ffffff}$50.00 telah dimasukkan kedalam PayCheck-mu.");
			        FishHolding[playerid] = 0;
			        DisablePlayerRaceCheckpoint(playerid);
			        PlayerInfo[playerid][pTruckingSkill] += 1;
					return 1;
			}
			else if(FishHolding[playerid] == 7) // kayu
			{
			        SedangTrucking[playerid] = 0;
				    PlayerInfo[playerid][pMissionsTime] = 300;
			    	PlayerInfo[playerid][pPayCheck] += 5000;
			    	SendClientMessageEx(playerid,COLOR_ARWIN,"TRUCKING: {ffffff}Kamu berhasil mengirimkan Kayu ke gudang Ocean Dock.");
			        SendClientMessageEx(playerid,COLOR_ARWIN,"TRUCKING: {ffffff}$50.00 telah dimasukkan kedalam PayCheck-mu.");
			        FishHolding[playerid] = 0;
			        DisablePlayerRaceCheckpoint(playerid);
			        PlayerInfo[playerid][pTruckingSkill] += 1;
					return 1;
			}
			else if(FishHolding[playerid] == 14) // Equipment
			{
			        SedangTrucking[playerid] = 0;
			        SendClientMessageEx(playerid,COLOR_WHITE,"200 kotak Ammunisi berhasil tiba dengan selamat.");
			        FishHolding[playerid] = 0;
			        EquipmentStock += 200;
			        new equipmentt1[1024], equipmentt2[1024], equipmentt3[1024], String[1024];
					format(equipmentt1, sizeof(equipmentt1), "'/sags'\nTo open your locker\nEquipment Stock: %d", EquipmentStock);
					UpdateDynamic3DTextLabelText(equipment1, COLOR_WHITE, String);
					format(equipmentt2, sizeof(equipmentt2), "'/sapd'\nTo open your locker\nEquipment Stock: %d", EquipmentStock);
					UpdateDynamic3DTextLabelText(equipment2, COLOR_WHITE, String);
					format(equipmentt3, sizeof(equipmentt3), "'/samd'\nTo open your locker\n'/takemedicine'\nto take medicine\nEquipment Stock: %d", EquipmentStock);
					UpdateDynamic3DTextLabelText(equipment3, COLOR_WHITE, String);
			        DisablePlayerRaceCheckpoint(playerid);
			        PlayerInfo[playerid][pEnergi] -= 2;
					PlayerInfo[playerid][pHunger] -= 2;
					return 1;
			}
		}
		return 1;
	}
    if(SedangHauling[playerid] > 0)
	{
 		if(SedangHauling[playerid] == 1)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order");
  			SedangHauling[playerid] = 2;
     		SetPlayerRaceCheckpoint(playerid, 1, -2471.2942, 783.0248, 35.1719, -2471.2942, 783.0248, 35.1719, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 2)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
                PlayerInfo[playerid][pPayCheck] += 35000;
                PlayerInfo[playerid][pHaulingTime] += 30*60;
                DialogHauling[0] = false;
                DialogSaya[playerid][0] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "TRUCKING: {FFFFFF}$350.00 have been issued to your paycheck");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 3)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order");
  			SedangHauling[playerid] = 4;
     		SetPlayerRaceCheckpoint(playerid, 1, -576.2687, 2569.0842, 53.5156, 576.2687, 2569.0842, 53.5156, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 4)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
                PlayerInfo[playerid][pPayCheck] += 30000;
                PlayerInfo[playerid][pHaulingTime] += 30*60;
                DialogHauling[1] = false;
                DialogSaya[playerid][1] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "TRUCKING: {FFFFFF}$300.00 have been issued to your paycheck");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 5)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order");
  			SedangHauling[playerid] = 6;
     		SetPlayerRaceCheckpoint(playerid, 1, 1424.8624, 2333.4939, 10.8203, 1424.8624, 2333.4939, 10.8203, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 6)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
                PlayerInfo[playerid][pPayCheck] += 25000;
                PlayerInfo[playerid][pHaulingTime] += 30*60;
                DialogHauling[2] = false;
                DialogSaya[playerid][2] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "TRUCKING: {FFFFFF}$250.00 have been issued to your paycheck");
                return 1;
			}
		}
		if(SedangHauling[playerid] == 7)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order");
  			SedangHauling[playerid] = 8;
     		SetPlayerRaceCheckpoint(playerid, 1, 1198.7153, 165.4331, 20.5056, 1198.7153, 165.4331, 20.5056, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 8)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
                PlayerInfo[playerid][pPayCheck] += 27000;
                PlayerInfo[playerid][pHaulingTime] += 30*60;
                DialogHauling[3] = false;
                DialogSaya[playerid][3] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "TRUCKING: {FFFFFF}$270.00 have been issued to your paycheck");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 9)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order");
  			SedangHauling[playerid] = 10;
     		SetPlayerRaceCheckpoint(playerid, 1, 1201.5385, 171.6184, 20.5035, 1201.5385, 171.6184, 20.5035, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 10)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
                PlayerInfo[playerid][pPayCheck] += 39900;
                PlayerInfo[playerid][pHaulingTime] += 30*60;
                DialogHauling[4] = false;
                DialogSaya[playerid][4] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "TRUCKING: {FFFFFF}$399.00 have been issued to your paycheck");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 11)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order");
  			SedangHauling[playerid] = 12;
     		SetPlayerRaceCheckpoint(playerid, 1, 2786.8313, -2417.9558, 13.6339, 2786.8313, -2417.9558, 13.6339, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 12)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
                PlayerInfo[playerid][pPayCheck] += 20000;
                PlayerInfo[playerid][pHaulingTime] += 30*60;
                DialogHauling[5] = false;
                DialogSaya[playerid][5] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "TRUCKING: {FFFFFF}$200.00 have been issued to your paycheck");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 13)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order");
  			SedangHauling[playerid] = 14;
     		SetPlayerRaceCheckpoint(playerid, 1, 1613.7815, 2236.2046, 10.3787, 1613.7815, 2236.2046, 10.3787, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 14)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
                PlayerInfo[playerid][pPayCheck] += 31000;
                PlayerInfo[playerid][pHaulingTime] += 30*60;
                DialogHauling[6] = false;
                DialogSaya[playerid][6] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "TRUCKING: {FFFFFF}$310.00 have been issued to your paycheck");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 15)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order");
  			SedangHauling[playerid] = 16;
     		SetPlayerRaceCheckpoint(playerid, 1, 2415.7803, -2470.1309, 13.6300, 2415.7803, -2470.1309, 13.6300, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 16)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
                PlayerInfo[playerid][pPayCheck] += 33300;
                PlayerInfo[playerid][pHaulingTime] += 30*60;
                DialogHauling[7] = false;
                DialogSaya[playerid][7] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "TRUCKING: {FFFFFF}$333.00 have been issued to your paycheck");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 17)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order");
  			SedangHauling[playerid] = 18;
     		SetPlayerRaceCheckpoint(playerid, 1, -980.1684, -713.3505, 32.0078, -980.1684, -713.3505, 32.0078, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 18)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
                PlayerInfo[playerid][pPayCheck] += 29000;
                PlayerInfo[playerid][pHaulingTime] += 30*60;
                DialogHauling[8] = false;
                DialogSaya[playerid][8] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "TRUCKING: {FFFFFF}$290.00 have been issued to your paycheck");
                return 1;
			}
		}
		else if(SedangHauling[playerid] == 19)
	    {
     		DisablePlayerRaceCheckpoint(playerid);
     		SendClientMessage(playerid, COLOR_ARWIN,"TRUCKING: {FFFFFF}Attach the trailer to your vehicle to order");
  			SedangHauling[playerid] = 20;
     		SetPlayerRaceCheckpoint(playerid, 1, -2226.1292, -2315.1055, 30.6045, -2226.1292, -2315.1055, 30.6045, 10.0);
       		return 1;
		}
		else if(SedangHauling[playerid] == 20)
		{
			if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
			{
			    DisablePlayerRaceCheckpoint(playerid);
                SedangHauling[playerid] = 0;
                PlayerInfo[playerid][pPayCheck] += 22500;
                PlayerInfo[playerid][pHaulingTime] += 30*60;
                DialogHauling[9] = false;
                DialogSaya[playerid][9] = false;
                DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
                SendClientMessage(playerid, COLOR_ARWIN, "TRUCKING: {FFFFFF}$225.00 have been issued to your paycheck");
                return 1;
			}
		}
		return 1;
	}
	new Float:Health;
    if(CPD[playerid] == 1)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			CPD[playerid] = 2;
			SetPlayerRaceCheckpoint(playerid, 0, 1972.9482, -1929.8557, 12.5739,1948.1033,-1930.6860,13.4751,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 2)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			CPD[playerid] = 3;
			SetPlayerRaceCheckpoint(playerid, 0, 1948.1033,-1930.6860,13.4751,1906.9967, -1930.0426, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 3)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 4;
			SetPlayerRaceCheckpoint(playerid, 0, 1906.9967, -1930.0426, 12.5739,1834.1765, -1929.9357, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 4)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health >= 950)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 5;
			SetPlayerRaceCheckpoint(playerid, 0, 1834.1765, -1929.9357, 12.5739,1823.9728, -1921.6290, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 5)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 6;
			SetPlayerRaceCheckpoint(playerid, 0, 1823.9728, -1921.6290, 12.5739,1823.7241, -1844.5658, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 6)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 7;
			SetPlayerRaceCheckpoint(playerid, 0, 1823.7241, -1844.5658, 12.5739,1809.9785, -1829.8235, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 7)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 9;
			SetPlayerRaceCheckpoint(playerid, 0, 1809.9785, -1829.8235, 12.5739,1766.6809, -1822.9556, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 9)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 10;
			SetPlayerRaceCheckpoint(playerid, 0, 1766.6809, -1822.9556, 12.5739,1700.6266, -1809.6973, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 10)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 11;
			SetPlayerRaceCheckpoint(playerid, 0, 1700.6266, -1809.6973, 12.5739,1691.8811, -1801.5286, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 11)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 12;
			SetPlayerRaceCheckpoint(playerid, 0, 1691.8811, -1801.5286, 12.5739,1691.7961, -1745.4752, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 12)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 13;
			SetPlayerRaceCheckpoint(playerid, 0, 1691.7961, -1745.4752, 12.5739,1691.8342, -1679.3737, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 13)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 15;
			SetPlayerRaceCheckpoint(playerid, 0, 1691.8342, -1679.3737, 12.5739,1691.7463, -1603.1737, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 15)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 16;
			SetPlayerRaceCheckpoint(playerid, 0, 1691.7463, -1603.1737, 12.5739,1699.5380, -1594.7327, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 16)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 17;
			SetPlayerRaceCheckpoint(playerid, 0, 1699.5380, -1594.7327, 12.5739,1738.8302, -1600.2924, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 17)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 18;
			SetPlayerRaceCheckpoint(playerid, 0, 1738.8302, -1600.2924, 12.5739,1809.6837, -1614.3446, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 18)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 19;
			SetPlayerRaceCheckpoint(playerid, 0, 1809.6837, -1614.3446, 12.5739,1929.3334, -1615.0773, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 19)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 20;
			SetPlayerRaceCheckpoint(playerid, 0, 1929.3334, -1615.0773, 12.5739,1939.0790, -1622.0118, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 20)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 21;
			SetPlayerRaceCheckpoint(playerid, 0, 1939.0790, -1622.0118, 12.5739,1939.3633, -1738.4812, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 21)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 22;
			SetPlayerRaceCheckpoint(playerid, 0, 1939.3633, -1738.4812, 12.5739,1952.4625, -1754.5654, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 22)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 23;
			SetPlayerRaceCheckpoint(playerid, 0, 1952.4625, -1754.5654, 12.5739,1988.9359, -1754.5220, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 23)
 	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 24;
			SetPlayerRaceCheckpoint(playerid, 0, 1988.9359, -1754.5220, 12.5739,2079.5874, -1754.7408, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 24)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 25;
			SetPlayerRaceCheckpoint(playerid, 0, 2079.5874, -1754.7408, 12.5739,2087.1904, -1762.3777, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 25)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 26;
			SetPlayerRaceCheckpoint(playerid, 0, 2087.1904, -1762.3777, 12.5739,2079.6643, -1797.5828, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 26)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 27;
			SetPlayerRaceCheckpoint(playerid, 0, 2079.6643, -1797.5828, 12.5739,2079.6372, -1886.3774, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 27)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 28;
			SetPlayerRaceCheckpoint(playerid, 0, 2079.6372, -1886.3774, 12.5739,2073.5535, -1909.7695, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 28)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 29;
			SetPlayerRaceCheckpoint(playerid, 0, 2073.5535, -1909.7695, 12.5739,2073.5535, -1909.7695, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 29)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 30;
			SetPlayerRaceCheckpoint(playerid, 0, 2073.5535, -1909.7695, 12.5739,2066.9595, -1914.0358, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 30)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 31;
			SetPlayerRaceCheckpoint(playerid, 0, 2066.9595, -1914.0358, 12.5739,2065.4746, -1919.7954, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 31)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
		    DisablePlayerRaceCheckpoint(playerid);
		    CPD[playerid] = 32;
			SetPlayerRaceCheckpoint(playerid, 1, 2065.4746, -1919.7954, 12.5739,2065.4746, -1919.7954, 12.5739,5);
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	else if(CPD[playerid] == 32)
	{
		GetVehicleHealth(GetPlayerVehicleID(playerid), Health);
		if(Health > 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			PlayerInfo[playerid][pCarLic] = 1;
			PlayerInfo[playerid][pCTime] = 604800;
			PlayerInfo[playerid][pCarLicID] = 1;
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have successfully passed the test and received your license.");
		}
		if(Health < 900)
		{
			DisablePlayerRaceCheckpoint(playerid);
			LicenseTest[playerid] = 0;
			CPD[playerid] = 0;
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
		}
		return 1;
	}
	for(new i; i <= 3; i++) // 3 = Total Dialog , Jadi kita mau tau kalau Player Ini Apakah Ambil Dialog dari 3 tersebut apa ga !
	{
		if(BusSteps[playerid][i] > 0)
		{
		    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 431)
		    {
			 	if(IsPlayerInAnyVehicle(playerid))
				{
				    if(BusSteps[playerid][0] == 2)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 15);
				        BusSteps[playerid][0] = 3;
				        SetPlayerRaceCheckpoint(playerid, 0, 1655.8779,-1580.8289,13.4839, 1325.0560,-1569.7898,13.4628, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 3)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 20);
				        BusSteps[playerid][0] = 4;
				        SetPlayerRaceCheckpoint(playerid, 0, 1325.0560,-1569.7898,13.4628,1359.4424,-1422.9174,13.4767, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 4)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 5;
				        SetPlayerRaceCheckpoint(playerid, 0, 1359.4424,-1422.9174,13.4767,1338.3066,-1394.7805,13.4779, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 5)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 70);
				        BusSteps[playerid][0] = 6;
				        SetPlayerRaceCheckpoint(playerid, 0, 1338.3066,-1394.7805,13.4779,651.5914,-1393.6437,13.5422, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 6)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 5);
				        BusSteps[playerid][0] = 7;
				        SetPlayerRaceCheckpoint(playerid, 0, 651.5914,-1393.6437,13.5422,539.4284,-1405.4429,15.7669, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 7)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 300);
				        BusSteps[playerid][0] = 8;
				        SetPlayerRaceCheckpoint(playerid, 0, 539.4284,-1405.4429,15.7669,492.0627,-1309.9187,15.7158, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 8)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 129);
				        BusSteps[playerid][0] = 9;
				        SetPlayerRaceCheckpoint(playerid, 0, 492.0627,-1309.9187,15.7158,153.1991,-1545.3175,10.5614, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 9)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 90);
				        BusSteps[playerid][0] = 10;
				        SetPlayerRaceCheckpoint(playerid, 0, 153.1991,-1545.3175,10.5614,373.0657,-1720.0210,7.2636, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 10)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 250);
				        BusSteps[playerid][0] = 11;
				        SetPlayerRaceCheckpoint(playerid, 0, 373.0657,-1720.0210,7.2636,1001.7006,-1809.3325,14.1462, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 11)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 200);
				        BusSteps[playerid][0] = 12;
				        SetPlayerRaceCheckpoint(playerid, 0, 1001.7006,-1809.3325,14.1462, 1017.2707,-2218.5603,13.0459, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 12)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 20);
				        BusSteps[playerid][0] = 13;
				        SetPlayerRaceCheckpoint(playerid, 0, 1017.2707,-2218.5603,13.0459,1312.3700,-2467.7739,7.7606, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 14;
				        SetPlayerRaceCheckpoint(playerid, 0, 1312.3700,-2467.7739,7.7606,1443.5225,-2683.4890,13.4660, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 14)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 15;
				        SetPlayerRaceCheckpoint(playerid, 0, 1443.5225,-2683.4890,13.4660,2167.0093,-2614.6147,13.4766, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 15)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 16;
				        SetPlayerRaceCheckpoint(playerid, 1, 2167.0093,-2614.6147,13.4766,2297.5007,-2281.6836,13.4911, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 16)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 17;
				        SetPlayerRaceCheckpoint(playerid, 1, 2297.5007,-2281.6836,13.4911,2245.5674,-2207.3191,13.4066, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 17)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 18;
				        SetPlayerRaceCheckpoint(playerid, 1, 2245.5674,-2207.3191,13.4066,1978.5647,-2107.1409,13.4477, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 18)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 19;
				        SetPlayerRaceCheckpoint(playerid, 1, 1978.5647,-2107.1409,13.4477,1964.9993,-1764.2311,13.4818, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 19)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 20;
				        SetPlayerRaceCheckpoint(playerid, 1, 1964.9993,-1764.2311,13.4818,1835.2019,-1750.1224,13.4855, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 20)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 21;
				        SetPlayerRaceCheckpoint(playerid, 1, 1835.2019,-1750.1224,13.4855,1824.7201,-1625.2925,13.4876, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 21)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 22;
				        SetPlayerRaceCheckpoint(playerid, 1, 1824.7201,-1625.2925,13.4876,1668.9048,-1590.1837,13.4715, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 22)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 23;
				        SetPlayerRaceCheckpoint(playerid, 1, 1668.9048,-1590.1837,13.4715,1662.6278,-1552.6962,13.4833, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 23)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 24;
				        SetPlayerRaceCheckpoint(playerid, 1, 1662.6278,-1552.6962,13.4833,1686.7153,-1551.0281,13.4776, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 24)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][0] = 25;
				        SetPlayerRaceCheckpoint(playerid, 1, 1686.7153,-1551.0281,13.4776,1673.5162,-1477.9034,13.4807, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][0] == 25)
				    {
				        BusSteps[playerid][0] = 0;
				        DialogBus[0] = false; // Dialog 0 telah di pilih
			    		DialogSaya[playerid][0] = false;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}$100.00 telah dimasukkan ke JobSalary mu.");
						PlayerInfo[playerid][pPayCheck] += 10000;
				        PlayerInfo[playerid][pBusTime] = 1800;
				        DisablePlayerRaceCheckpoint(playerid);
				        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
			   		}
				    else if(BusSteps[playerid][1] == 6)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 5);
				        BusSteps[playerid][1] = 7;
				        SetPlayerRaceCheckpoint(playerid, 0, 1655.4309,-1578.8663,13.4876,1675.6584,-1594.5546,13.4830, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 7)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 300);
				        BusSteps[playerid][1] = 8;
				        SetPlayerRaceCheckpoint(playerid, 0, 1675.6584,-1594.5546,13.4830,1808.3151,-1614.4534,13.4606, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 8)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 129);
				        BusSteps[playerid][1] = 9;
				        SetPlayerRaceCheckpoint(playerid, 0, 1808.3151,-1614.4534,13.4606,1822.1866,-1602.4225,13.4650, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 9)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 90);
				        BusSteps[playerid][1] = 10;
				        SetPlayerRaceCheckpoint(playerid, 0, 1822.1866,-1602.4225,13.4650,1852.0515,-1477.0760,13.4892, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 10)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 250);
				        BusSteps[playerid][1] = 11;
				        SetPlayerRaceCheckpoint(playerid, 0, 1852.0515,-1477.0760,13.4892,1976.1843,-1468.7709,13.4898, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 11)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 200);
				        BusSteps[playerid][1] = 12;
				        SetPlayerRaceCheckpoint(playerid, 0, 1976.1843,-1468.7709,13.4898, 1988.9058,-1453.9619,13.4881, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 12)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 20);
				        BusSteps[playerid][1] = 13;
				        SetPlayerRaceCheckpoint(playerid, 0, 1988.9058,-1453.9619,13.4881,1989.5841,-1354.7592,23.8970, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 13)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 14;
				        SetPlayerRaceCheckpoint(playerid, 0, 1989.5841,-1354.7592,23.8970,2055.3843,-1343.6346,23.9209, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 14)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 15;
				        SetPlayerRaceCheckpoint(playerid, 0, 2055.3843,-1343.6346,23.9209,2073.3601,-1237.0232,23.9111, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 15)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 16;
				        SetPlayerRaceCheckpoint(playerid, 0, 2073.3601,-1237.0232,23.9111,2074.4985,-1106.5936,24.7291, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 16)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 17;
				        SetPlayerRaceCheckpoint(playerid, 0, 2074.4985,-1106.5936,24.7291,1995.6899,-1054.9963,24.5139, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 17)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 18;
				        SetPlayerRaceCheckpoint(playerid, 0, 1995.6899,-1054.9963,24.5139,1867.9518,-1058.5884,23.7857, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 18)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 19;
				        SetPlayerRaceCheckpoint(playerid, 0, 1867.9518,-1058.5884,23.7857,1863.6049,-1169.5271,23.7625, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 19)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 20;
				        SetPlayerRaceCheckpoint(playerid, 0, 1863.6049,-1169.5271,23.7625,1657.9583,-1157.8536,23.8513, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 20)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 21;
				        SetPlayerRaceCheckpoint(playerid, 0, 1657.9583,-1157.8536,23.8513,1592.6194,-1159.1958,24.0051, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 21)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 22;
				        SetPlayerRaceCheckpoint(playerid, 0, 1592.6194,-1159.1958,24.0051,1549.6796,-1055.4402,23.7095, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 22)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 23;
				        SetPlayerRaceCheckpoint(playerid, 0, 1549.6796,-1055.4402,23.7095,1458.6635,-1030.3673,23.7568, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 23)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 24;
				        SetPlayerRaceCheckpoint(playerid, 0, 1458.6635,-1030.3673,23.7568,1383.3145,-1032.3024,26.1900, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 24)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 25;
				        SetPlayerRaceCheckpoint(playerid, 0, 1383.3145,-1032.3024,26.1900,1355.6470,-1045.0482,26.4642, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 25)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 26;
				        SetPlayerRaceCheckpoint(playerid, 0, 1355.6470,-1045.0482,26.4642,1340.4150,-1127.6436,23.7744, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 26)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 27;
				        SetPlayerRaceCheckpoint(playerid, 0, 1340.4150,-1127.6436,23.7744,1340.1676,-1379.0829,13.5948, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 27)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 28;
				        SetPlayerRaceCheckpoint(playerid, 0, 1340.1676,-1379.0829,13.5948,1363.4252,-1405.9730,13.4503, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 28)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 29;
				        SetPlayerRaceCheckpoint(playerid, 0, 1363.4252,-1405.9730,13.4503,1393.6683,-1430.9860,13.5163, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 29)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 30;
				        SetPlayerRaceCheckpoint(playerid, 0, 1393.6683,-1430.9860,13.5163,1640.2510,-1443.0830,13.4826, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 30)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 31;
				        SetPlayerRaceCheckpoint(playerid, 0, 1640.2510,-1443.0830,13.4826,1654.4456,-1539.0234,13.4815, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 31)
				    {
				        DisablePlayerRaceCheckpoint(playerid);
				        GivePlayerCash(playerid, 100);
				        BusSteps[playerid][1] = 32;
				        SetPlayerRaceCheckpoint(playerid, 1, 1654.4456,-1539.0234,13.4815,1685.5889,-1550.3016,13.4852, 5);
				        return 1;
				    }
				    else if(BusSteps[playerid][1] == 32)
				    {
				        BusSteps[playerid][1] = 0;
				        DialogBus[1] = false; // Dialog 0 telah di pilih
			    		DialogSaya[playerid][1] = false;
						SendClientMessageEx(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}$100.00 telah dimasukkan ke JobSalary mu.");
						PlayerInfo[playerid][pPayCheck] += 10000;
				        PlayerInfo[playerid][pBusTime] = 1800;
				        DisablePlayerRaceCheckpoint(playerid);
				        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				        return 1;
			   		}
				}
			}
		}
	}
	for(new i; i <= 3; i++) // 3 = Total Dialog , Jadi kita mau tau kalau Player Ini Apakah Ambil Dialog dari 3 tersebut apa ga !
	{
		if(SweeperSteps[playerid][i] > 0)
		{
		 	if(IsPlayerInAnyVehicle(playerid))
			{
				if(SweeperSteps[playerid][0] == 1)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 144);
			        SweeperSteps[playerid][0] = 2;
			        SetPlayerRaceCheckpoint(playerid, 0, 1619.4293,-1881.6036,13.4845, 1816.1698,-1834.6884,13.4141, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][0] == 2)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 15);
			        SweeperSteps[playerid][0] = 3;
			        SetPlayerRaceCheckpoint(playerid, 0, 1816.1698,-1834.6884,13.4141, 1820.7505,-1929.6912,13.3750, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][0] == 3)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 20);
			        SweeperSteps[playerid][0] = 4;
			        SetPlayerRaceCheckpoint(playerid, 0, 1820.7505,-1929.6912,13.3750,1955.9108,-1934.7244,13.3828, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][0] == 4)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 100);
			        SweeperSteps[playerid][0] = 5;
			        SetPlayerRaceCheckpoint(playerid, 0, 1955.9108,-1934.7244,13.3828,1962.7469,-1759.2129,13.3828, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][0] == 5)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 70);
			        SweeperSteps[playerid][0] = 6;
			        SetPlayerRaceCheckpoint(playerid, 0, 1962.7469,-1759.2129,13.3828,1830.1188,-1750.1913,13.3828, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][0] == 6)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 5);
			        SweeperSteps[playerid][0] = 7;
			        SetPlayerRaceCheckpoint(playerid, 0, 1830.1188,-1750.1913,13.3828,1700.3102,-1729.7719,13.3828, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][0] == 7)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 300);
			        SweeperSteps[playerid][0] = 8;
			        SetPlayerRaceCheckpoint(playerid, 0, 1700.3102,-1729.7719,13.3828,1575.3949,-1729.9983,13.3828, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][0] == 8)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 129);
			        SweeperSteps[playerid][0] = 9;
			        SetPlayerRaceCheckpoint(playerid, 0, 1575.3949,-1729.9983,13.3828,1567.2383,-1862.6960,13.3828, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][0] == 9)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 90);
			        SweeperSteps[playerid][0] = 10;
			        SetPlayerRaceCheckpoint(playerid, 0, 1567.2383,-1862.6960,13.3828,1619.1874,-1877.3141,13.3828, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][0] == 10)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 250);
			        SweeperSteps[playerid][0] = 11;
			        SetPlayerRaceCheckpoint(playerid, 1, 1619.1874,-1877.3141,13.3828,1619.1874,-1877.3141,13.3828, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][0] == 11)
			    {
			        SweeperSteps[playerid][0] = 0;
			        DialogSweeper[0] = false; // Dialog 0 telah di pilih
		    		DialogSaya[playerid][0] = false;
			        SendClientMessageEx(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}$25.00 telah dimasukkan ke JobSalary mu.");
					PlayerInfo[playerid][pPayCheck] += 3500;
			        PlayerInfo[playerid][pSweeperT] = 1800;
			        DisablePlayerRaceCheckpoint(playerid);
			        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			        return 1;
		   		}
			    else if(SweeperSteps[playerid][1] == 1)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 200);
			        SweeperSteps[playerid][1] = 2;
			        SetPlayerRaceCheckpoint(playerid, 0, 1574.9003,-1871.1334,12.9483, 1572.1841,-1746.2827,12.9516, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][1] == 2)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 20);
			        SweeperSteps[playerid][1] = 3;
			        SetPlayerRaceCheckpoint(playerid, 0, 1572.1841,-1746.2827,12.9516,1533.9382,-1729.6626,12.9601, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][1] == 3)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 100);
			        SweeperSteps[playerid][1] = 4;
			        SetPlayerRaceCheckpoint(playerid, 0, 1533.9382,-1729.6626,12.9601,1532.7323,-1606.6068,12.9475, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][1] == 4)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 70);
			        SweeperSteps[playerid][1] = 5;
			        SetPlayerRaceCheckpoint(playerid, 0, 1532.7323,-1606.6068,12.9475,1443.0881,-1593.6465,12.9596, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][1] == 5)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 5);
			        SweeperSteps[playerid][1] = 6;
			        SetPlayerRaceCheckpoint(playerid, 0, 1443.0881,-1593.6465,12.9596,1456.4535,-1453.5516,12.9308, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][1] == 6)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 129);
			        SweeperSteps[playerid][1] = 7;
			        SetPlayerRaceCheckpoint(playerid, 0, 1456.4535,-1453.5516,12.9308,1424.1686,-1432.9954,12.9524, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][1] == 7)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 90);
			        SweeperSteps[playerid][1] = 8;
			        SetPlayerRaceCheckpoint(playerid, 0, 1424.1686,-1432.9954,12.9524,1369.5051,-1392.7247,13.0346, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][1] == 8)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 250);
			        SweeperSteps[playerid][1] = 9;
			        SetPlayerRaceCheckpoint(playerid, 0, 1369.5051,-1392.7247,13.0346,1294.5410,-1565.4962,12.9621, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][1] == 9)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 250);
			        SweeperSteps[playerid][1] = 10;
			        SetPlayerRaceCheckpoint(playerid, 0, 1294.5410,-1565.4962,12.9621,1293.6605,-1837.6873,12.9545, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][1] == 10)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 250);
			        SweeperSteps[playerid][1] = 11;
			        SetPlayerRaceCheckpoint(playerid, 0, 1293.6605,-1837.6873,12.9545,1524.6145,-1875.7056,12.9340, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][1] == 11)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 144);
			        SweeperSteps[playerid][1] = 12;
			        SetPlayerRaceCheckpoint(playerid, 1, 1619.4293,-1881.6036,13.4845, 1619.4293, -1881.6036, 13.4845, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][1] == 12)
			    {
			        SweeperSteps[playerid][1] = 0;
			        DialogSweeper[1] = false; // Dialog 0 telah di pilih
		    		DialogSaya[playerid][1] = false;
			        SendClientMessageEx(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}$40.00 telah dimasukkan ke JobSalary mu.");
					PlayerInfo[playerid][pPayCheck] += 4000;
			        PlayerInfo[playerid][pSweeperT] = 1800;
			        DisablePlayerRaceCheckpoint(playerid);
			        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			        return 1;
		   		}
		   		else if(SweeperSteps[playerid][2] == 1)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 144);
			        SweeperSteps[playerid][2] = 2;
			        SetPlayerRaceCheckpoint(playerid, 0, 1539.4319,-1869.4375,13.1080, 1323.6667,-1851.4268,13.1080, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 2)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 15);
			        SweeperSteps[playerid][2] = 3;
			        SetPlayerRaceCheckpoint(playerid, 0, 1323.6667,-1851.4268,13.1080, 1184.0767,-1849.0615,13.1313, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 3)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 15);
			        SweeperSteps[playerid][2] = 17;
			        SetPlayerRaceCheckpoint(playerid, 0, 1184.0767,-1849.0615,13.1313, 1181.9901,-1711.4929,13.2177, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 17)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 20);
			        SweeperSteps[playerid][2] = 4;
			        SetPlayerRaceCheckpoint(playerid, 0, 1181.9901,-1711.4929,13.2177,1045.3878,-1709.5790,13.1080, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 4)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 100);
			        SweeperSteps[playerid][2] = 5;
			        SetPlayerRaceCheckpoint(playerid, 0, 1045.3878,-1709.5790,13.1080,1039.8157,-1583.4841,13.1078, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 5)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 70);
			        SweeperSteps[playerid][2] = 6;
			        SetPlayerRaceCheckpoint(playerid, 0, 1039.8157,-1583.4841,13.1078,927.9300,-1568.9344,13.1080, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 6)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 5);
			        SweeperSteps[playerid][2] = 7;
			        SetPlayerRaceCheckpoint(playerid, 0, 927.9300,-1568.9344,13.1080,916.0417,-1583.1429,13.1079, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 7)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 300);
			        SweeperSteps[playerid][2] = 8;
			        SetPlayerRaceCheckpoint(playerid, 0, 916.0417,-1583.1429,13.1079,916.0583,-1760.4836,13.1076, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 8)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 129);
			        SweeperSteps[playerid][2] = 9;
			        SetPlayerRaceCheckpoint(playerid, 0, 916.0583,-1760.4836,13.1076,819.3672,-1766.9518,13.1248, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 9)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 90);
			        SweeperSteps[playerid][2] = 10;
			        SetPlayerRaceCheckpoint(playerid, 0, 819.3672,-1766.9518,13.1248,832.2370,-1623.7051,13.1080, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 10)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 250);
			        SweeperSteps[playerid][2] = 11;
			        SetPlayerRaceCheckpoint(playerid, 0, 832.2370,-1623.7051,13.1080,905.0103,-1576.2756,13.1081, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 11)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 200);
			        SweeperSteps[playerid][2] = 12;
			        SetPlayerRaceCheckpoint(playerid, 0, 905.0103,-1576.2756,13.1081, 1286.4901,-1574.9495,13.1080, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 12)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 20);
			        SweeperSteps[playerid][2] = 13;
			        SetPlayerRaceCheckpoint(playerid, 0, 1286.4901,-1574.9495,13.1080,1294.6498,-1852.5858,13.1080, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 13)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 100);
			        SweeperSteps[playerid][2] = 14;
			        SetPlayerRaceCheckpoint(playerid, 0, 1294.6498,-1852.5858,13.1080,1524.0383,-1875.6007,13.1080, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 14)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 100);
			        SweeperSteps[playerid][2] = 15;
			        SetPlayerRaceCheckpoint(playerid, 0, 1524.0383,-1875.6007,13.1080,1619.1874, -1877.3141, 13.3828, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 15)
			    {
			        DisablePlayerRaceCheckpoint(playerid);
			        GivePlayerCash(playerid, 100);
			        SweeperSteps[playerid][2] = 16;
			        SetPlayerRaceCheckpoint(playerid, 1, 1619.1874, -1877.3141, 13.3828,1619.1874, -1877.3141, 13.3828, 5);
			        return 1;
			    }
			    else if(SweeperSteps[playerid][2] == 16)
			    {
			        SweeperSteps[playerid][2] = 0;
			        DialogSweeper[2] = false; // Dialog 0 telah di pilih
		    		DialogSaya[playerid][2] = false;
					SendClientMessageEx(playerid, COLOR_ARWIN, "SIDEJOBINFO: {FFFFFF}$75.00 telah dimasukkan ke JobSalary mu.");
					PlayerInfo[playerid][pPayCheck] += 7500;
			        PlayerInfo[playerid][pSweeperT] = 1800;
			        DisablePlayerRaceCheckpoint(playerid);
			        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			        return 1;
		   		}
			}
	   	}
    }
	return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
	//Lumberjack Job
 	if(PlayerInfo[playerid][pJob] == 8 || PlayerInfo[playerid][pJob2] == 8)
	{
 		new vehhh = GetPlayerVehicleID(playerid);
 		if(PlayerInfo[playerid][pLumber] > 0)
 		{
			if( GetVehicleModel( vehhh ) == 422 || GetVehicleModel( vehhh ) == 554 || GetVehicleModel( vehhh ) == 543 || GetVehicleModel( vehhh ) == 478 )
			{
				GameTextForPlayer(playerid, "~g~Unloading Lumber..", 3000, 3);
				TogglePlayerControllable(playerid,0);
				SetTimerEx("UnloadLumber", 10000, false, "i", playerid);
				DisablePlayerCheckpoint(playerid);
			}
		}
	}
	if(GetPVarInt(playerid,"TrackCar") != 0)
	{
	    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	    DisablePlayerCheckpoint(playerid);
		DeletePVar(playerid, "TrackCar");
		return 1;
	}
	if(GetPVarInt(playerid, "Finding")>=1)
	{
	    DeletePVar(playerid, "Finding");
	    DisablePlayerCheckpoint(playerid);
	    GameTextForPlayer(playerid, "~w~Reached destination", 5000, 1);
	}
	else if(EMSCallTime[playerid] > 0 && EMSAccepted[playerid] < 999)
	{
	    if(GetPVarInt(EMSAccepted[playerid], "Injured") == 1)
	    {
	    	SendEMSQueue(EMSAccepted[playerid],2);
	    	EMSAccepted[playerid] = 999;
	    	GameTextForPlayer(playerid, "~w~mencapai tujuan", 5000, 1);
	    	EMSCallTime[playerid] = 0;
	    	DisablePlayerCheckpoint(playerid);
		}
		else
		{
            EMSAccepted[playerid] = 999;
		    GameTextForPlayer(playerid, "~r~Pasien telah meninggal", 5000, 1);
		    EMSCallTime[playerid] = 0;
	    	DisablePlayerCheckpoint(playerid);
		}
	}
	else if(MedicCallTime[playerid] > 0 && MedicAccepted[playerid] < 999)
	{
		MedicAccepted[playerid] = 999;
		GameTextForPlayer(playerid, "~w~Pasien telah diantarkan", 5000, 1);
		MedicCallTime[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	else
	{
		switch (gPlayerCheckpointStatus[playerid])
		{
			case CHECKPOINT_HOME:
			{
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				new i = hInviteHouse[playerid];
				DisablePlayerCheckpoint(playerid);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
    			Streamer_UpdateEx(playerid, HouseInfo[i][hInteriorX],HouseInfo[i][hInteriorY],HouseInfo[i][hInteriorZ]);
				AC_BS_SetPlayerInterior(playerid,HouseInfo[i][hHInteriorWorld]);
				if(HouseInfo[i][hCustomInterior] == 1)
				{
				    TogglePlayerControllable(playerid, 1);
			        GameTextForPlayer(playerid, "Objects loading...", 4000, 5);
				    SetPVarInt(playerid, "LoadingObjects", 1);
				    SetTimerEx("SafeLoadObjects", 4000, 0, "d", playerid);
		        }
				AC_BS_SetPlayerPos(playerid,HouseInfo[i][hInteriorX],HouseInfo[i][hInteriorY],HouseInfo[i][hInteriorZ]);
				PlayerInfo[playerid][pInt] = HouseInfo[i][hHInteriorWorld];
				PlayerInfo[playerid][pLocal] = i+6000;
				PlayerInfo[playerid][pVW] = i+6000;
				AC_BS_SetPlayerVirtualWorld(playerid, i+6000);
				hInviteOffer[playerid] = 999;
				hInviteHouse[playerid] = INVALID_HOUSE_ID;
			}
		}
	}
	return 1;
}

public SetAllPlayerCheckpoint(Float:allx, Float:ally, Float:allz, Float:radi, num)
{
	foreach(Player, i)
	{
		SetPlayerCheckpoint(i,allx,ally,allz, radi);
		if (num != 255)
		{
			gPlayerCheckpointStatus[i] = num;
		}
	}
}

public SetAllCopCheckpoint(Float:allx, Float:ally, Float:allz, Float:radi)
{
	foreach(Player, i)
	{
		if(gTeam[i] == 2)
		{
			SetPlayerCheckpoint(i,allx,ally,allz, radi);
		}
	}
	return 1;
}

public ShowPlayerBeaconForCops(playerid)
{
	foreach(Player, i)
	{
		if(gTeam[i] == 2 || IsACop(i))
		{
			SetPlayerMarkerForPlayer(i, playerid, COP_GREEN_COLOR);
		}
	}
	return 1;
}

public HidePlayerBeaconForCops(playerid)
{
	foreach(Player, i)
	{
		if(gTeam[i] == 2 || IsACop(i))
		{
			SetPlayerMarkerForPlayer(i, playerid, TEAM_HIT_COLOR);
		}
	}
	SetPlayerToTeamColor(playerid);
	return 1;
}

public ShowPlayerBeaconForMedics(playerid)
{
	foreach(Player, i)
	{
		if(IsInLSMD(i))
		{
			SetPlayerMarkerForPlayer(i, playerid, COP_GREEN_COLOR);
		}
	}
	return 1;
}

public HidePlayerBeaconForMedics(playerid)
{
	foreach(Player, i)
	{
		if(IsInLSMD(i))
		{
			SetPlayerMarkerForPlayer(i, playerid, TEAM_HIT_COLOR);
		}
	}
	SetPlayerToTeamColor(playerid);
	return 1;
}


// MoveEMS Function(playerid)
public MoveEMS(playerid)
{
    new Float:mX, Float:mY, Float:mZ;
    GetPlayerPos(playerid, mX, mY, mZ);

    SetPVarFloat(GetPVarInt(playerid, "MovingStretcher"), "MedicX", mX);
	SetPVarFloat(GetPVarInt(playerid, "MovingStretcher"), "MedicY", mY);
	SetPVarFloat(GetPVarInt(playerid, "MovingStretcher"), "MedicZ", mZ);
	SetPVarInt(GetPVarInt(playerid, "MovingStretcher"), "MedicVW", GetPlayerVirtualWorld(playerid));
	SetPVarInt(GetPVarInt(playerid, "MovingStretcher"), "MedicInt", GetPlayerInterior(playerid));

	Streamer_UpdateEx(GetPVarInt(playerid, "MovingStretcher"), mX, mY, mZ);
	AC_BS_SetPlayerPos(GetPVarInt(playerid, "MovingStretcher"), mX, mY, mZ);
	AC_BS_SetPlayerInterior(GetPVarInt(playerid, "MovingStretcher"), GetPlayerVirtualWorld(playerid));
	AC_BS_SetPlayerVirtualWorld(GetPVarInt(playerid, "MovingStretcher"), GetPlayerVirtualWorld(playerid));

	ClearAnimations(GetPVarInt(playerid, "MovingStretcher"));
	ApplyAnimation(GetPVarInt(playerid, "MovingStretcher"), "SWAT", "gnstwall_injurd", 4.0, 0, 1, 1, 1, 0, 1);

	DeletePVar(GetPVarInt(playerid, "MovingStretcher"), "OnStretcher");
	SetPVarInt(playerid, "MovingStretcher", -1);
}

// KillEMSQueue Function(playerid)
public KillEMSQueue(playerid)
{
    DeletePVar(playerid, "Injured");
    DeletePVar(playerid, "EMSAttempt");
	SetPVarInt(playerid, "MedicBill", 1);
	DeletePVar(playerid, "MedicCall");

	return 1;
}

// SendEMSQueue Function(playerid)
public SendEMSQueue(playerid,type)
{
    switch (type)
	{
		case 1:
		{
		    if(GetPlayerAnimationIndex(playerid) != 746) ClearAnimations(playerid), ApplyAnimation(playerid, "PED","KO_skid_front", 4.0, 0, 1, 1, 1, 0, 1);
		    Streamer_UpdateEx(playerid, GetPVarFloat(playerid,"MedicX"), GetPVarFloat(playerid,"MedicY"), GetPVarFloat(playerid,"MedicZ"));
			AC_BS_SetPlayerPos(playerid, GetPVarFloat(playerid,"MedicX"), GetPVarFloat(playerid,"MedicY"), GetPVarFloat(playerid,"MedicZ"));
			AC_BS_SetPlayerVirtualWorld(playerid, GetPVarInt(playerid,"MedicVW"));
	  		AC_BS_SetPlayerInterior(playerid, GetPVarInt(playerid,"MedicInt"));

			SetPVarInt(playerid, "EMSAttempt", -1);

			if(GetPlayerInterior(playerid) > 0)
			{
				TogglePlayerControllable(playerid, 0);
			    SetPVarInt(playerid, "LoadingObjects", 1);
			    SetTimerEx("SafeLoadObjects", 4000, 0, "d", playerid);
			}

			SetPVarInt(playerid,"MedicCall",1);
		}
		case 2:
		{
		    if(GetPlayerAnimationIndex(playerid) != 746) ClearAnimations(playerid), ApplyAnimation(playerid, "PED","KO_skid_front", 4.0, 0, 1, 1, 1, 0, 1);
		    SetPVarInt(playerid,"EMSAttempt", 2);
		 	ApplyAnimation(playerid,"PED","KO_skid_front",4.1, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}

// AddWarrant Function (playerid,judgeid,crime[])
public AddWarrant(playerid,judgeid,crime[])
{
    new String[10000];
    new day,month,year;
	getdate(year,month,day);
    new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(String,sizeof(String),"warrants/%s.ini",playername);
    new File: file = fopen(String, io_write);
	if(file)
	{
	    format(String,sizeof(String),"%s - %s (%d/%d/%d)",crime,GetPlayerNameEx(judgeid),day,month,year);
	    fwrite(file, String);
	    fclose(file);
	}
	return 1;
}

// RemoveWarrant Function (playerid)
public RemoveWarrant(playerid)
{
	new String[10000];
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	format(String,sizeof(String),"warrants/%s.ini",playername);
	if(fexist(String))
	{
		fremove(String);
		return 1;
	}
	else
	{
	    return 0;
	}
}

// OAddWarrant Function (name[],judgeid,crime[])
public OAddWarrant(name[],judgeid,crime[])
{
	new String[10000];
	new day,month,year;
	getdate(year,month,day);
	format(String,sizeof(String),"warrants/%s.ini",name);
	new File: file = fopen(String, io_write);
	if(file)
	{
	    format(String,sizeof(String),"%s - %s (%d/%d/%d)",crime,GetPlayerNameEx(judgeid),day,month,year);
	    fwrite(file, String);
	    fclose(file);
	}
}

// ORemoveWarrant Function (name[])
public ORemoveWarrant(name[])
{
	new String[10000];
	format(String,sizeof(String),"warrants/%s.ini",name);
	if(fexist(String))
	{
	    fremove(String);
	    return 1;
	}
	else
	{
	    return 0;
	}
}

stock IsInvalidSkin(skin)
{
    #define	MAX_BAD_SKINS   14
    new badSkins[MAX_BAD_SKINS] =
    {
        993, 994, 995, 996, 998, 9942, 965, 974, 986,
        919, 949, 908, 973, 989
    };

    for (new i = 0; i < MAX_BAD_SKINS; i++)
    {
        if (skin == badSkins[i] || skin < 0 || skin >= 311 ) return true;
    }

    return false;
}

stock IsInvalidSkinEx(skin) // Add the restricted skins that don't crash their client.
{
    #define	MAX_BAD_SKINSEX   15
    new badSkins[MAX_BAD_SKINSEX] =
    {
        993, 994, 995, 996, 998, 992, 965, 974, 986,
        919, 949, 908, 973, 989, 986
    };

    for (new i = 0; i < MAX_BAD_SKINSEX; i++)
    {
        if (skin == badSkins[i] || skin < 0 || skin >= 311 ) return true;
    }

    return false;
}

IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

forward DrinkCooldown(playerid);
public DrinkCooldown(playerid)
{
    SetPVarInt(playerid, "DrinkCooledDown", 1);
    return 1;
}

forward RadarCooldown(playerid);
public RadarCooldown(playerid)
{
   DeletePVar(playerid, "RadarTimeout");
   return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(gPlayerUsingLoopingAnim[playerid])
	{
		if(IsKeyJustDown(KEY_SPRINT,newkeys,oldkeys))
		{
		    TextDrawHideForPlayer(playerid,txtAnimHelper);
			StopLoopingAnim(playerid);
			animation[playerid] = 0;
			ClearAnimations(playerid);
			return 1;
		}
	}
	if(IsKeyJustDown(KEY_YES, newkeys, oldkeys))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510) return -1;
			SetVehicleLights(vehicleid, playerid);
		}
	    if (IsPlayerInRangeOfPoint(playerid,5.0,649.3228, -608.1068, -3.9568)) {
	        if(IsACop(playerid)) {
	            if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
	                SetVehiclePos(GetPlayerVehicleID(playerid), 624.5196,-596.8649,16.9396);
	            }
	            else {
	                AC_BS_SetPlayerPos(playerid,624.5196,-596.8649,16.9396);
	            }
	        }
	    }
	 	if (IsPlayerInRangeOfPoint(playerid,5.0,618.0125, -597.0211, 18.1502)) {
	        if(IsACop(playerid)) {
	            if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
	                SetVehiclePos(GetPlayerVehicleID(playerid), 643.8234,-608.0292,-4.2479);
	            }
	            else {
	                AC_BS_SetPlayerPos(playerid,643.8234,-608.0292,-4.2479);
	            }
	        }
	    }
	}
 	if(IsKeyJustDown(KEY_CROUCH, newkeys, oldkeys))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			cmd_paytoll(playerid, "");
			cmd_go(playerid, "");
			cmd_gate(playerid, "");

		    for(new idx=1; idx<MAX_GATES; idx++)
			{
		    	if(GateInfo[idx][gModel] && IsPlayerInRangeOfPoint(playerid, GateInfo[idx][gRange], GateInfo[idx][gCX], GateInfo[idx][gCY], GateInfo[idx][gCZ]))
				{
					if(PlayerInfo[playerid][pGate] == idx)
					{
				    	if(!GateInfo[idx][gStatus])
					    {
					    	GateInfo[idx][gStatus] = 1;
					        MoveDynamicObject(GateInfo[idx][gGate], GateInfo[idx][gOX], GateInfo[idx][gOY], GateInfo[idx][gOZ], GateInfo[idx][gSpeed]);
					        SetDynamicObjectRot(GateInfo[idx][gGate], GateInfo[idx][gORX], GateInfo[idx][gORY], GateInfo[idx][gORZ]);
					    }
				        else
				        {
				            GateInfo[idx][gStatus] = 0;
				            MoveDynamicObject(GateInfo[idx][gGate], GateInfo[idx][gCX], GateInfo[idx][gCY], GateInfo[idx][gCZ], GateInfo[idx][gSpeed]);
				            SetDynamicObjectRot(GateInfo[idx][gGate], GateInfo[idx][gCRX], GateInfo[idx][gCRY], GateInfo[idx][gCRZ]);
				        }
					}
				}
			}
		}
	}
	/*/DISABLE ANTI BUNNY HOPP
	if((newkeys & KEY_JUMP) && !IsPlayerInAnyVehicle(playerid))
    {
        PlayerPressedJump[playerid] ++;
        SetTimerEx("PressJumpReset", 11000, false, "i", playerid);
        if(PlayerPressedJump[playerid] == 8)
        {
            foreach(Player, p)
            {
	            new string[1024];
	            PlayerPressedJump[playerid] = 0;
	            format(string, sizeof(string), "AdmWarn: {FF0000}%s {FFFF00}possible Bunny Hopping.", GetName(playerid));
				if(PlayerInfo[p][pAdmin] >= 1)
				{
				    if(togbh[p] == 1)
				    {
				        SendClientMessageEx(p,COLOR_YELLOW,string);
					}
				}
			}
        }
    }*/
    if((newkeys & KEY_NO ))
	{
	    	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				new engine,lights,alarm,doors,bonnet,boot,objective,vehicleid;
				vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510) return SendClientMessageEx(playerid,COLOR_WHITE,"This command can't be used in this vehicle.");
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if(engine == VEHICLE_PARAMS_ON)
				{
					SetVehicleEngine(vehicleid, playerid);
				}
				else if((engine == VEHICLE_PARAMS_OFF || engine == VEHICLE_PARAMS_UNSET))
				{
					SendClientMessageEx(playerid, COLOR_WHITE, "ENGINE: Anda mencoba untuk menghidupkan Mesin.");
					SetTimerEx("SetVehicleEngine", 3000, 0, "dd",  vehicleid, playerid);
				}
			}
	}
	if((newkeys & KEY_SECONDARY_ATTACK ))
	{
		return cmd_enter(playerid, "");
	}

 	//============================
    if(IsPlayerNPC(playerid)) return 1;
	if((newkeys & KEY_FIRE) && GetPVarInt(playerid, "SpeedRadar") == 1 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
 	{
	    if(GetPVarInt(playerid, "RadarTimeout") == 0)
	    {
			if(GetPlayerWeapon(playerid) == SPEEDGUN)
			{
			    new Float:x,Float:y,Float:z;
				for(new veh = 1; veh < MAX_VEHICLES; veh++)
				{
				    if(IsVehicleStreamedIn(veh, playerid))
				    {
					    GetVehiclePos(veh,x,y,z);
					    if(IsPlayerAimingAt(playerid,x,y,z,10))
					    {
							new Float: Speed = GetVehicleSpeed(veh, 0);
							new String[68];
							format(String, sizeof(String), "~n~~n~~n~~n~~n~~n~~b~License Plate: ~w~%d~n~~b~Speed: ~w~%d MPH", veh, floatround(Speed/1.609));
							GameTextForPlayer(playerid, String,3500, 3);
							format(String, sizeof(String), "License Plate: %d Speed: %d MPH", veh, floatround(Speed/1.609));
							SendClientMessageEx(playerid, COLOR_GRAD4, String);
							SetPVarInt(playerid, "RadarTimeout", 1);
							SetTimerEx("RadarCooldown", 3000, 0, "i", playerid);
							return 1;
						}
					}
			    }
			}
		}
	}
	if((newkeys & KEY_FIRE) && pTazer[playerid] == 1 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
 		if(TazerTimeout[playerid] > 0)
  		{
			return 1;
		}
		new Float:X, Float:Y, Float:Z;
		foreach(Player, i)
		{
		    if(IsPlayerStreamedIn(i, playerid))
		    {
			    GetPlayerPos(i, X, Y, Z);
				if(IsPlayerAimingAt(playerid,X,Y,Z,1) && PlayerCuffed[i] == 0 && GetPlayerState(i) == PLAYER_STATE_ONFOOT && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
				{
		    		TogglePlayerControllable(i, 0);
					PlayerPlaySound(i, 6003, 0,0,0);
					PlayerPlaySound(playerid, 6003, 0,0,0);
					PlayerCuffed[i] = 1;
					SetPVarInt(i, "PlayerCuffed", 1);
					PlayerCuffedTime[i] = 16;
					SetPVarInt(i, "IsFrozen", 1);
					//Frozen[i] = 1;
					TazerTimeout[playerid] = 4;
					SetTimerEx("TazerTimer",1000,false,"d",playerid);
					return 1;
				}
			}
		}
	}
	if((newkeys & 16) && GetPVarInt(playerid,"UsingAnim") == 1 && GetPVarInt(playerid, "IsFrozen") == 0 && GetPlayerState(playerid) == 1 && PlayerCuffed[playerid] == 0 && PlayerInfo[playerid][pBeingSentenced] == 0)
	{
		ClearAnimations(playerid);
		DeletePVar(playerid,"UsingAnim");
	}
	if((newkeys & KEY_SPRINT) && GetPVarInt(playerid,"UsingAnim") == 1 && GetPVarInt(playerid, "IsFrozen") == 0 && GetPlayerState(playerid) == 1 && PlayerCuffed[playerid] == 0 && PlayerInfo[playerid][pBeingSentenced] == 0)
	{
			ClearAnimations(playerid);
			SetPlayerSkin(playerid, GetPlayerSkin(playerid));
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			DeletePVar(playerid,"UsingAnim");
	}
	//Lumber Jack Job
	new vehhh = IsPlayerInRangeOfVehicle(playerid, 5.0);
	if (newkeys & KEY_YES && GetPVarInt(playerid, "HoldingWood") == 1)
	{
	    if( GetVehicleModel( vehhh ) == 422 || GetVehicleModel( vehhh ) == 554 || GetVehicleModel( vehhh ) == 543 || GetVehicleModel( vehhh ) == 478 )
		{
	    	if (GetPVarInt(playerid, "LoadingWood") == 0)
			{
				SetTimerEx("LoadLumber", 1000, false, "i", playerid);
				SetPVarInt(playerid, "LoadingWood", 1);
			}
		}
	}
	//,SPECIAL_ACTION_DRINK_BEER,SPECIAL_ACTION_DRINK_WINE,SPECIAL_ACTION_DRINK_SPRUNK
	if(newkeys & KEY_FIRE && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_SMOKE_CIGGY)
	{
            PlayerInfo[playerid][pCondition] --;
 	}
	if(newkeys & KEY_FIRE && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DRINK_BEER)
	{
	    	SetPlayerDrunkLevel(playerid, 50000);
			SetTimerEx("StopCameraEffect", 60000, 0, "i", playerid);
		    PlayerInfo[playerid][pCondition] --;
	}
	if(newkeys & KEY_FIRE && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DRINK_WINE)
	{
	    	SetPlayerDrunkLevel(playerid, 50000);
			SetTimerEx("StopCameraEffect", 60000, 0, "i", playerid);
		    PlayerInfo[playerid][pCondition] --;
	}
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DRINK_SPRUNK && (newkeys & KEY_FIRE))
	{
	    if(GetPVarInt(playerid, "DrinkCooledDown") == 1)
	    {
			new Float: cHealth;
			GetPlayerHealth(playerid, cHealth);
		    if(cHealth < 100)
		    {
				AC_BS_SetPlayerHealth(playerid, cHealth+2);
				PlayerInfo[playerid][pHealth] += 2.0;
		    }
		    else
		    {
		        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		    }
		    DeletePVar(playerid, "DrinkCooledDown");
		    SetTimerEx("DrinkCooldown", 2500, 0, "i", playerid);
			return 1;
		}
	}
	if(IsKeyJustDown(KEY_SECONDARY_ATTACK, newkeys, oldkeys))
	{
	    if(GetPVarInt(playerid, "NGPassenger") == 1)
	    {
	        TogglePlayerSpectating(playerid, 0);
		}
		if(GetPVarInt(playerid, "UsingSprunk"))
		{
			DeletePVar(playerid, "UsingSprunk");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			return 1;
		}
	}
	if (IsKeyJustDown(KEY_FIRE, newkeys, oldkeys))
 	{
 	    if(prSpawn[playerid] == 1)
 	    {
			new String[50];
 	        new Float:x,Float:y,Float:z,Float:angle, idx = prSpawnID[playerid];
 	        GetPlayerPos(playerid, x, y, z);
 	        GetPlayerFacingAngle(playerid, angle);
			RentInfo[idx][rSpawnX] = x;
			RentInfo[idx][rSpawnY] = y;
			RentInfo[idx][rSpawnZ] = z;
			RentInfo[idx][rAngle] = angle;
			format(String, sizeof(String), "Anda telah men-set Lokasi Spawn kendaraan Rent ID: %d", idx);
			SendClientMessage(playerid, COLOR_WHITE, String);
			prSpawnID[playerid] = 0;
			prSpawn[playerid] = 0;
		}
 	    if(GetPVarInt(playerid, "MovingStretcher") != -1)
 	    {
 	        KillTimer(GetPVarInt(playerid, "TickEMSMove"));
		    MoveEMS(playerid);
			return 1;
 	    }
 	    if(GetPVarInt(playerid, "editingcdvehpos"))
		{
			TogglePlayerControllable(playerid, false);
		    ShowPlayerDialog(playerid,DIALOG_CDEDITPARK,DIALOG_STYLE_MSGBOX,"Warning:","Is this the new position you want?","Ok","Cancel");
		}
		if(GetPVarInt(playerid, "editingcdvehnew"))
		{
            TogglePlayerControllable(playerid, false);
	        ShowPlayerDialog(playerid,DIALOG_CDEDITPARK,DIALOG_STYLE_MSGBOX,"Warning:","Is this the new position you want?","Ok","Cancel");
		}
		if(GetPVarInt(playerid, "editingfamhq") != 255)
		{
		    if(GetPVarInt(playerid, "editingfamhqaction") == 1)
		    {
      			DeletePVar(playerid, "editingfamhqaction");
		        TogglePlayerControllable(playerid, false);
	        	ShowPlayerDialog(playerid,HQENTRANCE,DIALOG_STYLE_MSGBOX,"Warning:","Is this the entrance you want?","Ok","Cancel");
		    }
		    else if(GetPVarInt(playerid, "editingfamhqaction") == 2)
		    {
		        DeletePVar(playerid, "editingfamhqaction");
		        TogglePlayerControllable(playerid, false);
	        	ShowPlayerDialog(playerid,HQEXIT,DIALOG_STYLE_MSGBOX,"Warning:","Is this the exit you want?","Ok","Cancel");
		    }
		    else if(GetPVarInt(playerid, "editingfamhqaction") == 5)
		    {
		        TogglePlayerControllable(playerid, false);
	        	ShowPlayerDialog(playerid,HQENTRANCE,DIALOG_STYLE_MSGBOX,"Warning:","Is this the entrance you want?","Ok","Cancel");
		    }
		    else if(GetPVarInt(playerid, "editingfamhqaction") == 6)
		    {
		        TogglePlayerControllable(playerid, false);
	        	ShowPlayerDialog(playerid,HQEXIT,DIALOG_STYLE_MSGBOX,"Warning:","Is this the exit you want?","Ok","Cancel");
		    }

		}
		if(GetPVarInt(playerid, "UsingSprunk"))
		{
		    if(PlayerInfo[playerid][pEnergi] >= 100)
			{
			    DeletePVar(playerid, "UsingSprunk");
  				return 1;
	   		}
	   		else
	   		{
	   		    PlayerInfo[playerid][pBladder] -= 5;
		    	PlayerInfo[playerid][pEnergi] += 5;
			}
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if (newstate == PLAYER_STATE_PASSENGER)
	{
	    switch (GetPlayerWeapon(playerid))
	    {
	        case 22, 25, 28..33:
	    		SetPlayerArmedWeapon(playerid, GetPlayerWeapon(playerid));

			default:
				SetPlayerArmedWeapon(playerid, 0);
		}
	}
	if(newstate != 2) NOPTrigger[playerid] = 0;
	if(GettingSpectated[playerid] != INVALID_PLAYER_ID)
	{
	    new spectator = GettingSpectated[playerid];
	    if(!IsPlayerConnected(spectator))
	    {
	        GettingSpectated[playerid] = INVALID_PLAYER_ID;
	        Spectate[spectator] = INVALID_PLAYER_ID;
		}

	    if(newstate == PLAYER_STATE_DRIVER && PlayerInfo[spectator][pAdmin] >= 2 || newstate == PLAYER_STATE_PASSENGER && PlayerInfo[spectator][pAdmin] >= 2)
	    {
	        TogglePlayerSpectating(spectator, true);
			new carid = GetPlayerVehicleID( playerid );
			PlayerSpectateVehicle( spectator, carid );
	    }
	    else if(newstate == PLAYER_STATE_ONFOOT && PlayerInfo[spectator][pAdmin] >= 2)
	    {
	        TogglePlayerSpectating(spectator, true);
		   	PlayerSpectatePlayer( spectator, playerid );
		   	AC_BS_SetPlayerInterior( spectator, GetPlayerInterior( playerid ) );
	    }
	}
	if(IsPlayerNPC(playerid))
	{
		if(newstate == PLAYER_STATE_SPECTATING)
		{
			TogglePlayerSpectating(playerid, false);
		}
		return 1;
	}
	if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
	{
	    if(LicenseTest[playerid] == 1)
	    {
	        SendClientMessageEx(playerid, COLOR_GREY, "Anda telah keluar dari kendaraan");
	        SendClientMessageEx(playerid, COLOR_GREY, "Tes mengemudi gagal");
	        LicenseTest[playerid] = 0;
	        CPD[playerid] = 0;
		    DisablePlayerCheckpoint(playerid);
		}
		SetPlayerDrunkLevel(playerid, 0);
	}
	if(newstate == PLAYER_STATE_DRIVER) {
		if(PlayerInfo[playerid][pEnergi] < 30)
		{
	    	if(IsPlayerInAnyVehicle(playerid))
			{
			    SetPlayerDrunkLevel(playerid, 4000);
			}
		}
	    pvehicleid[playerid] = GetPlayerVehicleID(playerid);
	    pmodelid[playerid] = GetVehicleModel(pvehicleid[playerid]);
	}
	else {
	    pvehicleid[playerid] = 0;
	    pmodelid[playerid] = 0;
	}
    if(newstate == PLAYER_STATE_PASSENGER) // TAXI & BUSSES
	{
 		if(stationidv[GetPlayerVehicleID(playerid)] != 0)
		{
		    new station[64];
			switch(stationidv[GetPlayerVehicleID(playerid)])
			{
				case 1: format(station, sizeof(station), "http://216.246.109.162:8000");
				case 2: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1415249");
				case 3: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1415249");
				case 4: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1628721");
				case 5: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1283687");
				case 6: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1628932");
				case 7: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1756658");
				case 8: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377200");
				case 9: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=2057197");
				case 10: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=18695");
				case 11: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=412093");
				case 12: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=181367");
				case 13: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1275071");
				case 14: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=412093");
				case 15: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280356");
				case 16: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1279013");
				case 17: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1281016");
				case 18: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280855");
				case 19: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1116397");
				case 20: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=2057543");
				case 21: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=616366");
				case 22: format(station, sizeof(station), "http://38.107.220.164:8014");
				case 23: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=847066");
			}
			if(Audio_IsClientConnected(playerid))
		 	{
		 	    Audio_Stop(playerid, stationidp[playerid]);
				stationidp[playerid] = Audio_PlayStreamed(playerid, station, false, true, false);
			}
		}
        if( GetPVarInt( playerid, "ToBeEjected" ) >= 1 )
    	{
	       	SetPVarInt( playerid, "ToBeEjected", 0 );
	       	RemovePlayerFromVehicle( playerid );
	       	new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			AC_BS_SetPlayerPos(playerid, X, Y, Z+2);

			if(GetPVarInt(playerid, "Injured") == 1)
  			{
  			    Streamer_UpdateEx(playerid, GetPVarFloat(playerid,"MedicX"), GetPVarFloat(playerid,"MedicY"), GetPVarFloat(playerid,"MedicZ"));
		   		AC_BS_SetPlayerPos(playerid, GetPVarFloat(playerid,"MedicX"), GetPVarFloat(playerid,"MedicY"), GetPVarFloat(playerid,"MedicZ"));
				AC_BS_SetPlayerVirtualWorld(playerid, GetPVarInt(playerid,"MedicVW"));
				AC_BS_SetPlayerInterior(playerid, GetPVarInt(playerid,"MedicInt"));
   				ClearAnimations(playerid);
				ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Die",4.0,0,1,1,1,0);
				TogglePlayerControllable(playerid, 0);
   			}
   		}
	}
	if(newstate == PLAYER_STATE_WASTED)
	{
		if(ConnectedToPC[playerid] == 1337)//mdc
	    {
	        ConnectedToPC[playerid] = 0;
		}
		Seatbelt[playerid] = 0;
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    if(stationidv[GetPlayerVehicleID(playerid)] != 0)
		{
		    new station[64];
			switch(stationidv[GetPlayerVehicleID(playerid)])
			{
				case 1: format(station, sizeof(station), "http://216.246.109.162:8000");
				case 2: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1415249");
				case 3: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1415249");
				case 4: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1628721");
				case 5: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1283687");
				case 6: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1628932");
				case 7: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1756658");
				case 8: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377200");
				case 9: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=2057197");
				case 10: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=18695");
				case 11: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=412093");
				case 12: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=181367");
				case 13: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1275071");
				case 14: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=412093");
				case 15: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280356");
				case 16: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1279013");
				case 17: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1281016");
				case 18: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280855");
				case 19: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1116397");
				case 20: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=2057543");
				case 21: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=616366");
				case 22: format(station, sizeof(station), "http://38.107.220.164:8014");
				case 23: format(station, sizeof(station), "http://yp.shoutcast.com/sbin/tunein-station.pls?id=847066");
			}
			if(Audio_IsClientConnected(playerid))
		 	{
		 	    Audio_Stop(playerid, stationidp[playerid]);
				stationidp[playerid] = Audio_PlayStreamed(playerid, station, false, true, false);
			}
		}

		new
			newcar = GetPlayerVehicleID(playerid),
			engine, lights, alarm, doors, bonnet, boot, objective, v;

		gLastCar[playerid] = newcar;

	 	foreach(Player, i) {
	   		v = GetPlayerVehicle(i, newcar);
		    if(v != -1) {
				if(i == playerid) {

					new
						String[96];
					if(PlayerVehicleInfo[i][v][pvTicket] != 0)
					{
						format(String, sizeof(String),"(%s) surat tilang ada di kendaraan anda. Anda harus membayarnya di tempat LSPD.", FormatMoney(PlayerVehicleInfo[i][v][pvTicket]));
						SendClientMessageEx(playerid, COLOR_GREY, String);
					}
					if(PlayerVehicleInfo[i][v][pvImpounded] == 2)
					{
					    SendClientMessageEx(playerid, COLOR_GREY, "Ban kendaraan anda telah digembok oleh Pihak Berwajib");
					    RemovePlayerFromVehicle(playerid);
					    return 1;
					}

				}
				return 1;
			}
		}

		for(new f = 0; f < MAX_FAMILY; f++) {
			v = GetGangVehicle(f, newcar);
			if(v != -1) {
				new String[49 + MAX_PLAYER_NAME];
				if(PlayerInfo[playerid][pFMember] == f)
				{
					format(String, sizeof(String), "You are in the family that owns this %s.", GetVehicleName(newcar));
	    			SendClientMessageEx(playerid, COLOR_GREY, String);
				}
				else if(FamilyVehicleInfo[f][v][fvLocked] == 1 && FamilyVehicleInfo[f][v][fvLock] == 1)
				{
					GetVehicleParamsEx(newcar,engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(newcar,engine,lights,VEHICLE_PARAMS_ON,doors,bonnet,boot,objective);
					SetTimerEx("DisableVehicleAlarm", 20000, 0, "d",  newcar);
				}
				else if(FamilyVehicleInfo[f][v][fvLocked] == 1 && FamilyVehicleInfo[f][v][fvLock] == 2)
				{
		            new Float:X, Float:Y, Float:Z, Float:HP;
		            GetPlayerPos(playerid, X, Y, Z);
		            SendAudioToRange(10300, 100, 0, X, Y, Z, 20.0);
		            AC_BS_SetPlayerPos(playerid, X + 1, Y, Z);
		            RemovePlayerFromVehicle(playerid);
		            new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					AC_BS_SetPlayerPos(playerid, slx, sly, slz);
					SetPVarInt(playerid, "IsFrozen", 1);
		            TogglePlayerControllable(playerid,0);
		            SetTimerEx("ReleasePlayer", 10000, 0, "d", playerid);
		            GameTextForPlayer(playerid,"~r~STUNNED!",11000,3);
		            GetPlayerHealth(playerid,HP);
		            AC_BS_SetPlayerHealth(playerid,HP-15);
		            PlayerInfo[playerid][pHealth] -= 15.0;
				}
				return 1;
			}
		}
		if(PlayerInfo[playerid][pCarLic] == 0)
		{
			SendClientMessage(playerid, COLOR_ORANGE, "Berhati-hatilah karena anda tidak memiliki SIM");
		}
		new vehicleid = newcar;
		if(IsAnSASDCar(vehicleid))
		{
		    if(PlayerInfo[playerid][pMember] == 7 || PlayerInfo[playerid][pLeader] == 7)
			{
			}
		    else
			{
			    RemovePlayerFromVehicle(playerid);
			    NOPCheck(playerid);
			    SendClientMessage(playerid, COLOR_GREY, "Anda bukan bagian dari SASD.");
			}
		}
		if(IsDMVCar(vehicleid))
		{
		    if(LicenseTest[playerid] < 1)
		    {
                RemovePlayerFromVehicle(playerid);
		        SendClientMessage(playerid, COLOR_ORANGE, "Anda belum mengambil tes mengemudi.");
		    }
		    if(LicenseTest[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* GPS: Selesaikan tes dengan mengikuti tanda di GPS anda.");
		        CPD[playerid] = 1;
		        SetPlayerRaceCheckpoint(playerid, 0, 2040.7101,-1930.1340,13.4667,1972.9482, -1929.8557, 12.5739,5);
		        SendClientMessage(playerid, COLOR_RED, "Jika anda keluar dari kendaraan Tes, Tes anda akan otomatis gagal.");
		    }
		}
		else if(IsAnSFPDCar(vehicleid))
		{
		    if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLeader] == 3)
			{
			}
		    else
			{
			    RemovePlayerFromVehicle(playerid);
			    NOPCheck(playerid);
			    SendClientMessage(playerid, COLOR_GREY, "Anda bukan bagian dari SFPD.");
			}
		}
		else if(IsAnSanNewsCar(vehicleid))
		{
		    if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLeader] == 9)
			{
			}
		    else
			{
			    RemovePlayerFromVehicle(playerid);
			    NOPCheck(playerid);
			    SendClientMessage(playerid, COLOR_GREY, "Anda bukan bagian dari 'San Andreas Network'.");
			}
		}
		else if(IsAGovCar(vehicleid))
		{
		    if(PlayerInfo[playerid][pMember] == 6)
			{
			}
		    else
			{
			    RemovePlayerFromVehicle(playerid);
			    NOPCheck(playerid);
			    SendClientMessage(playerid, COLOR_GREY, "Anda bukan bagian dari 'San Andreas Goverment Service'.");
			}
		}
		else if(IsACopCar(vehicleid))
		{
		    if(PlayerInfo[playerid][pMember] == 1||PlayerInfo[playerid][pLeader] == 1)
			{
			}
		    else
			{
			    RemovePlayerFromVehicle(playerid);
			    NOPCheck(playerid);
			    SendClientMessage(playerid, COLOR_GREY, "Anda bukan bagian dari 'San Andreas Police Department'.");
			}
		}
		else if(IsAnAmbulance(vehicleid))
		{
		    if(PlayerInfo[playerid][pMember] == 4||PlayerInfo[playerid][pLeader] == 4)
			{
			}
		    else
			{
			    RemovePlayerFromVehicle(playerid);
			    NOPCheck(playerid);
			    SendClientMessage(playerid, COLOR_GREY, "Anda bukan bagian dari San Andreas Medical Department.");
			}
		}
	   	else if(IsAPlane(vehicleid))
		{
	  		if(PlayerInfo[playerid][pFlyLic] != 1)
	  		{
		  		RemovePlayerFromVehicle(playerid);
		  		NOPCheck(playerid);
		  		SendClientMessage(playerid, COLOR_GREY, "Kamu tidak memiliki izin terbang.");
	  		}
		}
		else if(IsAHelicopter(vehicleid))
		{
		    if(PlayerInfo[playerid][pFlyLic] != 1)
		    {
		    RemovePlayerFromVehicle(playerid);
			NOPCheck(playerid);
			SendClientMessage(playerid, COLOR_GREY, "Kamu tidak memiliki izin terbang.");
			}
		}
	    else if(IsSWEEPERCar(vehicleid))
		{
		    new String[10000], S3MP4K[10000];
		    if(PlayerInfo[playerid][pSweeperT] == 0)
			{
		    	strcat(S3MP4K, "Route\tPrice\n");
				format(String, sizeof(String), "Route A: Idlewood - Commerce\t%s\n", (DialogSweeper[0] == true) ? ("{FF0000}Cleaning") : ("{33AA33}$25.00"));
				strcat(S3MP4K, String);
				format(String, sizeof(String), "Route B: Pershing Square - Commerce\t%s\n", (DialogSweeper[1] == true) ? ("{FF0000}Cleaning") : ("{33AA33}$35.00"));
				strcat(S3MP4K, String);
				format(String, sizeof(String), "Route C: Commerce - Marina\t%s\n", (DialogSweeper[2] == true) ? ("{FF0000}Cleaning") : ("{33AA33}$75.00"));
				strcat(S3MP4K, String);
				ShowPlayerDialog(playerid, SWEEPERJOB, DIALOG_STYLE_TABLIST_HEADERS, "Sweeper Sidejob", S3MP4K, "Select", "Cancel");
			}
			else
			{
			    format(String, sizeof(String),"ERROR: Kamu harus menunggu %d Menit untuk menjadi Street Sweeper", PlayerInfo[playerid][pSweeperT]/60);
			    SendClientMessage(playerid, COLOR_GRAD2, String);
				RemovePlayerFromVehicle(playerid);
		 	}
		}
		else if(IsBUSCAR(vehicleid))
		{
		    new String[10000], S3MP4K[10000];
		    if(PlayerInfo[playerid][pBusTime] == 0)
			{
		    	strcat(S3MP4K, "Route\tPrice\n");
				format(String, sizeof(String), "Route A: Commerce - Ocean Dock\t%s\n", (DialogBus[0] == true) ? ("{FF0000}Taken") : ("{33AA33}$100.00"));
				strcat(S3MP4K, String);
				format(String, sizeof(String), "Route B: Commerce - Los Santos Bank\t%s\n", (DialogBus[1] == true) ? ("{FF0000}Taken") : ("{33AA33}$100.00"));
				strcat(S3MP4K, String);
				format(String, sizeof(String), "Route C: Commerce - East Los Santos\t{FF0000}Maintenance");
				strcat(S3MP4K, String);
				ShowPlayerDialog(playerid, BUSJOB, DIALOG_STYLE_TABLIST_HEADERS, "Bus Driver Sidejob", S3MP4K, "Select", "Cancel");
			}
			else
			{
			    format(String, sizeof(String),"ERROR: Kamu harus menunggu %d Menit untuk menjadi Bus Driver", PlayerInfo[playerid][pBusTime]/60);
			    SendClientMessage(playerid, COLOR_GRAD2, String);
				RemovePlayerFromVehicle(playerid);
		 	}
		}
	    else if(IsDMVCar(vehicleid))
		{
		    if(LicenseTest[playerid] < 1)
		    {
                RemovePlayerFromVehicle(playerid);
		        SendClientMessage(playerid, COLOR_ORANGE, "Anda belum mengambil tes mengemudi.");
		    }
		}
	    if( GetPVarInt( playerid, "ToBeEjected" ) >= 1 )
    	{
	       	SetPVarInt( playerid, "ToBeEjected", 0 );
	       	RemovePlayerFromVehicle( playerid );
	       	new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			AC_BS_SetPlayerPos(playerid, X, Y, Z+2);

			if(GetPVarInt(playerid, "Injured") == 1)
  			{
  			    Streamer_UpdateEx(playerid, GetPVarFloat(playerid,"MedicX"), GetPVarFloat(playerid,"MedicY"), GetPVarFloat(playerid,"MedicZ"));
		   		AC_BS_SetPlayerPos(playerid, GetPVarFloat(playerid,"MedicX"), GetPVarFloat(playerid,"MedicY"), GetPVarFloat(playerid,"MedicZ"));
				AC_BS_SetPlayerVirtualWorld(playerid, GetPVarInt(playerid,"MedicVW"));
				AC_BS_SetPlayerInterior(playerid, GetPVarInt(playerid,"MedicInt"));
   				ClearAnimations(playerid);
				ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0, 0, 1, 1, 1, 0, 1);
				TogglePlayerControllable(playerid, 0);
   			}
   		}
		TelePos[playerid][0] = 0.0;
		TelePos[playerid][1] = 0.0;
		/*if(GetCarDealershipVehicleId(newcar) != -1 && GetCarDealershipVehicleId(newcar) == GetPVarInt(playerid, "editingcdveh")) return 1;
        if(GetCarDealershipVehicleId(newcar) != -1)
        {
			new string[57 + 20 + 4];
			format(string, sizeof(string),"Would you like to buy this {00FF00}%s?\n\nThis vehicle costs {00FFFF}$%s.", GetVehicleName(newcar), FormatMoney(CarDealershipInfo[GetCarDealershipId(newcar)][cdVehicleCost][GetCarDealershipVehicleId(newcar)]));
		    ShowPlayerDialog(playerid,DIALOG_CDBUY,DIALOG_STYLE_MSGBOX,"Warning:",string,"Buy","Cancel");
		    TogglePlayerControllable(playerid, false);
		    return 1;
        }*/
        //DEALER
		if(GetCarDealershipVehicleId(newcar) != -1 && GetCarDealershipVehicleId(newcar) == GetPVarInt(playerid, "editingcdveh")) return 1;
        if(GetCarDealershipVehicleId(newcar) != -1)
        {
			new string[57 + 20 + 4];
			format(string, sizeof(string),"Would you like to buy this {00FF00}%s?\n\nThis vehicle costs {00FFFF}%s.", GetVehicleName(newcar), FormatMoney(CarDealershipInfo[GetCarDealershipId(newcar)][cdVehicleCost][GetCarDealershipVehicleId(newcar)]));
		    ShowPlayerDialog(playerid,DIALOG_CDBUY,DIALOG_STYLE_MSGBOX,"Warning:",string,"Buy","Cancel");
		    TogglePlayerControllable(playerid, false);
		    return 1;
        }
		GetVehicleParamsEx(newcar,engine,lights,alarm,doors,bonnet,boot,objective);
		if((engine == VEHICLE_PARAMS_UNSET || engine == VEHICLE_PARAMS_OFF) && GetVehicleModel(newcar) != 509 && GetVehicleModel(newcar) != 481 && GetVehicleModel(newcar) != 510) {
		}
		else
		{
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 481 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 509 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 510)
			{
				SetPVarInt(playerid, "fuelonoff", 1);
			}
		}
	}
	if((newstate == 2 || newstate == 3 || newstate == 7 || newstate == 9) && pTazer[playerid] == 1)
	{
		givePlayerValidWeapon(playerid, pTazerReplace[playerid], 100);
		pTazer[playerid] = 0;
	}
	if(newstate == PLAYER_STATE_SPAWNED)
	{
		if(ConnectedToPC[playerid] == 1337)//mdc
	    {
	        ConnectedToPC[playerid] = 0;
		}
		TelePos[playerid][0] = 0.0;
		TelePos[playerid][1] = 0.0;
		gPlayerSpawned[playerid] = 1;
		SafeTime[playerid] = 60;
	}
	if(newstate == PLAYER_STATE_PASSENGER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 519)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(VehicleStatus{vehicleid} == 1) return SendClientMessageEx(playerid, COLOR_WHITE, "You are not allowed to enter this Shamal as it's been damaged!");
   		AC_BS_SetPlayerPos(playerid, 2.509036, 23.118730, 1199.593750);
     	SetPlayerFacingAngle(playerid, 82.14);
        SetCameraBehindPlayer(playerid);
		PlayerInfo[playerid][pVW] = vehicleid;
		AC_BS_SetPlayerVirtualWorld(playerid, vehicleid);
		PlayerInfo[playerid][pInt] = 0;
        AC_BS_SetPlayerInterior(playerid, 1);
		InsideShamal[playerid] = vehicleid;
		SendClientMessageEx(playerid, COLOR_WHITE, "Type /exit near the door to exit the vehicle, or /window to look outside.");
	}
	IsPlayerSteppingInVehicle[playerid] = -1;
	return 1;
}

player_remove_vip_toys(iTargetID) {
	if(PlayerInfo[iTargetID][pDonateRank] >= 3) return 1;
	else for(new iToyIter; iToyIter < MAX_PLAYER_ATTACHED_OBJECTS; ++iToyIter) {
		for(new LoopRapist; LoopRapist < sizeof(HoldingObjectsCop); ++LoopRapist) {
			if(HoldingObjectsCop[LoopRapist][holdingmodelid] == PlayerToyInfo[iTargetID][iToyIter][ptModelID]) {
				PlayerToyInfo[iTargetID][iToyIter][ptModelID] = 0;
				PlayerToyInfo[iTargetID][iToyIter][ptBone] = 0;
				PlayerToyInfo[iTargetID][iToyIter][ptPosX] = 0.0;
				PlayerToyInfo[iTargetID][iToyIter][ptPosY] = 0.0;
				PlayerToyInfo[iTargetID][iToyIter][ptPosZ] = 0.0;
				PlayerToyInfo[iTargetID][iToyIter][ptPosX] = 0.0;
				PlayerToyInfo[iTargetID][iToyIter][ptPosY] = 0.0;
				PlayerToyInfo[iTargetID][iToyIter][ptPosZ] = 0.0;
				if(IsPlayerAttachedObjectSlotUsed(iTargetID, iToyIter)) RemovePlayerAttachedObject(iTargetID, iToyIter);
			}
		}
	}
	SendClientMessageEx(iTargetID, COLOR_WHITE, "All accessories/toys that were property of your former employer have been removed.");
	return 1;
}

public CarInit()
{
	for(new f = 1; f < MAX_VEHICLES; f++)
	{
 		gLastDriver[f] = MAX_VEHICLES+1;
 		LinkVehicleToInterior(f, 0);
	}
	gLastDriver[MAX_PLAYERS]=INVALID_PLAYER_ID;
	return 1;
}

public CarRespawn(carid)
{
	foreach(Player, i)
	{
		if(IsPlayerInVehicle(i, carid) || HireCar[i] == carid)
		{
			gLastDriver[carid] = INVALID_PLAYER_ID;
			return 0;
		}
	}
	SetVehicleToRespawn(carid);
	gLastDriver[carid] = INVALID_PLAYER_ID;
	return 1;
}

vehicle_lock_doors(vehicle) {

	new
		vParamArr[7];

	GetVehicleParamsEx(vehicle, vParamArr[0], vParamArr[1], vParamArr[2], vParamArr[3], vParamArr[4], vParamArr[5], vParamArr[6]);
	return SetVehicleParamsEx(vehicle, vParamArr[0], vParamArr[1], vParamArr[2], VEHICLE_PARAMS_ON, vParamArr[4], vParamArr[5], vParamArr[6]);
}

vehicle_unlock_doors(vehicle) {

	new
		vParamArr[7];

	GetVehicleParamsEx(vehicle, vParamArr[0], vParamArr[1], vParamArr[2], vParamArr[3], vParamArr[4], vParamArr[5], vParamArr[6]);
	return SetVehicleParamsEx(vehicle, vParamArr[0], vParamArr[1], vParamArr[2], VEHICLE_PARAMS_OFF, vParamArr[4], vParamArr[5], vParamArr[6]);
}

stock IsSeatAvailable(vehicleid, seat)
{
	new carmodel = GetVehicleModel(vehicleid);
	for (new i = 0; i < sizeof( OneSeatVehicles ); i++ )
	{
	    if( carmodel == OneSeatVehicles[i] ) return 0;
	}
	foreach(Player, i)
	{
	    if(GetPlayerVehicleID(i) == vehicleid && GetPlayerVehicleSeat(i) == seat) return 0;
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	for(new d = 0 ; d < MAX_PLAYERVEHICLES; d++)
	{
	    if(!IsPlayerInVehicle(playerid, PlayerVehicleInfo[playerid][d][pvId]))
	    {
			new Float:x, Float:y, Float:z, Float:angle, Float:health;
			GetVehicleHealth(PlayerVehicleInfo[playerid][d][pvId], health);
//			if(health < 800) return SendClientMessageEx(playerid, COLOR_GREY, " Your vehicle is too damaged to park it.");
			if(PlayerInfo[playerid][pLockCar] == GetPlayerVehicleID(playerid)) PlayerInfo[playerid][pLockCar] = INVALID_VEHICLE_ID;
			GetVehiclePos(PlayerVehicleInfo[playerid][d][pvId], x, y, z);
			GetVehicleZAngle(PlayerVehicleInfo[playerid][d][pvId], angle);
			PlayerVehicleInfo[playerid][d][pvPosX] = x;
			PlayerVehicleInfo[playerid][d][pvPosY] = y;
			PlayerVehicleInfo[playerid][d][pvPosZ] = z;
			PlayerVehicleInfo[playerid][d][pvPosAngle] = angle;
			PlayerVehicleInfo[playerid][d][pvHealth] = health;
		}
	}
	if (GetPlayerState(playerid) == 1)
	{
		return 1;
	}
	if (GetVehicleModel(vehicleid) == 574)
	{
	    if(KerjaSweeper[playerid] != 0)
	    {
	        SendClientMessageEx(playerid,COLOR_LIGHTBLUE,"Kamu telah berhenti bekerja, kamu dapat bekerja Street Sweeper 30 menit lagi.");
			KerjaSweeper[playerid] = 0;
			for(new i = 0; i < 3; i++)
			{
				SweeperSteps[playerid][i] = 0;
			}
			DisablePlayerRaceCheckpoint(playerid);
			PlayerInfo[playerid][pSweeperT] = 1800;
	    }
		return 1;
	}
	if (GetVehicleModel(vehicleid) == 431)
	{
	    if(KerjaBus[playerid] != 0)
	    {
	        SendClientMessageEx(playerid,COLOR_LIGHTBLUE,"Kamu telah berhenti bekerja, kamu dapat bekerja sebagai Bus Driver 30 menit lagi.");
			KerjaSweeper[playerid] = 0;
			for(new i = 0; i < 3; i++)
			{
				BusSteps[playerid][i] = 0;
			}
			DisablePlayerRaceCheckpoint(playerid);
			PlayerInfo[playerid][pSweeperT] = 1800;
	    }
		return 1;
	}
	// Seatbelt Check
	switch(Seatbelt[playerid])
	{
		case 1:
		{
			if(IsABike(vehicleid))
			{
				SendClientMessageEx(playerid, COLOR_WHITE, "Anda telah melepaskan helm anda.");
			}
			else
			{
				SendClientMessageEx(playerid, COLOR_WHITE, "Anda telah melepaskan sabuk pengaman.");
			}
			Seatbelt[playerid] = 0;
		}
	}

	if(GetPVarInt(playerid, "rccam") == 1)
	{
		DestroyVehicle(GetPVarInt(playerid, "rcveh"));
		AC_BS_SetPlayerPos(playerid, GetPVarFloat(playerid, "rcX"), GetPVarFloat(playerid, "rcY"), GetPVarFloat(playerid, "rcZ"));
		DeletePVar(playerid, "rccam");
		KillTimer(GetPVarInt(playerid, "rccamtimer"));
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    if(IsPlayerNPC(playerid)) return 1;
	return 1;
}
public simpenmaxlimit()
{
    SaveMaxLimit();
}
public SetPlayerCriminal(playerid,declare,reason[])
{
	if(IsPlayerConnected(playerid))
	{
	    PlayerInfo[playerid][pCrimes] += 1;
	    new points = WantedPoints[playerid];
		new turned[MAX_PLAYER_NAME];
		new turner[MAX_PLAYER_NAME];
		new turnmes[128];
		new wantedmes[128];
		new wlevel;
		strmid(PlayerCrime[playerid][pAccusedof], reason, 0, strlen(reason), 255);
		GetPlayerName(playerid, turned, sizeof(turned));
		if (declare == INVALID_PLAYER_ID)
		{
			format(turner, sizeof(turner), "Unknown");
			strmid(PlayerCrime[playerid][pVictim], turner, 0, strlen(turner), 255);
		}
		if (declare == -5)
		{
		    format(turner, sizeof(turner), "MPS Lot Officer.");
			strmid(PlayerCrime[playerid][pVictim], turner, 0, strlen(turner), 255);
		}
		else
		{
		    if(IsPlayerConnected(declare))
		    {
				GetPlayerName(declare, turner, sizeof(turner));
				strmid(PlayerCrime[playerid][pVictim], turner, 0, strlen(turner), 255);
				strmid(PlayerCrime[declare][pBplayer], turned, 0, strlen(turned), 255);
				strmid(PlayerCrime[declare][pAccusing], reason, 0, strlen(reason), 255);
			}
		}
		format(turnmes, sizeof(turnmes), "You've commited a Crime ( %s ). Reporter: %s.",reason,turner);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, turnmes);
		if(points > 0)
		{
		    new yesno;
			if(points == 1) { if(PlayerInfo[playerid][pWantedLevel] != 1) { PlayerInfo[playerid][pWantedLevel] = 1; wlevel = 1; yesno = 1;} }
			else if(points == 2) { if(PlayerInfo[playerid][pWantedLevel] != 2) { PlayerInfo[playerid][pWantedLevel] = 2; wlevel = 2; yesno = 1;} }
			else if(points == 3) { if(PlayerInfo[playerid][pWantedLevel] != 3) { PlayerInfo[playerid][pWantedLevel] = 3; wlevel = 3; yesno = 1;} }
			else if(points == 4) { if(PlayerInfo[playerid][pWantedLevel] != 4) { PlayerInfo[playerid][pWantedLevel] = 4; wlevel = 4; yesno = 1;} }
			else if(points == 5) { if(PlayerInfo[playerid][pWantedLevel] != 5) { PlayerInfo[playerid][pWantedLevel] = 5; wlevel = 5; yesno = 1;} }
			else if(points == 6) { if(PlayerInfo[playerid][pWantedLevel] != 6) { PlayerInfo[playerid][pWantedLevel] = 6; wlevel = 6; yesno = 1;} }
			if(PlayerInfo[playerid][pWantedLevel] >= 1) { if(gTeam[playerid] == 3) { gTeam[playerid] = 4; } }
			if(yesno)
			{
				format(wantedmes, sizeof(wantedmes), "Current wanted level: %d", wlevel);
				SendClientMessageEx(playerid, COLOR_YELLOW, wantedmes);
				foreach(Player, i)
				{
				    if(PlayerInfo[i][pMember] == 3||PlayerInfo[i][pLeader] == 3||PlayerInfo[i][pMember] == 1||PlayerInfo[i][pLeader] == 1||PlayerInfo[i][pMember] == 2||PlayerInfo[i][pLeader] == 2|| (PlayerInfo[i][pMember] == 4||PlayerInfo[i][pLeader] == 4&&PlayerInfo[i][pDivision] == 2)||PlayerInfo[i][pMember] == 7||PlayerInfo[i][pLeader] == 7 || PlayerInfo[i][pMember] == 11 || PlayerInfo[i][pLeader] == 11)
				    {
						format(cbjstore, sizeof(turnmes), "HQ: All Units APB: Reporter: %s",GetPlayerNameEx(declare));
						SendClientMessageEx(i, TEAM_BLUE_COLOR, cbjstore);
						format(cbjstore, sizeof(turnmes), "HQ: Crime: %s, Suspect: %s",reason,GetPlayerNameEx(playerid));
						SendClientMessageEx(i, TEAM_BLUE_COLOR, cbjstore);
					}
				}
			}
		}
	}//not connected
}
//---------------------------------------------------------

public SetPlayerFree(playerid,declare,reason[])
{
	if(IsPlayerConnected(playerid))
	{
		ClearCrime(playerid);
		new turned[MAX_PLAYER_NAME];
		new turner[MAX_PLAYER_NAME];
		new crbjstore[128];
		if (declare == INVALID_PLAYER_ID)
		{
			format(turner, sizeof(turner), "911");
		}
		else
		{
			if(IsPlayerConnected(declare))
			{
				GetPlayerName(declare, turner, sizeof(turner));
			}
		}
		GetPlayerName(playerid, turned, sizeof(turned));
		RingTone[playerid] = 20;
		foreach(Player, i)
		{
			if(IsACop(i))
			{
				format(crbjstore, sizeof(crbjstore), "HQ: All units, officer %s has completed their assignment.",turner);
				SendClientMessageEx(i, COLOR_DBLUE, crbjstore);
				format(crbjstore, sizeof(crbjstore), "HQ: %s has been processed, %s.",turned,reason);
				SendClientMessageEx(i, COLOR_DBLUE, crbjstore);
			}
		}
	}
}

forward RingToner();
public RingToner()
{
	foreach(Player, i)
	{
		if(RingTone[i] != 6 && RingTone[i] != 0 && RingTone[i] < 11)
		{
			RingTone[i] = RingTone[i] -1;
			PlayerPlaySound(i, 1138, 0.0, 0.0, 0.0);
		}
		if(RingTone[i] == 6)
		{
			RingTone[i] = RingTone[i] -1;
		}
		if(RingTone[i] == 20)
		{
			RingTone[i] = RingTone[i] -1;
			PlayerPlaySound(i, 1139, 0.0, 0.0, 0.0);
		}
	}
	SetTimer("RingTonerRev", 1000, 0);
	return 1;
}

forward RingTonerRev();
public RingTonerRev()
{
	foreach(Player, i)
	{
			if(RingTone[i] != 5 && RingTone[i] != 0 && RingTone[i] < 10)
			{
				RingTone[i] = RingTone[i] -1;
				PlayerPlaySound(i, 1137, 0.0, 0.0, 0.0);
			}
			if(RingTone[i] == 5)
			{
				RingTone[i] = RingTone[i] -1;
			}
			if(RingTone[i] == 19)
			{
				PlayerPlaySound(i, 1139, 0.0, 0.0, 0.0);
				RingTone[i] = 0;
			}
	}
	SetTimer("RingToner", 1000, 0);
	return 1;
}

forward OtherTimerEx(playerid, type);
public OtherTimerEx(playerid, type)
{
	if(type == TYPE_TPMATRUNTIMER)
	{
    	if(GetPVarInt(playerid, "tpMatRunTimer") > 0)
		{
			SetPVarInt(playerid, "tpMatRunTimer", GetPVarInt(playerid, "tpMatRunTimer")-1);
			SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_TPMATRUNTIMER);
		}
	}
	else if(type == TYPE_TPDRUGRUNTIMER)
	{
    	if(GetPVarInt(playerid, "tpDrugRunTimer") > 0)
		{
			SetPVarInt(playerid, "tpDrugRunTimer", GetPVarInt(playerid, "tpDrugRunTimer")-1);
			SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_TPDRUGRUNTIMER);
		}
	}
	else if(type == TYPE_ARMSTIMER)
	{
	    if(GetPVarInt(playerid, "ArmsTimer") > 0)
		{
			SetPVarInt(playerid, "ArmsTimer", GetPVarInt(playerid, "ArmsTimer")-1);
			SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_ARMSTIMER);
		}
	}
	else if(type == TYPE_GUARDTIMER)
	{
	    if(GetPVarInt(playerid, "GuardTimer") > 0)
	    {
	        SetPVarInt(playerid, "GuardTimer", GetPVarInt(playerid, "GuardTimer")-1);
	        SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_GUARDTIMER);
	    }
	}
	else if(type == TYPE_GIVEWEAPONTIMER)
	{
	    if(GetPVarInt(playerid, "GiveWeaponTimer") > 0)
		{
			SetPVarInt(playerid, "GiveWeaponTimer", GetPVarInt(playerid, "GiveWeaponTimer")-1);
			SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_GIVEWEAPONTIMER);
		}
	}
	else if(type == TYPE_SELLMATSTIMER)
	{
	    if(GetPVarInt(playerid, "SellMatsTimer") > 0)
		{
			SetPVarInt(playerid, "SellMatsTimer", GetPVarInt(playerid, "SellMatsTimer")-1);
			SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_SELLMATSTIMER);
		}
	}
	else if(type == TYPE_HOSPITALTIMER)
	{
	    if(GetPVarInt(playerid, "HospitalTimer") > 0)
		{
		    new Float:curhealth;
			GetPlayerHealth(playerid, curhealth);
			SetPVarInt(playerid, "HospitalTimer", GetPVarInt(playerid, "HospitalTimer")-1);
			AC_BS_SetPlayerHealth(playerid, curhealth+2);
			PlayerInfo[playerid][pHealth] += 2.0;
			SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_HOSPITALTIMER);
			if(GetPVarInt(playerid, "HospitalTimer") == 0)
			{
				HospitalSpawn(playerid);
			}
		}
	}
	else if(type == TYPE_FLOODPROTECTION)
	{
 		if( CommandSpamUnmute[playerid] >= 1)
 		{
  			CommandSpamUnmute[playerid]--;
  			SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_FLOODPROTECTION);
    	}
 		if( TextSpamUnmute[playerid] >= 1)
 		{
  			TextSpamUnmute[playerid]--;
  			SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_FLOODPROTECTION);
    	}
	}
	else if(type == TYPE_HEALTIMER)
	{
	    if( GetPVarInt(playerid, "TriageTimer") >= 1)
 		{
  			SetPVarInt(playerid, "TriageTimer", GetPVarInt(playerid, "TriageTimer")-1);
  			SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_HEALTIMER);
    	}
	}
}

public SetPlayerWeapons(playerid)
{
    if(GetPVarInt(playerid, "IsInArena") >= 0) { return 1; }
	//ResetPlayerWeapons(playerid);
	for(new s = 0; s < 12; s++)
	{
		if(PlayerInfo[playerid][pGuns][s] > 0)
		{
			givePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][s], PlayerInfo[playerid][pGunsAmmo][s]);
		}
	}
	return 1;
}

public SetPlayerWeaponsEx(playerid)
{
	//ResetPlayerWeapons(playerid);
	for(new s = 0; s < 12; s++)
	{
		if(PlayerInfo[playerid][pGuns][s] > 0)
		{
			givePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][s], PlayerInfo[playerid][pAGuns][s]);
		}
	}
}

ShowStats(playerid, targetid)
{
	if(IsPlayerConnected(targetid)) {
		new sext[16], employer[64], rank[64], division[64], jtext[20], jtext2[20], ijtext[20], pnumber[20], facfam[20];
		if(PlayerInfo[targetid][pPnumber] == 0) pnumber = "None"; else format(pnumber, sizeof(pnumber), "%d", PlayerInfo[targetid][pPnumber]);
		if(PlayerInfo[targetid][pSex] == 1) { sext = "Male"; } else { sext = "Female"; }
		facfam = "Faction";
		if(PlayerInfo[targetid][pFMember] < 255)
		{
		    facfam = "Family"; division = "None";
			format(employer, sizeof(employer), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyName]);
			switch(PlayerInfo[targetid][pRank])
			{
				case 1: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank1]);
				case 2: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank2]);
				case 3: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank3]);
				case 4: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank4]);
				case 5: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank5]);
	  			case 6: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank6]);
				default: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank1]);
			}
		}
		else GetPlayerFactionInfo(targetid, rank, division, employer);
		switch(PlayerInfo[targetid][pJob])
		{
			case 7: jtext = "Mechanic";
			case 8: jtext = "Lumberjack";
			case 20: jtext = "Trucker";
			case 1401: jtext = "Farmer";
			default: jtext = "None";
		}
		switch(PlayerInfo[targetid][pJob2])
		{
			case 7: jtext2 = "Mechanic";
			case 8: jtext2 = "Lumberjack";
			case 20: jtext2 = "Trucker";
			case 1401: jtext2 = "Farmer";
			default: jtext2 = "None";
		}
		switch(PlayerInfo[targetid][pIllegalJob])
		{
			case 1: ijtext = "Arms Dealer";
			case 2: ijtext = "Drug Dealer";
			default: ijtext = "None";
		}
		new drank[32];
		switch(PlayerInfo[targetid][pDonateRank])
		{
			case 1: drank = "Basic Donator";
			case 2: drank = "Advanced Donator";
			case 3: drank = "Professional Donator";
			case 4: drank = "Lifetime Donator";
			default: drank = "{00FF00}None{FFFFFF}";
		}
		new married[20];
		strmid(married, PlayerInfo[targetid][pMarriedTo], 0, strlen(PlayerInfo[targetid][pMarriedTo]), 255);
		new ptime = PlayerInfo[targetid][pConnectTime];
		new housekey = PlayerInfo[targetid][pPhousekey];
		new bizkey = PlayerInfo[targetid][pPBiskey];
		new workshop = PlayerInfo[targetid][pWSid];
		new warns = PlayerInfo[targetid][pWarns];
		new farm = PlayerInfo[targetid][pFarmid];
		new dealership = -1;
		for(new d = 0 ; d < MAX_CARDEALERSHIPS; d++)
		{
            if(IsPlayerOwnerOfCDEx(targetid, d))
			{
				dealership = d;
                break;
	        }
	    }
		//new dealership = CarDealershipInfo[targetid][cdOwner];
		new coordsString[10000], S3MP4K[10000], idiot[1401];
		format(idiot, sizeof(idiot), "{FFFFFF}Statistic {00CCFF}%s", PlayerInfo[targetid][pNormalName]);
		//SendClientMessageEx(playerid,COLOR_WHITE,coordsString);
		format(coordsString, sizeof(coordsString), "{F7FF00}IC Information:\n");
		strcat(S3MP4K, coordsString);
		//SendClientMessageEx(playerid, 0xFFFF00FF,coordsString);
		format(coordsString, sizeof(coordsString), "{FFFFFF}Origin: [{C6E2FF}%s{FFFFFF}] Gender: [{C6E2FF}%s{FFFFFF}] Married with: [%s] Bank: [{00FF00}$%s{FFFFFF}] Phone number: [{C6E2FF}%s{FFFFFF}] Phone credit: [{C6E2FF}%d Point{FFFFFF}]\n",PlayerInfo[targetid][pAge], sext, married, FormatMoney(PlayerInfo[targetid][pAccount]), pnumber,PlayerInfo[targetid][pPulsa2]);
        strcat(S3MP4K, coordsString);
		//SendClientMessageEx(playerid, 0xFFFFFFAA,coordsString);
		format(coordsString, sizeof(coordsString), "Money: [{00FF00}$%s{FFFFFF}] Job: [{C6E2FF}%s{FFFFFF}, {C6E2FF}%s{FFFFFF}, {FF0000}%s{FFFFFF}] JobSalary: [{00FF00}$%s{FFFFFF}] %s: [%s] Rank : [%s]\n", FormatMoney(GetPlayerCash(targetid)), jtext, jtext2, ijtext, FormatMoney(PlayerInfo[targetid][pPayCheck]), facfam, employer, rank);
        strcat(S3MP4K, coordsString);
		//SendClientMessageEx(playerid, 0xFFFFFFAA,coordsString);
		format(coordsString, sizeof(coordsString), "{F7FF00}OOC Information:\n");
        strcat(S3MP4K, coordsString);
		//SendClientMessageEx(playerid, 0xFFFF00FF,coordsString);
		format(coordsString, sizeof(coordsString), "{FFFFFF}Player rank: [{C6E2FF}%s{FFFFFF}] Warns: [{FF0000}%d{FFFFFF}/20] Paycheck: [{C6E2FF}%d{FFFFFF}]\n",ORANK(targetid),warns,ptime);
        strcat(S3MP4K, coordsString);
		//SendClientMessageEx(playerid, 0xFFFFFFAA,coordsString);
		format(coordsString, sizeof(coordsString), "Donator rank: [{00FF00}%s{FFFFFF}] Expired: [{FF0000}%s{FFFFFF}] JailTime: [{FF0000}%d {FFFFFF}Minutes]\n", drank, PlayerInfo[targetid][pVIPExpDate],PlayerInfo[targetid][pJailTime]/60);
        strcat(S3MP4K, coordsString);
		//SendClientMessageEx(playerid, 0xFFFFFFAA,coordsString);
		format(coordsString, sizeof(coordsString), "WID: [{C6E2FF}%d{FFFFFF}] IID: [{C6E2FF}%d{FFFFFF}] HP: [{ff0000}%.1f{FFFFFF}] AP: [%.1f]\n",PlayerInfo[targetid][pVW],PlayerInfo[targetid][pInt], PlayerInfo[targetid][pHealth], PlayerInfo[targetid][pArmor]);
        strcat(S3MP4K, coordsString);
        format(coordsString, sizeof(coordsString), "House: [{FF0000}%d{FFFFFF}] Business: [{FF0000}%d{FFFFFF}] Workshop: [{FF0000}%d{FFFFFF}] Farm: [{FF0000}%d{FFFFFF}] Dealer: [{FF0000}%d{FFFFFF}]",housekey,bizkey,workshop,farm,dealership);
        strcat(S3MP4K, coordsString);
		//SendClientMessageEx(playerid, 0xFFFFFFAA,coordsString);
		ShowPlayerDialog(playerid, DIALOG_INVENTORY, DIALOG_STYLE_MSGBOX, idiot,S3MP4K,"Close","");
	}
}

//---------------------------------------------------------

SetPlayerToTeamColor(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pJailed] == 2)
    	{
   			SetPlayerColor(playerid,TEAM_HIT_COLOR);
   			return 1;
		}
		else if(PlayerInfo[playerid][pJailed] == 4)
  		{
    		SetPlayerColor(playerid,TEAM_HIT_COLOR);
    		return 1;
		}
		else
		{
            SetPlayerColor(playerid,TEAM_HIT_COLOR);
		}
	    if(IsACop(playerid))
	    {
	        if(PlayerInfo[playerid][pDuty] == 1)
	        {
	            if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLeader] == 1)
	            {
	        		SetPlayerColor(playerid,TEAM_BLUE_COLOR);
				}
				else if(PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pLeader] == 2)
	            {
	        		SetPlayerColor(playerid,TEAM_FBI_COLOR);
				}
				else if(PlayerInfo[playerid][pMember] == 6 || PlayerInfo[playerid][pLeader] == 6)
				{
				    SetPlayerColor(playerid, COLOR_TWAQUA);
				}
				else if(PlayerInfo[playerid][pMember] == 7 || PlayerInfo[playerid][pLeader] == 7)
				{
				    SetPlayerColor(playerid, TEAM_SASD);
				}
				else if(PlayerInfo[playerid][pMember] == 11 || PlayerInfo[playerid][pLeader] == 11)
    			{
	        		SetPlayerColor(playerid,COLOR_NG);
				}
				else if(PlayerInfo[playerid][pMember] == 13 || PlayerInfo[playerid][pLeader] == 13)
    			{
	        		SetPlayerColor(playerid,COLOR_PMC);
				}
				else
				{
				    SetPlayerColor(playerid,TEAM_HIT_COLOR); // white
				}
			}
			else
			{
			    SetPlayerColor(playerid,TEAM_HIT_COLOR); // white
			}
		}
		else
		{
		    if((PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLeader] == 9) && PlayerInfo[playerid][pDuty] == 1)
	    	{
	    		SetPlayerColor(playerid,COLOR_NEWS);
			}
			else if((PlayerInfo[playerid][pMember] == 4 || PlayerInfo[playerid][pLeader] == 4) && PlayerInfo[playerid][pDuty] == 1)
			{
   				SetPlayerColor(playerid, TEAM_MED_COLOR);
			}
			else if((PlayerInfo[playerid][pMember] == 12 || PlayerInfo[playerid][pLeader] == 12) && PlayerInfo[playerid][pDuty] == 1)
			{
  				SetPlayerColor(playerid, COLOR_TR);
			}
			else
			{
			    SetPlayerColor(playerid,TEAM_HIT_COLOR); // white
   			}
			if(PlayerInfo[playerid][pWantedLevel] > 0)
		    {
				WantedPoints[playerid] = PlayerInfo[playerid][pWantedLevel];
			}
		}
	}
	return 1;
}
public OnGameModeExit()
{
    foreach(Player, i)
	{
 		OnPlayerStatsUpdate(i);
	}
    djson_OnGameModeExit();
    ServerLocked = false;
   	print("\n--------------------------------------");
	print("SERVER DIMATIKAN / DIRESTART");
	//Speedo
    for(new i=0; i<PLAYERS; i++)
    {
	   	TextDrawHideForPlayer(i, LBox[i]);
		TextDrawHideForPlayer(i, LLine1[i]);
		TextDrawHideForPlayer(i, LLine2[i]);
		TextDrawHideForPlayer(i, LLine3[i]);
		TextDrawHideForPlayer(i, LCredits[i]);
	}
	SaveATMs();
	SaveFarm();
	SaveObj();
	SaveBusinesses();
	SaveGates();
	SaveMod();
	SaveBuy();
	SaveGYMObject();
 //SavePlant();();
	SaveWorkshop();
	SaveRent();
	SaveHouses();
	SaveDynamicDoors();
	SaveDynamicMapIcons();
	SaveStock();
	SaveMaxLimit();
	SaveElevatorStuff();
	SaveServerStats();
	SaveFamilies();
	SaveFamiliesHQ();
 	SaveStuff();
	SaveServerStats();
	FMemberCounter(); // Family member counter (requested by game affairs to track gang activity)
	return 1;
}

public DoGMX()
{
	SendRconCommand("gmx");
	return 1;
}

public OnPlayerSuspectedForAimbot(playerid,hitid,weaponid,warnings)
{
	new str[144],nme[MAX_PLAYER_NAME],wname[32],Float:Wstats[BUSTAIM_WSTATS_SHOTS];

	ids[playerid]++;
	GetPlayerName(playerid,nme,sizeof(nme));
	GetWeaponName(weaponid,wname,sizeof(wname));
	if(warnings & WARNING_OUT_OF_RANGE_SHOT)
	{
	    format(str,256,"AIMWARNING: {ffffff}[%d]%s(%d) fired shots from a distance greater than the %s's fire range(Normal Range:%d)",ids[playerid],nme,playerid,wname,BustAim::GetNormalWeaponRange(weaponid));
		ABroadCast(COLOR_ARWIN, str, 1);
		BustAim::GetRangeStats(playerid,Wstats);
		format(str,256,"AIMWARNING: {ffffff}Shooter to Victim Distance(SA Units): 1)%f 2)%f 3)%f",Wstats[0],Wstats[1],Wstats[2]);
		ABroadCast(COLOR_ARWIN, str, 1);
	}
	if(warnings & WARNING_PROAIM_TELEPORT)
	{
	    format(str,256,"AIMWARNING: {ffffff}[%d]%s(%d) is using proaim (Teleport Detected)",ids[playerid],nme,playerid);
		ABroadCast(COLOR_ARWIN, str, 1);
		BustAim::GetTeleportStats(playerid,Wstats);
		format(str,256,"Bullet to Victim Distance(SA Units): 1)%f 2)%f 3)%f",Wstats[0],Wstats[1],Wstats[2]);
		ABroadCast(COLOR_ARWIN, str, 1);
	}
	if(warnings & WARNING_RANDOM_AIM)
	{
	    format(str,256,"AIMWARNING: {ffffff}[%d]%s(%d) is suspected to be using aimbot(Hit with Random Aim with %s)",ids[playerid],nme,playerid,wname);
		ABroadCast(COLOR_ARWIN, str, 1);
		BustAim::GetRandomAimStats(playerid,Wstats);
		format(str,256,"AIMWARNING: {ffffff}Random Aim Offsets: 1)%f 2)%f 3)%f",Wstats[0],Wstats[1],Wstats[2]);
		ABroadCast(COLOR_ARWIN, str, 1);
	}
	if(warnings & WARNING_CONTINOUS_SHOTS)
	{
	    format(str,256,"AIMWARNING: {ffffff}[%d]%s(%d) has fired 10 shots continously with %s(%d)",ids[playerid],nme,playerid,wname,weaponid);
		ABroadCast(COLOR_ARWIN, str, 1);
	}
	return 0;
}

LoadServerStats()
{
	#define SERVER_STATS "serverstat.ini"

	if(!fexist(SERVER_STATS)) return 1;

	new	File: i_FileHandle = fopen("serverstat.ini", io_read), sz_FileStr[256];

	fread(i_FileHandle, sz_FileStr);
	sscanf(sz_FileStr, "p<,>iiiiiiiiiii", TotalLogin, TotalConnect, TotalAutoBan, TotalRegister, MaxPlayersConnected, MPDay, MPMonth, MPYear, MPHour, MPMinute, TotalUptime);
	return fclose(i_FileHandle);
}

SaveServerStats()
{

	new sz_FileStr[256], File: i_FileHandle = fopen(SERVER_STATS, io_write);

	format(sz_FileStr, sizeof(sz_FileStr), "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d", TotalLogin, TotalConnect, TotalAutoBan, TotalRegister,MaxPlayersConnected,MPDay,MPMonth,MPYear,MPHour,MPMinute,TotalUptime);
	fwrite(i_FileHandle, sz_FileStr);

	#undef SERVER_STATS

	return fclose(i_FileHandle);
}
LoadStuff()
{
	new arrCoords[12][64];
	new strFromFile2[256];
	new File: file = fopen("stuff.ini", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		splits(strFromFile2, arrCoords, ',');
		Jackpot = strval(arrCoords[0]);
		if(Jackpot < 0)
		{
		    Jackpot = 0;
		}
		Tax = strval(arrCoords[1]);
		TaxValue = strval(arrCoords[2]);
		if(TaxValue < 0)
		{
		    TaxValue = 0;
		}
		Security = strval(arrCoords[3]);
		SpecTimer = strval(arrCoords[5]);
		fclose(file);
  		if(Security == 0 || Security == 1)
		{
		}
		else
		{
			GameModeExit();
		}
	}
	else
	{
		GameModeExit();
	}
	return 1;
}

LoadElevatorStuff()
{
	new arrCoords[40][64];
	new strFromFile2[256];
	new File: file = fopen("elevator.ini", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		splits(strFromFile2, arrCoords, ',');
		format(LAElevatorFloorName[0], 24, "%s", arrCoords[0]);
		format(LAElevatorFloorName[1], 24, "%s", arrCoords[1]);
		format(LAElevatorFloorName[2], 24, "%s", arrCoords[2]);
		format(LAElevatorFloorName[3], 24, "%s", arrCoords[3]);
		format(LAElevatorFloorName[4], 24, "%s", arrCoords[4]);
		format(LAElevatorFloorName[5], 24, "%s", arrCoords[5]);
		format(LAElevatorFloorName[6], 24, "%s", arrCoords[6]);
		format(LAElevatorFloorName[7], 24, "%s", arrCoords[7]);
		format(LAElevatorFloorName[8], 24, "%s", arrCoords[8]);
		format(LAElevatorFloorName[9], 24, "%s", arrCoords[9]);
		format(LAElevatorFloorName[10], 24, "%s", arrCoords[10]);
		format(LAElevatorFloorName[11], 24, "%s", arrCoords[11]);
		format(LAElevatorFloorName[12], 24, "%s", arrCoords[12]);
		format(LAElevatorFloorName[13], 24, "%s", arrCoords[13]);
		format(LAElevatorFloorName[14], 24, "%s", arrCoords[14]);
		format(LAElevatorFloorName[15], 24, "%s", arrCoords[15]);
		format(LAElevatorFloorName[16], 24, "%s", arrCoords[16]);
		format(LAElevatorFloorName[17], 24, "%s", arrCoords[17]);
		format(LAElevatorFloorName[18], 24, "%s", arrCoords[18]);
		format(LAElevatorFloorName[19], 24, "%s", arrCoords[19]);
		format(LAElevatorFloorPass[0], 24, "%s", arrCoords[20]);
		format(LAElevatorFloorPass[1], 24, "%s", arrCoords[21]);
		format(LAElevatorFloorPass[2], 24, "%s", arrCoords[22]);
		format(LAElevatorFloorPass[3], 24, "%s", arrCoords[23]);
		format(LAElevatorFloorPass[4], 24, "%s", arrCoords[24]);
		format(LAElevatorFloorPass[5], 24, "%s", arrCoords[25]);
		format(LAElevatorFloorPass[6], 24, "%s", arrCoords[26]);
		format(LAElevatorFloorPass[7], 24, "%s", arrCoords[27]);
		format(LAElevatorFloorPass[8], 24, "%s", arrCoords[28]);
		format(LAElevatorFloorPass[9], 24, "%s", arrCoords[29]);
		format(LAElevatorFloorPass[10], 24, "%s", arrCoords[30]);
		format(LAElevatorFloorPass[11], 24, "%s", arrCoords[31]);
		format(LAElevatorFloorPass[12], 24, "%s", arrCoords[32]);
		format(LAElevatorFloorPass[13], 24, "%s", arrCoords[33]);
		format(LAElevatorFloorPass[14], 24, "%s", arrCoords[34]);
		format(LAElevatorFloorPass[15], 24, "%s", arrCoords[35]);
		format(LAElevatorFloorPass[16], 24, "%s", arrCoords[36]);
		format(LAElevatorFloorPass[17], 24, "%s", arrCoords[37]);
		format(LAElevatorFloorPass[18], 24, "%s", arrCoords[38]);
		format(LAElevatorFloorPass[19], 24, "%s", arrCoords[39]);
	}
	return 1;
}
SaveStuff()
{
	new coordsString[256];
	format(coordsString, sizeof(coordsString), "%d,%d,%d,%d,%d", Jackpot,Tax,TaxValue,Security,SpecTimer);
	new File: file2 = fopen("stuff.ini", io_write);
	fwrite(file2, coordsString);
	fclose(file2);
	return 1;
}

SaveStock()
{
	new coordsString[256];
	format(coordsString, sizeof(coordsString), "%d,%d,%d,%d,%d,%d,%d,%d,%d", StockIkan,IDPlate,stockcomp,StockDPU,stockplant,stockpot,stockcrack,EquipmentStock,cutt);
	new File: file2 = fopen("stock.ini", io_write);
	fwrite(file2, coordsString);
	fclose(file2);
	return 1;
}
LoadStock()
{
	new arrCoords[20][64];
	new strFromFile2[256];
	new File: file = fopen("stock.ini", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		splits(strFromFile2, arrCoords, ',');
		StockIkan = strval(arrCoords[0]);
		IDPlate = strval(arrCoords[1]);
		stockcomp = strval(arrCoords[2]);
		StockDPU = strval(arrCoords[3]);
		stockplant = strval(arrCoords[4]);
		stockpot = strval(arrCoords[5]);
		stockcrack = strval(arrCoords[6]);
		EquipmentStock = strval(arrCoords[7]);
		cutt = strval(arrCoords[8]);
		fclose(file);
	}
	else
	{
		GameModeExit();
	}
	return 1;
}

//---------------------------------
SaveElevatorStuff()
{
	new coordsString[10000];
	format(coordsString, sizeof(coordsString), "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
	LAElevatorFloorName[0],
	LAElevatorFloorName[1],
	LAElevatorFloorName[2],
	LAElevatorFloorName[3],
	LAElevatorFloorName[4],
	LAElevatorFloorName[5],
	LAElevatorFloorName[6],
	LAElevatorFloorName[7],
	LAElevatorFloorName[8],
	LAElevatorFloorName[9],
	LAElevatorFloorName[10],
	LAElevatorFloorName[11],
	LAElevatorFloorName[12],
	LAElevatorFloorName[13],
	LAElevatorFloorName[14],
	LAElevatorFloorName[15],
	LAElevatorFloorName[16],
	LAElevatorFloorName[17],
	LAElevatorFloorName[18],
	LAElevatorFloorName[19],
	LAElevatorFloorPass[0],
	LAElevatorFloorPass[1],
	LAElevatorFloorPass[2],
	LAElevatorFloorPass[3],
	LAElevatorFloorPass[4],
	LAElevatorFloorPass[5],
	LAElevatorFloorPass[6],
	LAElevatorFloorPass[7],
	LAElevatorFloorPass[8],
	LAElevatorFloorPass[9],
	LAElevatorFloorPass[10],
	LAElevatorFloorPass[11],
	LAElevatorFloorPass[12],
	LAElevatorFloorPass[13],
	LAElevatorFloorPass[14],
	LAElevatorFloorPass[15],
	LAElevatorFloorPass[16],
	LAElevatorFloorPass[17],
	LAElevatorFloorPass[18],
	LAElevatorFloorPass[19]
	);
	new File: file2 = fopen("elevator.ini", io_write);
	fwrite(file2, coordsString);
	fclose(file2);
	return 1;
}

LoadMaxLimit()
{
	new arrCoords[12][64];
	new strFromFile2[256];
	new File: file = fopen("maxlimit.ini", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		splits(strFromFile2, arrCoords, ',');
		SpawnedATM = strval(arrCoords[0]);
		fclose(file);
	}
	else
	{
		GameModeExit();
	}
	return 1;
}

SaveMaxLimit()
{
	new coordsString[256];
	format(coordsString, sizeof(coordsString), "%d", SpawnedATM);
	new File: file2 = fopen("maxlimit.ini", io_write);
	fwrite(file2, coordsString);
	fclose(file2);
	return 1;
}

LoadMOTDs()
{
	new arrCoords[4][128];
	new strFromFile2[512];
	new File: file = fopen("motd.ini", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		splits(strFromFile2, arrCoords, '|');
		strmid(GlobalMOTD, arrCoords[0], 0, strlen(arrCoords[0]), 255);
		strmid(AdminMOTD, arrCoords[1], 0, strlen(arrCoords[1]), 255);
		strmid(CAMOTD, arrCoords[3], 0, strlen(arrCoords[3]), 255);
		fclose(file);
	}
	else
	{
		fcreate("motd.ini");
		print("motd.ini doesn't exit, setting the default MOTDs");
		format(GlobalMOTD, sizeof(GlobalMOTD), "Welcome to Just Life Roleplay Server.");
		format(AdminMOTD, sizeof(AdminMOTD), "Admin MOTD: None.");
		format(CAMOTD, sizeof(CAMOTD), "Helpers MOTD: None.");
  		SaveMOTDs();
	}
	return 1;
}

SaveMOTDs()
{
	new coordsString[512];
	format(coordsString, sizeof(coordsString), "%s|%s|%s", GlobalMOTD,AdminMOTD,CAMOTD);
	new File: file2 = fopen("motd.ini", io_write);
	fwrite(file2, coordsString);
	fclose(file2);
	return 1;
}

LoadFamilies() {

	if(!fexist("families.cfg")) return 1;

	new
		szFileStr[512],
		iIndex,
		File: iFileHandle = fopen("families.cfg", io_read);

	while (iIndex < sizeof(FamilyInfo) && fread(iFileHandle, szFileStr)) {

		sscanf(szFileStr, "p<|>is[42]s[65]s[24]iiifffiiis[20]s[20]s[20]s[20]s[20]s[20]iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii",
			FamilyInfo[iIndex][FamilyTaken],
			FamilyInfo[iIndex][FamilyName],
			FamilyInfo[iIndex][FamilyMOTD],
			FamilyInfo[iIndex][FamilyLeader],
			FamilyInfo[iIndex][FamilyBank],
			FamilyInfo[iIndex][FamilyCash],
			FamilyInfo[iIndex][FamilyUSafe],
			FamilyInfo[iIndex][FamilySafe][0],
			FamilyInfo[iIndex][FamilySafe][1],
			FamilyInfo[iIndex][FamilySafe][2],
			FamilyInfo[iIndex][FamilyPot],
			FamilyInfo[iIndex][FamilyCrack],
			FamilyInfo[iIndex][FamilyMats],
			FamilyInfo[iIndex][FamilyRank1],
			FamilyInfo[iIndex][FamilyRank2],
			FamilyInfo[iIndex][FamilyRank3],
			FamilyInfo[iIndex][FamilyRank4],
			FamilyInfo[iIndex][FamilyRank5],
			FamilyInfo[iIndex][FamilyRank6],
			FamilyInfo[iIndex][FamilyMembers],
			FamilyInfo[iIndex][FamilyMaxSkins],
			FamilyInfo[iIndex][FamilySkins][0],
			FamilyInfo[iIndex][FamilySkins][1],
			FamilyInfo[iIndex][FamilySkins][2],
			FamilyInfo[iIndex][FamilySkins][3],
			FamilyInfo[iIndex][FamilySkins][4],
			FamilyInfo[iIndex][FamilySkins][5],
			FamilyInfo[iIndex][FamilySkins][6],
			FamilyInfo[iIndex][FamilySkins][7],
			FamilyInfo[iIndex][FamilyColor],
			FamilyInfo[iIndex][FamilyTurfTokens],
			FamilyInfo[iIndex][FamilyGuns][0],
			FamilyInfo[iIndex][FamilyGuns][1],
			FamilyInfo[iIndex][FamilyGuns][2],
			FamilyInfo[iIndex][FamilyGuns][3],
			FamilyInfo[iIndex][FamilyGuns][4],
			FamilyInfo[iIndex][FamilyGuns][5],
			FamilyInfo[iIndex][FamilyGuns][6],
			FamilyInfo[iIndex][FamilyGuns][7],
			FamilyInfo[iIndex][FamilyGuns][8],
			FamilyInfo[iIndex][FamilyGuns][9],
			FamilyInfo[iIndex][FamilyGunsAmmo][0],
			FamilyInfo[iIndex][FamilyGunsAmmo][1],
			FamilyInfo[iIndex][FamilyGunsAmmo][2],
			FamilyInfo[iIndex][FamilyGunsAmmo][3],
			FamilyInfo[iIndex][FamilyGunsAmmo][4],
			FamilyInfo[iIndex][FamilyGunsAmmo][5],
			FamilyInfo[iIndex][FamilyGunsAmmo][6],
			FamilyInfo[iIndex][FamilyGunsAmmo][7],
			FamilyInfo[iIndex][FamilyGunsAmmo][8],
			FamilyInfo[iIndex][FamilyGunsAmmo][9]
		);
		++iIndex;
	}
	return fclose(iFileHandle);
}

SaveFamilies()
{
	new idx;
	new File: file2;
	while (idx < sizeof(FamilyInfo))
	{
		new coordsString[512];
		format(coordsString, sizeof(coordsString), "%d|%s|%s|%s|%d|%d|%d|%f|%f|%f|%d|%d|%d|%s|%s|%s|%s|%s|%s|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d\n",
		FamilyInfo[idx][FamilyTaken],
		FamilyInfo[idx][FamilyName],
		FamilyInfo[idx][FamilyMOTD],
		FamilyInfo[idx][FamilyLeader],
		FamilyInfo[idx][FamilyBank],
		FamilyInfo[idx][FamilyCash],
		FamilyInfo[idx][FamilyUSafe],
		FamilyInfo[idx][FamilySafe][0],
		FamilyInfo[idx][FamilySafe][1],
		FamilyInfo[idx][FamilySafe][2],
		FamilyInfo[idx][FamilyPot],
		FamilyInfo[idx][FamilyCrack],
		FamilyInfo[idx][FamilyMats],
		FamilyInfo[idx][FamilyRank1],
		FamilyInfo[idx][FamilyRank2],
		FamilyInfo[idx][FamilyRank3],
		FamilyInfo[idx][FamilyRank4],
		FamilyInfo[idx][FamilyRank5],
		FamilyInfo[idx][FamilyRank6],
		FamilyInfo[idx][FamilyMembers],
		FamilyInfo[idx][FamilyMaxSkins],
		FamilyInfo[idx][FamilySkins][0],
		FamilyInfo[idx][FamilySkins][1],
		FamilyInfo[idx][FamilySkins][2],
		FamilyInfo[idx][FamilySkins][3],
		FamilyInfo[idx][FamilySkins][4],
		FamilyInfo[idx][FamilySkins][5],
		FamilyInfo[idx][FamilySkins][6],
		FamilyInfo[idx][FamilySkins][7],
		FamilyInfo[idx][FamilyColor],
		FamilyInfo[idx][FamilyTurfTokens],
		FamilyInfo[idx][FamilyGuns][0],
		FamilyInfo[idx][FamilyGuns][1],
		FamilyInfo[idx][FamilyGuns][2],
		FamilyInfo[idx][FamilyGuns][3],
		FamilyInfo[idx][FamilyGuns][4],
		FamilyInfo[idx][FamilyGuns][5],
		FamilyInfo[idx][FamilyGuns][6],
		FamilyInfo[idx][FamilyGuns][7],
		FamilyInfo[idx][FamilyGuns][8],
		FamilyInfo[idx][FamilyGuns][9],
		FamilyInfo[idx][FamilyGunsAmmo][0],
		FamilyInfo[idx][FamilyGunsAmmo][1],
		FamilyInfo[idx][FamilyGunsAmmo][2],
		FamilyInfo[idx][FamilyGunsAmmo][3],
		FamilyInfo[idx][FamilyGunsAmmo][4],
		FamilyInfo[idx][FamilyGunsAmmo][5],
		FamilyInfo[idx][FamilyGunsAmmo][6],
		FamilyInfo[idx][FamilyGunsAmmo][7],
		FamilyInfo[idx][FamilyGunsAmmo][8],
		FamilyInfo[idx][FamilyGunsAmmo][9]);
		if(idx == 0)
		{
			file2 = fopen("families.cfg", io_write);
		}
		else
		{
			file2 = fopen("families.cfg", io_append);
		}
		fwrite(file2, coordsString);
		idx++;
		fclose(file2);
	}
	return 1;
}

LoadFamiliesHQ()
{
    new String2[64];
	format(String2, sizeof(String2), "familieshq.ini");
	new File: GangFile = fopen(String2, io_read);
	//printf("[DEBUG] LoadFamiliesHQ: String2 (%s)", String2);
	if ( GangFile )
	{
	    //print("[DEBUG] LoadFamiliesHQ: GangFile exists, the handle parsed.");
		new key[ 256 ] , val[ 256 ];
		new Data[ 256 ];
		//print("[DEBUG] Starting while ( fread( GangFile , Data , sizeof( Data ) ) )");
		while ( fread( GangFile , Data , sizeof( Data ) ) )
		{
		    new String[10000];
		    for(new f = 0; f < MAX_FAMILY; f++)
    		{
				key = ini_GetKey( Data );
				format(String, 128, "Family%dEntranceX",f);
				if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyInfo[f][FamilyEntrance][0] = floatstr( val ); }
				format(String, 128, "Family%dEntranceY",f);
				if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyInfo[f][FamilyEntrance][1] = floatstr( val ); }
				format(String, 128, "Family%dEntranceZ",f);
				if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyInfo[f][FamilyEntrance][2] = floatstr( val ); }
				format(String, 128, "Family%dEntranceA",f);
				if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyInfo[f][FamilyEntrance][3] = floatstr( val ); }
				format(String, 128, "Family%dExitX",f);
				if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyInfo[f][FamilyExit][0] = floatstr( val ); }
				format(String, 128, "Family%dExitY",f);
				if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyInfo[f][FamilyExit][1] = floatstr( val ); }
				format(String, 128, "Family%dExitZ",f);
				if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyInfo[f][FamilyExit][2] = floatstr( val ); }
				format(String, 128, "Family%dExitA",f);
				if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyInfo[f][FamilyExit][3] = floatstr( val ); }
				format(String, 128, "Family%dInterior",f);
				if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyInfo[f][FamilyInterior] = strval( val ); }
				format(String, 128, "Family%dCustomMap",f);
				if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyInfo[f][FamilyCustomMap] = strval( val ); }
				format(String, 128, "Family%dVirtualWorld",f);
				if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyInfo[f][FamilyVirtualWorld] = strval( val ); }
				for(new fv = 0; fv < MAX_GANG_VEHICLES; fv++)
    			{
    			    format(String, 128, "Family%dVeh%dModelId",f, fv);
					if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyVehicleInfo[f][fv][fvModelId] = strval( val ); }
					format(String, 128, "Family%dVeh%dSpawnx",f, fv);
					if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyVehicleInfo[f][fv][fvSpawnx] = floatstr( val ); }
					format(String, 128, "Family%dVeh%dSpawny",f, fv);
					if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyVehicleInfo[f][fv][fvSpawny] = floatstr( val ); }
					format(String, 128, "Family%dVeh%dSpawnz",f, fv);
					if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyVehicleInfo[f][fv][fvSpawnz] = floatstr( val ); }
					format(String, 128, "Family%dVeh%dSpawna",f, fv);
					if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyVehicleInfo[f][fv][fvSpawna] = floatstr( val ); }
					format(String, 128, "Family%dVeh%dLock",f, fv);
					if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyVehicleInfo[f][fv][fvLock] = strval( val ); }
					format(String, 128, "Family%dVeh%dLocked",f, fv);
					if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyVehicleInfo[f][fv][fvLocked] = strval( val ); }
					format(String, 128, "Family%dVeh%dPaintJob",f, fv);
					if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyVehicleInfo[f][fv][fvPaintJob] = strval( val ); }
					format(String, 128, "Family%dVeh%dColor1",f, fv);
					if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyVehicleInfo[f][fv][fvColor1] = strval( val ); }
					format(String, 128, "Family%dVeh%dColor2",f, fv);
					if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyVehicleInfo[f][fv][fvColor2] = strval( val ); }
					format(String, 128, "Family%dVeh%dFuel",f, fv);
					if( strcmp( key , String , true ) == 0 ) { val = ini_GetValue( Data ); FamilyVehicleInfo[f][fv][fvFuel] = floatstr( val ); }
    			}
    			//printf("Family %d loaded [DEBUG] FamilyEntranceX: %.1f FamilyEntranceY: %.1f FamilyEntranceZ: %.1f", f, FamilyInfo[f][FamilyEntrance][0], FamilyInfo[f][FamilyEntrance][1], FamilyInfo[f][FamilyEntrance][2]);
			}
		}
		fclose(GangFile);
	}
	return 1;
}

SaveFamiliesHQ()
{
	new String3[32];
	//GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	format(String3, sizeof(String3), "familieshq.ini");
	new File: hFile = fopen(String3, io_write);
	if (hFile)
	{
		new var[32];
		for(new f = 0; f < MAX_FAMILY; f++)
   		{
			format(var, 1024, "Family%dEntranceX=%.1f\n",f, FamilyInfo[f][FamilyEntrance][0]); fwrite(hFile, var);
			format(var, 1024, "Family%dEntranceY=%.1f\n",f, FamilyInfo[f][FamilyEntrance][1]); fwrite(hFile, var);
			format(var, 1024, "Family%dEntranceZ=%.1f\n",f, FamilyInfo[f][FamilyEntrance][2]); fwrite(hFile, var);
			format(var, 1024, "Family%dEntranceA=%.1f\n",f, FamilyInfo[f][FamilyEntrance][3]); fwrite(hFile, var);
			format(var, 1024, "Family%dExitX=%.1f\n",f, FamilyInfo[f][FamilyExit][0]); fwrite(hFile, var);
			format(var, 1024, "Family%dExitY=%.1f\n",f, FamilyInfo[f][FamilyExit][1]); fwrite(hFile, var);
			format(var, 1024, "Family%dExitZ=%.1f\n",f, FamilyInfo[f][FamilyExit][2]); fwrite(hFile, var);
			format(var, 1024, "Family%dExitA=%.1f\n",f, FamilyInfo[f][FamilyExit][3]); fwrite(hFile, var);
			format(var, 1024, "Family%dInterior=%d\n",f, FamilyInfo[f][FamilyInterior]); fwrite(hFile, var);
			format(var, 1024, "Family%dCustomMap=%d\n",f, FamilyInfo[f][FamilyCustomMap]); fwrite(hFile, var);
			format(var, 1024, "Family%dVirtualWorld=%d\n",f, FamilyInfo[f][FamilyVirtualWorld]); fwrite(hFile, var);

			for(new fv = 0; fv < MAX_GANG_VEHICLES; fv++)
   			{
   			    format(var, 1024, "Family%dVeh%dModelId=%d\n",f, fv, FamilyVehicleInfo[f][fv][fvModelId]); fwrite(hFile, var);
				format(var, 1024, "Family%dVeh%dSpawnx=%.1f\n",f, fv,FamilyVehicleInfo[f][fv][fvSpawnx]); fwrite(hFile, var);
				format(var, 1024, "Family%dVeh%dSpawny=%.1f\n",f, fv,FamilyVehicleInfo[f][fv][fvSpawny]); fwrite(hFile, var);
				format(var, 1024, "Family%dVeh%dSpawnz=%.1f\n",f, fv,FamilyVehicleInfo[f][fv][fvSpawnz]); fwrite(hFile, var);
				format(var, 1024, "Family%dVeh%dSpawna=%.1f\n",f, fv,FamilyVehicleInfo[f][fv][fvSpawna]); fwrite(hFile, var);
				format(var, 1024, "Family%dVeh%dLock=%d\n",f, fv,FamilyVehicleInfo[f][fv][fvLock]); fwrite(hFile, var);
				format(var, 1024, "Family%dVeh%dLocked=%d\n",f, fv,FamilyVehicleInfo[f][fv][fvLocked]); fwrite(hFile, var);
				format(var, 1024, "Family%dVeh%dPaintJob=%d\n",f, fv,FamilyVehicleInfo[f][fv][fvPaintJob]); fwrite(hFile, var);
				format(var, 1024, "Family%dVeh%dColor1=%d\n",f, fv,FamilyVehicleInfo[f][fv][fvColor1]); fwrite(hFile, var);
				format(var, 1024, "Family%dVeh%dColor2=%d\n",f, fv,FamilyVehicleInfo[f][fv][fvColor2]); fwrite(hFile, var);
				if(FamilyVehicleInfo[f][fv][fvId] != INVALID_VEHICLE_ID) FamilyVehicleInfo[f][fv][fvFuel] = VehicleFuel[FamilyVehicleInfo[f][fv][fvId]];
				format(var, 32, "Family%dVeh%dFuel=%.1f\n",f, fv,FamilyVehicleInfo[f][fv][fvFuel]); fwrite(hFile, var);
    		}
  		}
		fclose(hFile);
	}
	return 1;
}

FMemberCounter() {

	new
		arrCounts[sizeof(FamilyInfo)],
		szFileStr[128],
		arrTimeStamp[2][3],
		File: iFileHandle = fopen("logs/fmembercount.log", io_append);

	gettime(arrTimeStamp[0][0], arrTimeStamp[0][1], arrTimeStamp[0][2]);
	getdate(arrTimeStamp[1][0], arrTimeStamp[1][1], arrTimeStamp[1][2]);
	foreach(Player, i) if(PlayerInfo[i][pAdmin] < 2 && playerTabbed[i] == 0 && PlayerInfo[i][pFMember] != 255) ++arrCounts[PlayerInfo[i][pFMember]];

	format(szFileStr, sizeof(szFileStr), "----------------------------------------\r\nDate: %d/%d/%d - Time: %d:%d\r\n", arrTimeStamp[1][1], arrTimeStamp[1][2], arrTimeStamp[1][0], arrTimeStamp[0][0], arrTimeStamp[0][1]);
	fwrite(iFileHandle, szFileStr);

	for(new iFam; iFam < sizeof(FamilyInfo); ++iFam) format(szFileStr, sizeof(szFileStr), "(%i) %s: %i\r\n", iFam+1, FamilyInfo[iFam][FamilyName], arrCounts[iFam]), fwrite(iFileHandle, szFileStr);
	return fclose(iFileHandle);
}

forward ReportTimer(reportid);
public ReportTimer(reportid)
{
	if(Reports[reportid][BeingUsed] == 1)
	{
	    if(Reports[reportid][TimeToExpire] > 0)
	    {
	        Reports[reportid][TimeToExpire]--;
	        if(Reports[reportid][TimeToExpire] == 0)
	        {
	            SendClientMessageEx(Reports[reportid][ReportFrom], COLOR_GRAD2, "Your report has expired. You can attempt to report again if you wish.");
	            Reports[reportid][BeingUsed] = 0;
	            Reports[reportid][ReportFrom] = 999;
	            return 1;
	        }
  			Reports[reportid][ReportExpireTimer] = SetTimerEx("ReportTimer", 60000, 0, "d", reportid);
		}
	}
	return 1;
}

forward ReplyTimer(reportid);
public ReplyTimer(reportid)
{
    Reports[reportid][BeingUsed] = 0;
	Reports[reportid][ReportFrom] = 999;
    Reports[reportid][CheckingReport] = 999;
}

/*LoadcDealerships()
{
	print("Load Dealership");
	new idx, idx2;
	new string[128];
	new owner[MAX_PLAYER_NAME];
	new message[128];
	djAutocommit(false);
	while (idx < sizeof(CarDealershipInfo))
	{
        format(string, sizeof(string), "%d/owned", idx);
		CarDealershipInfo[idx][cdOwned] = djInt("cardealerships.json", string);
		format(string, sizeof(string), "%d/owner", idx);
		format(owner, sizeof(owner), "%s", dj("cardealerships.json", string));
		strmid(CarDealershipInfo[idx][cdOwner], owner, 0, strlen(owner), 255);
		format(string, sizeof(string), "%d/entrance/x", idx);
		CarDealershipInfo[idx][cdEntranceX] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/entrance/y", idx);
		CarDealershipInfo[idx][cdEntranceY] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/entrance/z", idx);
		CarDealershipInfo[idx][cdEntranceZ] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/exit/x", idx);
		CarDealershipInfo[idx][cdExitX] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/exit/y", idx);
		CarDealershipInfo[idx][cdExitY] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/exit/z", idx);
	    CarDealershipInfo[idx][cdExitZ] = djFloat("cardealerships.json", string);
	    format(string, sizeof(string), "%d/message", idx);
		format(message, sizeof(message), "%s", dj("cardealerships.json", string));
		strmid(CarDealershipInfo[idx][cdMessage], message, 0, strlen(message), 255);
		format(string, sizeof(string), "%d/till", idx);
		CarDealershipInfo[idx][cdTill] = djInt("cardealerships.json", string);
		format(string, sizeof(string), "%d/interior", idx);
		CarDealershipInfo[idx][cdInterior] = djInt("cardealerships.json", string);
		format(string, sizeof(string), "%d/vehiclespawn/x", idx);
		CarDealershipInfo[idx][cdVehicleSpawn][0] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/vehiclespawn/y", idx);
		CarDealershipInfo[idx][cdVehicleSpawn][1] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/vehiclespawn/z", idx);
		CarDealershipInfo[idx][cdVehicleSpawn][2] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/vehiclespawn/a", idx);
		CarDealershipInfo[idx][cdVehicleSpawn][3] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/radius", idx);
		CarDealershipInfo[idx][cdRadius] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/price", idx);
		CarDealershipInfo[idx][cdPrice] = djInt("cardealerships.json", string);
		while (idx2 < MAX_DEALERSHIPVEHICLES)
		{
            format(string, sizeof(string), "%d/vehicleangle/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleSpawnAngle][idx2] = djFloat("cardealerships.json", string);
		    format(string, sizeof(string), "%d/vehiclespawnx/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleSpawnX][idx2] = djFloat("cardealerships.json", string);
		    format(string, sizeof(string), "%d/vehiclespawny/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleSpawnY][idx2] = djFloat("cardealerships.json", string);
		    format(string, sizeof(string), "%d/vehiclespawnz/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleSpawnZ][idx2] = djFloat("cardealerships.json", string);
		    format(string, sizeof(string), "%d/vehiclecost/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleCost][idx2] = djInt("cardealerships.json", string);
		    format(string, sizeof(string), "%d/vehicletypes/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleModel][idx2] = djInt("cardealerships.json", string);
		    idx2++;
		}
		idx2 = 0;
		idx++;
	}
	djAutocommit(true);
	return 1;
}

SavecDealership(id)
{
	new idx2;
	new string[128];
	printf("Saving Car Dealership %d.", id);
	//djAutocommit(false);
    format(string, sizeof(string), "%d/owned", id);
	djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdOwned]);
	format(string, sizeof(string), "%d/owner", id);
	djSet("cardealerships.json", string, CarDealershipInfo[id][cdOwner]);
	format(string, sizeof(string), "%d/entrance/x", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdEntranceX]);
	format(string, sizeof(string), "%d/entrance/y", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdEntranceY]);
	format(string, sizeof(string), "%d/entrance/z", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdEntranceZ]);
	format(string, sizeof(string), "%d/exit/x", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdExitX]);
	format(string, sizeof(string), "%d/exit/y", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdExitY]);
	format(string, sizeof(string), "%d/exit/z", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdExitZ]);
	format(string, sizeof(string), "%d/message", id);
	djSet("cardealerships.json", string, CarDealershipInfo[id][cdMessage]);
	format(string, sizeof(string), "%d/till", id);
	djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdTill]);
	format(string, sizeof(string), "%d/interior", id);
	djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdInterior]);
	format(string, sizeof(string), "%d/vehiclespawn/x", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawn][0]);
	format(string, sizeof(string), "%d/vehiclespawn/y", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawn][1]);
	format(string, sizeof(string), "%d/vehiclespawn/z", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawn][2]);
	format(string, sizeof(string), "%d/vehiclespawn/a", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawn][3]);
	format(string, sizeof(string), "%d/radius", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdRadius]);
	format(string, sizeof(string), "%d/price", id);
	djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdPrice]);
	while (idx2 < MAX_DEALERSHIPVEHICLES)
	{
        format(string, sizeof(string), "%d/vehicleangle/%d", id, idx2);
        djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawnAngle][idx2]);
	    format(string, sizeof(string), "%d/vehiclespawnx/%d", id, idx2);
	    djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawnX][idx2]);
	    format(string, sizeof(string), "%d/vehiclespawny/%d", id, idx2);
	    djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawnY][idx2]);
	    format(string, sizeof(string), "%d/vehiclespawnz/%d", id, idx2);
	    djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawnZ][idx2]);
	    format(string, sizeof(string), "%d/vehiclecost/%d", id, idx2);
	    djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdVehicleCost][idx2]);
	    format(string, sizeof(string), "%d/vehicletypes/%d", id, idx2);
	    djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdVehicleModel][idx2]);
	    idx2++;
	}
    //djAutocommit(true);
	return 1;
}*/

//DEALER
LoadcDealerships()
{
	new idx, idx2;
	new string[128];
	new owner[MAX_PLAYER_NAME];
	new message[128];
	djAutocommit(false);
	while (idx < sizeof(CarDealershipInfo))
	{
        format(string, sizeof(string), "%d/owned", idx);
		CarDealershipInfo[idx][cdOwned] = djInt("cardealerships.json", string);
		format(string, sizeof(string), "%d/owner", idx);
		format(owner, sizeof(owner), "%s", dj("cardealerships.json", string));
		strmid(CarDealershipInfo[idx][cdOwner], owner, 0, strlen(owner), 255);
		format(string, sizeof(string), "%d/entrance/x", idx);
		CarDealershipInfo[idx][cdEntranceX] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/entrance/y", idx);
		CarDealershipInfo[idx][cdEntranceY] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/entrance/z", idx);
		CarDealershipInfo[idx][cdEntranceZ] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/exit/x", idx);
		CarDealershipInfo[idx][cdExitX] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/exit/y", idx);
		CarDealershipInfo[idx][cdExitY] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/exit/z", idx);
	    CarDealershipInfo[idx][cdExitZ] = djFloat("cardealerships.json", string);
	    format(string, sizeof(string), "%d/message", idx);
		format(message, sizeof(message), "%s", dj("cardealerships.json", string));
		strmid(CarDealershipInfo[idx][cdMessage], message, 0, strlen(message), 255);
		format(string, sizeof(string), "%d/till", idx);
		CarDealershipInfo[idx][cdTill] = djInt("cardealerships.json", string);
		format(string, sizeof(string), "%d/interior", idx);
		CarDealershipInfo[idx][cdInterior] = djInt("cardealerships.json", string);
		format(string, sizeof(string), "%d/vehiclespawn/x", idx);
		CarDealershipInfo[idx][cdVehicleSpawn][0] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/vehiclespawn/y", idx);
		CarDealershipInfo[idx][cdVehicleSpawn][1] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/vehiclespawn/z", idx);
		CarDealershipInfo[idx][cdVehicleSpawn][2] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/vehiclespawn/a", idx);
		CarDealershipInfo[idx][cdVehicleSpawn][3] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/radius", idx);
		CarDealershipInfo[idx][cdRadius] = djFloat("cardealerships.json", string);
		format(string, sizeof(string), "%d/price", idx);
		CarDealershipInfo[idx][cdPrice] = djInt("cardealerships.json", string);
		format(string, sizeof(string), "%d/type", idx);
		CarDealershipInfo[idx][cdType] = djInt("cardealerships.json", string);
		while (idx2 < MAX_DEALERSHIPVEHICLES)
		{
            format(string, sizeof(string), "%d/vehicleangle/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleSpawnAngle][idx2] = djFloat("cardealerships.json", string);
		    format(string, sizeof(string), "%d/vehiclespawnx/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleSpawnX][idx2] = djFloat("cardealerships.json", string);
		    format(string, sizeof(string), "%d/vehiclespawny/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleSpawnY][idx2] = djFloat("cardealerships.json", string);
		    format(string, sizeof(string), "%d/vehiclespawnz/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleSpawnZ][idx2] = djFloat("cardealerships.json", string);
		    format(string, sizeof(string), "%d/vehiclecost/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleCost][idx2] = djInt("cardealerships.json", string);
		    format(string, sizeof(string), "%d/vehicletypes/%d", idx, idx2);
		    CarDealershipInfo[idx][cdVehicleModel][idx2] = djInt("cardealerships.json", string);
		    idx2++;
		}
		idx2 = 0;
		idx++;
	}
	djAutocommit(true);
	return 1;
}

SavecDealership(id)
{
	new idx2;
	new string[128];
	printf("[system] Menyimpan Car Dealership ID - %d.", id);
    format(string, sizeof(string), "%d/owned", id);
	djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdOwned]);
	format(string, sizeof(string), "%d/owner", id);
	djSet("cardealerships.json", string, CarDealershipInfo[id][cdOwner]);
	format(string, sizeof(string), "%d/entrance/x", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdEntranceX]);
	format(string, sizeof(string), "%d/entrance/y", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdEntranceY]);
	format(string, sizeof(string), "%d/entrance/z", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdEntranceZ]);
	format(string, sizeof(string), "%d/exit/x", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdExitX]);
	format(string, sizeof(string), "%d/exit/y", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdExitY]);
	format(string, sizeof(string), "%d/exit/z", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdExitZ]);
	format(string, sizeof(string), "%d/message", id);
	djSet("cardealerships.json", string, CarDealershipInfo[id][cdMessage]);
	format(string, sizeof(string), "%d/till", id);
	djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdTill]);
	format(string, sizeof(string), "%d/interior", id);
	djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdInterior]);
	format(string, sizeof(string), "%d/vehiclespawn/x", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawn][0]);
	format(string, sizeof(string), "%d/vehiclespawn/y", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawn][1]);
	format(string, sizeof(string), "%d/vehiclespawn/z", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawn][2]);
	format(string, sizeof(string), "%d/vehiclespawn/a", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawn][3]);
	format(string, sizeof(string), "%d/radius", id);
	djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdRadius]);
	format(string, sizeof(string), "%d/price", id);
	djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdPrice]);
	format(string, sizeof(string), "%d/type", id);
	djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdType]);
	while (idx2 < MAX_DEALERSHIPVEHICLES)
	{
        format(string, sizeof(string), "%d/vehicleangle/%d", id, idx2);
        djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawnAngle][idx2]);
	    format(string, sizeof(string), "%d/vehiclespawnx/%d", id, idx2);
	    djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawnX][idx2]);
	    format(string, sizeof(string), "%d/vehiclespawny/%d", id, idx2);
	    djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawnY][idx2]);
	    format(string, sizeof(string), "%d/vehiclespawnz/%d", id, idx2);
	    djSetFloat("cardealerships.json", string, CarDealershipInfo[id][cdVehicleSpawnZ][idx2]);
	    format(string, sizeof(string), "%d/vehiclecost/%d", id, idx2);
	    djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdVehicleCost][idx2]);
	    format(string, sizeof(string), "%d/vehicletypes/%d", id, idx2);
	    djSetInt("cardealerships.json", string, CarDealershipInfo[id][cdVehicleModel][idx2]);
	    idx2++;
	}
    //djAutocommit(true);
	return 1;
}

stock LoadGates()
{
	new dinfo[22][128];
	new string[350];
	new File:file = fopen("gates.cfg", io_read);
	if(file)
	{
	    new idx = 1;
		while(idx < MAX_GATES)
		{
		    fread(file, string);
		    split(string, dinfo, '|');
			GateInfo[idx][gModel] = strval(dinfo[0]);
			GateInfo[idx][gCX] = floatstr(dinfo[1]);
			GateInfo[idx][gCY] = floatstr(dinfo[2]);
			GateInfo[idx][gCZ] = floatstr(dinfo[3]);
			GateInfo[idx][gCRX] = floatstr(dinfo[4]);
			GateInfo[idx][gCRY] = floatstr(dinfo[5]);
			GateInfo[idx][gCRZ] = floatstr(dinfo[6]);
			GateInfo[idx][gOX] = floatstr(dinfo[7]);
			GateInfo[idx][gOY] = floatstr(dinfo[8]);
			GateInfo[idx][gOZ] = floatstr(dinfo[9]);
			GateInfo[idx][gORX] = floatstr(dinfo[10]);
			GateInfo[idx][gORY] = floatstr(dinfo[11]);
			GateInfo[idx][gORZ] = floatstr(dinfo[12]);
			format(GateInfo[idx][gPassword], 256, "%s", dinfo[13]);
			GateInfo[idx][gRange] = floatstr(dinfo[14]);
			GateInfo[idx][gFaction] = strval(dinfo[15]);
			GateInfo[idx][gWorkshop] = strval(dinfo[16]);
			GateInfo[idx][gHID] = strval(dinfo[17]);
			GateInfo[idx][gVW] = strval(dinfo[18]);
			GateInfo[idx][gInt] = strval(dinfo[19]);
			GateInfo[idx][gSpeed] = floatstr(dinfo[20]);
			GateInfo[idx][gOwner] = strval(dinfo[21]);
			if(GateInfo[idx][gModel]) // If gate exists
			{
				GateInfo[idx][gGate] = CreateDynamicObject(GateInfo[idx][gModel], GateInfo[idx][gCX], GateInfo[idx][gCY], GateInfo[idx][gCZ], GateInfo[idx][gCRX], GateInfo[idx][gCRY], GateInfo[idx][gCRZ]);
				GateInfo[idx][gStatus] = 0;
			}
			idx++;
	    }
	}
	print("Gate berhasil dimuat.");
	return 1;
}

SaveHouses() {

	new
		szFileStr[1024],
		File: fHandle = fopen("apartments.cfg", io_write);

	for(new iIndex; iIndex < MAX_HOUSES; iIndex++) {
		format(szFileStr, sizeof(szFileStr), "%d|%d|%d|%s|%s|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%f|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%f|%f|%s|%d|%d|%d|%d|%d\r\n",
			HouseInfo[iIndex][hOwned],
			HouseInfo[iIndex][hLevel],
			HouseInfo[iIndex][hHInteriorWorld],
			HouseInfo[iIndex][hDescription],
			HouseInfo[iIndex][hOwner],
			HouseInfo[iIndex][hExteriorX],
			HouseInfo[iIndex][hExteriorY],
			HouseInfo[iIndex][hExteriorZ],
			HouseInfo[iIndex][hExteriorR],
			HouseInfo[iIndex][hInteriorX],
			HouseInfo[iIndex][hInteriorY],
			HouseInfo[iIndex][hInteriorZ],
			HouseInfo[iIndex][hInteriorR],
			HouseInfo[iIndex][hGaragePos][0],
			HouseInfo[iIndex][hGaragePos][1],
			HouseInfo[iIndex][hGaragePos][2],
			HouseInfo[iIndex][hLock],
			HouseInfo[iIndex][hValue],
   			HouseInfo[iIndex][hSafeMoney],
			HouseInfo[iIndex][hPot],
			HouseInfo[iIndex][hCrack],
			HouseInfo[iIndex][hMaterials],
			HouseInfo[iIndex][hWeapons][0],
			HouseInfo[iIndex][hWeapons][1],
			HouseInfo[iIndex][hWeapons][2],
			HouseInfo[iIndex][hWeapons][3],
			HouseInfo[iIndex][hWeapons][4],
			HouseInfo[iIndex][hGLUpgrade],
			HouseInfo[iIndex][hPickupID],
			HouseInfo[iIndex][hCustomInterior],
			HouseInfo[iIndex][hCustomExterior],
			HouseInfo[iIndex][hExteriorA],
			HouseInfo[iIndex][hInteriorA],
			HouseInfo[iIndex][hAlamat],
			HouseInfo[iIndex][hWeaponsAmmo][0],
			HouseInfo[iIndex][hWeaponsAmmo][1],
			HouseInfo[iIndex][hWeaponsAmmo][2],
			HouseInfo[iIndex][hWeaponsAmmo][3],
			HouseInfo[iIndex][hWeaponsAmmo][4]
		);
		fwrite(fHandle, szFileStr);
	}
	return fclose(fHandle);
}

LoadDynamicMapIcons()
{
	new arrCoords[7][64];
	new strFromFile2[256];
	new File: file = fopen("dynamicmapicons.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(DMPInfo))
		{
			fread(file, strFromFile2);
			splits(strFromFile2, arrCoords, '|');
	  		DMPInfo[idx][dmpMarkerType] = strval(arrCoords[0]);
	  		DMPInfo[idx][dmpColor] = strval(arrCoords[1]);
	  		DMPInfo[idx][dmpVW] = strval(arrCoords[2]);
	  		DMPInfo[idx][dmpInt] = strval(arrCoords[3]);
	  		DMPInfo[idx][dmpPosX] = floatstr(arrCoords[4]);
	  		DMPInfo[idx][dmpPosY] = floatstr(arrCoords[5]);
	  		DMPInfo[idx][dmpPosZ] = floatstr(arrCoords[6]);

	  		if(DMPInfo[idx][dmpMarkerType] != 0)
	  		{
    			DMPInfo[idx][dmpMapIconID] = CreateDynamicMapIcon(DMPInfo[idx][dmpPosX], DMPInfo[idx][dmpPosY], DMPInfo[idx][dmpPosZ], DMPInfo[idx][dmpMarkerType], DMPInfo[idx][dmpColor], DMPInfo[idx][dmpVW], DMPInfo[idx][dmpInt], -1, 500.0);
			}

			idx++;
		}
		fclose(file);
	}
	return 1;
}

CreateDynamicDoor(doorid)
{
	new string[300];
	format(string, sizeof(string), "{00FFFF}[id: %d]\n{FFFF00}%s\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' to enter/exit the door.",doorid, DDoorsInfo[doorid][ddDescription]);
	//DDoorsInfo[doorid][dCP] = CreateDynamicCP(DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], 2, -1, -1, -1, 8.0);

	switch(DDoorsInfo[doorid][ddColor])
	{
	    case -1:{ /* Disable 3d Textdraw */ }
	    case 1:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWWHITE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 2:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWPINK, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 3:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWRED, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 4:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWBROWN, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 5:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWGRAY, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 6:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWOLIVE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 7:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWPURPLE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 8:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWORANGE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 9:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWAZURE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 10:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWGREEN, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 11:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWBLUE, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    case 12:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_TWBLACK, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		default:{DDoorsInfo[doorid][ddTextID] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	}

	switch(DDoorsInfo[doorid][ddPickupModel])
	{
	    case -1: { /* ENABLE Pickup */ }
		case 1:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(19130, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 2:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(19133, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 3:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(19132, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 4:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(19131, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 5:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(19134, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 6:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(19522, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 7:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(19523, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 8:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(19524, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 9:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1252, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 10:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1253, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 11:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1254, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 12:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1313, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 13:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1272, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 14:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1273, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 15:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1274, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 16:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1275, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 17:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1276, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 18:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1277, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 19:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1279, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 20:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1314, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 21:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1316, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 22:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1317, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 23:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1559, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 24:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1582, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 25:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(2894, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 26:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1210, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 27:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1212, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 28:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1239, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 29:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1240, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 30:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1241, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 31:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1242, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 32:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1247, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
		case 33:{DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1248, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW], DDoorsInfo[doorid][ddExteriorInt], -1);}
	    default:
	    {
			DDoorsInfo[doorid][ddPickupID] = CreateDynamicPickup(1318, 23, DDoorsInfo[doorid][ddExteriorX], DDoorsInfo[doorid][ddExteriorY], DDoorsInfo[doorid][ddExteriorZ], DDoorsInfo[doorid][ddExteriorVW]);
	    }
	}
}

LoadDynamicDoors()
{
	new arrCoords[25][64];
	new strFromFile2[256];
	new File: file = fopen("dynamicdoors.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(DDoorsInfo))
		{
			fread(file, strFromFile2);
			splits(strFromFile2, arrCoords, '|');
			strmid(DDoorsInfo[idx][ddDescription], arrCoords[0], 0, strlen(arrCoords[0]), 128);
	  		DDoorsInfo[idx][ddCustomInterior] = strval(arrCoords[1]);
	  		DDoorsInfo[idx][ddExteriorVW] = strval(arrCoords[2]);
	  		DDoorsInfo[idx][ddExteriorInt] = strval(arrCoords[3]);
	  		DDoorsInfo[idx][ddInteriorVW] = strval(arrCoords[4]);
	  		DDoorsInfo[idx][ddInteriorInt] = strval(arrCoords[5]);
	  		DDoorsInfo[idx][ddExteriorX] = floatstr(arrCoords[6]);
	  		DDoorsInfo[idx][ddExteriorY] = floatstr(arrCoords[7]);
	  		DDoorsInfo[idx][ddExteriorZ] = floatstr(arrCoords[8]);
	  		DDoorsInfo[idx][ddExteriorA] = floatstr(arrCoords[9]);
	  		DDoorsInfo[idx][ddInteriorX] = floatstr(arrCoords[10]);
	  		DDoorsInfo[idx][ddInteriorY] = floatstr(arrCoords[11]);
	  		DDoorsInfo[idx][ddInteriorZ] = floatstr(arrCoords[12]);
	  		DDoorsInfo[idx][ddInteriorA] = floatstr(arrCoords[13]);
	  		DDoorsInfo[idx][ddCustomExterior] = strval(arrCoords[14]);
	  		DDoorsInfo[idx][ddVIP] = strval(arrCoords[15]);
	  		DDoorsInfo[idx][ddFamily] = strval(arrCoords[16]);
	  		DDoorsInfo[idx][ddFaction] = strval(arrCoords[17]);
	  		DDoorsInfo[idx][ddAdmin] = strval(arrCoords[18]);
	  		DDoorsInfo[idx][ddWanted] = strval(arrCoords[19]);
	  		DDoorsInfo[idx][ddVehicleAble] = strval(arrCoords[20]);
	  		DDoorsInfo[idx][ddColor] = strval(arrCoords[21]);
	  		DDoorsInfo[idx][ddPickupModel] = strval(arrCoords[22]);
	  		strmid(DDoorsInfo[idx][dPass], arrCoords[23], 0, strlen(arrCoords[23]), 24);
	  		DDoorsInfo[idx][dLocked] = strval(arrCoords[24]);
	  		if(DDoorsInfo[idx][ddExteriorX])
	  		{
		  		if(!IsNull(DDoorsInfo[idx][ddDescription]))
		  		{
		  		    CreateDynamicDoor(idx);
				}
			}
			idx++;
		}
		fclose(file);
	}
	return 1;
}

LoadHouses()
{
	if(!fexist("apartments.cfg")) return 1;
	new
		szFileStr[1024],
		File: iFileHandle = fopen("apartments.cfg", io_read),
		iIndex;
	while(iIndex < sizeof(HouseInfo) && fread(iFileHandle, szFileStr)) {
		sscanf(szFileStr, "p<|>iiis[128]s[32]fffffffffffiiiiiiiiiiiiiiiffs[128]iiiii",
			HouseInfo[iIndex][hOwned],
			HouseInfo[iIndex][hLevel],
			HouseInfo[iIndex][hHInteriorWorld],
			HouseInfo[iIndex][hDescription],
			HouseInfo[iIndex][hOwner],
			HouseInfo[iIndex][hExteriorX],
			HouseInfo[iIndex][hExteriorY],
			HouseInfo[iIndex][hExteriorZ],
			HouseInfo[iIndex][hExteriorR],
			HouseInfo[iIndex][hInteriorX],
			HouseInfo[iIndex][hInteriorY],
			HouseInfo[iIndex][hInteriorZ],
			HouseInfo[iIndex][hInteriorR],
			HouseInfo[iIndex][hGaragePos][0],
			HouseInfo[iIndex][hGaragePos][1],
			HouseInfo[iIndex][hGaragePos][2],
			HouseInfo[iIndex][hLock],
			HouseInfo[iIndex][hValue],
			HouseInfo[iIndex][hSafeMoney],
			HouseInfo[iIndex][hPot],
			HouseInfo[iIndex][hCrack],
			HouseInfo[iIndex][hMaterials],
			HouseInfo[iIndex][hWeapons][0],
			HouseInfo[iIndex][hWeapons][1],
			HouseInfo[iIndex][hWeapons][2],
			HouseInfo[iIndex][hWeapons][3],
			HouseInfo[iIndex][hWeapons][4],
			HouseInfo[iIndex][hGLUpgrade],
			HouseInfo[iIndex][hPickupID],
			HouseInfo[iIndex][hCustomInterior],
			HouseInfo[iIndex][hCustomExterior],
			HouseInfo[iIndex][hExteriorA],
			HouseInfo[iIndex][hInteriorA],
			HouseInfo[iIndex][hAlamat],
 			HouseInfo[iIndex][hWeaponsAmmo][0],
 			HouseInfo[iIndex][hWeaponsAmmo][1],
 			HouseInfo[iIndex][hWeaponsAmmo][2],
 			HouseInfo[iIndex][hWeaponsAmmo][3],
 			HouseInfo[iIndex][hWeaponsAmmo][4]
		);
		if(HouseInfo[iIndex][hExteriorX])
		{
			if(HouseInfo[iIndex][hOwned])
			{
				format(szFileStr, sizeof(szFileStr), "{00FFFF}[id:%d]\n{00FF00}Owner: {FFFFFF}%s{00FF00}\nAddres: {FFFFFF}%s",iIndex,HouseInfo[iIndex][hOwner],HouseInfo[iIndex][hAlamat]);
			}
			else
			{
				format(szFileStr, sizeof(szFileStr), "{FF0000}House for Sale{00FF00}\nInterior: {FFFFFF}%s\n{00FF00}Price: {FFFFFF}%s\n{00FF00}Level: {FFFFFF}%d\n{00FF00}Addres: {FFFFFF}%s\n{00FF00}ID: {FFFFFF}%d\n{00FF00}use '/buyhouse' for purchase this house",HouseInfo[iIndex][hDescription],FormatMoney(HouseInfo[iIndex][hValue]),HouseInfo[iIndex][hLevel],HouseInfo[iIndex][hAlamat],iIndex);
			}
			HouseInfo[iIndex][hPickupID] = CreateDynamicPickup(19132, 23, HouseInfo[iIndex][hExteriorX], HouseInfo[iIndex][hExteriorY], HouseInfo[iIndex][hExteriorZ]);
			HouseInfo[iIndex][hTextID] = CreateDynamic3DTextLabel(szFileStr, COLOR_GREEN, HouseInfo[iIndex][hExteriorX], HouseInfo[iIndex][hExteriorY], HouseInfo[iIndex][hExteriorZ]+1,10.0, .testlos = 1, .streamdistance = 5.0);
			CreateDynamicCP(HouseInfo[iIndex][hExteriorX], HouseInfo[iIndex][hExteriorY], HouseInfo[iIndex][hExteriorZ], 2,  0, -1, -1, 5.0);
			CreateDynamicCP(HouseInfo[iIndex][hInteriorX], HouseInfo[iIndex][hInteriorY], HouseInfo[iIndex][hInteriorZ], 2,  0, -1, -1, 5.0);
		}
		++iIndex;
		}
	return fclose(iFileHandle);
}


public OnGameModeInit()
{
	SetTimer("CheckGate", 1000, true);
	SetTimer("AutoPark", 60000*5, true);
	SetTimer("antiCheat", 300, true);
	SetTimer("HBE", 300, true);
	SetTimer("PLANTUPDATE", 60000*5, true);
	AntiDeAMX();
	djson_OnGameModeInit();
	ServerLocked = false;
	/*/NPC Bus
	//NPCs
	ConnectNPC("Bedjo","Bus");
	ConnectNPC("Sanusi","Bus2");*/

	new String[1000];
	//CheckPoint Door
	//
	toylist = LoadModelSelectionMenu("toylist.txt");
	vtoylist = LoadModelSelectionMenu("vtoylist.txt");
	skinlist = LoadModelSelectionMenu("skins.txt");
	FACTIONSKIN = LoadModelSelectionMenu("skins.txt");
	toy1000list = LoadModelSelectionMenu("toys1000.txt");

	CheckFiles();
    SetTimer("settime",1000,true);
    BUD::Setting(opt.Database, "iAnims.db" );
	BUD::Setting(opt.Asynchronous, true );
	BUD::Setting(opt.KeepAliveTime, 3000 );
	BUD::Initialize();
	BUD::VerifyColumn("speed", BUD::TYPE_FLOAT, IANIM_DEFAULT_SPEED);
	BUD::VerifyColumn("loop", BUD::TYPE_NUMBER, IANIM_DEFAULT_LOOP);
	BUD::VerifyColumn("lockx", BUD::TYPE_NUMBER, IANIM_DEFAULT_LOCKX);
	BUD::VerifyColumn("locky", BUD::TYPE_NUMBER, IANIM_DEFAULT_LOCKY);
	BUD::VerifyColumn("freeze", BUD::TYPE_NUMBER, IANIM_DEFAULT_FREEZE);
	BUD::VerifyColumn("time", BUD::TYPE_NUMBER, IANIM_DEFAULT_TIME);
	BUD::VerifyColumn("forcesync", BUD::TYPE_NUMBER, IANIM_DEFAULT_FORCESYNC);
	#if defined LOAD_ON_START
	new
	dbstr[64];

	for(new i = 1; i < MAX_ANIMS; i++)
	{
		format(dbstr, sizeof( dbstr ), "Animation%d", i);
		if( !BUD::IsNameRegistered( dbstr ) )
		{
			BUD::RegisterName(dbstr, dbstr);
			iAnim_AnimData[ i ][ iAnim_Speed ] = IANIM_DEFAULT_SPEED;
			iAnim_AnimData[ i ][ iAnim_Loop ] = IANIM_DEFAULT_LOOP;
			iAnim_AnimData[ i ][ iAnim_Lockx ] = IANIM_DEFAULT_LOCKX;
			iAnim_AnimData[ i ][ iAnim_Locky ] = IANIM_DEFAULT_LOCKY;
			iAnim_AnimData[ i ][ iAnim_Freeze ] = IANIM_DEFAULT_FREEZE;
			iAnim_AnimData[ i ][ iAnim_Time ] = IANIM_DEFAULT_TIME;
			iAnim_AnimData[ i ][ iAnim_ForceSync ] = IANIM_DEFAULT_FORCESYNC;
		}
		else
		{
			BUD::MultiGet( i , "fiiiiii",
			"speed", iAnim_AnimData[ i ][ iAnim_Speed ],
			"loop", iAnim_AnimData[ i ][ iAnim_Loop ],
			"lockx", iAnim_AnimData[ i ][ iAnim_Lockx ],
			"locky", iAnim_AnimData[ i ][ iAnim_Locky ],
			"freeze", iAnim_AnimData[ i ][ iAnim_Freeze ],
			"time", iAnim_AnimData[ i ][ iAnim_Time ],
			"forcesync",iAnim_AnimData[ i ][ iAnim_ForceSync ]
			);
		}
	}
	#endif
	//Animations
	txtAnimHelper = TextDrawCreate(542.000000, 417.000000, "~r~~k~~PED_SPRINT~ ~w~untuk menghentikan Animations");
	TextDrawUseBox(txtAnimHelper, 0);
	TextDrawFont(txtAnimHelper, 2);
	TextDrawSetShadow(txtAnimHelper,0); // no shadow
	TextDrawSetOutline(txtAnimHelper,1); // thickness 1
	TextDrawBackgroundColor(txtAnimHelper,0x000000FF);
	TextDrawColor(txtAnimHelper,0xFFFFFFFF);
	TextDrawAlignment(txtAnimHelper,3); // align right
	

	//Body Status
	BSText[0] = TextDrawCreate(687.599609, 333.766571, "usebox");
	TextDrawLetterSize(BSText[0], 0.000000, 14.584074);
	TextDrawTextSize(BSText[0], 469.200042, 0.000000);
	TextDrawAlignment(BSText[0], 1);
	TextDrawColor(BSText[0], 0);
	TextDrawUseBox(BSText[0], true);
	TextDrawBoxColor(BSText[0], 102);
	TextDrawSetShadow(BSText[0], 0);
	TextDrawSetOutline(BSText[0], 0);
	TextDrawFont(BSText[0], 0);

	BSText[1] = TextDrawCreate(510.399993, 344.213348, "-");
	TextDrawLetterSize(BSText[1], 5.769995, 1.376000);
	TextDrawAlignment(BSText[1], 1);
	TextDrawColor(BSText[1], -1);
	TextDrawSetShadow(BSText[1], 0);
	TextDrawSetOutline(BSText[1], 1);
	TextDrawBackgroundColor(BSText[1], 51);
	TextDrawFont(BSText[1], 1);
	TextDrawSetProportional(BSText[1], 1);

	BSText[2] = TextDrawCreate(541.599731, 433.066833, "hud:radar_diner");
	TextDrawLetterSize(BSText[2], 0.000000, 0.000000);
	TextDrawTextSize(BSText[2], 9.599988, 13.439994);
	TextDrawAlignment(BSText[2], 1);
	TextDrawColor(BSText[2], -1);
	TextDrawSetShadow(BSText[2], 0);
	TextDrawSetOutline(BSText[2], 0);
	TextDrawFont(BSText[2], 4);

	BSText[3] = TextDrawCreate(536.799560, 352.426727, "New Textdraw");
	TextDrawLetterSize(BSText[3], 0.449999, 1.600000);
	TextDrawTextSize(BSText[3], 14.400012, 21.653347);
	TextDrawAlignment(BSText[3], 1);
	TextDrawColor(BSText[3], -1);
	TextDrawUseBox(BSText[3], true);
	TextDrawBoxColor(BSText[3], 0);
	TextDrawSetShadow(BSText[3], 0);
	TextDrawSetOutline(BSText[3], 1);
	TextDrawBackgroundColor(BSText[3], -871318784);
	TextDrawFont(BSText[3], 5);
	TextDrawSetProportional(BSText[3], 1);
	TextDrawSetPreviewModel(BSText[3], 1240);
	TextDrawSetPreviewRot(BSText[3], 341.000000, 0.000000, 0.000000, 1.000000);

	BSText[4] = TextDrawCreate(538.399719, 401.707000, "hud:radar_dateFood");
	TextDrawLetterSize(BSText[4], -0.007199, -0.149333);
	TextDrawTextSize(BSText[4], 11.200010, 11.946665);
	TextDrawAlignment(BSText[4], 1);
	TextDrawColor(BSText[4], -1);
	TextDrawSetShadow(BSText[4], 0);
	TextDrawSetOutline(BSText[4], 0);
	TextDrawFont(BSText[4], 4);

	BSText[5] = TextDrawCreate(535.199829, 368.853393, "New Textdraw");
	TextDrawLetterSize(BSText[5], 0.449999, 1.600000);
	TextDrawTextSize(BSText[5], 16.800006, 23.146678);
	TextDrawAlignment(BSText[5], 1);
	TextDrawColor(BSText[5], -1);
	TextDrawUseBox(BSText[5], true);
	TextDrawBoxColor(BSText[5], 0);
	TextDrawSetShadow(BSText[5], 0);
	TextDrawSetOutline(BSText[5], 1);
	TextDrawBackgroundColor(BSText[5], -871318784);
	TextDrawFont(BSText[5], 5);
	TextDrawSetProportional(BSText[5], 1);
	TextDrawSetPreviewModel(BSText[5], 1242);
	TextDrawSetPreviewRot(BSText[5], 0.000000, 0.000000, 0.000000, 1.000000);

	BSText[6] = TextDrawCreate(537.599914, 413.653381, "New Textdraw");
	TextDrawLetterSize(BSText[6], 0.449999, 1.600000);
	TextDrawTextSize(BSText[6], 20.800050, 18.666669);
	TextDrawAlignment(BSText[6], 1);
	TextDrawColor(BSText[6], -1);
	TextDrawUseBox(BSText[6], true);
	TextDrawBoxColor(BSText[6], 0);
	TextDrawSetShadow(BSText[6], 0);
	TextDrawSetOutline(BSText[6], 0);
	TextDrawBackgroundColor(BSText[6], -871318784);
	TextDrawFont(BSText[6], 5);
	TextDrawSetProportional(BSText[6], 1);
	TextDrawSetPreviewModel(BSText[6], 2525);
	TextDrawSetPreviewRot(BSText[6], 343.000000, 0.000000, -110.000000, 1.000000);

	BSText[7] = TextDrawCreate(495.999847, 351.679931, "");
	TextDrawLetterSize(BSText[7], 0.169999, 2.279466);
	TextDrawAlignment(BSText[7], 1);
	TextDrawColor(BSText[7], -1);
	TextDrawUseBox(BSText[7], true);
	TextDrawBoxColor(BSText[7], 0);
	TextDrawSetShadow(BSText[7], 0);
	TextDrawSetOutline(BSText[7], 1);
	TextDrawBackgroundColor(BSText[7], 51);
	TextDrawFont(BSText[7], 2);
	TextDrawSetProportional(BSText[7], 1);

	sen = TextDrawCreate(580.000000, 80.000000, ".");
	TextDrawBackgroundColor(sen, 255);
	TextDrawFont(sen, 1);
	TextDrawLetterSize(sen, 0.549999, 2.200002);
	TextDrawColor(sen, 794437320);
	TextDrawSetOutline(sen, 1);
	TextDrawSetProportional(sen, 1);
	TextDrawSetSelectable(sen, 0);

	koma2 = TextDrawCreate(543.000000, 80.000000, ",");
	TextDrawBackgroundColor(koma2, 255);
	TextDrawFont(koma2, 0);
	TextDrawLetterSize(koma2, 0.549999, 2.200002);
	TextDrawColor(koma2, 794437320);
	TextDrawSetOutline(koma2, 1);
	TextDrawSetProportional(koma2, 1);
	TextDrawSetSelectable(koma2, 0);

	Kotak = TextDrawCreate(636.000000, 152.000000, ".");
	TextDrawBackgroundColor(Kotak, 255);
	TextDrawFont(Kotak, 1);
	TextDrawLetterSize(Kotak, 120.299995, 8.900002);
	TextDrawColor(Kotak, -1);
	TextDrawSetOutline(Kotak, 1);
	TextDrawSetProportional(Kotak, 1);
	TextDrawUseBox(Kotak, 1);
	TextDrawBoxColor(Kotak, 45);
	TextDrawTextSize(Kotak, 533.000000, 92.000000);
	TextDrawSetSelectable(Kotak, 0);

	/*Date = TextDrawCreate(532.000000, 4.000000, "14/01/2014");//Born ArWin14
	TextDrawBackgroundColor(Date, 255);
	TextDrawFont(Date, 1);
	TextDrawLetterSize(Date, 0.410000, 1.000000);
	TextDrawColor(Date, -1);
	TextDrawSetOutline(Date, 0);
	TextDrawSetProportional(Date, 1);
	TextDrawSetShadow(Date, 1);
	TextDrawSetSelectable(Date, 0);

	Time = TextDrawCreate(540.000000, 17.000000, "09:55:00");//Born ArWin14
	TextDrawBackgroundColor(Time, 255);
	TextDrawFont(Time, 1);
	TextDrawLetterSize(Time, 0.410000, 1.000000);
	TextDrawColor(Time, -1);
	TextDrawSetOutline(Time, 0);
	TextDrawSetProportional(Time, 1);
	TextDrawSetShadow(Time, 1);
	TextDrawSetSelectable(Time, 0);*/
	Date = TextDrawCreate(3.000000, 433.000000,"--");
	TextDrawBackgroundColor	(Date, 255);
	TextDrawFont(Date, 1);
	TextDrawLetterSize(Date, 0.40000, 1.400000);
	TextDrawColor(Date, -1);
	TextDrawSetOutline(Date, 1);
	TextDrawSetProportional(Date, 1);

	Time = TextDrawCreate(547.000000,28.000000,"--");
	TextDrawFont(Time,3);
	TextDrawLetterSize(Time, 0.40000, 1.400000);
 	TextDrawFont(Time , 2);
 	TextDrawSetOutline(Time , 1);
    TextDrawSetProportional(Time , 1);
	TextDrawBackgroundColor(Time, 255);
	TextDrawSetShadow(Time, 1);
	TextDrawColor(Time,0xFFFFFFFF);
	SetTimer("LuX_SpeedoMeterUp", UpdateConfig, 1);
    for(new v=0; v<MAX_VEHICLES; v++)
	{
    	LuX_ReadPosition(v);}
		for(new i; i<PLAYERS; i++)
		{
		AntiFlood_InitPlayer(i);
	//---------------------------------------------------------->
		LBox[i] = TextDrawCreate(155.000000, 350.000000, "_");
		TextDrawBackgroundColor(LBox[i], 255);
		TextDrawFont(LBox[i], 0);
		TextDrawLetterSize(LBox[i], 0.600000, 7.899996);
		TextDrawColor(LBox[i], 75);
		TextDrawSetOutline(LBox[i], 0);
		TextDrawSetProportional(LBox[i], 1);
		TextDrawSetShadow(LBox[i], 1);
		TextDrawUseBox(LBox[i], 1);
		TextDrawBoxColor(LBox[i], 0x000000AA);
		TextDrawTextSize(LBox[i], 345.000000, 0.000000);
		TextDrawSetSelectable(LBox[i], 0);

	//---------------------------------------------------------->

		LLine1[i] = TextDrawCreate(216.000000, 348.000000, "Saddler");
		TextDrawBackgroundColor(LLine1[i], 255);
		TextDrawFont(LLine1[i], 0);
		TextDrawLetterSize(LLine1[i], 0.539999, 1.500004);
		TextDrawColor(LLine1[i], -1);
		TextDrawSetOutline(LLine1[i], 0);
		TextDrawSetProportional(LLine1[i], 1);
		TextDrawSetShadow(LLine1[i], 1);
		TextDrawSetSelectable(LLine1[i], 0);

	//---------------------------------------------------------->
		LLine2[i] = TextDrawCreate(160.000000, 370.000000, "");
		TextDrawBackgroundColor(LLine2[i], 255);
		TextDrawFont(LLine2[i], 1);
		TextDrawLetterSize(LLine2[i], 0.539999, 1.500004);
		TextDrawColor(LLine2[i], -1);
		TextDrawSetOutline(LLine2[i], 0);
		TextDrawSetProportional(LLine2[i], 1);
		TextDrawSetShadow(LLine2[i], 1);
		TextDrawSetSelectable(LLine2[i], 0);
	//---------------------------------------------------------->

		LLine3[i] = TextDrawCreate(175.100000, 394.000000, "");
		TextDrawBackgroundColor(LLine3[i], 255);
		TextDrawFont(LLine3[i], 1);
		TextDrawLetterSize(LLine3[i], 0.539999, 1.500004);
		TextDrawColor(LLine3[i], -1);
		TextDrawSetOutline(LLine3[i], 0);
		TextDrawSetProportional(LLine3[i], 1);
		TextDrawSetShadow(LLine3[i], 1);
		TextDrawSetSelectable(LLine3[i], 0);

	//---------------------------------------------------------->

		GPS[i] = TextDrawCreate(11.999984, 322.560089, "Loading");
		TextDrawAlignment(GPS[i], 0);
		TextDrawBackgroundColor(GPS[i], 255);
		TextDrawFont(GPS[i], 1);
		TextDrawLetterSize(GPS[i], 0.449999, 1.600000);
		TextDrawColor(GPS[i], -1);
		TextDrawSetOutline(GPS[i], 0);
		TextDrawSetProportional(GPS[i], 1);
	}
	EnableStuntBonusForAll(0);
	new servergmtextstr[128];
	format(servergmtextstr, 128, "gamemodetext %s", SERVER_GM_TEXT);
	SendRconCommand(servergmtextstr); // DO NOT REMOVE THIS
    format(servergmtextstr, 128, "language %s", SERVER_GM_LANGUAGE);
    SendRconCommand(servergmtextstr);
	new String1[MAX_PLAYER_NAME];
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_STREAMED);
	DisableInteriorEnterExits();
	LoadWorkshop();
 	LoadBizz();
	LoadFarm();
	LoadATM();
	LoadStock();
	LoadMaxLimit();
	LoadDynamicDoors();
	LoadDynamicMapIcons();
	LoadHouses();
	LoadGates();
	LoadcDealerships();
	LoadMod();
 	//LoadPlant();
	LoadBuy();
	LoadGYMObject();
	LoadRent();
	LoadObjects();
	LoadStuff();
	LoadElevatorStuff();
	LoadServerStats();
	LoadFamilies();

	for(new f = 0; f < sizeof(FamilyInfo); f++)
	{
		for(new fv = 0; fv < MAX_GANG_VEHICLES; fv++)
		{
		    FamilyVehicleInfo[f][fv][fvModelId] = 0;
			FamilyVehicleInfo[f][fv][fvSpawnx] = 0.0;
			FamilyVehicleInfo[f][fv][fvSpawny] = 0.0;
			FamilyVehicleInfo[f][fv][fvSpawnz] = 0.0;
			FamilyVehicleInfo[f][fv][fvSpawna] = 0.0;
			FamilyVehicleInfo[f][fv][fvPaintJob] = -1;
			FamilyVehicleInfo[f][fv][fvColor1] = 126;
			FamilyVehicleInfo[f][fv][fvColor2] = 126;
			FamilyVehicleInfo[f][fv][fvPrice] = 0;
			FamilyVehicleInfo[f][fv][fvFuel] = 100.0;
	    	FamilyVehicleInfo[f][fv][fvId] = INVALID_VEHICLE_ID;
		}
	}
	LoadFamiliesHQ();
	LoadMOTDs();
	ClearReports();
	SetNameTagDrawDistance(10.0);
	GiftAllowed = 1;
	News[hTaken1] = 0; News[hTaken2] = 0; News[hTaken3] = 0; News[hTaken4] = 0; News[hTaken5] = 0;
	format(String, sizeof(String), "Nothing");
	strmid(News[hAdd1], String, 0, strlen(String), 255);
	strmid(News[hAdd2], String, 0, strlen(String), 255);
	strmid(News[hAdd3], String, 0, strlen(String), 255);
	strmid(News[hAdd4], String, 0, strlen(String), 255);
	strmid(News[hAdd5], String, 0, strlen(String), 255);
	format(String1, sizeof(String1), "No-one");
	strmid(News[hContact1], String1, 0, strlen(String1), 255);
	strmid(News[hContact2], String1, 0, strlen(String1), 255);
	strmid(News[hContact3], String1, 0, strlen(String1), 255);
	strmid(News[hContact4], String1, 0, strlen(String1), 255);
	strmid(News[hContact5], String1, 0, strlen(String1), 255);
	format(objstore, sizeof(objstore), "MOLE: I got nothing, check back with me later.");
	format(cbjstore, sizeof(cbjstore), "HQ: There is nothing in your Vicinity, Out.");
	gettime(ghour, gminute, gsecond);
	FixHour(ghour);
	ghour = shifthour;

	if(!realtime)
	{
		SetWorldTime(wtime);
		gTime = wtime;
	}

	AllowInteriorWeapons(1);
	// CreatedCars check
	for(new i = 0; i < sizeof(CreatedCars); i++)
	{
		CreatedCars[i] = INVALID_VEHICLE_ID;
	}
	for(new v = 0; v < MAX_VEHICLES; v++)
	{
	    VehicleFuel[v] = 100.0;
	}
	// Player Class's
	for(new i = 0; i <= sizeof(Peds)-1; i++)
	{
		AddPlayerClass(Peds[i][0],1958.3783,1343.1572,1100.3746,269.1425,-1,-1,-1,-1,-1,-1);
	}
	//TextDrawTextSize(MsgBox, 602.000000, 0.000000);
	DisableInteriorEnterExits();
	//Sweeper
	SWEEPERPlate[0] = SWEEPER[0] = AddStaticVehicleEx(574, 1626.1691,-1896.3145,13.2765,357.4089, 1, 1, 1);
	SetVehicleNumberPlate(SWEEPERPlate[0], "SWEEPER");
	SWEEPERPlate[1] = SWEEPER[1] = AddStaticVehicleEx(574, 1622.7128,-1896.3400,13.2757,358.0077, 1, 1, 1);
	SetVehicleNumberPlate(SWEEPERPlate[1], "SWEEPER");
	SWEEPERPlate[2] = SWEEPER[2] = AddStaticVehicleEx(574, 1619.3044,-1896.3998,13.2737,359.5278, 1, 1, 1);
	SetVehicleNumberPlate(SWEEPERPlate[2], "SWEEPER");
	//Bus
	BusPlate[0] = BUS[0] = AddStaticVehicleEx(431, 1698.3337, -1496.5729, 13.4855, 359.1141, 3, 1, 1);
	SetVehicleNumberPlate(BusPlate[0], "BUS");
	BusPlate[1] = BUS[1] = AddStaticVehicleEx(431, 1698.2653, -1511.8468, 13.4872, 359.8352, 6, 1, 1);
	SetVehicleNumberPlate(BusPlate[1], "BUS");
	BusPlate[2] = BUS[2] = AddStaticVehicleEx(431, 1698.4172, -1526.7191, 13.4833, 0.4046, 2, 1, 1);
	SetVehicleNumberPlate(BusPlate[2], "BUS");
	
	//LSPD VEHICLES
	//Lincol Merah Putih
	LincolnMerah[1] = LSPDVehicles[30] = AddStaticVehicleEx(596,1602.3312,-1684.0071,5.6185,91.2188,3,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnMerah[1], "LINCON-1");
	SetVehicleHealth(LincolnMerah[1], 2000.0);
	AddVehicleComponent(LincolnMerah[1], 1080);
	LincolnMerah[2] = LSPDVehicles[31] = AddStaticVehicleEx(596,1602.5184,-1687.9525,5.6098,89.0430,3,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnMerah[2], "LINCON-2");
	SetVehicleHealth(LincolnMerah[2], 2000.0);
	AddVehicleComponent(LincolnMerah[2], 1080);
	LincolnMerah[3] = LSPDVehicles[32] = AddStaticVehicleEx(596,1602.3141,-1692.2067,5.6149,89.1927,3,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnMerah[3], "LINCON-3");
	SetVehicleHealth(LincolnMerah[3], 2000.0);
	AddVehicleComponent(LincolnMerah[3], 1080);
	LincolnMerah[4] = LSPDVehicles[33] = AddStaticVehicleEx(596,1602.2833,-1696.3682,5.6286,90.2932,3,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnMerah[4], "LINCON-4");
	SetVehicleHealth(LincolnMerah[4], 2000.0);
	AddVehicleComponent(LincolnMerah[4], 1080);
	LincolnMerah[5] = LSPDVehicles[34] = AddStaticVehicleEx(596,1602.1863,-1700.2629,5.6161,88.2802,3,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnMerah[5], "LINCON-5");
	SetVehicleHealth(LincolnMerah[5], 2000.0);
	AddVehicleComponent(LincolnMerah[5], 1080);
	//Lincoln Ungu Putih
	LincolnUngu[1] = LSPDVehicles[35] = AddStaticVehicleEx(596,1595.1029,-1711.1693,5.6132,358.1242,134,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnUngu[1], "LINCON-6");
	SetVehicleHealth(LincolnUngu[1], 2000.0);
	AddVehicleComponent(LincolnUngu[1], 1074);
	LincolnUngu[2] = LSPDVehicles[36] = AddStaticVehicleEx(596,1591.2061,-1711.1152,5.6060,357.9518,134,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnUngu[2], "LINCON-7");
	SetVehicleHealth(LincolnUngu[2], 2000.0);
	AddVehicleComponent(LincolnUngu[2], 1074);
	LincolnUngu[3] = LSPDVehicles[37] = AddStaticVehicleEx(596,1587.8042,-1711.0640,5.6139,0.4377,134,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnUngu[3], "LINCON-8");
	SetVehicleHealth(LincolnUngu[3], 2000.0);
	AddVehicleComponent(LincolnUngu[3], 1074);
	LincolnUngu[4] = LSPDVehicles[38] = AddStaticVehicleEx(596,1583.5166,-1710.9095,5.6262,357.2809,134,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(LincolnUngu[4], "LINCON-9");
	SetVehicleHealth(LincolnUngu[4], 2000.0);
	AddVehicleComponent(LincolnUngu[4], 1074);
	//Adam Unit
	Cruiser[1] = LSPDVehicles[0] = AddStaticVehicleEx(596,1602.6895,-1668.1362,5.6290,88.5506,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(Cruiser[1], "ADAM-1");
	SetVehicleHealth(Cruiser[1], 2000.0);
	AddVehicleComponent(Cruiser[2], 1074);
	Cruiser[2] = LSPDVehicles[1] = AddStaticVehicleEx(596,1602.6876,-1672.0906,5.6202,85.4490,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(Cruiser[2], "ADAM-2");
	SetVehicleHealth(Cruiser[2], 2000.0);
	AddVehicleComponent(Cruiser[2], 1074);
	Cruiser[3] = LSPDVehicles[2] = AddStaticVehicleEx(596,1602.4028,-1675.8799,5.5399,88.2919,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(Cruiser[3], "ADAM-3");
	SetVehicleHealth(Cruiser[3], 2000.0);
	AddVehicleComponent(Cruiser[3], 1074);
	Cruiser[4] = LSPDVehicles[3] = AddStaticVehicleEx(596,1602.3943,-1679.8274,5.5385,89.4124,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(Cruiser[4], "ADAM-4");
	SetVehicleHealth(Cruiser[4], 2000.0);
	AddVehicleComponent(Cruiser[4], 1074);
	//Detective
	LSPDVehicles[4] = AddStaticVehicleEx(468,1545.6774,-1671.9430,5.5675,83.3683,1,99, VEHICLE_RESPAWN); // Sanchez
	LSPDVehicles[5] = AddStaticVehicleEx(445,1545.9200,-1676.2919,5.7573,88.8056,168,168, VEHICLE_RESPAWN); // Admiral
	LSPDVehicles[6] = AddStaticVehicleEx(482,1546.0643,-1680.3092,6.0089,90.3870,6,6, VEHICLE_RESPAWN); // Burrito
	LSPDVehicles[7] = AddStaticVehicleEx(426,1545.7401,-1684.4756,5.6338,89.4337,61,105, VEHICLE_RESPAWN); // Premier
	//KOPASSUS
	Kopassus[0] = LSPDVehicles[9] = AddStaticVehicleEx(601,1526.5850,-1644.1801,5.6494,180.3210,1,1, VEHICLE_RESPAWN); // Splashy
	SetVehicleNumberPlate(Kopassus[0], "KING-3");
	SetVehicleHealth(Kopassus[0], 10000.0);
	Kopassus[1] = LSPDVehicles[10] = AddStaticVehicleEx(601,1530.7244,-1644.2538,5.6494,179.6148,1,1, VEHICLE_RESPAWN); // Splashy
	SetVehicleNumberPlate(Kopassus[1], "KING-4");
	SetVehicleHealth(Kopassus[0], 10000.0);
	Kopassus[2] = LSPDVehicles[11] = AddStaticVehicleEx(427,1534.8553,-1644.8682,6.0226,180.7921,0,0, VEHICLE_RESPAWN); // Enforcer
	SetVehicleNumberPlate(Kopassus[2], "KING-5");
	SetVehicleHealth(Kopassus[2], 10000.0);
	Kopassus[3] = LSPDVehicles[12] = 	AddStaticVehicleEx(427,1538.9325,-1644.9508,6.0226,179.5991,0,0, VEHICLE_RESPAWN); // Enforcer
	SetVehicleNumberPlate(Kopassus[3], "KING-6");
	SetVehicleHealth(Kopassus[3], 10000.0);
	//RAPTOR UNIT
	Lincoln[2] = LSPDVehicles[13] = AddStaticVehicleEx(415,1578.2784,-1711.2347,5.6581,1.8089,7,7, VEHICLE_RESPAWN); // Cheetah
	SetVehicleNumberPlate(Lincoln[2], "RAPTOR-1");
	SetVehicleHealth(Lincoln[2], 2000.0);
	AddVehicleComponent(Lincoln[2], 1074);
	Lincoln[3] = LSPDVehicles[14] = AddStaticVehicleEx(541,1574.4041,-1710.9807,5.5237,1.5713,7,1, VEHICLE_RESPAWN); // Bullet
	SetVehicleNumberPlate(Lincoln[3], "RAPTOR-2");
	SetVehicleHealth(Lincoln[3], 2000.0);
	AddVehicleComponent(Lincoln[3], 1074);
	Lincoln[4] = LSPDVehicles[15] = AddStaticVehicleEx(451,1570.1910,-1710.7435,5.6189,358.7257,7,7, VEHICLE_RESPAWN); // Turismo
	SetVehicleNumberPlate(Lincoln[4], "RAPTOR-3");
	SetVehicleHealth(Lincoln[4], 2000.0);
	AddVehicleComponent(Lincoln[4], 1074);
	Lincoln[5] = LSPDVehicles[16] = AddStaticVehicleEx(411,1558.6840,-1710.7120,5.6177,0.0276,7,7, VEHICLE_RESPAWN); // Infernus
	SetVehicleNumberPlate(Lincoln[5], "RAPTOR-4");
	SetVehicleHealth(Lincoln[5], 2000.0);
	AddVehicleComponent(Lincoln[5], 1074);
	//MAVERICK
	Kopassus[4] = LSPDVehicles[18] = AddStaticVehicleEx(497,1565.0839,-1643.2800,28.5921,89.4944,0,1, VEHICLE_RESPAWN); // Maverick
	SetVehicleNumberPlate(Kopassus[4], "CHOPPER-1");
	Kopassus[5] = LSPDVehicles[19] = AddStaticVehicleEx(497,1564.4895,-1703.4138,28.5848,87.6184,0,1, VEHICLE_RESPAWN); // Maverick
	SetVehicleNumberPlate(Kopassus[5], "CHOPPER-2");
	//RANCHER
	Kopassus[8] = LSPDVehicles[8] = AddStaticVehicleEx(490,1545.7213,-1655.0195,6.0814,90.4218,0,1, VEHICLE_RESPAWN); // Rancher
	SetVehicleNumberPlate(Kopassus[8], "KING-1");
	SetVehicleHealth(Kopassus[8], 10000.0);
	Kopassus[9] = LSPDVehicles[9] = AddStaticVehicleEx(490,1545.8069,-1651.1516,6.0790,88.2897,0,1, VEHICLE_RESPAWN); // Rancher
	SetVehicleNumberPlate(Kopassus[9], "KING-2");
	SetVehicleHealth(Kopassus[9], 10000.0);
	//Zeus Unit
	ZeusUnit[1] = LSPDVehicles[20] = AddStaticVehicleEx(525,1528.3439,-1684.0914,5.7702,269.9949,1,0, VEHICLE_RESPAWN); // Towtruck
	SetVehicleNumberPlate(ZeusUnit[1], "ZEUS-1");
	AddVehicleComponent(ZeusUnit[1], 1074);
	ZeusUnit[2] = LSPDVehicles[21] = AddStaticVehicleEx(525,1528.6476,-1688.2294,5.7698,269.9370,1,0, VEHICLE_RESPAWN); // Towtruck
	SetVehicleNumberPlate(ZeusUnit[2], "ZEUS-2");
	AddVehicleComponent(ZeusUnit[2], 1074);
	//TEU UNIT
	TEU[0] = LSPDVehicles[22] = AddStaticVehicleEx(468,1544.0415,-1708.5723,5.5538,156.7939,0,0, VEHICLE_RESPAWN, 1); // Cruiser (Front)
	SetVehicleNumberPlate(TEU[0], "TEU-1");
	TEU[1] = LSPDVehicles[23] = AddStaticVehicleEx(468,1542.7850,-1707.5076,5.5622,158.1278,0,0, VEHICLE_RESPAWN, 1); // Tow Truck
	SetVehicleNumberPlate(TEU[1], "TEU-2");
	TEU[2] = LSPDVehicles[24] = AddStaticVehicleEx(468,1542.0917,-1707.0608,5.5511,154.1654,0,0, VEHICLE_RESPAWN, 1); // Tow Truck
	SetVehicleNumberPlate(TEU[2], "TEU-3");
	TEU[3] = LSPDVehicles[25] = AddStaticVehicleEx(523,1540.4431,-1705.9148,5.4508,156.6729,1,0, VEHICLE_RESPAWN); // Maverick
	SetVehicleNumberPlate(TEU[3], "TEU-4");
	TEU[4] = LSPDVehicles[26] = AddStaticVehicleEx(523,1539.9655,-1705.2487,5.4344,156.1196,1,0, VEHICLE_RESPAWN); // Maverick
	SetVehicleNumberPlate(TEU[4], "TEU-5");
	TEU[5] = LSPDVehicles[27] = AddStaticVehicleEx(523,1539.1798,-1704.4395,5.4616,154.4021,1,0, VEHICLE_RESPAWN); // Maverick
	SetVehicleNumberPlate(TEU[5], "TEU-6");
	TEU[6] = LSPDVehicles[17] = AddStaticVehicleEx(431, 1556.3182, -1624.9568, 12.3709, 90.0000,0,1, VEHICLE_RESPAWN); // Cruiser
	SetVehicleNumberPlate(TEU[6], "BUS-PD-1");
	SetVehicleHealth(TEU[6], 5000);
	//SULTAN CHIEF SAPD
    Chief[1] = LSPDVehicles[28] = AddStaticVehicleEx(560,1546.3962,-1668.0127,5.5955,89.4513,0,0, VEHICLE_RESPAWN); // Rancher
	SetVehicleNumberPlate(Chief[1], "Chief SAPD");
	AddVehicleComponent(Chief[1], 1080);
	SetVehicleHealth(Chief[1], 10000.0);
	Chief[2] = LSPDVehicles[29] = AddStaticVehicleEx(560,1546.2767,-1663.0496,5.5966,90.1683,0,0, VEHICLE_RESPAWN); // Rancher
	SetVehicleNumberPlate(Chief[2], "Deputy SAPD");
	AddVehicleComponent(Chief[2], 1080);
	SetVehicleHealth(Chief[2], 10000.0);
	
	//LSMD VEHICLES
	LSMDVehicles[1] = AddStaticVehicleEx(416, 1135.7958, -1339.6821, 13.7354, 0.0000,1,42, VEHICLE_RESPAWN);
	LSMDVehicles[2] = AddStaticVehicleEx(490, 1126.5653, -1329.1073, 13.5685, 0.0000,42,1, VEHICLE_RESPAWN);
	LSMDVehicles[3] = AddStaticVehicleEx(563, 1160.4592, -1304.2850, 32.2063, 269.8798,1,42, VEHICLE_RESPAWN);
	LSMDVehicles[4] = AddStaticVehicleEx(563, 1160.4653, -1317.5906, 32.2002, 271.0922,1,42, VEHICLE_RESPAWN);
	LSMDVehicles[5] = AddStaticVehicleEx(416, 1177.9625, -1308.6173, 13.9895, 270.0000,1,42, VEHICLE_RESPAWN);
	LSMDVehicles[6] = AddStaticVehicleEx(416, 1179.1405, -1339.2197, 13.9141, 270.0000,1,42, VEHICLE_RESPAWN);
	LSMDVehicles[7] = AddStaticVehicleEx(416, 1183.3546, -1331.5344, 13.5914, 0.0000,1,42, VEHICLE_RESPAWN);
	LSMDVehicles[8] = AddStaticVehicleEx(416, 1183.3188, -1315.5452, 13.5914, 180.0000,1,42, VEHICLE_RESPAWN);
	LSMDVehicles[9] = AddStaticVehicleEx(490, 1121.4974, -1329.1469, 13.3858, 0.0000,42,1, VEHICLE_RESPAWN);
	LSMDVehicles[10] = AddStaticVehicleEx(407, 1113.6646, -1329.1010, 13.4321, 0.0000,42,1, VEHICLE_RESPAWN);
	LSMDVehicles[11] = AddStaticVehicleEx(407, 1108.1724, -1329.0571, 13.4321, 0.0000,42,1, VEHICLE_RESPAWN);
	LSMDVehicles[12] = AddStaticVehicleEx(442, 1100.3240, -1328.0861, 13.4061, 0.0000,42,1, VEHICLE_RESPAWN);
	LSMDVehicles[13] = AddStaticVehicleEx(442, 1095.2428, -1328.0631, 13.4061, 0.0000,42,1, VEHICLE_RESPAWN);

    for(new x;x<sizeof(LSMDVehicles);x++)
	{
	    format(String, sizeof(String), "SAMD %d", LSMDVehicles[x]);
	    SetVehicleNumberPlate(LSMDVehicles[x], String);
	    SetVehicleToRespawn(LSMDVehicles[x]);
	}
	//San News Vehicles
	SanNewsVehicles[1] = AddStaticVehicleEx(582, 740.8425, -1350.1150, 13.5608, 270.1750,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[1], "VanNews-1");
	SanNewsVehicles[2] = AddStaticVehicleEx(582, 740.8268, -1345.2783, 13.5731, 269.6423,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[2], "VanNews-2");
	SanNewsVehicles[3] = AddStaticVehicleEx(582, 740.8323, -1340.4932, 13.5844, 270.3435,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[3], "VanNews-3");
	SanNewsVehicles[4] = AddStaticVehicleEx(582, 740.8392, -1335.7560, 13.5946, 269.7987,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[4], "VanNews-4");
	SanNewsVehicles[5] = AddStaticVehicleEx(582, 740.9189, -1331.6019, 13.6048, 270.3356,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[5], "VanNews-5");
	SanNewsVehicles[6] = AddStaticVehicleEx(560, 771.8953, -1381.5955, 13.3783, 0.3974,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[6], "HC-1");
	SanNewsVehicles[7] = AddStaticVehicleEx(560, 767.8303, -1381.5265, 13.3720, 359.8817,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[7], "HC-2");
	SanNewsVehicles[8] = AddStaticVehicleEx(560, 763.7784, -1381.4996, 13.3698, 359.5485,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[8], "HC-3");
	SanNewsVehicles[9] = AddStaticVehicleEx(579, 759.6081, -1381.0505, 13.5876, 359.7089,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[9], "BIG-1");
	SanNewsVehicles[10] = AddStaticVehicleEx(400, 760.6287, -1363.8038, 13.5953, 270.5869,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[10], "HC-4");
	SanNewsVehicles[11] = AddStaticVehicleEx(533, 760.8224, -1359.0710, 13.2543, 269.6531,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[11], "HC-5");
	SanNewsVehicles[12] = AddStaticVehicleEx(500, 760.1707, -1354.3617, 13.6252, 270.9430,6,6, VEHICLE_RESPAWN);
	SetVehicleNumberPlate(SanNewsVehicles[12], "BIG-2");
	//DMVCar
	DMVPlate1 = DMVCar[1] = AddStaticVehicleEx(405,2052.8206,-1903.9745,13.3249,359.6511-180,6,1, 1); // Car1
	SetVehicleNumberPlate(DMVPlate1, "LATIHAN");
	DMVPlate2 = DMVCar[2] = AddStaticVehicleEx(405,2056.1641,-1903.9946,13.3470,359.6512-180,6,1, 1); // Car2
	SetVehicleNumberPlate(DMVPlate2, "LATIHAN");
	DMVPlate3 = DMVCar[3] = AddStaticVehicleEx(405,2059.3220,-1904.0138,13.3470,359.6512-180,6,1, 1); // Car3
	SetVehicleNumberPlate(DMVPlate3, "LATIHAN");
	DMVPlate4 = DMVCar[4] = AddStaticVehicleEx(405,2062.5098,-1904.0331,13.3470,359.6512-180,6,1, 1); // Car4
	SetVehicleNumberPlate(DMVPlate4, "LATIHAN");
	DMVPlate5 = DMVCar[5] = AddStaticVehicleEx(405,2065.6597,-1904.0526,13.3470,359.6512-180,6,1, 1); // Car5
	SetVehicleNumberPlate(DMVPlate5, "LATIHAN");
 	//SAGSVEHICLES
 	//TowtruckUnit
	Crane[1] = GovVehicles[0] = AddStaticVehicleEx(525,1671.5378,-1710.6315,20.3563,267.0355,1,7,VEHICLE_RESPAWN); //Tow Truck
	SetVehicleNumberPlate(Crane[1], "CRANE-1");
	AddVehicleComponent(Crane[1], 1074);
	Crane[2] = GovVehicles[1] = AddStaticVehicleEx(525,1671.1296,-1705.2520,20.3548,268.9514,1,7,VEHICLE_RESPAWN); //Tow Truck
	SetVehicleNumberPlate(Crane[2], "CRANE-2");
	AddVehicleComponent(Crane[2], 1074);
	Crane[3] = GovVehicles[2] = AddStaticVehicleEx(525,1671.3967,-1699.8611,20.3582,269.2641,1,7,VEHICLE_RESPAWN); //Tow Truck
	SetVehicleNumberPlate(Crane[3], "CRANE-3");
