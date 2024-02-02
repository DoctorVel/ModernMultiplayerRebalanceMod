class X2Character_ViperKing extends X2Character;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateTemplate_ViperKingMP());
	Templates.AddItem(CreateTemplate_AdvGeneralMP());
	Templates.AddItem(CreateTemplate_FeralMEC_MP());
	Templates.AddItem(CreateTemplate_ViperNeonateMP());
	Templates.AddItem(CreateTemplate_ChosenAssassinMP());
	Templates.AddItem(CreateTemplate_TheLostDasherMP());
	Templates.AddItem(CreateTemplate_AdvMEC_M2_MP());
	Templates.AddItem(CreateTemplate_AdvPsiWitch_MP());
	Templates.AddItem(CreateTemplate_ChosenWarlockMP());
	Templates.AddItem(CreateTemplate_ChosenSniperMP());
	Templates.AddItem(CreateTemplate_ArchonKingMP());
	Templates.AddItem(CreateTemplate_AdvTurretMP());
	Templates.AddItem(CreateTemplate_BerserkerQueenMP());
	Templates.AddItem(CreateTemplate_AHWElder());
	Templates.AddItem(CreateTemplate_MutonElite_MP());
	Templates.AddItem(CreateTemplate_AdvDroneMP());
	Templates.AddItem(CreateTemplate_SectoidM2_MP());
	Templates.AddItem(CreateTemplate_Centurion());
	Templates.AddItem(CreateTemplate_AdvMedicMP());
	Templates.AddItem(CreateTemplate_SparkSoldierMP());

	return Templates;
}

