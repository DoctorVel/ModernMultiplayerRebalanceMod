//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_ModernMultiplayerRebalanceMode.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_ModernMultiplayerRebalanceMode extends X2DownloadableContentInfo;

var config WeaponDamageValue FRAGGRENADE_BASEDAMAGE;


static final function SetHidden(out X2AbilityTemplate Template)
{
    Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
    Template.bDisplayInUITacticalText = false;
    Template.bDisplayInUITooltip = false;
    Template.bDontDisplayInAbilitySummary = true;
    Template.bHideOnClassUnlock = true;
}

static event OnPostTemplatesCreated()
{
    HideTeleportAlly();
	HideWarlockLevelM2();
	HideRemoveSpectralZombies();
	HideAvatarDamagedTeleport();
	HideDimensionalRiftStage2Ability();
	HideAvatarInitializationAbility();
	HideWarlockFocusM2();
	HideRapidFire2();
	HideKillzoneShot();
	HideBendingReed();
	HideVanishingWind_Reveal();
	HideLongWatchShot();
	HideChosenLowProfileTrigger();
	RapidFirePatch();
	SteadyHandsPatch();
    MindScorchPatch();
	PartingSilkPatch();
	HarborWavePatch();
	LethalDosePatch();
	TrackingShotPatch();
	TrackingShotMarkPatch();
	HunterRifleShotPatch();
	HunterKillZonePatch();
	HunterSniperRifleT4Patch();
	ChosenSniperPistolt4Patch();
	ChosenRifle_MGPatch();
	ChosenShotgun_T4Patch();
	AdvCaptainM3_WPNPatch();
	SpectralArmyM2Patch();
	PsiDimensionalRiftStage1Patch();
	VanishingWindPatch();
	GatekeeperMP_WPNPatch();
	SpectreMP_WPNPatch();
	AdvPriestMP_WPNPatch();
	GatekeeperPatch();
	AdvMEC_M2WPNPatch();
	HunterConcussionGrenadePatch();
    AdvPsiWitchM3_WPNPatch();
	AnimaGatePatch();
	MarkTargetShotPatch();
	BendingReedPatch2();
	WrathCannonStage1AbilityPatch();
	WrathCannonStage2AbilityPatch();
	EndBindPatch();
	CombatPresencePatch();
	SpawnChryssalidPatch();
	SpawnChryssalidMPPatch();
	CorressPatch2();
	SpecrtalArmyPatch2();
	ChosenAllSeeingPatch();
	ChosenLowProfilePatch();
	ChosenRevengePatch();
	TrackingShot2Patch();
	SectopodMPPatch();
	TrackingShot2Patch();
	HolyWarriorM3Patch();
	BindPatch();
	GetOverHerePatch();
	LostAttackPatch();
	ItemIcon();
	SpectralStunLancerPatch();
	InspirePatch2();
	SpectralZombieM2Patch();
	ChosenLowProfileTriggerPatch();
	StasisMPPatch();
	StasisPriestMPPatch();
	SwitchToRobotPatch();
	ChryssalidSlashMPPatch();
	SpawnChryssalidMPPatch2();
	RevivalProtocolPatch();
	BattleScanerPatch();
	DarkEventAbility_UndyingLoyaltyPatch();
	PsiZombiePatch();
	ChosenKineticPlatingPatch();
	PoisonSpitPatch();
	ChosenImmunitiesPatch();
	PoisonSpitGlobPatch();
	BindPatch2();
	FrostbitePatch();
	QuakePatch();
	IcarusDropGrabPatch();
	OverdrivePatch();
	RainmakerPatch();
	BulwarkPatch();
	IntimidatePatch();
	RepairkPatch();
	AbsorptionFieldPatch();
	NovaInitPatch();
	SparkSoldierPatch();
	RevealPatch();
	ArsenalPatch();
	SacrificePatch();
	StrikePatch();
	WreckingBallPatch();
	BombardPatch();
	NovaPatch();
	SparkFlamethrowerPatch();
	IntimidateTriggerPatch();
	SparkRocketLauncherPatch();
} 


// Hide Function


static private function HideTeleportAlly()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('TeleportAlly', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

        SetHidden(Template);;
    }
}


static private function HideWarlockLevelM2()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('WarlockLevelM2', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

        SetHidden(Template);
    }
}

static private function HideWarlockFocusM2()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('WarlockFocusM2', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

        SetHidden(Template);
    }
}


static private function HideRemoveSpectralZombies()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('RemoveSpectralZombies', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

        SetHidden(Template);
    }
}


static private function HideAvatarDamagedTeleport()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('TriggerDamagedTeleport', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        SetHidden(Template);
    }
}


static private function HideDimensionalRiftStage2Ability()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('PsiDimensionalRiftStage2', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_adventpsiwitch_dimensionrift";
		SetHidden(Template);
    }
}


static private function HideAvatarInitializationAbility()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('AvatarInitialization', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        SetHidden(Template);
    }
}

static private function HideRapidFire2()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('RapidFire2', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

        SetHidden(Template);
    }
}

static private function HideKillzoneShot()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('KillzoneShot', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

        SetHidden(Template);
    }
}

static private function HideVanishingWind_Reveal()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('VanishingWindReveal', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
         if (Template == none) continue;
        
        for (i = Template.AbilityTriggers.Length - 1; i >= 0; i--)
        {
            if (X2AbilityTrigger_EventListener(Template.AbilityTriggers[i]) != none)
            {
                Template.AbilityTriggers.Length = 0;
            }
        
		}
		SetHidden(Template);
    }
}


static private function HideBendingReed()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('BendingReed', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

        SetHidden(Template);
    }
}

static private function HideLongWatchShot()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('LongWatchShot', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

        SetHidden(Template);
    }
}

static private function HideChosenLowProfileTrigger()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('ChosenLowProfileTrigger', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

        SetHidden(Template);
    }
}


// Abilities and Weapons Patch


// Chosen Assassin

