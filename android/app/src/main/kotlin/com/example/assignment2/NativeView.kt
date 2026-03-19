package com.example.assignment2

import android.annotation.SuppressLint
import android.content.Context
import android.view.LayoutInflater
import android.widget.Button
import android.widget.FrameLayout
import android.widget.TextView
import io.flutter.plugin.common.MethodChannel


@SuppressLint("ViewConstructor")
class NativeView(
    context: Context,
    viewId: Int,
    messenger: io.flutter.plugin.common.BinaryMessenger,
    creationParams: Any?
) : FrameLayout(context) {

    private val methodChannel = MethodChannel(messenger, "native_view_channel_$viewId")
    private val tvTitle: TextView
    private val tvMessage: TextView
    private val btnAction: Button

    init {
        LayoutInflater.from(context).inflate(R.layout.native_layout, this, true)
        tvTitle = findViewById(R.id.tvTitle)
        tvMessage = findViewById(R.id.tvMessage)
        btnAction = findViewById(R.id.btnAction)

        // If Flutter passed initial params, apply them:
        try {
            (creationParams as? Map<String, Any?>)?.let { params ->
                val title = params["title"] as? String
                val message = params["message"] as? String
                if (!title.isNullOrEmpty()) tvTitle.text = title
                if (!message.isNullOrEmpty()) tvMessage.text = message
            }
        } catch (e: Exception) {
            // ignore
        }

        // Handle calls from Flutter
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "setMessage" -> {
                    val text = call.argument<String>("text")
                    tvMessage.text = text ?: ""
                    result.success(true)
                }
                "setTitle" -> {
                    val text = call.argument<String>("text")
                    tvTitle.text = text ?: ""
                    result.success(true)
                }
                "getState" -> {
                    val map = mapOf("title" to tvTitle.text.toString(), "message" to tvMessage.text.toString())
                    result.success(map)
                }
                else -> result.notImplemented()
            }
        }

        // Example native -> Flutter event on button click:
        btnAction.setOnClickListener {
            val payload = mapOf("event" to "button_clicked", "viewId" to viewId)
            methodChannel.invokeMethod("onNativeEvent", payload)
        }
    }
}