static function X2CharacterTemplate CreateTemplate_ViperKingMP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'ViperKingMP');
	CharTemplate.CharacterGroupName = 'ViperKing';
	CharTemplate.DefaultLoadout = 'ViperKingMP_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_ViperKing.ARC_GameUnit_ViperKing");
	CharTemplate.strMatineePackages.AddItem("CIN_Viper");
	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";
	CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("ViperHunkerDown_ANIM.ViperHunkerDown")));

	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = true;


	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.ImmuneTypes.AddItem('Poison');

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('Bind');
	CharTemplate.Abilities.AddItem('ShadowStep');
	CharTemplate.Abilities.AddItem('StoneSkin');
	CharTemplate.Abilities.AddItem('BlessingoftheElders');
	CharTemplate.Abilities.AddItem('HunkerDown');

	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	CharTemplate.ChallengePowerLevel = 25;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvGeneralMP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'AdvGeneralMP');
	CharTemplate.CharacterGroupName = 'AdventCaptain';
	CharTemplate.DefaultLoadout = 'AdvGeneralM3MP_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
    CharTemplate.strPawnArchetypes.AddItem("GameUnit_AdvGeneral.ARC_GameUnit_AdvGeneral_M");
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_AdvGeneral.ARC_GameUnit_AdvGeneral_F");

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.Abilities.AddItem('MarkTarget');
	CharTemplate.Abilities.AddItem('HunkerDown');
	CharTemplate.Abilities.AddItem('ChosenKineticPlating');
	CharTemplate.Abilities.AddItem('GrapplePowered');
	CharTemplate.Abilities.AddItem('TotalCombat');
	CharTemplate.Abilities.AddItem('Interactive_PlaceTurretObject');
	CharTemplate.Abilities.AddItem('DarkEventAbility_UndyingLoyalty');

	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_captain_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	CharTemplate.ChallengePowerLevel = 16;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_FeralMEC_MP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'FeralMEC_MP');
	CharTemplate.CharacterGroupName = 'FeralMEC';
	CharTemplate.DefaultLoadout = 'FeralMEC_MP_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("DLC_90_ProxyUnits.Units.ARC_GameUnit_FeralMEC");
	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;
	CharTemplate.bAllowRushCam = false;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = true;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bFacesAwayFromPod = true;

	CharTemplate.strScamperBT = "ScamperRoot_Flanker";

	CharTemplate.Abilities.AddItem('RobotImmunities');
	CharTemplate.Abilities.AddItem('BD_ReadyForAnything_LW');


	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_robot_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	CharTemplate.ChallengePowerLevel = 25;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_ViperNeonateMP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'ViperNeonateMP');
	CharTemplate.CharacterGroupName = 'ViperNeonate';
	CharTemplate.DefaultLoadout = 'ViperNeonateMP_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_ViperNeonate.ARC_GameUnit_ViperNeonate");
	CharTemplate.strMatineePackages.AddItem("CIN_Viper");
	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";

	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.ImmuneTypes.AddItem('Poison');

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('Bind');
	CharTemplate.Abilities.AddItem('LightningReflexes');
	CharTemplate.Abilities.AddItem('HoloTargeting');


	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	CharTemplate.ChallengePowerLevel = 25;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_ChosenAssassinMP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'ChosenAssassinMP');
	CharTemplate.CharacterGroupName = 'ChosenAssassinMP';
	CharTemplate.DefaultLoadout = 'ChosenAssassinMP_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
    CharTemplate.strPawnArchetypes.AddItem("GameUnit_ChosenAssassin.ARC_GameUnit_ChosenAssassin_M4");
	CharTemplate.strMatineePackages.AddItem("CIN_XP_ChosenAssassin");
	CharTemplate.RevealMatineePrefix = "CIN_ChosenAssassin";


	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bIsChosen = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bHideInShadowChamber = true;

	CharTemplate.Abilities.AddItem('ChosenImmunities');
	CharTemplate.ImmuneTypes.AddItem('ParthenogenicPoison');

	CharTemplate.Abilities.AddItem('VanishingWind');
	CharTemplate.Abilities.AddItem('BendingReed');
	CharTemplate.Abilities.AddItem('HarborWave');

	CharTemplate.Abilities.AddItem('ChosenShadowStep');
	CharTemplate.Abilities.AddItem('ChosenKineticPlating');
	CharTemplate.Abilities.AddItem('ChosenBewildered');
	CharTemplate.Abilities.AddItem('ChosenBlastPadding');

	CharTemplate.ImmuneTypes.AddItem('Mental');

	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_captain_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Chosen;

	CharTemplate.ChallengePowerLevel = 16;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_TheLostDasherMP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'TheLostDasherMP');
	CharTemplate.CharacterGroupName = 'TheLost';
	CharTemplate.DefaultLoadout = 'TheLostTier3_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.SightedNarrativeMoments.Length = 0;
	
	
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_TheLost.ARC_GameUnit_TheLost_Wolf");

	CharTemplate.strMatineePackages.AddItem("CIN_XP_Lost");

	CharTemplate.UnitSize = 1;

	CharTemplate.KillContribution = 0.25;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bIsMeleeOnly = true;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bDisplayUIUnitFlag = true;
	
	CharTemplate.bAllowSpawnFromATT = false;


	CharTemplate.ImmuneTypes.AddItem('Mental');
	CharTemplate.ImmuneTypes.AddItem('Poison');
	CharTemplate.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.ParthenogenicPoisonType);

	CharTemplate.Abilities.AddItem('StandardMove');
	CharTemplate.Abilities.AddItem('ZombieInitializationPassive');;
	CharTemplate.Abilities.AddItem('VulnerabilityToFire');

	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_TheLost;

	CharTemplate.bDontUseOTSTargetingCamera = true;

	CharTemplate.AcquiredPhobiaTemplate = 'FearOfTheLost';

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvMEC_M2_MP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'AdvMEC_M2_MP');
	CharTemplate.CharacterGroupName = 'AdventMEC_M2';
	CharTemplate.DefaultLoadout = 'AdvMEC_M2_MP_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_AdvMEC_M2.ARC_GameUnit_AdvMEC_M2");
	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;
	CharTemplate.bAllowRushCam = false;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = true;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bFacesAwayFromPod = true;

	CharTemplate.strScamperBT = "ScamperRoot_Flanker";

	CharTemplate.Abilities.AddItem('RobotImmunities');


	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_robot_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	CharTemplate.ChallengePowerLevel = 25;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvPsiWitch_MP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'AdvPsiWitch_MP');
	CharTemplate.CharacterGroupName = 'AdventPsiWitch';
	CharTemplate.DefaultLoadout = 'AdvPsiWitchM3_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strMatineePackages.AddItem("CIN_Advent");
    CharTemplate.strPawnArchetypes.AddItem("GameUnit_AdvPsiWitch.ARC_GameUnit_AdvPsiWitchM3_M");
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_AdvPsiWitch.ARC_GameUnit_AdvPsiWitchM3_F");
	CharTemplate.SightedNarrativeMoments.Length = 0;

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.Abilities.AddItem('AvatarInitialization');
	CharTemplate.Abilities.AddItem('TriggerDamagedTeleportListener');
	CharTemplate.Abilities.AddItem('AvatarDamagedTeleport');

	CharTemplate.ImmuneTypes.AddItem('Mental');
	CharTemplate.Abilities.AddItem('Insanity');
	CharTemplate.ImmuneTypes.AddItem('Fire');
	CharTemplate.ImmuneTypes.AddItem('Poison');
	CharTemplate.ImmuneTypes.AddItem('ParthenogenicPoison');
	CharTemplate.Abilities.AddItem('Parry');


	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_captain_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	CharTemplate.ChallengePowerLevel = 16;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_ChosenWarlockMP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'ChosenWarlockMP');
	CharTemplate.CharacterGroupName = 'ChosenWarlockMP';
	CharTemplate.DefaultLoadout = 'ChosenWarlockM2_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
    CharTemplate.strPawnArchetypes.AddItem("GameUnit_ChosenWarlock.ARC_GameUnit_ChosenWarlockM4");
	CharTemplate.strMatineePackages.AddItem("CIN_XP_ChosenWarlock");
	CharTemplate.strTargetingMatineePrefix = "CIN_XP_ChosenWarlock";
	CharTemplate.RevealMatineePrefix = "CIN_XP_ChosenWarlock";


	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bIsChosen = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bHideInShadowChamber = true;

	CharTemplate.Abilities.AddItem('ChosenImmunities');
	CharTemplate.ImmuneTypes.AddItem('ParthenogenicPoison');

	

	CharTemplate.Abilities.AddItem('HolyWarriorM3');
	CharTemplate.Abilities.AddItem('HolyWarriorDeath');

	CharTemplate.Abilities.AddItem('WarlockLevelM2');
	CharTemplate.Abilities.AddItem('ChosenBrutal');
	CharTemplate.Abilities.AddItem('ChosenRevenge');
	CharTemplate.Abilities.AddItem('ChosenGroundling');
	CharTemplate.Abilities.AddItem('KillZombie');

	CharTemplate.ImmuneTypes.AddItem('Mental');


	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_captain_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Chosen;

	CharTemplate.ChallengePowerLevel = 16;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_ChosenSniperMP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'ChosenSniperMP');
	CharTemplate.CharacterGroupName = 'ChosenSniperMP';
	CharTemplate.DefaultLoadout = 'ChosenSniperM4_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
    CharTemplate.strPawnArchetypes.AddItem("GameUnit_ChosenHunter.ARC_GameUnit_ChosenHunter_M4");
	CharTemplate.strMatineePackages.AddItem("CIN_XP_ChosenHunter");
	CharTemplate.RevealMatineePrefix = "CIN_ChosenHunter";

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bIsChosen = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bHideInShadowChamber = true;

	CharTemplate.Abilities.AddItem('ChosenImmunities');
	CharTemplate.ImmuneTypes.AddItem('ParthenogenicPoison');

	CharTemplate.Abilities.AddItem('HunterGrapple');

	CharTemplate.Abilities.AddItem('ChosenAllSeeing');
	CharTemplate.Abilities.AddItem('ChosenLowProfile');
	CharTemplate.Abilities.AddItem('ChosenLowProfileTrigger');
	CharTemplate.Abilities.AddItem('ChosenBrittle');

	CharTemplate.ImmuneTypes.AddItem('Mental');

	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_captain_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Chosen;

	CharTemplate.ChallengePowerLevel = 16;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_ArchonKingMP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'ArchonKingMP');
	CharTemplate.CharacterGroupName = 'Archon';
	CharTemplate.DefaultLoadout = 'ArchonKingMP_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_ArchonKing.ARC_GameUnit_ArchonKing");
	CharTemplate.strMatineePackages.AddItem("CIN_Archon");
	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	CharTemplate.strMatineePackages.AddItem("CIN_ArchonKing");
	CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";
	
	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = false;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = false;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = false;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanUse_eTraversal_Launch = true;
	CharTemplate.bCanUse_eTraversal_Flying = true;
	CharTemplate.bCanUse_eTraversal_Land = true;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bAllowSpawnFromATT = false;
	CharTemplate.bImmueToFalling = true;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strScamperBT = "ScamperRoot_NoCover";

	CharTemplate.Abilities.AddItem('FrenzyDamageListener');
	CharTemplate.Abilities.AddItem('BlazingPinionsStage1MP');
	CharTemplate.Abilities.AddItem('IcarusDropGrab');
	CharTemplate.Abilities.AddItem('BD_Executioner_LW');
	CharTemplate.Abilities.AddItem('Groundling');
	CharTemplate.Abilities.AddItem('BlessingoftheElders');

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	CharTemplate.ChallengePowerLevel = 50;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvTurretMP()

