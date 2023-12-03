//ENEMY UNKNOWN MIND MERGE RECREATED
//NOT BEING USED CURRENTLY
//USING X2Effect_MindMergeShield

class X2Effect_GreaterMindMerge extends X2Effect_Persistent config(SectoidCommander);

var int MergeHP; 

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Ability Ability;
	local XComGameState_Unit TargetUnit;
	local int MergeHealth, AddToMaxHP;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;
	Ability = XComGameState_Ability(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
	if (Ability == none)
		Ability = XComGameState_Ability(History.GetGameStateForObjectID(ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
	TargetUnit = XComGameState_Unit(kNewTargetState);
	MergeHealth = MergeHP;
	if (Ability != none && TargetUnit != none && TargetUnit.GetMyTemplate().CharacterGroupName == 'Sectoid')
	{
		if (TargetUnit.GetCurrentStat(eStat_HP) == TargetUnit.GetMaxStat(eStat_HP))
		{
			AddToMaxHP = TargetUnit.GetMaxStat(eStat_HP) + MergeHealth;
			TargetUnit.SetBaseMaxStat(eStat_HP, AddToMaxHP);
		}
		else
		{
			TargetUnit.ModifyCurrentStat(eStat_HP, MergeHealth);
		}
	}
}

defaultproperties
{
	EffectName="MindMergeEffect"
	DuplicateResponse=eDupe_Refresh
}