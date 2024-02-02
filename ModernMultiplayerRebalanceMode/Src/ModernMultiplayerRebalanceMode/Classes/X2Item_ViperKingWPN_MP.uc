class X2Item_ViperKingWPN_MP extends X2Item_DefaultWeapons;

var config WeaponDamageValue VIPERKINGMP_WPN_BASEDAMAGE;
var config WeaponDamageValue FERALMEC_MP_WPN_BASEDAMAGE;
var config WeaponDamageValue ARCHONKINGMP_WPN_BASEDAMAGE;
var config WeaponDamageValue AHW_ETHEREAL_WPN_BASEDAMAGE;
var config WeaponDamageValue AHW_ETHEREAL_MELEE_BASEDAMAGE;
var config array <WeaponDamageValue> Ethereal_AbilityDamage;
var config WeaponDamageValue MutonM3_LW_WPN_BASEDAMAGE;
var config WeaponDamageValue MutonM3_LW_MELEEATTACK_BASEDAMAGE;
var config int MutonM3_LW_IDEALRANGE;
var config int MutonM3_LW_WPN_ICLIPSIZE;
var config WeaponDamageValue MutonM2_LW_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue SECTOIDM2_WPN_BASEDAMAGE;
var config int SECTOIDM2_WPN_ICLIPSIZE;
var config WeaponDamageValue LWDRONEM1_DRONEWEAPON_BASEDAMAGE;
var config int LWDRONE_DRONEWEAPON_ISOUNDRANGE;
var config int LWDRONE_DRONEWEAPON_IENVIRONMENTDAMAGE;
var config int LWDRONE_DRONEWEAPON_RANGE;
var config WeaponDamageValue LWDRONEM1_DRONEREPAIRWEAPON_BASEDAMAGE;
var config int LWDRONE_DRONEREPAIRWEAPON_ISOUNDRANGE;
var config int LWDRONE_DRONEREPAIRWEAPON_IENVIRONMENTDAMAGE;
var config int LWDRONE_DRONEREPAIRWEAPON_RANGE;
var config int LWDRONE_IDEALRANGE;
var config WeaponDamageValue MUTONELITE_GRENADE_BASEDAMAGE;

var config WeaponDamageValue MutonM2_LW_WPN_BASEDAMAGE;
var config int MutonM2_LW_IDEALRANGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;
	
	Weapons.AddItem(CreateTemplate_AHWEthereal_PsiCannon());
	Weapons.AddItem(CreateTemplate_AHWEthereal_PsiWep());
	Weapons.AddItem(CreateTemplate_ViperKingWPN_MP());
	Weapons.AddItem(CreateTemplate_FeralMEC_MP_WPN());
	Weapons.AddItem(CreateTemplate_AdvMEC_M2_MP_Shoulder_WPN());
	Weapons.AddItem(CreateTemplate_ArchonKingMP_WPN());
	Weapons.AddItem(CreateTemplate_MutonEliteWPN());
	Weapons.AddItem(CreateTemplate_MutonM2_LW_MeleeAttack());
	Weapons.AddItem(CreateTemplate_SectoidM2_WPN());
	Weapons.AddItem(CreateTemplate_LWDrone_WPN());
	Weapons.AddItem(CreateTemplate_BD_DroneRepair_LW_WPN());
	Weapons.AddItem(CreateMountainMistGrenadeMP());
	Weapons.AddItem(CreateTemplate_MutonM2_LW_WPN());
	Weapons.AddItem(CreateMutonEliteGrenade());

	return Weapons;
}

static function X2DataTemplate CreateTemplate_ViperKingWPN_MP()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'ViperKingWPN_MP');
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.ViperRifle";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.MEDIUM_CONVENTIONAL_RANGE;
	Template.BaseDamage = default.VIPERKINGMP_WPN_BASEDAMAGE;
	Template.iClipSize = default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.VIPER_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Viper_Rifle.WP_ViperRifle";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_FeralMEC_MP_WPN()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'FeralMEC_MP_WPN');

	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventMecGun";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.MEDIUM_MAGNETIC_RANGE;
	Template.BaseDamage = default.FERALMEC_MP_WPN_BASEDAMAGE;
	Template.iClipSize = default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.ADVMEC_M1_IDEALRANGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Suppression');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_AdvMec_Gun.WP_AdvMecGun";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTemplate_AdvMEC_M2_MP_Shoulder_WPN()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'AdvMEC_M2_MP_Shoulder_WPN');
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shoulder_launcher';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventMecGun";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.FLAT_CONVENTIONAL_RANGE;
	Template.BaseDamage = default.AdvMEC_M2_MicroMissiles_BaseDamage;
	Template.iClipSize = 1;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.ADVMEC_M2_IDEALRANGE;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('MicroMissiles');
	Template.Abilities.AddItem('MicroMissileFuse');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_AdvMec_Launcher.WP_AdvMecLauncher";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;
	Template.iRange = 20;


	// This controls how much arc this projectile may have and how many times it may bounce
	Template.WeaponPrecomputedPathData.InitialPathTime = 1.5;
	Template.WeaponPrecomputedPathData.MaxPathTime = 2.5;
	Template.WeaponPrecomputedPathData.MaxNumberOfBounces = 0;

	Template.DamageTypeTemplateName = 'Explosion';

	return Template;
}

