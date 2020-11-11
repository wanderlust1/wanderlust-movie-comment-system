package service

import entity.Hero

/**
 * @author Wanderlust 2020.10.17
 */
interface HeroService {

    /**
     * 查询所有英雄数据
     * @return JSON格式的英雄列表数据
     */
    fun getAllHero(): List<Hero>

    /**
     * 查询含指定关键词的英雄数据
     * @param search 查询关键词
     * @return 符合搜索条件的JSON格式的英雄列表数据
     */
    fun getHero(search: String): List<Hero>

}