class X2StatusEffect_MKNew extends X2StatusEffects;

static function X2Effect_MindControlNew CreateMindControlStatusEffectNew(int NumTurns, bool bRobotic=false, bool bIsInfinite=false, float DelayVisualizationSec=0.0f)
{
	local X2Effect_MindControlNew MindControlEffect;
	local X2Condition_UnitEffects	EffectCondition;

	MindControlEffect = new class'X2Effect_MindControlNew';
	`Log("Setting MindControlStatus with NumTurns="$NumTurns,,'XCom_Templates');
	MindControlEffect.iNumTurns = NumTurns;
	MindControlEffect.bInfiniteDuration = bIsInfinite;
	MindControlEffect.SetDisplayInfo(ePerkBuff_Penalty, 
									 bRobotic?default.HackedUnitFriendlyName:default.MindControlFriendlyName, 
									 bRobotic?default.HackedUnitFriendlyDesc:default.MindControlFriendlyDesc, 
									 "img:///UILibrary_PerkIcons.UIPerk_domination",
									 true,
									 class'UIUtilities_Image'.const.UnitStatus_MindControlled);
	if(!bRobotic)
	{
		MindControlEffect.SetSourceDisplayInfo(ePerkBuff_Bonus, default.MindControlSourceFriendlyName, default.MindControlSourceFriendlyDesc, "img:///UILibrary_PerkIcons.UIPerk_domination");
	}

	EffectCondition = new class'X2Condition_UnitEffects';
	EffectCondition.AddExcludeEffect(class'X2Effect_Battlelord'.default.EffectName, 'AA_UnitIsImmune');
	EffectCondition.AddExcludeEffect(class'X2Effect_SkirmisherInterrupt'.default.EffectName, 'AA_UnitIsImmune');
	MindControlEffect.TargetConditions.AddItem(EffectCondition);

	MindControlEffect.DelayVisualizationSec = DelayVisualizationSec;
	MindControlEffect.VisualizationFn = MindControlVisualization;
	MindControlEffect.EffectTickedVisualizationFn = MindControlVisualizationTicked;
	MindControlEffect.EffectRemovedVisualizationFn = MindControlVisualizationRemoved;
	MindControlEffect.EffectHierarchyValue = default.MINDCONTROL_HIERARCHY_VALUE;

	return MindControlEffect;
}

static function X2Effect_RemoveEffects CreateMindControlRemoveEffects()
{
	local X2Effect_RemoveEffects RemoveEffects;

	// remove other impairing mental effects
	RemoveEffects = new class'X2Effect_RemoveEffects'; 
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ConfusedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.PanickedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.StunnedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.DazedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ObsessedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.BerserkName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ShatteredName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2Ability_AdvPriest'.default.HolyWarriorEffectName);
	RemoveEffects.DamageTypes.AddItem('mental'); 

	return RemoveEffects;
}

static function MindControlVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local XComGameState_Unit kUnit;

	if (EffectApplyResult != 'AA_Success')
	{
		AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.ResistedMindControlText, '', eColor_Good, class'UIUtilities_Image'.const.UnitStatus_MindControlled);
		return;
	}
	
	kUnit = XComGameState_Unit(ActionMetadata.StateObject_NewState);
	if (kUnit != none)
	{
		class'X2Action_MindControlled'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded);

		if(kUnit.IsRobotic())
		{
			AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.HackedUnitFriendlyName, '', eColor_Bad, class'UIUtilities_Image'.const.UnitStatus_Haywire);
			AddEffectMessageToTrack(
				ActionMetadata,
				default.HackedUnitEffectAcquiredString,
				VisualizeGameState.GetContext(),
				class'UIEventNoticesTactical'.default.DominationTitle,
				"img:///UILibrary_PerkIcons.UIPerk_domination",
				eUIState_Bad);
		}
		else
		{
			AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.MindControlFriendlyName, 'SoldierControlled', eColor_Bad, class'UIUtilities_Image'.const.UnitStatus_MindControlled);
			AddEffectMessageToTrack(
				ActionMetadata,
				default.MindControlEffectAcquiredString,
				VisualizeGameState.GetContext(),
				class'UIEventNoticesTactical'.default.DominationTitle,
				"img:///UILibrary_PerkIcons.UIPerk_domination",
				eUIState_Bad);
		}

		UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());		
	}
}

static function MindControlVisualizationTicked(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local XComGameState_Unit UnitState;
	local XComGameState_Effect MindControlState;

	UnitState = XComGameState_Unit(ActionMetadata.StateObject_NewState);
	if (UnitState == none)
		return;

	// dead units should not be reported
	if( !UnitState.IsAlive() )
	{
		return;
	}

	// infinite-duration mind-control effects should not be reported every turn
	MindControlState = UnitState.GetUnitAffectedByEffectState(class'X2Effect_MindControl'.default.EffectName);
	if (MindControlState != None && MindControlState.GetX2Effect().bInfiniteDuration)
	{
		return;
	}

	AddEffectCameraPanToAffectedUnitToTrack(ActionMetadata, VisualizeGameState.GetContext());
	if(UnitState.IsRobotic() ) 
	{
		AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.HackedUnitFriendlyName, 'SoldierControlled', eColor_Bad, class'UIUtilities_Image'.const.UnitStatus_Haywire);
		AddEffectMessageToTrack(
			ActionMetadata,
			default.HackedUnitEffectTickedString,
			VisualizeGameState.GetContext(),
			class'UIEventNoticesTactical'.default.DominationTitle,
			"img:///UILibrary_PerkIcons.UIPerk_domination",
			eUIState_Warning);
	}
	else
	{
		AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.MindControlFriendlyName, 'SoldierControlled', eColor_Bad, class'UIUtilities_Image'.const.UnitStatus_MindControlled);
		AddEffectMessageToTrack(
			ActionMetadata,
			default.MindControlEffectTickedString,
			VisualizeGameState.GetContext(),
			class'UIEventNoticesTactical'.default.DominationTitle,
			"img:///UILibrary_PerkIcons.UIPerk_domination",
			eUIState_Warning);
	}
	UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());
}

static function MindControlVisualizationRemoved(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local XComGameState_Unit UnitState;

	UnitState = XComGameState_Unit(ActionMetadata.StateObject_NewState);
	if (UnitState == none)
		return;

	// dead units should not be reported
	if( !UnitState.IsAlive() )
	{
		return;
	}

	class'X2Action_SwapTeams'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded);

	if( UnitState.IsRobotic() )
	{
		AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.HackedUnitLostFriendlyName, '', eColor_Good, class'UIUtilities_Image'.const.UnitStatus_Haywire, 2.0f);
		AddEffectMessageToTrack(
			ActionMetadata,
			default.HackedUnitEffectLostString,
			VisualizeGameState.GetContext(),
			class'UIEventNoticesTactical'.default.DominationTitle,
			"img:///UILibrary_PerkIcons.UIPerk_domination",
			eUIState_Good);
	}
	else
	{
		AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.MindControlLostFriendlyName, '', eColor_Good, class'UIUtilities_Image'.const.UnitStatus_MindControlled, 2.0f);
		AddEffectMessageToTrack(
			ActionMetadata,
			default.MindControlEffectLostString,
			VisualizeGameState.GetContext(),
			class'UIEventNoticesTactical'.default.DominationTitle,
			"img:///UILibrary_PerkIcons.UIPerk_domination",
			eUIState_Good);
	}
	UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());
}