static private function EventListenerReturn OnAssassinAbilityActivated(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
    local XComGameStateContext_Ability	AbilityContext;
    local XComGameState_Unit			UnitState;
	local TTile							FinalTile;
	local XComGameState     			NewGameState;
	
	`LOG("Running",, 'ChosenAssassin');
	
	AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
    if (AbilityContext == none)
        return ELR_NoInterrupt;
	
	`LOG("For ability" @ AbilityContext.InputContext.AbilityTemplateName,, 'ChosenAssassin');
    
	 if (AbilityContext.InterruptionStatus == eInterruptionStatus_Interrupt)
		return ELR_NoInterrupt;

	
	`LOG("Have ability from callback data",, 'ChosenAssassin');

	if (AbilityContext.InputContext.MovementPaths.Length == 0)
		return ELR_NoInterrupt;
	
	//if (AbilityContext.InputContext.MovementPaths[0].MovementTiles.Length == 0)
	//	return ELR_NoInterrupt;
	
	`LOG("Ability has movement",, 'ChosenAssassin');
	
	UnitState = XComGameState_Unit(EventSource);
	if (UnitState == none)
	{
		`LOG("WARNING: No Unit State from event source",, 'ChosenAssassin');
		UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
		if (UnitState == none)
			return ELR_NoInterrupt;
	}
	
	`LOG("Have Unit State",, 'ChosenAssassin');
	
	if (!IsTargetUnitMoving(UnitState.ObjectID, AbilityContext.InputContext.MovementPaths, FinalTile))
		return ELR_NoInterrupt;
	
	`LOG("Unit State is moving, destination coordinates:" @ FinalTile.X @ FinalTile.Y @ FinalTile.Z,, 'ChosenAssassin');
	 
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Setting Chosen Assassin Coordinates");
	UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
	UnitState.SetUnitFloatValue('ChosenAssassinCoordinatesX', FinalTile.X, eCleanup_BeginTactical);
	UnitState.SetUnitFloatValue('ChosenAssassinCoordinatesY', FinalTile.Y, eCleanup_BeginTactical);
	UnitState.SetUnitFloatValue('ChosenAssassinCoordinatesZ', FinalTile.Z, eCleanup_BeginTactical);
	`GAMERULES.SubmitGameState(NewGameState);
	
    return ELR_NoInterrupt;
}


static private function EventListenerReturn VanishingWindRevealOnAbilityActivation(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameStateContext_Ability	AbilityContext;
	local XComGameState_Ability			AbilityState;
	local XComGameState_Ability			RevealAbilityState;
	local array<GameRulesCache_VisibilityInfo> VisibilityInfos;
	local GameRulesCache_VisibilityInfo VisibilityInfo;
	local XComGameState_Unit			OwnerUnit;
	local vector						OwnerUnitPosition;
	local XComGameStateHistory			History;
	local XComGameState_Unit			UnitState;
	local StateObjectReference			AbilityRef;
	local TTile							OwnerUnitTileLocation;
	local UnitValue						UV;
	local bool							bMissingUnitValue;
	
	`LOG("Begin",, 'VanishinWindReveal');
	
	AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
	if(AbilityContext == none)
		return ELR_NoInterrupt;
	
	`LOG("Ability activation:" @ AbilityContext.InputContext.AbilityTemplateName,, 'VanishinWindReveal');
	
	if(AbilityContext.InterruptionStatus == eInterruptionStatus_Interrupt)
		return ELR_NoInterrupt;
	
	`LOG("Not an interrupt",, 'VanishinWindReveal');
	
	AbilityState = XComGameState_Ability(EventData);
	if (AbilityState == none)
		return ELR_NoInterrupt;
	
	`LOG("Have the ability state",, 'VanishinWindReveal');

	History = `XCOMHISTORY;
	foreach History.IterateByClassType(class'XComGameState_Unit', OwnerUnit)
	{
		`LOG("Unit in history:" @ OwnerUnit.GetMyTemplateName() @ "on team:" @ OwnerUnit.GetTeam(),, 'VanishinWindReveal');
		
		if (OwnerUnit.IsDead() || OwnerUnit.GetMyTemplateName() != 'ChosenAssassinMP')
			continue;
		
		AbilityRef = OwnerUnit.FindAbility('VanishingWindReveal');
		RevealAbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
		if (RevealAbilityState == none)
			continue;
		
		`LOG("Have Chosen Assassin and reveal ability state on team:" @ OwnerUnit.GetTeam(),, 'VanishinWindReveal');
		
		if (AbilityContext.InputContext.SourceObject.ObjectID == OwnerUnit.ObjectID)
		{
			`LOG("Ability was activated by this Assassin",, 'VanishinWindReveal');
			
			if (AbilityState.RetainConcealmentOnActivation(AbilityContext))
			{
				`LOG("This ability does not break concealment",, 'VanishinWindReveal');
			}
			else
			{
				`LOG("This ability breaks concealment, triggering reveal",, 'VanishinWindReveal');
				RevealAbilityState.AbilityTriggerAgainstSingleTarget(OwnerUnit.GetReference(), false);
				continue; // Go to next potential Assassin
			}
		}
		else
		{
			`LOG("Ability was activated by another unit",, 'VanishinWindReveal');
		}
		
		bMissingUnitValue = OwnerUnit.GetUnitValue('ChosenAssassinCoordinatesX', UV);
		OwnerUnitTileLocation.X = UV.fValue;
		if (!bMissingUnitValue)
			`LOG("Warning! Missing X unit value",, 'VanishinWindReveal');
		
		bMissingUnitValue = OwnerUnit.GetUnitValue('ChosenAssassinCoordinatesY', UV);
		OwnerUnitTileLocation.Y = UV.fValue;
		if (!bMissingUnitValue)
			`LOG("Warning! Missing Y unit value",, 'VanishinWindReveal');
		
		bMissingUnitValue = OwnerUnit.GetUnitValue('ChosenAssassinCoordinatesZ', UV);
		OwnerUnitTileLocation.Z = UV.fValue;
		if (!bMissingUnitValue)
			`LOG("Warning! Missing Z unit value",, 'VanishinWindReveal');
		
		OwnerUnitPosition = `XWORLD.GetPositionFromTileCoordinates(OwnerUnitTileLocation);
		class'X2TacticalVisibilityHelpers'.static.GetAllEnemiesForLocation(OwnerUnitPosition, OwnerUnit.ControllingPlayer.ObjectID, VisibilityInfos);
		
		`LOG("This assassin is on tile:" @ OwnerUnitTileLocation.X @ OwnerUnitTileLocation.Y @ OwnerUnitTileLocation.Z @ "Visible to enemy units:" @ VisibilityInfos.Length,, 'VanishinWindReveal');
		
		foreach VisibilityInfos(VisibilityInfo)
		{
			if (!VisibilityInfo.bVisibleBasic)
				continue; // Go to next visible enemy
			
			UnitState = XComGameState_Unit(History.GetGameStateForObjectID(VisibilityInfo.SourceID));
			if (UnitState == none)
				continue; // Go to next visible enemy
			
			`LOG("Visible to enemy unit:" @ UnitState.GetMyTemplateName(),, 'VanishinWindReveal');
			
			if (VisibilityInfo.TargetCover == CT_None)
			{
				`LOG("Flanked by this unit, triggering reveal",, 'VanishinWindReveal');
				
				RevealAbilityState.AbilityTriggerAgainstSingleTarget(OwnerUnit.GetReference(), false);
				break; // Go to next Assassin
			}
			
			if (UnitState.HasSoldierAbility('ChosenAllSeeing', true))
			{
				`LOG("Unit has Chosen All Seeing, triggering reveal",, 'VanishinWindReveal');
					
				RevealAbilityState.AbilityTriggerAgainstSingleTarget(OwnerUnit.GetReference(), false);
				break; // Go to next Assassin
			}
		}
	}

	`LOG("Reached EOL",, 'VanishinWindReveal');
	
	return ELR_NoInterrupt;
}


static private function bool IsTargetUnitMoving(const int ObjectID, const array<PathingInputData> MovementPaths, out TTile FinalTile)
{
	local PathingInputData MovementPath;
	local int i;

	//`AMLOG("Running for objectID:" @ ObjectID @ "num movement paths:" @ MovementPaths.Length);
	
	foreach MovementPaths(MovementPath, i)
	{
		//`AMLOG("Path number i:" @ i @ MovementPath.MovingUnitRef.ObjectID @ MovementPath.MovementTiles.Length);
		if (MovementPath.MovingUnitRef.ObjectID == ObjectID && MovementPath.MovementTiles.Length > 0)
		{
			//`AMLOG("Target is moving");
			FinalTile = MovementPath.MovementTiles[MovementPath.MovementTiles.Length - 1];
			return true;
		}
	}
	//`AMLOG("Target is NOT moving");
	return false;
}

static private function ChosenImmunitiesPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('ChosenImmunities', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
		
		 for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_DamageImmunity(Template.AbilityTargetEffects[i]) != none)
            {
				X2Effect_DamageImmunity(Template.AbilityTargetEffects[i]).SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), "img:///UILibrary_PerkIcons.UIPerk_mentalfortress", , , Template.AbilitySourceName);
            }
        }
		

		Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_mentalfortress";

    }
}

