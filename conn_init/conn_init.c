
/*
 * Copyright (C) 2017 arttttt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <stdlib.h>
#include <string.h>
#include <cutils/log.h>
#include <cutils/properties.h>
#include <errno.h>

#define TAG "conn_init"
#define MAC_PARTION "/dev/block/platform/700b0600.sdhci/by-name/BKB"
#define MAC_PARTION_OLD "/dev/block/platform/sdhci-tegra.3/by-name/BKB"
#define PROPERTY_BT_BDADDR_PATH "ro.bt.bdaddr_path"
#define PERSIST_BDADDR_PROPERTY "persist.service.bdroid.bdaddr"
#define FACTORY_BT_ADDR_PROPERTY "ro.boot.btmacaddr"
#define WIFI_MAC_PROP "/sys/module/bcmdhd/parameters/mac"
#define BT_MAC_FILE "/data/misc/bluetooth/bt_mac.conf"

int isValidMacAddress(const char* mac) {
	int i = 0;
	int s = 0;
	int cnt = 0;

	while (*mac) {
		if (isxdigit(*mac)) {
			if (i == 0) {
				cnt++;
			}
			i++;
			if (i > 2) {
				return 0;
			}
		} else if (*mac == ':') {
			if (i == 0) {
				return 0;
			}
			++s;
			i = 0;
		}
		else {
			return 0;
		}
		++mac;
	}
	if (s != 5 || cnt != 6)
		return 0;
	return 1;
}

void set_bt_mac(FILE *fp) {
	char buf[30];
	FILE *bmfp;
	char addr[18];

/*
in /system/bt/btif/btif_core.c, btif_fetch_local_bdaddr() load BT addrees:
1. load it from file in PROPERTY_BT_BDADDR_PATH
2. load it from /data/misc/bluedroid/bt_config.conf or bt_config.xml, section "Adapter", setting "Address"
3. load it from PERSIST_BDADDR_PROPERTY
4. load it from FACTORY_BT_ADDR_PROPERTY
5. load it from ro.boot.btmacaddr

so we should set PROPERTY_BT_BDADDR_PATH to correct file, and write bt mac to this file if it's not exist.
if this file exists, we assume already write it or user change it, just read it and if it's format correct, use it.
if not, write bt mac address to this file.
*/
	memset(addr, '\0', 18);
	bmfp = fopen(BT_MAC_FILE, "r");
	if (bmfp != NULL) {
		fseek(bmfp, 0, SEEK_SET);
		fread(addr, sizeof(char), 17, bmfp);
		fclose(bmfp);
		if (isValidMacAddress(addr)) {
			property_set(PROPERTY_BT_BDADDR_PATH, BT_MAC_FILE);
			property_set(PERSIST_BDADDR_PROPERTY, addr);
			property_set(FACTORY_BT_ADDR_PROPERTY, addr);
			return;
		}
	}
	// not exist or wrong format
	fseek(fp, 0, SEEK_SET);
	fread(buf, sizeof(char), 22, fp);
	sprintf(addr, "%02x:%02x:%02x:%02x:%02x:%02x",
		(unsigned char)buf[14],
		(unsigned char)buf[13],
		(unsigned char)buf[12],
		(unsigned char)buf[11],
		(unsigned char)buf[10],
		(unsigned char)buf[9]);

	bmfp = fopen(BT_MAC_FILE, "w");
	if (bmfp == NULL) {
		property_set(PERSIST_BDADDR_PROPERTY, addr);
		property_set(FACTORY_BT_ADDR_PROPERTY, addr);
		ALOGE("%s: Can't open %s error: %d", TAG, BT_MAC_FILE, errno);
		return;
	}
	fprintf(bmfp, "%s\n", addr);
	fclose(bmfp);
	property_set(PROPERTY_BT_BDADDR_PATH, BT_MAC_FILE);
	property_set(PERSIST_BDADDR_PROPERTY, addr);
	property_set(FACTORY_BT_ADDR_PROPERTY, addr);
}

void set_wifi_mac(FILE *fp)
{
	char buf[30];

	fseek(fp, sizeof(char) * 22, SEEK_SET);
	fread(buf, sizeof(char), 22, fp);

	snprintf(buf, 30, "0x%x,0x%x,0x%x,0x%x,0x%x,0x%x\n",
		(unsigned char)buf[14],
		(unsigned char)buf[13],
		(unsigned char)buf[12],
		(unsigned char)buf[11],
		(unsigned char)buf[10],
		(unsigned char)buf[9]);

	FILE *wfp = fopen(WIFI_MAC_PROP, "w");
	if (wfp == NULL) {
		ALOGE("%s: Can't open %s error: %d", TAG, WIFI_MAC_PROP, errno);
		return;
	}
	fwrite(buf, sizeof(unsigned char), 30, wfp);
	fclose(wfp);
}

int main(void)
{
	FILE *fp;
	fp = fopen(MAC_PARTION, "r");
	if (fp == NULL) {
		ALOGE("%s: Can't open %s error: %d", TAG, MAC_PARTION, errno);
		fp = fopen(MAC_PARTION_OLD, "r");
		if (fp == NULL) {
			ALOGE("%s: Can't open %s error: %d", TAG, MAC_PARTION_OLD, errno);
			return 0;
		}
	}
	set_wifi_mac(fp);
	set_bt_mac(fp);
	fclose(fp);

	return 0;
}