static function X2DataTemplate CreateTemplate_ArchonKingMP_WPN()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'ArchonKingMP_WPN');
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.ArchonStaff";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.MEDIUM_MAGNETIC_RANGE;
	Template.BaseDamage = default.ARCHONKINGMP_WPN_BASEDAMAGE;
	Template.iClipSize = default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.ARCHON_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Archon_Rifle.WP_ArchonRifle";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_AHWEthereal_PsiCannon()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'AHW_Elder_PsiCannon');
	
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///FX_Holograms.Mugshot_Central_01";

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	Template.BaseDamage = default.AHW_ETHEREAL_WPN_BASEDAMAGE;
	Template.CritChance = 0;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = class'X2Item_DefaultWeapons'.default.ADVPSIWITCHM3_IDEALRANGE;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');

	Template.InfiniteAmmo = true;
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Ethereal_AHW.WP_Ethereal_PsiCannon";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	Template.DamageTypeTemplateName = 'Projectile_BeamAvatar';

	return Template;
}

static function X2DataTemplate CreateTemplate_AHWEthereal_PsiWep()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'AHW_Elder_PsiWep');

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'alien';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Psi_Amp";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	// This all the resources; sounds, animations, models, physics, the works.

	Template.iRadius = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 0;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;
	Template.iIdealRange = 1;
	Template.Aim = 10;

	Template.BaseDamage = default.AHW_ETHEREAL_MELEE_BASEDAMAGE;
	Template.BaseDamage.DamageType='Psi';
	Template.iSoundRange = 2;
	Template.iEnvironmentDamage = 10;

	Template.CanBeBuilt = false;

	Template.Abilities.AddItem('PsiMindControl');
	Template.Abilities.AddItem('PsiDimensionalRiftStage1');
	Template.Abilities.AddItem('PsiDimensionalRiftStage2');
	Template.Abilities.AddItem('NullLance');
	Template.Abilities.AddItem('AHWElderImmunity');

	//Template.ExtraDamage = class'X2Item_DefaultWeapons'.default.PSIAMPT3_ABILITYDAMAGE;
	Template.ExtraDamage = default.Ethereal_AbilityDamage;

	Template.GameArchetype = "WP_Ethereal_AHW.WP_Ethereal_PsiWep";

	Template.SetAnimationNameForAbility('NullLance', 'HL_Psi_NullLanceA');	
	Template.SetAnimationNameForAbility('PsiDimensionalRiftStage1', 'HL_Psi_VoidRift');	
	Template.SetAnimationNameForAbility('PsiMindControl', 'HL_Psi_MindControlA');
	Template.SetAnimationNameForAbility('AHWElderImmunity', 'HL_Psi_DrainA');	

	return Template;
}

static function X2DataTemplate CreateTemplate_MutonEliteWPN()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'MutonElite_WPN');
	
	Template.WeaponPanelImage = "_BeamCannon";
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_Base";

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	Template.BaseDamage = default.MutonM3_LW_WPN_BASEDAMAGE;
	Template.iClipSize = default.MutonM3_LW_WPN_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_BEAM_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.MutonM3_LW_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('Suppression');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Execute');


 	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWMutonM3Rifle.Archetypes.WP_MutonM3Rifle_Base";  // upscaled, recolored beam cannon

	Template.AddDefaultAttachment('Mag', "LWMutonM3Rifle.Meshes.SK_MutonM3Rifle_Mag",, "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_MagA");
    Template.AddDefaultAttachment('Core', "LWMutonM3Rifle.Meshes.SK_MutonM3Rifle_Core",, "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_CoreA");
    Template.AddDefaultAttachment('Core_Center', "LWMutonM3Rifle.Meshes.SK_MutonM3Rifle_Core_Center");
    Template.AddDefaultAttachment('HeatSink', "LWMutonM3Rifle.Meshes.SK_MutonM3Rifle_HeatSink",, "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_HeatsinkA");
    Template.AddDefaultAttachment('Suppressor', "LWMutonM3Rifle.Meshes.SK_MutonM3Rifle_Suppressor",, "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_SupressorA");

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_MutonM2_LW_MeleeAttack()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'MutonM2_LW_MeleeAttack');
	
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'baton';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.Sword";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Muton_Bayonet.WP_MutonBayonet"; // re-use base game art assets for melee weapon

	Template.Aim = class'X2Item_DefaultWeapons'.default.GENERIC_MELEE_ACCURACY;

	Template.iRange = 0;
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;
	Template.iIdealRange = 1;

	Template.BaseDamage = default.MutonM2_LW_MELEEATTACK_BASEDAMAGE;
	Template.BaseDamage.DamageType='Melee';
	Template.iSoundRange = 2;
	Template.iEnvironmentDamage = 10;

	//Build Data
	Template.StartingItem = false;
	Template.CanBeBuilt = false;

	Template.Abilities.AddItem('Bayonet');
	Template.Abilities.AddItem('BD_Bayonetcharge_LW');
	Template.Abilities.AddItem('CounterattackBayonet');

	return Template;
}

