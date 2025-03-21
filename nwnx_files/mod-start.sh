#!/usr/bin/env bash

#######################################################
# SERVER CONFIGURATION START
#######################################################

# Module name without the '.mod' extension
MODNAME=mymodule

# Name that will be shown in the server list
SERVERNAME='My Cool Server'

# Player password
# The password the player must enter to log in
PLAYERPASSWORD='password'

# DM Password
# The password the DM must enter to log in
DMPASSWORD='password'

# Admin Password
# The password the player must enter to log in with DM powers
ADMINPASSWORD='password'

# Max players allowed to be logged in the server simultaneously
MAXCLIENTS=20

# Minimum player level
MINLEVEL=1

# Maximum player level
MAXLEVEL=40

# Pause and Play
# 0: Only a DM can pause the server
# 1: Anyone can pause the server
PAUSEANDPLAY=0

# PvP (Player versus Player)
# 0: Disabled
# 1: Party PVP
# 2: Full PVP (Friendly-fire enabled)
PVP=1

# Server vault only
# 0: Use local vault only
# 1: Use server vault only
SERVERVAULT=1

# Enforce Legal Characters
# 0: Disabled
# 1: Enabled
# Disable if using custom ELC
ELC=1

# Item Level Restriction
# 0: Disabled
# 1: Enabled
# Disable if using custom ILR
ILR=1

# Game/Server type/genre
# 0: Action
# 1: Story
# 2: Story lite
# 3: Role Play
# 4: Team
# 5: Melee
# 6: Arena
# 7: Social
# 8: Alternative
# 9: PW Action (PW = Persistent World)
# 10: PW Story (PW = Persistent World)
# 11: Solo
# 12: Tech Support
GAMETYPE=10

# One party only
# 0: Allow multiple parties
# 1: One party for everyone
ONEPARTY=0

# Difficulty
# 1: Easy (Easiest)
# 2: Normal
# 3: D&D Hardcore
# 4: Very Difficult (Hardest)
DIFFICULTY=3

# Auto-save interval in minutes
AUTOSAVEINTERVAL=5

# List the server publicly
# 0: Doesn't show the server in the server list
# 1: Show the server in the server list
PUBLICSERVER=1

# Reload the server when empty
# 0: Disabled
# 1: Enabled
RELOADWHENEMPTY=0

# Port to listen on for the server
PORT=5121

# NWSync
# Link to nwsync if using it
NWSYNCURL=''

# -----------------------------------------------------

# Keep all logs in this directory
LOGFILE="$HOME/share/logs/mod-$(date +%s).txt"

#######################################################
# SERVER CONFIGURATION END
#######################################################

#######################################################
# NWNX CONFIGS START
#######################################################

# InfluxDB
# Admin username for InfluxDB
INFLUXDBADMINUSER='admin'
# Admin password for InfluxDB
INFLUXDBADMINPASSWORD='pass'

# User username for InfluxDB
INFLUXDBUSER='nwn'
# User password for InfluxDB
INFLUXDBUSERPASSWORD='pass'

# -----------------------------------------------------

# Redis
# NWScript that will be used by Redis calls
REDISPUBSUBSCRIPT='on_pubsub'
# Channels that the Redis will listen to.
# Comma separated strings
REDISPUBSUBCHANNELS='test, server, runscript'

# -----------------------------------------------------

# SQL

# SQL Type, values are
# MYSQL
# PSTGRESQL
# SQLITE
SQLTYPE="MYSQL"
#
# Database username used for the connection
# Not used if using SQLite
SQLUSERNAME='nwn'
# Database password used for the connection
# Not used if using SQLite
SQLPASSWORD='pass'

# The name of the database to connect to.
# If using SQLite it's the filename in NWN's Documents/database folder
SQLDATABASE='name'

#######################################################
# NWNX CONFIGS END
#######################################################

#######################################################
# CUSTOM ENV VARS START
#######################################################

# CUSTOM ENV VARS (These are here for examples)
# These can be retrieved in nwscript by NWNX_UTIL using the:
# NWNX_Util_GetEnvironmentVariable("ENV_VAR_NAME");
# It returns anything as a string so define all your vars as strings