static private function RevealPatch()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;
	local X2AbilityTrigger_EventListener Trigger;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('VanishingWindReveal', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Trigger = new class'X2AbilityTrigger_EventListener';
		Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
		Trigger.ListenerData.EventFn = VanishingWindRevealOnAbilityActivation;
		Trigger.ListenerData.EventID = 'AbilityActivated';
		Trigger.ListenerData.Filter = eFilter_None;
		Template.AbilityTriggers.AddItem(Trigger);

		Trigger = new class'X2AbilityTrigger_EventListener';
		Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
		Trigger.ListenerData.EventID = 'VanishingWindRevealEvent';
		Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
		Trigger.ListenerData.Filter = eFilter_Unit;
		Template.AbilityTriggers.AddItem(Trigger);

    }
}


static private function VanishingWindPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2Condition_UnitEffects UnitEffectsCondition;
	local X2AbilityCharges							Charges;
	local X2AbilityCost_Charges						ChargeCost;
	local X2AbilityTrigger_EventListener Trigger;
	local X2Effect_VanishingWindRevealTimer RevealTimer;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('VanishingWind', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
         if (Template == none) continue;
        
        for (i = Template.AbilityShooterConditions.Length - 1; i >= 0; i--)
        {
            if (X2Condition_UnitEffects(Template.AbilityShooterConditions[i]) != none)
            {
                Template.AbilityShooterConditions.Remove(i, 1);
            }
        }
		
		
		Template.AbilityShooterConditions.AddItem(new class'X2Condition_Stealth');

		UnitEffectsCondition = new class'X2Condition_UnitEffects';
		UnitEffectsCondition.AddExcludeEffect('VanishingWind', 'AA_UnitIsConcealed');
		Template.AbilityShooterConditions.AddItem(UnitEffectsCondition);

        ActionPointCost = new class'X2AbilityCost_ActionPoints';
		ActionPointCost.iNumPoints = 1;
	    ActionPointCost.bFreeCost = true;
	    Template.AbilityCosts.AddItem(ActionPointCost);

		Template.AdditionalAbilities.RemoveItem('VanishingWind_Scamper');

		Charges = new class 'X2AbilityCharges';
		Charges.InitialCharges = 3;
		Template.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		Template.AbilityCosts.AddItem(ChargeCost);

		Trigger = new class'X2AbilityTrigger_EventListener';
		Trigger.ListenerData.EventID = 'AbilityActivated';
		Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
		Trigger.ListenerData.Filter = eFilter_Unit;
		Trigger.ListenerData.EventFn = OnAssassinAbilityActivated; 
		Trigger.ListenerData.Priority = 100;
		Template.AbilityTriggers.AddItem(Trigger);

		RevealTimer = new class'X2Effect_VanishingWindRevealTimer';
		RevealTimer.BuildPersistentEffect(2, false, true, false, eGameRule_PlayerTurnBegin);
		RevealTimer.DuplicateResponse = eDupe_Refresh;
		RevealTimer.EffectName = 'VanishingWindRevealEffect';
		Template.AddShooterEffect(RevealTimer);
    }

}



static private function PartingSilkPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
    local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('PartingSilk', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
   
        for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_Dazed(Template.AbilityTargetEffects[i]) != none)
            {
                Template.AbilityTargetEffects.Remove(i, 1);
            }
        }
		for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_Knockback(Template.AbilityTargetEffects[i]) != none)
            {
                Template.AbilityTargetEffects.Remove(i, 1);
            }
        }
		for (i = Template.AbilityTargetConditions.Length - 1; i >= 0; i--)
		if (X2Condition_UnitProperty(Template.AbilityTargetConditions[i]) != none && (X2Condition_UnitProperty(Template.AbilityTargetConditions[i]).RequireUnitSelectedFromHQ)
){
    Template.AbilityTargetConditions.Remove(i, 1);
        }
		for (i = Template.AbilityCosts.Length - 1; i >= 0; i--)
		X2AbilityCost_ActionPoints(Template.AbilityCosts[i]).bConsumeAllPoints = true;
    }

}


static private function HarborWavePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
    local X2Effect_ApplyWeaponDamage Damage;
    local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('HarborWave', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        Template.AbilityMultiTargetEffects.Length = 0;
        Template.AbilityTargetEffects.Length = 0;
		for (i = Template.AbilityCosts.Length - 1; i >= 0; i--)
		X2AbilityCost_ActionPoints(Template.AbilityCosts[i]).bConsumeAllPoints = true;
        
        Damage = new class'X2Effect_ApplyWeaponDamage';
        Damage.bIgnoreBaseDamage = true;
		Damage.bIgnoreArmor = true;
        Damage.EffectDamageValue.Damage = 6;
        Damage.EffectDamageValue.DamageType = 'Psi';
        
        Template.AddTargetEffect(Damage);
        Template.AddMultiTargetEffect(Damage);
		Template.AddShooterEffectExclusions();
	

        X2AbilityMultiTarget_Cone(Template.AbilityMultiTargetStyle).bLockShooterZ = false;
       	
	
    }
}

static private function ChosenShotgun_T4Patch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('ChosenShotgun_T4', DifficultyVariants);
	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);
        if (Template != none)
        {
		Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_Chosen_Shotgun";
	    }
	}
}

static private function BendingReedPatch2()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2Effect_PersistentStatChange MobilityIncrease;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('BendingReed', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
         if (Template == none) continue;

		  for (i = Template.AbilityShooterEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_PersistentStatChange(Template.AbilityShooterEffects[i]) != none)
            {
                Template.AbilityShooterEffects.Remove(i, 1);
			}
		}
		MobilityIncrease = new class'X2Effect_PersistentStatChange';
        MobilityIncrease.BuildPersistentEffect(1, false, true, true, eGameRule_PlayerTurnEnd);
        MobilityIncrease.AddPersistentStatChange(eStat_Mobility, class'X2Ability_ChosenAssassin'.default.BENDINGREED_MOBILITY_INCREASE, MODOP_Multiplication);
        Template.AddShooterEffect(MobilityIncrease);
		}
}

static private function RapidFirePatch()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;
	local X2AbilityCooldown Cooldown;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('RapidFire', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template != none)
        {
            Cooldown = new class'X2AbilityCooldown';
            Cooldown.iNumTurns = 2;
            Template.AbilityCooldown = Cooldown;
        }
    }
}

static private function ChosenKineticPlatingPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('ChosenKineticPlating', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

        SetHidden(Template);
		Template.AdditionalAbilities.AddItem('ChosenKineticPlatingPassive');
    }
}

// Chosen Hunter

static private function LethalDosePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2Condition_UnitImmunities UnitImmunityCondition;
	local X2Effect_ApplyWeaponDamage DamageEffect;
    local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('LethalDose', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
   
        for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_Dazed(Template.AbilityTargetEffects[i]) != none)
            {
                Template.AbilityTargetEffects.Remove(i, 1);
            }
        }
		for (i = Template.AbilityTargetConditions.Length - 1; i >= 0; i--)
		if (X2Condition_UnitProperty(Template.AbilityTargetConditions[i]) != none && (X2Condition_UnitProperty(Template.AbilityTargetConditions[i]).RequireUnitSelectedFromHQ)
){
    Template.AbilityTargetConditions.Remove(i, 1);
        }
		for (i = Template.AbilityCosts.Length - 1; i >= 0; i--)
		X2AbilityCost_ActionPoints(Template.AbilityCosts[i]).bConsumeAllPoints = false;


		Template.AddTargetEffect(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, 100));
		Template.AddTargetEffect(class'X2StatusEffects'.static.CreatePoisonedStatusEffect());

		Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_StandardAim';

		UnitPropertyCondition = new class'X2Condition_UnitProperty';
		UnitPropertyCondition.ExcludeTurret = true;
	    UnitPropertyCondition.ExcludeRobotic = true;
	    Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

		

		DamageEffect = new class'X2Effect_ApplyWeaponDamage';
		DamageEffect.bIgnoreBaseDamage = true;
		Template.AddTargetEffect(DamageEffect);

		UnitImmunityCondition = new class'X2Condition_UnitImmunities';
	    UnitImmunityCondition.AddExcludeDamageType('Mental');
	    UnitImmunityCondition.bOnlyOnCharacterTemplate = true;
	    Template.AbilityTargetConditions.AddItem(UnitImmunityCondition);
		Template.AddShooterEffectExclusions();
    }

}


