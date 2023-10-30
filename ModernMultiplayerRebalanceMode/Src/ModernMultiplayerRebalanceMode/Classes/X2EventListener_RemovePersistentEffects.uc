class X2EventListener_RemovePersistentEffects extends X2EventListener;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Templates;

    Templates.AddItem(CreateUnitGroupTurnBegunTemplate());
    Templates.AddItem(CreateUnitGroupTurnEndedTemplate());
    Templates.AddItem(CreatePlayerTurnBegunTemplate());
    Templates.AddItem(CreatePlayerTurnEndedTemplate());

    return Templates;
}

//---------------------------------------------------------------------------//

static function X2EventListenerTemplate CreateUnitGroupTurnBegunTemplate()
{
    local X2EventListenerTemplate Template;

    `CREATE_X2TEMPLATE(class'X2EventListenerTemplate', Template,
        'UnitGroupTurnBegunListenerTemplate_KMP01');

    Template.RegisterInTactical = true;
    Template.RegisterInStrategy = false;
    Template.AddEvent('UnitGroupTurnBegun', OnUnitGroupTurnEvent_KMP01);

    return Template;
}

static function X2EventListenerTemplate CreateUnitGroupTurnEndedTemplate()
{
    local X2EventListenerTemplate Template;

    `CREATE_X2TEMPLATE(class'X2EventListenerTemplate', Template,
        'UnitGroupTurnEndedListenerTemplate_KMP01');

    Template.RegisterInTactical = true;
    Template.RegisterInStrategy = false;
    Template.AddEvent('UnitGroupTurnEnded', OnUnitGroupTurnEvent_KMP01);

    return Template;
}

static function X2EventListenerTemplate CreatePlayerTurnBegunTemplate()
{
    local X2EventListenerTemplate Template;

    `CREATE_X2TEMPLATE(class'X2EventListenerTemplate', Template,
        'PlayerTurnBegunListenerTemplate_KMP01');

    Template.RegisterInTactical = true;
    Template.RegisterInStrategy = false;
    Template.AddEvent('PlayerTurnBegun', OnPlayerTurnEvent_KMP01);

    return Template;
}

static function X2EventListenerTemplate CreatePlayerTurnEndedTemplate()
{
    local X2EventListenerTemplate Template;

    `CREATE_X2TEMPLATE(class'X2EventListenerTemplate', Template,
        'PlayerTurnEndedListenerTemplate_KMP01');

    Template.RegisterInTactical = true;
    Template.RegisterInStrategy = false;
    Template.AddEvent('PlayerTurnEnded', OnPlayerTurnEvent_KMP01);

    return Template;
}

static protected function EventListenerReturn OnUnitGroupTurnEvent_KMP01(
    Object EventData,
    Object EventSource,
    XComGameState EventGameState,
    Name EventID,  // 'UnitGroupTurnBegun' or 'UnitGroupTurnEnded'
    Object CallbackData)  // None
{
    local XComGameState_AIGroup GroupState;
    local XComGameState_Unit UnitState;
    local XComGameStateHistory History;
    local XComGameState NewGameState;
    local bool bUnitStateModified;
    local array<int> LivingMemberIDs;
    local array<XComGameState_Unit> LivingMembers;
    local int idx;
    local XComGameState_Player CtrlPlayer;

    History = `XCOMHISTORY;
    GroupState = XComGameState_AIGroup(EventData);

    NewGameState = class'XComGameStateContext_ChangeContainer'.static
        .CreateChangeState("OnUnitGroupTurnEvent_KMP01");

    if (!GroupState.GetLivingMembers(LivingMemberIDs, LivingMembers))
    {
        return ELR_NoInterrupt;
    }

    foreach LivingMembers(UnitState, idx)
    {
        if (UnitState == none || UnitState.bRemovedFromPlay
            || UnitState.ControllingPlayer.ObjectID <= 0
            || UnitState.GetMyTemplate().bNeverSelectable
            || UnitState.GetMyTemplate().bIsCosmetic
            || !UnitState.IsAlive())
        {
            continue;
        }

        CtrlPlayer = XComGameState_Player(History.GetGameStateForObjectID(UnitState.ControllingPlayer.ObjectID));

        if (CtrlPlayer.ObjectID > 0)
        {
            bUnitStateModified = class'X2Helpers_PersistentStatChangeFix'.static.ModifyUnitState(NewGameState, UnitState, EventID);
        }
    }

    if (NewGameState.GetNumGameStateObjects() > 0)
    {
        `TACTICALRULES.SubmitGameState(NewGameState);
    }
    else
    {
        History.CleanupPendingGameState(NewGameState);
    }
    return ELR_NoInterrupt;
}

static protected function EventListenerReturn OnPlayerTurnEvent_KMP01(
    Object EventData,
    Object EventSource,
    XComGameState EventGameState,
    Name EventID,  // 'PlayerTurnEnded' or 'PlayerTurnEnded'
    Object CallbackData)  // None
{
    local XComGameState_Player PlayerState;
    local XComGameStateHistory History;
    local XComGameState NewGameState;
    
    History = `XCOMHISTORY;
    PlayerState = XComGameState_Player(EventData);

    return ELR_NoInterrupt;

    NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("OnPlayerTurnEvent_KMP01");

    if (NewGameState.GetNumGameStateObjects() > 0)
    {
        `TACTICALRULES.SubmitGameState(NewGameState);
    }
    else
    {
        History.CleanupPendingGameState(NewGameState);
    }
    return ELR_NoInterrupt;
}