# In nwscript it would look like this:
# string sWebhook = NWNX_Util_GetEnvironmentVariable("MY_COOL_DISCORD_SERVER_WEBHOOK");
export MY_COOL_DISCORD_SERVER_WEBHOOK="/api/webhooks/SUPERLONGCODE/slack"

# You can string to int/float:
# string sMultiplier = NWNX_Util_GetEnvironmentVariable("MY_COOL_CUSTOM_XP_MULTIPLIER");
# float fMultiplier = StringToFloat(sMultiplier)
export MY_COOL_CUSTOM_XP_MULTIPLIER=1.2

# You can even play with "conditionals"
# string sEnableDoubleXP = NWNX_Util_GetEnvironmentVariable("MY_COOL_EVENT_DOUBLE_XP");
# int bEnableDoubleXP = StringToInt(sEnableDoubleXP)
export MY_COOL_EVENT_DOUBLE_XP=0

# You can use their values just like you would any other var
# string sMessageToShout = NWNX_Util_GetEnvironmentVariable("MY_COOL_EVENT_DOUBLE_XP_MESSAGE");
# AssignCommand(GetModule(), ActionSpeakString(sMessageToShout, TALKVOLUME_SHOUT));
export MY_COOL_EVENT_DOUBLE_XP_MESSAGE="We're running double XP, enjoy!"

export MY_SPOOKY_WARNING_WARNING=1

export MY_SPOOKY_WARNING_WARNING_MESSAGE="Don't give your personal info, we'll never ask for it!"

# For "true/false" bools you can create a function that "converts" them to 1/0
# That can be used as a boolean that nwscript understands
export PTR_ENABLED=true

#######################################################
# CUSTOM ENV VARS END
#######################################################

#######################################################
# LOAD PLUGINS START
#######################################################

# 0 = Loads the plugin
# 1 = Don't load the plugin

# All plugins (besides diagnostics and sql) are set to 1, which means, they won't be loaded
# To load them either change the 1 to 0 or comment them (Put a '#' in front of them)

# If this is skipped (set to 1), NWNX will be disabled
export NWNX_CORE_SKIP=0

# 0 = Loads all plugins, you'll have to manually disable plugins you don't want to load
# 1 = Don't load any plugin, you'll have to manually enable plugins you want to load
export NWNX_CORE_SKIP_ALL=0

export NWNX_ADMINISTRATION_SKIP=1
export NWNX_APPEARANCE_SKIP=1
export NWNX_AREA_SKIP=1
export NWNX_CHAT_SKIP=1
export NWNX_COMPILER_SKIP=1
export NWNX_CREATURE_SKIP=1
export NWNX_DAMAGE_SKIP=1
# export NWNX_DIAGNOSTICS_SKIP=1
export NWNX_DIALOG_SKIP=1
export NWNX_DOTNET_SKIP=1
export NWNX_ELC_SKIP=1
export NWNX_EFFECT_SKIP=1
export NWNX_ENCOUNTER_SKIP=1
export NWNX_EVENTS_SKIP=1
export NWNX_EXPERIMENTAL_SKIP=1
export NWNX_FEAT_SKIP=1
export NWNX_FEEDBACK_SKIP=1
export NWNX_HTTPCLIENT_SKIP=1
export NWNX_ITEM_SKIP=1
export NWNX_ITEMPROPERTY_SKIP=1
export NWNX_LUA_SKIP=1
export NWNX_MAXLEVEL_SKIP=1
export NWNX_METRICS_INFLUXDB_SKIP=1
export NWNX_NWSQLITEEXTENSIONS_SKIP=1
export NWNX_NOSTACK_SKIP=1
export NWNX_OBJECT_SKIP=1
export NWNX_OPTIMIZATIONS_SKIP=1
export NWNX_PLAYER_SKIP=1
export NWNX_PROFILER_SKIP=1
export NWNX_RACE_SKIP=1
export NWNX_REDIS_SKIP=1
export NWNX_RENAME_SKIP=1
export NWNX_RESOURCES_SKIP=1
export NWNX_REVEAL_SKIP=1
export NWNX_RUBY_SKIP=1
# export NWNX_SQL_SKIP=1
export NWNX_SWIG_SKIP=1
export NWNX_SERVERLOGREDIRECTOR_SKIP=1
export NWNX_SKILLRANKS_SKIP=1
export NWNX_SPELLCHECKER_SKIP=1
export NWNX_STORE_SKIP=1
export NWNX_THREADWATCHDOG_SKIP=1
export NWNX_TILESET_SKIP=1
export NWNX_TRACKING_SKIP=1
export NWNX_TWEAKS_SKIP=1
export NWNX_UTIL_SKIP=1
export NWNX_VISIBILITY_SKIP=1
export NWNX_WEAPON_SKIP=1
export NWNX_WEBHOOK_SKIP=1

