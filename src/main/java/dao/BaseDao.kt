package dao

import org.apache.ibatis.io.Resources
import org.apache.ibatis.session.SqlSession
import org.apache.ibatis.session.SqlSessionFactoryBuilder
import java.io.IOException

open class BaseDao {

    private val factory = SqlSessionFactoryBuilder().build(Resources.getResourceAsReader("mybatis.xml"))
    protected var session: SqlSession? = null

    fun closeSession() {
        session?.close()
    }

    fun openSession() {
        try {
            session = factory.openSession()
        } catch (e: IOException) {
            e.printStackTrace()
        }
    }

}