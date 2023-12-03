class WOTCAdventRestore_Add extends X2Ability config(AdventMedic);

var config int ADV_RESTORE_DISORIENT_PERCENT_CHANCE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(AddAdventMedicRestore());

	return Templates;
}

static function X2AbilityTemplate AddAdventMedicRestore()
{
	local X2AbilityTemplate                	Template;
	local X2Effect_RemoveEffects           	RemoveEffects;
	local X2Effect_Persistent              	DisorientedEffect;
	local X2AbilityCost_ActionPoints 		ActionPointCost;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AdventMedicRestore');
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_chosenrevive";
	Template.Hostility = eHostility_Neutral;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	
	// Hitting the target
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = new class'X2AbilityTarget_Single';

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_WOTCAdventRestore');

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.PanickedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.StunnedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2StatusEffects'.default.UnconsciousName);
	Template.AddTargetEffect(RemoveEffects);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Template.DisplayTargetHitChance = false;
	Template.bDontDisplayInAbilitySummary = true;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.MUST_RELOAD_PRIORITY;

	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false);
	DisorientedEffect.ApplyChance = default.ADV_RESTORE_DISORIENT_PERCENT_CHANCE;
	DisorientedEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(DisorientedEffect);

	Template.ActivationSpeech = 'HealingAlly';

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.bShowPostActivation = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.CustomFireAnim = 'HL_Revive';

	return Template;
}