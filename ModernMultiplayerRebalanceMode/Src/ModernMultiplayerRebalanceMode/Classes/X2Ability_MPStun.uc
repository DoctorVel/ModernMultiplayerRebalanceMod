class X2Ability_MPStun extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateMP_StunImpairingAbilityAbility());
	
	return Templates;
}

static function X2DataTemplate CreateMP_StunImpairingAbilityAbility()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityToHitCalc_PercentChance	PercentChance;
	local X2AbilityTarget_Single            SingleTarget;
	local X2Effect_Stunned				    StunnedEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MP_StunImpairingAbility');

	Template.bDontDisplayInAbilitySummary = true;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;

	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_Placeholder');

	// Target Conditions
	Template.AbilityTargetConditions.AddItem(default.LivingTargetUnitOnlyProperty);
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);

	// Shooter Conditions
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	PercentChance = new class'X2AbilityToHitCalc_PercentChance';
	PercentChance.PercentToHit = 100; // Шанс оглушения
	Template.AbilityToHitCalc = PercentChance;

	// On hit effects
	StunnedEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, 100, false);
	StunnedEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(StunnedEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = class'X2Ability_StunLancer'.static.StunLancerImpairing_BuildVisualization;
	Template.bFrameEvenWhenUnitIsHidden = true;

	Template.bSkipPerkActivationActions = true;
	Template.bSkipPerkActivationActionsSync = false;
	Template.bSkipFireAction = true;

	return Template;
}