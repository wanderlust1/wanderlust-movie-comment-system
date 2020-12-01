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

    /**
     * 从mapper.xml中返回具有特定实体类的查询列表。只有当mapper中的resultType为特定实体类时才有效
     * @param mapperPath DAO中的mapper映射函数名（Reference）
     * @param param 传入参数
     * @return 具有特定实体类的查询列表
     */
    protected inline fun <reified T> getListByTemplatedMapper(mapperPath: String, param: String = ""): List<T> {
        openSession()
        val result = mutableListOf<T>()
        session?.selectList(mapperPath, param)?.forEach {
            if (it is T) result.add(it)
        }
        return result
    }

}