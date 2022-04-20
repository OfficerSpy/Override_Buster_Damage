#include <sourcemod>
#include <sdkhooks>
#include <tf2_stocks>

#pragma semicolon 1

public Plugin myinfo =
{
	name = "[TF2] Override Buster Damage",
	author = "Officer Spy",
	description = "Override the damage dealt from Sentry Buster bots to Blue human players in MvM.",
	version = "1.0.0",
	url = ""
};

public OnClientPutInServer(int client)
{
	SDKHook(client, SDKHook_OnTakeDamage, SDKOnPlayerTakeDamage);
}

public Action SDKOnPlayerTakeDamage(int victim, int& attacker, int& inflictor, float& damage, int& damagetype, int& weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	if (!IsValidClientIndex(attacker))
		return Plugin_Continue;
	
	//Ignore blue giant bot players.
	if (!IsFakeClient(victim) && IsMiniBoss(victim) && TF2_GetClientTeam(victim) == TFTeam_Blue)
	{
		//Override damage from buster bots.
		if (IsFakeClient(attacker) && IsSentryBuster(attacker) && damagetype & DMG_BLAST)
		{
			if (damage > 600.0)
			{
				damage = 600.0;
				return Plugin_Changed;
			}
		}
	}
	return Plugin_Continue;
}

stock bool IsValidClientIndex(int client)
{
	if (client > 0 && client <= MaxClients && IsClientInGame(client))
		return true;
		
	return false;
}

stock bool IsSentryBuster(int client)
{
	char model[PLATFORM_MAX_PATH];
	GetClientModel(client, model, PLATFORM_MAX_PATH);
	return StrEqual(model, "models/bots/demo/bot_sentry_buster.mdl");
}

stock bool IsMiniBoss(int client)
{
	return !!GetEntProp(client, Prop_Send, "m_bIsMiniBoss");
}