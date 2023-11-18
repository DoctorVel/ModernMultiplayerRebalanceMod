class X2Ability_MutonElite extends X2Ability config(XComGameData_SoldierSkills);

var config int WARCRY_DURATION;
var config int WARCRY_MUTON_OFFENSE_BONUS;
var config int WARCRY_MUTON_WILL_BONUS;
var config int WARCRY_MUTON_MOBILITY_BONUS;

var config int BAYONETCHARGE_PENALTY_DURATION;
var config int BAYONETCHARGE_DEFENSE_PENALTY;
var config array <string> WARCRY_MUTON_BONUS;

var config int PERSONAL_SHIELD_DURATION;
var config int PERSONAL_SHIELD_HP;
var localized string strBayonetChargePenalty;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateMutonM2_LWAbility_BayonetCharge());
	Templates.AddItem(CreateMutonM2_LWAbility_WarCry());	

	return Templates;
}

static function X2AbilityTemplate CreateMutonM2_LWAbility_WarCry()
{
	local X2AbilityTemplate					Template;
	local X2AbilityCost_ActionPoints		ActionPointCost;
	local X2AbilityCooldown					Cooldown;
	local X2Condition_UnitProperty			MultiTargetProperty;
	local X2Effect_WarCry					StatEffect;
	local X2AbilityTargetStyle				TargetStyle;
	local X2AbilityMultiTarget_Radius		RadiusMultiTarget;
	local int								i;
	local string							AlienName;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'BD_WarCry_LW');
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.IconImage = "img:///Texture2D'UILibrary_BD_LWAlienPack.LWCenturion_AbilityWarCry64'";
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bfreeCost = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 5;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityToHitCalc = default.Deadeye;

	TargetStyle = new class 'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.fTargetRadius = 27;
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AddShooterEffectExclusions();

	MultiTargetProperty = new class'X2Condition_UnitProperty';
	MultiTargetProperty.ExcludeAlive = false;
	MultiTargetProperty.ExcludeDead = true;
	MultiTargetProperty.ExcludeHostileToSource = true;
	MultiTargetProperty.ExcludeFriendlyToSource = false;
	MultiTargetProperty.RequireSquadmates = true;
	MultiTargetProperty.ExcludePanicked = true;
	MultiTargetProperty.ExcludeRobotic = true;
	MultiTargetProperty.ExcludeStunned = true;

	Template.AbilityMultiTargetConditions.AddItem(MultiTargetProperty);

	StatEffect = new class'X2Effect_WarCry';

	StatEffect.BuildPersistentEffect(default.WARCRY_DURATION, false, true, false, eGameRule_PlayerTurnEnd);
	//StatEffect.SetDisplayInfo (ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName); // adjust
	StatEffect.SetDisplayInfo (ePerkBuff_Bonus, Template.LocFriendlyName, class'X2Effect_WarCry'.default.strWarCryFriendlyDesc, Template.IconImage,,, Template.AbilitySourceName);

	StatEffect.DuplicateResponse = eDupe_Refresh;

	ForEach default.WARCRY_MUTON_BONUS (AlienName, i)
	{
		StatEffect.AddCharacterNameHigh (name(AlienName));
	}

	StatEffect.AddPersistentStatChange (eStat_Offense, float (default.WARCRY_MUTON_OFFENSE_BONUS), true);
	StatEffect.AddPersistentStatChange (eStat_Mobility, float (default.WARCRY_MUTON_MOBILITY_BONUS), true);
	StatEffect.AddPersistentStatChange (eStat_Will, float (default.WARCRY_MUTON_WILL_BONUS), true);


	//Template.AddShooterEffect(StatEffect); This would make Centurion gain bonuses from own War Cry
	Template.AddMultiTargetEffect(StatEffect);

	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = WarCry_BuildVisualization;
	return Template;
}

