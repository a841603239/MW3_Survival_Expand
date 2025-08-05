[中文](README_CN.md) | [English](README.md)

## 📖 General

- Waves timer increased from 30 seconds to **40 seconds**.  
- Adjusted enemy count and composition per wave.  
- Equipment_menu available after ** Wave 2**, Weapon_menu available after **Wave 4**, and Airsupport_menu available after **Wave 6**.  
- Fixed or rewrote numerous Chinese localzation in Survival Mode.  
- Replaced the menu background.  
- Adjusted enemy strength and numbers per wave, with slight tweaks to different enemy types' health and **reduced score rewards for kills**.  
- Enemy attributes scale linearly with wave progression, as detailed below:  

| Attribute    | Per-Wave Increase | Max Cap (Relative to Base) | Wave to Reach Cap |  
|-------------|------------------|---------------------------|------------------|  
| Health      | Linear Growth    | 300%                      | Wave 40          |  
| Movement Speed | Linear Growth | 150%                      | Wave 25          |  
| Accuracy    | Linear Growth    | 120%                      | Wave 20          |  

- Difficulty differences between maps **only affect starting equipment&ammo**.  
- HUD Adjustments:  
  - PERK icons are now positioned closer to the left side of the screen.  
  - Added ally squad maxhealth/health display below the minimap in the top-left corner.  

## 🔫 Weapon Menu  

- Adjusted weapon prices.  
- Refined descriptions for all firearms.  
- Weapon realism adjustments:  
  - M1887 **base damage** increased from 30 to 40, **minimum damage** from 20 to 30.  
