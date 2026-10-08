//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"Mem:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},

	{"", "$HOME/nixos-config/scripts/sb-clock",					1,		0},
	{"", "$HOME/nixos-config/scripts/sb-battery",					15,		0},
	{"", "$HOME/nixos-config/scripts/sb-volume",					15,		0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
