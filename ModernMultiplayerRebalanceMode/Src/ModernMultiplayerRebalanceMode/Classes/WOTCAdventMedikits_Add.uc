class WOTCAdventMedikits_Add extends X2Item config(GameData_WeaponData);

var config int ADV_MEDIKIT_RANGE;
var config int ADV_MEDIKIT_MP_ICLIPSIZE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;


	Items.AddItem(CreateAdventMedikitMP());

	return Items;
}



static function X2DataTemplate CreateAdventMedikitMP()
{
	local X2WeaponTemplate Template;
	
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'AdventMedikitMP');
	Template.ItemCat = 'heal';
	Template.WeaponCat = 'medikit';

	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_RearBackPack;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Medkit";
	Template.EquipSound = "StrategyUI_Medkit_Equip";

	Template.iClipSize = default.ADV_MEDIKIT_MP_ICLIPSIZE;
	Template.iRange = default.ADV_MEDIKIT_RANGE;
	Template.bMergeAmmo = true;

	Template.Abilities.AddItem('NanoMedikitHeal');
	Template.Abilities.AddItem('NanoMedikitBonus');

	Template.GameArchetype = "AdventMedic.ARC_AdventMedikit";

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 15;
	Template.PointsToComplete = 0;
	Template.Tier = 0;

	Template.bShouldCreateDifficultyVariants = true;

	return Template;
}