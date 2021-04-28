package th.ac.kku.coe.borrow_and_lent_book_app.recycleview

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import th.ac.kku.coe.borrow_and_lent_book_app.R
import th.ac.kku.coe.borrow_and_lent_book_app.model.Book
import th.ac.kku.coe.borrow_and_lent_book_app.recycleview.BookAdapter.bookviewholder

class BookAdapter(var mdata: List<Book>, var callback: BookCallback) :
    RecyclerView.Adapter<bookviewholder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): bookviewholder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_book, parent, false)
        return bookviewholder(view)
    }

    override fun onBindViewHolder(holder: bookviewholder, position: Int) {
        Glide.with(holder.itemView.context)
            .load(mdata[position].drawableResource)
            .transform(CenterCrop(), RoundedCorners(16))
            .into(holder.imageBook)
        holder.ratingBar.rating = 4.5.toFloat()
    }

    override fun getItemCount(): Int {
        return mdata.size
    }

    inner class bookviewholder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var imageBook: ImageView
        var imgFav: ImageView? = null
        var imageContainer: ImageView
        var title: TextView
        var description: TextView? = null
        var author: TextView
        var pages: TextView
        var rate: TextView
        var ratingBar: RatingBar

        init {
            imageBook = itemView.findViewById(R.id.item_book_img)
            imageContainer = itemView.findViewById(R.id.item_book_container)
            title = itemView.findViewById(R.id.item_book_title)
            author = itemView.findViewById(R.id.item_book_author)
            pages = itemView.findViewById(R.id.item_book_pagesrev)
            rate = itemView.findViewById(R.id.item_book_score)
            ratingBar = itemView.findViewById(R.id.item_book_ratingBar)
            itemView.setOnClickListener {
                callback.onBookItemClick(
                    adapterPosition,
                    imageContainer,
                    imageBook,
                    title,
                    author,
                    pages,
                    rate,
                    ratingBar
                )
            }
        }
    }
}