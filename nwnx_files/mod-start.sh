#!/usr/bin/env bash

# Set the names for your server/module here
MODNAME=modname

# Enable disable NWNX_PROFILER
PROFILER_ENABLE=true

status=$(./mod-status.sh)
if [ "$status" -eq "1" ]; then
  echo "$MODNAME is already running"
  exit
fi

if [ -f /home/nwn/.mod-maintenance ]; then
  echo "$MODNAME maintenance in progress (.mod-maintenance file exists), not starting"
  exit
fi

# Make a backup of all characters each time the server restarts
./mod-savechars.sh

pushd ~/nwn/bin/linux-x86

# Advanced plugins most people won't use, so skip them by default.
export NWNX_ADMINISTRATION_SKIP=y
export NWNX_APPEARANCE_SKIP=y
export NWNX_AREA_SKIP=y
export NWNX_CHAT_SKIP=y
export NWNX_COMPILER_SKIP=y
export NWNX_COMBATMODE_SKIP=y
#export NWNX_CORE_SKIP=y
export NWNX_CREATURE_SKIP=y
export NWNX_DAMAGE_SKIP=y
export NWNX_DATA_SKIP=y
#export NWNX_DIAGNOSTICS_SKIP=y
export NWNX_DIALOG_SKIP=y
export NWNX_DOTNET_SKIP=y
export NWNX_ELC_SKIP=y
export NWNX_EFFECT_SKIP=y
export NWNX_ENCOUNTER_SKIP=y
export NWNX_EVENTS_SKIP=y
export NWNX_EXPERIMENTAL_SKIP=y
export NWNX_FEAT_SKIP=y
export NWNX_FEEDBACK_SKIP=y
export NWNX_ITEM_SKIP=y
export NWNX_ITEMPROPERTY_SKIP=y
export NWNX_JVM_SKIP=y
export NWNX_LUA_SKIP=y
export NWNX_MAXLEVEL_SKIP=y
export NWNX_METRICS_INFLUXDB_SKIP=y
export NWNX_MONO_SKIP=y
export NWNX_NOSTACK_SKIP=y
export NWNX_OBJECT_SKIP=y
export NWNX_OPTIMIZATIONS_SKIP=y
export NWNX_PLAYER_SKIP=y
export NWNX_PROFILER_SKIP=y
export NWNX_RACE_SKIP=y
export NWNX_REDIS_SKIP=y
export NWNX_REGEX_SKIP=y
export NWNX_RENAME_SKIP=y
export NWNX_REVEAL_SKIP=y
export NWNX_RUBY_SKIP=y
#export NWNX_SQL_SKIP=y
export NWNX_SWIG_SKIP=y
export NWNX_SERVERLOGREDIRECTOR_SKIP=y
export NWNX_SKILLRANKS_SKIP=y
export NWNX_SPELLCHECKER_SKIP=y
export NWNX_THREADWATCHDOG_SKIP=y
export NWNX_TILESET_SKIP=y
export NWNX_TIME_SKIP=y
export NWNX_TRACKING_SKIP=y
export NWNX_TWEAKS_SKIP=y
export NWNX_UTIL_SKIP=y
export NWNX_VISIBILITY_SKIP=y
export NWNX_WEAPON_SKIP=y
export NWNX_WEBHOOK_SKIP=y

# NWNX_CORE
# Log levels go from 2 (only fatal errors) to 7 (very verbose). 6 is recommended
export NWNX_CORE_LOG_LEVEL=6
#
# Set whether to show timestamp in logs printed by NWNX.
export NWNX_CORE_LOG_TIMESTAMP=1
#
# Set whether to show date(Y-M-D) in logs printed by NWNX. Timestamps must be enabled.
export NWNX_CORE_LOG_DATE=1
#
# Set whether to show plugin name in logs printed by NWNX.
export NWNX_CORE_LOG_PLUGIN=1
#
# Set whether to show source code location in logs printed by NWNX.
export NWNX_CORE_LOG_SOURCE=1
#
# Sets whether to flush the log to disk in an async thread.
export NWNX_CORE_LOG_ASYNC=1
#
# Sets which NWScript to run when the module shuts down.
#export NWNX_CORE_SHUTDOWN_SCRIPT=""

