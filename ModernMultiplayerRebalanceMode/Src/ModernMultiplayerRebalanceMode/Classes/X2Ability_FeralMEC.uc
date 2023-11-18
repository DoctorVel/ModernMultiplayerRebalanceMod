class X2Ability_FeralMEC extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateReadyForAnythingAbility());
	Templates.AddItem(ReadyForAnythingFlyover());

	return Templates;
}


static function X2DataTemplate CreateReadyForAnythingAbility()
{
	local X2AbilityTemplate							Template;
	local X2Effect_ReadyForAnything					ActionPointEffect;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'BD_ReadyForAnything_LW');

	Template.IconImage = "img:///UILibrary_BD_LWAlienPack.LW_AbilityReadyForAnything";

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bShowActivation = false;
	Template.bIsPassive = true;
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	ActionPointEffect = new class'X2Effect_ReadyForAnything';
	ActionPointEffect.BuildPersistentEffect (1, true, false);
	ActionPointEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
	Template.AddTargetEffect(ActionPointEffect);

	Template.AdditionalAbilities.AddItem('BD_ReadyForAnything_LWFlyover');

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;



	return Template;
}

static function X2DataTemplate ReadyForAnythingFlyover()
{
	local X2AbilityTemplate					Template;
	local X2AbilityTrigger_EventListener	EventListener;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'BD_ReadyForAnything_LWFlyover');

	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bShowActivation = true;
	Template.bSkipFireAction = true;
	Template.bDontDisplayInAbilitySummary = true;

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.EventID = 'ReadyForAnythingTriggered';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);

	Template.CinescriptCameraType = "Overwatch";

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = ReadyforAnything_BuildVisualization;

	return Template;
}

simulated function ReadyForAnything_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory			History;
	local XComGameStateContext_Ability	Context;
	local VisualizationActionMetadata	EmptyTrack;
	local VisualizationActionMetadata	BuildTrack;
	local X2Action_PlaySoundAndFlyOver	SoundAndFlyOver;
	local StateObjectReference			InteractingUnitRef;
	local XComGameState_Ability			Ability;

	History = `XCOMHISTORY;
	context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;
	Ability = XComGameState_Ability(History.GetGameStateForObjectID(context.InputContext.AbilityRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1));
	BuildTrack = EmptyTrack;
	BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	BuildTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(BuildTrack, Context, false, BuildTrack.LastActionAdded));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(SoundCue'SoundUI.OverWatchCue', Ability.GetMyTemplate().LocFlyOverText, '', eColor_Alien, "img:///UILibrary_PerkIcons.UIPerk_overwatch");
}