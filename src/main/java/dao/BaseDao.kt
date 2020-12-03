package dao

import org.apache.ibatis.io.Resources
import org.apache.ibatis.session.SqlSession
import org.apache.ibatis.session.SqlSessionFactoryBuilder
import java.io.IOException

open class BaseDao {

    private val factory = SqlSessionFactoryBuilder().build(Resources.getResourceAsReader("mybatis.xml"))
    protected var session: SqlSession? = null

    fun openSession() {
        try {
            session = factory.openSession()
        } catch (e: IOException) {
            e.printStackTrace()
        }
    }

    fun commit() {
        try {
            session?.commit()
            session?.close()
        } catch (e: IOException) {
            e.printStackTrace()
        }
    }

    /**
     * 从mapper.xml中返回具有特定实体类的查询列表。只有当mapper中的resultType为特定实体类时才有效
     * @param mapperPath DAO中的mapper映射函数名（Reference）
     * @param param 传入参数
     * @return 具有特定实体类的查询列表
     */
    protected inline fun <reified T> query(mapperPath: String, params: Any? = null): List<T> {
        openSession()
        val result = mutableListOf<T>()
        session?.selectList(mapperPath, params)?.forEach {
            if (it is T) result.add(it)
        }
        return result
    }

    protected fun insert(mapperPath: String, params: Any): Int {
        openSession()
        val result = session?.insert(mapperPath, params)
        commit()
        return result ?: -1
    }

    protected fun update(mapperPath: String, params: Any): Int {
        openSession()
        val result = session?.update(mapperPath, params)
        commit()
        return result ?: -1
    }

    protected fun delete(mapperPath: String, params: Any): Int {
        openSession()
        val result = session?.delete(mapperPath, params)
        commit()
        return result ?: -1
    }

}