# NWNX_CHAT
# Sets the nwscript that the plugin will look for
export NWNX_CHAT_CHAT_SCRIPT="nwnx_chat"

# NWNX_COMPILER
#
# The directory containing the source .nss files.
export NWNX_COMPILER_SRC_DIR=""
#
# The directory to output the compiled .ncs files.
export NWNX_COMPILER_OUT_DIR=""
#
# Cleans all .ncs files from the output directory.
export NWNX_COMPILER_CLEAN_COMPILE=false
#
# Continue processing scripts after a compiler error.
export NWNX_COMPILER_CONTINUE_ON_ERROR=false
#
# After completing compilation, shuts down the server.
export NWNX_COMPILER_EXIT_ON_COMPLETE=true
#
# CScriptCompiler->SetCompileDebugLevel()
export NWNX_COMPILER_DEBUG_LEVEL=0
#
# CScriptCompiler->SetCompileSymbolicOutput()
export NWNX_COMPILER_SYMBOLIC_OUTPUT=0
#
# CScriptCompiler->SetGenerateDebuggerOutput()
export NWNX_COMPILER_GENERATE_DEBUGGER_OUTPUT=0
#
# CScriptCompiler->SetOptimizeBinaryCodeLength()
export NWNX_COMPILER_OPTIMIZE_BINARY_CODE_LENGTH=true

# NWNX DIAGNOSTICS
# Catches a few classes of memory corruptions in NWN and NWNX
export NWNX_DIAGNOSTICS_MEMORY_SANITIZER=true

# NWNX_ELC
# Sets the nwscript that the plugin will look for
export NWNX_ELC_ELC_SCRIPT="nwnx_elc"
#
# Enables the custom ELC check, an ELC script must be set for it to run.
export NWNX_ELC_CUSTOM_ELC_CHECK=false
#
# If enabled, resets a character's event scripts to default. Requires ELC to be enabled.
export NWNX_ELC_ENFORCE_DEFAULT_EVENT_SCRIPTS=false
#
# If enabled, resets a character's dialog resref to empty. Requires ELC to be enabled.
export NWNX_ELC_ENFORCE_EMPTY_DIALOG_RESREF=false
#
# If enabled, check when a character's first level class is a spellcaster, if their primary casting stat is >= 11.
export NWNX_ELC_ENFORCE_CASTER_PRIMARY_STAT_IS_11=false

# NWNX_EXPERIMENTAL
# Enables NWNX_EXPERIMENTAL
export NWNX_CORE_LOAD_EXPERIMENTAL_PLUGIN=n
#
# Suppresses the playerlist and player login/logout messages for all players except DMs.
# This functionality is not compatible with NWNX_Rename.
export NWNX_EXPERIMENTAL_SUPPRESS_PLAYER_LOGIN_INFO=false
#
# Attempts to correct a crash involving faction/reputations.
export NWNX_EXPERIMENTAL_ADJUST_REPUTATION_FIX=false
#
# Disable LevelUp Validation
export NWNX_EXPERIMENTAL_DISABLE_LEVELUP_VALIDATION=false
#
# Removes the hardcoded effects of the Ranger's Dual-wield feat.
export NWNX_EXPERIMENTAL_UNHARDCODE_RANGER_DUALWIELD=false
#
# Ignore the module's version when loading.
export NWNX_EXPERIMENTAL_IGNORE_MODULE_VERSION=false

# NWNX_FEAT
# Shows the effect's icon (the red and green squares)
export NWNX_FEAT_SHOW_EFFECT_ICON=true
#
# A custom spell id given to all effects created by this plugin.
#export NWNX_FEAT_CUSTOM_SPELL_ID=

