class X2Ability_SectoidM2MP extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateMassReanimateAbility());
	Templates.AddItem(CreateSectoidMindControl());
	Templates.AddItem(CreateSectoidStasis());

	return Templates;
}

static function X2DataTemplate CreateMassReanimateAbility()
{
	local X2AbilityTemplate					Template;
	local X2AbilityCost_ActionPoints		ActionPointCost;
	local X2AbilityCooldown_LocalAndGlobal	Cooldown;
	local X2AbilityMultiTarget_Radius		RadiusMultiTarget;
	local X2AbilityTarget_Cursor			CursorTarget;
	local X2Condition_UnitProperty			UnitPropertyCondition;
	local X2Condition_UnitValue				UnitValue;
	local X2Effect_SpawnPsiZombie			SpawnZombieEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MassReanimation_LW');
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_sectoid_psiexplosion";
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.Hostility = eHostility_Neutral;

	//should no longer be needed with custom anim
	//Template.bShowActivation = true;
	//Template.bSkipFireAction = true


	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	
	//attempted new targeting method
	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToSquadsightRange = true;
	CursorTarget.FixedAbilityRange = 20;
	Template.AbilityTargetStyle = CursorTarget;
	//Template.AbilityTargetStyle = default.SelfTarget;
	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.fTargetRadius = 10.5;
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	RadiusMultiTarget.bAllowDeadMultiTargetUnits = true;
	RadiusMultiTarget.bExcludeSelfAsTargetIfWithinRadius = true;
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	Template.TargetingMethod = class'X2TargetingMethod_MassPsiReanimation';


	Template.AbilityToHitCalc = default.Deadeye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = 4;
	Cooldown.NumGlobalTurns = 4;
	Template.AbilityCooldown = Cooldown;



	SpawnZombieEffect = new class'X2Effect_SpawnPsiZombie';
	SpawnZombieEffect.AnimationName = 'HL_GetUp_Multi';
	SpawnZombieEffect.BuildPersistentEffect(1);
	SpawnZombieEffect.StartAnimationMinDelaySec = class'X2Ability_GateKeeper'.default.MASS_REANIMATION_ANIMATION_MIN_DELAY_SEC;
	SpawnZombieEffect.StartAnimationMaxDelaySec = class'X2Ability_GateKeeper'.default.MASS_REANIMATION_ANIMATION_MAX_DELAY_SEC;

	// The unit must be organic, dead, and not an alien
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = false;
	UnitPropertyCondition.ExcludeAlive = true;
	UnitPropertyCondition.ExcludeRobotic = true;
	UnitPropertyCondition.ExcludeOrganic = false;
	UnitPropertyCondition.ExcludeAlien = true;
	UnitPropertyCondition.ExcludeCivilian = false;
	UnitPropertyCondition.ExcludeCosmetic = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeHostileToSource = false;
	UnitPropertyCondition.FailOnNonUnits = true;
	SpawnZombieEffect.TargetConditions.AddItem(UnitPropertyCondition);

	// This effect is only valid if the target has not yet been turned into a zombie
	UnitValue = new class'X2Condition_UnitValue';
	UnitValue.AddCheckValue(class'X2Effect_SpawnPsiZombie'.default.TurnedZombieName, 1, eCheck_LessThan);
	SpawnZombieEffect.TargetConditions.AddItem(UnitValue);

	Template.AddMultiTargetEffect(SpawnZombieEffect);

	//Template.bSkipPerkActivationActions = true;
	//Template.bSkipPerkActivationActions = true;
	Template.CustomFireAnim = 'HL_MassPsiReanimate';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = AnimaInversion_BuildVisualization_SC;
	//Template.BuildVisualizationFn = AnimaInversion_BuildVisualization;
	Template.CinescriptCameraType = "HL_MassPsiReanimate";

	return Template;
}

