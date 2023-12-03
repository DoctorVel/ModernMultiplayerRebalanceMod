class X2Effect_VanishingWindRevealTimer extends X2Effect_Persistent;

simulated function OnEffectRemoved(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState, bool bCleansed, XComGameState_Effect RemovedEffectState)
{
	local XComGameState_Unit TargetUnit;

	TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	if (TargetUnit == none)
	{
		TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
		if (TargetUnit != none)
		{
			TargetUnit = XComGameState_Unit(NewGameState.ModifyStateObject(TargetUnit.Class, TargetUnit.ObjectID));
		}
	}
	if (TargetUnit != none)
	{
		`XEVENTMGR.TriggerEvent('VanishingWindRevealEvent', TargetUnit, TargetUnit, NewGameState);
	}
}