# NWNX_MAXLEVEL
# Sets the max level 41-60
export NWNX_MAXLEVEL_MAX=40

# NWNX_METRICS
export NWNX_METRICS_INFLUXDB_HOST=localhost
export NWNX_METRICS_INFLUXDB_PORT=8089

# InfluxDB
# Database that will be created along with the container setup
export INFLUXDB_DB=metrics

# Credentials for your admin user. Don't give these away!
export INFLUXDB_ADMIN_USER=admin
export INFLUXDB_ADMIN_PASSWORD=admin

# Credentials for using for your reporting user (Grafana, etc.)
export INFLUXDB_USER=user
export INFLUXDB_USER_PASSWORD=password

# This will enable the InfluxDb UDP binding on the NWNX Metrics Plugin default port
export INFLUXDB_UDP_ENABLED=true
export INFLUXDB_UDP_BIND_ADDRESS=:8089
export INFLUXDB_UDP_DATABASE=metrics

# NWNX_NOSTACK
# The four variables below have a range of 0-4
# 0: Default value, vanilla behaviour
# 1: No stack, only highest effect will be used
# 2: Stacks both the highest spell AND item effect
# 3: No stack from items, spells will stack as vanilla
# 4: Custom, needs to be set in NWScript
#
# Controls whether ability scores should stack or not
export NWNX_NOSTACK_ABILITY=0
#
# Controls whether skill bonuses should stack or not
export NWNX_NOSTACK_SKILL=0
#
# Controls whether saving throw bonuses should stack or not
export NWNX_NOSTACK_SAVINGTHROW=0
#
# Controls whether attack bonuses should stack or not
export NWNX_NOSTACK_ATTACKBONUS=0
#
# Controls whether penalties should stack or not
export NWNX_NOSTACK_ALWAYS_STACK_PENALTIES=false
#
# Controls whether separate "OBJECT_INVALID" effects should stack or not
export NWNX_NOSTACK_SEPARATE_INVALID_OID_EFFECTS=false
#
# The two variables below have a range of 0 to 20
# 0: Enhancement Bonus (Default for Items)
# 1: Circumstance bonus (stacks) (Default for Spells)
# 2: Competence bonus
# 3: Insight Bonus
# 4: Luck Bonus
# 5: Morale Bonus
# 6: Profane Bonus
# 7: Resistance Bonus
# 8: Sacred Bonus
# 9-20: Custom
#
# Assigns all spells effects to desired type
export NWNX_NOSTACK_SPELL_DEFAULT_TYPE=1
#
# Assigns all items effects to desired type
export NWNX_NOSTACK_ITEM_DEFAULT_TYPE=0

# NWNX_OPTIMIZATIONS
# Flushes the game log on an async thread, potentially improving performance
export NWNX_OPTIMIZATIONS_ASYNC_LOG_FLUSH=true
#
# Optimizes object lookup code, improving performance
export NWNX_OPTIMIZATIONS_GAME_OBJECT_LOOKUP=true
#
# Optimizes Player client lookup from object IDs, improving performance
export NWNX_OPTIMIZATIONS_PLAYER_LOOKUP=true
#
# Optimizes LastUpdateObject lookup code, improving performance
export NWNX_OPTIMIZATIONS_LUO_LOOKUP=true
#
# Uses an experimental alternative update mechanism. Requires LUO_LOOKUP
# Breaks all of NWNX_Appearance
# Breaks the following NWNX_Player functions: SetObjectVisualTransformOverride,
# ApplyLoopingVisualEffectToObject, SetPlaceableNameOverride, SetCreatureNameOverride,
# SetObjectMouseCursorOverride and SetObjectHiliteColorOverride
# Breaks forcing object to be always visible from NWNX_Visibility
export NWNX_OPTIMIZATIONS_ALTERNATE_GAME_OBJECT_UPDATE=false
#
# Caches all script chunks, improving performance
export NWNX_OPTIMIZATIONS_CACHE_SCRIPT_CHUNKS=true
#
# Caches all nwscript debugger instances, improving GetScriptBacktrace() performance
export NWNX_OPTIMIZATIONS_CACHE_DEBUGGER_INSTANCES=true

