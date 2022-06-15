package mytld.mycompany.myapp;

import java.sql.Connection;
import java.sql.SQLException;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
// import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)									// ** 폴더가 있을수도 있고 없을수도 있고
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"}) // 완결설정 어딨는지 알려주는 파일.
public class MybatisTest {	// connectpull 보다는 조금 어려운거.
								// 중요한거 /src가아님 !!! ! ! !! !  !  / 붙어있나봄 !!!!
	@Inject //@Autowired 둘중 하나만 사용하깅. 
	private SqlSessionFactory ssFactory;
	
	@Test 		//  junit 사용!
	public void testSSFactory() {
		System.out.println(ssFactory);
	}

	@Test
	public void testSession() {
		SqlSession sSession = null;
		
		try {
			sSession = ssFactory.openSession(); // session을 열어줌.
			System.out.println(sSession); // sSession을 사용할수 있게해줌.
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(sSession!=null) {
				sSession.close();
			}
		}
	}
}
