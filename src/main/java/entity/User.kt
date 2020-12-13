package entity

import com.google.gson.annotations.SerializedName

/**
 * 用户实体类
 * @author Wanderlust 2020.11.12
 */
data class User (

    @SerializedName("user_id")
    var userId: String = "",

    var password: String = "",

    @SerializedName("nick_name")
    var nickName: String = "",

    var header: String = ""

)