#######################################################
# LOAD PLUGINS END
#######################################################

#######################################################
# CONFIGURE PLUGINS START
#######################################################

# -----------------------------------------------------
# NWNX_CORE
#
# Log levels go from 2 (only fatal errors) to 7 (very verbose). 6 is is a good level for live servers.
# 7 includes debug messages
export NWNX_CORE_LOG_LEVEL=0
#
# Enables NWNX_EXPERIMENTAL
export NWNX_CORE_LOAD_EXPERIMENTAL_PLUGIN=0
#
# Set the locale NWNX will use when encoding.
# Supported are cp1250, cp1251, cp1252 (default). Can also use two letter country codes (e.g. 'ru')
export NWNX_CORE_LOCALE=""
#
# Sets whether an ASSERT failure hard crashed the server
export NWNX_CORE_CRASH_ON_ASSERT_FAILURE=0
#
# Sets which NWScript to run when the module shuts down.
export NWNX_CORE_SHUTDOWN_SCRIPT=""
#
# When enabled, allows the ExecutesScriptChunk() function to call NWScript NWNX functions.
export NWNX_CORE_ALLOW_NWNX_FUNCTIONS_IN_EXECUTE_SCRIPT_CHUNK=0
#
# The path of the /nwnx resource directory
# export NWNX_CORE_NWNX_RESOURCE_DIRECTORY_PATH="UserDirectory/nwnx"
#
# A path to a file with custom resource directory aliases
export NWNX_CORE_CUSTOM_RESMAN_DEFINITION=""
#
# Sets the resman priority of the UserDirectory/nwn folder
export NWNX_CORE_NWNX_RESOURCE_DIRECTORY_PRIORITY=70000000
#
# Set whether to show timestamp in logs printed by NWNX.
export NWNX_CORE_LOG_TIMESTAMP=1
#
# Set whether to show date(Y-M-D) in logs printed by NWNX. Timestamps must be enabled.
export NWNX_CORE_LOG_DATE=0
#
# Set whether to show plugin name in logs printed by NWNX.
export NWNX_CORE_LOG_PLUGIN=1
#
# Set whether to show source code location in logs printed by NWNX.
export NWNX_CORE_LOG_SOURCE=1
#
# Set whether to show logs printed by NWNX in color (only when printing to a TTY).
export NWNX_CORE_LOG_COLOR=1
#
# Set whether to force color output
export NWNX_CORE_LOG_FORCE_COLOR=0
#
# Sets the secondary (in addition to stdout) log file.
export NWNX_CORE_LOG_FILE_PATH=""
#
# If set, NWNX will hard kill the process after it unloads.
export NWNC_CORE_HARD_EXIT=0
#
# Sets whether to also call the base game handler in case of crash.
export NWNX_CORE_BASE_GAME_CRASH_HANDLER=0
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_CHAT
#
# Sets the nwscript that the plugin will look for
export NWNX_CHAT_CHAT_SCRIPT=""
# -----------------------------------------------------

# -----------------------------------------------------
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
# CScriptCompiler->SetOptimizationFlags()
export NWNX_COMPILER_OPTIMIZATION_FLAGS=0xFFFFFFFF