static private function TrackingShotMarkPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local X2Condition_Visibility TargetVisibilityCondition;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    Template = AbilityTemplateManager.FindAbilityTemplate('TrackingShotMark');
	
	if (Template != none) 
    {
        
	    TargetVisibilityCondition = new class'X2Condition_Visibility';
	    TargetVisibilityCondition.bRequireGameplayVisible = true;
	    TargetVisibilityCondition.bAllowSquadsight = true;
	    Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

		Template.AddShooterEffectExclusions();
		Template.bFrameEvenWhenUnitIsHidden = false;
	}
}

static private function MarkTargetShotPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('TrackingShotMark', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
         if (Template == none) continue;
        
        for (i = Template.AbilityShooterConditions.Length - 1; i >= 0; i--)
        {
            if (X2Condition_BattleState(Template.AbilityShooterConditions[i]) != none)
            {
                Template.AbilityShooterConditions.Remove(i, 1);
            }
        }
    }
}

static private function TrackingShotPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local X2Condition_Visibility TargetVisibilityCondition;
	local X2AbilityCost_Ammo AmmoCost;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    Template = AbilityTemplateManager.FindAbilityTemplate('TrackingShot');
    if (Template != none) 
    {
        TargetVisibilityCondition = new class'X2Condition_Visibility';
	    TargetVisibilityCondition.bRequireGameplayVisible = true;
	    TargetVisibilityCondition.bAllowSquadsight = true;
	    Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);
	    
		 AmmoCost = new class'X2AbilityCost_Ammo';
	     AmmoCost.iAmmo = 1;
	     Template.AbilityCosts.AddItem(AmmoCost);

		 Template.AddShooterEffectExclusions();
		 Template.bFrameEvenWhenUnitIsHidden = false;

		 Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
    }
}


static private function TrackingShot2Patch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('TrackingShot', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
         if (Template == none) continue;
        
        for (i = Template.AbilityCosts.Length - 1; i >= 0; i--)
        {
            if (X2AbilityCost_ActionPoints(Template.AbilityCosts[i]) != none)
            {
                Template.AbilityCosts.Remove(i, 1);
            }
        
		}
		 ActionPointCost = new class'X2AbilityCost_ActionPoints';
	     ActionPointCost.iNumPoints = 2;
		 ActionPointCost.bFreeCost = true;
	     Template.AbilityCosts.AddItem(ActionPointCost);
    }

}

static private function HunterRifleShotPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
	local X2AbilityCost_Ammo AmmoCost;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    Template = AbilityTemplateManager.FindAbilityTemplate('HunterRifleShot');
    if (Template != none) 
    {
		 AmmoCost = new class'X2AbilityCost_Ammo';
	     AmmoCost.iAmmo = 1;
	     Template.AbilityCosts.AddItem(AmmoCost);

		 Template.bFrameEvenWhenUnitIsHidden = false;
    }
}


static private function  HunterKillZonePatch()
{
    local X2AbilityTemplate Template;
    local int AbilityCostIndex;
	local X2AbilityTemplateManager    AbilityTemplateManager;

   
  AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    Template = AbilityTemplateManager.FindAbilityTemplate('HunterKillzone');
    if (Template != none) 
    {

      for (AbilityCostIndex = 0; AbilityCostIndex < Template.AbilityCosts.Length; ++AbilityCostIndex)
     {
        if (Template.AbilityCosts[AbilityCostIndex].IsA('X2AbilityCost_ActionPoints'))
        {
            X2AbilityCost_ActionPoints(Template.AbilityCosts[AbilityCostIndex]).iNumPoints = 0;
            break;
        }
     Template.AddShooterEffectExclusions();
	 Template.bFrameEvenWhenUnitIsHidden = false;
	 }
	}
}


static private function  HunterSniperRifleT4Patch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('ChosenSniperRifle_T4', DifficultyVariants);
	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);
        if (Template != none)
        {
	    Template.iTypicalActionCost = 1;
		Template.Abilities.AddItem('LongWatch');
		Template.Abilities.AddItem('LongWatchShot');
		Template.Abilities.AddItem('Squadsight');
		Template.Abilities.AddItem('Killzone');
		Template.Abilities.RemoveItem('HunterKillzone');
		Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_Chosen_Sniper";
	    }
	}
}

static private function  ChosenSniperPistolt4Patch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('ChosenSniperPistol_T4', DifficultyVariants);
	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);
        if (Template != none)
        {
		Template.Abilities.AddItem('LightningHands');
		Template.Abilities.AddItem('Quickdraw');
	    }
	}
}

static private function HunterConcussionGrenadePatch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2GrenadeTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	local int i;



	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('HunterConcussionGrenade', DifficultyVariants);

	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2GrenadeTemplate(DifficultyVariant);

		if (Template == none) continue;
        
        for (i = Template.ThrownGrenadeEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_Knockback(Template.ThrownGrenadeEffects[i]) != none)
            {
                Template.ThrownGrenadeEffects.Remove(i, 1);
            }
        }

        Template.bFriendlyFire = true;
	    Template.bFriendlyFireWarning = true;

		WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
        WeaponDamageEffect.EffectDamageValue = class'X2Item_DefaultGrenades'.default.FRAGGRENADE_BASEDAMAGE;
	    Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
		Template.ThrownGrenadeEffects.AddItem(class'X2StatusEffects'.static.CreateDisorientedStatusEffect());
		Template.ThrownGrenadeEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(1, 100));
        
	}

}

static private function ChosenLowProfileTriggerPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local int i;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('ChosenLowProfileTrigger', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
    Template = X2AbilityTemplate(DifficultyVariant);

     if (Template == none) continue;
        
        for (i = Template.AbilityShooterEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_RemoveEffects(Template.AbilityShooterEffects[i]) != none)
            {
                Template.AbilityShooterEffects.Remove(i, 1);
            }
        }
	}
}

static private function ChosenLowProfilePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('ChosenLowProfile', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}

static private function ChosenAllSeeingPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('ChosenAllSeeing', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}


static function SteadyHandsPatch()
{
    local array<X2DataTemplate> DifficultyVariants;
    local X2DataTemplate DifficultyVariant;
    local X2Effect_PersistentStatChange StatChangeEffect;
    local X2Effect_Persistent PersistentEffect;
    local X2AbilityTemplate AbilityTemplate;
    local X2AbilityTemplateManager AbilityMgr;
    local X2Effect Effect;

    AbilityMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
    AbilityMgr.FindDataTemplateAllDifficulties('SteadyHands', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        AbilityTemplate = X2AbilityTemplate(DifficultyVariant);

        if (AbilityTemplate == none)
        {
            continue;
        }

        foreach AbilityTemplate.AbilityShooterEffects(Effect)
        {
            PersistentEffect = X2Effect_Persistent(Effect);
            if (PersistentEffect.EffectName != 'SteadyHands')
            {
                continue;
            }

            foreach PersistentEffect.ApplyOnTick(Effect)
            {
                StatChangeEffect = X2Effect_PersistentStatChange(Effect);
                if (StatChangeEffect.EffectName != 'SteadyHandsStatBoost')
                {
                    continue;
                }
                StatChangeEffect.DuplicateResponse = eDupe_Ignore;
                break;
            }
            break;
        }
    }
}


// Chosen Warlock

