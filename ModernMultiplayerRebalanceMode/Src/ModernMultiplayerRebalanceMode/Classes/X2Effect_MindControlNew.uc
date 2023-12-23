class X2Effect_MindControlNew extends X2Effect_MindControl;

function int GetStartingNumTurns(const out EffectAppliedData ApplyEffectParameters)
{
    local XComGameState_Unit TargetUnit;
    
    TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
    if (TargetUnit != none)
    {
        if (TargetUnit.HasSoldierAbility('BlessingoftheElders'))
        {
            return 2;
        }
    }    
    return super.GetStartingNumTurns(ApplyEffectParameters);
}