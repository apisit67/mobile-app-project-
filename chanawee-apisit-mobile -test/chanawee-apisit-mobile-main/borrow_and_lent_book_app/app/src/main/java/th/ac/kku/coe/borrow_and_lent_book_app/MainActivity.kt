package th.ac.kku.coe.borrow_and_lent_book_app

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityOptionsCompat
import androidx.core.util.Pair
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import th.ac.kku.coe.borrow_and_lent_book_app.model.Book
import th.ac.kku.coe.borrow_and_lent_book_app.recycleview.BookAdapter
import th.ac.kku.coe.borrow_and_lent_book_app.recycleview.BookCallback
import th.ac.kku.coe.borrow_and_lent_book_app.recycleview.CustomItemAnimator
import java.util.*

class MainActivity : AppCompatActivity(), BookCallback {
    private var rvBook: RecyclerView? = null
    private var bookAdapter: BookAdapter? = null
    private var mdata: MutableList<Book>? = null
    private var btnAddBook: Button? = null
    private var btnRemoveBook: Button? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initView()
        initmdataBook()
        setupBookAdapter()
    }

    private fun setupBookAdapter() {
        bookAdapter = BookAdapter(mdata!!, this)
        rvBook!!.adapter = bookAdapter
    }

    private fun initmdataBook() {
        mdata = ArrayList()
        (mdata as ArrayList<Book>).add(Book(R.drawable.book1))
        (mdata as ArrayList<Book>).add(Book(R.drawable.book2))
        (mdata as ArrayList<Book>).add(Book(R.drawable.book3))
        (mdata as ArrayList<Book>).add(Book(R.drawable.book4))
        (mdata as ArrayList<Book>).add(Book(R.drawable.book5))
        (mdata as ArrayList<Book>).add(Book(R.drawable.book6))
        (mdata as ArrayList<Book>).add(Book(R.drawable.book7))
        (mdata as ArrayList<Book>).add(Book(R.drawable.book8))
    }

    private fun initView() {
        btnAddBook = findViewById(R.id.btn_add)
        btnRemoveBook = findViewById(R.id.btn_remove)
        rvBook = findViewById(R.id.rv_book)
        rvBook?.setLayoutManager(LinearLayoutManager(this))
        rvBook?.setHasFixedSize(true)
        rvBook?.setItemAnimator(CustomItemAnimator())
        btnAddBook?.setOnClickListener(View.OnClickListener { addBook() })
        btnRemoveBook?.setOnClickListener(View.OnClickListener { removeBook() })
    }

    private fun removeBook() {
        mdata!!.removeAt(1)
        bookAdapter!!.notifyItemRemoved(1)
    }

    private fun addBook() {
        val book = Book(R.drawable.book8)
        mdata!!.add(1, book)
        bookAdapter!!.notifyItemInserted(1)
    }

    override fun onBookItemClick(
        pos: Int,
        imgContainer: ImageView?,
        imgBook: ImageView?,
        title: TextView?,
        authorName: TextView?,
        nbpages: TextView?,
        score: TextView?,
        ratingBar: RatingBar?
    ) {
        val intent = Intent(this, BookDetailsActivity::class.java)
        intent.putExtra("bookObject", mdata!![pos])
        val p1 = Pair.create(imgContainer as View, "containerTN")
        val p2 = Pair.create(imgContainer as View, "bookTN")
        val p3 = Pair.create(imgContainer as View, "booktitleTN")
        val p4 = Pair.create(imgContainer as View, "bookauthorTN")
        val p5 = Pair.create(imgContainer as View, "bookratingBarTN")
        val p6 = Pair.create(imgContainer as View, "bookscoreTN")
        val p7 = Pair.create(imgContainer as View, "bookpagesrevTN")
        val optionsCompat =
            ActivityOptionsCompat.makeSceneTransitionAnimation(this, p1, p2, p3, p4, p5, p6, p7)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
            startActivity(intent, optionsCompat.toBundle())
        } else startActivity(intent)
    }
}