{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'AdvTurretMP');
	CharTemplate.CharacterGroupName = 'AdventTurret';
	CharTemplate.DefaultLoadout='AdvTurretM1_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strMatineePackages.AddItem("CIN_Turret");
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_AdvTurret.ARC_GameUnit_AdvTurretM1");
	CharTemplate.strTargetingMatineePrefix = "CIN_Turret_FF_StartPos";

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = true;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bIsTurret = true;

	CharTemplate.UnitSize = 1;
	CharTemplate.VisionArcDegrees = 360;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = false;

	CharTemplate.bAllowSpawnFromATT = false;
	CharTemplate.bSkipDefaultAbilities = true;

	CharTemplate.bBlocksPathingWhenDead = true;

	CharTemplate.ImmuneTypes.AddItem('Fire');
	CharTemplate.ImmuneTypes.AddItem('Poison');
	CharTemplate.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.ParthenogenicPoisonType);
	CharTemplate.ImmuneTypes.AddItem('Panic');

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_turret_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Turret;

	CharTemplate.bDisablePodRevealMovementChecks = true;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_BerserkerQueenMP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'BerserkerQueenMP');
	CharTemplate.CharacterGroupName = 'BerserkerQueenMP';
	CharTemplate.DefaultLoadout = 'BerserkerQueenMP_Loadout';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_BerserkerQueen.ARC_GameUnit_BerserkerQueen");

	CharTemplate.strMatineePackages.AddItem("CIN_Berserker");
	CharTemplate.strMatineePackages.AddItem("CIN_BerserkerQueen");

	CharTemplate.UnitSize = 1;
	CharTemplate.UnitHeight = 3; //One unit taller than normal
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bIsMeleeOnly = true;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = false;
	CharTemplate.bAllowRushCam = false;

	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;


	CharTemplate.Abilities.AddItem('TriggerRageDamageListener');
	CharTemplate.Abilities.AddItem('DevastatingPunchBQMP');
	CharTemplate.Abilities.AddItem('Quake');
	CharTemplate.Abilities.AddItem('Faithbreaker');
	CharTemplate.Abilities.AddItem('BlessingoftheElders');


	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	CharTemplate.ChallengePowerLevel = 50;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AHWElder()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'AHWElder');
	CharTemplate.CharacterGroupName = 'Ethereal';
	CharTemplate.DefaultLoadout='Elder_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strBehaviorTree = "AHWElder::CharacterRoot";
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_Ethereal.ARC_GameUnit_Elder");
	CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("Ethereal_MassPsiReanimation.AS_EtherealReanimation")));
	CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("Ethereal_MassPsiReanimation.AS_Fire")));
	CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("Ethereal_MassPsiReanimation.AS_LifeStile")));

	CharTemplate.strMatineePackages.AddItem("CIN_AHWElder");

	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;    
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = true;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.bImmueToFalling = true;

	CharTemplate.bCanBeTerrorist = true;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;


	CharTemplate.Abilities.AddItem('VulnerabilityMelee');
	CharTemplate.Abilities.AddItem('AHWEtherealDivinity');
	CharTemplate.Abilities.AddItem('AHWElderReflect');
	CharTemplate.Abilities.AddItem('AHWElderReflectShot');
	CharTemplate.Abilities.AddItem('ElderMentalFortress');
	CharTemplate.Abilities.AddItem('MassReanimation_LW');
	CharTemplate.Abilities.AddItem('AHWElderLifeStyle');
	CharTemplate.ImmuneTypes.AddItem('Mental');
	

	CharTemplate.strTargetIconImage = "UI_Icons_Elder.TargetIcons.Target_Elder";
	CharTemplate.ScamperActionPoints = 1;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_MutonElite_MP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'MutonElite_MP');
	CharTemplate.CharacterGroupName = 'Muton';
	CharTemplate.DefaultLoadout='MutonElite_MP_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWMutonM3.Archetypes.ARC_GameUnit_MutonM3"); // SCRUBBED AFTER S&R

	CharTemplate.strMatineePackages.AddItem("CIN_Muton");

	CharTemplate.UnitSize = 1;
	// Traversal Rules -- same as base Muton
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;    
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
    CharTemplate.bIsChosen = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('CounterattackPreparation');
	CharTemplate.Abilities.AddItem('CounterattackDescription');
	CharTemplate.Abilities.AddItem('BD_WarCry_LW');
	CharTemplate.Abilities.AddItem('LongRangeThrow');

	CharTemplate.Abilities.AddItem('MutonElite_PersonalShield');

	CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("Muton_ANIM_WarCry.Anims.AS_WarCry")));



	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;
	CharTemplate.strBehaviorTree = "LWMutonM3::CharacterRoot"; // new config behavior tree parsing means we could use the group instead


	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvDroneMP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'AdvDroneMP');
	CharTemplate.CharacterGroupName = 'AdventDrone';
	CharTemplate.DefaultLoadout='AdvDroneMP_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWDrone.Archetypes.ARC_GameUnit_DroneM1"); 

	CharTemplate.strMatineePackages.AddItem("LW_CIN_Drone");

	CharTemplate.UnitSize = 1;

	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = false;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = false;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = false;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanUse_eTraversal_Launch = true;
	CharTemplate.bCanUse_eTraversal_Flying = true;
	CharTemplate.bCanUse_eTraversal_Land = true;
	CharTemplate.bAppearanceDefinesPawn = false;    
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = true;
	CharTemplate.bIsSoldier = false;
    CharTemplate.bIsChosen = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = false;

	CharTemplate.bWeakAgainstTechLikeRobot = true;

	CharTemplate.Abilities.AddItem('RobotImmunities');
	CharTemplate.Abilities.AddItem('DroneAidProtocol');
	
	CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("AdvDroneMP_ANIM.AS_DroneAidProtocol")));

	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;
	CharTemplate.strBehaviorTree = "LWDrone::CharacterRoot"; // new config behavior tree parsing means we could use the group instead


	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_robot_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;  

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_SectoidM2_MP()  
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'SectoidM2_MP');
	CharTemplate.CharacterGroupName = 'Sectoid';
	CharTemplate.DefaultLoadout='SectoidM2_MP_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_SectoidAbductor.ARC_GameUnit_SectoidAbductor");

	CharTemplate.strMatineePackages.AddItem("CIN_Sectoid");

	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;    
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = true;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('VulnerabilityMelee');
	CharTemplate.Abilities.AddItem('KillSiredZombies');
	CharTemplate.Abilities.AddItem('MassReanimation_LW');
	CharTemplate.Abilities.AddItem('Mindspin');
	CharTemplate.Abilities.AddItem('SectoidStasis');
	CharTemplate.Abilities.AddItem('PsionicShield');


	CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("SectoidM2_ANIM_Ability.AS_SectoidStasis")));
	CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("LWSectoidM2.Anims.AS_SectoidM2")));
	CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("SectoidM2_ANIM_Ability.AS_SectoidMindControl")));
	CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("SectoidM2_ANIM_Ability.AS_SectoidMassReanination")));
	CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("Sectoid_PsionicShield.AS_PsionicShield")));
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strBehaviorTree = "LWSectoidM2::CharacterRoot"; // new config behavior tree parsing means we could use the group instead


	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_Centurion()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'Centurion');
	CharTemplate.CharacterGroupName = 'Muton';
	CharTemplate.DefaultLoadout='Centurion_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWMutonM2.ARC_GameUnit_MutonM2"); 
	Loot.ForceLevel=0;
	Loot.LootTableName='Muton_BaseLoot'; 
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'Muton_TimedLoot'; 
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	
	Loot.LootTableName = 'Muton_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	//CharTemplate.strMatineePackage = "CIN_Muton"; 
	CharTemplate.strMatineePackages.AddItem("CIN_Muton"); //update with new cinematic?

	CharTemplate.UnitSize = 1;
	// Traversal Rules -- same as base Muton
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;    
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bIsChosen = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('CounterattackPreparation');
	CharTemplate.Abilities.AddItem('CounterattackDescription');
	CharTemplate.Abilities.AddItem('WallPhasing');


	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;
	CharTemplate.strBehaviorTree = "LWMutonM2::CharacterRoot";  // new config behavior tree parsing means we could use the group instead


	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvMedicMP()
{
	local X2CharacterTemplate CharTemplate;


	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'AdvMedicMP');
	CharTemplate.CharacterGroupName = 'AdventMedic';
	
	CharTemplate.DefaultLoadout='AdvMedicMP_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("AdventMedic.ARC_GameUnit_AdvMedic_M");
	CharTemplate.strPawnArchetypes.AddItem("AdventMedic.ARC_GameUnit_AdvMedic_F");
	

	CharTemplate.strMatineePackages.AddItem("CIN_Advent");
	CharTemplate.RevealMatineePrefix = "CIN_Advent_Trooper";

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;    
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.Abilities.AddItem('AdventMedicRestore');
	

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_captain_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	return CharTemplate;

}

