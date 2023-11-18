class X2Ability_ArchonKingMP extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(AddExecutionerAbility());
	Templates.AddItem(CreateGroundling());

	return Templates;
}

static function X2AbilityTemplate AddExecutionerAbility()
{
	local X2AbilityTemplate					Template;
	local X2Effect_Executioner_AP			AimandCritModifiers;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'BD_Executioner_LW');
	Template.IconImage = "img:///UILibrary_BD_LWAlienPack.LW_AbilityExecutioner"; //TODO
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	AimandCritModifiers = new class 'X2Effect_Executioner_AP';
	AimandCritModifiers.BuildPersistentEffect (1, true, true);
	AimandCritModifiers.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect (AimandCritModifiers);
	Template.bcrossclasseligible = false;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate CreateGroundling()
{
	local X2AbilityTemplate		Template;
	local X2Effect_Groundling	TargetEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'Groundling');

	Template.IconImage = "img:///UILibrary_XPACK_Common.weak_groundling";
	Template.Hostility = eHostility_Neutral;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	TargetEffect = new class'X2Effect_Groundling';
	TargetEffect.HeightBonus = -10;
	TargetEffect.BuildPersistentEffect(1, true, false, false);
	TargetEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage);
	Template.AddTargetEffect(TargetEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}