static private function MindScorchPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
    local X2Effect_ApplyWeaponDamage Damage;
	local X2Condition_UnitProperty UnitPropertyCondition;
    local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('MindScorch', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        
        for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_Dazed(Template.AbilityTargetEffects[i]) != none)
            {
                Template.AbilityTargetEffects.Remove(i, 1);
            }
        }
        for (i = Template.AbilityMultiTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_Dazed(Template.AbilityMultiTargetEffects[i]) != none)
            {
                Template.AbilityMultiTargetEffects.Remove(i, 1);
            }
        }
        
        Template.AddTargetEffect(class'X2StatusEffects'.static.CreateDisorientedStatusEffect());
        Template.AddMultiTargetEffect(class'X2StatusEffects'.static.CreateDisorientedStatusEffect());
        
        Damage = new class'X2Effect_ApplyWeaponDamage';
        Damage.bIgnoreBaseDamage = true;
		Damage.bIgnoreArmor = true;
        Damage.EffectDamageValue.Damage = 5;
        Damage.EffectDamageValue.DamageType = 'Psi';
        
        Template.AddTargetEffect(Damage);
        Template.AddMultiTargetEffect(Damage);

		UnitPropertyCondition = new class'X2Condition_UnitProperty';
		UnitPropertyCondition.ExcludeTurret = true;
	    UnitPropertyCondition.ExcludeRobotic = true;
	    Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);
    }
}

static private function ChosenRifle_MGPatch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('ChosenRifle_MG', DifficultyVariants);
	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);
        if (Template != none)
        {
		Template.Abilities.AddItem('StandardShotWarlock');
		Template.Abilities.RemoveItem('StandardShot');
		Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_Chosen_AssaultRifle";
	    }
	}

}

static private function SpectralArmyM2Patch()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('SpectralArmyM2', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template != none)
        {
           Template.AddShooterEffectExclusions();
		   Template.bFrameEvenWhenUnitIsHidden = false;
        }
    }
}

static private function SpecrtalArmyPatch2()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2Effect_SpawnSpectralArmyNew SpawnArmyEffect;
	local int i;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('SpectralArmyM2', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
    Template = X2AbilityTemplate(DifficultyVariant);
    if (X2Effect_SpawnSpectralArmy(Template.AbilityTargetEffects[i]) != none)
            {
                Template.AbilityTargetEffects.Remove(i, 1);
            }
	    SpawnArmyEffect = new class'X2Effect_SpawnSpectralArmyNew';
		SpawnArmyEffect.UnitToSpawnName = 'SpectralStunLancerM2';
	    Template.AbilityTargetEffects.InsertItem(0, SpawnArmyEffect);

	}
}
static private function CorressPatch2()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2Effect_SpawnSpectralZombiesNew SpawnZombieEffect;
	local int i;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('CorressM2', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
    Template = X2AbilityTemplate(DifficultyVariant);
    if (X2Effect_SpawnSpectralZombies(Template.AbilityTargetEffects[i]) != none)
            {
                Template.AbilityTargetEffects.Remove(i, 1);
            }
	    SpawnZombieEffect = new class'X2Effect_SpawnSpectralZombiesNew';
		SpawnZombieEffect.UnitToSpawnName = 'SpectralZombieM2';
	    Template.AddTargetEffect(SpawnZombieEffect);

		Template.AdditionalAbilities.AddItem('ZombieTurnLife');
	}
}

static private function ChosenRevengePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('ChosenRevenge', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);
    }
}

static private function HolyWarriorM3Patch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2Effect_PersistentStatChange HolyWarriorEffect;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('HolyWarriorM3', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
         if (Template == none) continue;
        
        for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_PersistentStatChange(Template.AbilityTargetEffects[i]) != none)
            {
                Template.AbilityTargetEffects.Remove(i, 1);
            }
        
		}
		HolyWarriorEffect = new class'X2Effect_PersistentStatChange';
		HolyWarriorEffect.EffectName = class'X2Ability_AdvPriest'.default.HolyWarriorEffectName;
		HolyWarriorEffect.DuplicateResponse = eDupe_Ignore;
		HolyWarriorEffect.BuildPersistentEffect(1, true, false, true);
		HolyWarriorEffect.bRemoveWhenTargetDies = true;
		HolyWarriorEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage);
		HolyWarriorEffect.AddPersistentStatChange(eStat_Mobility, 2);
		HolyWarriorEffect.AddPersistentStatChange(eStat_Will, 25);
		HolyWarriorEffect.AddPersistentStatChange(eStat_PsiOffense, 25);
		HolyWarriorEffect.AddPersistentStatChange(eStat_ShieldHP, 4);
		Template.AbilityTargetEffects.InsertItem(0, HolyWarriorEffect);
    }

}

static private function SpectralZombieM2Patch()
{
    local X2CharacterTemplateManager    CharacterTemplateManager;
    local X2CharacterTemplate    Template;
    local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    CharacterTemplateManager.FindDataTemplateAllDifficulties('SpectralZombieM2', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2CharacterTemplate(DifficultyVariant);
        if (Template != none)
        {
        Template.DefaultLoadout = 'SpectralZombieM2MP_Loadout';
        }
    }
}

static private function SpectralStunLancerPatch()
{
    local X2CharacterTemplateManager    CharacterTemplateManager;
    local X2CharacterTemplate    Template;
    local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    CharacterTemplateManager.FindDataTemplateAllDifficulties('SpectralStunLancerM2', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2CharacterTemplate(DifficultyVariant);
        if (Template != none)
        {
        Template.DefaultLoadout = 'SpectralStunLancerM2MP_Loadout';
        }
    }
}


// ADvent Psi Witch

static private function PsiDimensionalRiftStage1Patch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
    local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('PsiDimensionalRiftStage1', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
		for (i = Template.AbilityCosts.Length - 1; i >= 0; i--)
		X2AbilityCost_ActionPoints(Template.AbilityCosts[i]).bConsumeAllPoints = true;
		Template.bFrameEvenWhenUnitIsHidden = false;
    }

}

static private function AdvPsiWitchM3_WPNPatch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('AdvPsiWitchM3_WPN', DifficultyVariants);
	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);
        if (Template != none)
        {
		Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	    }
	}

}


// Gatekeeper


static private function GatekeeperMP_WPNPatch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('Gatekeeper_WPN', DifficultyVariants);
	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);
        if (Template != none)
        {
		Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
		Template.Abilities.AddItem('AnimaGate');
	    }
	}

}

static private function GatekeeperPatch()
{
    local X2CharacterTemplateManager    CharacterTemplateManager;
    local X2CharacterTemplate    Template;
    local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    CharacterTemplateManager.FindDataTemplateAllDifficulties('GatekeeperMP', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2CharacterTemplate(DifficultyVariant);
        if (Template != none)
        {
        Template.Abilities.RemoveItem('AnimaGate');
        }
    }
}

static private function AnimaGatePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('AnimaGate', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
         if (Template == none) continue;
        
        for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_ApplyWeaponDamage(Template.AbilityTargetEffects[i]) != none)
            {
                Template.AbilityTargetEffects.Remove(i, 1);
            }
			WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	        Template.AddTargetEffect(WeaponDamageEffect);
        }
    }

}


// Sectopod 

static private function WrathCannonStage1AbilityPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('WrathCannonStage1', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
         if (Template != none)
        {
		Template.AddShooterEffect(new class'X2Effect_ReplaceActionPoints');
		}
	}
}



static private function WrathCannonStage2AbilityPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local int i;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('WrathCannonStage2', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		  for (i = Template.AbilityShooterEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_TurnStartActionPoints(Template.AbilityShooterEffects[i]) != none)
            {
                Template.AbilityShooterEffects.Remove(i, 1);
			}
		}
	}	
}

