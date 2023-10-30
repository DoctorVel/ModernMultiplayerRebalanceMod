class X2Effect_IRI_DelayedDamage extends X2Effect_OverrideDeathAction;

simulated function OnEffectRemoved(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState, bool bCleansed, XComGameState_Effect RemovedEffectState)
{
	local XComGameState_Unit TargetUnit;
	local int KillAmount;

	super.OnEffectRemoved(ApplyEffectParameters, NewGameState, bCleansed, RemovedEffectState);

	TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	
	if( (TargetUnit != none) && !TargetUnit.IsDead()  )
	{
		KillAmount = TargetUnit.GetCurrentStat(eStat_HP) + TargetUnit.GetCurrentStat(eStat_ShieldHP);
		TargetUnit.TakeEffectDamage(self, KillAmount, 0, 0, ApplyEffectParameters, NewGameState, false, false);
	}
	//`XEVENTMGR.TriggerEvent('IRI_KillZombieEvent', TargetUnit, TargetUnit, NewGameState);
}

/*
simulated function X2Action AddX2ActionsForVisualization_Death(out VisualizationActionMetadata ActionMetadata, XComGameStateContext Context)
{
	local X2Action AddAction;

	AddAction = class'X2Action'.static.CreateVisualizationActionClass(class'X2Action_ZombieSireDeath', Context, ActionMetadata.VisualizeActor );
	class'X2Action'.static.AddActionToVisualizationTree(AddAction, ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

	return AddAction;
}*/