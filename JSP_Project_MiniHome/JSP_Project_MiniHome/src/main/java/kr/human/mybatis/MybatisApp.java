package kr.human.mybatis;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;


public class MybatisApp {
	// 1. 정적 멤버로 팩토리 변수 선언
	private static SqlSessionFactory sqlSessionFactory;
	
	// 2. 정적 변수를 초기화하는 정적초기화 블럭을 생성
	static {
		String resource = "mybatis-config.xml";
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 3. 외부에서 객체를 얻도록 public 메서드로 작성한다.
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
}
