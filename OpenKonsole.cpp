/* OpenKonsole
 *
 * Copyright (c) 2026 ablyss
 * See the The MIT License included in this folder *
 * Some AI was used to help make this possibe.
 *
 */
#include "OpenKonsole.h"
#include <Alert.h>
#include <Entry.h>
#include <Path.h>
#include <Roster.h>
#include <String.h>

extern "C" {

void
process_refs(entry_ref dir_ref, BMessage *msg, void *reserved)
{
	// 1. Convert the entry_ref to a usable string path
	BPath path(&dir_ref);
	if (path.InitCheck() != B_OK)
		return;

	// 2. Get a reference to the Konsole binary
	entry_ref konsoleRef;
	if (get_ref_for_path("/bin/konsole", &konsoleRef) != B_OK) {
		BAlert *alert = new BAlert("Error", "Could not find /bin/konsole", "OK");
		alert->Go();
		return;
	}

	// 3. Use the --workdir flag to force the starting directory
	// argv[0] = program name
	// argv[1] = the flag
	// argv[2] = the path to open in
	const char* args[] = { "/bin/konsole", "--workdir", path.Path(), NULL };

	// 4. Launch with argc set to 3
	status_t status = be_roster->Launch(&konsoleRef, 3, args);

	if (status != B_OK && status != B_ALREADY_RUNNING) {
		BString errorMsg("Failed to launch Konsole: ");
		errorMsg << strerror(status);
		BAlert *alert = new BAlert("Error", errorMsg.String(), "OK");
		alert->Go();
   	}
    }
}