# NWNX_PROFILER
export NWNX_PROFILER_ENABLE_OVERHEAD_COMPENSATION=$PROFILER_ENABLE
export NWNX_PROFILER_OVERHEAD_COMPENSATION_FORCE=0
export NWNX_PROFILER_OVERHEAD_COMPENSATION_RUNS=500
export NWNX_PROFILER_OVERHEAD_COMPENSATION_RECALIBRATE=$PROFILER_ENABLE
export NWNX_PROFILER_OVERHEAD_COMPENSATION_RECALIBRATION_PERIOD=1000
export NWNX_PROFILER_ENABLE_AI_MASTER_UPDATES=$PROFILER_ENABLE
export NWNX_PROFILER_AI_MASTER_UPDATES_OVERKILL=$PROFILER_ENABLE
export NWNX_PROFILER_ENABLE_MAIN_LOOP=$PROFILER_ENABLE
export NWNX_PROFILER_ENABLE_NET_LAYER=$PROFILER_ENABLE
export NWNX_PROFILER_ENABLE_NET_MESSAGES=$PROFILER_ENABLE
export NWNX_PROFILER_ENABLE_OBJECT_AI_UPDATES=$PROFILER_ENABLE
export NWNX_PROFILER_ENABLE_OBJECT_EVENT_HANDLERS=$PROFILER_ENABLE
export NWNX_PROFILER_ENABLE_PATHING=$PROFILER_ENABLE
export NWNX_PROFILER_ENABLE_SCRIPTS=$PROFILER_ENABLE
export NWNX_PROFILER_SCRIPTS_AREA_TIMINGS=$PROFILER_ENABLE
export NWNX_PROFILER_SCRIPTS_TYPE_TIMINGS=$PROFILER_ENABLE
export NWNX_PROFILER_ENABLE_TICKRATE=$PROFILER_ENABLE

# NWNX_RACE
# Shows the effect's icon (the red and green squares)
export NWNX_RACE_SHOW_EFFECT_ICON=true

# NWNX_REDIS
#
# Address to use
export NWNX_REDIS_HOST=""
#
# Port to use
export NWNX_REDIS_PORT=6379
#
# NWScript NWNX_REDIS will subcribe to
export NWNX_REDIS_PUBSUB_SCRIPT="on_pubsub"
#
# Channels it'll listen to
export NWNX_REDIS_PUBSUB_CHANNELS=""

# NWNX_RENAME
# This is the listing of players from the character selection screen before entering the server. Setting the value to 1 overrides their names if a global rename has been set, 2 also hides class information, 3 hides class information but keeps names as their original.
export NWNX_RENAME_ON_MODULE_CHAR_LIST=false
#
# Renames the player name on the player list as well.
export NWNX_RENAME_ON_PLAYER_LIST=true
#
# DM observers will see global or personal overrides as well as being able to have their own name overridden for other observers.
export NWNX_RENAME_ALLOW_DM=false
#
# When using NWNX_Rename_SetPCNameOverride with NWNX_RENAME_PLAYERNAME_ANONYMOUS this is the string used for the <PlayerName>
export NWNX_RENAME_ANONYMOUS_NAME="Someone"
#
# When set to true, global overrides change the display name globally - scripts and DMs included. When set to false, then name is only changed for players. Scripts and DMs see the original names (unless NWNX_RENAME_ALLOW_DM is set).
export NWNX_RENAME_OVERWRITE_DISPLAY_NAME=false