# -----------------------------------------------------
# NWNX_DIAGNOSTICS
#
# Catches a few classes of memory corruptions in NWN and NWNX:
# * Buffer overrun for heap buffers (writing outside of bounds of allocation)
# * Use after free
# * Double free
#
# Enabling the sanitizer will make it IMPOSSIBLE to cleanly shut down the server.
# When the plugins unload, the server WILL crash. This is an UNAVOIDABLE side effect.
#
# You must append ":/path/to/NWNX_Diagnostics.so" to your LD_PRELOAD like so:
# LD_PRELOAD=/path/to/NWNX_Core.so:/path/to/NWNX_Diagnostics.so
export NWNX_DIAGNOSTICS_MEMORY_SANITIZER=true
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_DOTNET
#
# https://github.com/nwnxee/unified/tree/master/Plugins/DotNET
#
# Full path to your assembly/dll (withouth extension)
export ASSEMBLY=""
#
# Full type name containing static entrypoint method
# (Default NWN.Internal)
export ENTRYPOINT="NWN.Internal"
#
# Name of entrypoint method to call. Method must be "static void" without any parameters
# (Default: Bootstrap)
export METHOD="Bootstrap"
#
# Path where to load libnethost.so from
export NETHOST_PATH=""
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_ELC
#
# Sets the nwscript that the plugin will look for
export NWNX_ELC_ELC_SCRIPT=""
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
# If enabled, check when a character's first level class is a spellcaster, if their primary casting stat
# is >= 11.
export NWNX_ELC_ENFORCE_CASTER_PRIMARY_STAT_IS_11=false
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_EXPERIMENTAL
#
# Must have 'NWNX_CORE_LOAD_EXPERIMENTAL_PLUGIN' enabled
#
# Suppresses the playerlist and player login/logout messages for all players except DMs.
# This functionality is NOT compatible with NWNX_Rename.
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
#
# Combat rounds end immediately after spell cast, making it possible to cast another spell right after
export NWNX_EXPERIMENTAL_END_COMBATROUND_AFTER_SPELLCAST=false
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_FEAT
#
# Shows the effect's icon (the red and green squares)
export NWNX_FEAT_SHOW_EFFECT_ICON=false
#
# A custom spell id given to all effects created by this plugin.
#export NWNX_FEAT_CUSTOM_SPELL_ID=
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_HTTPCLIENT
#
# HTTP requrest timeout (in milliseconds)
export NWNX_HTTPCLIENT_REQUEST_TIMEOUT=2000
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_LUA
#
# export PRELOAD_SCRIPT="USERDIR/lua/preload.lua"
# export TOKEN_FUNCTION="CallToken"
# export EVENT_FUNCTION="RunEvent"
# export OBJSELF_FUNCTION=""
# export RUNSCRIPT_TRABLE=""
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_MAXLEVEL
#
# https://github.com/nwnxee/unified/tree/master/Plugins/MaxLevel
#
# Must have 'NWNX_ELC' loaded
#
# Sets the max level 41-60
# * Spellcasters can't change spells when levelling up after level 40
# * "Next Level XP" on "Character Sheet" shows an incorrect value.
# Must change your "-maxlevel" argument in your server start up as well
# Must change your "MaxCharLevel" defined in your "nwnplayer.ini" as well
# You may ignore "Server: Invalid argument to -maxlevel" message
# You must change your "exptable.2da" as well
export NWNX_MAXLEVEL_MAX=40
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_METRICS
#
export NWNX_METRICS_INFLUXDB_HOST=localhost
export NWNX_METRICS_INFLUXDB_PORT=8089
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_NWSQLITEEXTENSIONS
#
# https://github.com/nwnxee/unified/tree/master/Plugins/NWSQLiteExtensions
#
# Allows SqlPrepareQueryObject() to work on all object types except areas.
export NWNX_NWSQLITEEXTENSIONS_ENABLE_DATABASE_ON_ALL_OBJECT_TYPES=false
#
# Enables Mersenne Twister SQLite functions. Useful for seeded RNG.
export NWNX_NWSQLITEEXTENSIONS_ENABLE_MERSENNE_TWISTER_FUNCTIONS=false
#
# Enable the 2DA Virtual Table Module. Read-only tables that allows to query 2DA data.
export NWNX_NWSQLITEEXTENSIONS_ENABLE_2DA_VIRTUAL_TABLE_MODULE=false
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_NOSTACK
#
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
export NWNX_NOSTACK_SPELL_DEFAULT_TYPE=0
#
# Assigns all items effects to desired type
export NWNX_NOSTACK_ITEM_DEFAULT_TYPE=0
#
# Controls whether penalties should stack or not
export NWNX_NOSTACK_ALWAYS_STACK_PENALTIES=false
#
# Controls whether separate "OBJECT_INVALID" effects should stack or not
export NWNX_NOSTACK_SEPARATE_INVALID_OID_EFFECTS=false
#
## Ignore innate supernatural effects
export NWNX_NOSTACK_IGNORE_SUPERNATURAL_INNATE=false
# -----------------------------------------------------