function WarCry_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory				History;
	local XComGameStateContext_Ability		context;
	local StateObjectReference				InteractingUnitRef;
	local VisualizationActionMetadata		EmptyTrack, BuildTrack, TargetTrack;
	local X2Action_PlayAnimation			PlayAnimationAction;
	local X2Action_PlaySoundAndFlyOver		SoundAndFlyover, SoundAndFlyoverTarget;
	local XComGameState_Ability				Ability;
	local XComGameState_Effect				EffectState;
	local XComGameState_Unit				UnitState;

	History = `XCOMHISTORY;
	context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	Ability = XComGameState_Ability(History.GetGameStateForObjectID(context.InputContext.AbilityRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1));
	InteractingUnitRef = context.InputContext.SourceObject;
	BuildTrack = EmptyTrack;
	BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	BuildTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	SoundAndFlyover = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(BuildTrack, context, false, BuildTrack.LastActionAdded));
	SoundAndFlyover.SetSoundAndFlyOverParameters(none, Ability.GetMyTemplate().LocFlyOverText, 'None', eColor_Alien);

	PlayAnimationAction = X2Action_PlayAnimation(class'X2Action_PlayAnimation'.static.AddToVisualizationTree(BuildTrack, context, false, BuildTrack.LastActionAdded));
	PlayAnimationAction.Params.AnimName = 'HL_WarCry';
	PlayAnimationAction.bFinishAnimationWait = true;

	foreach VisualizeGameState.IterateByClassType(class'XComGameState_Effect', EffectState)
	{
		if (EffectState.GetX2Effect().EffectName == class'X2Effect_WarCry'.default.EffectName)
		{
				TargetTrack = EmptyTrack;
				UnitState = XComGameState_Unit(VisualizeGameState.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
				if ((UnitState != none) && (EffectState.StatChanges.Length > 0))
				{
					TargetTrack.StateObject_NewState = UnitState;
					TargetTrack.StateObject_OldState = History.GetGameStateForObjectID(UnitState.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
					TargetTrack.VisualizeActor = UnitState.GetVisualizer();
					SoundandFlyoverTarget = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(TargetTrack, context, false, TargetTrack.LastActionAdded));
					SoundandFlyoverTarget.SetSoundAndFlyOverParameters(none, Ability.GetMyTemplate().LocFlyOverText, 'None', eColor_Alien);
				}
		}
	}

}

static function X2AbilityTemplate CreateMutonM2_LWAbility_BayonetCharge()
{
	local X2AbilityTemplate					Template;
	local X2AbilityCost_ActionPoints		ActionPointCost;
	local X2AbilityToHitCalc_StandardMelee	StandardMelee;
	local X2Effect_ApplyWeaponDamage		WeaponDamageEffect;
	local X2AbilityCooldown Cooldown;
	
	local X2Effect_ImmediateAbilityActivation ImpairingAbilityEffect;
	local X2Effect_PersistentStatChange		StatEffect;
	local XGParamTag						kTag;
	local string							strPenalty;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'BD_Bayonetcharge_LW');
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.IconImage = "img:///Texture2D'UILibrary_BD_LWAlienPack.LWCenturion_AbilityBayonetCharge64'";

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bfreeCost = false;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 4;
	Template.AbilityCooldown = Cooldown;

	StatEffect = new class'X2Effect_PersistentStatChange';

	kTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	if (kTag != none)
	{
		kTag.IntValue0 = default.BAYONETCHARGE_PENALTY_DURATION;
		kTag.IntValue1 = default.BAYONETCHARGE_DEFENSE_PENALTY;
		strPenalty = `XEXPAND.ExpandString(default.strBayonetChargePenalty);
	} else {
		strPenalty = "Placeholder Centurion penalty (no XGParamTag)";
	}
	StatEffect.BuildPersistentEffect(default.BAYONETCHARGE_PENALTY_DURATION, false, true, false, eGameRule_PlayerTurnEnd);
	//StatEffect.SetDisplayInfo (ePerkBuff_Penalty, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName); // adjust
	StatEffect.SetDisplayInfo (ePerkBuff_Penalty, Template.LocFriendlyName, strPenalty, Template.IconImage,,, Template.AbilitySourceName); // adjust
	StatEffect.DuplicateResponse = eDupe_Refresh;
	StatEffect.AddPersistentStatChange (eStat_Defense, float (default.BAYONETCHARGE_DEFENSE_PENALTY));
	Template.AddShooterEffect(StatEffect);

	StandardMelee = new class'X2AbilityToHitCalc_StandardMelee';
	Template.AbilityToHitCalc = StandardMelee;
	Template.AbilityTargetStyle = new class'X2AbilityTarget_MovingMelee';
	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	//Effect on a successful melee attack is triggering the Apply Impairing Effect Ability
	ImpairingAbilityEffect = new class 'X2Effect_ImmediateAbilityActivation';
	ImpairingAbilityEffect.BuildPersistentEffect(1, false, true, , eGameRule_PlayerTurnBegin);
	ImpairingAbilityEffect.EffectName = 'ImmediateStunImpair';
	ImpairingAbilityEffect.AbilityName = class'X2Ability_Impairing'.default.ImpairingAbilityName;
	ImpairingAbilityEffect.bRemoveWhenTargetDies = true;
	ImpairingAbilityEffect.VisualizationFn = class'X2Ability_Impairing'.static.ImpairingAbilityEffectTriggeredVisualization;
	Template.AddTargetEffect(ImpairingAbilityEffect);

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddTargetEffect(WeaponDamageEffect);
	Template.bAllowBonusWeaponEffects = true;
	Template.bSkipMoveStop = true;

	Template.BuildNewGameStateFn = BayonetCharge_BuildGameState;
	Template.BuildInterruptGameStateFn = class'X2Ability_DefaultAbilitySet'.static.MoveAbility_BuildInterruptGameState;

	Template.CinescriptCameraType = "Muton_Punch";
	
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.MeleeLostSpawnIncreasePerUse;

	return Template;

}

