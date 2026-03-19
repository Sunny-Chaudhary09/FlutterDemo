package com.example.assignment2

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.assignment2.R

class ProfileActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // This line links your Kotlin class to the XML layout file.
        // It assumes you have created activity_profile.xml in
        // android/app/src/main/res/layout/
        setContentView(R.layout.activity_profile)

        // You can add your Kotlin logic here, like finding views:
        // val usernameView = findViewById<TextView>(R.id.username_text)
        // usernameView.text = "Hello, Profile!"
    }
}