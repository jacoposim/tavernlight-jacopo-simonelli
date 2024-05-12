--spell spawn area design
-- 0=no effect, 1=effect, 2=character position with no effect
local area = {
	{0, 0, 0, 1, 0, 0, 0},
    {0, 0, 1, 0, 1, 0, 0},
    {0, 1, 0, 1, 0, 1, 0},
    {1, 0, 1, 2, 1, 0, 1},
    {0, 1, 0, 1, 0, 1, 0},
    {0, 0, 1, 0, 1, 0, 0},
    {0, 0, 0, 1, 0, 0, 0}
}

--spell setup with the wanted effect and the custom area
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO) --CONST_ME_FIREAREA 
combat:setArea(createCombatArea(area))

--spell execution
function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end