static private function SectopodMPPatch()
{
    local X2CharacterTemplateManager    CharacterTemplateManager;
    local X2CharacterTemplate    Template;
    local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    CharacterTemplateManager.FindDataTemplateAllDifficulties('SectopodMP', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2CharacterTemplate(DifficultyVariant);
        if (Template != none)
        {
        Template.ImmuneTypes.AddItem('Mental');
        }
    }
}


// Arhon King

static private function IcarusDropGrabPatch()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('IcarusDropGrab', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        
        for (i = Template.AbilityTargetConditions.Length - 1; i >= 0; i--)
        {
            if (X2Condition_UnitProperty(Template.AbilityTargetConditions[i]) != none)
            {
                X2Condition_UnitProperty(Template.AbilityTargetConditions[i]).ExcludeAdvent=true;
            }
        }


    }
}


// Berserker Queen


static private function QuakePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2Effect_ApplyWeaponDamage DamageEffect;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Quake', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AbilityMultiTargetEffects.Length = 0;

		DamageEffect = new class'X2Effect_ApplyWeaponDamage';
		DamageEffect.EffectDamageValue = class'X2Ability_DLC_Day60BerserkerQueen'.default.QUAKE_DAMAGE;
		Template.AddMultiTargetEffect(DamageEffect);
		
		Template.IconImage = "img:///UILibrary_DLC2Images.UIPerk_beserker_quake";
    }
}


// Viper King


static private function FrostbitePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Frostbite', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
		
		Template.IconImage = "img:///UILibrary_DLC2Images.UIPerk_freezingbreath";
    }
}

// Spark


static private function OverdrivePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Overdrive', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}

static private function RainmakerPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Rainmaker', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}

static private function BulwarkPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Bulwark', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}

static private function IntimidatePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Intimidate', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}

static private function IntimidateTriggerPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('IntimidateTrigger', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}

static private function RepairkPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Repair', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}

static private function AbsorptionFieldPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('AbsorptionField', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}

static private function NovaInitPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('NovaInit', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}

static private function ArsenalPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Arsenal', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}
static private function SacrificePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Sacrifice', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}
static private function StrikePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Strike', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}
static private function WreckingBallPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('WreckingBall', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}
static private function BombardPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Bombard', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}
static private function NovaPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Nova', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}

static private function SparkFlamethrowerPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('SparkFlamethrower', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}

static private function SparkRocketLauncherPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties(' SparkRocketLauncher', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

    }
}


static private function SparkSoldierPatch()
{
    local X2CharacterTemplateManager    CharacterTemplateManager;
    local X2CharacterTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

   CharacterTemplateManager.FindDataTemplateAllDifficulties('SparkSoldier', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2CharacterTemplate(DifficultyVariant);
        if (Template == none) continue;

		Template.AddTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);
		Template.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_robot_icon";

    }
}





// Viper 

static private function EndBindPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2AbilityCost_ActionPoints ActionPointCost;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('EndBind', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template != none)
        {
	    Template.AbilityCosts.Length = 0;
		ActionPointCost = new class'X2AbilityCost_ActionPoints';
        ActionPointCost.bFreeCost = true;
        ActionPointCost.iNumPoints = 1;
        Template.AbilityCosts.AddItem(ActionPointCost);
		}
	}
}

static private function BindPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2Effect_ApplyViperTongueDamageMP PhysicalDamageEffect;
	local int i;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Bind', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
    Template = X2AbilityTemplate(DifficultyVariant);

    if (X2Effect_ApplyWeaponDamage(Template.AbilityTargetEffects[i]) != none)
            {
                Template.AbilityTargetEffects.Remove(i, 1);
            }
	PhysicalDamageEffect = new class'X2Effect_ApplyViperTongueDamageMP';
	PhysicalDamageEffect.EffectDamageValue = class'X2Item_DefaultWeapons'.default.Viper_Bind_BaseDamage;
	PhysicalDamageEffect.DamageTypes.AddItem('ViperCrush');
	PhysicalDamageEffect.EffectDamageValue.DamageType = 'Melee';
	Template.AddTargetEffect(PhysicalDamageEffect);
	}
}

static private function GetOverHerePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2Condition_ViperTongueMP UnitPropertyCondition;
	local int i;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('GetOverHere', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
    Template = X2AbilityTemplate(DifficultyVariant);
    if (X2Condition_UnitProperty(Template.AbilityTargetConditions[i]) != none)
            {
                Template.AbilityTargetConditions.Remove(i, 1);
            }
	    UnitPropertyCondition = new class'X2Condition_ViperTongueMP';
		Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);
	}
}

static private function PoisonSpitPatch()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;
	local X2AbilityCooldown Cooldown;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('PoisonSpit', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template != none)
        {
            Cooldown = new class'X2AbilityCooldown';
            Cooldown.iNumTurns = 3;
            Template.AbilityCooldown = Cooldown;
        }
    }
}

static private function PoisonSpitGlobPatch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;


	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('PoisonSpitGlob', DifficultyVariants);

	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);

		if (Template == none) continue;

		Template.iRange = 14;
        
	}

}

static private function BindPatch2()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Bind', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        
        for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_ApplyDirectionalWorldDamage(Template.AbilityTargetEffects[i]) != none)
            {
               Template.AbilityTargetEffects.Remove(i, 1);
            }
        }

    }
}


// Chryssalid 

static private function SpawnChryssalidPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('SpawnChryssalid', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template != none)
        {
	    Template.AbilityTargetConditions.Length = 0;
		}
	}
}

static private function SpawnChryssalidMPPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('SpawnChryssalidMP', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template != none)
        {
	    Template.AbilityTargetConditions.Length = 0;
		}
	}
}

static private function ChryssalidSlashMPPatch()
{
    local X2AbilityTemplateManager			AbilityTemplateManager;
    local X2AbilityTemplate					Template;
    local array<X2DataTemplate>				DifficultyVariants;
    local X2DataTemplate					DifficultyVariant;
	local X2Effect_ParthenogenicPoisonNew	ParthenogenicPoisonEffect;
	local X2Condition_UnitProperty			UnitPropertyCondition;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
    AbilityTemplateManager.FindDataTemplateAllDifficulties('ChryssalidSlashMP', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        
		for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
		{
			if (X2Effect_ParthenogenicPoison(Template.AbilityTargetEffects[i]) != none)
			{
				Template.AbilityTargetEffects.Remove(i, 1);
			}
		}

		ParthenogenicPoisonEffect = new class'X2Effect_ParthenogenicPoisonNew';
		ParthenogenicPoisonEffect.UnitToSpawnName = 'ChryssalidCocoonMP';
		ParthenogenicPoisonEffect.AltUnitToSpawnName = 'ChryssalidCocoonHumanMP';
		ParthenogenicPoisonEffect.BuildPersistentEffect(class'X2Ability_Chryssalid'.default.POISON_DURATION, true, false, false, eGameRule_PlayerTurnEnd);
		ParthenogenicPoisonEffect.SetDisplayInfo(ePerkBuff_Penalty, class'X2Ability_Chryssalid'.default.ParthenogenicPoisonFriendlyName, class'X2Ability_Chryssalid'.default.ParthenogenicPoisonFriendlyDesc, Template.IconImage, true);
		ParthenogenicPoisonEffect.DuplicateResponse = eDupe_Ignore;
		ParthenogenicPoisonEffect.bAddToSourceGroup = true;
		ParthenogenicPoisonEffect.SetPoisonDamageDamage();

		UnitPropertyCondition = new class'X2Condition_UnitProperty';
		UnitPropertyCondition.ExcludeRobotic = true;
		UnitPropertyCondition.ExcludeAlive = false;
		UnitPropertyCondition.ExcludeDead = false;
		UnitPropertyCondition.ExcludeFriendlyToSource = false;
		ParthenogenicPoisonEffect.TargetConditions.AddItem(UnitPropertyCondition);

		Template.AddTargetEffect(ParthenogenicPoisonEffect);
 
	}
}

