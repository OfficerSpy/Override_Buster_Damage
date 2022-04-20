# Override_Buster_Damage
Overrides the damage dealt from Sentry Busters. Intended to be used with plugins that let humans join the Blue team in MvM.

Within `CTFBotMissionSuicideBomber::Detonate`, Sentry Busters will always deal damage that is 4x the victim's health upon detonation. Now in `CTFPlayer::OnTakeDamage`, any bot that is a MiniBoss and on the same team as the Sentry Buster will only take 600 damage from the detonation. However, this doesn't apply to human players on the Blue team since the game is checking if the player that took damage was a bot in the first place. As a result, human players will always be taking damage that is 4x their health, regardless if they are a MiniBoss or not.

This plugin will override damage from Sentry Buster robots against human players playing as a giant robot on the Blue team. It is intended only for the game mode Mann vs. Machine.
