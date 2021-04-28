package th.ac.kku.coe.borrow_and_lent_book_app.model

import java.io.Serializable

class Book : Serializable {
    var title: String? = null
    var description: String? = null
    var author: String? = null
    var imgUrl: String? = null
    var pages = 0
    var review = 0
    var rating = 0f
    var drawableResource = 0

    constructor() {}
    constructor(drawableResource: Int) {
        this.drawableResource = drawableResource
    }

    constructor(
        title: String?,
        description: String?,
        author: String?,
        imgUrl: String?,
        pages: Int,
        review: Int,
        rating: Float,
        drawableResource: Int
    ) {
        this.title = title
        this.description = description
        this.author = author
        this.imgUrl = imgUrl
        this.pages = pages
        this.review = review
        this.rating = rating
        this.drawableResource = drawableResource
    }
}