# NWNX_SQL
#
# Types are: MYSQL, POSTGRESQL, SQLITE
export NWNX_SQL_TYPE=MYSQL
#
# Host name where the database resides. Typically localhost but can be any valid host name or IP address.
# Not used if using SQLITE
export NWNX_SQL_HOST=localhost
#
# The port for the database connection. If left unset it will use the default port.
# Only used by MYSQL
export NWNX_SQL_PORT=3307
#
# Database username used for the connection.
# Not used if using SQLITE
export NWNX_SQL_USERNAME=user
#
# Password for the database connection.
# Not used if using SQLITE
export NWNX_SQL_PASSWORD=password
#
# The database to connect to.
# The filename of the database when using SQLite, it is stored in the UserDirectory/database folder.
export NWNX_SQL_DATABASE=mymodulename
#
# Export query execution metrics.
# The Metrics_InfluxDB plugin and a visualizer like Grafana are required to view these metrics.
export NWNX_SQL_QUERY_METRICS=true
#
# Convert all strings going between the database and game to/from UTF8
# This takes into account the core locale as well.
#export NWNX_SQL_USE_UTF8=true
#
# Set the connection's character set to be used.
# Only supported on mysql and pgsql. For sqlite this can be achieved with a query.
# For supported MYSQL character sets check: https://dev.mysql.com/doc/refman/8.0/en/charset-charsets.html
# For supported POSTGRESQL character sets check: https://www.postgresql.org/docs/current/multibyte.html
#export NWNX_SQL_CHARACTER_SET=utf8mb3

# NWNX_SERVERLOGREDIRECTOR
# When true, "*** ValidateGFFResource sent by user." messages are not written to the NWNX log
export NWNX_SERVERLOGREDIRECTOR_HIDE_VALIDATEGFFRESOURCE_MESSAGES=false

# NWNX_SPELLCHECKER
# Path to the aff file
export NWNX_SPELL_PATH_AFF=/usr/share/hunspell/en_US.aff
#
# Path to the dic file
export NWNX_SPELL_PATH_DIC=/usr/share/hunspell/en_US.dic

# NWNX_THREADWATCHDOG
# Set the period at which the watchdog fires, in seconds
export NWNX_THREADWATCHDOG_PERIOD=5
#
# Number of successive long stall detections needed to kill the server
export NWNX_THREADWATCHDOG_KILL_THRESHOLD=5

# NWNX_TRACKING
# Enable targeting object to track
export ENABLE_ACTIVITY_TARGET=true

