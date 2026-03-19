package com.example.assignment2

import android.content.Context
import android.view.View
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.StandardMessageCodec


// 1. View class: Wraps your XML layout
class CalendarView(context: Context, id: Int, creationParams: Map<String, Any>?) : PlatformView {
    private val view: View = View.inflate(context, R.layout.activity_calendar, null)

    // R.layout.activity_main refers to your XML file (which should be renamed to activity_main.xml)

    override fun getView(): View {
        // You would perform view setup and logic here, such as finding TextViews
        // and setting up the calendar's initial state.
        // val backButton = view.findViewById<TextView>(R.id.back_button)
        // backButton.text = "Custom Text"

        return view
    }

    override fun dispose() {
        // Cleanup resources if necessary
    }
}

// 2. Factory class: Tells Flutter how to create the View
class CalendarViewFactory(private val activity: FlutterActivity) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as? Map<String, Any>
        return CalendarView(context, viewId, creationParams)
    }
}