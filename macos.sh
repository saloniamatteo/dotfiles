#!/bin/bash
# MacOS ships with nasty stuff. Let's remove some of it.
# First things first: disable SIP (System Integrity Protection)
# 1. Turn off your Mac
# 2. Keep holding the power button until the recovery menu opens
# 3. Click Options > Continue
# 4. In the menu bar at the top select Utilities > Terminal
# 5. Launch these commands
# csrutil disable
# reboot

_usage() {
	printf "Usage: $0 [options]

Options:
-h,--help                      Print this help and exit
-r,--restore                   Restore recoverable services
-R,--remove                    Remove all services (default)
-s,--service <SERVICE>         Together with '-r' or '-R', restore or remove only service named SERVICE
-S,--systemservice <SERVICE>   Together with '-r' or '-R', restore or remove only a system service named SERVICE
"
}

# System daemons (need sudo launchctl disable system/<label>)
SERVICES_SYSTEM=(
	"com.apple.analyticsd" # Main Mac Analytics collector
	"com.apple.audioanalyticsd" # Audio usage telemetry
	"com.apple.cloudd" # iCloud/CloudKit sync (system copy, user copy already disabled)
	"com.apple.cloudtelemetryd" # iCloud/CloudKit telemetry
	"com.apple.dprivacyd" # Differential-privacy usage uploads (system copy)
	"com.apple.ecosystemanalyticsd" # Continuity usage telemetry
	"com.apple.libsqlite3.dbtelemetryd" # SQLite usage telemetry
	"com.apple.rtcreportingd" # FaceTime/call quality reporting
	"com.apple.triald.system" # Apple server-controlled experiments
	"com.apple.usbctelemetryd" # USB-C port/accessory telemetry
	"com.apple.wifianalyticsd" # Wi-Fi performance analytics
)

# Services that you 100% must remove (ads, tracking, etc.)
SERVICES_MUSTREMOVE=(
	# Ads/Engagement/Promotions
	"com.apple.amsengagementd"
	"com.apple.ap.promotedcontentd"

	# Analytics
	"com.apple.analyticsagent"
	"com.apple.feedbackd"
	"com.apple.geoanalyticsd"
	"com.apple.inputanalyticsd"

	# Media analysis
	"com.apple.mediaanalysisd"

	# Photo analysis
	"com.apple.photoanalysisd"

	# Telemetry
	"com.apple.DiagnosticsReporter"
	"com.apple.ap.adprivacyd"
	"com.apple.appleseed.seedusaged"
	"com.apple.betaenrollmentagent"
	"com.apple.diagnostics_agent"
	"com.apple.diagnosticspushd"
	"com.apple.enhancedloggingd"
	"com.apple.loginwindow.LWWeeklyMessageTracer"
	"com.apple.metrickitd"
	"com.apple.parsec-fbf"
	"com.apple.proactiveeventtrackerd"
	"com.apple.securityuploadd"
	"com.apple.symptomsd-diag.agent"
	"com.apple.triald"
)

