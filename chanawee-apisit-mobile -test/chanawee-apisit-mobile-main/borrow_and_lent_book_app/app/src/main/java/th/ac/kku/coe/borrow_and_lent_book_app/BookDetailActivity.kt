package th.ac.kku.coe.borrow_and_lent_book_app

import android.os.Bundle
import android.widget.ImageView
import android.widget.RatingBar
import androidx.appcompat.app.AppCompatActivity
import com.bumptech.glide.Glide
import th.ac.kku.coe.borrow_and_lent_book_app.model.Book

class BookDetailsActivity : AppCompatActivity() {
    var imgbook: ImageView? = null
    var ratingBar: RatingBar? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_book_details)
        imgbook = findViewById(R.id.item_book_img)
        ratingBar = findViewById(R.id.item_book_ratingBar)
        val item = intent.extras!!.getSerializable("bookObject") as Book?
        loadBookData(item)
    }

    private fun loadBookData(item: Book?) {
        Glide.with(this).load(item!!.drawableResource).into(imgbook!!)
    }
}