# -----------------------------------------------------
# InfluxDB
#
# Database that will be created along with the container setup
export INFLUXDB_DB=metrics
#
# Credentials for your admin user. Don't give these away!
export INFLUXDB_ADMIN_USER=$INFLUXDBADMINUSER
export INFLUXDB_ADMIN_PASSWORD=$INFLUXDBADMINPASSWORD
#
# Credentials for using for your reporting user (Grafana, etc.)
export INFLUXDB_USER=$INFLUXDBUSER
export INFLUXDB_USER_PASSWORD=$INFLUXDBUSERPASSWORD
#
# This will enable the InfluxDb UDP binding on the NWNX Metrics Plugin default port
export INFLUXDB_UDP_ENABLED=true
export INFLUXDB_UDP_BIND_ADDRESS=:8089
export INFLUXDB_UDP_DATABASE=metrics
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_OPTIMIZATIONS
#
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
#
# Caches all scripts, improving performance
export NWNX_OPTIMIZATIONS_CACHE_SCRIPTS=true
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_PROFILER
#
export NWNX_PROFILER_ENABLE_OVERHEAD_COMPENSATION=true
export NWNX_PROFILER_OVERHEAD_COMPENSATION_FORCE=0
export NWNX_PROFILER_OVERHEAD_COMPENSATION_RUNS=500
export NWNX_PROFILER_OVERHEAD_COMPENSATION_RECALIBRATE=false
export NWNX_PROFILER_OVERHEAD_COMPENSATION_RECALIBRATION_PERIOD=1000
export NWNX_PROFILER_ENABLE_AI_MASTER_UPDATES=true
export NWNX_PROFILER_AI_MASTER_UPDATES_OVERKILL=false
export NWNX_PROFILER_ENABLE_MAIN_LOOP=true
export NWNX_PROFILER_ENABLE_NET_LAYER=true
export NWNX_PROFILER_ENABLE_NET_MESSAGES=true
export NWNX_PROFILER_ENABLE_OBJECT_AI_UPDATES=false
export NWNX_PROFILER_ENABLE_OBJECT_EVENT_HANDLERS=false
export NWNX_PROFILER_ENABLE_PATHING=true
export NWNX_PROFILER_ENABLE_SCRIPTS=true
export NWNX_PROFILER_SCRIPTS_AREA_TIMINGS=true
export NWNX_PROFILER_SCRIPTS_TYPE_TIMINGS=true
export NWNX_PROFILER_ENABLE_TICKRATE=true
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_RACE
# Shows the effect's icon (the red and green squares)
export NWNX_RACE_SHOW_EFFECT_ICON=false
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_REDIS
#
# Address to use
export NWNX_REDIS_HOST="localhost"
#
# Port to use
export NWNX_REDIS_PORT=6379
#
# NWScript NWNX_REDIS will subcribe to
export NWNX_REDIS_PUBSUB_SCRIPT=$REDISPUBSUBSCRIPT
#
# Channels it'll listen to
export NWNX_REDIS_PUBSUB_CHANNELS=$REDISPUBSUBCHANNELS
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_RENAME
#
# This is the listing of players from the character selection screen before entering the server.
# Setting the value to true overrides their names if a global rename has been set.
export NWNX_RENAME_ON_MODULE_CHAR_LIST=false
#
# Renames the player name on the player list as well.
export NWNX_RENAME_ON_PLAYER_LIST=true
#
# DM observers will see global or personal overrides as well as being able to have their own name
# overridden for other observers.
export NWNX_RENAME_ALLOW_DM=false
#
# When using NWNX_Rename_SetPCNameOverride with NWNX_RENAME_PLAYERNAME_ANONYMOUS this is the string
# used for the <PlayerName>
export NWNX_RENAME_ANONYMOUS_NAME="Someone"
#
# When set to true, global overrides change the display name globally - scripts and DMs included.
# When set to false, then name is only changed for players.
# Scripts and DMs see the original names (unless NWNX_RENAME_ALLOW_DM is set).
export NWNX_RENAME_OVERWRITE_DISPLAY_NAME=false
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_RESOURCES
#
# Causes the server to synchronise to a standard nwsync repository, and load the referenced content.
export NWNX_RESOURCES_USE_NWSYNC=false
#
# Clears or replaces the hak list defined in module properties.
export NWNX_RESOURCES_USE_CUSTOM_HAK_LIST=false
#
# Clears or replaces the tlk file defined in module properties. Supports tlk files included in nwsync.
export NWNX_RESOURCES_USE_CUSTOM_TLK=false
#
# Sets the timeout grace period for the thread watchdog. Only increase this if you are experiencing
# issues with the server exiting too quickly during resource loading.
export NWNX_RESOURCES_THREADWATCHDOG_GRACE=2
#
# NWNX_RESOURCES_USE_NWSYNC MUST BE TRUE. The root URL containing the NWSync repository.
export NWNX_RESOURCES_NWSYNC_HOST=""
#
# NWNX_RESOURCES_USE_NWSYNC MUST BE TRUE. The manifest hash to load. Does not support "latest"
export NWNX_RESOURCES_NWSYNC_MANIFEST=""
#
# NWNX_RESOURCES_USE_CUSTOM_HAK_LIST MUST BE TRUE. A comma (,) separated list of hak files to load.
# Replaces the list defined in the module properties.
# If left empty, this will cause the module to not load any hak files.
# Haks are prioritized in order - the first hak will override resources from the hak files after it,
# similar to the module hak list.
export NWNX_RESOURCES_CUSTOM_HAK_LIST=""
#
# NWNX_RESOURCES_USE_CUSTOM_TLK MUST BE TRUE. A custom tlk file/resource (without extension) to load.
# Replaces the custom tlk defined in the module properties.
# If left empty, this will cause the module to not load any custom tlk file.
export NWNX_RESOURCES_CUSTOM_TLK=""
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_RUBY
#
export EVALUATE_METRICS=false
export PRELOAD_SCRIPT=""
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_SQL
#
# Types are: MYSQL, POSTGRESQL, SQLITE
export NWNX_SQL_TYPE=$SQLTYPE
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
export NWNX_SQL_USERNAME=$SQLUSERNAME
#
# Password for the database connection.
# Not used if using SQLITE
export NWNX_SQL_PASSWORD=$SQLPASSWORD
#
# The database to connect to.
# The filename of the database when using SQLite, it is stored in the UserDirectory/database folder.
export NWNX_SQL_DATABASE=$SQLDATABASE
#
# Export query execution metrics.
# The Metrics_InfluxDB plugin and a visualizer like Grafana are required to view these metrics.
export NWNX_SQL_QUERY_METRICS=true
#
# Convert all strings going between the database and game to/from UTF8
# This takes into account the core locale as well.
export NWNX_SQL_USE_UTF8=true
#
# Set the connection's character set to be used.
# Only supported on mysql and pgsql. For sqlite this can be achieved with a query.
# For supported MYSQL character sets check: https://dev.mysql.com/doc/refman/8.0/en/charset-charsets.html
# For supported POSTGRESQL character sets check: https://www.postgresql.org/docs/current/multibyte.html
export NWNX_SQL_CHARACTER_SET=utf8
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_SERVERLOGREDIRECTOR
#
# When true, "*** ValidateGFFResource sent by user." messages are not written to the NWNX log
# export NWNX_SERVERLOGREDIRECTOR_HIDE_VALIDATEGFFRESOURCE_MESSAGES=false
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_SPELLCHECKER
#
# Path to the aff file
#export NWNX_SPELL_PATH_AFF=/usr/share/hunspell/en_US.aff
#
# Path to the dic file
#export NWNX_SPELL_PATH_DIC=/usr/share/hunspell/en_US.dic
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_THREADWATCHDOG
#
# Set the period at which the watchdog fires, in seconds
export NWNX_THREADWATCHDOG_PERIOD=15
#
# Number of successive long stall detections needed to kill the server
export NWNX_THREADWATCHDOG_KILL_THRESHOLD=5
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_TRACKING
#
# Enable targeting object to track
export ENABLE_ACTIVITY_TARGET=true
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_TWEAKS
#
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
# Removes the limit of number of parried attacks per round
export NWNX_TWEAKS_PARRY_ALL_ATTACKS=false
#
# Allow Sneak Attacks on creatures that are immune to Critical Hits
export NWNX_TWEAKS_SNEAK_ATTACK_IGNORE_CRIT_IMMUNITY=false
#
# Items are not destroyed when they reach 0 charges
export NWNX_TWEAKS_PRESERVE_DEPLETED_ITEMS=false
#
# 1: DMs are hidden on the module's Character List
# 2: PCs are hidden on the module's Character List
# 3: Both PCs and DMs are hidden on the module's Character list.
export NWNX_TWEAKS_HIDE_PLAYERS_ON_CHAR_LIST=1
#
# Disable monk abilities when polymorphed
export NWNX_TWEAKS_DISABLE_MONK_ABILITIES_WHEN_POLYMORPHED=false
#
# Changes the base of the StringToInt() nwscript function from base10 to automatic.
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
# 1 = Same price at 50 charges. Charges over 50 won't affect item's cost.
# 2 = Increase price after 50 charges, doubling at 250 charges
# 3 = Increase price after 50 charges, 5 times at 250 charges
export NWNX_TWEAKS_ITEM_CHARGES_COST_MODE=1
#
# Fixes dispel checks vs. effect created by deleted objects
export NWNX_TWEAKS_FIX_DISPEL_EFFECT_LEVELS=true
#
# Prestige Classes counts as caster levels
export NWNX_TWEAKS_ADD_PRESTIGECLASS_CASTER_LEVELS=false
#
# Fix Unlimited Potions Bug
export NWNX_TWEAKS_FIX_UNLIMITED_POTIONS_BUG=true
#
# Unhardcode Shields
# baseitems.2da will be used to define shield AC for shields and shield-like items.
export NWNX_TWEAKS_UNHARDCODE_SHIELDS=false
#
# Disables the "dm_spawnitem" console command
export NWNX_TWEAKS_BLOCK_DM_SPAWNITEM=false
#
# Allows armor with a max DEX bonus of under 1.
export NWNX_TWEAKS_FIX_ARMOR_DEX_BONUS_UNDER_ONE=false
#
# Effects on logged out player characters will be removed when a caster rests.
export NWNX_TWEAKS_CLEAR_SPELL_EFFECTS_ON_TURDS=true
#
# Creatures will always have their full dex states, even when immobilized/entangled.
export NWNX_TWEAKS_ALWAYS_RETURN_FULL_DEX_STAT=false
#
# The number of attacks per round overridden by SetBaseAttackBonus() will show on the character sheet.
export NWNX_TWEAKS_DISPLAY_NUM_ATTACKS_OVERRIDE_IN_CHARACTER_SHEET=false
#
# TURDs are associated by CDKey/CharacterName instead of PlayerName/CharacterName. Pass the CDKey instead
# of PlayerName when calling NWNX_Administration_DeleteTURD()
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
# export NWNX_TWEAKS_LANGUAGE_OVERRIDE=
#
# TlkTable entries overridden by SetTlkOverride() will be sent before Character Generation.
export NWNX_TWEAKS_SEND_TLK_OVERRIDE_BEFORE_CHARGEN=true
#
# When splitting an item, local variables will be copied.
export NWNX_TWEAKS_RETAIN_LOCAL_VARIABLES_ON_ITEM_SPLIT=true
#
# Prevents attack bonus effects from bypassing damage reductions.
export NWNX_TWEAKS_PREVENT_ATTACK_BONUS_BYPASSING_REDUCTION=true
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
export NWNX_TWEAKS_UNCAP_DAMAGE_RESISTANCE_DAMAGE_FLAGS=false
#
# Makes all bows, crossbows, and slings use On Hit: Effect item properties (in addition to their
# ammunition).
export NWNX_TWEAKS_RANGED_WEAPONS_USE_ON_HIT_EFFECT_ITEM_PROPERTIES=false
#
# Makes all bows, crossbows, and slings use On Hit: Cast Spell item properties (in addition to their
# ammunition).
export NWNX_TWEAKS_RANGED_WEAPONS_USE_ON_HIT_CAST_SPELL_ITEM_PROPERTIES=false
#
# Casts all On Hit: Cast Spell item properties on hit, instead of only the first property.
export NWNX_TWEAKS_CAST_ALL_ON_HIT_CAST_SPELL_ITEM_PROPERTIES=false
#
# If enabled, a creature getting added to an area will fire the NWNX_ON_MATERIALCHANGE_* and
# NWNX_ON_CREATURE_TILE_CHANGE_* events.
export NWNX_TWEAKS_SETAREA_CALLS_SETPOSITION=false
#
# The module OnPlayerEquipItem and OnPlayerUnEquipItem events are fired for all creatures
export NWNX_TWEAKS_FIRE_EQUIP_EVENTS_FOR_ALL_CREATURES=false
#
# Fixes Unequip/Equip events being out of sync if an item is equipped/unequipped multiple times per
# server tick
export NWNX_TWEAKS_DONT_DELAY_EQUIP_EVENT=true
#
# SetCutsceneMode() will not cause a TURD to be dropped.
export NWNX_TWEAKS_CUTSCENE_MODE_NO_TURD=true
#
# Allow all items to be used while polymorphed.
export NWNX_TWEAKS_CAN_USE_ITEMS_WHILE_POLYMORPHED=false
#
# Resist Energy feats stack with Epic Energy Resistance.
export NWNX_TWEAKS_RESIST_ENERGY_STACKS_WITH_EPIC_ENERGY_RESISTANCE=false
#
# Allows special abilities to be used on target types other than creatures.
export NWNX_TWEAKS_UNHARDCODE_SPECIAL_ABILITY_TARGET_TYPE=false
# -----------------------------------------------------

