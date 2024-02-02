class X2Ability_AdvDroneMP extends X2Ability;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateDroneRepairAbility());
	Templates.AddItem(Add_StandardShotDrone());
	Templates.AddItem(DroneAidProtocol());
	
	return Templates;
}

static function X2DataTemplate CreateDroneRepairAbility()
{
	local X2AbilityTemplate							Template;
	local X2AbilityCost_ActionPoints				ActionPointCost;
	local X2Effect_RemoveEffectsByDamageType		RemoveEffects;
	local X2Condition_UnitProperty					UnitPropertyCondition;
	local X2Effect_SimpleHeal						RepairEffect;
	local X2Condition_Visibility					TargetVisibilityCondition;
	local X2AbilityTarget_Single					SingleTarget;
	local X2AbilityCooldown							Cooldown;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'BD_DroneRepair_LW');
	Template.IconImage = "img:///UILibrary_BD_LWAlienPack.LW_AbilityDroneRepair"; //from old EW Repair Servos icon
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Only at single targets that are in range.
	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 1; // just to prevent from triggering twice in a turn
	Template.AbilityCooldown = Cooldown;

	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	Template.bCrossClassEligible = false;
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;
	Template.bShowActivation = true;
	Template.DisplayTargetHitChance = false;

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeHostileToSource = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeFullHealth = true;
	UnitPropertyCondition.ExcludeOrganic = true;
	UnitPropertyCondition.ExcludeRobotic = false;
	UnitPropertyCondition.FailOnNonUnits = true;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

	RepairEffect = new class'X2Effect_SimpleHeal';
	Template.AddTargetEffect(RepairEffect);

	RemoveEffects = new class'X2Effect_RemoveEffectsByDamageType';
	RemoveEffects.DamageTypesToRemove.AddItem('Fire');
	RemoveEffects.DamageTypesToRemove.AddItem('Acid');
	Template.AddTargetEffect(RemoveEffects);

	Template.CustomFireAnim = 'NO_Repair';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.bShowActivation = true;

	return Template;
}

static function X2AbilityTemplate Add_StandardShotDrone( Name AbilityName='StandardShotDrone', bool bNoAmmoCost = false, bool bAllowBurning = true, bool bAllowDisoriented = true)
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
	Template.TargetingMethod = class'X2TargetingMethod_OverTheShoulder';
	Template.bUsesFiringCamera = true;
	Template.CinescriptCameraType = "StandardGunFiring";	

	Template.AssociatedPassives.AddItem('HoloTargeting');

	// MAKE IT LIVE!

	Template.CustomFireAnim = 'NO_ArcStun';
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

static function X2AbilityTemplate DroneAidProtocol()
{
	local X2AbilityTemplate                     Template;
	local X2AbilityCost_ActionPoints            ActionPointCost;
	local X2Condition_UnitProperty              TargetProperty;
	local X2Condition_UnitEffects               EffectsCondition;
	local X2AbilityCooldown				        Cooldown;
	local X2Effect_PersistentStatChange AidProtocolEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'DroneAidProtocol');

	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_aidprotocol";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Defensive;
	Template.bLimitTargetIcons = true;
	Template.DisplayTargetHitChance = false;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY;

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 3;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SingleTargetWithSelf;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = true;
	TargetProperty.ExcludeFriendlyToSource = false;
	TargetProperty.RequireSquadmates = true;
	Template.AbilityTargetConditions.AddItem(TargetProperty);

	EffectsCondition = new class'X2Condition_UnitEffects';
	EffectsCondition.AddExcludeEffect('AidProtocol', 'AA_UnitIsImmune');
	EffectsCondition.AddExcludeEffect('DroneAidProtocol', 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(EffectsCondition);

	AidProtocolEffect = new class'X2Effect_PersistentStatChange';
	AidProtocolEffect.EffectName = 'DroneAidProtocol';
	AidProtocolEffect.DuplicateResponse = eDupe_Ignore;
	AidProtocolEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	AidProtocolEffect.bRemoveWhenTargetDies = true;
	AidProtocolEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage);
	AidProtocolEffect.AddPersistentStatChange(eStat_Defense, 10);

	Template.AddTargetEffect(AidProtocolEffect);


	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.bSkipPerkActivationActions = true;
	Template.bShowActivation = true;

	Template.CustomFireAnim = 'NO_DroneAidProtocol';
	Template.CustomSelfFireAnim = 'NO_DroneAidProtocol';

	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.NonAggressiveChosenActivationIncreasePerUse;
//BEGIN AUTOGENERATED CODE: Template Overrides 'AidProtocol'
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
//END AUTOGENERATED CODE: Template Overrides 'AidProtocol'

	return Template;
}
