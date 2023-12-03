class X2Ability_SectoidCommanderAbilitySet extends X2Ability config(SectoidCommander);

var config int MIND_FRAY_COOLDOWN;
var config int MIND_FRAY_COOLDOWN_GLOBAL;

var config int G_MIND_MERGE_COOLDOWN;
var config int G_MIND_MERGE_COOLDOWN_GLOBAL;
var config int G_MIND_MERGE_RANGE_METERS;
var config int G_MIND_MERGE_DURATION;

var config int G_MIND_MERGE_HP;
var config int G_MIND_MERGE_CRIT;
var config float G_MIND_MERGE_DMG_REDUCTION;

var config int PSI_PANIC_COOLDOWN;
var config int PSI_PANIC_COOLDOWN_GLOBAL;
var config int PSI_PANIC_TURNS;

var config int MIND_CONTROL_COOLDOWN;
var config int MIND_CONTROL_COOLDOWN_GLOBAL;
var config int MIND_CONTROL_DURATION;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(PsiPanic());
	Templates.AddItem(MindControl());

	return Templates;
}





static function X2DataTemplate PsiPanic()
{
	local X2AbilityTemplate             Template;
	local X2AbilityCost_ActionPoints    ActionPointCost;
	local X2AbilityCooldown_LocalAndGlobal Cooldown;
	local X2Condition_UnitProperty      UnitPropertyCondition;
	local X2Condition_Visibility        TargetVisibilityCondition;
	local X2Condition_UnitImmunities	UnitImmunityCondition;
	local X2Condition_UnitEffects		ExcludeEffects;
	local X2Effect_Panicked             PanickedEffect;
	local X2AbilityTarget_Single        SingleTarget;
	local X2AbilityTrigger_PlayerInput  InputTrigger;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'PsiPanic');
	
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.IconImage = "img:///Sectoid_Commander_Psi_Panic.UIPerk_sectoid_comander_psi_panic";

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = default.PSI_PANIC_COOLDOWN;
	Cooldown.NumGlobalTurns = default.PSI_PANIC_COOLDOWN_GLOBAL;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_StatCheck_UnitVsUnit';

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	Template.AbilityShooterConditions.AddItem(UnitPropertyCondition);

	Template.AddShooterEffectExclusions();

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = true;
	UnitPropertyCondition.ExcludeRobotic = true;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);
	
	TargetVisibilityCondition = new class'X2Condition_Visibility';	
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	ExcludeEffects = new class'X2Condition_UnitEffects';
	ExcludeEffects.AddExcludeEffect(class'X2Ability_CarryUnit'.default.CarryUnitEffectName, 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(ExcludeEffects);

	UnitImmunityCondition = new class'X2Condition_UnitImmunities';
	UnitImmunityCondition.AddExcludeDamageType('Mental');
	UnitImmunityCondition.bOnlyOnCharacterTemplate = true;
	Template.AbilityTargetConditions.AddItem(UnitImmunityCondition);

	PanickedEffect = class'X2StatusEffects'.static.CreatePanickedStatusEffect();
	PanickedEffect.BuildPersistentEffect(default.PSI_PANIC_TURNS, , , , eGameRule_PlayerTurnBegin);
	Template.AddTargetEffect(PanickedEffect);

	SingleTarget = new class'X2AbilityTarget_Single';
	Template.AbilityTargetStyle = SingleTarget;

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);

	Template.TargetMissSpeech = 'SoldierResistsMindControl';

	Template.bShowActivation = true;

	Template.CustomFireAnim = 'HL_SectoidCommanderAbilityA';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CinescriptCameraType = "Sectoid_Mindspin";

	Template.Hostility = eHostility_Offensive;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	
	return Template;
}

static function X2DataTemplate MindControl()
{
	local X2AbilityTemplate             Template;
	local X2AbilityCost_ActionPoints    ActionPointCost;
	local X2AbilityCooldown_LocalAndGlobal Cooldown;
	local X2Condition_UnitProperty      UnitPropertyCondition;
	local X2Condition_Visibility        TargetVisibilityCondition;
	local X2Condition_UnitImmunities	UnitImmunityCondition;
	local X2Condition_UnitEffects		ExcludeEffects;
	local X2Effect_MindControl          MindControlEffect;
	local X2Effect_RemoveEffects        MindControlRemoveEffects;
	local X2AbilityTarget_Single        SingleTarget;
	local X2AbilityTrigger_PlayerInput  InputTrigger;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MindControl');
	
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.IconImage = "img:///Sectoid_Commander_Mind_Control.UIPerk_mind_control";

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = default.MIND_CONTROL_COOLDOWN;
	Cooldown.NumGlobalTurns = default.MIND_CONTROL_COOLDOWN_GLOBAL;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_StatCheck_UnitVsUnit';

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	Template.AbilityShooterConditions.AddItem(UnitPropertyCondition);

	Template.AddShooterEffectExclusions();

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = true;
	UnitPropertyCondition.ExcludeRobotic = true;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);
	
	TargetVisibilityCondition = new class'X2Condition_Visibility';	
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	ExcludeEffects = new class'X2Condition_UnitEffects';
	ExcludeEffects.AddExcludeEffect(class'X2Ability_CarryUnit'.default.CarryUnitEffectName, 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(ExcludeEffects);

	UnitImmunityCondition = new class'X2Condition_UnitImmunities';
	UnitImmunityCondition.AddExcludeDamageType('Mental');
	UnitImmunityCondition.bOnlyOnCharacterTemplate = true;
	Template.AbilityTargetConditions.AddItem(UnitImmunityCondition);

	MindControlEffect = class'X2StatusEffects'.static.CreateMindControlStatusEffect(default.MIND_CONTROL_DURATION);
	Template.AddTargetEffect(MindControlEffect);

	MindControlRemoveEffects = class'X2StatusEffects'.static.CreateMindControlRemoveEffects();
	MindControlRemoveEffects.DamageTypes.AddItem('Mental');
	Template.AddTargetEffect(MindControlRemoveEffects);

	SingleTarget = new class'X2AbilityTarget_Single';
	Template.AbilityTargetStyle = SingleTarget;

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);

	Template.TargetMissSpeech = 'SoldierResistsMindControl';
	Template.bShowActivation = true;

	Template.CustomFireAnim = 'HL_SectoidCommanderAbilityA';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CinescriptCameraType = "Sectoid_Mindspin";

	Template.Hostility = eHostility_Offensive;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	
	return Template;
}