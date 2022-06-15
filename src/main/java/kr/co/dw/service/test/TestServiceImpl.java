package kr.co.dw.service.test;

import org.springframework.stereotype.Service;

@Service
public class TestServiceImpl implements TestService {

	@Override
	public void ba() {
		System.out.println("::::::::::::::::::::::::pointtcuts:::::::");

	}

	@Override
	public void ba(String msg) {
		System.out.println("::::::::::::::::::::::::pointtcuts:::::::");
		
		
	}

}