static function X2CharacterTemplate CreateTemplate_SparkSoldierMP()
{
	local X2CharacterTemplate CharTemplate;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'SparkSoldierMP');
	CharTemplate.strPawnArchetypes.AddItem("DLC_90_ProxyUnits.Units.ARC_GameUnit_FeralMEC");
	CharTemplate.UnitSize = 1;
	CharTemplate.UnitHeight = 3;
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bDiesWhenCaptured = true;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = true;
	CharTemplate.bIsSoldier = true;
	CharTemplate.bCanTakeCover = false;
	CharTemplate.bCanBeCarried = false;
	CharTemplate.bCanBeRevived = false;
	CharTemplate.bUsePoolSoldiers = true;
	CharTemplate.bIsTooBigForArmory = true;
	CharTemplate.bStaffingAllowed = true;
	CharTemplate.bAppearInBase = false; // Do not appear as filler crew or in any regular staff slots throughout the base
	CharTemplate.bWearArmorInBase = true;
	CharTemplate.AppearInStaffSlots.AddItem('SparkStaffSlot'); // But are allowed to appear in the spark repair slot
	CharTemplate.bIgnoreEndTacticalHealthMod = true;
	CharTemplate.bAllowRushCam = false;

	CharTemplate.strMatineePackages.AddItem("CIN_Spark");
	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";
	CharTemplate.strIntroMatineeSlotPrefix = "Spark";
	CharTemplate.strLoadingMatineeSlotPrefix = "SparkSoldier";
	
	CharTemplate.DefaultSoldierClass = 'SparkMP';
	CharTemplate.DefaultLoadout = 'MP_Spark';
	CharTemplate.RequiredLoadout = 'MP_Spark';

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_XCom;

	CharTemplate.CustomizationManagerClass = class'XComCharacterCustomization_Spark';
	CharTemplate.UICustomizationMenuClass = class'UICustomize_SparkMenu';
	CharTemplate.UICustomizationInfoClass = class'UICustomize_SparkInfo';
	CharTemplate.UICustomizationPropsClass = class'UICustomize_SparkProps';
	CharTemplate.UICustomizationHeadClass = class'UICustomize_SparkHead';
	CharTemplate.UICustomizationBodyClass = class'UICustomize_SparkBody';
	CharTemplate.UICustomizationWeaponClass = class'UICustomize_SparkWeapon';

	CharTemplate.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.KnockbackDamageType);

	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator_SPARK';
	
	// Ensure only Spark heads are available for customization
	CharTemplate.bHasCharacterExclusiveAppearance = true;
	
	CharTemplate.PhotoboothPersonality = 'Personality_Normal';

	CharTemplate.GetPawnNameFn = GetSparkPawnName;

	return CharTemplate;
}

function name GetSparkPawnName(optional EGender Gender)
{
	return 'XCom_Soldier_Spark';
}

static function name GetDefaultSparkVoiceByLanguage(optional string strLanguage = "")
{
	if (len(strLanguage) == 0)
		strLanguage = GetLanguage();

	switch (strLanguage)
	{
	case "DEU":
		return 'SparkCalmVoice1_German';
	case "ESN":
		return 'SparkCalmVoice1_Spanish';
	case "FRA":
		return 'SparkCalmVoice1_French';
	case "ITA":
		return 'SparkCalmVoice1_Italian';
	}

	return 'SparkCalmVoice1_English';
}