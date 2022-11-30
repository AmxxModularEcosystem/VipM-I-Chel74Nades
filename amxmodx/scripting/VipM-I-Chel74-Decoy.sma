#include <amxmodx>
#include <VipModular>

/* Выдаёт ложные гранаты игроку
 * 
 * pPlayer - индекс игрока получателя
 * iCount - количество гранат
 * 
 * Возвращает индекс гранаты, либо NULLENT, если гранату не удалось выдать
 */
native give_decoy(pPlayer, iCount);

#pragma semicolon 1
#pragma compress 1

public stock const PluginName[] = "[VipM-I] Decoy";
public stock const PluginVersion[] = "1.0.0";
public stock const PluginAuthor[] = "ArKaNeMaN";
public stock const PluginURL[] = "t.me/arkanaplugins";
public stock const PluginDescription[] = "[VipM-I] Support for CHEL74's Decoy";

new const TYPE_NAME[] = "DecoyGrenade";

public VipM_IC_OnInitTypes() {
    register_plugin(PluginName, PluginVersion, PluginAuthor);

    VipM_IC_RegisterType(TYPE_NAME);
    VipM_IC_RegisterTypeEvent(TYPE_NAME, ItemType_OnRead, "@OnRead");
    VipM_IC_RegisterTypeEvent(TYPE_NAME, ItemType_OnGive, "@OnGive");
}

@OnRead(const JSON:jCfg, Trie:tParams) {
    TrieDeleteKey(tParams, "Name");

    if (json_object_has_value(jCfg, "Count", JSONNumber)) {
        TrieSetCell(tParams, "Count", json_object_get_number(jCfg, "Count"));
    }

    return VIPM_CONTINUE;
}

@OnGive(const UserId, const Trie:tParams) {
    return give_decoy(UserId, VipM_Params_GetInt(tParams, "Count", 1))
        ? VIPM_CONTINUE
        : VIPM_STOP;
}