# NWNX_TWEAKS
# Custom behavior tweaks from the NWNX_Tweaks plugin. Uncomment/modify to enable
#
# Hide players classes from Character Selection Window
export NWNX_TWEAKS_HIDE_CLASSES_ON_CHAR_LIST=false
#
# HP players need to reach to be considered dead
export NWNX_TWEAKS_PLAYER_DYING_HP_LIMIT=-10
#
# Disable pausing by players and DMs
export NWNX_TWEAKS_DISABLE_PAUSE=false
#
# Disable DM quicksave ability
export NWNX_TWEAKS_DISABLE_QUICKSAVE=false
#
# Stackable items can only be merged if all local variables are the same
export NWNX_TWEAKS_COMPARE_VARIABLES_WHEN_MERGING=true
#
# Parry functions as per description, instead of blocking max 3 attacks per round
export NWNX_TWEAKS_PARRY_ALL_ATTACKS=true
#
# Immunity to Critical Hits does not confer immunity to sneak attack
export NWNX_TWEAKS_SNEAK_ATTACK_IGNORE_CRIT_IMMUNITY=true
#
# Items are not destroyed when they reach 0 charges
export NWNX_TWEAKS_PRESERVE_DEPLETED_ITEMS=true
#
# 1: DMs are hidden on Char List; 2: PCs are hidden on Char List; 3: Both PCs and DMs are hidden on char list.
export NWNX_TWEAKS_HIDE_PLAYERS_ON_CHAR_LIST=1
#
# Disable monk abilities when polymorphed
export NWNX_TWEAKS_DISABLE_MONK_ABILITIES_WHEN_POLYMORPHED=false
#
# Lets you convert hex numbers (and others) to string
export NWNX_TWEAKS_STRINGTOINT_BASE_TO_AUTO=true
#
# Dead creatures will trigger OnAreaExit
export NWNX_TWEAKS_DEAD_CREATURES_TRIGGER_ON_AREA_EXIT=false
#
# Keep doing what was doing when DM possessess
export NWNX_TWEAKS_PRESERVE_ACTIONS_ON_DM_POSSESS=true
#
# Fix GS Bug
export NWNX_TWEAKS_FIX_GREATER_SANCTUARY_BUG=true
#
# 1 = Same price at 50 charges
# 2 = Increase price after 50 charges, doubling at 250 charges
# 3 = Increase price after 50 charges, 5 times at 250 charges
export NWNX_TWEAKS_ITEM_CHARGES_COST_MODE=2
#
# Dispell Effect Fix
export NWNX_TWEAKS_FIX_DISPEL_EFFECT_LEVELS=true
#
# Prestige Classes counts as caster levels
export NWNX_TWEAKS_ADD_PRESTIGECLASS_CASTER_LEVELS=true
#
# Fix Unlimited Potions Bug
export NWNX_TWEAKS_FIX_UNLIMITED_POTIONS_BUG=true
#
# Remove hardcode from shields
export NWNX_TWEAKS_UNHARDCODE_SHIELDS=true
#
# Stops DMs from spawning items
export NWNX_TWEAKS_BLOCK_DM_SPAWNITEM=false
#
# Allows armor with a max DEX bonus of under 1.
export NWNX_TWEAKS_FIX_ARMOR_DEX_BONUS_UNDER_ONE=true
#
# Fixes a (rare?) inventory crash bug.
export NWNX_TWEAKS_FIX_ITEM_NULLPTR_IN_CITEMREPOSITORY=true
#
# Effects on logged out player characters will be removed when a caster rests.
export NWNX_TWEAKS_CLEAR_SPELL_EFFECTS_ON_TURDS=true
#
# Creatures will always have their full dex states, even when immobilized/entangled.
export NWNX_TWEAKS_ALWAYS_RETURN_FULL_DEX_STAT=false
#
# The number of attacks per round overridden by SetBaseAttackBonus() will show on the character sheet.
export NWNX_TWEAKS_DISPLAY_NUM_ATTACKS_OVERRIDE_IN_CHARACTER_SHEET=true
#
# TURDs are associated by CDKey/CharacterName instead of PlayerName/CharacterName. Pass the CDKey instead of PlayerName when calling NWNX_Administration_DeleteTURD()
export NWNX_TWEAKS_TURD_BY_CDKEY=true
#
# 1: French
# 2: German
# 3: Italian
# 4: Spanish
# 5: Polish
# 6: Italian
# 128: Korean
# 129: Chinese Traditional
# 130: Chinese Simplified
# 131: Japanese
#export NWNX_TWEAKS_LANGUAGE_OVERRIDE=
#
# TlkTable entries overridden by SetTlkOverride() will be sent before Character Generation.
export NWNX_TWEAKS_SEND_TLK_OVERRIDE_BEFORE_CHARGEN=true
#
# When splitting an item, local variables will be copied.
export NWNX_TWEAKS_RETAIN_LOCAL_VARIABLES_ON_ITEM_SPLIT=true
#
# Prevents attack bonus effects from bypassing damage reductions.
export NWNX_TWEAKS_PREVENT_ATTACK_BONUS_BYPASSING_REDUCTION=false
#
# Makes SetMaterialShaderParamXxx() functions take sMaterial="" to mean all materials.
export NWNX_TWEAKS_MATERIAL_NAME_NULL_IS_ALL=false
#
# 1: Manual VFX (ItemPropertyVisualEffect)
# 2: (Elemental) DamageBonus
# 4: (Elemental) DamageBonusVSAlignmentGroup)
# 8: (Elemental) DamageBonusVSRacialGroup
# 16: (Elemental) DamageBonusVSSpecificAlignment
# 32: HolyAvenger
# 64: VampiricRegeneration
# 128: OnHitLevelDrain
# 256: OnHitVorpal
# 512: OnHitWounding
# 1024: (Good/Evil) DamageBonusVSAlignmentGroup)
# 2048: (Good/Evil) AttackBonusVSAlignmentGroup
# 4096: (Good/Evil) EnhancementBonusVSAlignmentGroup
# 8192: (Good/Evil) DamageBonusVSSpecificAlignment
# 16384: (Good/Evil) AttackBonusVSSpecificAlignment
# 32768: (Good/Evil) EnhancementBonusVSSpecificAlignment
#
# Some values for convenience
# 30: All Elemental Damage Bonus
# 896: All OnHit properties
# 7168: All Good/Evil vs AlignmentGroup
# 57344: All Good/Evil vs SpecificAlignment
# 65535: Hide all VFX
#
# This is good in case you want to manually apply VFX on items through NWScript
# Instead of toolset automatically applying VFX depending on the property you added to them
#export NWNX_TWEAKS_HIDE_HARDCODED_ITEM_VFX=
#
# The CNWSCreature::CanUseItem() function will also check ILR for Henchmen.
export NWNX_TWEAKS_CANUSEITEM_CHECK_ILR_FOR_HENCHMEN=true
#
# Adds an additional bounds check for triggers to fix a trigger detection bug.
export NWNX_TWEAKS_FIX_TRIGGER_ENTER_DETECTION=true
#
# Uncaps the compounded damage flags of EffectDamageResistance.
export NWNX_TWEAKS_UNCAP_DAMAGE_RESISTANCE_DAMAGE_FLAGS=true
#
# Stops damage from being resolved when a special attack misses.
export NWNX_TWEAKS_FIX_RESOLVE_SPECIAL_ATTACK_DAMAGE=true
#
# Stops effects from unlinking when restored from a TURD due to their effect ID changing.
export NWNX_TWEAKS_FIX_TURD_EFFECT_UNLINKING=true