simulated function AnimaInversion_BuildVisualization_SC(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability Context;
	local StateObjectReference InteractingUnitRef;
	local VisualizationActionMetadata EmptyTrack;
	local VisualizationActionMetadata GatekeeperTrack, BuildTrack, ZombieTrack;
	local XComGameState_Unit SpawnedUnit, DeadUnit;
	local UnitValue SpawnedUnitValue;
	local X2Effect_SpawnPsiZombie SpawnPsiZombieEffect;
	local int i, j;
	local name SpawnPsiZombieEffectResult;
	local X2VisualizerInterface TargetVisualizerInterface;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;

	//Configure the visualization track for the shooter
	//****************************************************************************************
	GatekeeperTrack = EmptyTrack;
	GatekeeperTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	GatekeeperTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	GatekeeperTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	class'X2Action_AbilityPerkStart'.static.AddToVisualizationTree(GatekeeperTrack, Context);
	class'X2Action_ExitCover'.static.AddToVisualizationTree(GatekeeperTrack, Context);
	class'X2Action_Fire'.static.AddToVisualizationTree(GatekeeperTrack, Context);
	class'X2Action_EnterCover'.static.AddToVisualizationTree(GatekeeperTrack, Context);
	class'X2Action_AbilityPerkEnd'.static.AddToVisualizationTree(GatekeeperTrack, Context);

	// Configure the visualization track for the multi targets
	//******************************************************************************************
	for( i = 0; i < Context.InputContext.MultiTargets.Length; ++i )
	{
		InteractingUnitRef = Context.InputContext.MultiTargets[i];
		BuildTrack = EmptyTrack;
		BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
		BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
		BuildTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

		//class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(BuildTrack, Context);

		for( j = 0; j < Context.ResultContext.MultiTargetEffectResults[i].Effects.Length; ++j )
		{
			SpawnPsiZombieEffect = X2Effect_SpawnPsiZombie(Context.ResultContext.MultiTargetEffectResults[i].Effects[j]);
			SpawnPsiZombieEffectResult = 'AA_UnknownError';

			if( SpawnPsiZombieEffect != none )
			{
				SpawnPsiZombieEffectResult = Context.ResultContext.MultiTargetEffectResults[i].ApplyResults[j];
			}
			else
			{
				Context.ResultContext.MultiTargetEffectResults[i].Effects[j].AddX2ActionsForVisualization(VisualizeGameState, BuildTrack, Context.ResultContext.MultiTargetEffectResults[i].ApplyResults[j]);
			}
		}

		TargetVisualizerInterface = X2VisualizerInterface(BuildTrack.VisualizeActor);
		if( TargetVisualizerInterface != none )
		{
			//Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
			TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, BuildTrack);
		}

		if( SpawnPsiZombieEffectResult == 'AA_Success' )
		{
			DeadUnit = XComGameState_Unit(VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID));
			`assert(DeadUnit != none);
			DeadUnit.GetUnitValue(class'X2Effect_SpawnUnit'.default.SpawnedUnitValueName, SpawnedUnitValue);

			ZombieTrack = EmptyTrack;
			ZombieTrack.StateObject_OldState = History.GetGameStateForObjectID(SpawnedUnitValue.fValue, eReturnType_Reference, VisualizeGameState.HistoryIndex);
			ZombieTrack.StateObject_NewState = ZombieTrack.StateObject_OldState;
			SpawnedUnit = XComGameState_Unit(ZombieTrack.StateObject_NewState);
			`assert(SpawnedUnit != none);
			ZombieTrack.VisualizeActor = History.GetVisualizer(SpawnedUnit.ObjectID);

			SpawnPsiZombieEffect.AddSpawnVisualizationsToTracks(Context, SpawnedUnit, ZombieTrack, DeadUnit, BuildTrack);

		}

	}

	TypicalAbility_AddEffectRedirects(VisualizeGameState, GatekeeperTrack);
}

