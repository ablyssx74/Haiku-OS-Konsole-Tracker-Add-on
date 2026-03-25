/* OpenKonsole
 *
 * Copyright (c) 2026 ablyss
 * See the The MIT License included in this folder *
 * Some AI was used to help make this possibe.
 *
 */
#ifndef TRACKER_ADDON_H
#define TRACKER_ADDON_H

#include <Entry.h>
#include <Message.h>
#include <TrackerAddOn.h>

extern "C"
{
	void	process_refs(entry_ref dir_ref, BMessage *msg, void *data);
}

#endif
