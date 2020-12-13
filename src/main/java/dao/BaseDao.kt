package dao

import org.apache.ibatis.exceptions.IbatisException
import org.apache.ibatis.io.Resources
import org.apache.ibatis.session.SqlSession
import org.apache.ibatis.session.SqlSessionFactoryBuilder
import java.lang.Exception

/**
 * 所有DAO层类的父类，包含增删查改的快捷方法，并保存factory和session对象。
 * @author Wanderlust 2020.10.17
 */
open class BaseDao {

    private val factory = SqlSessionFactoryBuilder().build(Resources.getResourceAsReader("mybatis.xml"))
    protected var session: SqlSession? = null

    /**
     * 打开对话。注意：每次请求数据库操作前必须调用。
     */
    fun openSession() {
        session = factory.openSession()
    }

    /**
     * 提交操作，并关闭对话。注意：每次请求数据库操作后必须调用。
     */
    fun commit() {
        session?.commit()
    }

    /**
     * 执行查询操作并返回指定实体类的数据列表。只有当mapper.xml中的resultType为特定实体类时才有效
     * @param mapperPath DAO中的mapper映射函数名（Reference）
     * @param params 传入参数
     * @return 指定实体类的数据列表
     */
    protected inline fun <reified T> query(mapperPath: String, params: Any? = null): List<T> {
        val result = mutableListOf<T>()
        try {
            openSession()
            session?.selectList(mapperPath, params)?.forEach {
                if (it is T) result.add(it)
            }
            commit()
        } catch (e: Exception) {
        } finally {
            try {
                session?.close()
            } catch (e: Exception) {
            }
        }
        return result
    }

    /**
     * 执行插入操作并返回结果。
     * @param mapperPath DAO中的mapper映射函数名（Reference）
     * @param params 传入参数
     * @return 1为操作成功，否则失败
     */
    protected fun insert(mapperPath: String, params: Any): Int {
        return try {
            openSession()
            val result = session?.insert(mapperPath, params)
            commit()
            result ?: -1
        } catch (e: Exception) {
            if (e is IbatisException) -2 else -1
        } finally {
            try {
                session?.close()
            } catch (e: Exception) {
            }
        }
    }

    /**
     * 执行更新操作并返回结果。
     * @param mapperPath DAO中的mapper映射函数名（Reference）
     * @param params 传入参数
     * @return 1为操作成功，否则失败
     */
    protected fun update(mapperPath: String, params: Any): Int {
        return try {
            openSession()
            val result = session?.update(mapperPath, params)
            commit()
            result ?: -1
        } catch (e: Exception) {
            -1
        } finally {
            try {
                session?.close()
            } catch (e: Exception) {
            }
        }
    }

    /**
     * 执行删除操作并返回结果。
     * @param mapperPath DAO中的mapper映射函数名（Reference）
     * @param params 传入参数
     * @return 1为操作成功，否则失败
     */
    protected fun delete(mapperPath: String, params: Any): Int {
        return try {
            openSession()
            val result = session?.delete(mapperPath, params)
            commit()
            result ?: -1
        } catch (e: Exception) {
            -1
        } finally {
            try {
                session?.close()
            } catch (e: Exception) {
            }
        }
    }

}