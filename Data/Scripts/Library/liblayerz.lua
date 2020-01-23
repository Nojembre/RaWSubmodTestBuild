local libLayerZ = { }

--- Disables a given GameObject.
-- @tparam GameObject gameObject
-- @tparam Boolean spawnsFighters [optional]
function libLayerZ.disableObject(gameObject, spawnsFighters)
    local spawns = false
    if spawnsFighters then
        spawns = spawnsFighters
    end
    if spawns then
        gameObject.Set_Garrison_Spawn(false)
    end
    gameObject.Make_Invulnerable(true)
    gameObject.Set_Selectable(false)
    gameObject.Prevent_All_Fire(true)
end

--- Enables a given GameObject.
-- @tparam GameObject gameObject
-- @tparam Boolean spawnsFighters [optional]
function libLayerZ.enableObject(gameObject, spawnsFighters)
    local spawns = false
    if spawnsFighters then
        spawns = spawnsFighters
    end
    if spawns then
        gameObject.Set_Garrison_Spawn(true)
    end
    gameObject.Make_Invulnerable(false)
    gameObject.Set_Selectable(true)
    gameObject.Prevent_All_Fire(false)
end

--- Hides a given game object.
-- It's a wrapper around two consecutive GameObject.Hide(true) calls - don't even ask why we need those.
-- @tparam GameObject gameObject
function libLayerZ.hideObject(gameObject)
    gameObject.Hide(true)
    gameObject.Hide(true)
end

--- Teleports the given object to a randomized Z-Layer.
-- @tparam GameObject gameObject
function libLayerZ.setLayerZ(gameObject)
    local layerZObj = Spawn_Unit(Find_Object_Type("LAYER_Z_DUMMY"), gameObject.Get_Position(), gameObject.Get_Owner())
    layerZObj = layerZObj[1]
    local layer = "CORVETTE"
    if gameObject.Is_Category("Frigate") then
        layer = "FRIGATE"
    elseif gameObject.Is_Category("Capital") then
        layer = "CAPITAL"
    elseif gameObject.Is_Category("Super") then
        layer = "SUPER"
    end
    local layerMarkerTable = {
        ["CORVETTE"] = {
            "CORVETTE_00", "CORVETTE_01", "CORVETTE_02", "CORVETTE_03", "CORVETTE_04", "CORVETTE_05", "CORVETTE_06", "CORVETTE_07", "CORVETTE_08", "CORVETTE_09", "CORVETTE_10", "CORVETTE_11", "CORVETTE_12"},
        ["FRIGATE"] = {
            "FRIGATE_00", "FRIGATE_01", "FRIGATE_02", "FRIGATE_03", "FRIGATE_04", "FRIGATE_05", "FRIGATE_06", "FRIGATE_07", "FRIGATE_08", "FRIGATE_09", "FRIGATE_10", "FRIGATE_11", "FRIGATE_12", "FRIGATE_13"},
        ["CAPITAL"] = {
            "CAPITAL_00", "CAPITAL_01", "CAPITAL_02", "CAPITAL_03", "CAPITAL_04", "CAPITAL_05", "CAPITAL_06", "CAPITAL_07", "CAPITAL_08", "CAPITAL_09", "CAPITAL_10", "CAPITAL_11", "CAPITAL_12"},
        ["SUPER"] = {
            "SUPER_00", "SUPER_01", "SUPER_02", "SUPER_03", "SUPER_04", "SUPER_05", "SUPER_06", "SUPER_07", "SUPER_08", "SUPER_09", "SUPER_10"},
    }
    local finalBoneTab = layerMarkerTable[layer]
    if finalBoneTab then
        local bone = finalBoneTab[GameRandom(1,table.getn(finalBoneTab))]
        if bone then
            gameObject.Teleport(layerZObj.Get_Bone_Position(bone))
        else
            gameObject.Teleport(layerZObj.Get_Position())
        end
    else
        gameObject.Teleport(layerZObj.Get_Position())
    end
    layerZObj.Despawn()
end

--- Only function that needs to be called from the gameobject script.
-- @tparam GameObject gameObject
function libLayerZ.enterBattlefield(gameObject)
    libLayerZ.disableObject(gameObject)
    gameObject.Cancel_Hyperspace()
    libLayerZ.hideObject(gameObject)
    libLayerZ.setLayerZ(gameObject)
    gameObject.Cinematic_Hyperspace_In(1)
    libLayerZ.enableObject(gameObject)
end

return libLayerZ
