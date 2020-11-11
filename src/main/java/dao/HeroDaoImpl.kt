package dao

import entity.Hero
import org.springframework.stereotype.Repository

/**
 * @author Wanderlust 2020.10.17
 */
@Repository("HeroDaoImpl")
class HeroDaoImpl: HeroDao, BaseDao() {

    override fun queryAllHero(): List<Hero> {
        openSession()
        val result = mutableListOf<Hero>()
        session?.selectList("dao.HeroDaoImpl.queryAllHero")?.apply {
            (this as List<Map<String, Any>?>).forEach {
                if (it != null) {
                    val hero = Hero()
                    hero.title = it["name"] as String?
                    hero.name = it["title"] as String?
                    hero.tags = it["roles"] as String?
                    hero.lines = it["position"] as String?
                    hero.alias = it["alias"] as String?
                    result.add(hero)
                }
            }
        }
        return result
    }

    override fun queryHero(search: String): List<Hero> {
        openSession()
        val result = mutableListOf<Hero>()
        session?.selectList("dao.HeroDaoImpl.queryHero", search)?.apply {
            (this as List<Map<String, Any>?>).forEach {
                if (it != null) {
                    val hero = Hero()
                    hero.title = it["name"] as String?
                    hero.name = it["title"] as String?
                    hero.tags = it["roles"] as String?
                    hero.lines = it["position"] as String?
                    hero.alias = it["alias"] as String?
                    result.add(hero)
                }
            }
        }
        return result
    }

}

