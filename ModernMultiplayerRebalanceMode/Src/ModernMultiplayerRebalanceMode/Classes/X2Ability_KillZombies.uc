class X2Ability_KillZombies extends X2Ability;

var privatewrite name VoidRiftDurationFXEffectName;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(AddKillZombiesAbility());
	Templates.AddItem(KillZombiesRiftEndDurationFX());

	return Templates;
}


static function X2AbilityTemplate AddKillZombiesAbility()
{
	local X2AbilityTemplate				Template;
	local X2AbilityCost_ActionPoints    ActionPointCost;
	local X2Effect_KillUnit				KillUnitEffect;
	local X2Effect_RemoveEffects		PerkEffect;
	local X2Condition_KillZombies UnitTypeCondition;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2Condition_Visibility TargetVisibilityCondition;
	local X2AbilityTarget_Cursor CursorTarget;
	local X2AbilityMultiTarget_Radius RadiusMultiTarget;
	local X2Effect_PerkAttachForFX DurationFXEffect;
	local X2AbilityCooldown Cooldown;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'KillZombies');

	// Icon Properties

	Template.AbilitySourceName = 'eAbilitySource_Psionic';                                       // color of the icon
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_teleportally";
	Template.Hostility = eHostility_Offensive;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 1;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityToHitCalc = default.DeadEye;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	UnitTypeCondition = new class'X2Condition_KillZombies';
	Template.AbilityTargetConditions.AddItem(UnitTypeCondition);

	Template.AddShooterEffectExclusions();

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = true;
	UnitPropertyCondition.ExcludeRobotic = true;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);
	
	TargetVisibilityCondition = new class'X2Condition_Visibility';	
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	KillUnitEffect = new class'X2Effect_KillUnit';
	KillUnitEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	KillUnitEffect.DeathActionClass = class'X2Action_ZombieSireDeath';
	KillUnitEffect.VisualizationFn = class'X2Ability_Sectoid'.static.BuildVisualization_SireDeathEffect;
	Template.AddTargetEffect(KillUnitEffect);

    Template.AddMultiTargetEffect(KillUnitEffect);

	PerkEffect = new class'X2Effect_RemoveEffects';
	PerkEffect.EffectNamesToRemove.AddItem(class'X2Ability_Sectoid'.default.SireZombieLinkName);
	Template.AddTargetEffect(PerkEffect);

	//Template.AbilityTargetStyle = default.SimpleSingleTarget;
	//Template.AbilityMultiTargetStyle = new class'X2AbilityMultiTarget_Volt';

	//Template.TargetingMethod = class'X2TargetingMethod_Volt';

	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToSquadsightRange = true;
	CursorTarget.FixedAbilityRange = 18;
	Template.AbilityTargetStyle = CursorTarget;
	//Template.AbilityTargetStyle = default.SelfTarget;
	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.fTargetRadius = 4;
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	RadiusMultiTarget.bAllowDeadMultiTargetUnits = true;
	RadiusMultiTarget.bExcludeSelfAsTargetIfWithinRadius = true;
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	DurationFXEffect = new class 'X2Effect_PerkAttachForFX';
	DurationFXEffect.BuildPersistentEffect(1, false, true, , eGameRule_PlayerTurnEnd);
	DurationFXEffect.EffectName = default.VoidRiftDurationFXEffectName;
	Template.AddShooterEffect(DurationFXEffect);

	Template.TargetingMethod = class'X2TargetingMethod_MassPsiReanimation';

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.AdditionalAbilities.AddItem('KillZombiesRiftEndDurationFX');

	Template.bShowActivation = true;
	Template.bSkipFireAction = false;
		
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CustomFireAnim = 'HL_KillZombies';
	Template.CinescriptCameraType = "HL_KillZombies";
	Template.bFrameEvenWhenUnitIsHidden = false;

	return Template;
}

static function X2AbilityTemplate KillZombiesRiftEndDurationFX()
{
	local X2AbilityTemplate             Template;
	local X2Effect_RemoveEffects        VoidRiftRemoveEffects;
	local X2AbilityTrigger_EventListener EventListener;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'KillZombiesRiftEndDurationFX');
	
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_VoidRiftEndDurrationFX;
	Template.AbilityTriggers.AddItem(EventListener);



	VoidRiftRemoveEffects = new class'X2Effect_RemoveEffects';
	VoidRiftRemoveEffects.EffectNamesToRemove.AddItem(default.VoidRiftDurationFXEffectName);
	Template.AddShooterEffect(VoidRiftRemoveEffects);

	Template.bSkipFireAction = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_insanity";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_CORPORAL_PRIORITY;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	
	return Template;
}

DefaultProperties
{
	VoidRiftDurationFXEffectName="VoidRiftDurationFXEffect"
}

