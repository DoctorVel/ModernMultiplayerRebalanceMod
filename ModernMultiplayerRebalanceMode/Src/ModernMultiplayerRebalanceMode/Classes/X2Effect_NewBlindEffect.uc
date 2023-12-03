class X2Effect_NewBlindEffect extends X2Effect_PersistentStatChange config(GameCore);

var localized string BlindNewName, BlindNewDesc, BlindAddedFlyover, BlindNewAddedString, BlindNewRemovedFlyover, BlindNewRemovedString;

static function X2Effect_NewBlindEffect CreateBlindEffectNew()
{
	local X2Effect_NewBlindEffect Effect;

	Effect = new class'X2Effect_NewBlindEffect';
	Effect.BuildPersistentEffect(2, false, false, false, eGameRule_PlayerTurnBegin);
	Effect.SetDisplayInfo(ePerkBuff_Penalty, default.BlindNewName, default.BlindNewDesc, "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_mountainmist");
	Effect.AddPersistentStatChange(eStat_SightRadius, -21);
	Effect.AddPersistentStatChange(eStat_Mobility, -8);
	Effect.EffectName = 'BlindNew';

	if (class'X2StatusEffects'.default.BlindedParticle_Name != "")
	{
		Effect.VFXTemplateName = class'X2StatusEffects'.default.BlindedParticle_Name;
		Effect.VFXSocket = class'X2StatusEffects'.default.BlindedSocket_Name;
		Effect.VFXSocketsArrayName = class'X2StatusEffects'.default.BlindedSocketsArray_Name;
	}

	return Effect;
}

simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, name EffectApplyResult)
{
	local X2Action_UpdateFOW FOWUpdate;

	super.AddX2ActionsForVisualization(VisualizeGameState, ActionMetadata, EffectApplyResult);

	if( (EffectApplyResult == 'AA_Success') &&
		(XComGameState_Unit(ActionMetadata.StateObject_NewState) != none) )
	{
		class'X2StatusEffects'.static.AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.BlindAddedFlyover, '', eColor_Bad, default.StatusIcon);
		class'X2StatusEffects'.static.AddEffectMessageToTrack(ActionMetadata,
															  default.BlindNewAddedString,
															  VisualizeGameState.GetContext(),
															  class'UIEventNoticesTactical'.default.BlindedTitle,
															  default.StatusIcon,
															  eUIState_Bad);
		class'X2StatusEffects'.static.UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());

		FOWUpdate = X2Action_UpdateFOW( class'X2Action_UpdateFOW'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext() , false, ActionMetadata.LastActionAdded) );
		FOWUpdate.ForceUpdate = true;
	}
}

simulated function AddX2ActionsForVisualization_Removed(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult, XComGameState_Effect RemovedEffect)
{
	local X2Action_UpdateFOW FOWUpdate;

	super.AddX2ActionsForVisualization_Removed(VisualizeGameState, ActionMetadata, EffectApplyResult, RemovedEffect);

	if( (EffectApplyResult == 'AA_Success') &&
		(XComGameState_Unit(ActionMetadata.StateObject_NewState) != none) )
	{
		class'X2StatusEffects'.static.AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.BlindNewRemovedFlyover, '', eColor_Good, default.StatusIcon);
		class'X2StatusEffects'.static.AddEffectMessageToTrack(ActionMetadata,
															  default.BlindNewRemovedString,
															  VisualizeGameState.GetContext(),
															  class'UIEventNoticesTactical'.default.BlindedTitle,
															  default.StatusIcon,
															  eUIState_Good);
		class'X2StatusEffects'.static.UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());

		FOWUpdate = X2Action_UpdateFOW( class'X2Action_UpdateFOW'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext() , false, ActionMetadata.LastActionAdded) );
		FOWUpdate.ForceUpdate = true;
	}
}

DefaultProperties
{
	bIsImpairing=true
	Begin Object Class=X2Condition_UnitProperty Name=UnitPropertyCondition
	ExcludeTurret=true
	ExcludeRobotic=true	
	ExcludeFriendlyToSource=false;
	End Object
	TargetConditions.Add(UnitPropertyCondition)

	DuplicateResponse=eDupe_Refresh
}