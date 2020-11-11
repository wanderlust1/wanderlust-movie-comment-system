package dao

import entity.Hero

/**
 * @author Wanderlust 2020.10.17
 */
interface HeroDao {

    /**
     * 查询所有英雄数据
     * @return 包含英雄实体对象列表
     */
    fun queryAllHero(): List<Hero>

    /**
     * 查询指定英雄数据
     * @param search 查询关键词
     * @return 包含符合条件的英雄实体对象列表
     */
    fun queryHero(search: String): List<Hero>

    /**
     * 关闭SqlSession
     */
    fun closeSession()

}