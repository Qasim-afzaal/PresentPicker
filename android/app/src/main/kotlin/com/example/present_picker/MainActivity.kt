package com.example.the_gift_guide

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    private var sharedData: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleDeepLink(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleDeepLink(intent)
    }

    override fun onResume() {
        super.onResume()
        handleSharedData()
    }

    private fun handleDeepLink(intent: Intent) {
        if (Intent.ACTION_VIEW == intent.action) {
            val uri: Uri? = intent.data
            sharedData = uri?.toString()
            handleSharedData()
        }
    }

    private fun handleSharedData() {
        sharedData?.let { data ->
            // Now you can send the sharedData to Flutter using a MethodChannel
            // or you can directly display it in your Flutter UI
            sharedData = null // Reset sharedData after handling
        }
    }
}