static private function SpawnChryssalidMPPatch2()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('SpawnChryssalidMP', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        
        for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_SpawnChryssalid(Template.AbilityTargetEffects[i]) != none)
            {
             X2Effect_SpawnChryssalid(Template.AbilityTargetEffects[i]).bAddToSourceGroup=true;
            }
        }
    }
}

// Psi-ability

static private function InspirePatch2()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2Condition_UnitImmunities UnitImmunityCondition;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Inspire', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template != none)
		{
	    UnitImmunityCondition = new class'X2Condition_UnitImmunities';
	    UnitImmunityCondition.AddExcludeDamageType('Mental');
	    Template.AbilityTargetConditions.AddItem(UnitImmunityCondition);
		}
	}
}




static private function StasisMPPatch()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;
	local X2Condition_UnitType UnitType;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('Stasis', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template != none)
        {
            UnitType = new class'X2Condition_UnitType';
			UnitType.ExcludeTypes.AddItem('ChosenAssassinMP');
			UnitType.ExcludeTypes.AddItem('ChosenWarlockMP');
			UnitType.ExcludeTypes.AddItem('ChosenSniperMP');
			UnitType.ExcludeTypes.AddItem('AdventPsiWitch');
			Template.AbilityTargetConditions.AddItem(UnitType);
        }
    }
}

static private function StasisPriestMPPatch()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;
	local X2Condition_UnitType UnitType;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('PriestStasis', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template != none)
        {
            UnitType = new class'X2Condition_UnitType';
			UnitType.ExcludeTypes.AddItem('ChosenAssassinMP');
			UnitType.ExcludeTypes.AddItem('ChosenWarlockMP');
			UnitType.ExcludeTypes.AddItem('ChosenSniperMP');
			UnitType.ExcludeTypes.AddItem('AdventPsiWitch');
			Template.AbilityTargetConditions.AddItem(UnitType);
        }
    }
}

// Advent General

static private function CombatPresencePatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;
	local X2Condition_UnitImmunities UnitImmunityCondition;

   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('CombatPresence', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template != none)
		{
	    UnitImmunityCondition = new class'X2Condition_UnitImmunities';
	    UnitImmunityCondition.AddExcludeDamageType('Mental');
	    Template.AbilityTargetConditions.AddItem(UnitImmunityCondition);
		}
	}
}

static private function BattleScanerPatch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('BattleScanner', DifficultyVariants);

	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);

		 if (Template != none)
        {
			Template.iClipSize = 1;
		}
        
	}

}

static private function DarkEventAbility_UndyingLoyaltyPatch()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('DarkEventAbility_UndyingLoyalty', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        
        for (i = Template.AbilityShooterConditions.Length - 1; i >= 0; i--)
        {
            if (X2Condition_GameplayTag(Template.AbilityShooterConditions[i]) != none)
            {
               Template.AbilityShooterConditions.Remove(i, 1);
            }
        }

		for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_SpawnPsiZombie(Template.AbilityTargetEffects[i]) != none)
            {
             X2Effect_SpawnPsiZombie(Template.AbilityTargetEffects[i]).bAddToSourceGroup=true;
            }
		}
		Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_sectoid_psireanimate";
		SetHidden(Template);
		Template.AdditionalAbilities.AddItem('DarkEventAbility_UndyingLoyaltyPassive');

    }
}

static private function PsiZombiePatch()
{
    local X2CharacterTemplateManager    CharacterTemplateManager;
    local X2CharacterTemplate    Template;
    local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    CharacterTemplateManager.FindDataTemplateAllDifficulties('PsiZombie', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2CharacterTemplate(DifficultyVariant);
        if (Template != none)
        {
        Template.DefaultLoadout = 'SpectralZombieM2MP_Loadout';
        }
    }
}

static private function AdvCaptainM3_WPNPatch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('AdvCaptainM3_WPN', DifficultyVariants);
	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);
        if (Template != none)
        {
		Template.Abilities.AddItem('HailOfBullets');
		Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	    }
	}
}

//


// Range Accuracy fix

static private function SpectreMP_WPNPatch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('SpectreMP_WPN', DifficultyVariants);
	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);
        if (Template != none)
        {
		Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	    }
	}

}

static private function AdvPriestMP_WPNPatch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('AdvPriestMP_WPN', DifficultyVariants);
	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);
        if (Template != none)
        {
		Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	    }
	}
}


static private function AdvMEC_M2WPNPatch()
{
    local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponTemplate Template;
	local array<X2DataTemplate>    DifficultyVariants;
    local X2DataTemplate        DifficultyVariant;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.FindDataTemplateAllDifficulties('AdvMEC_M2_WPN', DifficultyVariants);
	 foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2WeaponTemplate(DifficultyVariant);
        if (Template != none)
        {
		Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	    }
	}

}

static private function LostAttackPatch()
{
    local X2AbilityTemplateManager    AbilityTemplateManager;
    local X2AbilityTemplate            Template;
    local array<X2DataTemplate>        DifficultyVariants;
    local X2DataTemplate            DifficultyVariant;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('LostAttack', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
		
		Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_swordSlash";
    }
}

static private function SwitchToRobotPatch()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('SwitchToRobotMP', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        
        for (i = Template.AbilityTargetEffects.Length - 1; i >= 0; i--)
        {
            if (X2Effect_SwitchToRobot(Template.AbilityTargetEffects[i]) != none)
            {
             X2Effect_SwitchToRobot(Template.AbilityTargetEffects[i]).bAddToSourceGroup=true;
            }
        }
    }
}

static private function RevivalProtocolPatch()
{
    local X2AbilityTemplateManager           AbilityTemplateManager;
    local X2AbilityTemplate                       Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                         DifficultyVariant;
	local int i;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    AbilityTemplateManager.FindDataTemplateAllDifficulties('RevivalProtocol', DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2AbilityTemplate(DifficultyVariant);
        if (Template == none) continue;
        
        for (i = Template.AbilityTargetConditions.Length - 1; i >= 0; i--)
        {
            if (X2Condition_RevivalProtocol(Template.AbilityTargetConditions[i]) != none)
            {
               Template.AbilityTargetConditions.Remove(i, 1);
            }
	   Template.AbilityTargetConditions.AddItem(new class'X2Condition_RevivalProtocolNew');
        }
    }
}


