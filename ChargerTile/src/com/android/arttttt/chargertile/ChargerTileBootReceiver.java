/*
 * Copyright (C) 2018 arttttt <artem-bambalov@yandex.ru>
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
 
package com.android.arttttt.chargertile;

import com.android.arttttt.chargertile.Constants;
import com.android.arttttt.chargertile.utils.PreferencesUtils;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

//import org.cyanogenmod.internal.util.FileUtils;
import android.util.Log;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class ChargerTileBootReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        if (Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())) {
            int chargingDisabledByUser = PreferencesUtils
                                            .getInstance(context)
                                            .getInt(Constants.PREF_CHARGING_DISABLED_KEY);
            //FileUtils.writeLine(Constants.PROCFS_PROP_PATH, String.valueOf(chargingDisabledByUser));
            try {
                FileWriter writer = new FileWriter(Constants.PROCFS_PROP_PATH);
                writer.write(String.valueOf(chargingDisabledByUser));
                writer.flush();
                writer.close();
            } catch (Exception err) {
                Log.d("ChargeTile", "FiltWriter failed");
                err.printStackTrace();
            }
        }
    }
}
