class X2Ability_StandardShotWarlock extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(Add_StandardShotWarlock());
	Templates.AddItem(AddEtherealPossess());
	
	return Templates;
}

static function X2AbilityTemplate Add_StandardShotWarlock( Name AbilityName='StandardShotWarlock', bool bNoAmmoCost = false, bool bAllowBurning = true, bool bAllowDisoriented = true)
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
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_standard";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STANDARD_SHOT_PRIORITY;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.DisplayTargetHitChance = true;
	Template.AbilitySourceName = 'eAbilitySource_Standard';                                       // color of the icon
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


static function X2DataTemplate AddEtherealPossess()
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityCharges Charges;
	local X2AbilityCost_Charges ChargeCost;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2Condition_UnitEffects ExcludeEffectsCondition;
	local X2Condition_UnitTypePossess  UnitTypeCondition;
	local X2Condition_UnitEffectsApplying ApplyingEffectsCondition;
	local X2Effect_PersistentStatChange PossessEffect;
	local X2Effect_EtheralGhost Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'EtherealPossess');
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_possess";
	Template.Hostility = eHostility_Offensive;
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Charges = new class 'X2AbilityCharges';
	Charges.InitialCharges = 1;
	Template.AbilityCharges = Charges;

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargeCost);

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Shooter Conditions
	//
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();	// Discuss with Jake/Design what exclusions are allowed here

	ApplyingEffectsCondition = new class'X2Condition_UnitEffectsApplying';
	ApplyingEffectsCondition.AddExcludeEffect(class'X2Ability_AdvPriest'.default.HolyWarriorEffectName, 'AA_AbilityUnavailable');
	ApplyingEffectsCondition.AddExcludeEffect(class'X2Effect_MindControl'.default.EffectName, 'AA_UnitIsMindControlling');
	Template.AbilityTargetConditions.AddItem(ApplyingEffectsCondition);

	// Target Conditions
	//
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);
	
	UnitTypeCondition = new class'X2Condition_UnitTypePossess';
	Template.AbilityTargetConditions.AddItem(UnitTypeCondition);

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeHostileToSource = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeRobotic = true;
	UnitPropertyCondition.FailOnNonUnits = true;
	UnitPropertyCondition.ExcludeCivilian = true;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

	ExcludeEffectsCondition = new class'X2Condition_UnitEffects';
	ExcludeEffectsCondition.AddExcludeEffect(class'X2Ability_AdvPriest'.default.HolyWarriorEffectName, 'AA_AbilityUnavailable');
	ExcludeEffectsCondition.AddExcludeEffect(class'X2Effect_EnergyShield'.default.EffectName, 'AA_DuplicateEffectIgnored');
	ExcludeEffectsCondition.AddExcludeEffect(class'X2Effect_Stasis'.default.EffectName, 'AA_AbilityUnavailable');
	Template.AbilityTargetConditions.AddItem(ExcludeEffectsCondition);
	
	PossessEffect = new class'X2Effect_PersistentStatChange';
	PossessEffect.BuildPersistentEffect(3, false, true, false, eGameRule_PlayerTurnEnd);
	PossessEffect.SetDisplayInfo (ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
	PossessEffect.DuplicateResponse = eDupe_Ignore;
	PossessEffect.AddPersistentStatChange(eStat_ShieldHP, 10);
	PossessEffect.AddPersistentStatChange(eStat_Will, 200);
	PossessEffect.AddPersistentStatChange(eStat_Mobility, 2);
	PossessEffect.AddPersistentStatChange(eStat_Offense, 30);
	PossessEffect.EffectName='EtherealPossess';
	PossessEffect.bRemoveWhenTargetDies = true;
	Template.AddTargetEffect(PossessEffect);

	Template.AddShooterEffectExclusions();

	Effect = new class'X2Effect_EtheralGhost';
    Effect.BuildPersistentEffect(3, false, true, false, eGameRule_PlayerTurnEnd);
    Template.AddTargetEffect(Effect);

	Template.AdditionalAbilities.AddItem('PossessTurnLife');

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CustomFireAnim = 'HL_EtherealPosses';
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.CinescriptCameraType = "HL_EtherealPosses";

	Template.bShowActivation = true;


	return Template;
}