package kr.co.dw.repository.readcnt;

public interface ReadCntDAO {

	void insert(String ip, int bno);
	
	String read(String ip, int bno);

}