static function X2DataTemplate CreateSectoidMindControl()
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityCooldown Cooldown;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2Condition_UnitImmunities UnitImmunityCondition;
	local X2Condition_UnitEffects EffectCondition;
	local X2Effect_MindControl MindControlEffect;
	local X2Effect_RemoveEffects MindControlRemoveEffects;
	local X2AbilityTarget_Single SingleTarget;
	local X2AbilityToHitCalc_StatCheck_UnitVsUnit StatCheck;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'SectoidMindControl');

	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_adventpsiwitch_mindcontrol";
	Template.Hostility = eHostility_Offensive;
	Template.bShowActivation = true;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 5;
	Template.AbilityCooldown = Cooldown;

	StatCheck = new class'X2AbilityToHitCalc_StatCheck_UnitVsUnit';
	StatCheck.BaseValue = 85;
	Template.AbilityToHitCalc = StatCheck;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	EffectCondition = new class'X2Condition_UnitEffects';
	EffectCondition.AddExcludeEffect(class'X2Effect_MindControl'.default.EffectName, 'AA_UnitIsMindControlled');
	Template.AbilityShooterConditions.AddItem(EffectCondition);

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = true;
	UnitPropertyCondition.ExcludeRobotic = true;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);

	UnitImmunityCondition = new class'X2Condition_UnitImmunities';
	UnitImmunityCondition.AddExcludeDamageType('Mental');
	UnitImmunityCondition.bOnlyOnCharacterTemplate = true;
	Template.AbilityTargetConditions.AddItem(UnitImmunityCondition);

	EffectCondition = new class'X2Condition_UnitEffects';
	EffectCondition.AddExcludeEffect(class'X2Effect_MindControl'.default.EffectName, 'AA_UnitIsMindControlled');
	Template.AbilityTargetConditions.AddItem(EffectCondition);

	// MindControl effect for 1 or more unblocked psi hit
	MindControlEffect = class'X2StatusEffects'.static.CreateMindControlStatusEffect(class 'X2Ability_PsiOperativeAbilitySet'.default.PSI_OP_MIND_CONTROL_LASTS_NUMBER_TURNS);
	MindControlEffect.MinStatContestResult = 1;
	MindControlEffect.DamageTypes.AddItem('Psi');
	Template.AddTargetEffect(MindControlEffect);

	MindControlRemoveEffects = class'X2StatusEffects'.static.CreateMindControlRemoveEffects();
	MindControlRemoveEffects.MinStatContestResult = 1;
	Template.AddTargetEffect(MindControlRemoveEffects);
	// MindControl effect for 1 or more unblocked psi hit

	SingleTarget = new class'X2AbilityTarget_Single';
	Template.AbilityTargetStyle = SingleTarget;

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Unlike in other cases, in TypicalAbility_BuildVisualization, the MissSpeech is used on the Target!
	Template.TargetMissSpeech = 'SoldierResistsMindControl';

	Template.CustomFireAnim = 'HL_SectoidMindControl';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CinescriptCameraType = "HL_SectoidMindControl";

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;
//BEGIN AUTOGENERATED CODE: Template Overrides 'PsiOperativeMindControl'
	Template.bFrameEvenWhenUnitIsHidden = true;
//END AUTOGENERATED CODE: Template Overrides 'PsiOperativeMindControl'

	return Template;
}

static function X2DataTemplate CreateSectoidStasis( Name TemplateName='SectoidStasis' )
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2Effect_Stasis                   StasisEffect;
	local X2AbilityCooldown                 Cooldown;
	local X2Effect_RemoveEffects            RemoveEffects;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.Hostility = eHostility_Offensive;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_stasis";
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.AbilitySourceName = 'eAbilitySource_Psionic';

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY;

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 3;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityToHitCalc = default.DeadEye;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_StasisTarget');
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);

	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2Ability_Viper'.default.BindSustainedEffectName);
	Template.AddTargetEffect(RemoveEffects);

	StasisEffect = new class'X2Effect_Stasis';
	StasisEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	StasisEffect.bUseSourcePlayerState = true;
	StasisEffect.bRemoveWhenTargetDies = true;          //  probably shouldn't be possible for them to die while in stasis, but just in case
	StasisEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage);
	Template.AddTargetEffect(StasisEffect);

	Template.AbilityTargetStyle = default.SingleTargetWithSelf;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
		
	Template.bShowActivation = true;
	Template.CustomFireAnim = 'HL_Stasis';

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = Stasis_BuildVisualization;
	Template.CinescriptCameraType = "HL_Stasis";
	Template.ActivationSpeech = 'NullShield';

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;
//BEGIN AUTOGENERATED CODE: Template Overrides 'Stasis'
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
//END AUTOGENERATED CODE: Template Overrides 'Stasis'

	return Template;
}

function Stasis_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameState_Effect RemovedEffect;
	local VisualizationActionMetadata ActionMetadata, EmptyTrack;

	TypicalAbility_BuildVisualization(VisualizeGameState);
	History = `XCOMHISTORY;

	foreach VisualizeGameState.IterateByClassType(class'XComGameState_Effect', RemovedEffect)
	{
		if (RemovedEffect.bRemoved)
		{
			ActionMetadata = EmptyTrack;
			ActionMetadata.VisualizeActor = History.GetVisualizer(RemovedEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID);
			ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(RemovedEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID, , VisualizeGameState.HistoryIndex -1);
			ActionMetadata.StateObject_NewState = History.GetGameStateForObjectID(RemovedEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID);

			RemovedEffect.GetX2Effect().AddX2ActionsForVisualization_RemovedSource(VisualizeGameState, ActionMetadata, 'AA_Success', RemovedEffect);
		}
	}
}