#!/bin/bash

# Set the names for your server/module here
MODNAME=modname

# Enable disable NWNX_PROFILER
PROFILER_ENABLE=true

status=$(./mod-status.sh)
if [ "$status" -eq "1" ]; then
    echo "$MODNAME is already running"
    exit;
fi

if [ -f /home/nwn/.mod-maintenance ]; then
    echo "$MODNAME maintenance in progress (.mod-maintenance file exists), not starting"
    exit;
fi

# Make a backup of all characters each time the server restarts
./mod-savechars.sh

pushd ~/nwn/bin/linux-x86

# Advanced plugins most people won't use, so skip them by default.
export NWNX_ADMINISTRATION_SKIP=y
export NWNX_APPEARANCE_SKIP=y
export NWNX_AREA_SKIP=y
export NWNX_CHAT_SKIP=y
export NWNX_COMBATMODES_SKIP=y
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

# Set you DB connection info here
export NWNX_SQL_TYPE=mysql
export NWNX_SQL_HOST=localhost
export NWNX_SQL_USERNAME=user
export NWNX_SQL_PASSWORD=password
export NWNX_SQL_DATABASE=nwn
export NWNX_SQL_QUERY_METRICS=true

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

# NWNX_FEAT
# Shows the effect's icon (the red and green squares)
export NWNX_FEAT_SHOW_EFFECT_ICON=true

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

# NWNX_OPTIMIZATIONS
# Flushes the game log on an async thread, potentially improving performance
export NWNX_OPTIMIZATIONS_ASYNC_LOG_FLUSH=true
#
# Optimizes object lookup code, improving performance
export NWNX_OPTIMIZATIONS_GAME_OBJECT_LOOKUP=true
#
# Optimizes GetObjectByTag() lookup code, improving performance
export NWNX_OPTIMIZATIONS_OBJECT_TAG_LOOKUP=true

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

# NWNX_RENAME
# This is the listing of players from the character selection screen before entering the server. Setting the value to 1 overrides their names if a global rename has been set, 2 also hides class information, 3 hides class information but keeps names as their original.
export NWNX_RENAME_ON_MODULE_CHAR_LIST=1
#
# Renames the player name on the player list as well.
export NWNX_RENAME_ON_PLAYER_LIST=true 
#
# DM observers will see global or personal overrides as well as being able to have their own name overridden for other observers.
export NWNX_RENAME_ALLOW_DM=true
#
# When using NWNX_Rename_SetPCNameOverride with NWNX_RENAME_PLAYERNAME_ANONYMOUS this is the string used for the <PlayerName>
export NWNX_RENAME_ANONYMOUS_NAME="Someone"
#
# When set to true, global overrides change the display name globally - scripts and DMs included. When set to false, then name is only changed for players. Scripts and DMs see the original names (unless NWNX_RENAME_ALLOW_DM is set).
export NWNX_RENAME_OVERWRITE_DISPLAY_NAME=true

# NWNX_SERVERLOGREDIRECTOR
# When true, *** ValidateGFFResource sent by user. messages are not written to the NWNX log
export NWNX_SERVERLOGREDIRECTOR_HIDE_VALIDATEGFFRESOURCE_MESSAGES=false

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
export NWNX_TWEAKS_DISABLE_PAUSE=true
#
# Disable DM quicksave ability
export NWNX_TWEAKS_DISABLE_QUICKSAVE=true
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
# Fix some intel crashes by disabling some shadows on areas
export NWNX_TWEAKS_DISABLE_SHADOWS=false
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
#export NWNX_TWEAKS_FIX_UNLIMITED_POTIONS_BUG=true
#
# Remove hardcode from shields
export NWNX_TWEAKS_UNHARDCODE_SHIELDS=true
#
# Stops DMs from spawning items
export NWNX_TWEAKS_BLOCK_DM_SPAWNITEM=false

# NWNX_UTIL
# Allows you to set a NWScript that runs before the OnModuleLoad event
#export NWNX_UTIL_PRE_MODULE_START_SCRIPT=""
#
# Allows you to set a NWScript Chunk that runs before the OnModuleLoad event
#export NWNX_UTIL_PRE_MODULE_START_SCRIPT_CHUNK=""

# Keep all logs in this directory
LOGFILE=~/logs/mod-`date +%s`.txt
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
  "$@" >> $LOGFILE 2>&1 &

echo $! > ~/.modpid 
popd 
