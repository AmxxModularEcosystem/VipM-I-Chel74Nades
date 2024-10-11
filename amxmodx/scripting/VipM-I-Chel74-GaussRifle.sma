#include <amxmodx>
#include <VipModular>

/* Выдаёт Гаусс ружьё игроку
 * 
 * pPlayer - индекс игрока получателя
 * iType - тип выдачи
 * 
 * Возвращает индекс винтовки, либо NULLENT, если гранату не удалось выдать
 */
native give_gaussrifle(pPlayer, GiveType:iType);

#pragma semicolon 1
#pragma compress 1

public stock const PluginName[] = "[VipM-I] Gauss Rifle";
public stock const PluginVersion[] = "1.0.0";
public stock const PluginAuthor[] = "ArKaNeMaN";
public stock const PluginURL[] = "t.me/arkanaplugins";
public stock const PluginDescription[] = "[VipM-I] Support for CHEL74's Gauss Rifle";

new const TYPE_NAME[] = "GaussRifle";

public VipM_IC_OnInitTypes() {
    register_plugin(PluginName, PluginVersion, PluginAuthor);

    VipM_IC_RegisterType(TYPE_NAME);
    VipM_IC_RegisterTypeEvent(TYPE_NAME, ItemType_OnRead, "@OnRead");
    VipM_IC_RegisterTypeEvent(TYPE_NAME, ItemType_OnGive, "@OnGive");
}

@OnRead(const JSON:jCfg, Trie:tParams) {
    TrieDeleteKey(tParams, "Name");

    if (json_object_has_value(jCfg, "BPAmmo", JSONNumber)) {
        TrieSetCell(tParams, "BPAmmo", json_object_get_number(jCfg, "BPAmmo"));
    }

    return VIPM_CONTINUE;
}

@OnGive(const UserId, const Trie:tParams) {
    new pWeapon = give_gaussrifle(UserId, GT_DROP_AND_REPLACE);
	
	if(pWeapon <= 0) {
		return VIPM_STOP;
	}
	
	rg_set_user_bpammo(pPlayer, get_member(pWeapon, m_iId), VipM_Params_GetInt(tParams, "BPAmmo", 1));
	
	return VIPM_CONTINUE;
}