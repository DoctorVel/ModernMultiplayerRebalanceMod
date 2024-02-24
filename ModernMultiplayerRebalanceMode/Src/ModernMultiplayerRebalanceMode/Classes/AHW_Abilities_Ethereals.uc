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
	Templates.AddItem(EtherealLifeSteal());
	Templates.AddItem(EtherealMindControl());
	Templates.AddItem(PurePassive('ElderMentalFortress', "img:///UILibrary_Common.Alert_Combat_Lose", false, 'eAbilitySource_Perk', true));
	Templates.AddItem(PurePassive('EtherealSoulSteal', "img:///Ethereal_PsiDrain.UIPerk_Ethereal_psi_drain", false, 'eAbilitySource_Perk', true));
	Templates.AddItem(Add_StandardShotEthereal());
	
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

static function X2AbilityTemplate EtherealLifeSteal()
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2Condition_UnitProperty TargetPropertyCondition;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	local X2Effect_LifeSteal LifeStealEffect;
	local X2Condition_NotFullHP FullHPCondition;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'EtherealLifeSteal');

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.IconImage = "img:///Ethereal_PsiDrain.UIPerk_Ethereal_psi_drain";
	Template.AbilitySourceName = 'eAbilitySource_Psionic';

	FullHPCondition = new class'X2Condition_NotFullHP';
	Template.AbilityShooterConditions.AddItem(FullHPCondition);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	Template.AbilityToHitCalc = default.DeadEye;

	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Shooter Conditions
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	Template.AddShooterEffectExclusions();

	// Damage Effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bIgnoreBaseDamage = true;
	WeaponDamageEffect.DamageTag = 'LifeSteal';
	WeaponDamageEffect.bBypassShields = true;
	WeaponDamageEffect.bIgnoreArmor = true;
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
	LifeStealEffect.LifeAmountMultiplier = 5;
	LifeStealEffect.TargetConditions.AddItem(TargetPropertyCondition);
	LifeStealEffect.DamageTypes.AddItem('psi');
	Template.AddTargetEffect(LifeStealEffect);

	Template.AssociatedPassives.AddItem('EtherealSoulSteal');

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

static function X2DataTemplate EtherealMindControl()
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityCooldown_PerPlayerType Cooldown;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2Condition_UnitEffects EffectCondition;
	local X2Condition_UnitImmunities UnitImmunityCondition;
	local X2Effect_MindControl MindControlEffect;
	local X2Effect_RemoveEffects MindControlRemoveEffects;
	local X2AbilityTarget_Single SingleTarget;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'EtherealMindControl');

	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_adventpsiwitch_mindcontrol";
	Template.Hostility = eHostility_Offensive;
	Template.bShowActivation = true;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown_PerPlayerType';
	Cooldown.iNumTurns = 6;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_StatCheck_UnitVsUnit';

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
	EffectCondition.AddExcludeEffect(class'X2Ability_CarryUnit'.default.CarryUnitEffectName, 'AA_CarryingUnit');
	Template.AbilityTargetConditions.AddItem(EffectCondition);

	// MindControl effect for 1 or more unblocked psi hit
	MindControlEffect = class'X2StatusEffect_MKNew'.static.CreateMindControlStatusEffectNew(class'X2Ability_PsiWitch'.default.MIND_CONTROL_PLAYER_TURNS_DURATION);
	MindControlEffect.MinStatContestResult = 1;
	Template.AbilityTargetEffects.InsertItem(0, MindControlEffect);

	MindControlRemoveEffects = class'X2StatusEffects'.static.CreateMindControlRemoveEffects();
	MindControlRemoveEffects.MinStatContestResult = 1;
	Template.AddTargetEffect(MindControlRemoveEffects);
	// MindControl effect for 1 or more unblocked psi hit

	SingleTarget = new class'X2AbilityTarget_Single';
	Template.AbilityTargetStyle = SingleTarget;

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Unlike in other cases, in TypicalAbility_BuildVisualization, the MissSpeech is used on the Target!
	Template.TargetMissSpeech = 'SoldierResistsMindControl';

	//Template.CustomFireAnim = 'HL_EtherealMindControl';
	Template.CustomFireAnim = 'HL_MassPsiReanimate';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CinescriptCameraType = "Psionic_FireAtUnit";

	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;
