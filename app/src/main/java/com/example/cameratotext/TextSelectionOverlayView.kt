package com.example.cameratotext

import android.content.Context
import android.graphics.*
import android.util.AttributeSet
import android.view.View
import com.google.mlkit.vision.text.Text

class TextSelectionOverlayView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : View(context, attrs, defStyleAttr) {

    private val paint = Paint().apply {
        color = Color.parseColor("#4CAF50")
        style = Paint.Style.FILL
        alpha = 100
    }

    private val strokePaint = Paint().apply {
        color = Color.parseColor("#2196F3")
        style = Paint.Style.STROKE
        strokeWidth = 4f
    }

    private val textPaint = Paint().apply {
        color = Color.WHITE
        textSize = 16f
        isFakeBoldText = true
    }

    private var textBlocks = mutableListOf<Text.TextBlock>()
    private var selectedElement: Text.Element? = null
    private var selectedRect: Rect? = null

    fun setTextBlocks(blocks: List<Text.TextBlock>) {
        textBlocks.clear()
        textBlocks.addAll(blocks)
        invalidate()
    }

    fun setSelectedElement(element: Text.Element?) {
        selectedElement = element
        selectedRect = element?.boundingBox
        invalidate()
    }

    override fun onDraw(canvas: Canvas) {
        super.onDraw(canvas)

        // Draw bounding boxes for all text elements
        for (block in textBlocks) {
            for (line in block.lines) {
                for (element in line.elements) {
                    val boundingBox = element.boundingBox
                    if (boundingBox != null) {
                        // Draw selection highlight for selected element
                        if (element == selectedElement) {
                            canvas.drawRect(boundingBox, paint)
                            canvas.drawRect(boundingBox, strokePaint)
                        } else {
                            // Draw subtle outline for other elements
                            val outlinePaint = Paint().apply {
                                color = Color.parseColor("#80FFFFFF")
                                style = Paint.Style.STROKE
                                strokeWidth = 2f
                            }
                            canvas.drawRect(boundingBox, outlinePaint)
                        }
                    }
                }
            }
        }
    }
} 