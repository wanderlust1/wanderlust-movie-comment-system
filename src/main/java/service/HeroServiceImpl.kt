package service

import dao.HeroDao
import entity.Hero
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

/**
 * @author Wanderlust 2020.10.17
 */
@Service("HeroServiceImpl")
class HeroServiceImpl: HeroService {

    @Autowired
    lateinit var mHeroDao: HeroDao

    override fun getAllHero(): List<Hero> {
        return mHeroDao.queryAllHero()
    }

    override fun getHero(search: String): List<Hero> {
        return mHeroDao.queryHero(search)
    }

}