# Services that you should remove (iCloud, Siri, etc.)
SERVICES_SHOULDREMOVE=(
	# iCloud
	"com.apple.bird"

	# Family sharing
	"com.apple.familycircled"

	# Recents
	"com.apple.recentsd"

	# Student/school
	"com.apple.studentd"

	# Other photo/video/media stuff
	"com.apple.CloudPhotosConfiguration"
	"com.apple.accessibility.mediaaccessibilityd"
	"com.apple.amp.mediasharingd"
	"com.apple.cloudphotod"
	"com.apple.imageplaygroundd"
	"com.apple.mediacontinuityd"
	"com.apple.mediaremoteagent"
	"com.apple.mediastream.mstreamd"
	"com.apple.photolibraryd" # Don't disable if you want to use the Photos app
	"com.apple.privatecloudcomputed"
	"com.apple.videosubscriptionsd"
	"com.apple.visualintelligenced"

	# Siri
	"com.apple.assistant_service"
	"com.apple.assistantd"
	# "com.apple.campo" # Don't disable if you use spotlight!
	"com.apple.corespeechd"
	"com.apple.Siri.agent"
	"com.apple.SiriTTSTrainingAgent"
	"com.apple.siri.context.service"
	# "com.apple.siriactionsd" # Don't disable if you have shortcuts configured
	"com.apple.siriinferenced"
	"com.apple.siriknowledged"
	"com.apple.sirittsd"

	# Apple Intelligence
	"com.apple.GenerativeFunctions.agentstored"
	"com.apple.assistant_cdmd"
	"com.apple.generativeexperiencesd"

	# iCloud
	"com.apple.AOSHeartbeat"
	"com.apple.iCloudHelper"
	"com.apple.icloudmailagent"
	"com.apple.iCloudNotificationAgent"
	"com.apple.iCloudUserNotificationsd"
	"com.apple.icloudwebd"
	"com.apple.cloudsettingssyncagent"
	"com.apple.ckdiscretionaryd"
	"com.apple.cksharingmanagementd"
	"com.apple.cmfsyncagent"
	"com.apple.protectedcloudstorage.protectedcloudkeysyncing"
	"com.apple.security.cloudkeychainproxy3"
	"com.apple.SafariBookmarksSyncAgent"
	"com.apple.syncdefaultsd"
	"com.apple.UserPictureSyncAgent"
	"com.apple.Maps.mapssyncd"
	"com.apple.CallHistorySyncHelper"
	"com.apple.biomesyncd"
	# "com.apple.AOSPushRelay" # Don't disable if you use Find My

	# Family / child accounts
	"com.apple.familynotificationd"
	"com.apple.askpermissiond"
	"com.apple.AskPermissionUI"
	"com.apple.parentalcontrols.check"

	# Game Center
	"com.apple.gamed"
	"com.apple.gamesaved"
	"com.apple.GameOverlayUI"
	# "com.apple.GamePolicyAgent" # Don't disable if you play games (Game Mode)

	# Home
	"com.apple.homed"
	"com.apple.homeenergyd"
	"com.apple.homeeventsd"

	# Music / TV
	"com.apple.itunescloudd"
	"com.apple.AMPArtworkAgent"
	"com.apple.watchlistd"
	"com.apple.tvremoted"

	# News / Books / Tips
	"com.apple.newsd"
	"com.apple.bookassetd"
	"com.apple.bookdatastored"
	"com.apple.tipsd"

	# Exchange
	"com.apple.exchange.exchangesyncd"
	"com.apple.notes.exchangenotesd"

	# Sidecar (iPad as 2nd display)
	"com.apple.sidecar-display-agent"
	"com.apple.sidecar-relay"

	# Misc
	"com.apple.translationd"
	"com.apple.voicebankingd"
	"com.apple.AssetCache.agent"
	"com.apple.AssetCacheLocatorService"

	# Apple Intelligence background
	"com.apple.intelligencetasksd"
	"com.apple.knowledgeconstructiond"
	"com.apple.ModelCatalogAgent"
	"com.apple.knowledge-agent" # Test last, may affect Screen Time stats
	# "com.apple.intelligenceflowd"     # Don't disable: Spotlight runs on it
	# "com.apple.intelligencecontextd"  # Don't disable: Spotlight runs on it
	# "com.apple.intelligenceplatformd" # Don't disable: Spotlight runs on it
)

# Helper function to remove (stop and disable) a system service
_remove_system_service() {
	local service="$1"
	sudo launchctl bootout system/$service
	sudo launchctl disable system/$service && echo "$service disabled" || echo "ERROR: disabling $service failed! (Maybe already disabled)"
	echo
}

# Helper function to remove (stop and disable) a service
_remove_service() {
	local service="$1"
	launchctl bootout gui/$UID/$service
	launchctl disable gui/$UID/$service && echo "$service disabled" || echo "ERROR: disabling $service failed! (Maybe already disabled)"
	echo
}

# Helper function to restore (enable and start) a system service
_restore_system_service() {
	local service="$1"
	sudo launchctl enable system/$service
	sudo launchctl bootstrap system /System/Library/LaunchDaemons/$service.plist
	sudo launchctl kickstart -k system/$service && \
	echo "$service kickstarted" || echo "ERROR: could not kickstart $service! (Maybe already restored)"
}

# Helper function to restore (enable and start) a service
_restore_service() {
	local service="$1"
	launchctl enable gui/$UID/$service
	launchctl bootstrap gui/$UID /System/Library/LaunchAgents/$service.plist
	launchctl kickstart -k gui/$UID/$service && \
	echo "$service kickstarted" || echo "ERROR: could not kickstart $service! (Maybe already restored)"
}

