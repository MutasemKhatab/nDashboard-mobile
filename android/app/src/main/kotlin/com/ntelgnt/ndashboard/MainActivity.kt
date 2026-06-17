package com.ntelgnt.ndashboard

import android.content.ComponentName
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "icon_service")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "switchIcon" -> {
                        val alias = call.argument<String>("alias")!!
                        switchToAlias(alias)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun switchToAlias(target: String) {
        val all = listOf("MainActivityIconA", "MainActivityIconB")
        all.forEach { name ->
            val state = if (name == target)
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED
            else
                PackageManager.COMPONENT_ENABLED_STATE_DISABLED
            packageManager.setComponentEnabledSetting(
                ComponentName(this, "com.ntelgnt.ndashboard.$name"),
                state,
                PackageManager.DONT_KILL_APP
            )
        }
    }
}