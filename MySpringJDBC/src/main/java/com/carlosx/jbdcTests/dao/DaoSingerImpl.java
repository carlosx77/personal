package com.carlosx.jbdcTests.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanInitializationException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.carlosx.jbdcTests.dao.mapper.IConvertToObject;
import com.carlosx.jbdcTests.dao.mapper.SqlToObjectMapperAlbum;
import com.carlosx.jbdcTests.dao.mapper.SqlToObjectMapperSinger;
import com.carlosx.jbdcTests.dao.query.FindAllSingersUsingMappingSqlQuery;
import com.carlosx.jbdcTests.dao.query.FindByFirstNameUsingSqlQuery;
import com.carlosx.jbdcTests.dao.query.SingerInsert;
import com.carlosx.jbdcTests.dao.query.SingerUpdate;
import com.carlosx.jbdcTests.entities.Album;
import com.carlosx.jbdcTests.entities.Singer;


@Repository
public class DaoSingerImpl implements ISingerDao, InitializingBean {
	
	private static Logger logger = LoggerFactory.getLogger(DaoSingerImpl.class);
	
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;
	private NamedParameterJdbcTemplate namedTemplate;


	public NamedParameterJdbcTemplate getNamedTemplate() {
		return namedTemplate;
	}

	public void setNamedTemplate(NamedParameterJdbcTemplate namedTemplate) {
		this.namedTemplate = namedTemplate;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public DataSource getDataSource() {
		return dataSource;
	}

	@Resource (name = "dataSource")
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
		this.jdbcTemplate = new JdbcTemplate();
		jdbcTemplate.setDataSource(this.dataSource);
		this.namedTemplate = new NamedParameterJdbcTemplate(this.dataSource);
		
	}

	@Override
	public List<Singer> findAll() {
		System.out.println("findAll");
		return this.jdbcTemplate.query("Select * from singer", new SingerMapper());
	}

	@Override
	public List<Singer> findByFirstNameUsingMappingSqlQuery(String firstName) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("first_name", firstName);
		FindByFirstNameUsingSqlQuery finder = new FindByFirstNameUsingSqlQuery(this.dataSource);
		return finder.executeByNamedParam(paramMap);
	}

	@Override
	public String findById(Long id) {
		Object[] params = new Object[] {id};
		return this.jdbcTemplate.queryForObject("select first_name from singer where id = ?", params, String.class);
	}
	
	public String findByIdUsingNamedParameters(Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		return this.namedTemplate.queryForObject("select first_name from singer where id = :id", map, String.class);
	}

	@Override
	public void insert(Singer singer) {
		SingerInsert inserter = new SingerInsert(this.dataSource);
		Map<String, Object> params = SqlToObjectMapperSinger.mapToMapForInsert(singer);
		KeyHolder keyHolder = new GeneratedKeyHolder();
		inserter.updateByNamedParam(params, keyHolder);
		singer.setId(keyHolder.getKey().longValue());
		logger.info("Nuevo ID: " + singer.getId());
	}

	@Override
	public void update(Singer singertoUpdt) {
		SingerUpdate updater = new SingerUpdate(dataSource);
		Map<String, Object> params = SqlToObjectMapperSinger.mapToMap(singertoUpdt);
		updater.updateByNamedParam(params);
	}

	@Override
	public void delete(Long singerId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertWithAlbum(Singer singer) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		if (this.dataSource==null) {
			throw new BeanInitializationException("Null dataSource on SingerDaoImpl");
		}
		if (this.namedTemplate==null) {
			throw new BeanInitializationException("Null named template");
		}
		
		
	}
	
	private static final class SingerMapper implements RowMapper<Singer>  {

		@Override
		public Singer mapRow(ResultSet rs, int rowNum) throws SQLException {
			IConvertToObject mapper = new SqlToObjectMapperSinger();
			return (Singer) mapper.convertToObject(rs);
		}

		
	}
	
	private static final class SingerAlbumMapper implements ResultSetExtractor<List<Singer>> {

		@Override
		public List<Singer> extractData(ResultSet rs) throws SQLException, DataAccessException {
			Map<Long, Singer> map = new HashMap<Long, Singer>();
			Singer singer = null;
			Album album = null;
			Long singerId;
			SqlToObjectMapperSinger singerMapper = new SqlToObjectMapperSinger();
			SqlToObjectMapperAlbum albumMapper = new SqlToObjectMapperAlbum();
			
			while (rs.next()) {
				singerId = rs.getLong("id");
				if ( map.get(singerId) == null ) {
					singer = (Singer) singerMapper.convertToObject(rs);
					map.put(singerId, singer);
				} 
				album = (Album) albumMapper.convertToObject(rs);
				singer.addAlbum(album);
			}
			
			return new ArrayList<Singer>(map.values());
		}
		
	}

	@Override
	public List<Singer> findByIdWithAlbums(Long id) {
		String query = new String ("select s.id, s.first_name, s.last_name, s.birth_date, "
				+ "a.id as album_id, a.title, a.release_date "
				+ "from singer s, album a "
				+ "where a.singer_id = s.id and s.id = " + id);
		System.out.println(query);
		return this.jdbcTemplate.query(query, new SingerAlbumMapper());
	}

	@Override
	public List<Singer> findAllUsingMappingSqlQuery() {
		FindAllSingersUsingMappingSqlQuery sqlMap = new FindAllSingersUsingMappingSqlQuery(this.dataSource);
		return sqlMap.execute();
	}
}