static function X2DataTemplate CreateTemplate_SectoidM2_WPN()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'SectoidM2_WPN');
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.SectoidPistol";

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	Template.BaseDamage = default.SECTOIDM2_WPN_BASEDAMAGE;
	Template.iClipSize = default.SECTOIDM2_WPN_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = class'X2Item_DefaultWeapons'.default.SECTOID_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('SectoidMindControl');

	Template.SetAnimationNameForAbility('PsiOperativeMindControl', 'SectoidMindControl');
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Sectoid_ArmPistol.WP_SectoidPistol";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_LWDrone_WPN()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'LWDroneM1_WPN');
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_BD_LWAlienPack.LWAdventDrone_ArcWeapon";
	Template.BaseDamage = default.LWDRONEM1_DRONEWEAPON_BASEDAMAGE;

	Template.iRange = default.LWDRONE_DRONEWEAPON_RANGE;
	Template.iSoundRange = default.LWDRONE_DRONEWEAPON_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.LWDRONE_DRONEWEAPON_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.LWDRONE_IDEALRANGE;
	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;

	Template.iClipSize = 99;
	Template.InfiniteAmmo = true;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShotDrone');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWDroneWeapon.Archetypes.WP_DroneBeam";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_BD_DroneRepair_LW_WPN()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'BD_DroneRepair_LWM1_WPN');
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.GatekeeperEyeball"; 
	Template.BaseDamage = default.LWDRONEM1_DRONEREPAIRWEAPON_BASEDAMAGE;
	Template.iRange = default.LWDRONE_DRONEREPAIRWEAPON_RANGE;
	Template.iSoundRange = default.LWDRONE_DRONEREPAIRWEAPON_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.LWDRONE_DRONEREPAIRWEAPON_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.LWDRONE_IDEALRANGE;

	Template.iClipSize = 99;
	Template.InfiniteAmmo = true;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('BD_DroneRepair_LW');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWDroneWeapon.Archetypes.WP_DroneRepair";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateMountainMistGrenadeMP()
{
	local X2GrenadeTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'MountainMistGrenadeMP');

	Template.strImage = "img:///UILibrary_StrategyImages.InventoryIcons.Inv_AlienGrenade";
	Template.EquipSound = "StrategyUI_Grenade_Equip";

	Template.Abilities.AddItem('ThrowGrenade');
	Template.bFriendlyFire = true;
	Template.bFriendlyFireWarning = true;

	Template.iRange = class'X2Item_XpackGrenades'.default.MOUNTAINMIST_GRENADE_RANGE;
	Template.iRadius = class'X2Item_XpackGrenades'.default.MOUNTAINMIST_GRENADE_RADIUS;
	Template.BaseDamage = class'X2Item_XpackGrenades'.default.MOUNTAINMIST_GRENADE_BASEDAMAGE;
	Template.iEnvironmentDamage = class'X2Item_XpackGrenades'.default.MOUNTAINMIST_GRENADE_ENVIRONMENTDAMAGE;
	Template.iClipSize = class'X2Item_XpackGrenades'.default.MOUNTAINMIST_GRENADE_CLIPSIZE;
	Template.iSoundRange = class'X2Item_XpackGrenades'.default.MOUNTAINMIST_GRENADE_SOUNDRANGE;

	Template.ThrownGrenadeEffects.AddItem(class'X2Effect_NewBlindEffect'.static.CreateBlindEffectNew());
	
//BEGIN AUTOGENERATED CODE: Template Overrides 'MountainMistGrenade'
	Template.GameArchetype = "WP_Grenade_MountainMist.WP_Grenade_MountainMist";
//END AUTOGENERATED CODE: Template Overrides 'MountainMistGrenade'

	Template.CanBeBuilt = false;

	return Template;
}

static function X2DataTemplate CreateTemplate_MutonM2_LW_WPN()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'MutonM2_LW_WPN');
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.MutonRifle";

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	Template.BaseDamage = default.MutonM2_LW_WPN_BASEDAMAGE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.MutonM2_LW_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('Suppression');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Execute');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Muton_Rifle.WP_MutonRifle";  // re-use base-game Muton Rifle art assets

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateMutonEliteGrenade()
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'MutonEliteGrenade');

	Template.strImage = "img:///UILibrary_StrategyImages.InventoryIcons.Inv_AlienGrenade";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.BaseDamage = default.MUTONELITE_GRENADE_BASEDAMAGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultGrenades'.default.ALIENGRENADE_IENVIRONMENTDAMAGE;
	Template.iRange = 16;
	Template.iRadius = 4;
	Template.iClipSize = 1;
	Template.iSoundRange = class'X2Item_DefaultGrenades'.default.GRENADE_SOUND_RANGE;
	Template.DamageTypeTemplateName = 'Explosion';
	
	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
	Template.LaunchedGrenadeEffects.AddItem(WeaponDamageEffect);
	
	Template.GameArchetype = "WP_Grenade_Alien.WP_Grenade_Alien";

	Template.iPhysicsImpulse = 10;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 50;

	return Template;
}