static private function ItemIcon()
{
    local X2AbilityTemplateManager  AbilityMgr;
    local X2ItemTemplateManager     ItemMgr;
   
    AbilityMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
    ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

    //Additional Passives
    AddVaultPassiveToUnitsThatCanJump();

	//EnsurePassiveIconDisplay(X2AbilityTemplate, optional X2ItemTemplate, optional name, optional string, optional doner X2AbilityTemplate)

	//ruler panic localisation transfer
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('SerpentPanicPassive'),,,,AbilityMgr.FindAbilityTemplate('SerpentPanic'));
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('RagePanicPassive'),,,,AbilityMgr.FindAbilityTemplate('RagePanic'));
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('IcarusPanicPassive'),,,,AbilityMgr.FindAbilityTemplate('IcarusPanic'));


    //base vests
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('StasisVestBonus'), ItemMgr.FindItemTemplate('StasisVest'), 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_item_nanofibervest");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('ScorchCircuits'),ItemMgr.FindItemTemplate('Hellweave'), 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_item_scorchcircuits");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('ScorchCircuitsDamage'),ItemMgr.FindItemTemplate('Hellweave'), 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_item_scorchcircuits");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('HazmatVestBonus'), ItemMgr.FindItemTemplate('HazmatVest'), 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_item_flamesealant");


    //base items
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('MindShield'), ItemMgr.FindItemTemplate('MindShield'), 'eAbilitySource_Item',"UILibrary_XPACK_Common.PerkIcons.UIPerk_mindshield");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('MedikitBonus'), ItemMgr.FindItemTemplate('Medikit'), 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_immunities");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('NanoMedikitBonus'), ItemMgr.FindItemTemplate('NanoMedikit'), 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_immunities");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('RefractionFieldImmunities'),, 'eAbilitySource_Item',"UILibrary_XPACK_Common.PerkIcons.UIPerk_refractionfield", AbilityMgr.FindAbilityTemplate('RefractionFieldAbility'));
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('SustainingSphereAbility'), ItemMgr.FindItemTemplate('SustainingSphere'), 'eAbilitySource_Item');
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('SustainingSphereTriggeredAbility'), ItemMgr.FindItemTemplate('SustainingSphere'), 'eAbilitySource_Item');

 

    //other base icon swaps
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('SKULLMINEAbility'),, 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_skulljack");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('MeleeResistance'),, 'eAbilitySource_Perk');
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('HolyWarriorMP'),, 'eAbilitySource_Psionic');
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('HolyWarriorM1'),, 'eAbilitySource_Psionic');
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('HolyWarriorM2'),, 'eAbilitySource_Psionic');
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('HolyWarriorM3'),, 'eAbilitySource_Psionic');

    //other mod icon swaps
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('SparkRegeneration'),, 'eAbilitySource_Commander',"UILibrary_XPACK_Common.PerkIcons.UIPerk_chosenrevive");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('WalkerServosJump'),ItemMgr.FindItemTemplate('WalkerServos'), 'eAbilitySource_Item',"UILibrary_DLC2Images.UIPerk_icarusvault");

	//The new immunity abilities: Chrm_AcidImmunity, Chrm_FireImmunity, Chrm_PoisonImmunity, Chrm_FrostImmunity, Chrm_MentalImmunity.
	//The new regen abilities: Chrm_RegenM1, Chrm_RegenM2, Chrm_RegenM3
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('Chrm_AcidImmunity'),, 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_immunities");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('Chrm_FireImmunity'),, 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_immunities");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('Chrm_PoisonImmunity'),, 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_immunities");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('Chrm_FrostImmunity'),, 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_immunities");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('Chrm_MentalImmunity'),, 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_immunities");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('Chrm_RegenM1'),, 'eAbilitySource_Item',"UILibrary_XPACK_Common.PerkIcons.UIPerk_chosenrevive");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('Chrm_RegenM2'),, 'eAbilitySource_Item',"UILibrary_XPACK_Common.PerkIcons.UIPerk_chosenrevive");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('Chrm_RegenM3'),, 'eAbilitySource_Item',"UILibrary_XPACK_Common.PerkIcons.UIPerk_chosenrevive");

    //LWotC ... does it's thing where it adds a whole new ability instead of patching the original ... so we need to look for those too ...
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('NanofiberVestBonus_LW'), ItemMgr.FindItemTemplate('NanofiberVest'), 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_item_nanofibervest");
    EnsurePassiveIconDisplay(AbilityMgr.FindAbilityTemplate('HazmatVestBonus_LW'), ItemMgr.FindItemTemplate('HazmatVest'), 'eAbilitySource_Item',"UILibrary_PerkIcons.UIPerk_item_flamesealant");

}

// SetDisplayInfo(EPerkBuffCategory BuffCat, string strName, string strDesc, string strIconLabel, optional bool DisplayInUI=true, optional string strStatusIcon = "", optional Name opAbilitySource = 'eAbilitySource_Standard')

// eAbility/ePerkBuff colours				ePerkBuffCategories
// eAbilitySource_Passive	= Blue			ePerkBuff_Passive	Lower Left Corner
// eAbilitySource_Item		= Blue		
// eAbilitySource_Perk		= Yellow
// eAbilitySource_Standard	= Yellow		
// eAbilitySource_Psionic	= Purple
// eAbilitySource_Commander = Green			ePerkBuff_Bonus		^ green in mini-pop out
// eAbilitySource_Debuff	= Red			ePerkBuff_Penalty	v red in mini-pop out

static private function EnsurePassiveIconDisplay(X2AbilityTemplate Template, optional X2ItemTemplate ItemTemplate, optional name OverrideAbilitySourceName, optional string OverrideIconImage, optional X2AbilityTemplate DonorTemplate)
{
    local X2Effect_Persistent   PersistentEffect;
    local X2Effect              Effect;
 
    if (Template == none)
        return;
 
    if (OverrideAbilitySourceName != '')
    {
        Template.AbilitySourceName = OverrideAbilitySourceName;
    }
 
    if (OverrideIconImage != "")
    {
        Template.IconImage = "img:///" $ OverrideIconImage;
    }
 
    if (Template.LocFriendlyName == "" && ItemTemplate != none)
    {
        Template.LocFriendlyName = ItemTemplate.FriendlyName;
        Template.LocHelpText = ItemTemplate.BriefSummary != "" ? ItemTemplate.BriefSummary : ItemTemplate.TacticalText;
        Template.LocLongDescription = Template.LocHelpText;
    }

	if (Template.LocFriendlyName == "" && DonorTemplate != none)
    {
        Template.LocFriendlyName = DonorTemplate.LocFriendlyName;
        Template.LocHelpText = DonorTemplate.LocHelpText;
        Template.LocLongDescription = DonorTemplate.LocLongDescription;
    }

    if (Template.LocLongDescription == "" && ItemTemplate != none)
    {
        Template.LocFriendlyName = ItemTemplate.FriendlyName;
        Template.LocHelpText = ItemTemplate.BriefSummary != "" ? ItemTemplate.BriefSummary : ItemTemplate.TacticalText;
        Template.LocLongDescription = Template.LocHelpText;
    }

	if (Template.LocLongDescription == "" && DonorTemplate != none)
    {
        Template.LocFriendlyName = DonorTemplate.LocFriendlyName;
        Template.LocHelpText = DonorTemplate.LocHelpText;
        Template.LocLongDescription = DonorTemplate.LocLongDescription;
    }

    //  Cycle through Persistent Effects on the ability, if any exist.
    foreach Template.AbilityTargetEffects(Effect)
    {
        PersistentEffect = X2Effect_Persistent(Effect);
 
        if (PersistentEffect != none)
        {
            //  Find the first effect that is configured to display a passive icon
            if (PersistentEffect.bDisplayInUI && PersistentEffect.BuffCategory == ePerkBuff_Bonus)
            {
                //  Then reset it to our new options, and exit function.
                //PersistentEffect.AbilitySourceName = AbilitySource;
                PersistentEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true, , Template.AbilitySourceName);
                return;
            }
        }
    }
 
    //  If we're still in the function, it means none of the ability's Persistent Effects are configured to show up.
    //  Use whatever Persistent Effect we last grabbed from the ability template and make it display a passive icon.
    if (PersistentEffect != none)
    {
        PersistentEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true, , Template.AbilitySourceName);
    }
    else    //  There are no persistent effects on the ability at all, so we add one ourselves.
    {
        PersistentEffect = new class'X2Effect_Persistent';
        PersistentEffect.BuildPersistentEffect(1, true, false);
        PersistentEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true, , Template.AbilitySourceName);
        Template.AddShooterEffect(PersistentEffect);
    }
}

static private function AddVaultPassiveToUnitsThatCanJump()
{
	local X2CharacterTemplateManager    CharMgr;
    local X2CharacterTemplate           CharTemplate;
    local X2DataTemplate                DataTemplate;

    CharMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    foreach CharMgr.IterateTemplates(DataTemplate, none)
    {
        CharTemplate = X2CharacterTemplate(DataTemplate);

        if (CharTemplate.bCanUse_eTraversal_JumpUp) 
        {   
            CharTemplate.Abilities.AddItem('VaultAbilityPassive');
        }
	}
}


