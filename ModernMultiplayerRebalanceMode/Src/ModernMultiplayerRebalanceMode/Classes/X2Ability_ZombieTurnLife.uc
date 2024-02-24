class X2Ability_ZombieTurnLife extends X2Ability;

var localized string DelayedDamageBuffName;
var localized string DelayedDamageBuffText;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(AddLinkedEffectAbility());

	return Templates;
}

static function X2AbilityTemplate AddLinkedEffectAbility()
{
	local X2AbilityTemplate				Template;
	local X2Effect_IRI_DelayedDamage	SireZombieLinkEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ZombieTurnLife');

	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_sectoid_psireanimate";

	Template.AbilityTargetStyle = new class'X2AbilityTarget_Single';

	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_Placeholder');

	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.AbilitySourceName = 'eAbilitySource_Psionic';

	Template.bOverrideMeleeDeath = true;

	// Create an effect that will be attached to the spawned zombie
	SireZombieLinkEffect = new class'X2Effect_IRI_DelayedDamage';

	
	SireZombieLinkEffect.BuildPersistentEffect(4, false, false, false, eGameRule_PlayerTurnEnd);
	SireZombieLinkEffect.SetDisplayInfo(ePerkBuff_Bonus, default.DelayedDamageBuffName, default.DelayedDamageBuffText, Template.IconImage);


	SireZombieLinkEffect.DeathActionClass = class'X2Action_ZombieSireDeath';
	SireZombieLinkEffect.VisualizationFn = class'X2Ability_Sectoid'.static.BuildVisualization_SireDeathEffect;

	//SireZombieLinkEffect.DeathActionClass = class'X2Action_ZombieSireDeath';
	//SireZombieLinkEffect.VisualizationFn = class'X2Ability_Sectoid'.static.BuildVisualization_SireDeathEffect;

	SireZombieLinkEffect.EffectName = class'X2Ability_Sectoid'.default.SireZombieLinkName;
	Template.AddTargetEffect(SireZombieLinkEffect);

	Template.BuildNewGameStateFn = class'X2Ability_Sectoid '.static.Empty_BuildGameState;
	Template.BuildVisualizationFn = none;

	//We re-run the X2Action_CreateDoppelganger on load, to restore the appearance and tether of the zombie.
	Template.BuildAffectedVisualizationSyncFn = class'X2Ability_Sectoid'.static.SireZombieLink_BuildVisualizationSyncDelegate;

	return Template;
}