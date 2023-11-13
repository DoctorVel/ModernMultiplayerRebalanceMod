class X2Ability_BerserkerQueenMPPunch extends X2Ability;

var config WeaponDamageValue BERSERKERQUEENMP_MELEEATTACK_MISSDAMAGE;
var config WeaponDamageValue BERSERKERQUEENMP_MELEEATTACK_BASEDAMAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateDevastatingPunchAbilityBQMP());

	return Templates;
}



static function X2AbilityTemplate CreateDevastatingPunchAbilityBQMP(optional Name AbilityName = 'DevastatingPunchBQMP')
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityToHitCalc_StandardMelee MeleeHitCalc;
	local X2Effect_ApplyWeaponDamage PhysicalDamageEffect;
	local X2Effect_ImmediateAbilityActivation BrainDamageAbilityEffect;
	local X2AbilityTarget_MovingMelee MeleeTarget;
	//local X2Effect_Knockback KnockbackEffect;
	local array<name> SkipExclusions;
	local X2Condition_BerserkerDevastatingPunch PunchCondition;

	`CREATE_X2ABILITY_TEMPLATE(Template, AbilityName);
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_muton_punch";
	Template.Hostility = eHostility_Offensive;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.MP_PerkOverride = 'DevastatingPunch';

	Template.AdditionalAbilities.AddItem(class'X2Ability_Impairing'.default.ImpairingAbilityName);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	MeleeHitCalc = new class'X2AbilityToHitCalc_StandardMelee';
	Template.AbilityToHitCalc = MeleeHitCalc;

	MeleeTarget = new class'X2AbilityTarget_MovingMelee';
	Template.AbilityTargetStyle = MeleeTarget;
	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';

	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_PlayerInput');
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	
	// May punch if the unit is burning or disoriented
	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	PunchCondition = new class'X2Condition_BerserkerDevastatingPunch';
	PunchCondition.bFailOnNonUnitTargets = false;
	Template.AbilityTargetConditions.AddItem(PunchCondition);
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);

	PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	PhysicalDamageEffect.EffectDamageValue = default.BERSERKERQUEENMP_MELEEATTACK_BASEDAMAGE;
	PhysicalDamageEffect.EffectDamageValue.DamageType = 'Melee';
	Template.AddTargetEffect(PhysicalDamageEffect);

	PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	PhysicalDamageEffect.EffectDamageValue = default.BERSERKERQUEENMP_MELEEATTACK_MISSDAMAGE;
	PhysicalDamageEffect.EffectDamageValue.DamageType = 'Melee';
	PhysicalDamageEffect.bApplyOnHit = False;
	PhysicalDamageEffect.bApplyOnMiss = True;
	PhysicalDamageEffect.bIgnoreBaseDamage = True;
	Template.AddTargetEffect(PhysicalDamageEffect);

	//Impairing effects need to come after the damage. This is needed for proper visualization ordering.
	//Effect on a successful melee attack is triggering the BrainDamage Ability
	BrainDamageAbilityEffect = new class 'X2Effect_ImmediateAbilityActivation';
	BrainDamageAbilityEffect.BuildPersistentEffect(1, false, true, , eGameRule_PlayerTurnBegin);
	BrainDamageAbilityEffect.EffectName = 'ImmediateBrainDamage';
	// NOTICE: For now StunLancer, Muton, and Berserker all use this ability. This may change.
	BrainDamageAbilityEffect.AbilityName = class'X2Ability_Impairing'.default.ImpairingAbilityName;
	BrainDamageAbilityEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true, , Template.AbilitySourceName);
	BrainDamageAbilityEffect.bRemoveWhenTargetDies = true;
	BrainDamageAbilityEffect.VisualizationFn = class'X2Ability_Impairing'.static.ImpairingAbilityEffectTriggeredVisualization;
	Template.AddTargetEffect(BrainDamageAbilityEffect);

	//KnockbackEffect = new class'X2Effect_Knockback';
	//KnockbackEffect.KnockbackDistance = 5; //Knockback 5 meters
	//Template.AddTargetEffect(KnockbackEffect);

	Template.CustomFireAnim = 'FF_Melee';
	Template.bSkipMoveStop = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bOverrideMeleeDeath = true;
	Template.BuildNewGameStateFn = TypicalMoveEndAbility_BuildGameState;
	Template.BuildVisualizationFn = DevastatingPunchAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;
	Template.CinescriptCameraType = "Berserker_DevastatingPunch";

	return Template;
}

function DevastatingPunchAbility_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameState_Unit SourceState, TargetState;
	local XComGameStateContext_Ability  Context;
	local VisualizationActionMetadata				ActionMetadata;
	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;

	TypicalAbility_BuildVisualization(VisualizeGameState);
	
	// Check if we should add a fly-over for 'Blind Rage' (iff both source and target are AI).
	History = `XCOMHISTORY;
	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	SourceState = XComGameState_Unit(History.GetGameStateForObjectID(Context.InputContext.SourceObject.ObjectID));
	if( SourceState.ControllingPlayerIsAI() && SourceState.IsUnitAffectedByEffectName(RageTriggeredEffectName))
	{
		TargetState = XComGameState_Unit(History.GetGameStateForObjectID(Context.InputContext.PrimaryTarget.ObjectID));
		if( TargetState.GetTeam() == SourceState.GetTeam() )
		{
			ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(SourceState.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
			ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(SourceState.ObjectID);
			ActionMetadata.VisualizeActor = History.GetVisualizer(SourceState.ObjectID);

			SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
 			SoundAndFlyOver.SetSoundAndFlyOverParameters(None, default.BlindRageFlyover, '', eColor_Good);
		}
	}
}