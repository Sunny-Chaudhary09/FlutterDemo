package com.example.assignment2

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(){
    private val CHANNEL = "com.example.assignment2/navigation"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

      /*  MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->

            if (call.method == "openProfile") {
                // 2. Command received from Dart: launch the new Activity
                val intent = Intent(this, ProfileActivity::class.java)
                startActivity(intent)
                result.success(true)
            }


            else if (call.method == "calendar") {
                // 2. Command received from Dart: launch the new Activity
                val intent = Intent(this, CalendarActivity::class.java)
                startActivity(intent)
                result.success(true)
            }

            else {
                result.notImplemented()
            }
        }*/

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("native-view", NativeViewFactory(flutterEngine.dartExecutor.binaryMessenger))
    }

}
