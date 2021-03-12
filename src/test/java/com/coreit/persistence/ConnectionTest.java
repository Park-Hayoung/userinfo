package com.coreit.persistence;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ConnectionTest {
	
	private static final Logger logger = LoggerFactory.getLogger(ConnectionTest.class);
	
	@Autowired
	private DataSource dataSource;
	
	@Test
	public void testConnection() {
		try {
			Connection conn = dataSource.getConnection();
			logger.info(conn.toString());
		} catch (Exception e) {
			logger.info("Connection Fail...");
		}
	}
}
