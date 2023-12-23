class X2Effect_NewHunkerDown extends X2Effect_Persistent;

function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
    local ShotModifierInfo ShotModifier;
    
    if (bFlanking)
        return;
        
    ShotModifier.ModType = eHit_Success;
    ShotModifier.Value = -class'X2Ability_DefaultAbilitySet'.default.HUNKERDOWN_DEFENSE;
    ShotModifier.Reason = FriendlyName;
    ShotModifiers.AddItem(ShotModifier);
    
    ShotModifier.ModType = eHit_Graze;
    ShotModifier.Value = -class'X2Ability_DefaultAbilitySet'.default.HUNKERDOWN_DODGE;
    ShotModifier.Reason = FriendlyName;
    ShotModifiers.AddItem(ShotModifier);
}

defaultproperties
{
    EffectName = "HunkerDown"
}