# -----------------------------------------------------
# NWNX_UTIL
#
# Allows you to set a NWScript that runs before the OnModuleLoad event
export NWNX_UTIL_PRE_MODULE_START_SCRIPT=""
#
# Allows you to set a NWScript Chunk that runs before the OnModuleLoad event
export NWNX_UTIL_PRE_MODULE_START_SCRIPT_CHUNK=""
# -----------------------------------------------------

#######################################################
# CONFIGURE PLUGINS END
#######################################################

status=$(./mod-status.sh)
if [ "$status" -eq "1" ]; then
  echo "$MODNAME is already running"
  exit
fi

if [ -f ~/.mod-maintenance ]; then
  echo "$MODNAME maintenance in progress (.mod-maintenance file exists), not starting"
  exit
fi

# Make a backup of all characters each time the server restarts
./mod-savechars.sh

pushd ~/nwn/bin/linux-x86

echo "Starting $MODNAME. Log is $LOGFILE"

# Set game options below

export NWNX_CORE_LOAD_PATH=~/nwnx/Binaries
LD_PRELOAD=~/nwnx/Binaries/NWNX_Core.so:~/nwnx/Binaries/NWNX_Diagnostics.so \
  ./nwserver-linux \
  -module "$MODNAME" \
  -maxclients "$MAXCLIENTS" \
  -minlevel "$MINLEVEL" \
  -maxlevel "$MAXLEVEL" \
  -pauseandplay "$PAUSEANDPLAY" \
  -pvp "$PVP" \
  -servervault "$SERVERVAULT" \
  -elc "$ELC" \
  -ilr "$ILR" \
  -gametype "$GAMETYPE" \
  -oneparty "$ONEPARTY" \
  -difficulty "$DIFFICULTY" \
  -autosaveinterval "$AUTOSAVEINTERVAL" \
  -playerpassword "$PLAYERPASSWORD" \
  -dmpassword "$DMPASSWORD" \
  -adminpassword "$ADMINPASSWORD" \
  -servername "$SERVERNAME" \
  -publicserver "$PUBLICSERVER" \
  -reloadwhenempty "$RELOADWHENEMPTY" \
  -port "$PORT" \
  -nwsyncurl "$NWSYNCURL" \
  "$@" >>"$LOGFILE" 2>&1 &

echo $! >~/.modpid
popd
