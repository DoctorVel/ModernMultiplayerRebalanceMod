class XComGameState_AdventChosen_Overide extends XComGameState_AdventChosen;

function AssignStartingTraits(out array<name> ExcludeStrengths, out array<name> ExcludeWeaknesses, XComGameState_ResistanceFaction FactionState, bool bNarrative)
{};

function AddTrait(name TraitToAdd)
{};
function RemoveTrait(name TraitToRemove)
{};
function LoseWeaknesses(int NumWeaknesses)
{};

function array<X2AbilityTemplate> GetChosenWeaknesses()
{};

function string GetWeaknessesList()
{};
function X2AbilityTemplate GetReinforcementStrength() {};
function Name GetReinforcementGroupName() {};
function GainNewStrengths(XComGameState NewGameState, int NumStrengths) {};
function string GetStrengthsList() {};