simulated function XComGameState BayonetCharge_BuildGameState(XComGameStateContext context)
{
	local XComGameState NewGameState;

	NewGameState = class'X2Ability_DefaultAbilitySet'.static.MoveAbility_BuildGameState(context);
	TypicalAbility_FillOutGameState(NewGameState);
	return NewGameState;
}

static function X2DataTemplate CreatePersonalShieldAbility()
{
	local X2AbilityTemplate							Template;
	local X2AbilityCharges							Charges;
	local X2AbilityCost_Charges						ChargeCost;
	local X2AbilityCost_ActionPoints				ActionPointCost;
	local array<name>								SkipExclusions;
	local X2Effect_EnergyShield						PersonalShieldEffect;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'BD_Personalshield_LW');

	Template.IconImage = "img:///UILibrary_BD_LWAlienPack.LW_AbilityPersonalShields"; // from old EW icon for Bioelectric skin
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bCrossClassEligible = false;
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;
	Template.bShowActivation = true;
	//Template.bSkipFireAction = true;
	Template.DisplayTargetHitChance = false;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName); //okay when disoriented
	Template.AddShooterEffectExclusions(SkipExclusions);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Charges = new class 'X2AbilityCharges';
	Charges.InitialCharges = 1;
	Template.AbilityCharges = Charges;

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargeCost);

	PersonalShieldEffect = new class'X2Effect_EnergyShield';
	PersonalShieldEffect.BuildPersistentEffect(default.PERSONAL_SHIELD_DURATION, false, true, false, eGameRule_PlayerTurnEnd);
	PersonalShieldEffect.SetDisplayInfo (ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
	PersonalShieldEffect.AddPersistentStatChange(eStat_ShieldHP, default.PERSONAL_SHIELD_HP);
	PersonalShieldEffect.EffectName='PersonalShield';
	Template.AddTargetEffect(PersonalShieldEffect);

	Template.CustomFireAnim = 'HL_SignalPositive';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CinescriptCameraType = "AdvShieldBearer_EnergyShieldArmor"; //??

	return Template;
}