- Integrated [@SadSlothXL's Akimbo Mod](https://github.com/SadSlothXL/IW5-mod_akimbo). Supported weapons:  

| Weapon Type      | Akimbo-Compatible Weapons                                                                 |  
|------------------|------------------------------------------------------------------------------------------|  
| All Pistols      | Five Seven, USP.45, MP412, Desert Eagle, .44 Magnum, P99                                |  
| All Machine Pistols | G18, Skorpion, MP9, FMG9                                                              |  
| SMGs            | UMP45, PP90M1                                                                           |  
| Shotguns        | Model 1887                                                                              |  

```
*Known Bugs:*
	  - *Due to menu modification limitations, all weapons display the akimbo option, but only the listed weapons are functional.*
	  - *The akimbo model occupies the GP25 grenade launcher slot, meaning GP25 can no longer be purchased. The only affected weapon is the AK47.*
```


## 💣 Equipment Menu  

- Adjusted equipment item prices.  
- Body armor replaced with **multi-layered armor**. Can be purchased **up to 3 times**, granting 200 armor points per purchase. No purchases allowed if armor exceeds 600.  
- RPG max ammo capacity increased from 4 to 8.  
- Sentry-gun and sentry-grenade-launcher limits raised from 2 to **4**, with updated descriptions.  
- Sentry gun health increased from 800 to 1800; sentry grenade launcher health increased from 1000 to 1600.  

## ✈️ Airsupport Menu  

- Adjusted airsupport item prices.  
- Perks **max carry capacity increased to 2 types**. Players cannot purchase additional perks if they already have 2.  
- **All perks are lost when downed in LastStand.**  
- Add screen notifications for most airsupport purchases.  
- Remaked ally support system:  
  - **Delta Squad replaced with 1 Juggernaut, equipped with a Pecheneg LMG, base health : 2000, damage resistance : 50% . Moves slowly but follows the player.**  
  - **G.I.G.N Squad now consists of 2 members wielding SPAS-12 shotguns, base health of 500. They follow the player for the first 60 seconds before switching to a defensive hold.**  
  - **New reinforcement: "Call Friendly Attack Helicopter." The helicopter circles above, engaging nearby enemies for 5 minutes before departing. Max 1 helicopter active at a time.**  
  - **Ally squad cap increased to 3 teams (max 6 members), excluding helicopters.**  
- New battlefield upgrades:  
  - **Vigor Boost**: Permanently increases Delta and G.I.G.N squad health by 500 per upgrade (max 4 upgrades).  
  - **Improved Crafting**: Permanently increases sentry gun and grenade launcher health by 500 (1 upgrade only).  
  - **Call Resupply**: Restores health and ammo for ally squads.  

```
*Known Bugs:*
	- *Due to menu limitations, the air support menu does not auto-center when opened.*
	- *Due to menu limitations, the air support menu does not auto-center when opened.*
```


## 💻 Installation Guide  

1. Download <span style="color:red">MW3_survival_expand.rar</span> from the Releases.  
2. Extract and copy to the game root directory. Overwrite when prompted.  
   <span style="color:red">  
       The following files will be overwritten:<br>  
       \main\iw_24.iwd<br>  
       \zone\chinese\patch_survival.ff  
   </span>  
3. (Optional) Run <span style="color:red">IW5_background_menu_replace.exe</span> to replace the main menu background.  
4. Start game.  

## 📖 Credits  

- Mod created by Sorin.  
- Inspired by [@神念MAX](https://space.bilibili.com/175979296)'s MW2 Survival Mod. Special thanks for technical guidance.  
- Akimbo mod originally by [@SadSlothXL](https://github.com/SadSlothXL/IW5-mod_akimbo). Included in this mod.  

## 💖 Donate 

**MW3_survival_expand** is a free mod. If you enjoy it,please consider donating! 🤩  

| Platforms    | Donation Button                                                                                              | Message    |  
|:------------:|:------------------------------------------------------------------------------------------------------------:|:-----------|  
| PayPal       | [![PayPal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://paypal.me/841603239)        | Thank you! |  

## ✅ Mod File Structure  

```bash  
├── accuracy/  
│   ├── aivsai/  
│   │   ├── assault_rifle.accu  
│   │   ├── pistol.accu  
│   │   ├── rpg.accu  
│   │   ├── smg.accu  
│   │   └── sniper_rifle.accu  
│   │  
│   └── aivsplayer/  
│       ├── assault_rifle.accu  
│       ├── mg.accu  
│       ├── pistol.accu  
│       ├── rpg.accu  
│       ├── shotgun.accu  
│       ├── smg.accu  
│       └── sniper_rifle.accu  
│  
├── aitype/  
│   ├── ally_so_delta.gsc  
│   ├── ally_so_riotshield.gsc  
│   ├── enemy_juggernaut_so_survival.gsc  
│   └── enemy_so_chemical.gsc  
│  
├── english/  
│   └── localizedstrings/  
│       ├── mod_survival_airsupport_menu.str  
│       ├── mod_survival_equipment_menu.str  
│       ├── mod_survival_weapon_menu.str  
│       └── patch_survival.str  
│  
├── images/  
│   ├── icon_call_for_resupply.iwi  
│   ├── icon_friendly_support_chopper.iwi  
│   ├── icon_friendly_support_dog.iwi  
│   ├── icon_friendly_support_juggernaut.iwi  
│   ├── icon_upgrade_friendly_squad.iwi  
│   ├── icon_upgrade_sentry_gun.iwi  
│   ├── small_icon_survival_chopper.iwi  
│   ├── small_icon_survival_gign.iwi  
│   └── small_icon_survival_juggernaut.iwi  
│  
├── materials/  
│   ├── icon_call_for_resupply.json  
│   ├── icon_friendly_support_chopper.json  
│   ├── icon_friendly_support_dog.json  
│   ├── icon_friendly_support_juggernaut.json  
│   ├── icon_upgrade_friendly_squad.json  
│   ├── icon_upgrade_sentry_gun.json  
│   ├── small_icon_survival_chopper.json  
│   ├── small_icon_survival_gign.json  
│   └── small_icon_survival_juggernaut.json  
│  
├── sp/  
│   ├── survival_armories.csv  
│   ├── survival_waves.csv  
│   │  
│   └── so_survival/  
│       ├── tier_1.csv  
│       ├── tier_2.csv  
│       ├── tier_3.csv  
│       ├── tier_4.csv  
│       ├── tier_dlc_1.csv  
│       └── tier_dlc_2.csv  
│  
├── ui/  
│   └── scriptmenus/  
│       ├── survival_armory_airsupport.menu  
│       └── survival_armory_airsupport_perks.menu  
│  
├── weapons/  
│   ├── iw5_1887_mp  
│   ├── iw5_pp90m1_mp  
│   ├── iw5_ump45_mp  
│   └── rpg_survival  
│  
└── [base]  
    ├── 1557.gsc  
    ├── 1564.gsc  
    ├── 1571.gsc  
    ├── 1574.gsc  
    ├── mod_friendly_health_hud.gsc  
    └── mod_friendly_upgrade.gsc  
```
