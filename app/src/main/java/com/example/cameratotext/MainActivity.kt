package com.example.cameratotext

import android.Manifest
import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.content.pm.PackageManager
import android.graphics.*
import android.os.Bundle
import android.util.Log
import android.view.MotionEvent
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.camera.core.*
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.example.cameratotext.databinding.ActivityMainBinding
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.latin.TextRecognizerOptions
import com.google.mlkit.vision.text.Text
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private lateinit var cameraExecutor: ExecutorService
    private var imageCapture: ImageCapture? = null
    private var camera: Camera? = null
    private var lensFacing = CameraSelector.LENS_FACING_BACK
    
    private var recognizedText = ""
    private var textBlocks = mutableListOf<Text.TextBlock>()
    private var isSelectionMode = false
    private var selectedText = ""
    private var selectedElement: Text.Element? = null
    
    private val textRecognizer = TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS)
    
    companion object {
        private const val TAG = "CameraToText"
        private const val REQUEST_CODE_PERMISSIONS = 10
        private val REQUIRED_PERMISSIONS = arrayOf(Manifest.permission.CAMERA)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        if (allPermissionsGranted()) {
            startCamera()
        } else {
            ActivityCompat.requestPermissions(
                this, REQUIRED_PERMISSIONS, REQUEST_CODE_PERMISSIONS
            )
        }

        cameraExecutor = Executors.newSingleThreadExecutor()
        setupUI()
    }

    private fun setupUI() {
        binding.captureButton.setOnClickListener {
            takePhoto()
        }

        binding.selectButton.setOnClickListener {
            toggleSelectionMode()
        }

        binding.copyButton.setOnClickListener {
            copySelectedText()
        }

        binding.retakeButton.setOnClickListener {
            hideTextResult()
        }

        binding.overlayView.setOnTouchListener { _, event ->
            if (isSelectionMode && event.action == MotionEvent.ACTION_DOWN) {
                handleTextSelection(event.x, event.y)
                return@setOnTouchListener true
            }
            false
        }
    }

    private fun startCamera() {
        val cameraProviderFuture = ProcessCameraProvider.getInstance(this)

        cameraProviderFuture.addListener({
            val cameraProvider: ProcessCameraProvider = cameraProviderFuture.get()

            val preview = Preview.Builder()
                .build()
                .also {
                    it.setSurfaceProvider(binding.viewFinder.surfaceProvider)
                }

            imageCapture = ImageCapture.Builder()
                .setCaptureMode(ImageCapture.CAPTURE_MODE_MINIMIZE_LATENCY)
                .build()

            val cameraSelector = CameraSelector.DEFAULT_BACK_CAMERA

            try {
                cameraProvider.unbindAll()
                camera = cameraProvider.bindToLifecycle(
                    this, cameraSelector, preview, imageCapture
                )
            } catch (exc: Exception) {
                Log.e(TAG, "Use case binding failed", exc)
            }
        }, ContextCompat.getMainExecutor(this))
    }

    private fun takePhoto() {
        val imageCapture = imageCapture ?: return

        binding.progressBar.visibility = View.VISIBLE

        imageCapture.takePicture(
            ContextCompat.getMainExecutor(this),
            object : ImageCapture.OnImageCapturedCallback() {
                override fun onCaptureSuccess(image: ImageProxy) {
                    processImage(image)
                }

                override fun onError(exception: ImageCaptureException) {
                    Log.e(TAG, "Photo capture failed: ${exception.message}", exception)
                    binding.progressBar.visibility = View.GONE
                    Toast.makeText(this@MainActivity, "Photo capture failed", Toast.LENGTH_SHORT).show()
                }
            }
        )
    }

    private fun processImage(imageProxy: ImageProxy) {
        val mediaImage = imageProxy.image
        if (mediaImage != null) {
            val image = InputImage.fromMediaImage(mediaImage, imageProxy.imageInfo.rotationDegrees)
            
            textRecognizer.process(image)
                .addOnSuccessListener { visionText ->
                    recognizedText = visionText.text
                    textBlocks.clear()
                    textBlocks.addAll(visionText.textBlocks)
                    
                    runOnUiThread {
                        binding.progressBar.visibility = View.GONE
                        binding.overlayView.setTextBlocks(textBlocks)
                        showTextResult()
                    }
                }
                .addOnFailureListener { e ->
                    Log.e(TAG, "Text recognition failed", e)
                    runOnUiThread {
                        binding.progressBar.visibility = View.GONE
                        Toast.makeText(this@MainActivity, "Text recognition failed", Toast.LENGTH_SHORT).show()
                    }
                }
                .addOnCompleteListener {
                    imageProxy.close()
                }
        }
    }

    private fun showTextResult() {
        binding.recognizedTextView.text = recognizedText
        binding.textResultCard.visibility = View.VISIBLE
        binding.controlsLayout.visibility = View.GONE
    }

    private fun hideTextResult() {
        binding.textResultCard.visibility = View.GONE
        binding.controlsLayout.visibility = View.VISIBLE
        recognizedText = ""
        textBlocks.clear()
        selectedText = ""
        selectedElement = null
        isSelectionMode = false
        binding.overlayView.setSelectedElement(null)
    }

    private fun toggleSelectionMode() {
        isSelectionMode = !isSelectionMode
        if (isSelectionMode) {
            binding.selectButton.text = getString(R.string.clear_selection)
            Toast.makeText(this, "Tap on text to select", Toast.LENGTH_SHORT).show()
        } else {
            binding.selectButton.text = getString(R.string.select_text)
            selectedText = ""
            selectedElement = null
            binding.overlayView.setSelectedElement(null)
        }
    }

    private fun handleTextSelection(x: Float, y: Float) {
        for (block in textBlocks) {
            for (line in block.lines) {
                for (element in line.elements) {
                    val boundingBox = element.boundingBox
                    if (boundingBox != null && boundingBox.contains(x.toInt(), y.toInt())) {
                        selectedText = element.text
                        selectedElement = element
                        binding.overlayView.setSelectedElement(element)
                        Toast.makeText(this, "Selected: $selectedText", Toast.LENGTH_SHORT).show()
                        return
                    }
                }
            }
        }
    }

    private fun copySelectedText() {
        val textToCopy = if (selectedText.isNotEmpty()) selectedText else recognizedText
        if (textToCopy.isNotEmpty()) {
            val clipboard = getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
            val clip = ClipData.newPlainText("Copied Text", textToCopy)
            clipboard.setPrimaryClip(clip)
            Toast.makeText(this, getString(R.string.text_copied), Toast.LENGTH_SHORT).show()
        }
    }

    private fun allPermissionsGranted() = REQUIRED_PERMISSIONS.all {
        ContextCompat.checkSelfPermission(baseContext, it) == PackageManager.PERMISSION_GRANTED
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_CODE_PERMISSIONS) {
            if (allPermissionsGranted()) {
                startCamera()
            } else {
                Toast.makeText(this, getString(R.string.camera_permission_required), Toast.LENGTH_LONG).show()
                finish()
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        cameraExecutor.shutdown()
    }
} 