//BEGIN AUTOGENERATED CODE: Template Overrides 'PsiMindControl'
	Template.bFrameEvenWhenUnitIsHidden = true;
//END AUTOGENERATED CODE: Template Overrides 'PsiMindControl'

	return Template;
}

static function X2AbilityTemplate Add_StandardShotEthereal( Name AbilityName='StandardShotEthereal', bool bNoAmmoCost = false, bool bAllowBurning = true, bool bAllowDisoriented = true)
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityCost_Ammo                AmmoCost;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local array<name>                       SkipExclusions;
	local X2Effect_Knockback				KnockbackEffect;
	local X2Condition_Visibility            VisibilityCondition;

	// Macro to do localisation and stuffs
	`CREATE_X2ABILITY_TEMPLATE(Template, AbilityName);

	// Icon Properties
	Template.bDontDisplayInAbilitySummary = true;
	Template.IconImage = "img:///Ethereal_PsiLance.UIPerk_Ethereal_psi_lance";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STANDARD_SHOT_PRIORITY;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.DisplayTargetHitChance = true;
	Template.AbilitySourceName = 'eAbilitySource_Psionic';                                      // color of the icon
	// Activated by a button press; additionally, tells the AI this is an activatable
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	if (bAllowDisoriented)
		SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	if (bAllowBurning)
		SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	// Targeting Details
	// Can only shoot visible enemies
	VisibilityCondition = new class'X2Condition_Visibility';
	VisibilityCondition.bRequireGameplayVisible = true;
	VisibilityCondition.bAllowSquadsight = true;
	Template.AbilityTargetConditions.AddItem(VisibilityCondition);
	// Can't target dead; Can't target friendlies
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	// Can't shoot while dead
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	// Only at single targets that are in range.
	Template.AbilityTargetStyle = default.SimpleSingleTarget;

	// Action Point
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.DoNotConsumeAllSoldierAbilities.AddItem('SkirmisherStrike');
	Template.AbilityCosts.AddItem(ActionPointCost);	

	// Ammo
	if( !bNoAmmoCost )
	{
		AmmoCost = new class'X2AbilityCost_Ammo';
		AmmoCost.iAmmo = 1;
		Template.AbilityCosts.AddItem(AmmoCost);
	}
	Template.bAllowAmmoEffects = true; // 	
	Template.bAllowBonusWeaponEffects = true;

	// Weapon Upgrade Compatibility
	Template.bAllowFreeFireWeaponUpgrade = true;                        // Flag that permits action to become 'free action' via 'Hair Trigger' or similar upgrade / effects

	//  Put holo target effect first because if the target dies from this shot, it will be too late to notify the effect.
	Template.AddTargetEffect(class'X2Ability_Chosen'.static.HoloTargetEffect());
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());
	//  Various Soldier ability specific effects - effects check for the ability before applying	
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect());
	
	// Damage Effect
	Template.AddTargetEffect(default.WeaponUpgradeMissDamage);

	// Hit Calculation (Different weapons now have different calculations for range)
	Template.AbilityToHitCalc = default.SimpleStandardAim;
	Template.AbilityToHitOwnerOnMissCalc = default.SimpleStandardAim;
		
	// Targeting Method
	Template.TargetingMethod = class'X2TargetingMethod_OverTheShoulder';
	Template.bUsesFiringCamera = true;
	Template.CinescriptCameraType = "StandardGunFiring";	

	Template.AssociatedPassives.AddItem('HoloTargeting');

	// MAKE IT LIVE!
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;	
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;

	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;

	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = 2;
	Template.AddTargetEffect(KnockbackEffect);

	class'X2StrategyElement_XpackDarkEvents'.static.AddStilettoRoundsEffect(Template);

	Template.PostActivationEvents.AddItem('StandardShotActivated');

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;

	Template.bFrameEvenWhenUnitIsHidden = true;

	return Template;	
}