# NWNX_UTIL
# Allows you to set a NWScript that runs before the OnModuleLoad event
#export NWNX_UTIL_PRE_MODULE_START_SCRIPT=""
#
# Allows you to set a NWScript Chunk that runs before the OnModuleLoad event
#export NWNX_UTIL_PRE_MODULE_START_SCRIPT_CHUNK=""

# Keep all logs in this directory
LOGFILE=~/logs/mod-$(date +%s).txt
echo "Starting $MODNAME. Log is $LOGFILE"

# Set game options below

export NWNX_CORE_LOAD_PATH=~/nwnx/Binaries
LD_PRELOAD=~/nwnx/Binaries/NWNX_Core.so:~/nwnx/Binaries/NWNX_Diagnostics.so \
  ./nwserver-linux \
  -module "$MODNAME" \
  -maxclients 20 \
  -minlevel 1 \
  -maxlevel 40 \
  -pauseandplay 0 \
  -pvp 1 \
  -servervault 1 \
  -elc 0 \
  -ilr 0 \
  -gametype 0 \
  -oneparty 0 \
  -difficulty 4 \
  -autosaveinterval 60 \
  -dmpassword 'password' \
  -servername 'My Cool Server' \
  -publicserver 1 \
  -reloadwhenempty 0 \
  -port 5121 \
  -nwsyncurl http://web.site.address/nwsyncdata/ \
  "$@" >>$LOGFILE 2>&1 &

echo $! >~/.modpid
popd
