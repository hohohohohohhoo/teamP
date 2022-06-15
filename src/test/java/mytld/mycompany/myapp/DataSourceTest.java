package mytld.mycompany.myapp;

import java.sql.Connection;
import java.sql.SQLException;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
// import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)									// ** 폴더가 있을수도 있고 없을수도 있고
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"}) // 완결설정 어딨는지 알려주는 파일.
public class DataSourceTest {	// connectpull 보다는 조금 어려운거.
								// 중요한거 /src가아님 !!! ! ! !! !  !  / 붙어있나봄 !!!!
	@Inject //@Autowired 둘중 하나만 사용하깅. 
	private DataSource dataFactory;
	
	@Test
	public void testConnection() {
		Connection conn = null;
		try {
			conn = dataFactory.getConnection();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

}