# Default function
# Remove all services
_default() {
	echo "Services: System"
	echo "---------------------"

	for service in ${SERVICES_SYSTEM[@]}; do
		echo "Removing: $service"
		_remove_system_service $service
	done

	echo "Services: Must Remove"
	echo "---------------------"

	for service in ${SERVICES_MUSTREMOVE[@]}; do
		echo "Removing: $service"
		_remove_service $service
	done

	echo "Services: Should Remove"
	echo "---------------------"

	for service in ${SERVICES_SHOULDREMOVE[@]}; do
		echo "Removing: $service"
		_remove_service $service
	done
}

# Restore all "should remove" services
_restore() {
	echo "Restoring all Should Remove services"
	echo

	for service in ${SERVICES_SHOULDREMOVE[@]}; do
		echo "Restoring: $service"
		_restore_service $service
	done
}

# Parse options
# -o: short options
# -l: long options
# -n: program name
# -------------------
# Note that we use "$@" to let each command-line parameter expand to a
# separate word. The quotes around "$@" are essential!
# We need this as the 'eval set --' would nuke the return value of getopt.
OPTS=$(getopt \
	-o 'hrRs:S:' \
	-l 'help,restore,remove,service:systemservice:' \
	-- "$@"
)

# Get getopt's return code
if [ $? -ne 0 ]; then
	_usage >&2
	exit 1
fi

# If no parameters have been provided, run default function
if [[ "$OPTS" = " --" ]]; then
	_default
fi

# Reset the positional parameters to the parsed options
eval set -- "$OPTS"
unset OPTS

F_PRINT_HELP=0			# Print help and exit
F_REMOVE=0              # Remove all services
F_RESTORE=0				# Restore recoverable services
F_SERVICE=""            # Service to restore or remove
F_SYSTEMSERVICE=""      # System service to restore or remove

# Process options
while true; do
	case "$1" in
		'-h' | '--help')
			F_PRINT_HELP=1
			shift
			continue
			;;
		'-r' | '--restore')
			F_RESTORE=1
			shift
			continue
			;;
		'-R' | '--remove')
			F_REMOVE=1
			shift
			continue
			;;
		'-s' | '--service')
			F_SERVICE="$2"
			shift 2
			continue
			;;
		'-S' | '--systemservice')
			F_SYSTEMSERVICE="$2"
			shift 2
			continue
			;;
		'--')
			shift
			break
			;;
		*)
			echo "Internal error!" >&2
			exit 1
			;;
	esac
done

# Print help
if [ $F_PRINT_HELP = 1 ]; then
	_usage
	exit
fi

# Check only service or system service is defined
if [[ -n "$F_SERVICE" && -n "$F_SYSTEMSERVICE" ]]; then
	echo "Error: select only service (-s) or system service (-S)!"
	_usage
	exit
fi

# System service is selected
if [ -n "$F_SYSTEMSERVICE" ]; then
	# If both restore and remove have been selected, error out
	if [[ $F_RESTORE = 1 && $F_REMOVE = 1 ]]; then
		echo "Error: select only one restore (-r) or remove (-R)!"
		_usage
		exit

	# Restore
	else if [ $F_RESTORE = 1 ]; then
		echo "Restoring: $F_SYSTEMSERVICE"
		_restore_system_service "$F_SYSTEMSERVICE"
		exit

	# Remove
	else if [ $F_REMOVE = 1 ]; then
		echo "Removing: $F_SYSTEMSERVICE"
		_remove_system_service "$F_SYSTEMSERVICE"
		exit

	else
		_usage
		exit
	fi
fi
fi
fi

# Service is selected
if [ -n "$F_SERVICE" ]; then
	# If both restore and remove have been selected, error out
	if [[ $F_RESTORE = 1 && $F_REMOVE = 1 ]]; then
		echo "Error: select only one restore (-r) or remove (-R)!"
		_usage
		exit

	# Restore
	else if [ $F_RESTORE = 1 ]; then
		echo "Restoring: $F_SERVICE"
		_restore_service "$F_SERVICE"
		exit

	# Remove
	else if [ $F_REMOVE = 1 ]; then
		echo "Removing: $F_SERVICE"
		_remove_service "$F_SERVICE"
		exit

	else
		_usage
		exit
	fi
fi
fi
fi

# Restore services
if [ $F_RESTORE = 1 ]; then
	_restore
	exit
fi

# Remove services (default)
if [ $F_REMOVE = 1 ]; then
	_default
	exit
fi
