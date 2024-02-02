class AHW_Abilities_Ethereals extends X2Ability config (GameData_SoldierSKills);

var config int AHW_DIVINITY_CRIT_MOD;
var config int AHW_DIVINITY_MELEEDAMAGEMOD;

var privatewrite name AHWElderImmunityName;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(AHWEtherealDivinity());
	Templates.AddItem(CreateAHWElderImmunity());
	Templates.AddItem(AHWElderReflect());
	Templates.AddItem(AHWElderReflectShot());
	Templates.AddItem(AHWElderLifeStyle());
	Templates.AddItem(PurePassive('ElderMentalFortress', "img:///UILibrary_Common.Alert_Combat_Lose", false, 'eAbilitySource_Perk', true));
	
	return Templates;
}

static function X2AbilityTemplate AHWEtherealDivinity()
{
	local X2AbilityTemplate				Template;
	local AHW_Effect_EtherealDivinity	TargetEffect;
	local X2Effect_Bewildered			BewilderedEffect;
	local X2Effect_Regeneration			RegenerationEffect;
	local X2Effect_ToHitModifier        HitModEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AHWEtherealDivinity');

	Template.IconImage = "img:///UILibrary_Common.Head_Ethereal";
	Template.Hostility = eHostility_Neutral;
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	BewilderedEffect = new class'X2Effect_Bewildered';
	BewilderedEffect.DmgMod = -0.4f;
	BewilderedEffect.NumHitsForMod = 3;
	BewilderedEffect.BuildPersistentEffect(1, true, false, false);
	BewilderedEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage);
	Template.AddTargetEffect(BewilderedEffect);

	TargetEffect = new class'AHW_Effect_EtherealDivinity';
	TargetEffect.Penalty = -30;
	TargetEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(TargetEffect);

	RegenerationEffect = new class'X2Effect_Regeneration';
	RegenerationEffect.BuildPersistentEffect(1,  true, true, false, eGameRule_PlayerTurnBegin);
	RegenerationEffect.HealAmount = 1;
	Template.AddTargetEffect(RegenerationEffect);

	HitModEffect = new class'X2Effect_ToHitModifier';
	HitModEffect.AddEffectHitModifier(eHit_Success, 30, Template.LocFriendlyName, , true, false, true, true);
	HitModEffect.BuildPersistentEffect(1, true, false, false);
	HitModEffect.EffectName = 'AHWEtherealDivinity';
	Template.AddTargetEffect(HitModEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate CreateAHWElderImmunity()
{
	local X2AbilityTemplate					Template;
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;
	local X2Effect_DamageImmunity			DamageImmunity;
	local X2AbilityCost_ActionPoints		ActionPointCost;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AHWElderImmunity');
	
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_chosenreckoning";
	Template.Hostility = eHostility_Neutral;
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Charges = new class'X2AbilityCharges';
	Charges.InitialCharges = 1;
	Template.AbilityCharges = Charges;

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargeCost);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);


	// Build the immunities
	DamageImmunity = new class'X2Effect_DamageImmunity';
	DamageImmunity.BuildPersistentEffect(2, false, true, false, eGameRule_PlayerTurnEnd);
	DamageImmunity.SetDisplayInfo (ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
	DamageImmunity.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.ParthenogenicPoisonType);
	DamageImmunity.ImmuneTypes.AddItem('Acid');
	DamageImmunity.ImmuneTypes.AddItem('Frost');
	DamageImmunity.ImmuneTypes.AddItem('Fire');
	DamageImmunity.ImmuneTypes.AddItem('Napalm');
	DamageImmunity.ImmuneTypes.AddItem('Electrical');
	DamageImmunity.EffectName = default.AHWElderImmunityName;
	Template.AddTargetEffect(DamageImmunity);

	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateDoNotConsumeStatusEffect());

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}

