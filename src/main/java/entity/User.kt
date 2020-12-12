package entity

import com.google.gson.annotations.SerializedName

data class User (

    @SerializedName("user_id")
    var userId: String = "",

    var password: String = "",

    @SerializedName("nick_name")
    var nickName: String = "",

    var header: String = ""

)