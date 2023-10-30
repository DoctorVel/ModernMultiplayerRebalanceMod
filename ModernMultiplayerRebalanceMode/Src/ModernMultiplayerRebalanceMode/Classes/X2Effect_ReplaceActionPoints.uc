class X2Effect_ReplaceActionPoints extends X2Effect;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
    local XComGameState_Unit UnitState;
    local int i;
    local int iNumActionPoints;

    UnitState = XComGameState_Unit(kNewTargetState);
    if (UnitState == none)
        return;
    
    // Record how many standard AP a unit has
    iNumActionPoints = UnitState.NumActionPoints(class'X2CharacterTemplateManager'.default.StandardActionPoint);
    
    // Remove standard AP
    UnitState.ActionPoints.RemoveItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);

    // Give same amount of Run and Gun AP
    for (i = 0; i < iNumActionPoints; i++)
    {
        UnitState.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.RunAndGunActionPoint);
    }    
}