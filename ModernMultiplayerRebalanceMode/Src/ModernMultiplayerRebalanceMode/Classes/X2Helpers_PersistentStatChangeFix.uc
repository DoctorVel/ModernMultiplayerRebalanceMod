class X2Helpers_PersistentStatChangeFix extends Object abstract;

enum EEffectClass_Type
{
    eEffectClass_None,
    eEffectClass_Effect,
    eEffectClass_Persistent,
    eEffectClass_StatChange,
    eEffectClass_Other
};

//---------------------------------------------------------------------------//

private static function Generate_WatchEffects(out array<name> List)
{
    List.AddItem('SteadyHandsStatBoost');
    List.AddItem('FrenzyEffect');
    List.AddItem('HunkerDown');
}

//---------------------------------------------------------------------------//

private static function Generate_PTB_ForceRemoveEffects(out array<name> List)
{
}

//---------------------------------------------------------------------------//

private static function Generate_PTE_ForceRemoveEffects(out array<name> List)
{
}

//---------------------------------------------------------------------------//

private static function Generate_UGB_ForceRemoveEffects(out array<name> List)
{
    List.AddItem('HunkerDown');
}

//---------------------------------------------------------------------------//

private static function Generate_UGE_ForceRemoveEffects(out array<name> List)
{
    List.AddItem('SteadyHandsStatBoost');
}

static final function bool HandlePlayerTurnEvent(XComGameState NewGameState,
    XComGameState_Player PlayerState, Name EventID)
{
    local XComGameStateHistory History;
    local XComGameState_Unit UnitState;
    local bool bUnitStateModified;
    
    History = `XCOMHISTORY;

    foreach History.IterateByClassType(class'XComGameState_Unit', UnitState)
    {
        if (!IsUnitValid(UnitState) || UnitState.ControllingPlayer.ObjectID != PlayerState.ObjectID)
        {
            continue;
        }

        bUnitStateModified = ModifyUnitState(NewGameState, UnitState, EventID);
    }

    return bUnitStateModified;
}

static private function EEffectClass_Type LogEffectInfo(
    name EffectName, const out XComGameState_Effect EffectState)
{
    local X2Effect_PersistentStatChange StatChangeEffect;
    local X2Effect_Persistent Effect;
    local EEffectClass_Type eType;

    if (EffectState == none)
    {
        return eEffectClass_None;
    }

    Effect = EffectState.GetX2Effect();
    if (Effect == none)
    {
        return eEffectClass_Effect;
    }

    eType = eEffectClass_Persistent;
    
    if (Effect.IsA('X2Effect_PersistentStatChange'))
    {
        StatChangeEffect = X2Effect_PersistentStatChange(Effect);
        eType = eEffectClass_StatChange;
    }

    if (eType == eEffectClass_StatChange)
    {
    }

    return eType;
}

//---------------------------------------------------------------------------//

static final function bool ModifyUnitState(XComGameState NewGameState,
                                           XComGameState_Unit UnitState,
                                           optional name TriggeredEventID)
{
    local array<name> WatchEffects;
    local XComGameState_Effect EffectState;
    local EEffectClass_Type eType;
    local name EffectName;
    local bool bModified;

    Generate_WatchEffects(WatchEffects);

    foreach UnitState.AffectedByEffectNames(EffectName)
    {
        if (WatchEffects.Find(EffectName) == INDEX_NONE)
        {
            continue;
        }

        EffectState = UnitState.GetUnitAffectedByEffectState(EffectName);

        eType = LogEffectInfo(EffectName, EffectState);

        if (eType != eEffectClass_Persistent && eType != eEffectClass_StatChange)
        {
            continue;
        }

        // Universal Features
        switch (TriggeredEventID)
        {
            case 'PlayerTurnBegun':
                break;
            case 'UnitGroupTurnBegun':
                if (EffectName == 'HunkerDown')
                {
                    EffectState.RemoveEffect(NewGameState, NewGameState);
                    bModified = true;
                }
                break;
            case 'PlayerTurnEnded':
                break;
            case 'UnitGroupTurnEnded':
                if (EffectName == 'SteadyHandsStatBoost')
                {
                    EffectState.RemoveEffect(NewGameState, NewGameState);
                    bModified = true;
                }
                break;
            default:
                break;
        }

        switch (TriggeredEventID)
        {
            case 'PlayerTurnBegun':
                break;
            case 'UnitGroupTurnBegun':
                break;
            case 'PlayerTurnEnded':
                break;
            case 'UnitGroupTurnEnded':
                break;
            default:
                break;
        }
    }
    return bModified;
}

static final function bool IsUnitValid(XComGameState_Unit UnitState,
                                       optional bool bIsDeadValid)
{
    // Skip removed (evac'ed), non-selectable (mimic beacon),
    //   cosmectic (gremlin), dead, and playerless (MOCX!) Units
    return !(UnitState == none
        || UnitState.bRemovedFromPlay
        || UnitState.ControllingPlayer.ObjectID <= 0
        || UnitState.GetMyTemplate().bNeverSelectable
        || UnitState.GetMyTemplate().bIsCosmetic
        || (!bIsDeadValid && !UnitState.IsAlive())
    );
}