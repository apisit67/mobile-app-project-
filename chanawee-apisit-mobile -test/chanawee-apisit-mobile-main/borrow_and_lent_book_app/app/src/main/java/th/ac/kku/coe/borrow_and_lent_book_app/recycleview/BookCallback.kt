package th.ac.kku.coe.borrow_and_lent_book_app.recycleview

import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView

interface BookCallback {
    fun onBookItemClick(
        pos: Int,
        imgContainer: ImageView?,
        imgBook: ImageView?,
        title: TextView?,
        authorName: TextView?,
        nbpages: TextView?,
        score: TextView?,
        ratingBar: RatingBar?
    )
}