static function X2AbilityTemplate AHWElderReflect()
{
	local X2AbilityTemplate						Template;
	local AHW_Effect_ElderReflect				Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AHWElderReflect');

	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

//BEGIN AUTOGENERATED CODE: Template Overrides 'Deflect'
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_deflectshot";
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
//END AUTOGENERATED CODE: Template Overrides 'Deflect'
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = new class'AHW_Effect_ElderReflect';
	Effect.BuildPersistentEffect(1, true, false);
	Effect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, true, , Template.AbilitySourceName);
	Template.AddTargetEffect(Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = none;

	return Template;
}

static function X2AbilityTemplate AHWElderReflectShot()
{
	local X2AbilityTemplate						Template;
	local X2AbilityToHitCalc_PercentChance		ChanceToHit;
	local X2AbilityTrigger_EventListener		EventListener;
	local X2Effect_ApplyReflectDamage			DamageEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AHWElderReflectShot');

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Offensive;
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_ReflectShot";

	ChanceToHit = new class'X2AbilityToHitCalc_PercentChance';
	ChanceToHit.PercentToHit = 40;
	Template.AbilityToHitCalc = ChanceToHit;

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.EventID = 'AbilityActivated';
	EventListener.ListenerData.Filter = eFilter_None;
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.TemplarReflectListener;
	Template.AbilityTriggers.AddItem(EventListener);

	Template.AbilityTargetStyle = default.SimpleSingleTarget;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();
	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitDisallowMindControlProperty);
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);

	DamageEffect = new class'X2Effect_ApplyReflectDamage';
	DamageEffect.EffectDamageValue.DamageType = 'Psi';
	Template.AddTargetEffect(DamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	
	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;

	//BEGIN AUTOGENERATED CODE: Template Overrides 'ReflectShot'
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.CustomFireAnim = 'HL_ReflectFireA';
	Template.CustomFireKillAnim = 'HL_ReflectFireA';
	//END AUTOGENERATED CODE: Template Overrides 'ReflectShot'

	return Template;
}

static function X2AbilityTemplate AHWElderLifeStyle()
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2Condition_UnitProperty TargetPropertyCondition;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	local X2Effect_LifeSteal LifeStealEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'AHWElderLifeStyle');

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_gatekeeper_animaconsume";

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_StandardMelee';

	Template.AbilityTargetStyle = default.SimpleSingleMeleeTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Shooter Conditions
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);


	Template.AddShooterEffectExclusions();

	// Damage Effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.EffectDamageValue = class'X2Item_DefaultWeapons'.default.Gatekeeper_AnimaConsume_BaseDamage;
	Template.AddTargetEffect(WeaponDamageEffect);

	// Life Steal Effect - Same as damage target but must be organic
	TargetPropertyCondition = new class'X2Condition_UnitProperty';
	TargetPropertyCondition.ExcludeHostileToSource = true;
	TargetPropertyCondition.ExcludeFriendlyToSource = false;
	TargetPropertyCondition.RequireSquadmates = true;
	TargetPropertyCondition.FailOnNonUnits = true;
	TargetPropertyCondition.ExcludeDead = true;
	TargetPropertyCondition.ExcludeRobotic = true;
	TargetPropertyCondition.ExcludeUnableToAct = true;
	TargetPropertyCondition.WithinRange = 18;

	Template.AbilityTargetConditions.AddItem(TargetPropertyCondition);
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);

	LifeStealEffect = new class'X2Effect_LifeSteal';
	LifeStealEffect.LifeAmountMultiplier = 4;
	LifeStealEffect.TargetConditions.AddItem(TargetPropertyCondition);
	LifeStealEffect.DamageTypes.AddItem('psi');
	Template.AddTargetEffect(LifeStealEffect);


	Template.CustomFireAnim = 'HL_EtherealLifeStile';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CinescriptCameraType = "HL_EtherealLifeStile";

	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;
//BEGIN AUTOGENERATED CODE: Template Overrides 'AnimaConsume'
	Template.bFrameEvenWhenUnitIsHidden = true;
//END AUTOGENERATED CODE: Template Overrides 'AnimaConsume'

	return Template;
}